local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1028012 = class("bs_1028012", base)
bs_1028012.config = {
  buffId_263 = 102803,
  buffId_264 = 102804,
  buffId_att = 102801
}

function bs_1028012:ctor()
end

function bs_1028012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1028012_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_1028012_2", 20, self.OnSetHurt, self.caster)
  self.ass_role = nil
  self.ass_pow = 0
end

function bs_1028012:OnAfterBattleStart()
  if LuaSkillCtrl.IsInTDBattle ~= true then
    self.caster:AddRoleProperty(eHeroAttr.attackRange, self.arglist[1] - 1, eHeroAttrType.Origin)
  else
    self.caster:AddRoleProperty(eHeroAttr.attackRange, 2, eHeroAttrType.Origin)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_att, 1)
end

function bs_1028012:OnSetHurt(context)
  if context.sender == self.caster and context.skill.isCommonAttack and context.target.belongNum ~= self.caster.belongNum and (context.target ~= self.ass_role or context.target.pow ~= self.ass_pow) then
    if self.ass_role ~= nil and self.ass_role.hp > 0 then
      LuaSkillCtrl:DispelBuff(self.ass_role, self.config.buffId_263, 0, true)
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_264, 0, true)
    local num = context.target.pow * self.arglist[4] // 1000
    local min = self.caster.pow * self.arglist[5] // 1000
    if num > min then
      num = min
    end
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_263, num, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_264, num, nil, true)
    self.ass_role = context.target
    self.ass_pow = context.target.pow
  end
end

function bs_1028012:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_1028012:LuaDispose()
  base.LuaDispose(self)
  self.ass_role = nil
end

return bs_1028012
