require("base_ins_r")
_class("PlayStuntMonsterBindEffectInstruction", BaseInstruction)
PlayStuntMonsterBindEffectInstruction = PlayStuntMonsterBindEffectInstruction

function PlayStuntMonsterBindEffectInstruction:Constructor(paramList)
  self._stuntTag = paramList.tag or "default"
  self._effectID = tonumber(paramList.effectID)
  self._scale = tonumber(paramList.scale) or 1
end

function PlayStuntMonsterBindEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if not casterEntity:HasStuntOwnerComponent() then
    return
  end
  local e = casterEntity:StuntOwnerComponent():GetStuntByTag(self._stuntTag)
  if not e then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local effect = world:GetService("Effect"):CreateEffect(self._effectID, e)
  if effect and self._scale ~= 1 then
    YIELD(TT)
    local trajectoryObject = effect:View():GetGameObject()
    local transWork = trajectoryObject.transform
    local scaleData = Vector3.New(self._scale, self._scale, self._scale)
    local sequence = transWork:DOScale(scaleData, 0)
  end
end

function PlayStuntMonsterBindEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
