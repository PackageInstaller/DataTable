local BattleRoleFsmComp, Super = System.NewClass("BattleRoleFsmComp", BattleComponent)

function BattleRoleFsmComp:ctor(battleRole)
  self.battleRole = battleRole
  self.fsmState = bc.AwakerFsmState.Idle
  self.delayChangeFsmFuncs = {}
  self:RegisterEvent()
end

function BattleRoleFsmComp:RegisterEvent()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeRoleFsmState, self.OnChangeFsmState, self)
end

function BattleRoleFsmComp:Dispose()
  Super.Dispose(self)
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
end

function BattleRoleFsmComp:Tick()
  if #(self.delayChangeFsmFuncs or {}) > 0 and bg.battleRender.renderTime - (self.lastFsmTime or 0) >= bc.HitDelay then
    self.lastFsmTime = bg.battleRender.renderTime
    local func = table.remove(self.delayChangeFsmFuncs, 1)
    if func then
      func()
    end
  end
end

function BattleRoleFsmComp:OnChangeFsmState(data)
  if data.config.actionAwakerId ~= self.battleRole.uid and data.uid ~= self.battleRole.uid then
    return
  end
  
  local function onChangeFsmFunc()
    local newState = data.newState
    local config = data.config
    if newState == bc.AwakerFsmState.Idle then
    elseif newState == bc.AwakerFsmState.Attack then
      self:OnEnterAttackState(config)
    elseif newState == bc.AwakerFsmState.BeHit then
      self:OnEnterBeHitState(config)
    elseif newState == bc.AwakerFsmState.Dead then
      if bg.battleRender.roleMgr:IsHaveUnplayedEffectSfx(self.battleRole.uid) then
        self:OnChangeFsmState(data)
        return
      end
      for _, awaker in ipairs(self.battleRole.awakerList) do
        awaker:ChangeFsmState(newState, config)
      end
      self.battleRole.roleDataModel:ClearIntention()
    end
  end
  
  table.insert(self.delayChangeFsmFuncs, onChangeFsmFunc)
end

function BattleRoleFsmComp:OnEnterAttackState(config)
  bg.ultiSkillAwakerTid = nil
  local actionAwaker = self.battleRole:GetAwakerByUid(config.actionAwakerId)
  if bg.isPVP then
    actionAwaker = self.battleRole:GetRandomAwaker()
  end
  if nil ~= actionAwaker then
    actionAwaker:ChangeFsmState(bc.AwakerFsmState.Attack, config)
  elseif self.battleRole.roleType ~= bc.RoleType.Player then
    Logger.Error("BattleRoleFsmComp:OnChangeFsmState 找不到战斗小人 ", self.uid, config.actionAwakerId)
  end
end

function BattleRoleFsmComp:OnEnterBeHitState(config)
  local castRoleUid = config.castRoleUid
  local castRole = bg.battleScene:GetRoleByUid(castRoleUid)
  local hitSfxBlister = self.battleRole:GetHitSfxBlister(castRole, config.skillConfigId)
  local awaker = self.battleRole:GetRandomAwaker()
  if not awaker then
    return
  end
  awaker:ChangeFsmState(bc.AwakerFsmState.BeHit, config)
  if nil ~= hitSfxBlister then
    local DT = bg.DT
    local isPVE = bg.isPVE
    for _, sfxId in ipairs(hitSfxBlister) do
      local sfxConfig = DT.BattleSfxConfig[sfxId]
      local isFlip = false
      if isPVE and sfxConfig.CanFlip and self.battleRole.camp == bc.BattleCamp.Camp1 then
        isFlip = true
      end
      awaker:PlaySfx(sfxId, nil, nil, nil, isFlip, castRoleUid)
    end
  end
end

return BattleRoleFsmComp
