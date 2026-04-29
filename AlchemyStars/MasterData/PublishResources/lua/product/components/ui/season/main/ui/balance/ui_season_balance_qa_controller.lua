_class("UISeasonBalanceQAController", UIController)
UISeasonBalanceQAController = UISeasonBalanceQAController

function UISeasonBalanceQAController:GetComponents()
  self._pool = self:GetUIComponent("UISelectObjectPath", "a_pool")
  self._qTex = self:GetUIComponent("UILocalizationText", "q")
  self._stepCount = 3
  self._steps = {}
  for i = 1, self._stepCount do
    local imgGo = self:GetGameObject("img" .. i)
    self._steps[i] = imgGo
  end
  self._qaPanel = self:GetGameObject("qa")
  self._resultPanel = self:GetGameObject("result")
  self._resultLastPanel = self:GetGameObject("resultLastPanel")
  self._resultSuccPanel = self:GetGameObject("resultSuccPanel")
  self._resultFailPanel = self:GetGameObject("resultFailPanel")
  self._resultSuccDesc = self:GetUIComponent("UILocalizationText", "resultSuccDesc")
  self._resultFailDesc = self:GetUIComponent("UILocalizationText", "resultFailDesc")
  self._qaAndResultPanel = self:GetGameObject("qaAndResult")
  self._evidencePanel = self:GetGameObject("evidence")
  self._evidenceTypePool = self:GetUIComponent("UISelectObjectPath", "evidenceTypePool")
  self._evidencePool = self:GetUIComponent("UISelectObjectPath", "evidencePool")
  self._balanceSpine = self:GetUIComponent("SpineLoader", "balanceImg")
  self._balanceSpine:LoadSpine("tianping_spine_idle")
  self._idx2anim = {
    [1] = "incline1",
    [2] = "incline2",
    [3] = "incline3"
  }
  self._idx2idleAnim = {
    [1] = "idle1",
    [2] = "idle2",
    [3] = "idle3"
  }
  self._spineSke = self._balanceSpine.CurrentSkeleton
  if not self._spineSke then
    self._spineSke = self._balanceSpine.CurrentMultiSkeleton
  end
  local backBtn = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self._backBtn = backBtn:SpawnObject("UISeasonTopBtn")
  self._backBtn:SetData(function()
    self:ClosePanel()
  end)
  self._a_result_pool = self:GetUIComponent("UISelectObjectPath", "a_result_pool")
  self._atlas = self:GetAsset("UIS2Balance.spriteAtlas", LoadType.SpriteAtlas)
  self._anim = self:GetUIComponent("Animation", "SafeArea")
  self.evidenceBtnObj = self:GetGameObject("EvidenceBtn")
end

function UISeasonBalanceQAController:OnShow(uiParams)
  self._finish = false
  self._closeCallback = uiParams[2]
  self:GetComponents()
  self._balanceID = uiParams[1]
  self._qaIdx = 1
  self._cfg_balance = Cfg.cfg_season_balance[self._balanceID]
  self._qas = self._cfg_balance.QAList
  self._panelType = 1
  self._evidenceTypeID = 1
  self:ShowQAInfo(true)
  self:ShowEvidenceInfo()
  self:ShowTypePanel()
  self:ShowQaAndAnswerInAnim()
end

function UISeasonBalanceQAController:ShowQaAndAnswerInAnim()
  local animName = "uieffanim_UISeasonBalanceQAController_anser_in"
  self._anim:Stop()
  self._anim:Play(animName)
end

function UISeasonBalanceQAController:ChooseAnswer(succ, cfg, idx)
  self:ShowResult(succ, cfg, idx)
end

function UISeasonBalanceQAController:ShowResult(succ, cfg, idx)
  self._qaPanel:SetActive(false)
  self._resultPanel:SetActive(true)
  self._resultLastPanel:SetActive(false)
  self._resultSuccPanel:SetActive(false)
  self._resultFailPanel:SetActive(false)
  if succ then
    self:PlaySpineAnim()
    if #self._qas == self._qaIdx then
      self._finish = true
      self._resultLastPanel:SetActive(true)
      self:ShowResultLastPanel(cfg, idx)
    else
      self._resultSuccPanel:SetActive(true)
      self:ShowResultSuccPanel(cfg, idx)
    end
    self._qaIdx = self._qaIdx + 1
  else
    self._resultFailPanel:SetActive(true)
    self:ShowResultFailPanel(cfg, idx)
  end
  local animName = "uieffanim_UISeasonBalanceQAController_anser_click_02"
  self._anim:Stop()
  self._anim:Play(animName)
  if self._resultAnimTimer then
    GameGlobal.Timer():CancelEvent(self._resultAnimTimer)
  end
  self:Lock("ShowResultAnim")
  self._resultAnimTimer = GameGlobal.Timer():AddEvent(1200, function()
    self:UnLock("ShowResultAnim")
  end)
  self:SetStepUI()
end

function UISeasonBalanceQAController:ShowResultLastPanel(cfg, idx)
  if not self._a_result_item then
    self._a_result_item = self._a_result_pool:SpawnObject("UISeasonBalanceQA_Answer")
  end
  self._a_result_item:SetDataOnlyDesc(StringTable.Get("str_season_s2_clear_title"))
