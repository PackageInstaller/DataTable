local bs_104301 = class("bs_104301", LuaSkillBase)
local base = LuaSkillBase
bs_104301.config = {
  buff_ReduceDef = 104301,
  buff_IncreaseDef = 104302,
  buff_ReduceMagicRes = 104303,
  buff_IncreaseMagicRes = 104304,
  effectId_Suck = 104307
}

function bs_104301:ctor()
end

function bs_104301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_104301_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_104301_2", 1, self.OnAfterPlaySkill)
  self:AddBuffDieTrigger("bs_104301_2", 1, self.OnBuffDie)
  self.AttackCount = 0
end

function bs_104301:OnSetHurt(context)
  local buffs = LuaSkillCtrl:GetRoleBuffById(context.target, self.config.buff_ReduceDef)
  if buffs ~= nil then
    LuaSkillCtrl:DispelBuff(context.target, self.config.buff_ReduceDef, 0)
    LuaSkillCtrl:DispelBuff(context.target, self.config.buff_ReduceMagicRes, 0)
  end
  if context.sender == self.caster and context.skill.isCommonAttack and context.target.belongNum ~= self.caster.belongNum and 0 < context.target.intensity then
    local DefNum = context.target.def * self.arglist[1] // 1000
    local MagicNum = context.target.magic_res * self.arglist[1] // 1000
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId_Suck, self)
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buff_ReduceDef, DefNum, self.arglist[2], true)
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buff_ReduceMagicRes, MagicNum, self.arglist[2], true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_IncreaseDef, DefNum, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_IncreaseMagicRes, MagicNum, nil, true)
  end
end

function bs_104301:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buff_ReduceDef then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_IncreaseDef, buff.tier)
  end
  if buff.dataId == self.config.buff_ReduceMagicRes then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_IncreaseMagicRes, buff.tier)
  end
end

function bs_104301:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    self.AttackCount = self.AttackCount + 1
    if self.AttackCount == self.arglist[3] then
      self.caster.recordTable.Aoe = true
      self.AttackCount = -1
    end
  end
end

function bs_104301:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_104301:LuaDispose()
  base.LuaDispose(self)
end

return bs_104301
