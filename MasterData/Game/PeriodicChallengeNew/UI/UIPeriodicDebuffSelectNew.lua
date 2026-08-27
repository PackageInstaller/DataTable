local UIPeriodicDebuffSelectNew = class("UIPeriodicDebuffSelectNew", UIBaseWindow)
local base = UIBaseWindow
local UINPeriodicDebuff = require("Game.PeriodicChallengeNew.UI.UINPeriodicEnvBuffLockItem")
local UINPeriodicEnvBuffTitle = require("Game.PeriodicChallengeNew.UI.UINPeriodicEnvBuffTitle")
local UINPeriodicEnvBuffLockItem = require("Game.PeriodicChallengeNew.UI.UINPeriodicEnvBuffLockItem")
local UINDungeonBuffItem = require("Game.CommonUI.DungeonState.UINDungeonBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_MessageCommon = CS.MessageCommon
local tiveTypeEnum = {Positive = 1, Negative = 2}

function UIPeriodicDebuffSelectNew:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_ClearAll, self, self.OnClickClear)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  self.resloader = CS.ResLoader.Create()
  UIUtil.SetTopStatus(self, self.Delete)
  self.buffItemPool = UIItemPool.New(UINPeriodicDebuff, self.ui.obj_debuffSelectItem)
  self.ui.obj_debuffSelectItem:SetActive(false)
  self.titleItemPool = UIItemPool.New(UINPeriodicEnvBuffTitle, self.ui.obj_debuffTitle)
  self.ui.obj_debuffTitle:SetActive(false)
  self.buffIconPool = UIItemPool.New(UINDungeonBuffItem, self.ui.img_BuffItem)
  self.ui.img_BuffItem:SetActive(false)
  self.__OnSelectTogAction = BindCallback(self, self.OnItemValueChange)
  self.__OnPressBuffItemAction = BindCallback(self, self.__OnPressBuffItem)
  self.__OnPressUpBuffItemAction = BindCallback(self, self.__OnPressUpBuffItem)
end

function UIPeriodicDebuffSelectNew:InitDebuffSelectNew(fmtBuffSelectData, confirmFunc, closeCallback)
  self.buffCfgDic = fmtBuffSelectData:GetFmtAllBuffCfg()
  self.fmtBuffSelectData = fmtBuffSelectData
  self.closeCallback = closeCallback
  self.confirmFunc = confirmFunc
  self:CreateEnvBuffInfo()
  self:CreateEnvBuffSelectInfo(fmtBuffSelectData:GetFmtBuffSelect())
  self:CreateItemList()
  self:Refresh()
end

function UIPeriodicDebuffSelectNew:CreateEnvBuffInfo()
  self._envBuffInfo = {
    buffList = {},
    deBuffList = {}
  }
  for buffId, cfg in pairs(self.buffCfgDic) do
    if self.fmtBuffSelectData:IsPositiveBuff(buffId) then
      table.insert(self._envBuffInfo.buffList, buffId)
    else
      table.insert(self._envBuffInfo.deBuffList, buffId)
    end
  end
  
  local function Local_SortDebuff(list)
    table.sort(list, function(a, b)
      local aCfg = self.buffCfgDic[a]
      local bCfg = self.buffCfgDic[b]
      if aCfg.order_id ~= bCfg.order_id then
        return aCfg.order_id < bCfg.order_id
      end
      return a < b
    end)
  end
  
  Local_SortDebuff(self._envBuffInfo.deBuffList)
  Local_SortDebuff(self._envBuffInfo.buffList)
end

function UIPeriodicDebuffSelectNew:CreateEnvBuffSelectInfo(selectedBuffIds)
  self._envBuffSelectInfo = {
    selectedDic = {},
    selectPositiveDic = {},
    selectNegativeDic = {}
  }
  if selectedBuffIds == nil then
    return
  end
  for _, buffId in ipairs(selectedBuffIds) do
    if self.buffCfgDic[buffId] ~= nil then
      local isPositive = self.fmtBuffSelectData:IsPositiveBuff(buffId)
      self._envBuffSelectInfo.selectedDic[buffId] = true
      if isPositive then
        self._envBuffSelectInfo.selectPositiveDic[buffId] = true
      else
        self._envBuffSelectInfo.selectNegativeDic[buffId] = true
      end
    end
  end
end

function UIPeriodicDebuffSelectNew:CreateItemList()
  self.ui.tex_Title.text = self.fmtBuffSelectData:GetFmtBuffTitle()
  self.ui.tex_Intro.text = self.fmtBuffSelectData:GetFmtBuffIntro()
  self.buffItemPool:HideAll()
  self.titleItemPool:HideAll()
  for i = 1, 2 do
    local titleItem = self.titleItemPool:GetOne()
    if i == tiveTypeEnum.Positive then
      titleItem:SetPositiveTitle()
      for _, buffId in ipairs(self._envBuffInfo.buffList) do
        local item = self.buffItemPool:GetOne()
        item:InitDebuffItem(buffId, self.buffCfgDic[buffId], self.__OnSelectTogAction, self._envBuffSelectInfo.selectedDic[buffId], self.resloader)
      end
    elseif i == tiveTypeEnum.Negative then
      titleItem:SetNegativeTitle()
      for _, buffId in ipairs(self._envBuffInfo.deBuffList) do
        local item = self.buffItemPool:GetOne()
        item:InitDebuffItem(buffId, self.buffCfgDic[buffId], self.__OnSelectTogAction, self._envBuffSelectInfo.selectedDic[buffId], self.resloader)
      end
    end
  end
