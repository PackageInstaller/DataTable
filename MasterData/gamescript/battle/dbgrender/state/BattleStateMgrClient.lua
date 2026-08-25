local BattleStateMgrClient, Super = System.NewClass("BattleStateMgrClient")

function BattleStateMgrClient:ctor()
  Super.ctor(self)
end

function BattleStateMgrClient:Awake()
  self:RegisterEvents()
  self.stateData = bg.battleDataCenter.stateData
end

function BattleStateMgrClient:Dispose()
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
end

function BattleStateMgrClient:RegisterEvents()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.AddState, self.OnAddState, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeStateLayer, self.OnChangeStateLayer, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.DelState, self.OnDelState, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.AddCardState, self.OnAddCardState, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.UpdateStateArgs, self.OnUpdateStateArgs, self)
end

function BattleStateMgrClient:OnAddState(data)
  self.stateData:AddState(data)
  self:ProcessAudioOnStateChange(data.stateId, data.roleUid)
  if data.stateType == bc.StateType.Role or data.stateType == bc.StateType.Awaker then
    local roleUid = data.roleUid
    local role = bg.battleScene:GetRoleByUid(roleUid)
    if not role then
      return
    end
    role:OnChangeState(data)
  end
end

function BattleStateMgrClient:OnChangeStateLayer(data)
  self.stateData:ChangeState(data)
  if data.newLayer > data.oldLayer then
    self:ProcessAudioOnStateChange(data.stateId, data.ownerUid)
  end
  if data.stateType == bc.StateType.Role or data.stateType == bc.StateType.Awaker then
    local roleUid = data.roleUid
    local role = bg.battleScene:GetRoleByUid(roleUid)
    if not role then
      return
    end
    role:OnChangeState(data)
  end
end

function BattleStateMgrClient:OnUpdateStateArgs(data)
  self.stateData:UpdateStateArgs(data.updateList)
end

function BattleStateMgrClient:ProcessAudioOnStateChange(stateId, uid)
  local DT = bg.DT
  local configData = DT.State[stateId]
  if not configData or not configData.IsBuff then
    return
  end
  local role = bg.battleScene:GetRoleByUid(uid)
  if not role then
    return
  end
  local audioEvent
  if role.camp == bc.BattleCamp.Camp1 then
    audioEvent = configData.IsBuff == "TRUE" and "SFX_FT_BUFF_CM_PLAYER" or "SFX_FT_DEBUFF_CM_PLAYER"
  elseif role.camp == bc.BattleCamp.Camp2 then
    audioEvent = configData.IsBuff == "TRUE" and "SFX_FT_BUFF_CM_EN" or "SFX_FT_DEBUFF_CM_EN"
  end
  if nil ~= audioEvent then
    AudioManager.Instance:PostSoundEvent(audioEvent)
  end
end

function BattleStateMgrClient:OnDelState(data)
  local cardMgr = bg.battleRender.cardMgr
  local removedState = self.stateData:RemoveState(data)
  if data.stateType ~= bc.StateType.Card then
    local roleUid = data.ownerUid
    local role = bg.battleScene:GetRoleByUid(roleUid)
    if not role or not role.floatTextUI then
      return
    end
    role.floatTextUI:OnStateDel(removedState)
  end
end

function BattleStateMgrClient:OnAddCardState(data)
  self.stateData:AddState(data)
end

return BattleStateMgrClient
