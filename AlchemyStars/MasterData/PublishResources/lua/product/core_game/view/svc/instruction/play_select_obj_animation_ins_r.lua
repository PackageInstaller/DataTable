require("base_ins_r")
_class("PlaySelectObjAnimationInstruction", BaseInstruction)
PlaySelectObjAnimationInstruction = PlaySelectObjAnimationInstruction

function PlaySelectObjAnimationInstruction:Constructor(paramList)
  self._objName = paramList.objName
  self._animName = paramList.animName
end

function PlaySelectObjAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local obj = UnityEngine.GameObject.Find(self._objName)
  if not obj then
    return
  end
  local anim = obj:GetComponentInChildren(typeof(UnityEngine.Animation))
  if not anim then
    return
  end
  anim:Play(self._animName)
end
