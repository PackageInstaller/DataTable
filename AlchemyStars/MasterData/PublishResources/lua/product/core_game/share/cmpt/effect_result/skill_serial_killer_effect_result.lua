_class("SkillSerialKillerResult", SkillEffectResultBase)
SkillSerialKillerResult = SkillSerialKillerResult

function SkillSerialKillerResult:Constructor()
  self._killedArray = {}
end

function SkillSerialKillerResult:GetEffectType()
  return SkillEffectType.SerialKiller
end

function SkillSerialKillerResult:AddOneKilled(damageReult)
  table.insert(self._killedArray, damageReult)
end

function SkillSerialKillerResult:GetKilledArray()
  return self._killedArray
end

function SkillSerialKillerResult:GetAddPiecePosList()
  return self._addPiecePosList
end

function SkillSerialKillerResult:SetAddPiecePosList(addPiecePosList)
  self._addPiecePosList = addPiecePosList
end
