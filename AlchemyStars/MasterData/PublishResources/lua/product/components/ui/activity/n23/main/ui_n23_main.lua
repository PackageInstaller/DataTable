_class("UIN23Main", UIController)
UIN23Main = UIN23Main

function UIN23Main:Constructor(ui_root_transform)
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN23Data()
  self.strsLeftTime = {
    "str_n23_left_time_d_h",
    "str_n23_left_time_d",
    "str_n23_left_time_h_m",
    "str_n23_left_time_h",
    "str_n23_left_time_m"
  }
  self.strsLineLeftTime = {
    "str_n23_line_left_time_d_h",
    "str_n23_line_left_time_d",
    "str_n23_line_left_time_h_m",
    "str_n23_line_left_time_h",
    "str_n23_line_left_time_m"
  }
  self.strsAdventureUnlockCD = {
    "str_n23_adventure_unlock_left_time_d_h",
    "str_n23_adventure_unlock_left_time_d",
    "str_n23_adventure_unlock_left_time_h_m",
    "str_n23_adventure_unlock_left_time_h",
    "str_n23_adventure_unlock_left_time_m"
  }
  self.strsAdventureCloseCD = {
    "str_n23_adventure_close_left_time_d_h",
    "str_n23_adventure_close_left_time_d",
    "str_n23_adventure_close_left_time_h_m",
    "str_n23_adventure_close_left_time_h",
    "str_n23_adventure_close_left_time_m"
  }
  self.CampaignType23 = ECampaignType.CAMPAIGN_TYPE_N23
end

function UIN23Main:LoadDataOnEnter(TT, res, uiParams)
  self.data:RequestCampaign(TT, self.CampaignType23, res)
  if res and not res:GetSucc() then
    self.mCampaign:CheckErrorCode(res.m_result, self.mCampaign._id, nil, nil)
    return
  end
  self:LoadDataOnEnter_BattlePass(TT, res)
end

function UIN23Main:LoadDataOnEnter_BattlePass(TT, res)
  self._battlepassCampaign = UIActivityCampaign:New()
  self._battlepassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN23Main:OnShow(uiParams)
  N23Data.SetPrefsMain()
  self.imgRT = uiParams[1]
  self.anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self.rt = self:GetUIComponent("RawImage", "Eff")
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtns = btns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end, nil, nil, false, function()
    self.SafeArea:SetActive(false)
  end)
  self.SafeArea = self:GetGameObject("SafeArea")
  self.imgFilm = self:GetUIComponent("Image", "BtnFilm")
  self.imgAdventure = self:GetUIComponent("Image", "BtnAdventure")
  self.imgStageNormal = self:GetUIComponent("Image", "BtnStageNormal")
  self.imgShop = self:GetUIComponent("Image", "BtnShop")
  self.imgFilmLock = self:GetGameObject("imgFilmLock")
  self.imgAdventureLock = self:GetGameObject("imgAdventureLock")
  self.imgStageNormalLock = self:GetGameObject("imgStageNormalLock")
  self.imgShopLock = self:GetGameObject("imgShopLock")
  self.redBattlePass = self:GetGameObject("redBattlePass")
  self.redAward = self:GetGameObject("redAward")
  self.redFilm = self:GetGameObject("redFilm")
  self.redAdventure = self:GetGameObject("redAdventure")
  self.redStageNormal = self:GetGameObject("redStageNormal")
  self.redShop = self:GetGameObject("redShop")
  self.newFilm = self:GetGameObject("newFilm")
  self.newAdventure = self:GetGameObject("newAdventure")
  self.newLine = self:GetGameObject("newLine")
  self.newShop = self:GetGameObject("newShop")
  self.txtStageLeftTime = self:GetUIComponent("RollingText", "txtStageLeftTime")
  self.txtLeftTimeFilm = self:GetUIComponent("RollingText", "txtLeftTimeFilm")
  self.txtLeftTimeAdventure = self:GetUIComponent("RollingText", "txtLeftTimeAdventure")
  self.txtLeftTimeStageNormal = self:GetUIComponent("RollingText", "txtLeftTimeStageNormal")
  self.imgShopIcon = self:GetUIComponent("RawImageLoader", "imgShopIcon")
  self.txtShopLow = self:GetUIComponent("UILocalizationText", "txtShopLow")
  self.txtShop = self:GetUIComponent("UILocalizationText", "txtShop")
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self.teActivity = UIActivityHelper.StartTimerEvent(self.teActivity, function()
    self:FlushCDActivity()
  end, 60000)
  self:PlayAnim(function()
    self:_CheckGuide()
  end)
  self:Flush()