end

function UIPeriodicDebuffSelectNew:Refresh()
  self.buffIconPool:HideAll()
  local permillageAll = 0
  for buffId, _ in pairs(self._envBuffSelectInfo.selectedDic) do
    local buffCfg = ConfigData.exploration_buff[buffId]
    local item = self.buffIconPool:GetOne()
    item:InitBuffOnlyWithCfg(buffCfg, self.__OnPressBuffItemAction, self.__OnPressUpBuffItemAction)
    permillageAll = permillageAll + self.buffCfgDic[buffId].inifinite_coe
  end
  permillageAll = permillageAll + self.fmtBuffSelectData:GetBaseAddRate()
  self.ui.tex_BuffCount:SetIndex(0, tostring(table.count(self._envBuffSelectInfo.selectedDic)))
  self.ui.tex_Percent:SetIndex(0, tostring(permillageAll))
  local groupCfg = self.fmtBuffSelectData:GetGroupCfg()
  local positiveNum = table.count(self._envBuffSelectInfo.selectPositiveDic)
  local negativeNum = table.count(self._envBuffSelectInfo.selectNegativeDic)
  local positiveForbid = positiveNum >= groupCfg.buff_max
  local negativeForbid = negativeNum >= groupCfg.debuff_max
  for _, item in ipairs(self.buffItemPool.listItem) do
    local selected = self._envBuffSelectInfo.selectedDic[item.buffId] ~= nil
    if selected then
      item:ChangeState(selected, false)
    else
      local isForbid = false
      if self.fmtBuffSelectData:IsPositiveBuff(item.buffId) and positiveForbid then
        isForbid = true
      end
      if not self.fmtBuffSelectData:IsPositiveBuff(item.buffId) and negativeForbid then
        isForbid = true
      end
      item:ChangeState(selected, isForbid)
    end
  end
  for _, item in ipairs(self.titleItemPool.listItem) do
    if item.isPositive then
      item:SetSelectNum(positiveNum, groupCfg.buff_max)
    else
      item:SetSelectNum(negativeNum, groupCfg.debuff_max)
    end
  end
  local warningTipValue = self.fmtBuffSelectData:GetBuffScoreWarningValue(1)
  self.ui.obj_Warning:SetActive(permillageAll >= warningTipValue)
end

function UIPeriodicDebuffSelectNew:OnClickClear()
  self:__ClearSelectInfo()
  self:Refresh()
end

function UIPeriodicDebuffSelectNew:OnClickConfirm()
  if self.confirmFunc ~= nil then
    local selectedBuffIds = {}
    for buffId, _ in pairs(self._envBuffSelectInfo.selectedDic) do
      table.insert(selectedBuffIds, buffId)
    end
    self.confirmFunc(selectedBuffIds)
  end
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  UIUtil.OnClickBackByUiTab(self)
end

function UIPeriodicDebuffSelectNew:OnItemValueChange(buffId, flag)
  if flag then
    self:__SelectDebuff(buffId)
  else
    self:__CancleDebuff(buffId)
  end
  self:Refresh()
end

function UIPeriodicDebuffSelectNew:__SelectDebuff(buffId)
  if self._envBuffSelectInfo.selectedDic[buffId] ~= nil then
    return
  end
  local isPositive = self.fmtBuffSelectData:IsPositiveBuff(buffId)
  local groupCfg = self.fmtBuffSelectData:GetGroupCfg()
  if isPositive and table.count(self._envBuffSelectInfo.selectPositiveDic) >= groupCfg.buff_max then
    local err = ConfigData:GetTipContent(40012)
    cs_MessageCommon.ShowMessageTips(err)
    return
  end
  if not isPositive and table.count(self._envBuffSelectInfo.selectNegativeDic) >= groupCfg.debuff_max then
    local err = ConfigData:GetTipContent(40012)
    cs_MessageCommon.ShowMessageTips(err)
    return
  end
  if isPositive then
    self._envBuffSelectInfo.selectPositiveDic[buffId] = true
  else
    self._envBuffSelectInfo.selectNegativeDic[buffId] = true
  end
  self._envBuffSelectInfo.selectedDic[buffId] = true
end

function UIPeriodicDebuffSelectNew:__CancleDebuff(buffId)
  if self._envBuffSelectInfo.selectedDic[buffId] == nil then
    return
  end
  local isPositive = self.fmtBuffSelectData:IsPositiveBuff(buffId)
  if isPositive then
    self._envBuffSelectInfo.selectPositiveDic[buffId] = nil
  else
    self._envBuffSelectInfo.selectNegativeDic[buffId] = nil
  end
  self._envBuffSelectInfo.selectedDic[buffId] = nil
end

function UIPeriodicDebuffSelectNew:__ClearSelectInfo()
  self._envBuffSelectInfo.selectedDic = {}
  self._envBuffSelectInfo.selectPositiveDic = {}
  self._envBuffSelectInfo.selectNegativeDic = {}
end

function UIPeriodicDebuffSelectNew:__OnPressBuffItem(buffItem, buffCfg)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(LanguageUtil.GetLocaleText(buffCfg.name), LanguageUtil.GetLocaleText(buffCfg.describe))
  win:FloatTo(buffItem.transform, HAType.autoCenter, VAType.down)
end

function UIPeriodicDebuffSelectNew:__OnPressUpBuffItem()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UIPeriodicDebuffSelectNew:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIPeriodicDebuffSelectNew
