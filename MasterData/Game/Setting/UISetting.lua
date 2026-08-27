local UISetting = class("UISetting", UIBaseWindow)
local base = UIBaseWindow
local UISettingDisplayPanel = require("Game.Setting.UI.UISettingDisplayPanel")
local UINSettingTypeItem = require("Game.Setting.UI.UINSettingTypeItem")
local UINNotifySettingNode = require("Game.Setting.UI.UINNotifySettingNode")
local UINCDKeyPanelNode = require("Game.Setting.UI.UINCDKeyPanelNode")
local UINGameSetPanelNode = require("Game.Setting.UI.UINGameSetPanel")
local UISingleSwitchTogItem = require("Game.Setting.UI.UISingleSwitchTogItem")
local UINSettingJpStatute = require("Game.Setting.UI.UINSettingJpStatute")
local cs_MicaSDKManager = CS.MicaSDKManager.Instance
local CS_ClientConsts = CS.ClientConsts

function UISetting:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.CloseSettingClicked)
  UIUtil.AddButtonListener(self.ui.btn_Logout, self, self.UserLogout)
  UIUtil.AddButtonListener(self.ui.btn_UserCenter, self, self.OpenUserCenter)
  UIUtil.AddButtonListener(self.ui.btn_Customer, self, self.EnterCustomService)
  UIUtil.AddButtonListener(self.ui.btn_BiliCloseAccount, self, self._BiliCloseAccount)
  UIUtil.AddButtonListener(self.ui.btn_ActorList, self, self.OnClickBtnActorList)
  self.ui.btn_BiliCloseAccount.gameObject:SetActive(Consts.GameChannelType.IsBilibili())
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  self.notifySettingNode = nil
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):PushTopStatusDataToBackStack()
end

local InitStartup = {
  [UIWindowTypeID.BattlePause] = {
    showTypeGroup = {5, 2},
    topActive = false
  }
}

function UISetting:InitSettingByFrom(winFrom)
  local starUp = InitStartup[winFrom]
  local topActive = true
  local showTypeGroup
  if starUp ~= nil then
    showTypeGroup = starUp.showTypeGroup
    topActive = starUp.topActive
  else
    showTypeGroup = {}
    for i = 1, #self.ui.settingTypeGroup do
      table.insert(showTypeGroup, i)
    end
  end
  self:_SetTopBtnActive(topActive)
  self:_InitCustomer()
  self:InitSettingTypeItem(showTypeGroup)
  self:__InitGameSettingReddot()
end

function UISetting:_SetTopBtnActive(active)
  self.ui.btn_Logout.gameObject:SetActive(active)
  self.ui.btn_UserCenter.gameObject:SetActive(active)
  self.ui.btn_Customer.gameObject:SetActive(active)
end

function UISetting:_InitCustomer()
  self.__onCustomerNewMsg = BindCallback(self, self.OnCustomerNewMsg)
  cs_MicaSDKManager:onHaveNewMsg("+", self.__onCustomerNewMsg)
  local channelId = cs_MicaSDKManager.channelId
  if Consts.GameChannelType.IsInland() and (channelId == Consts.GameChannelType.Bilibili or channelId == Consts.GameChannelType.BilibiliKol or channelId == Consts.GameChannelType.BilibiliGray or channelId == Consts.GameChannelType.BilibiliQATest) then
    self.ui.btn_UserCenter.gameObject:SetActive(false)
    self.ui.btn_Customer.gameObject:SetActive(false)
  else
    cs_MicaSDKManager:CheckCustomNewMsg()
  end
end

