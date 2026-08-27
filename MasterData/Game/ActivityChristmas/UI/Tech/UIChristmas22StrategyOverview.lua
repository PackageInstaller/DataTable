local UIChristmas22StrategyOverview = class("UIChristmas22StrategyOverview", UIBaseWindow)
local base = UIBaseWindow
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_Edge = CS.UnityEngine.RectTransform.Edge
local UINWATechLine = require("Game.ActivitySectorII.Tech.UI.UINWATechLine")
local UINCarnival22TechItemLocked = require("Game.ActivityCarnival.UI.CarnivalTech.UINCarnival22TechItemLocked")
local Top_INTERNIVAL = 30
local LEFT_INTERNIVAL = 30
local TECH_WIDTH_NOR = 199
local TECH_WIDTH_SPLIT = 209
local TECH_HEIGHT = 249
local TECH_LENGHT_SPLIT = 2
local LockedLineOffsetY = 20

function UIChristmas22StrategyOverview:__SetNodeClass()
  self._techItemClass = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechItem")
  self._techLvClass = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechLv")
  self._techTitleClass = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechTitle")
  self._specialListClass = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechSpecialList")
  self._specialSideClass = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechSpeicalSide")
  self._desType = eLogicDesType.Christmas
  self._lvNodeOffset = 0
  self._itemNoEnoughTip = 8714
  self._resetNoEnoughTip = 8713
end

function UIChristmas22StrategyOverview:OnInit()
  self:__SetNodeClass()
  UIUtil.SetTopStatus(self, self.CloseChristmas22StrategyOverview)
  self.resloader = cs_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickBg)
  UIUtil.AddButtonListener(self.ui.btn_rect, self, self.OnClickBg)
  self.__OnTechLvCallback = BindCallback(self, self.__OnTechLv)
  self.__OnTechResetCallback = BindCallback(self, self.__OnTechReset)
  self.__OnTechDetailCallback = BindCallback(self, self.__OnTechDetail)
  self.__OnClickLvCallbackCallback = BindCallback(self, self.OnClickLvCallback)
  self.__GetLockItemCallback = BindCallback(self, self.__GetLockItem)
  self.__RefreshWindowCallback = BindCallback(self, self.__RefreshWindow)
  self._itemPool = UIItemPool.New(self._techItemClass, self.ui.techItem)
  self._titlePool = UIItemPool.New(self._techTitleClass, self.ui.titleNode)
  self._linePool = UIItemPool.New(UINWATechLine, self.ui.obj_Line)
  self._lockPool = UIItemPool.New(UINCarnival22TechItemLocked, self.ui.obj_ItemLocked)
  self.ui.techItem:SetActive(false)
  self.ui.titleNode:SetActive(false)
  self.ui.obj_Line:SetActive(false)
  self._sideNode = self._specialSideClass.New()
  self._sideNode:Init(self.ui.side)
  self._sideNode:SetChristmas22LogicDesType(self._desType)
  self._sideNode:BindChrismas22TechSpeicalSide(self.__OnTechLvCallback, self.__OnTechResetCallback, self.__OnTechDetailCallback)
  self.ui.techInfoNode.gameObject:SetActive(false)
  self.__ItemUpdateCallback = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemUpdateCallback)
end

function UIChristmas22StrategyOverview:InitChristmas22StrategyOverview(actTechTree, specialBranchId, callback)
  self._data = actTechTree
  self._specialBranchId = specialBranchId
  self._callback = callback
  local techType = self._data:GetTreeId()
  local techTypeCfg = ConfigData.activity_tech_type[techType]
  if techTypeCfg ~= nil then
    local resTable = {}
    if 0 < (techTypeCfg.activity_tech_item or 0) then
      table.insert(resTable, techTypeCfg.activity_tech_item)
    end
    for k, v in pairs(techTypeCfg.return_tech_item) do
      table.insert(resTable, k)
    end
    UIUtil.RefreshTopResId(resTable)
  end
  self._allTechDataDic = self._data:GetTechDataDic()
  self._branchList = {}
  for branchId, _ in pairs(self._allTechDataDic) do
    if branchId ~= self._specialBranchId then
      table.insert(self._branchList, branchId)
    end
  end
  table.sort(self._branchList)
  self._sideNode:InitChristmas22TechSpeicalSide(self._data, self._specialBranchId, self.resloader)
  self:__GenTitle()
  self:__GenTech()
end

function UIChristmas22StrategyOverview:__ItemUpdate(_, _, itemDic)
  local techTypeCostDic = self._data:GetTechTypeCostDic()
  if techTypeCostDic == nil then
    return
  end
  for itemId, _ in pairs(techTypeCostDic) do
    if itemDic[itemId] ~= nil then
      self:__RefreshWindow()
      break
    end
  end
end

function UIChristmas22StrategyOverview:__GenTitle()
  self._titlePool:HideAll()
  for _, branchId in ipairs(self._branchList) do
    local item = self._titlePool:GetOne()
    item:InitChristmas22TechTitle(self._data, branchId)
  end
end

