require("base_ins_r")
_class("StopCasterSubMaterialAnimInstruction", BaseInstruction)
StopCasterSubMaterialAnimInstruction = StopCasterSubMaterialAnimInstruction

function StopCasterSubMaterialAnimInstruction:Constructor(paramList)
  self._nodeName = paramList.nodeName
  self._animName = paramList.animName
end

function StopCasterSubMaterialAnimInstruction:DoInstruction(TT, casterEntity, phaseContext)
  casterEntity:StopSubMaterialAnim(self._nodeName, self._animName)
end
