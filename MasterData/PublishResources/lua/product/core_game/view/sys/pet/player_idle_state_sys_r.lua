_class("PlayerIdleStateSystem_Render", ReactiveSystem)
PlayerIdleStateSystem_Render = PlayerIdleStateSystem_Render

function PlayerIdleStateSystem_Render:Constructor(world)
  self._world = world
end

function PlayerIdleStateSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.MoveFSM)
  }, {"Added"})
  return c
end

function PlayerIdleStateSystem_Render:Filter(entity)
  if not entity:HasMoveFSM() then
    return false
  end
  local move_fsm_cmpt = entity:MoveFSM()
  local cur_state_id = move_fsm_cmpt:GetMoveFSMCurStateID()
  if cur_state_id == PlayerActionStateID.Idle then
    return true
  end
  return false
end

function PlayerIdleStateSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    local handle_res = self:HandleIdle(entities[i])
    if handle_res then
      break
    end
  end
end

function PlayerIdleStateSystem_Render:HandleIdle(entity)
  local utilDataSvc = self._world:GetService("UtilData")
  local curMainStateID = utilDataSvc:GetCurMainStateID()
  if curMainStateID == GameStateID.ChainAttack or curMainStateID == GameStateID.RunTest then
    return self:_HandleChainSkillEnd(entity)
  end
  return false
end

function PlayerIdleStateSystem_Render:_HandleChainSkillEnd(entity)
  if entity:HasChainSkillFlag() then
    entity:RemoveChainSkillFlag()
    local teamEntity = entity:Pet():GetOwnerTeamEntity()
    local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
    local petEntities = teamEntity:Team():GetTeamPetEntities()
    local chain_skill_sequence_cmpt = teamEntity:ChainSkillSequence()
    local chain_skill_sequence_table = chain_skill_sequence_cmpt.ChainSkillSeqTable
    table.removev(chain_skill_sequence_table, entity:GetID())
    if 0 < #chain_skill_sequence_table then
      if entity:HasViewExtension() then
        entity:SetViewVisible(false)
      end
      local pet_entity_id = self:GetFirstChainSkillActorID(chain_skill_sequence_table)
      TaskManager:GetInstance():CoreGameStartTask(self._StartNextPetChainAttack, self, teamEntity:GridLocation().Position, pet_entity_id)
    else
      teamLeaderEntity:SetViewVisible(true)
      for i, e in ipairs(petEntities) do
        if e:HasViewExtension() and teamLeaderEntity:GetID() ~= e:GetID() then
          e:SetViewVisible(false)
        end
      end
    end
    return true
  end
end

function PlayerIdleStateSystem_Render:GetFirstChainSkillActorID(chain_skill_sequence_table)
  local pet_entity_id = chain_skill_sequence_table[1]
  pet_entity_id = pet_entity_id or -1
  return pet_entity_id
end

function PlayerIdleStateSystem_Render:_StartNextPetChainAttack(TT, castPos, nextPetEntityID)
  local pet_entity = self._world:GetEntityByID(nextPetEntityID)
  pet_entity:SetViewVisible(true)
  YIELD(TT, 100)
  pet_entity:AddChainSkillFlag()
  self._world:EventDispatcher():Dispatch(GameEventType.IdleEnd, 2, nextPetEntityID)
end
