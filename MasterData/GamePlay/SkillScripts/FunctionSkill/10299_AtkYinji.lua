local bs_10299 = class("bs_10299", LuaSkillBase)
local base = LuaSkillBase
bs_10299.config = {buffId_shixue = 257}

function bs_10299:ctor()
end

function bs_10299:InitSkill(isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_10299_1", 10, self.OnSetHurt, {
    sender = self.caster,
    targetBelongNum = 0,
    extraArg1 = eSkillTag.commonAttack,
    extraArg2 = false,
    extraArg3 = false
  })
  self.attackNum = 0
end

function bs_10299:OnSetHurt(context)
  if context.skill.isCommonAttack and not context.isMiss and context.sender == self.caster and context.isTriggerSet ~= true and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    if context.target.belongNum == 0 and context.target.career == 1 then
      return
    end
    self.attackNum = self.attackNum + 1
    self:CheckAndAddBuffToTarget(context.sender)
  end
end

function bs_10299:CheckAndAddBuffToTarget(sender)
  if sender ~= nil and sender.hp > 0 and self.attackNum >= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId_shixue, self.arglist[2])
    self.attackNum = 0
  end
end

function bs_10299:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10299
