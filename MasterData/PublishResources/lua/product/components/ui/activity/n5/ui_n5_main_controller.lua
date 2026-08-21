_class("UIN5MainController", UIController)
UIN5MainController = UIN5MainController

function UIN5MainController:Constructor()
  self._battlePassTmpCmptId = 100
  self._btnClickAnimTime = 500
  self._componentState = {}
  self._showSpine = false
end

function UIN5MainController:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N5, ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD, ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS, ECampaignN5ComponentID.ECAMPAIGN_N5_CUMULATIVE_LOGIN, ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION, ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION_FIXTEAM)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._battlefieldCompInfo = self._campaign:GetLocalProcess()._battlefieldCompInfo
end

function UIN5MainController:_GetComponentState(componentid)
  return self._campaign:CheckComponentOpen(componentid)
end

function UIN5MainController:OnShow(uiParams)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
  self:_GetComponents()
  self:_OnValue()
  self:_ClearNewFlag()
end

function UIN5MainController:_ClearNewFlag()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._campaignModule:CampaignClearNewFlag(TT, res, self._campaign._id)
    if not res:GetSucc() then
      self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    end
  end, self)
end

function UIN5MainController:OnHide()
  if self._checkRedTask then
    GameGlobal.TaskManager():KillTask(self._checkRedTask)
    self._checkRedTask = nil
  end
end

function UIN5MainController:Dispose()
  UIN5MainController.super:Dispose()
end

function UIN5MainController:AfterUILayerChanged()
  self:_RefreshUIInfo()
end

function UIN5MainController:_RefreshUIInfo()
  local remaintime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if self._battlefieldCompInfo then
    remaintime = self._battlefieldCompInfo.m_close_time - curtime
  end
  self:_ShowActivityIntro(0 < remaintime)
  local pre_remaining = ""
  if 0 < remaintime then
    pre_remaining = StringTable.Get("str_n5_battle_remaining_time")
  else
    local sample = self._campaign and self._campaign:GetSample()
    remaintime = sample and sample.end_time - curtime or 0
    pre_remaining = StringTable.Get("str_n5_reward_remaining_time")
  end
  self:_SetRemainTime(pre_remaining, remaintime)
  self:_RefreshComponentState()
  self:_InitRedPoint()
  self:_RefreshProgressItemCount()
  self:_RefreshBtnState()
end

function UIN5MainController:_CheckCampaignClose()
  return not self._campaign:CheckCampaignOpen()
end

function UIN5MainController:_GetComponents()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end, nil, nil, false, function()
    if not self._showSpine then
      self:_ShowBgSpine()
    end
  end)
  self._activitySubName = self:GetUIComponent("UILocalizationText", "ActivitySubName")
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._remainTime1 = self:GetUIComponent("UILocalizationText", "RemainTime1")
  self._remainTime1Suffix = self:GetUIComponent("UILocalizationText", "RemainTime1Suffix")
  self._remainTime2 = self:GetUIComponent("UILocalizationText", "RemainTime2")
  self._remainTime2Suffix = self:GetUIComponent("UILocalizationText", "RemainTime2Suffix")
  self._militaryExploitRedPoint = self:GetGameObject("MilitaryExploitRedPoint")
  self._loginAwardRedPoint = self:GetGameObject("LoginAwardRedPoint")
  self._lineMissionRedPoint = self:GetGameObject("LineMissionRedPoint")
  self._battlefieldRedPoint = self:GetGameObject("BattlefieldRedPoint")
  self._battlePassRedPoint = self:GetGameObject("BattlePassRedPoint")
  self._activityIntro = self:GetGameObject("ActivityIntro")
  self._militaryExploitBtn = self:GetGameObject("MilitaryExploitBtn")
  self._loginAwardBtn = self:GetGameObject("LoginAwardBtn")
  self._lineMissionBtn = self:GetGameObject("LineMissionBtn")
  self._battlefieldBtn = self:GetGameObject("BattlefieldBtn")
  self._battlePassBtn = self:GetGameObject("BattlePassBtn")
  self._militaryExploitValue = self:GetUIComponent("UILocalizationText", "MilitaryExploitValue")
  self._militaryExploitRankValue = self:GetUIComponent("UILocalizationText", "MilitaryExploitRankValue")
  self._mainAnimation = self:GetGameObject():GetComponent("Animation")
  self._battlePassBtnAnimation = self:GetUIComponent("Animation", "BattlePassBtn")
  self._militaryExploitBtnAnimation = self:GetUIComponent("Animation", "MilitaryExploitBtn")
  self._loginAwardBtnAnimation = self:GetUIComponent("Animation", "LoginAwardBtn")
  self._lineMissionBtnAnimation = self:GetUIComponent("Animation", "LineMissionBtn")
  self._battlefieldBtnAnimation = self:GetUIComponent("Animation", "BattlefieldBtn")
  self._btnImg = {}
  self._btnTextImg = {}
  self._btnImg[ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION] = self:GetUIComponent("RawImage", "LineMissionBtn")
  self._btnImg[ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD] = self:GetUIComponent("RawImage", "BattlefieldBtn")
  self._btnTextImg[ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION] = self:GetUIComponent("RawImage", "LineMissionBtnText")
  self._btnTextImg[ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD] = self:GetUIComponent("RawImage", "BattlefieldBtnText")
