local UIWinterActivityTech = class("UIWinterActivityTech", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local UINUnlockedTechLine = require("Game.ActivitySectorII.Tech.UI.UINUnlockedTechLine")
local UINTechItem = require("Game.ActivitySectorII.Tech.UI.UINTechItem")
local UINWATechLine = require("Game.ActivitySectorII.Tech.UI.UINWATechLine")
local UINWATechSide = require("Game.ActivitySectorII.Tech.UI.UINWATechSide")

function UIWinterActivityTech:OnInit()
  self.actId = nil
  self.resloader = cs_ResLoader.Create()
  self.techItemDic = {}
  self.techItemIdDic = {}
  self.unlockRowPool = UIItemPool.New(UINUnlockedTechLine, self.ui.obj_unlock)
  self.ui.obj_unlock:SetActive(false)
  self.techItemPool = UIItemPool.New(UINTechItem, self.ui.obj_techItem)
  self.ui.obj_techItem:SetActive(false)
  self.techLinePool = UIItemPool.New(UINWATechLine, self.ui.obj_Line)
  self.ui.obj_Line:SetActive(false)
  self.techSideNode = UINWATechSide.New()
  self.techSideNode:Init(self.ui.obj_side)
  self.techSideNode:InitTechSideNode(self)
  self.ui.obj_OnSelelct:SetActive(false)
  self.ui.obj_IsLock:SetActive(false)
  self.__OnClickTechItem = BindCallback(self, self.OnClickTechItem)
  self.__RefreshAllItem = BindCallback(self, self.RefreshAllItem)
  MsgCenter:AddListener(eMsgEventId.ActivityTechChange, self.__RefreshAllItem)
  self.__showIntroduce = BindCallback(self, self.__ShowIntroduce)
  UIUtil.SetTopStatus(self, self.OnReturnClick, nil, self.__showIntroduce)
end

function UIWinterActivityTech:InitWATech(actId)
  self.actId = actId
  self.unlockRowPool:HideAll()
  self.techItemPool:HideAll()
  self.techLinePool:HideAll()
  local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
  local SectorIIData = sectorIICtrl:GetSectorIIDataByActId(actId)
  local rowDataList = SectorIIData:GetSectorIITechRowDataList()
  self:GenTechRows(rowDataList, SectorIIData)
  self:GenWATechItem(rowDataList)
  self:GenLineBetweenTechItem()
  self:SelectDefaultTechItem()
  UIUtil.RefreshTopResId({
    SectorIIData:GetSectorIIDunPointId()
  })
  local firstTechItem = rowDataList[1]:GetTechDataDic()
  for techId, techData in pairs(firstTechItem) do
    if not techData.level or techData.level == 0 then
      GuideManager:StartNewTriggerGuide(31001)
      break
    end
  end
end

function UIWinterActivityTech:GenTechRows(rowDataList, SectorIIData)
  for index, lineData in ipairs(rowDataList) do
    lineData:RefreshTechAvgState()
    local isUnlock = lineData:GetIsUnlock()
    if isUnlock then
      local unlockRowItem = self.unlockRowPool:GetOne()
      unlockRowItem:RefreshRowItem(SectorIIData, lineData, self.resloader)
    else
      local lockedRowItem = self.unlockRowPool:GetOne()
      lockedRowItem:RefreshRowItem(SectorIIData, lineData, self.resloader)
    end
  end
end

function UIWinterActivityTech:GenWATechItem(rowDataList)
  self.techItemDic = {}
  self.techItemIdDic = {}
  for row, lineData in ipairs(rowDataList) do
    self.techItemDic[row] = {}
    for techId, techData in pairs(lineData:GetTechDataDic()) do
      local col = techData:GetTechCol()
      local techItem = self.techItemPool:GetOne()
      techItem:InitWATechItem(techData, self.resloader, self.__OnClickTechItem)
      techItem.transform:SetParent(self.ui.trans_chessLayout)
      techItem.gameObject.name = tostring(row) .. "_" .. tostring(col)
      techItem.transform.anchoredPosition = self:_CalTechItemPos(row, col)
      self.techItemDic[row][col] = techItem
      self.techItemIdDic[techData:GetTechId()] = techItem
    end
  end
end

function UIWinterActivityTech:_CalTechItemPos(row, col)
  local padding = self.ui.chessLayout.padding
  local cellSize = self.ui.chessLayout.cellSize
  local spacing = self.ui.chessLayout.spacing
  local x = padding.left + (col - 0.5) * cellSize.x + spacing.x * (col - 1)
  local y = (padding.top + (row - 0.5) * cellSize.y + spacing.y * (row - 1)) * -1
  return Vector2.New(x, y)
end

function UIWinterActivityTech:GenLineBetweenTechItem()
  for row, colDic in pairs(self.techItemDic) do
    for col, techItem in pairs(colDic) do
      local techData = techItem.techData
      local preTechId = techData:GetPreTechId()
      if preTechId ~= nil then
        local preTechItem = self.techItemIdDic[preTechId]
        if preTechItem ~= nil then
          local techLine = self.techLinePool:GetOne()
          techLine.transform:SetParent(self.ui.trans_chessLayout)
          techLine.gameObject.name = preTechItem.gameObject.name .. " to " .. techItem.gameObject.name
          techLine:InitWALineItem(preTechItem, techItem)
        end
      end
    end
  end
end

function UIWinterActivityTech:OnClickTechItem(techItem)
  if not self.ui.obj_OnSelelct.activeSelf then
    self.ui.obj_OnSelelct:SetActive(true)
  end
  self.ui.obj_OnSelelct.transform:SetParent(techItem.transform)
  self.ui.obj_OnSelelct.transform.anchoredPosition = Vector2.zero
  self.techSideNode:RefreshWATechSide(techItem.techData)
end

function UIWinterActivityTech:SelectDefaultTechItem()
  for row, colDic in ipairs(self.techItemDic) do
    for col, techItem in pairs(colDic) do
      self:OnClickTechItem(techItem)
      return
    end
  end
end

function UIWinterActivityTech:OnTechItemLevelUp(techData)
  local techId = techData:GetTechId()
  local techItem = self.techItemIdDic[techId]
  if techItem ~= nil then
    local fX_LevelUp = self.ui.obj_fX_LevelUp
    fX_LevelUp.transform:SetParent(techItem.transform)
    fX_LevelUp.transform.anchoredPosition = Vector2.zero
    fX_LevelUp:SetActive(false)
    fX_LevelUp:SetActive(true)
    if techData:IsMaxLvel() then
      AudioManager:PlayAudioById(1158)
    end
  end
end

function UIWinterActivityTech:RefreshAllItem()
  for _, techItem in pairs(self.techItemIdDic) do
    techItem:RefreshTechItem()
  end
end

function UIWinterActivityTech:__ShowIntroduce()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(ConfigData.game_config.win21GuideNum, nil)
end

function UIWinterActivityTech:OnReturnClick()
  self:Delete()
end

function UIWinterActivityTech:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.ActivityTechChange, self.__RefreshAllItem)
  base.OnDelete(self)
end

return UIWinterActivityTech
