_class("BuffLogicAddHPShieldHpSpilled", BuffLogicBase)
BuffLogicAddHPShieldHpSpilled = BuffLogicAddHPShieldHpSpilled

function BuffLogicAddHPShieldHpSpilled:Constructor(buffInstance, logicParam)
  self._addBuffID = logicParam.addBuffID
end

function BuffLogicAddHPShieldHpSpilled:DoLogic(notify)
  local hpSpilled = notify:GetHPSpilled()
  if not hpSpilled or hpSpilled <= 0 then
    return
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local buffInstance = buffLogicSvc:AddBuff(self._addBuffID, teamEntity, {hpSpilled = hpSpilled})
  return BuffResultAddHPShieldHpSpilled:New(buffInstance:BuffSeq())
end

function BuffLogicAddHPShieldHpSpilled:DoOverlap(logicParam)
  return self:DoLogic()
end