end

function UIN5MainController:_OnValue()
  self._activitySubName:SetText(StringTable.Get(self._cfg_campaign.CampaignSubtitle))
  self:_RefreshProgressItemCount()
  self:_PlayAnimation()
  CutsceneManager.ExcuteCutsceneOut()
end

local ComponentStateImgColor = {
  [true] = Color.white,
  [false] = Color(0.3, 0.3, 0.3, 1)
}
_enum("ComponentStateImgColor", ComponentStateImgColor)
local ComponentStateTextColor = {
  [true] = Color.white,
  [false] = Color(0.2, 0.2, 0.2, 1)
}
_enum("ComponentStateTextColor", ComponentStateTextColor)

function UIN5MainController:_RefreshBtnState()
  local ids = {
    ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION,
    ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD
  }
  for key, value in pairs(ids) do
    self._btnImg[value].color = ComponentStateImgColor[self._componentState[value]]
    self._btnTextImg[value].color = ComponentStateTextColor[self._componentState[value]]
  end
end

function UIN5MainController:_PlayAnimation()
  self:StartTask(function(TT)
    self:Lock("UIN5MainControllerPlayAnimation")
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN5MainController)
    self:UnLock("UIN5MainControllerPlayAnimation")
  end, self)
end

function UIN5MainController:_RefreshProgressItemCount()
  local cmpt = self._campaign:GetComponent(ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS)
  if cmpt then
    local componentInfo = cmpt:GetComponentInfo()
    local cur = componentInfo.m_current_progress
    self._militaryExploitValue:SetText(self:_MakeCurProgressText(cur))
    local cmptCfgId = cmpt:GetComponentCfgId()
    local curRank = UIActivityHelper.CalPlayerPersonProgressRank(cmptCfgId, cur)
    self._militaryExploitRankValue:SetText(curRank)
  end
end

function UIN5MainController:_MakeCurProgressText(cur)
  if cur then
    local tarNumDight = 6
    local retStr = UIActivityHelper.AddZeroFrontNum(6, cur)
    return retStr
  end
end

function UIN5MainController:_InitRedPoint()
  if self._checkRedTask then
    GameGlobal.TaskManager():KillTask(self._checkRedTask)
    self._checkRedTask = nil
  end
  self._checkRedTask = self:StartTask(function()
    local campaignData = self._campaignModule:GetN5Data()
    campaignData:RequestCampaign()
    YIELD(TT)
    self:_CheckRedPointAll()
  end)
