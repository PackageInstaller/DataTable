_class("BuffViewDeathInstant", BuffViewBase)
BuffViewDeathInstant = BuffViewDeathInstant

function BuffViewDeathInstant:PlayView(TT)
  local entity = self._entity
  local result = self._buffResult
  local hasDead = result:GetIsDead()
  if hasDead then
    entity:AddDeadFlag()
    local hasBoss = entity:HasBoss()
    local buffCmpt = entity:BuffView()
    local curShowBossHP = buffCmpt and buffCmpt:HasBuffEffect(BuffEffectType.CurShowBossHP)
    if hasBoss or curShowBossHP then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossRedHp, entity:GetID(), 0, 0, 1)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossWhiteHp, entity:GetID(), 0, 0, 1)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossShield, entity:GetID(), 0)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossGreyHP, entity:GetID(), 0, 1)
    end
    local targetEffectID = self:BuffViewInstance():BuffConfigData():GetExecEffectID()
    if targetEffectID then
      local effectService = self._world:GetService("Effect")
      local effectEntity = effectService:CreateEffect(targetEffectID, entity)
      YIELD(TT, 1000)
    end
    local sMonsterShowRender = self._world:GetService("MonsterShowRender")
    sMonsterShowRender:_DoOneMonsterDead(TT, entity)
  end
end

function BuffViewDeathInstant:IsNotifyMatch(notify)
  if self._buffResult:GetCasterID() == notify:GetNotifyEntity():GetID() then
    return true
  end
  return false
end
