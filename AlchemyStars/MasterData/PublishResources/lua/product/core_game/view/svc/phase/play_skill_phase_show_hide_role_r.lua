require("play_skill_phase_base_r")
_class("PlaySkillPhase_ShowHideRole", PlaySkillPhaseBase)
PlaySkillPhase_ShowHideRole = PlaySkillPhase_ShowHideRole

function PlaySkillPhase_ShowHideRole:PlayFlight(TT, casterEntity, phaseParam)
  self:_DelayTime(TT, phaseParam:GetBeginDelay())
  local nShowType, showParam = phaseParam:GetShowData()
  if SkillPhaseParam_ShowType.Hide == nShowType then
    casterEntity:View():GetGameObject():SetActive(false)
  elseif SkillPhaseParam_ShowType.Show == nShowType then
    casterEntity:View():GetGameObject():SetActive(true)
  elseif SkillPhaseParam_ShowType.Replace == nShowType then
    local newPrefab = showParam
    casterEntity:ReplaceAsset(NativeUnityPrefabAsset:New(newPrefab, true))
  elseif SkillPhaseParam_ShowType.Fade == nShowType then
    local fadeIn = showParam.fadeIn
    local isSelf = showParam.isSelf
    local duration = showParam.duration
    if isSelf then
      casterEntity:NewEnableGhost()
      self:DOFade(casterEntity, fadeIn, duration)
    else
      local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
      local pos = casterEntity:GridLocation().Position
      local damageResult = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.Damage, pos)
      local targetEntityID = damageResult:GetTargetID()
      local entity = self._world:GetEntityByID(targetEntityID)
      entity:NewEnableGhost()
      self:DOFade(entity, fadeIn, duration)
    end
  end
  self:_DelayTime(TT, phaseParam:GetEndDelay())
end

function PlaySkillPhase_ShowHideRole:DOFade(e, fadeIn, duration)
  duration = duration * 0.001
  if duration <= 0 then
    if fadeIn then
      e:SetTransparentValue(1)
    else
      e:SetTransparentValue(0)
    end
    return
  end
  local tmpDuration = 0
  local factor = 0
  local func
  if fadeIn then
    tmpDuration = 0
    factor = 1
    
    function func()
      return tmpDuration <= 1
    end
  else
    tmpDuration = duration
    factor = -1
    
    function func()
      return 0 <= tmpDuration
    end
  end
  local mathService = self._world:GetService("Math")
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    while func() do
      tmpDuration = tmpDuration + UnityEngine.Time.deltaTime * factor
      local tran = tmpDuration / duration
      tran = mathService:ClampValue(tran, 0, 1)
      e:SetTransparentValue(tran)
      YIELD(TT)
    end
  end, self)
end
