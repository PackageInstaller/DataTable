_class("BuffViewAddHPComplex", BuffViewBase)
BuffViewAddHPComplex = BuffViewAddHPComplex

function BuffViewAddHPComplex:Constructor()
end

function BuffViewAddHPComplex:IsNotifyMatch(notify)
  local result = self._buffResult
  if notify:GetNotifyType() == NotifyType.NotifyLayerChange then
    local n = notify
    local n = notify
    if result:GetLayerName() and notify:GetLayerName() ~= result:GetLayerName() then
      return false
    end
    if result:GetLayerTotalCount() and result:GetLayerTotalCount() ~= n:GetTotalCount() then
      return false
    end
  elseif notify:GetNotifyType() == NotifyType.NormalEachAttackEnd or notify:GetNotifyType() == NotifyType.ChainSkillEachAttackEnd then
    return self._buffResult.attackPos == notify:GetAttackPos() and self._buffResult.targetPos == notify:GetTargetPos() and self._buffResult.attacker == notify:GetAttackerEntity() and self._buffResult.defender == notify:GetDefenderEntity()
  end
  return true
end

function BuffViewAddHPComplex:PlayView(TT)
  local res = self._buffResult
  local entity = self._entity
  local damageInfo = res:GetDamageInfo()
  local headOut = res:GetHeadout()
  local delay = res:GetDelay()
  if 0 < delay then
    YIELD(TT, delay)
  end
  if headOut then
    local petPstIdCmp = entity:PetPstID()
    local petPstId = petPstIdCmp:GetPstID()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.InOutQueue, petPstId, true)
  end
  local materialAnimCmpt = entity:MaterialAnimationComponent()
  if materialAnimCmpt then
    materialAnimCmpt:PlayCure()
  end
  local playDmg = self._world:GetService("PlayDamage")
  if entity:PetPstID() then
    entity:Pet():GetOwnerTeamEntity()
    local teamEntity = entity:Pet():GetOwnerTeamEntity()
    playDmg:AsyncUpdateHPAndDisplayDamage(teamEntity, damageInfo)
  else
    playDmg:AsyncUpdateHPAndDisplayDamage(entity, damageInfo)
  end
  if headOut then
    local petPstIdCmp = entity:PetPstID()
    local petPstId = petPstIdCmp:GetPstID()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.InOutQueue, petPstId, false)
  end
end
