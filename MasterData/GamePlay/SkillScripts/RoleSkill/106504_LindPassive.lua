local bs_106501 = require("GamePlay.SkillScripts.RoleSkill.106501_LindPassive")
local bs_106504 = class("bs_106504", bs_106501)
local base = bs_106501
bs_106504.config = {
  weaponLv = 1,
  buffId_5 = 106506,
  buff_id_res = 106510,
  hurt_config = {crit_formula = 10003}
}
bs_106504.config = setmetatable(bs_106504.config, {
  __index = base.config
})

function bs_106504:ctor()
end

function bs_106504:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_106504_01", 1, self.OnAfterHurt, {
    sender = self.caster,
    targetBelongNum = eBattleRoleBelong.enemy,
    extraArg2 = false
  })
  self:AddSetHurtTrigger("bs_106504_02", 2, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.enemy)
  self:AddBuffDieTrigger("bs_106504_03", 3, self.OnBuffDie, self.caster, nil, self.config.buffId_5)
  self:AddHurtResultStartTrigger("bs_106504_01", 4, self.OnHurtResultStart, self.caster, nil, nil, eBattleRoleBelong.enemy)
  self.healNum = 0
end

function bs_106504:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.skillType == eBattleSkillLogicType.Original then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_id_res, 1, self.arglist[15])
  end
end

function bs_106504:OnSetHurt(context)
  if self.caster:GetBuffTier(self.config.buffId_5) > 0 then
    self.healNum = self.healNum + context.hurt * self.arglist[16] // 1000
  end
end

function bs_106504:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_5 and target == self.caster then
    LuaSkillCtrl:CallHeal(self.healNum, self, self.caster, true)
    self.healNum = 0
  end
end

function bs_106504:OnHurtResultStart(skill, context)
  if LuaSkillCtrl:RoleContainsCtrlBuff(context.target) and context.sender == self.caster and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.hurt_type ~= 2 then
    context.new_config = self.config.hurt_config
    setmetatable(context.new_config, {
      __index = context.config
    })
    return
  end
end

function bs_106504:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106504