end

function UIN5MainController:_CheckRedPointAll()
  local data = self._campaignModule:GetN5Data()
  self._militaryExploitRedPoint:SetActive(data:MilitaryExploitRedPoint())
  self._loginAwardRedPoint:SetActive(data:LoginRewardRedPoint())
  self._lineMissionRedPoint:SetActive(data:PetStageRedPoint())
  self._battlefieldRedPoint:SetActive(data:BattleFieldReSetRedPoint())
  self._battlePassRedPoint:SetActive(data:BattlePassRedPoint())
end

function UIN5MainController:_Close()
  self:SwitchState(UIStateType.UIMain)
end

function UIN5MainController:_ShowBgSpine()
  self:StartTask(function(TT)
    self:Lock("UIN5MainControllerPlayAnimation")
    local state = self._mainAnimation:get_Item("uieff_N5_Main_Hide")
    if not self._showSpine then
      state.speed = 1
      state.time = 0
    else
      state.speed = -1
      state.time = state.clip.length
    end
    self._mainAnimation.enabled = true
    self._mainAnimation:Play("uieff_N5_Main_Hide")
    YIELD(TT, 333)
    self._showSpine = not self._showSpine
    self:UnLock("UIN5MainControllerPlayAnimation")
  end, self)
end

function UIN5MainController:_ShowActivityIntro(show)
  self._activityIntro:SetActive(show)
end

function UIN5MainController:_SetRemainTime(pre_remaining, remaintime)
  self._remainTime:SetText(pre_remaining)
  local s1, s2, s3, s4 = self:_GetRemainTime(remaintime)
  self._remainTime1:SetText(UIActivityHelper.AddZeroFrontNum(2, s1))
  self._remainTime1Suffix:SetText(s2)
  self._remainTime2:SetText(UIActivityHelper.AddZeroFrontNum(2, s3))
  self._remainTime2Suffix:SetText(s4)
end

function UIN5MainController:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  if 0 < day then
    return day, StringTable.Get("str_activity_common_day"), hour, StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    return hour, StringTable.Get("str_activity_common_hour"), minute, StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    return minute, StringTable.Get("str_activity_common_minute"), "", ""
  else
    return "", StringTable.Get("str_activity_common_less_minute"), "", ""
  end
end

function UIN5MainController:_RefreshComponentState()
  self._componentState[ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD] = self:_GetComponentState(ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD)
  self._componentState[ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS] = self:_GetComponentState(ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS)
  self._componentState[ECampaignN5ComponentID.ECAMPAIGN_N5_CUMULATIVE_LOGIN] = self:_GetComponentState(ECampaignN5ComponentID.ECAMPAIGN_N5_CUMULATIVE_LOGIN)
  self._componentState[ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION] = self:_GetComponentState(ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION)
  if not self._battlepassCampaign then
    self._battlepassCampaign = UIActivityCampaign:New()
    self._battlepassCampaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  end
  self._componentState[self._battlePassTmpCmptId] = self._battlepassCampaign:CheckCampaignOpen()
end

function UIN5MainController:ActivityIntroOnClick(go)
  self:ShowDialog("UIN5Intro")
end

function UIN5MainController:MilitaryExploitBtnOnClick(go)
  self:StartTask(function(TT)
    self:Lock("UIN5MainControllerPlayAnimation")
    self:_PlayBtnClickAnim(self._militaryExploitBtnAnimation)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5NormalClick)
    YIELD(TT, self._btnClickAnimTime)
    if self:_CheckCampaignClose() or not self:_GetComponentState(ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS) then
      ToastManager.ShowToast(StringTable.Get("str_activity_common_end"))
      self:_RefreshUIInfo()
      self:UnLock("UIN5MainControllerPlayAnimation")
      return
    end
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5CloseDoor)
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIN5ProgressController, function()
      self._campaignModule:CampaignSwitchState(true, UIStateType.UIN5ProgressController, UIStateType.UIMain, {
        ECampaignType.CAMPAIGN_TYPE_N5
      }, self._campaign._id)
    end)
    self:UnLock("UIN5MainControllerPlayAnimation")
  end, self)
