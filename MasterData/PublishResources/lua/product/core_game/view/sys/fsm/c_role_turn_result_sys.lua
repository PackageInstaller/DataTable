require("role_turn_result_state_system")
_class("ClientRoleTurnResultSystem_Render", RoleTurnResultStateSystem)
ClientRoleTurnResultSystem_Render = ClientRoleTurnResultSystem_Render

function ClientRoleTurnResultSystem_Render:_DoRenderPlayNotify(TT)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTRoleTurnResultState:New())
end

function ClientRoleTurnResultSystem_Render:_DoRenderNormalAttackMonsterDead(TT)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:DoAllMonsterDeadRender(TT, false)
end

function ClientRoleTurnResultSystem_Render:_DoRenderGuideSkill(TT)
  local guideService = self._world:GetService("Guide")
  local guideTaskId = guideService:Trigger(GameEventType.GuidePlayerSkillFinish, GuidePlayerHandle.LinkEnd)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
end

function ClientRoleTurnResultSystem_Render:_DoRenderGuideSkillReal(TT)
  local guideService = self._world:GetService("Guide")
  local guideTaskId = guideService:Trigger(GameEventType.GuidePlayerSkillRealFinish, GuidePlayerHandle.LinkEnd)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
end

function ClientRoleTurnResultSystem_Render:_DoRenderWaitDeathEnd(TT)
  while self:_CheckShowDeathNotEnd() do
    YIELD(TT)
  end
end

function ClientRoleTurnResultSystem_Render:_CheckShowDeathNotEnd()
  local deathGroup = self._world:GetGroup(self._world.BW_WEMatchers.ShowDeath)
  for _, v in ipairs(deathGroup:GetEntities()) do
    local entity = v
    local showDeathCmpt = entity:ShowDeath()
    if not showDeathCmpt:IsShowDeathEnd() then
      return true
    end
  end
  return false
end

function ClientRoleTurnResultSystem_Render:_WaitBeHitSkillFinish(TT)
  YIELD(TT)
  YIELD(TT)
  local count = 0
  local previewEntity = self._world:GetPreviewEntity()
  local renderState = previewEntity:RenderState()
  if renderState and renderState:GetRenderStateType() == RenderStateType.WaitPlayTask then
    local taskID = renderState:GetRenderStateParam()
    if taskID then
      while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
        YIELD(TT)
        count = count + 1
      end
    else
      while renderState:GetRenderStateType() == RenderStateType.WaitPlayTask do
        YIELD(TT)
        count = count + 1
      end
    end
  end
  if count ~= 0 then
    Log.warn("HPLock Wait Count:", count)
  end
end
