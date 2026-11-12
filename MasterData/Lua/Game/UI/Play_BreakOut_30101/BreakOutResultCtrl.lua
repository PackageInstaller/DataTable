local BreakOutResultCtrl = class("BreakOutResultCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
BreakOutResultCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  BtnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close",
    sAction = "Back"
  },
  FailRoot = {},
  LeveName_Fail = {},
  SucceedRoot = {},
  LeveName_Succeed = {},
  btn_Exit = {
    sNodeName = "btn_Exit",
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close",
    sAction = "Giveup",
    sActionIconType = "Dark"
  },
  txt_Exit = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Result_Exit"
  },
  btn_Restart = {
    sNodeName = "btn_Restart",
    sComponentName = "NaviButton",
    callback = "BreakOut_Button_Restart",
    sAction = "Retry",
    sActionIconType = "Dark"
  },
  txt_Restart = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Result_Restart"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  txtTips1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  txtTips2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  txtClickPre = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Click_Pre"
  },
  txtClickSuf = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Click_Suf"
  }
}
BreakOutResultCtrl._mapEventConfig = {OpenBreakOutResultPanel = "Open", CloseBreakOutResultPanel = "Close"}
BreakOutResultCtrl._mapRedDotConfig = {}

function BreakOutResultCtrl:Awake()
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  self._mapNode.BtnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  self._mapNode.txtTips1.gameObject:SetActive(not GamepadUIManager.GetInputState())
end

function BreakOutResultCtrl:OnEnable()
end

function BreakOutResultCtrl:SetContent()
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
  if self.bResult then
    WwiseAudioMgr:PostEvent("mode_breakout_ui_victory")
    local sTitle = self._mapNode.LeveName_Succeed.transform:Find("txt_title"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(sTitle, self.sLevelName)
    self:AddTimer(1, 1, function()
      local mapReward = PlayerData.Item:ProcessRewardChangeInfo(self.mapChangeInfo)
      local tbItem = {}
      for _, v in pairs(mapReward.tbReward) do
        local item = {
          Tid = v.id,
          Qty = v.count,
          rewardType = AllEnum.RewardType.First
        }
        table.insert(tbItem, item)
      end
      UTILS.OpenReceiveByDisplayItem(tbItem, self.mapChangeInfo)
    end, true, true, true)
  else
    WwiseAudioMgr:PostEvent("mode_breakout_ui_lose")
    local sTitle = self._mapNode.LeveName_Fail.transform:Find("txt_title"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(sTitle, self.sLevelName)
  end
end

function BreakOutResultCtrl:OnBtnClick_Close(btn)
  if self.bProcessingClose then
    return
  end
  self.bProcessingClose = true
  if self.callback ~= nil then
    self.callback()
  end
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    EventManager.Hit(EventId.CloesCurPanel)
    PlayerData.Base:OnBackToMainMenuModule()
  else
    CS.AdventureModuleHelper.LevelStateChanged(true, 0, false)
  end
end

function BreakOutResultCtrl:BreakOut_Button_Restart()
  EventManager.Hit("Close_BattlePause")
  self:Close()
  EventManager.Hit("SetPlayFinishState", false)
  EventManager.Hit("SetBreakOutPlaySkill_Visible", false)
  NovaAPI.DispatchEventWithData("BreakOut_InRestart", nil, {true})
  EventManager.Hit("BreakOut_Complete", false)
  CS.AdventureModuleHelper.LevelStateChanged(false)
  EventManager.Hit("ResetBossHUD")
end

function BreakOutResultCtrl:Open(bResult, sLevelName, callback, mapChangeInfo)
  EventManager.Hit("Event_SetPopPlayTips", false)
  GamepadUIManager.EnableGamepadUI("BreakOutResultCtrl", self.tbGamepadUINode)
  PanelManager.InputDisable()
  EventManager.Hit("SetBreakOutPlaySkill_Visible", false)
  EventManager.Hit("OnEvent_ClearState")
  self.bResult = bResult
  self.sLevelName = sLevelName
  self.callback = callback
  self.mapChangeInfo = mapChangeInfo
  self._mapNode.SucceedRoot:SetActive(self.bResult)
  self._mapNode.FailRoot:SetActive(not self.bResult)
  self._mapNode.BtnShortcutClose.gameObject:SetActive(self.bResult)
  self:SetContent()
  self.bProcessingClose = false
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
end

function BreakOutResultCtrl:Close()
  self._mapNode.safeAreaRoot:SetActive(false)
  EventManager.Hit("Event_SetPopPlayTips", true)
  PanelManager.InputEnable()
  self._mapNode.imgBlurredBg.gameObject:SetActive(false)
  GamepadUIManager.DisableGamepadUI("BreakOutResultCtrl")
end

return BreakOutResultCtrl
