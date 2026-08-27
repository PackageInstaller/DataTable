local UINBattleDungeonLevelAutoStart = class("UINBattleDungeonLevelAutoStart", UIBaseNode)
local base = UIBaseNode
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local cs_MessageCommon = CS.MessageCommon

function UINBattleDungeonLevelAutoStart:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.OnClickConfirm)
  UIUtil.AddValueChangedListener(self.ui.slider, self, self.OnValueTimesChange)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickTimesAdd)
  self.ui.btn_Add.onPress:AddListener(BindCallback(self, self.OnClickTimesAdd))
  UIUtil.AddButtonListener(self.ui.btn_Sub, self, self.OnClickTimesReduce)
  self.ui.btn_Sub.onPress:AddListener(BindCallback(self, self.OnClickTimesReduce))
  UIUtil.AddButtonListener(self.ui.btn_QuickBattleTip, self, self._OnClickQuickBattleTip)
  self.__OnItemRefresh = BindCallback(self, self.OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
end

function UINBattleDungeonLevelAutoStart:InitDunLevelAutoStart(dungeonLevelData, callback)
  self.dungeonLevelData = dungeonLevelData
  self.callback = callback
  self:RefreshData()
  self:RefreshSlider()
  self:_InitQuickBattle()
  if self.dungeonLevelData:IsDgQuickBattleUnlock() then
    self._isQuickBattle = true
    self._switchQuickBattleTog:SetCommonSwitchToggleValue(true)
  end
  self:_UpdBattleBtnText()
end

function UINBattleDungeonLevelAutoStart:_InitQuickBattle()
  local quickBattleOpen = self.dungeonLevelData:IsDgQuickBattleOpen()
  self.ui.quickBattle:SetActive(quickBattleOpen)
  if not quickBattleOpen then
    return
  end
  if self._switchQuickBattleTog == nil then
    self._switchQuickBattleTog = UINCommonSwitchToggle.New()
    self._switchQuickBattleTog:Init(self.ui.tog_SwitchQuickBattle)
    self._switchQuickBattleFunc = BindCallback(self, self._OnClickSwitchQuickBattle)
    self._switchQuickBattleTog:CommonSwitchTogAutoSetValue(false)
  end
  self._switchQuickBattleTog:InitCommonSwitchToggle(false, self._switchQuickBattleFunc)
end

function UINBattleDungeonLevelAutoStart:SetBattleAutoStartQuick(quickBattleFunc)
  self._quickBattleFunc = quickBattleFunc
end

function UINBattleDungeonLevelAutoStart:_OnClickSwitchQuickBattle(isOn)
  if not self.dungeonLevelData:IsDgQuickBattleUnlock() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2906))
    return
  end
  self._isQuickBattle = isOn
  self._switchQuickBattleTog:SetCommonSwitchToggleValue(isOn)
  self:_UpdBattleBtnText()
end

function UINBattleDungeonLevelAutoStart:_UpdBattleBtnText()
  self.ui.tex_BtnName:SetIndex(self._isQuickBattle and 1 or 0)
end

function UINBattleDungeonLevelAutoStart:RefreshData()
  local ticketItemId = self.dungeonLevelData:GetEnterLevelCost()
  self.ticketItemCount = PlayerDataCenter:GetItemCount(ticketItemId)
  self.ticketSingleCost = self.dungeonLevelData:GetConsumeKeyNum()
  self.ui.img_Ticket.sprite = CRH:GetDefaultKeySprite(ticketItemId)
  local costItemCfg = ConfigData.item[ticketItemId]
  self.ui.tex_TicketName.text = LanguageUtil.GetLocaleText(costItemCfg.name)
  if self.ticketSingleCost > 0 then
    self.maxTimes = math.floor(self.ticketItemCount / self.ticketSingleCost)
    self.curTimes = self.curTimes or self.maxTimes
    self.curTimes = self.curTimes <= self.maxTimes and self.curTimes or self.maxTimes
  end
end

function UINBattleDungeonLevelAutoStart:RefreshSlider()
  if (self.maxTimes or 0) < 1 then
    self.ui.silderNode:SetActive(false)
    self:RefreshAutoStartUI()
    return
  end
  local valueChange = false
  if self.ui.slider.maxValue ~= self.maxTimes then
    self.ui.slider.maxValue = self.maxTimes
  end
  if self.ui.slider.minValue ~= 1 then
    self.ui.slider.minValue = 1
  end
  if self.ui.slider.value ~= self.curTimes then
    self.ui.slider.value = self.curTimes
    valueChange = true
  end
  if not valueChange then
    self:RefreshAutoStartUI()
  end
end

function UINBattleDungeonLevelAutoStart:RefreshAutoStartUI()
  self.ui.tex_BattleTimes.text = tostring(math.floor(self.curTimes))
  self.ui.tex_Before.text = tostring(self.ticketItemCount)
  self.ui.tex_After.text = tostring(math.floor(self.ticketItemCount - self.curTimes * self.ticketSingleCost))
end

function UINBattleDungeonLevelAutoStart:OnItemRefresh(itemUpdate)
  if itemUpdate[ConstGlobalItem.SKey] == nil then
    return
  end
  self:RefreshData()
  self:RefreshSlider()
end

function UINBattleDungeonLevelAutoStart:OnClickTimesAdd()
  if self.curTimes >= self.maxTimes then
    return
  end
  self.curTimes = self.curTimes + 1
  self:RefreshSlider()
end

function UINBattleDungeonLevelAutoStart:OnClickTimesReduce()
  if self.curTimes <= 1 then
    return
  end
  self.curTimes = self.curTimes - 1
  self:RefreshSlider()
end

function UINBattleDungeonLevelAutoStart:OnValueTimesChange(value)
  self.curTimes = math.floor(value)
  self:RefreshAutoStartUI()
end

function UINBattleDungeonLevelAutoStart:OnClickConfirm()
  if self._isQuickBattle and self._quickBattleFunc then
    self._quickBattleFunc(self.curTimes)
    return
  end
  if self.callback == nil then
    return
  end
  self.callback(self.curTimes)
end

function UINBattleDungeonLevelAutoStart:_OnClickQuickBattleTip()
  UIManager:CreateWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfoByRule(21)
  end)
end

function UINBattleDungeonLevelAutoStart:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  base.OnHide(self)
end

function UINBattleDungeonLevelAutoStart:OnDelete()
  if self._switchQuickBattleTog ~= nil then
    self._switchQuickBattleTog:Delete()
  end
end

return UINBattleDungeonLevelAutoStart
