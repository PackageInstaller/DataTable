require("cutscene_base_ins_r")
_class("CutsceneFindObjPlayAnimationInstruction", CutsceneBaseInstruction)
CutsceneFindObjPlayAnimationInstruction = CutsceneFindObjPlayAnimationInstruction

function CutsceneFindObjPlayAnimationInstruction:Constructor(paramList)
  self._gameObjectName = paramList.gameObjectName
  self._animName = paramList.anim
end

function CutsceneFindObjPlayAnimationInstruction:DoInstruction(TT, phaseContext)
  local targetGameObject = UnityEngine.GameObject.Find(self._gameObjectName)
  if targetGameObject then
    local anim = targetGameObject.gameObject:GetComponent("Animation")
    anim:Play(self._animName)
  end
end
