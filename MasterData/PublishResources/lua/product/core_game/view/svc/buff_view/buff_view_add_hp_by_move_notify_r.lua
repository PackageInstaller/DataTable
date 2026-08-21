_class("BuffViewAddHPByMoveNotify", BuffViewBase)
BuffViewAddHPByMoveNotify = BuffViewAddHPByMoveNotify

function BuffViewAddHPByMoveNotify:Constructor()
end

function BuffViewAddHPByMoveNotify:IsNotifyMatch(notify)
  if notify and (notify:GetNotifyType() == NotifyType.EntityMoveEnd or notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd) then
    local n = notify
    local ntPosNew = n:GetPosNew()
    local resPosNew = self._buffResult:GetPosNew()
    if ntPosNew and resPosNew and ntPosNew == resPosNew then
      return true
    end
    return false
  end
  return true
end

function BuffViewAddHPByMoveNotify:PlayView(TT)
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
