require("cutscene_base_ins_r")
_class("CutsceneTrapFadeOutInstruction", CutsceneBaseInstruction)
CutsceneTrapFadeOutInstruction = CutsceneTrapFadeOutInstruction

function CutsceneTrapFadeOutInstruction:Constructor(paramList)
  self._duration = tonumber(paramList.duration)
end

function CutsceneTrapFadeOutInstruction:DoInstruction(TT, phaseContext)
  local world = phaseContext:GetCutsceneWorld()
  local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
  if trapGroup then
    for i, e in ipairs(trapGroup:GetEntities()) do
      local trapRenderCmpt = e:TrapRender()
      if trapRenderCmpt and not trapRenderCmpt:GetHadPlayDestroy() then
        self:DOFade(e, world, self._duration)
      end
    end
  end
end

function CutsceneTrapFadeOutInstruction:DOFade(e, world, duration)
  duration = duration * 0.001
  local fadeComponent = e:View():GetGameObject():GetComponent(typeof(FadeComponent))
  if not fadeComponent then
    e:SetViewVisible(false)
    local roundRender = e:TrapRoundInfoRender()
    if roundRender then
      local round_entity_id = roundRender:GetRoundInfoEntityID()
      local round_entity = world:GetEntityByID(round_entity_id)
      if round_entity then
        round_entity:SetViewVisible(false)
      end
    end
    return
  end
  if duration <= 0 then
    fadeComponent.Alpha = 0
    return
  end
  local tmpDuration = 0
  local factor = 0
  local func
  tmpDuration = duration
  factor = -1
  
  function func()
    return 0 <= tmpDuration
  end
  
  local mathService = world:GetService("Math")
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    while func() do
      tmpDuration = tmpDuration + UnityEngine.Time.deltaTime * factor
      local tran = tmpDuration / duration
      tran = mathService:ClampValue(tran, 0, 1)
      fadeComponent.Alpha = tran
      YIELD(TT)
    end
  end, self)
end
