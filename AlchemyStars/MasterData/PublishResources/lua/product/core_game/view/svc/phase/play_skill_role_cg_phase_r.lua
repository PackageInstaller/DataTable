require("play_skill_phase_base_r")
_class("PlaySkillRoleCGPhase", PlaySkillPhaseBase)
PlaySkillRoleCGPhase = PlaySkillRoleCGPhase

function PlaySkillRoleCGPhase:PlayFlight(TT, casterEntity, phaseParam)
  local roleCGParam = phaseParam
  local cgTimeLen = roleCGParam:GetCGTimeLen()
  local cgRes = roleCGParam:GetCGRes()
  local hideRoleTime = roleCGParam:GetHideRoleTime()
  local world = casterEntity:GetOwnerWorld()
  local battleRenderConfigCmpt = world:BattleRenderConfig()
  local canPlayCG = battleRenderConfigCmpt:GetCanPlaySkillSpineInBattle(cgRes)
  if not canPlayCG then
    return
  end
  if hideRoleTime then
    YIELD(TT, hideRoleTime)
  end
  if hideRoleTime then
    casterEntity:SetViewVisible(false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowUltraSkillSpine, cgRes)
  YIELD(TT, cgTimeLen)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopUltraSkillSpine, cgRes)
  if hideRoleTime then
    casterEntity:SetViewVisible(true)
  end
end
