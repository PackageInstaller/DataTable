require("guide_svc_r")
_class("GuideServiceListenerRender", GameEventListener)
GuideServiceListenerRender = GuideServiceListenerRender

function GuideServiceListenerRender:Constructor(guide_service)
  self._guide_service = guide_service
  self._eventDispatcher = guide_service._eventDispatcher
end

function GuideServiceListenerRender:RegEvents()
  self._eventDispatcher:AddListener(GameEventType.ShowGuideStep, self)
  self._eventDispatcher:AddListener(GameEventType.PauseGuideWeakLine, self)
  self._eventDispatcher:AddListener(GameEventType.FinishGuideWeakLine, self)
  self._eventDispatcher:AddListener(GameEventType.FinishGuideStep, self)
  self._eventDispatcher:AddListener(GameEventType.GuideYield, self)
  self._eventDispatcher:AddListener(GameEventType.GuideActiveSkill, self)
  self._eventDispatcher:AddListener(GameEventType.GuideChangeGhostLayer, self)
  self._eventDispatcher:AddListener(GameEventType.GuideYieldBreak, self)
end

function GuideServiceListenerRender:UnregEvents()
  self._eventDispatcher:RemoveListener(GameEventType.ShowGuideStep, self.listenerID)
  self._eventDispatcher:RemoveListener(GameEventType.PauseGuideWeakLine, self.listenerID)
  self._eventDispatcher:RemoveListener(GameEventType.FinishGuideWeakLine, self.listenerID)
  self._eventDispatcher:RemoveListener(GameEventType.FinishGuideStep, self.listenerID)
  self._eventDispatcher:RemoveListener(GameEventType.GuideYield, self.listenerID)
  self._eventDispatcher:RemoveListener(GameEventType.GuideActiveSkill, self.listenerID)
  self._eventDispatcher:RemoveListener(GameEventType.GuideChangeGhostLayer, self.listenerID)
  self._eventDispatcher:RemoveListener(GameEventType.GuideYieldBreak, self.listenerID)
end

function GuideServiceListenerRender:OnGameEvent(gameEventType, param)
  if gameEventType == GameEventType.ShowGuideStep then
    local guideStep = param
    local guideType = guideStep and guideStep.data.guideType
    local guideParam = guideStep and guideStep.guideParam
    if guideType == GuideType.Line then
      self._guide_service:ShowGuideLine(guideParam)
    elseif guideType == GuideType.Piece then
      self._guide_service:ShowGuidePiece(guideParam)
    elseif guideType == GuideType.StoryBanner then
    elseif guideType == GuideType.Warn then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowGuideWarn, guideParam)
    elseif guideType == GuideType.Pop then
    elseif guideType == GuideType.Circle then
      self._guide_service:ShowCircle(guideParam)
    elseif guideType == GuideType.Buff then
      self._guide_service:ShowBuff(guideParam)
    elseif guideType == GuideType.Entity then
      self._guide_service:ShowEntity(guideParam)
    elseif guideType == GuideType.PreviewLinkLine then
      self._guide_service:ShowPLLGuideLine(guideParam)
    elseif guideType == GuideType.PuzzleCountdown then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuidePuzzleCountdown, guideParam)
    end
    self._guide_service:SetNeedYield(guideStep:NeedYield())
  elseif gameEventType == GameEventType.PauseGuideWeakLine then
    self._guide_service:PauseGuideWeakLine()
  elseif gameEventType == GameEventType.FinishGuideWeakLine then
    self._guide_service:FinishGuideWeakLine()
  elseif gameEventType == GameEventType.FinishGuideStep then
    local guideType = param
    if guideType == GuideType.Piece then
      self._guide_service:DestroyGuidePieceEntity()
    end
    if guideType == GuideType.Entity then
      self._guide_service:FinishGuideShadowEntity()
    end
  elseif gameEventType == GameEventType.GuideYield then
    local guideStep = param
    local yieldFlag = guideStep:Yield()
    if yieldFlag then
      self._guide_service:SetNeedYield(yieldFlag == 1)
    else
      self._guide_service:SetNeedYield(false)
    end
  elseif gameEventType == GameEventType.GuideYieldBreak then
    self._guide_service:SetNeedYield(false)
  elseif gameEventType == GameEventType.GuideActiveSkill then
    local petTempID = param.petTempID
    local guideStepID = param.guideStepID
    local playerEntity = self._guide_service._world:Player():GetLocalTeamEntity()
    local cmd = GuideCommand:New()
    cmd:SetPetPstId(self:GetPetPstIdByTempId(petTempID))
    cmd:SetGuideStepID(guideStepID)
    self._guide_service._world:Player():SendCommand(cmd)
  elseif gameEventType == GameEventType.GuideChangeGhostLayer then
    self._guide_service:ChangeGuideGhostLayer()
  end
end

function GuideServiceListenerRender:GetPetPstIdByTempId(petTempId)
  local pets = self._guide_service._world:GetLocalMatchPetList()
  for _, pet in ipairs(pets) do
    if pet:GetTemplateID() == petTempId then
      return pet:GetPstID()
    end
  end
  return nil
end
