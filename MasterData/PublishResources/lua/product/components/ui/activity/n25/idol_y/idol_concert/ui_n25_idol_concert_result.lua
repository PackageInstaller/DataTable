_class("UIN25IdolConcertResult", UIController)
UIN25IdolConcertResult = UIN25IdolConcertResult

function UIN25IdolConcertResult:Constructor()
end

function UIN25IdolConcertResult:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, function()
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
  self.component = self._campaign:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
end

function UIN25IdolConcertResult:OnShow(uiParams)
  self.succ = uiParams[1]
  self.currentTurn = uiParams[2]
  self.gapFansNumber = uiParams[3]
  self.callback = uiParams[4]
  CutsceneManager.ExcuteCutsceneOut()
  self:GetComponents()
  self:OnValue()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN25IdolCheckState, self:GetName())
end

function UIN25IdolConcertResult:GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self.backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self.backBtns:SetData(function()
    self:Close()
  end, nil, nil, true)
  self.spineRect = self:GetUIComponent("RectTransform", "spine")
  self.spine = self:GetUIComponent("SpineLoader", "spine")
  self.succC = self:GetGameObject("succC")
  self.failC = self:GetGameObject("failC")
  self.succGo = self:GetGameObject("succ")
  self.failGo = self:GetGameObject("fail")
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.gapFans = self:GetUIComponent("UILocalizationText", "gapFans")
  self.succDesc1 = self:GetUIComponent("UILocalizationText", "succDesc1")
  self.succDesc2 = self:GetUIComponent("UILocalizationText", "succDesc2")
  self.failDesc1 = self:GetUIComponent("UILocalizationText", "failDesc1")
  self.failDesc2 = self:GetUIComponent("UILocalizationText", "failDesc2")
  self.anim = self:GetUIComponent("Animation", "Center")
end

function UIN25IdolConcertResult:OnValue()
  local type, spine, title, offset, inAnim, loopAnim, yieldTime
  if self.succ then
    type = UIIdolResultType.ConcertSucc
    spine = "n25_g_win_spine_idle"
    title = "str_n25_idol_y_concert_succ_title"
    offset = Vector2(-283, -170)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N25IdolSuccess)
    inAnim = "uieff_UIN25IdolConcertResult_succC_in"
    yieldTime = 500
    loopAnim = "uieff_UIN25IdolConcertResult_succC_loop"
  else
    type = UIIdolResultType.ConcertFail
    spine = "n25_g_fail_spine_idle"
    title = "str_n25_idol_y_concert_fail_title"
    offset = Vector2(-283, -219)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioLose)
    inAnim = "uieff_UIN25IdolConcertResult_failc_in"
    yieldTime = 1000
    loopAnim = "uieff_UIN25IdolConcertResult_failc_loop"
  end
  self:Lock("UIN25IdolConcertResult:InAnim")
  self.anim:Play(inAnim)
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
  end
  self.event = GameGlobal.Timer():AddEvent(yieldTime, function()
    self:UnLock("UIN25IdolConcertResult:InAnim")
    self.anim:Play(loopAnim)
  end)
  self:ConcertFailReq()
  self.gapFans:SetText(self.gapFansNumber)
  self.spineRect.anchoredPosition = offset
  self.spine:LoadSpine(spine)
  self.title:SetText(StringTable.Get(title))
  self.succC:SetActive(self.succ)
  self.failC:SetActive(not self.succ)
  self.succGo:SetActive(self.succ)
  self.failGo:SetActive(not self.succ)
  local cfgs = Cfg.cfg_n25_concert({
    Turn = self.currentTurn
  })
  if cfgs and table.count(cfgs) > 0 then
    self.cfg = cfgs[1]
    local desc1, desc2
    if self.succ then
      desc1 = self.cfg.Desc1
      desc2 = self.cfg.Desc2
    else
      desc1 = self.cfg.Desc1
      desc2 = self.cfg.Desc2
    end
    local s_desc1 = self.cfg.SuccDesc1
    local s_desc2 = self.cfg.SuccDesc2
    local f_desc1 = self.cfg.FailDesc1
    local f_desc2 = self.cfg.FailDesc2
    self.succDesc1:SetText(StringTable.Get(s_desc1) or "")
    self.succDesc2:SetText(StringTable.Get(s_desc2) or "")
    self.failDesc1:SetText(StringTable.Get(f_desc1) or "")
    self.failDesc2:SetText(StringTable.Get(f_desc2) or "")
  else
    Log.error("###[UIN25IdolConcertResult] cfgs is nil! turn :", self.currentTurn)
  end
end

function UIN25IdolConcertResult:ConcertFailReq()
  GameGlobal.TaskManager():StartTask(self.SendReq, self)
end

function UIN25IdolConcertResult:SendReq(TT)
  self:Lock("UIN25IdolConcertResult:SendReq")
  local res = AsyncRequestRes:New()
  self.component:HandleIdolConcertFail(TT, res, self.succ)
  self:UnLock("UIN25IdolConcertResult:SendReq")
  if res:GetSucc() then
    Log.debug("###[UIN25IdolConcertResult] HandleIdolConcertFail succ ")
  else
    local result = res:GetResult()
    Log.fatal("###[UIN25IdolConcertResult] HandleIdolConcertFail fail ,result:", result)
  end
end

function UIN25IdolConcertResult:BgOnClick(go)
  self:Close()
end

function UIN25IdolConcertResult:Close()
  local after = self.cfg.AfterStory
  if after and self.succ then
    self:ShowDialog("UIN25IdolStoryController", after, function()
      self:Over()
    end)
  else
    self:Over()
  end
end

function UIN25IdolConcertResult:OnHide()
  self:UnLock("UIN25IdolConcertResult:InAnim")
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
  end
  if self.callback then
    self.callback()
  end
end

function UIN25IdolConcertResult:Over()
  local type = self.cfg.Type
  if type == 2 then
    CutsceneManager.ExcuteCutsceneIn("UIN25Idol_Common_Switch", function()
      self:ShowDialog("UIN25IdolSumUp")
    end)
  elseif self.succ then
    CutsceneManager.ExcuteCutsceneIn("UIN25Idol_Common_Switch", function()
      self:CloseDialog()
      CutsceneManager.ExcuteCutsceneOut()
    end)
  else
    self:SwitchState(UIStateType.UIN25IdolLogin)
  end
end
