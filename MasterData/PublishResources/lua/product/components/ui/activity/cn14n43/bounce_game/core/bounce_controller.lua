require("bounce_obj_mgr")
_class("BounceController", Object)
BounceController = BounceController

function BounceController:Constructor()
  self.bounceData = BounceData:New()
  self.monsterPool = BounceMonsterPool:New()
  self.objMgr = BounceObjMgr:New()
  self.monsterGenerator = {}
  self.firstGuideStepPositionKeys = {
    "guide5420082",
    "guide5420083",
    "guide5420085",
    "guide5420086",
    "guide5420087"
  }
  self.secondGuideStepPositionKeys = {
    "guide5420092",
    "guide5420093",
    "guide5420094"
  }
  self.guideModule = GameGlobal.GetModule(GuideModule)
end

function BounceController:Init(uiController, levelId, selectPlayer, historyBestScore)
  self.uiController = uiController
  self.bounceData:Init(levelId, selectPlayer, historyBestScore)
  MonsterFactory.Init()
  EffectManager.Init()
  self.objMgr:Init(self)
  self.uiController:SetViewVisibleByBouceState(StateBounce.Init)
  self.fsm = StateMachineManager:GetInstance():CreateStateMachine("StateBounce", StateBounce)
  self.fsm:SetData(self)
  self.fsm:Init(StateBounce.Init)
  self.playerChangeStateRefUICallFun = nil
end

function BounceController:OnQuick()
  self.fsm:SetData(nil)
  StateMachineManager:GetInstance():DestroyStateMachine(self.fsm.Id)
  self.fsm = nil
  MonsterFactory.Destroy()
  EffectManager.Destroy()
  BouncePlayerData.DebugIns = nil
end

function BounceController:OnRestartGame()
  self.objMgr:Reset()
  self:ChgFsmState(StateBounce.Prepare)
end

function BounceController:GetData()
  return self.bounceData
end

function BounceController:GetUIController()
  return self.uiController
end

function BounceController:GetObjMgr()
  return self.objMgr
end

function BounceController:GetMonsterPool()
  return self.monsterPool
end

function BounceController:GetMonsterGenerator()
  return self.monsterGenerator
end

function BounceController:GetObjectsRoot()
  return self.uiController:GetCanvasRt()
end

function BounceController:IsOvering()
  return self.bounceData.isOvering
end

function BounceController:OnUpdate(deltaTimeMS)
  EffectManager.Update(deltaTimeMS)
  if self.bounceData.isGuiding and GuideHelper.IsUIGuideShow() then
    return
  end
  if self.bounceData.isGuiding then
    local isGuiding = self.guideModule:IsGuideProcess(self.bounceData.guidingId)
    self.bounceData:SetIsGuiding(isGuiding)
  end
  if self.bounceData.isOvering then
    self.bounceData.overTime = self.bounceData.overTime - deltaTimeMS
    if self.bounceData.overTime <= 0 then
      self.bounceData.isOvering = false
      local params = self:GetOverParam()
      self:ChgFsmState(StateBounce.Over, params)
      return
    end
  end
  if self.fsm then
    self.fsm:OnUpdate(deltaTimeMS)
  end
end

function BounceController:OnJump(fromPC)
  if self.bounceData.isGuiding and not GuideHelper.IsUIGuideShow() then
    return
  end
  if self.bounceData.isOvering then
    return
  end
  if fromPC and self.bounceData.isGuiding then
    local res = self:CheckKeyOperate("JumpBtn")
    if not res then
      return
    end
  end
  local curState = self.fsm:GetCurState()
  curState:OnJump()
end

function BounceController:OnAttack(fromPC)
  if self.bounceData.isGuiding and not GuideHelper.IsUIGuideShow() then
    return
  end
  if self.bounceData.isOvering then
    return
  end
  if fromPC and self.bounceData.isGuiding then
    local res = self:CheckKeyOperate("AttackBtn")
    if not res then
      return
    end
  end
  local curState = self.fsm:GetCurState()
  curState:OnAttack()
end

function BounceController:CheckKeyOperate(btnEvent)
  local guides = self.guideModule:GetCurGuides()
  if not guides then
    return false
  end
  for _, guide in pairs(guides) do
    local curStep = guide:GetCurStep()
    if curStep and curStep.show and curStep.btnGuideCfg and curStep.btnGuideCfg.guideArea == btnEvent then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ForceFinishGuideStep, GuideType.Button)
      return true
    end
  end
  return false
