require("base_ins_r")
_class("DataSelectDamageInfoInstruction", BaseInstruction)
DataSelectDamageInfoInstruction = DataSelectDamageInfoInstruction

function DataSelectDamageInfoInstruction:Constructor(paramList)
  self._damageInfoIndex = tonumber(paramList.damageInfoIndex)
  self._damageStageIndex = tonumber(paramList.damageStageIndex) or 1
end

function DataSelectDamageInfoInstruction:DoInstruction(TT, casterEntity, phaseContext)
  phaseContext:SetCurDamageInfoIndex(self._damageInfoIndex)
end
