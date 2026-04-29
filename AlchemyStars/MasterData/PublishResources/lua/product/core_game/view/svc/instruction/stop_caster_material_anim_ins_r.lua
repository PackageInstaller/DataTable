require("base_ins_r")
_class("StopCasterMaterialAnimInstruction", BaseInstruction)
StopCasterMaterialAnimInstruction = StopCasterMaterialAnimInstruction

function StopCasterMaterialAnimInstruction:Constructor(paramList)
  self._animName = paramList.animName
end

function StopCasterMaterialAnimInstruction:DoInstruction(TT, casterEntity, phaseContext)
  casterEntity:StopMaterialAnim(self._animName)
end