end

function UIN23Main:OnHide()
  if self.imgRT then
    self.imgRT:Release()
    self.imgRT = nil
  end
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  self:CancelTimerEventNormal()
  self:CancelTimerEventAdventure()
  self.data = nil
end

function UIN23Main:CancelTimerEventNormal()
  if self.teNormal then
    GameGlobal.Timer():CancelEvent(self.teNormal)
  end
end

function UIN23Main:CancelTimerEventAdventure()
  if self.teAdventure then
    GameGlobal.Timer():CancelEvent(self.teAdventure)
  end
end

function UIN23Main:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self.data then
    local cType, cId = self.data:GetCampaignTypeId()
    if cId == campaign_id then
      self:Flush()
    end
  end
  self:FlushRedPointBattlePass()
end

function UIN23Main:Flush()
  self:FlushRedPointBattlePass()
  self:FlushRedPointAward()
  self:FlushRedPointFilm()
  self:FlushRedPointAdventure()
  self:FlushRedPointStageNormal()
  self:FlushRedPointShop()
  self:FlushStateAdventure()
  self:FlushNormalStage()
  self:FlushShop()
  self:FlushCDActivity()
end

function UIN23Main:PlayAnim(callback)
  self:StartTask(function(TT)
    if self.imgRT then
      local key = "UIN23MainPlayAnim"
      self:Lock(key)
      self.rt.texture = self.imgRT
      self.anim:Play()
      YIELD(TT, 2333)
      self:UnLock(key)
    else
      local state = self.anim:get_Item("uieff_UIN23Main_in")
      state.normalizedTime = 1
      self.anim:Play()
    end
    if callback then
      callback()
    end
  end, self)
end

function UIN23Main:FlushShop()
  local s = self.data:GetStateShop()
  if s == UISummerOneEnterBtnState.Normal then
    self.imgShopLock:SetActive(false)
  else
    self.imgShopLock:SetActive(true)
  end
  local c = self.data:GetComponentShop()
  local icon, count = c:GetCostItemIconText()
  local c1 = "#847d7b"
  local c2 = "#ffe671"
  local text = UIActivityHelper.FormatNumber_PreZero(7, count, c1, c2)
  self.txtShop:SetText(text)
  self.txtShopLow:SetText(count)
end

function UIN23Main:FlushRedPointBattlePass()
  local bShow = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  self.redBattlePass:SetActive(bShow)
end

function UIN23Main:FlushRedPointAward()
  if self.data then
    local red = self.data:CheckRedAward()
    self.redAward:SetActive(red)
  end
end

function UIN23Main:FlushRedPointFilm()
  if self.data then
    local red = self.data:CheckRedFilm()
    self.redFilm:SetActive(red)
  end
  self:FlushNewFilm()
end

function UIN23Main:FlushRedPointAdventure()
  if self.data then
    local red = self.data:CheckRedAdventure()
    self.redAdventure:SetActive(red)
  end
  self:FlushNewAdventure()
end

function UIN23Main:FlushRedPointStageNormal()
  if self.data then
    local red = self.data:CheckRedNormal()
    self.redStageNormal:SetActive(red)
  end
  self:FlushNewLine()
end

function UIN23Main:FlushRedPointShop()
  if self.data then
    local red = self.data:CheckRedShop()
    self.redShop:SetActive(red)
  end
  self:FlushNewShop()