function UIChristmas22StrategyOverview:__GenTech()
  local bottomY = 0
  self._itemPool:HideAll()
  self._techItemDic = {}
  for branchId, branchTechDic in pairs(self._allTechDataDic) do
    if branchId ~= self._specialBranchId then
      for techId, techData in pairs(branchTechDic) do
        if not techData:IsActTechAutoUnlock() then
          local item = self._itemPool:GetOne()
          item.transform:SetParent(self.ui.rect)
          item.gameObject.name = "tech_" .. tostring(techId)
          item:BindChristmas22TechItemLockFunc(self.__GetLockItemCallback)
          item:InitChristmas22TechItem(techData, self.resloader, self.__OnClickLvCallbackCallback)
          local pos = self:__CalTechPos(techData.colIndex, techData.rowIndex)
          item.transform.anchoredPosition = pos
          self._techItemDic[techId] = item
          if bottomY > pos.y then
            bottomY = pos.y
          end
        end
      end
    end
  end
  self._linePool:HideAll()
  for techId, techItem in pairs(self._techItemDic) do
    local preId = techItem:GetChristmas22TechData():GetPreTechId()
    if preId ~= nil then
      local preItem = self._techItemDic[preId]
      if preItem ~= nil then
        local item = self._linePool:GetOne()
        item.transform:SetParent(self.ui.rect)
        item:InitWALineItem(preItem, techItem)
        item.gameObject.name = "line_" .. tostring(preId) .. "_" .. tostring(techId)
      end
    end
  end
  local sizeDelta = self.ui.rect.sizeDelta
  sizeDelta.y = -bottomY + TECH_HEIGHT
  self.ui.rect.sizeDelta = sizeDelta
end

function UIChristmas22StrategyOverview:__CalTechPos(col, row)
  row = self._data:GetTechRow(row)
  local splitCount = math.floor(col - 1 / TECH_LENGHT_SPLIT)
  local x = splitCount * TECH_WIDTH_SPLIT + (col - 1 - splitCount) * TECH_WIDTH_NOR + LEFT_INTERNIVAL
  local y = -(row - 1) * TECH_HEIGHT - Top_INTERNIVAL
  return Vector2.New(x, y)
end

function UIChristmas22StrategyOverview:__RefreshWindow()
  for k, v in pairs(self._titlePool.listItem) do
    v:RefreshChristmas22TechTitle()
  end
  for k, v in pairs(self._techItemDic) do
    v:RefreshChristmas22TechItem()
  end
  self._sideNode:RefreshChristmas22TechSpeicalSide()
  if self._lvNode ~= nil and self._lvNode.active then
    self._lvNode:RefreshChristmas22TechLv()
  end
  if self._detailNode ~= nil and self._detailNode.active then
    self._detailNode:RefreshChristmas22TechSpecialList()
  end
end

function UIChristmas22StrategyOverview:OnClickBg()
  if self._lvNode ~= nil then
    self._lvNode:Hide()
  end
end

function UIChristmas22StrategyOverview:OnClickLvCallback(techItem, techData)
  if self._lvNode == nil then
    self.ui.techInfoNode:SetActive(true)
    self._lvNode = self._techLvClass.New()
    self._lvNode:Init(self.ui.techInfoNode)
    self._lvNode:SetChristmas22LogicDesType(self._desType)
  else
    self._lvNode:Show()
  end
  self._lvNode:InitChristmas22TechLv(techData, self.__OnTechLvCallback)
  self._lvNode:FloatTo(techItem.transform, HAType.left, VAType.downAuto)
end

function UIChristmas22StrategyOverview:__GetLockItem()
  return self._lockPool:GetOne().gameObject
end

function UIChristmas22StrategyOverview:__OnTechLv(techData)
  if techData:IsMaxLvel() then
    return
  end
  local cond, para1, para2 = techData:GetAWTechUnlockParam(techData:GetCurLevel() + 1)
  local isUnlock = CheckCondition.CheckLua(cond, para1, para2)
  if not isUnlock then
    cs_MessageCommon.ShowMessageTips(CheckCondition.GetUnlockInfoLua(cond, para1, para2))
    return
  end
  if techData:GetActTechPrfeTotleLevel() > self._data:GetTechBranchLevel() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8716))
    return
  end
  if not techData:IsLeveUpResEnough() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(self._itemNoEnoughTip))
  end
  self._data:ReqTechUp(techData:GetTechId(), function()
    if not IsNull(self.transform) then
      self._sideNode:AddWaitLookTech(techData)
      self:__RefreshWindow()
    end
  end)
end

function UIChristmas22StrategyOverview:__OnTechReset()
  local techTypeCfg = ConfigData.activity_tech_type[self._data:GetTreeId()]
  for k, v in pairs(techTypeCfg.return_tech_item) do
    if v > PlayerDataCenter:GetItemCount(k) then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(self._resetNoEnoughTip))
      return
    end
  end
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(8715), function()
    self._data:ReqTechAllReset(self.__RefreshWindowCallback)
  end, nil)
end

function UIChristmas22StrategyOverview:__OnTechDetail()
  if self._detailNode == nil then
    self.ui.windowInfo:SetActive(true)
    self._detailNode = self._specialListClass.New()
    self._detailNode:Init(self.ui.windowInfo)
    self._detailNode:SetChristmas22LogicDesType(self._desType)
    self._detailNode:InitChristmas22TechSpecialList(self._data, self._specialBranchId, self.resloader, self.__OnTechLvCallback)
  else
    self._detailNode:Show()
    self._detailNode:RefreshChristmas22TechSpecialList()
  end
end

function UIChristmas22StrategyOverview:CloseChristmas22StrategyOverview()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIChristmas22StrategyOverview:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemUpdateCallback)
  base.OnDelete(self)
end

return UIChristmas22StrategyOverview
