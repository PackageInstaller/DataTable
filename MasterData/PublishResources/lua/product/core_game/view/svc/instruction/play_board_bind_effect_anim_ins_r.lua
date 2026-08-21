require("base_ins_r")
_class("PlayBoardBindEffectAnimInstruction", BaseInstruction)
PlayBoardBindEffectAnimInstruction = PlayBoardBindEffectAnimInstruction

function PlayBoardBindEffectAnimInstruction:Constructor(paramList)
  local str = paramList.animNames
  self._animNames = string.split(str, "|")
  self._effectID = tonumber(paramList.effectID or 0)
end

function PlayBoardBindEffectAnimInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._animNames == nil then
    Log.fatal("Legacy animation params is nil!")
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local boardEntity = world:GetRenderBoardEntity()
  local entityList = {}
  if self._effectID and self._effectID > 0 then
    local casterEffectHolderCmpt = boardEntity:EffectHolder()
    local effectEntityIDList = casterEffectHolderCmpt:GetEffectEntityIDByEffectID(self._effectID)
    if effectEntityIDList then
      for _, effectEntityID in ipairs(effectEntityIDList) do
        local effectEntity = world:GetEntityByID(effectEntityID)
        table.insert(entityList, effectEntity)
      end
    end
  end
  for _, e in ipairs(entityList) do
    self:_PlayAnimation(e)
  end
end

function PlayBoardBindEffectAnimInstruction:_PlayAnimation(entity)
  if not entity:HasView() then
    return
  end
  local go = entity:View():GetGameObject()
  local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  if anim == nil then
    Log.fatal("Cant play legacy animation, animation not found in ", go.name)
    return
  end
  if table.count(self._animNames) > 1 then
    anim:Stop()
    for i = 1, #self._animNames do
      anim:PlayQueued(self._animNames[i])
    end
  else
    anim:Play(self._animNames[1])
  end
end
