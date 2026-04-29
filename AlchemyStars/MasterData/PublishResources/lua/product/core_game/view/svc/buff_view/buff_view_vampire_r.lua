_class("BuffViewVampire", BuffViewBase)
BuffViewVampire = BuffViewVampire

function BuffViewVampire:IsNotifyMatch(notify)
  if notify and notify:GetNotifyEntity() ~= self._entity then
    local skillID = notify:GetSkillID()
    if skillID then
      local cfg = Cfg.cfg_camp_skill({
        SkillID = notify:GetSkillID()
      })
      if not cfg then
        return false
      end
    else
      return false
    end
  end
  if notify:GetNotifyType() == NotifyType.NormalEachAttackEnd then
    local result = self._buffResult
    local attackIndexMatch = true
    if result.normalAttackIndex and notify.GetNormalAttackIndex and notify:GetNormalAttackIndex() then
      attackIndexMatch = result.normalAttackIndex == notify:GetNormalAttackIndex()
    end
    return result.attacker == notify:GetAttackerEntity() and result.defender == notify:GetDefenderEntity() and result.attackPos == notify:GetAttackPos() and result.targetPos == notify:GetTargetPos() and attackIndexMatch
  end
  return true
end

function BuffViewVampire:PlayView(TT)
  local buffRes = self._buffResult
  local entity = self._entity
  local damageInfo = buffRes:GetDamageInfo()
  YIELD(TT)
  local materialEntity = entity
  if entity:HasSuperEntity() and entity:EntityType():IsSkillHolder() then
    materialEntity = entity:GetSuperEntity()
  end
  if entity:HasTeam() then
    materialEntity = entity:GetTeamLeaderPetEntity()
  end
  if materialEntity:MaterialAnimationComponent() and damageInfo:GetDamageType() == DamageType.Recover then
    materialEntity:MaterialAnimationComponent():PlayCure()
  end
  local playDamageService = self._world:GetService("PlayDamage")
  local matchType = self._world:MatchType()
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze and materialEntity:HasPetPstID() then
    materialEntity = materialEntity:Pet():GetOwnerTeamEntity()
  end
  playDamageService:AsyncUpdateHPAndDisplayDamage(materialEntity, damageInfo)
  if buffRes:IsAddSan() then
    local old = buffRes:GetOldSanValue()
    local current = buffRes:GetNewSanValue()
    local val = buffRes:GetModifySanValue()
    local debtVal = buffRes:GetDebtValue()
    local modifyTimes = buffRes:GetModifyTimes()
    local featureSvc = self._world:GetService("FeatureRender")
    featureSvc:NotifySanValueChange(current, old, val)
    local nt = NTSanValueChange:New(current, old, debtVal, modifyTimes)
    self._world:GetService("PlayBuff"):PlayBuffView(TT, nt)
  end
end