end

function UIN23Main:FlushNewFilm()
  if self.data then
    local new = self.data:CheckNewFilm()
    self.newFilm:SetActive(new)
  end
end

function UIN23Main:FlushNewAdventure()
  if self.data then
    local new = self.data:CheckNewAdventure()
    self.newAdventure:SetActive(new)
  end
end

function UIN23Main:FlushNewLine()
  if self.data then
    local new = self.data:CheckNewLine()
    self.newLine:SetActive(new)
  end
end

function UIN23Main:FlushNewShop()
  if self.data then
    local new = self.data:CheckNewShop()
    self.newShop:SetActive(new)
  end
end

function UIN23Main:FlushCDActivity()
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local cs = self.data:GetCampaignSample()
  if nowTimestamp < cs.end_time then
    UIForge.FlushCDText(self.txtStageLeftTime, cs.end_time, self.strsLeftTime, false)
  else
    self.txtStageLeftTime:RefreshText(StringTable.Get("str_activity_finished"))
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  end
end

function UIN23Main:FlushAdventureLeftTime()
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local cInfo = self.data:GetComponentInfoAdventure()
  if nowTimestamp < cInfo.m_unlock_time then
  else
    self:CancelTimerEventAdventure()
  end
end

function UIN23Main:RegisterTimeEvent(seconds, componentId)
  if componentId == ECampaignN23ComponentID.ECAMPAIGN_N23_LINE_MISSION then
    self:CancelTimerEventNormal()
  elseif componentId == ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN then
    self:CancelTimerEventAdventure()
  else
    Log.warn("### RegisterTimeEvent componentId=", componentId)
    return
  end
  if seconds < 60 then
    seconds = 60
  end
  local ms = seconds * 1000
  local te = GameGlobal.Timer():AddEvent(ms, function()
    self:StartTask(function(TT)
      if self.data then
        self.data:RequestCampaign(TT)
        if componentId == ECampaignN23ComponentID.ECAMPAIGN_N23_LINE_MISSION then
          self:FlushNormalStage()
        elseif componentId == ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN then
          self:FlushStateAdventure()
        end
      end
    end, self)
  end)
  if componentId == ECampaignN23ComponentID.ECAMPAIGN_N23_LINE_MISSION then
    self.teNormal = te
  elseif componentId == ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN then
    self.teAdventure = te
  end
end

function UIN23Main:FlushStateAdventure()
  self.imgFilmLock:SetActive(true)
  self.imgAdventureLock:SetActive(true)
  local cInfo = self.data:GetComponentInfoAdventure()
  if not cInfo then
    Log.fatal("### cInfo nil.")
    return
  end
  local componentId = ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN
  local state = self.data:GetStateAdventure()
  if state == UISummerOneEnterBtnState.NotOpen then
    local unlockTime = cInfo.m_unlock_time
    self:RegisterTimeEvent(UICommonHelper.CalcLeftSeconds(unlockTime), componentId)
    UIForge.FlushCDText(self.txtLeftTimeAdventure, unlockTime, self.strsAdventureUnlockCD, false)
    UIForge.FlushCDText(self.txtLeftTimeFilm, unlockTime, self.strsAdventureUnlockCD, false)
  elseif state == UISummerOneEnterBtnState.Closed then
    self:CancelTimerEventAdventure()
    local strFinished = StringTable.Get("str_activity_finished")
    self.txtLeftTimeAdventure:RefreshText(strFinished)
    self.txtLeftTimeFilm:RefreshText(strFinished)
  elseif state == UISummerOneEnterBtnState.Normal then
    self.imgFilmLock:SetActive(false)
    self.imgAdventureLock:SetActive(false)
    local closeTime = cInfo.m_close_time
    self:RegisterTimeEvent(UICommonHelper.CalcLeftSeconds(closeTime), componentId)
    UIForge.FlushCDText(self.txtLeftTimeAdventure, closeTime, self.strsAdventureCloseCD, false)
    UIForge.FlushCDText(self.txtLeftTimeFilm, closeTime, self.strsAdventureCloseCD, false)
  else
    Log.fatal("### state=", state)
  end
  self:FlushRedPointFilm()
  self:FlushRedPointAdventure()