end

function BounceController:ChgFsmState(newState, params)
  Log.debug("[bounce] BounceController chgfsmState " .. newState)
  if not self.fsm then
    return
  end
  self.uiController:SetViewVisibleByBouceState(newState, params)
  self.fsm:ChangeState(newState)
end

function BounceController:GetPlayerPrefabName()
  return self.bounceData.palyerRes
end

function BounceController:MonsterDead(monsterId)
  local monsterCfg = Cfg.cfg_bounce_monster[monsterId]
  if not monsterCfg then
    return nil
  end
  if monsterCfg.Score then
    self:AddScore(monsterCfg.Score)
  end
  self.uiController:MonsterDead(monsterId)
  if self.bounceData.targetMonster > 0 then
    if self.bounceData.targetMonster == monsterId then
      self:StartOver()
      self.bounceData:SetKilledBoss(true)
    end
  elseif self.bounceData.targetScore <= self.bounceData.score then
    self:StartOver()
    return
  end
  if not self.bounceData.hasGenBoss and self.bounceData.genBossId and self.bounceData.genBossScore <= self.bounceData.score then
    self.bounceData.hasGenBoss = true
    local monsterId = self.bounceData.genBossId
    local monster = self.monsterPool:Get(monsterId)
    monster:SetCoreController(self)
    local view = monster:GetBehavior(MonsterBeHaviorView.Name())
    if view then
      view:SetParent(self:GetObjectsRoot())
    end
    local posBehaviour = monster:GetBehavior(MonsterBeHaviorPosition.Name())
    if posBehaviour then
      posBehaviour:SetPosition(self.bounceData.genBossPos)
    end
    self.objMgr:AddMonster(monster)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneAccBossEnter)
    if self.bounceData.levelId == 6 and not self.guideModule:IsGuideDone(BounceConst.GuideBoss1) then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIBounceMainControllerBoss1)
      self.bounceData.guidingId = BounceConst.GuideBoss1
      local isGuiding = self.guideModule:IsGuideProcess(BounceConst.GuideBoss1)
      self.bounceData:SetIsGuiding(isGuiding)
    end
    self.uiController:PauseMoveBOSSBG_ShowBoss()
  end
end

function BounceController:StartOver()
  self.bounceData.isOvering = true
  self.bounceData.overTime = 2000
end

function BounceController:GetOverParam()
  local param = {}
  param.Score = self.bounceData.score
  param.HistoryBestScore = self.bounceData.historyBestScore
end

function BounceController:AddScore(score)
  self.bounceData:AddScore(score)
  self.uiController:ScoreChange(self.bounceData:GetScore())
end

function BounceController:ShowHPProgress(serializeId, maxValue)
  self.uiController:ShowHPProgress(serializeId, maxValue)
end

function BounceController:HideHPProgress(serializeId)
  self.uiController:HideHPProgress(serializeId)
end

function BounceController:HPProgressChange(serializeId, currentValue, maxValue)
  self.uiController:HPProgressChange(serializeId, currentValue, maxValue)
end

function BounceController:GetGameData()
  return self.bounceData
end

function BounceController:GetGuideRt(guideStepKey)
  return self.uiController:GetGuideRt(guideStepKey)
end

function BounceController:SetGuideStepShow(guideStepKey)
  self.uiController:SetGuideStepShow(guideStepKey)
end

function BounceController:SetGuidePosition(key, position)
  self.uiController:SetGuidePosition(key, position)
end

function BounceController:OnTrigerGuideStep(guideStepKey)
  Log.debug("[bounce] Guide_CheckMonsterPosition " .. guideStepKey)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.N28BounceGameArriveTarget, guideStepKey)
  self:SetGuideStepShow(guideStepKey)
end

function BounceController:SetPlayerChangeStateRefUICallFun(fun)
  self.playerChangeStateRefUICallFun = fun
end

function BounceController:PlayerChangeState(isLeaveGround)
  if self.playerChangeStateRefUICallFun then
    self.playerChangeStateRefUICallFun(isLeaveGround)
  end
end
