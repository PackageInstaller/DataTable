require("base_ins_r")
_class("PlayCasterSubMaterialAnimInstruction", BaseInstruction)
PlayCasterSubMaterialAnimInstruction = PlayCasterSubMaterialAnimInstruction

function PlayCasterSubMaterialAnimInstruction:Constructor(paramList)
  self._nodeName = paramList.nodeName
  self._animName = paramList.animName
end

function PlayCasterSubMaterialAnimInstruction:DoInstruction(TT, casterEntity, phaseContext)
  casterEntity:PlaySubMaterialAnim(self._nodeName, self._animName)
end
