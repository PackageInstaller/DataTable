local career_10006 = class("career_10006", LuaSkillBase)
local base = LuaSkillBase
career_10006.config = {buffId = 1800, effectId1 = 10993}

function career_10006:ctor()
end

function career_10006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "career_10006_22", 1, self.OnBreakShield)
  self:AddLuaTrigger(eSkillLuaTrigger.OnAddShield, self.OnAddShield)
  self:AddSetHealTriggerForTable("career_10006_10", 999, self.OnSetHeal, {
    senderBelongNum = eBattleRoleBelong.player,
    targetBelongNum = eBattleRoleBelong.player,
    extraArg2 = false
  })
end

function career_10006:OnAddShield(role, shieldType, value, addValue)
  if role.belongNum == 1 and addValue ~= 0 then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1)
  end
end

function career_10006:OnBreakShield(shieldType, sender, target)
  if target.belongNum == 1 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0)
  end
end

function career_10006:OnSetHeal(context)
  if context.sender.belongNum == 1 and (context.sender.career == 5 or context.sender.recordTable.transfCareer == 5) and self.arglist[1] == 1 and self:IsReadyToTake() and not context.isTriggerSet and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[3] and context.target.belongNum == eBattleRoleBelong.player then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
    if targetlist.Count > 0 then
      local target = targetlist[0].targetRole
      LuaSkillCtrl:CallEffect(target, self.config.effectId1, self)
      LuaSkillCtrl:RemoveLife(self.arglist[4], self, target, true, nil, true, true, eHurtType.RealDmg)
      self:OnSkillTake()
    end
  end
end

function career_10006:OnCasterDie()
  base.OnCasterDie(self)
end

return career_10006
