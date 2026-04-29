_class("UIN25IdolConcert", UIController)
UIN25IdolConcert = UIN25IdolConcert

function UIN25IdolConcert:Constructor()
  self.bgSpine = "n25_g_beijing_spine_idle"
  self.otherSpine = "n25_g_banwu_spine_idle"
  self.frontSpine = "n25_g_caidai_spine_idle"
  self.spineAnimName1 = "kaichang"
  self.spineAnimName2 = "dance"
  self.spineAnimName3 = "idle"
  self.spineLength = 14500
end

function UIN25IdolConcert:OnShow(uiParams)
  self.currentTurn = uiParams[1]
  self._lastBGMResName = AudioHelperController.GetCurrentBgm()
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMN25Idol, AudioConstValue.BGMCrossFadeTime)
  if not self.currentTurn then
    local info = self.component:GetComponentInfo()
    local break_info = info.break_info
    self.currentTurn = break_info.round_index
  end
  local cfgs = Cfg.cfg_n25_concert({
    Turn = self.currentTurn
  })
  Log.debug("###[UIN25IdolConcert] OnShow ! id --> ", self.currentTurn)
  self.cfg = cfgs[1]
  self:GetComponents()
  self:OnValue()
end

function UIN25IdolConcert:GetComponents()
  self.spine = self:GetUIComponent("SpineLoader", "spine")
  self.bgSpineLoader = self:GetUIComponent("SpineLoader", "bgSpine")
  self.frontSpineLoader = self:GetUIComponent("SpineLoader", "frontSpine")
  self.frontSpineLoaderGo = self:GetGameObject("frontSpine")
  self.otherSpines = {}
  local otherSpine1 = self:GetUIComponent("SpineLoader", "otherSpine1")
  table.insert(self.otherSpines, otherSpine1)
  local otherSpine2 = self:GetUIComponent("SpineLoader", "otherSpine2")
  table.insert(self.otherSpines, otherSpine2)
  local otherSpine3 = self:GetUIComponent("SpineLoader", "otherSpine3")
  table.insert(self.otherSpines, otherSpine3)
  local otherSpine4 = self:GetUIComponent("SpineLoader", "otherSpine4")
  table.insert(self.otherSpines, otherSpine4)
end

function UIN25IdolConcert:OnValue()
  CutsceneManager.ExcuteCutsceneOut()
  self:Play()
end

function UIN25IdolConcert:LoadSpine()
  for key, value in pairs(self.otherSpines) do
    value:LoadSpine(self.otherSpine)
  end
  self.bgSpineLoader:LoadSpine(self.bgSpine)
  self.frontSpineLoader:LoadSpine(self.frontSpine)
  self.spineName = self.cfg.Spine
  self.spine:LoadSpine(self.spineName)
  if self.spine.CurrentSkeleton then
    self.skeleton = self.spine.CurrentSkeleton
  else
    self.skeleton = self.spine.CurrentMultiSkeleton
  end
  if not self.skeleton then
    Log.fatal("###[UIN25IdolConcert] skeleton is nil ! name --> ", self.spineName)
  end
  if self.bgSpineLoader.CurrentSkeleton then
    self.bgSkeleton = self.bgSpineLoader.CurrentSkeleton
  else
    self.bgSkeleton = self.bgSpineLoader.CurrentMultiSkeleton
  end
  if not self.bgSkeleton then
    Log.fatal("###[UIN25IdolConcert] bg skeleton is nil ! name --> ", self.bgSpine)
  end
  if self.frontSpineLoader.CurrentSkeleton then
    self.frontSkeleton = self.frontSpineLoader.CurrentSkeleton
  else
    self.frontSkeleton = self.frontSpineLoader.CurrentMultiSkeleton
  end
  if not self.frontSkeleton then
    Log.fatal("###[UIN25IdolConcert] front skeleton is nil ! name --> ", self.frontSpine)
  end
  self.otherSkeletons = {}
  for key, value in pairs(self.otherSpines) do
    local otherSkeleton
    if value.CurrentSkeleton then
      otherSkeleton = value.CurrentSkeleton
    else
      otherSkeleton = value.CurrentMultiSkeleton
    end
    if not otherSkeleton then
      Log.fatal("###[UIN25IdolConcert] other skeleton is nil ! name --> ", self.otherSpine)
    end
    table.insert(self.otherSkeletons, otherSkeleton)
  end
end

function UIN25IdolConcert:Play()
  self:LoadSpine()
  self:PlaySpineAnim1()
  local yieldTime = self.spineLength
  GameGlobal.Timer():AddEvent(yieldTime, function()
    CutsceneManager.ExcuteCutsceneIn("UIN25Idol_Common_Switch", function()
      self:Result()
    end)
  end)
end

