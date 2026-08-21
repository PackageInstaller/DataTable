_class("SkillEffectResultCalEdgePos", SkillEffectResultBase)
SkillEffectResultCalEdgePos = SkillEffectResultCalEdgePos

function SkillEffectResultCalEdgePos:Constructor(farestIdx, posArr, dirArr)
  self.farestIdx = farestIdx
  self.posArr = posArr
  self.dirArr = dirArr
end

function SkillEffectResultCalEdgePos:GetEffectType()
  return SkillEffectType.CalEdgePos
end

function SkillEffectResultCalEdgePos:GetFarestIdx()
  return self.farestIdx
end

function SkillEffectResultCalEdgePos:GetPosArr()
  return self.posArr
end

function SkillEffectResultCalEdgePos:GetDirArr()
  return self.dirArr
end