end

function UIN23Main:FlushNormalStage()
  self.imgStageNormalLock:SetActive(true)
  local cInfo = self.data:GetComponentInfoNormal()
  if not cInfo then
    Log.fatal("### GetComponentInfoNormal nil.")
    return
  end
  local componentId = ECampaignN23ComponentID.ECAMPAIGN_N23_LINE_MISSION
  local state = self.data:GetStateNormal()
  if state == UISummerOneEnterBtnState.NotOpen then
  elseif state == UISummerOneEnterBtnState.Closed then
    self:CancelTimerEventNormal()
    self.txtLeftTimeStageNormal:RefreshText(StringTable.Get("str_activity_finished"))
  elseif state == UISummerOneEnterBtnState.Normal then
    self.imgStageNormalLock:SetActive(false)
    local closeTime = cInfo.m_close_time
    local leftSeconds = UICommonHelper.CalcLeftSeconds(closeTime)
    self:RegisterTimeEvent(leftSeconds, componentId)
    UIForge.FlushCDText(self.txtLeftTimeStageNormal, closeTime, self.strsLineLeftTime, false)
  else
    Log.fatal("### state=", state)
  end
  self:FlushRedPointStageNormal()
end

function UIN23Main:BgOnClick(go)
  self.SafeArea:SetActive(true)
end

function UIN23Main:BtnIntroOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN23Intro")
end

function UIN23Main:BtnBattlePassOnClick(go)
  UIActivityBattlePassHelper.OpenMainController()(self._battlepassCampaign)
end

function UIN23Main:BtnLoginAwardOnClick(go)
  self:ShowDialog("UIActivityTotalLoginAwardController", false, self.CampaignType23, ECampaignN23ComponentID.ECAMPAIGN_N23_CUMULATIVE_LOGIN)
end

function UIN23Main:BtnFilmOnClick(go)
  local state = self.data:GetStateAdventure()
  if self:CheckComponentState(state) then
    self:ShowDialog("UIN23Movie")
    N23Data.SetPrefsFilm()
    self:FlushNewFilm()
  end
end

function UIN23Main:BtnAdventureOnClick(go)
  self:ShowDialog("UIHomelandStoryTaskSimpleController", 1, self.CampaignType23, ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN)
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  self:StartTask(function(TT)
    local res = homelandModule:HomelandStoryTaskMoudleUnlockReq()
    if res:GetSucc() then
      res = homelandModule:HomelandStoryTaskUnlockReq(TT, 3)
      if res:GetSucc() then
        Log.info("UIN23Main:BtnAdventureOnClick() Success, id = ", 3)
      else
        Log.fatal("UIN23Main:BtnAdventureOnClick() error, id = ", 3)
      end
    end
  end, self)
  N23Data.SetPrefsAdventure()
  self:FlushNewAdventure()
end

function UIN23Main:BtnStageNormalOnClick(go)
  local state = self.data:GetStateNormal()
  if self:CheckComponentState(state) then
    self:SwitchState(UIStateType.UIN23Line)
  end
end

function UIN23Main:BtnShopOnClick(go)
  local cType, cId = self.data:GetCampaignTypeId()
  ClientCampaignShop.OpenCampaignShop(cType, cId)
end

function UIN23Main:CheckComponentState(btnState)
  if btnState == UISummerOneEnterBtnState.Normal then
    return true
  end
  local errType = 0
  if btnState == UISummerOneEnterBtnState.NotOpen then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
  elseif btnState == UISummerOneEnterBtnState.Closed then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
  end
  self.mCampaign:ShowErrorToast(errType, true)
  return false
end

function UIN23Main:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN23Main)
end