end

function UISeasonBalanceQAController:ShowResultSuccPanel(cfg, idx)
  if not self._a_result_item then
    self._a_result_item = self._a_result_pool:SpawnObject("UISeasonBalanceQA_Answer")
  end
  self._a_result_item:SetData(idx, cfg)
end

function UISeasonBalanceQAController:ShowResultFailPanel(cfg, idx)
  if not self._a_result_item then
    self._a_result_item = self._a_result_pool:SpawnObject("UISeasonBalanceQA_Answer")
  end
  self._a_result_item:SetData(idx, cfg)
end

function UISeasonBalanceQAController:ResultFailBtnOnClick(go)
  self:ShowQAInfo()
end

function UISeasonBalanceQAController:ResultSuccBtnOnClick(go)
  self:ShowQAInfo()
end

function UISeasonBalanceQAController:ShowQAInfo(hideAnim)
  self._qaPanel:SetActive(true)
  self._resultPanel:SetActive(false)
  local currentQA = self._qas[self._qaIdx]
  local qaCfg = Cfg.cfg_season_balance_qa[currentQA]
  local question = qaCfg.Question
  local answers = qaCfg.Answers
  self._qTex:SetText(StringTable.Get(question))
  self._pool:SpawnObjects("UISeasonBalanceQA_Answer", #answers)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #answers do
    local item = pools[i]
    item:SetData(i, qaCfg, function(succ, cfg, idx)
      self:ChooseAnswer(succ, cfg, idx)
    end)
  end
  self:SetStepUI()
  if not hideAnim then
    local animName = "uieffanim_UISeasonBalanceQAController_anser_click_03"
    self._anim:Stop()
    self._anim:Play(animName)
    self:Lock("ShowQAInfoAnim")
    if self._showInfoTime then
      GameGlobal.Timer():CancelEvent(self._showInfoTime)
    end
    self._showInfoTime = GameGlobal.Timer():AddEvent(1000, function()
      self:UnLock("ShowQAInfoAnim")
    end)
    local waitTime = 300
    local pools = self._pool:GetAllSpawnList()
    for i = 1, #pools do
      local item = pools[i]
      local yieldTime = (i - 1) * 200 + waitTime
      item:PlayAnim(yieldTime)
    end
  end
end

function UISeasonBalanceQAController:SetStepUI()
  for i = 1, self._stepCount do
    local img = self._steps[i]
    img:SetActive(i <= #self._qas)
    local spriteName
    if i < self._qaIdx then
      spriteName = "exp_s2_tp_icon04"
    else
      spriteName = "exp_s2_tp_icon05"
    end
    img:GetComponent("Image").sprite = self._atlas:GetSprite(spriteName)
  end
end

function UISeasonBalanceQAController:PlaySpineAnim()
  local lastIdx = self._qaIdx
  local animName = self._idx2anim[lastIdx]
  if string.isnullorempty(animName) then
    Log.error("###[UISeasonBalanceQAController] animName is nil ! lastIdx:", lastIdx)
  else
    local entry = self._spineSke.AnimationState:SetAnimation(0, animName, false)
    self._balanceSpine.AnimationState.Data.DefaultMix = 0
    self._spineSke:Update(0)
    if not entry then
      return
    end
    local anim = entry.Animation
    local duration = anim.Duration
    local yieldTime = math.floor(duration * 1000) - 675
    if self._spineAnimEvent then
      GameGlobal.Timer():CancelEvent(self._spineAnimEvent)
      self._spineAnimEvent = nil
    end
    self._spineAnimEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
      local idleAnimName = self._idx2idleAnim[lastIdx]
      self._spineSke.AnimationState:SetAnimation(0, idleAnimName, true)
      self._balanceSpine.AnimationState.Data.DefaultMix = 0
      self._spineSke:Update(0)
    end)
  end
end

function UISeasonBalanceQAController:ClosePanel()
  if self._closeCallback then
    self._closeCallback(self._finish)
  end
  self:CloseDialog()
end

function UISeasonBalanceQAController:OnHide()
  if self._spineAnimEvent then
    GameGlobal.Timer():CancelEvent(self._spineAnimEvent)
    self._spineAnimEvent = nil
  end
  if self._taskid then
    GameGlobal.TaskManager():KillTask(self._taskid)
  end
  if self._showInfoTime then
    GameGlobal.Timer():CancelEvent(self._showInfoTime)
  end
  if self._resultAnimTimer then
    GameGlobal.Timer():CancelEvent(self._resultAnimTimer)
  end
  self:UnLock("ShowResultAnim")
  self:UnLock("ShowTypePanelAnim")
  self:UnLock("ShowQAInfoAnim")
  self:UnLock("EvidenceBtnOnClickAnim")
  self:UnLock("EvidenceBtnOnClickAnim")
end

function UISeasonBalanceQAController:ShowTypePanel(hideAnim)
  self._qaAndResultPanel:SetActive(self._panelType == 1)
  self._evidencePanel:SetActive(self._panelType == 2)
  if not hideAnim then
    self:Lock("ShowTypePanelAnim")
    if self._taskid then
      GameGlobal.TaskManager():KillTask(self._taskid)
    end
    self._taskid = self:StartTask(function(TT)
      local animName = self._panelType == 1 and "uieffanim_UISeasonBalanceQAController_anser_in" or "uieffanim_UISeasonBalanceQAController_evidence_in"
      local animTime = self._panelType == 1 and 667 or 733
      self._anim:Stop()
      self._anim:Play(animName)
      if self._panelType == 1 then
        local pools = self._pool:GetAllSpawnList()
        local waitTime = 300
        for i = 1, #pools do
          local item = pools[i]
          local yieldTime = (i - 1) * 200 + waitTime
          item:PlayAnim(yieldTime)
        end
      end
      local lockTime
      if self._panelType == 1 then
        lockTime = animTime + 1000
      else
        lockTime = animTime
      end
      YIELD(TT, lockTime)
      self:UnLock("ShowTypePanelAnim")
    end, self)
  end
end

function UISeasonBalanceQAController:EvidenceBtnOnClick(go)
  self:Lock("EvidenceBtnOnClickAnim")
  if self._taskid then
    GameGlobal.TaskManager():KillTask(self._taskid)
  end
  self._taskid = self:StartTask(function(TT)
    local animName = "uieffanim_UISeasonBalanceQAController_anser_click_01"
    self._anim:Stop()
    self._anim:Play(animName)
    YIELD(TT, 300)
    self:UnLock("EvidenceBtnOnClickAnim")
    self._panelType = 2
    self:ShowTypePanel()
    self._evidenceTypeID = 1
    self:OnEvidenceTypeClick(1, self._evidenceTypeID)
    local e_type_pools = self._evidenceTypePool:GetAllSpawnList()
    for i = 1, #self._cfg_evidenceTypes do
      local item = e_type_pools[i]
      local yieldTime = (i - 1) * 4 * 20
      item:PlayAnim(yieldTime)
    end
    local pools = self._evidencePool:GetAllSpawnList()
    for i = 1, #pools do
      local item = pools[i]
      local yieldTime = (i - 1) * 3 * 20
      item:PlayAnim(yieldTime)
    end
  end, self)
end

function UISeasonBalanceQAController:QaAndResultBtnOnClick(go)
  self:Lock("QaAndResultBtnOnClickAnim")
  if self._taskid then
    GameGlobal.TaskManager():KillTask(self._taskid)
  end
  self._taskid = self:StartTask(function(TT)
    local animName = "uieffanim_UISeasonBalanceQAController_evidence_click"
    self._anim:Stop()
    self._anim:Play(animName)
    YIELD(TT, 400)
    self:UnLock("QaAndResultBtnOnClickAnim")
    self._panelType = 1
    self:ShowTypePanel()
  end)
end

function UISeasonBalanceQAController:ShowEvidenceInfo()
  local cfg_balance = Cfg.cfg_season_balance[self._balanceID]
  self._evidences = cfg_balance.EvidenceList
  self._cfg_evidenceTypes = Cfg.cfg_season_evidence_type({})
  self._evidenceTypePool:SpawnObjects("UISeasonBalanceQAEvidenceType", #self._cfg_evidenceTypes)
  local e_type_pools = self._evidenceTypePool:GetAllSpawnList()
  for i = 1, #self._cfg_evidenceTypes do
    local item = e_type_pools[i]
    item:SetData(i, self._cfg_evidenceTypes[i], function(idx, typeID)
      self:OnEvidenceTypeClick(idx, typeID)
    end)
  end
  for i = 1, #self._cfg_evidenceTypes do
    local item = e_type_pools[i]
    item:Select(1)
  end
  self:ShowEvidenceList()
end

function UISeasonBalanceQAController:OnEvidenceTypeClick(idx, typeID)
  self._evidenceTypeID = typeID
  self:ShowEvidenceList()
  local e_type_pools = self._evidenceTypePool:GetAllSpawnList()
  for i = 1, #self._cfg_evidenceTypes do
    local item = e_type_pools[i]
    item:Select(idx)
  end
end

function UISeasonBalanceQAController:ShowEvidenceList()
  local showEvidences = {}
  if self._evidences == nil or #self._evidences == 0 then
    if self.evidenceBtnObj then
      self.evidenceBtnObj:SetActive(false)
    end
    return
  end
  for key, value in pairs(self._evidences) do
    local cfg_evidence = Cfg.cfg_season_evidence[value]
    local type = cfg_evidence.EvidenceType
    if type == self._evidenceTypeID then
      table.insert(showEvidences, cfg_evidence)
    end
  end
  self._evidencePool:SpawnObjects("UISeasonBalanceQAEvidence", #showEvidences)
  local pools = self._evidencePool:GetAllSpawnList()
  for i = 1, #showEvidences do
    local item = pools[i]
    item:SetData(i, showEvidences[i])
  end
end

function UISeasonBalanceQAController:ResultLastBtnOnClick()
  self:ClosePanel()
end
