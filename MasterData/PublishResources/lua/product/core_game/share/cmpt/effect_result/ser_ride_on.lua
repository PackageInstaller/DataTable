require("skill_effect_result_base")
_class("SkillEffectRideOnResult", SkillEffectResultBase)
SkillEffectRideOnResult = SkillEffectRideOnResult

function SkillEffectRideOnResult:Constructor(curMountID, oldPos, monsterMountID, trapMountID, trapID, summonPosList, height, centerOffset)
  self._curMountID = curMountID
  self._oldPos = oldPos
  self._monsterMountID = monsterMountID
  self._trapMountID = trapMountID
  self._trapID = trapID
  self._summonPosList = summonPosList
  self._height = height
  self._centerOffset = centerOffset
end

function SkillEffectRideOnResult:GetEffectType()
  return SkillEffectType.RideOn
end

function SkillEffectRideOnResult:GetCurMountID()
  return self._curMountID
end

function SkillEffectRideOnResult:GetOldPos()
  return self._oldPos
end

function SkillEffectRideOnResult:GetMonsterMountID()
  return self._monsterMountID
end

function SkillEffectRideOnResult:GetTrapMountID()
  return self._trapMountID
end

function SkillEffectRideOnResult:GetTrapID()
  return self._trapID
end

function SkillEffectRideOnResult:GetSummonPosList()
  return self._summonPosList
end

function SkillEffectRideOnResult:GetHeight()
  return self._height
end

function SkillEffectRideOnResult:GetCenterOffset()
  return self._centerOffset
end

function SkillEffectRideOnResult:SetTrapIDList(trapIDList)
  self._trapIDList = trapIDList
end

function SkillEffectRideOnResult:GetTrapIDList()
  return self._trapIDList
end