function UISetting:InitSettingTypeItem(showTypeGroup)
  for i = 1, #self.ui.settingTypeGroup do
    self.ui.settingTypeGroup[i].gameObject:SetActive(false)
  end
  self.settingTypeItemList = {}
  for _, value in ipairs(showTypeGroup) do
    local typeItem = UINSettingTypeItem.New()
    typeItem:Init(self.ui.settingTypeGroup[value].transform)
    self.settingTypeItemList[value] = typeItem
    UIUtil.AddValueChangedListener(self.ui.settingTypeGroup[value], self, self.OnPanelToggleValueChanged, value)
    local active = true
    if value == 4 then
      active = self:VerifyGiftUnlock()
    end
    typeItem.gameObject:SetActive(active)
  end
  self.ui.settingTypeGroup[showTypeGroup[1]].group:SetAllTogglesOff()
  self.ui.settingTypeGroup[showTypeGroup[1]].isOn = true
  if not Consts.GameChannelType.IsInland(cs_MicaSDKManager.channelId) and GameSystemInfo.Platform == GameSystemInfo.PlatformType.iOS and self.settingTypeItemList[4] ~= nil then
    self.settingTypeItemList[4].gameObject:SetActive(false)
  end
  if self.settingTypeItemList[6] ~= nil then
    local isJp = Consts.GameChannelType.IsJp(cs_MicaSDKManager.channelId)
    self.settingTypeItemList[6].gameObject:SetActive(isJp)
  end
end

function UISetting:OnPanelToggleValueChanged(index, value)
  if index == 1 then
    self.ui.displayPanel:SetActive(value)
    if value and not self.__isDisplayInited then
      self:InitDisplaySettingPanel()
      self.__isDisplayInited = true
    end
  elseif index == 2 then
    self.ui.audioPanel:SetActive(value)
    if value and not self.__isAudioInited then
      self:InitAudioSettingPanel()
      self.__isAudioInited = true
    end
  elseif index == 3 then
    self.ui.notifiesPanel:SetActive(value)
    if value and not self.__isNoticeInited then
      self:InitNoticeSettingPanel()
      self.__isNoticeInited = true
    end
  elseif index == 4 then
    self.ui.cDKeyPanel:SetActive(value)
    if value and not self.__iscDKeyInited then
      self:InitCDKeyPanel()
      self.__iscDKeyInited = true
    end
  elseif index == 5 then
    self.ui.gameSetPanel:SetActive(value)
    if value and not self.__isGameSetInited then
      self:InitGameSet()
      self.__isGameSetInited = true
      self.ctrl:SetGameSettingReddotLooked()
    end
  elseif index == 6 then
    self:_TryInitJpStatute()
    if value then
      self._jpStatuteNode:Show()
    else
      self._jpStatuteNode:Hide()
    end
  end
  self.settingTypeItemList[index]:SetSettingTypeItemActive(value, self.ui)
end

function UISetting:InitDisplaySettingPanel()
  self.displayPanel = UISettingDisplayPanel.New()
  self.displayPanel:Init(self.ui.displayPanel)
  self.displayPanel:InitDisplayPanel(self.ctrl)
end

function UISetting:InitAudioSettingPanel()
  local audioSetting = self.ctrl:GetSettingAudioData()
  for index = 1, AudioManager.AudioTypeCount do
    UIUtil.AddValueChangedListener(self.ui.audioSliderGroup[index], self, self.OnAudioVolumeChanged, index)
    self.ui.audioSliderGroup[index].value = audioSetting.volumes[index] or 1
  end
  if self.muteTogItem == nil then
    self.muteTogItem = UISingleSwitchTogItem.New()
    self.muteTogItem:Init(self.ui.tog_mute)
    local currnetOpenWeatherCallback = BindCallback(self, self.IsGlobalMute, "mute")
    self.muteTogItem:InitSingleSwitchTogItem(currnetOpenWeatherCallback, {
      ConfigData:GetTipContent(8002),
      ConfigData:GetTipContent(8001)
    }, self.OnAudioSwitchChaned, self)
  end
end

function UISetting:OnAudioVolumeChanged(index, value)
  self.ctrl:SetSettingAudioVolume(index, value)
  CS.AudioManager.Instance:SetVolume(index, value)
  self.ui.audioVolTextGroup[index].text = tostring(math.floor(value * 100))
end

function UISetting:IsGlobalMute()
  local audioSetting = self.ctrl:GetSettingAudioData()
  if audioSetting == nil then
    return false
  end
  if audioSetting.globalMute == nil then
    return false
  end
  return audioSetting.globalMute
end

