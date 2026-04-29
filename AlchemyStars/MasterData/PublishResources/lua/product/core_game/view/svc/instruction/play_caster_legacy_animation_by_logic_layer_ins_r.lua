require("base_ins_r")
_class("PlayCasterLegacyAnimationByLogicLayerInstruction", BaseInstruction)
PlayCasterLegacyAnimationByLogicLayerInstruction = PlayCasterLegacyAnimationByLogicLayerInstruction

function PlayCasterLegacyAnimationByLogicLayerInstruction:Constructor(paramList)
  self._buffEffectType = tonumber(paramList.buffEffectType)
  self._noLayerAnimName = paramList.noLayerAnimName
  local animNameGroup = paramList.animNameByLayer
  self._animNameByLayer = string.split(animNameGroup, "|")
end

function PlayCasterLegacyAnimationByLogicLayerInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if not self._buffEffectType then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local utilData = world:GetService("UtilData")
  local realEntity = casterEntity:HasSuperEntity() and casterEntity:GetSuperEntity() or casterEntity
  local buffLayer = utilData:GetBuffLayer(realEntity, self._buffEffectType)
  Log.info(table.concat({
    "PlayCasterLegacyAnimationByLogicLayer: entityID=",
    realEntity:GetID(),
    " buffEffectType=",
    self._buffEffectType,
    " layer=",
    buffLayer
  }))
  local go = casterEntity:View():GetGameObject()
  local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  if not anim or tostring(anim) == "null" then
    Log.fatal("PlayCasterLegacyAnimationByLogicLayer: no UnityEngine.Animation on entityID=", realEntity:GetID())
    return
  end
  anim:Stop()
  if buffLayer == 0 then
    anim:Play(self._noLayerAnimName)
  else
    local name = self._animNameByLayer[buffLayer]
    if not name then
      Log.exception("PlayCasterLegacyAnimationByLogicLayer: unmatched buffLayer: ", tostring(buffLayer))
    end
    anim:Play(self._animNameByLayer[buffLayer])
  end
end
