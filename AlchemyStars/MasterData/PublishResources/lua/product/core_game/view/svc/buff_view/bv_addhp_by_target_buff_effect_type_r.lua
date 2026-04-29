_class("BuffViewAddHPByTargetBuffEffectType", BuffViewBase)
BuffViewAddHPByTargetBuffEffectType = BuffViewAddHPByTargetBuffEffectType

function BuffViewAddHPByTargetBuffEffectType:Constructor()
end

function BuffViewAddHPByTargetBuffEffectType:PlayView(TT)
  local entity = self._entity
  local addValue = self._buffResult:GetAddHP()
  local damageInfo = self._buffResult:GetDamageInfo()
  if addValue <= 0 then
    return
  end
  YIELD(TT)
  local materialEntity = entity
  if entity:HasTeam() then
    materialEntity = entity:GetTeamLeaderPetEntity()
  end
  if materialEntity:MaterialAnimationComponent() then
    materialEntity:MaterialAnimationComponent():PlayCure()
  end
  local playDamageService = self._world:GetService("PlayDamage")
  local matchType = self._world:MatchType()
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze and materialEntity:HasPetPstID() then
    materialEntity = materialEntity:Pet():GetOwnerTeamEntity()
  end
  playDamageService:AsyncUpdateHPAndDisplayDamage(materialEntity, damageInfo)
end