function UISetting:OnAudioSwitchChaned(value)
  self.ctrl:SetSettingAudioGlobalMute(value)
  for index = 1, AudioManager.AudioTypeCount do
    CS.AudioManager.Instance:SetMute(index, value)
  end
end

function UISetting:InitNoticeSettingPanel()
  local noticeSwitchOffDic = self.ctrl:GetSettingNoticeSwitch()
  if self.notifySettingNode == nil then
    self.notifySettingNode = UINNotifySettingNode.New()
    self.notifySettingNode:Init(self.ui.notifiesPanel)
  end
  self.notifySettingNode:InitNotifySettingNode(noticeSwitchOffDic)
end

function UISetting:InitCDKeyPanel()
  if self.cDKeyPanelNode == nil then
    self.cDKeyPanelNode = UINCDKeyPanelNode.New()
    self.cDKeyPanelNode:Init(self.ui.cDKeyPanel)
  end
end

function UISetting:InitGameSet()
  if self.gameSetPanelNode == nil then
    self.gameSetPanelNode = UINGameSetPanelNode.New()
    self.gameSetPanelNode:Init(self.ui.gameSetPanel)
    self.gameSetPanelNode:InitGameSetPanel(self.ctrl)
  end
end

function UISetting:_TryInitJpStatute()
  if self._jpStatuteNode == nil then
    self._jpStatuteNode = UINSettingJpStatute.New()
    self._jpStatuteNode:Init(self.ui.jPStatutePanel)
  end
  self._jpStatuteNode:InitSettingJpStatute()
end

function UISetting:CloseSettingClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UISetting:UserLogout()
  self.ctrl:UserLogout()
end

function UISetting:OpenUserCenter()
  self.ctrl:OpenUserCenter()
end

function UISetting:EnterCustomService()
  self.ui.redDot_Customer:SetActive(false)
  self.ctrl:EnterCustomService()
end

function UISetting:_BiliCloseAccount()
  self.ctrl:BiliCloseAccount()
end

function UISetting:OnClickBtnActorList()
  UIManager:ShowWindowAsync(UIWindowTypeID.ClosingList, function(win)
    if win == nil then
      return
    end
    win:InitClosingList()
  end)
end

function UISetting:OnCustomerNewMsg(value)
  if value then
    self.ui.redDot_Customer:SetActive(true)
  end
end

function UISetting:SetCDKButtomActive(active)
  self.ui.settingTypeGroup[4].gameObject:SetActive(active)
end

function UISetting:SetUIMailHideCallback(callback)
  self.__hideCallback = callback
end

function UISetting:VerifyGiftUnlock()
  local isGiftUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_GiftCode)
  if CS_ClientConsts.IsAudit then
    isGiftUnlock = false
  end
  return isGiftUnlock
end

function UISetting:__InitGameSettingReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Setting, RedDotStaticTypeId.GameSetting)
  if isOk then
    if self.__refresnGameSettingReddot == nil then
      function self.__refresnGameSettingReddot(node)
        self.ui.blueDot_GameSetting:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(node.nodePath, self.__refresnGameSettingReddot)
    self.__refresnGameSettingReddot(node)
  end
end

function UISetting:__RemoveGameSettingReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Setting, RedDotStaticTypeId.GameSetting)
  if isOk then
    RedDotController:RemoveListener(node.nodePath, self.__refresnGameSettingReddot)
  end
  self.__refresnGameSettingReddot = nil
end

function UISetting:OnHide()
  self:OnCloseWin()
  if self.__hideCallback ~= nil then
    self.__hideCallback()
  end
  base.OnHide(self)
end

function UISetting:OnDelete()
  if self._jpStatuteNode ~= nil then
    self._jpStatuteNode:Delete()
    self._jpStatuteNode = nil
  end
  self:__RemoveGameSettingReddot()
  cs_MicaSDKManager:onHaveNewMsg("-", self.__onCustomerNewMsg)
  self.ctrl:TryReqSaveGameSettingData()
  self.ctrl = nil
  base.OnDelete(self)
  PersistentManager:SaveModelData(PersistentConfig.ePackage.SystemData)
  PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
end

return UISetting
