require("base_ins_r")
_class("PlayFadeInOutEntityInstruction", BaseInstruction)
PlayFadeInOutEntityInstruction = PlayFadeInOutEntityInstruction

function PlayFadeInOutEntityInstruction:Constructor(paramList)
  self._fadeIn = paramList.fadeIn == "true"
  self._target = paramList.target
  self._duration = tonumber(paramList.duration)
end

function PlayFadeInOutEntityInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if self._target == "self" then
    casterEntity:NewEnableGhost()
    self:DOFade(casterEntity, world)
  elseif self._target == "player" then
    local teamEntity = world:Player():GetCurrentTeamEntity()
    local ePlayer = teamEntity:GetTeamLeaderPetEntity()
    ePlayer:NewEnableGhost()
    self:DOFade(ePlayer, world)
  end
end

function PlayFadeInOutEntityInstruction:DOFade(e, world)
  local fadeIn = self._fadeIn
  self._duration = self._duration * 0.001
  if self._duration <= 0 then
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
    tmpDuration = self._duration
    factor = -1
    
    function func()
      return 0 <= tmpDuration
    end
  end
  local mathService = world:GetService("Math")
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    while func() do
      tmpDuration = tmpDuration + UnityEngine.Time.deltaTime * factor
      local tran = tmpDuration / self._duration
      tran = mathService:ClampValue(tran, 0, 1)
      e:SetTransparentValue(tran)
      YIELD(TT)
    end
  end, self)
end