function UIN25IdolConcert:PlaySpineAnim1()
  self.frontSpineLoaderGo:SetActive(false)
  local yieldTime
  local tmpTime = self:SetSpineAnimation(self.skeleton, self.spineName, self.spineAnimName1)
  yieldTime = yieldTime or tmpTime
  local tmpTime = self:SetSpineAnimation(self.bgSkeleton, self.bgSpine, self.spineAnimName1)
  yieldTime = yieldTime or tmpTime
  for key, value in pairs(self.otherSkeletons) do
    local tmpTime = self:SetSpineAnimation(value, self.otherSpine, self.spineAnimName1)
    yieldTime = yieldTime or tmpTime
  end
  if yieldTime then
    Log.debug("###[UIN25IdolConcert] PlaySpineAnim1 name:", self.spineAnimName1, " yieldTime:", yieldTime)
    GameGlobal.Timer():AddEvent(yieldTime, function()
      self:PlaySpineAnim2()
    end)
  end
end

function UIN25IdolConcert:PlaySpineAnim2()
  self.frontSpineLoaderGo:SetActive(true)
  local yieldTime
  local tmpTime = self:SetSpineAnimation(self.skeleton, self.spineName, self.spineAnimName2)
  yieldTime = yieldTime or tmpTime
  local tmpTime = self:SetSpineAnimation(self.bgSkeleton, self.bgSpine, self.spineAnimName2)
  yieldTime = yieldTime or tmpTime
  local tmpTime = self:SetSpineAnimation(self.frontSkeleton, self.frontSpine, self.spineAnimName2)
  yieldTime = yieldTime or tmpTime
  for key, value in pairs(self.otherSkeletons) do
    local tmpTime = self:SetSpineAnimation(value, self.otherSpine, self.spineAnimName2)
    yieldTime = yieldTime or tmpTime
  end
  if yieldTime then
    Log.debug("###[UIN25IdolConcert] PlaySpineAnim2 name:", self.spineAnimName2, " yieldTime:", yieldTime)
  end
end

function UIN25IdolConcert:PlaySpineAnim3()
  self.frontSpineLoaderGo:SetActive(false)
  local yieldTime
  local tmpTime = self:SetSpineAnimation(self.skeleton, self.spineName, self.spineAnimName3)
  yieldTime = yieldTime or tmpTime
  local tmpTime = self:SetSpineAnimation(self.bgSkeleton, self.bgSpine, self.spineAnimName3)
  yieldTime = yieldTime or tmpTime
  for key, value in pairs(self.otherSkeletons) do
    local tmpTime = self:SetSpineAnimation(value, self.otherSpine, self.spineAnimName3)
    yieldTime = yieldTime or tmpTime
  end
  if yieldTime then
    Log.debug("###[UIN25IdolConcert] PlaySpineAnim3 name:", self.spineAnimName3, " yieldTime:", yieldTime)
  end
end

function UIN25IdolConcert:SetSpineAnimation(spineSke, spinename, spineAnim)
  local entry
  
  local function playAniSpineFunc()
    spineSke:Initialize(true)
    entry = spineSke.AnimationState:SetAnimation(0, spineAnim, false)
  end
  
  local succ = pcall(playAniSpineFunc)
  if not succ then
    Log.error("###[UIN25IdolConcert] set spine anim fail ! spine[", spinename, "] anim[", spineAnim, "]")
    return
  end
  if not entry then
    Log.error("###[UIN25IdolConcert] entry is nil ! spine[", spinename, "] anim[", spineAnim, "]")
    return
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  return yieldTime
end

function UIN25IdolConcert:Result()
  CutsceneManager.ExcuteCutsceneIn("UIN25Idol_Common_Switch", function()
    self:ShowDialog("UIN25IdolConcertResult", true, self.currentTurn, 0, function()
      local type = self.cfg.Type
      if type == 1 then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.N25IdolGameNextDay, true, false)
      end
      self:CloseDialog()
    end)
  end)
end

function UIN25IdolConcert:FinishEnding(id, callback)
  GameGlobal.TaskManager():StartTask(self.OnFinishEnding, self, id, callback)
end

function UIN25IdolConcert:OnFinishEnding(TT, id, callback)
  self:Lock("UIN25IdolConcert:OnFinishEnding")
  local res = AsyncRequestRes:New()
  Log.debug("###[UIN25IdolConcert] HandleIdolComplateEnding id :", id)
  self.component:HandleIdolComplateEnding(TT, res, id)
  self:UnLock("UIN25IdolConcert:OnFinishEnding")
  local succ
  if res:GetSucc() then
    succ = true
    Log.debug("###[UIN25IdolConcert] HandleIdolComplateEnding succ !")
  else
    succ = false
    local result = res:GetResult()
    Log.fatal("###[UIN25IdolConcert] HandleIdolComplateEnding fail ! result:", result)
  end
  if callback then
    callback(succ, res)
  end
end

function UIN25IdolConcert:LoadDataOnEnter(TT, res, uiParams)
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

function UIN25IdolConcert:CheckOptionCantClick(condition)
  local conditionTab = condition
  for key, value in pairs(condition) do
    if not self.component:UI_IsFinishAgreedEvent(value) then
      return true
    end
  end
  return false
end

function UIN25IdolConcert:OnHide()
  AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
end
