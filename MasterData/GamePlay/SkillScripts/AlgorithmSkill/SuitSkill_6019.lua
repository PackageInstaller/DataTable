local bs_6019 = class("bs_6019", LuaSkillBase)
local base = LuaSkillBase
bs_6019.config = {buffid = 601901}

function bs_6019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_6019_3", -1, self.OnAfterHurt, self.caster)
  self:AddAfterAddBuffTrigger("bs_601901_13", 1, self.OnAfterAddBuff, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_6019_15", 1, self.OnHurtResultStart)
  self.buffs3 = {}
end

function bs_6019:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffid then
    return
  end
  if target.belongNum ~= self.caster.belongNum and buff.buffType == 2 and table.count(self.buffs3) < self.arglist[2] and self.buffs3[buff.dataId] == nil then
    self.buffs3[buff.dataId] = buff
    local buffMger = self.caster:GetBuffComponent()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid, 1, nil)
  end
end

function bs_6019:OnHurtResultStart(skill, context)
  if skill.isCommonAttack and context.sender:GetBuffTier(self.config.buffid) >= 1 then
    context.new_config = {}
    context.new_config.extra_arg = self.config.buffid
    setmetatable(context.new_config, {
      __index = context.config
    })
  end
end

function bs_6019:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet, extraArg)
  if extraArg == nil or extraArg ~= self.config.buffid then
    return
  end
  if sender == self.caster and skill.isCommonAttack then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid, 0, true)
    self.buffs3 = {}
  end
end

function bs_6019:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6019