end

function UIN5MainController:LoginAwardBtnOnClick(go)
  self:StartTask(function(TT)
    self:Lock("UIN5MainControllerPlayAnimation")
    self:_PlayBtnClickAnim(self._loginAwardBtnAnimation)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5NormalClick)
    YIELD(TT, self._btnClickAnimTime)
    self:_ShowChildUI(ECampaignN5ComponentID.ECAMPAIGN_N5_CUMULATIVE_LOGIN, "UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N5, ECampaignN5ComponentID.ECAMPAIGN_N5_CUMULATIVE_LOGIN)
    self:UnLock("UIN5MainControllerPlayAnimation")
  end, self)
end

function UIN5MainController:LineMissionBtnOnClick(go)
  self:StartTask(function(TT)
    self:Lock("UIN5MainControllerPlayAnimation")
    self:_PlayBtnClickAnim(self._lineMissionBtnAnimation)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5NormalClick)
    YIELD(TT, self._btnClickAnimTime)
    if self:_CheckCampaignClose() or not self:_GetComponentState(ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION) then
      self:_RefreshUIInfo()
      ToastManager.ShowToast(StringTable.Get("str_activity_common_end"))
      self:UnLock("UIN5MainControllerPlayAnimation")
      return
    end
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5CloseDoor)
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIActivityN5SimpleLevel, function()
      self._campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN5SimpleLevel, UIStateType.UIMain, nil, self._campaign._id)
    end)
    self:UnLock("UIN5MainControllerPlayAnimation")
  end, self)
end

function UIN5MainController:BattlefieldBtnOnClick(go)
  self:StartTask(function(TT)
    self:Lock("UIN5MainControllerPlayAnimation")
    self:_PlayBtnClickAnim(self._battlefieldBtnAnimation)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5NormalClick)
    YIELD(TT, self._btnClickAnimTime)
    if self:_CheckCampaignClose() or not self:_GetComponentState(ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD) then
      self:_RefreshUIInfo()
      ToastManager.ShowToast(StringTable.Get("str_activity_common_end"))
      self:UnLock("UIN5MainControllerPlayAnimation")
      return
    end
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5CloseDoor)
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIActivityN5BattleField, function()
      self._campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN5BattleField, UIStateType.UIMain, nil, self._campaign._id)
    end)
    self:UnLock("UIN5MainControllerPlayAnimation")
  end, self)
end

function UIN5MainController:BattlePassBtnOnClick(go)
  self:StartTask(function(TT)
    self:Lock("UIN5MainControllerPlayAnimation")
    self:_PlayBtnClickAnim(self._battlePassBtnAnimation)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5NormalClick)
    YIELD(TT, self._btnClickAnimTime)
    UIActivityBattlePassHelper.OpenMainController()(self._battlepassCampaign)
    self:UnLock("UIN5MainControllerPlayAnimation")
  end, self)
end

function UIN5MainController:_ShowChildUI(componentid, uiName, ...)
  if self:_CheckCampaignClose() then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_activity_common_notice_title"), StringTable.Get("str_activity_common_notice_content"), function()
      self:_Close()
    end, nil)
    return
  end
  if not self._componentState[componentid] then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_end"))
    return
  end
  self:ShowDialog(uiName, ...)
end

function UIN5MainController:BgOnClick(go)
  if self._showSpine then
    self:_ShowBgSpine()
  end
end

function UIN5MainController:_PlayBtnClickAnim(animCmpt)
  if self._mainAnimation then
    self._mainAnimation.enabled = true
    self._mainAnimation:Play("uieff_N5_Main_Shock")
  end
  if animCmpt then
    animCmpt:Play("uieff_N5_Main_BtnClick")
  end
end
