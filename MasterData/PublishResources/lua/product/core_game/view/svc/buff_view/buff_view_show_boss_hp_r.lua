_class("BuffViewShowBossHp", BuffViewBase)
BuffViewShowBossHp = BuffViewShowBossHp

function BuffViewShowBossHp:PlayView(TT)
  local entityWork = self._entity
  local bossIds = SortedArray:New(Algorithm.COMPARE_CUSTOM, self.SortBosses)
  local cMonsterId = entityWork:MonsterID()
  local templateId = cMonsterId:GetMonsterID()
  local sepHPList = entityWork:HP():GetHPLockSepList()
  local redHp = entityWork:HP():GetRedHP()
  local maxHP = entityWork:HP():GetMaxHP()
  local percent = redHp / maxHP
  local buffView = entityWork:BuffView()
  if not buffView:HasBuffEffect(BuffEffectType.NotShowBossHP) then
    local hpBarType
    if entityWork:MonsterID():IsEliteMonster() then
      hpBarType = HPBarType.EliteBoss
    else
      hpBarType = HPBarType.Boss
    end
    local id = {
      pstId = entityWork:GetID(),
      tplId = templateId,
      isVice = false,
      sepHPList = sepHPList,
      percent = percent,
      entity = entityWork,
      HPBarType = hpBarType,
      hpEnergyVal = 0,
      maxHPEnergyVal = 0
    }
    bossIds:Insert(id)
  end
  if bossIds:Size() == 1 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowBossHp, bossIds)
  end
end

function BuffViewShowBossHp:IsNotifyMatch(notify)
  local result = self._buffResult
  local isMatch = result:GetEntityID() == self._entity:GetID()
  return isMatch
end
