local bs_102801 = class("bs_102801", LuaSkillBase)
local base = LuaSkillBase
bs_102801.config = {
  buffId_263 = 102803,
  buffId_264 = 102804,
  buffId_zw3 = 102807,
  buffId_zw4 = 102808,
  buffId_att = 102801,
  weaponLv = 0
}

function bs_102801:ctor()
end

function bs_102801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102801_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_102801_2", 20, self.OnSetHurt, self.caster)
  self.ass_role = nil
  self.ass_pow = 0
  self.ass_skill = 0
  self.caster.recordTable.weaponLv = self.config.weaponLv
end

function bs_102801:OnAfterBattleStart()
  if LuaSkillCtrl.IsInTDBattle ~= true then
    self.caster:AddRoleProperty(eHeroAttr.attackRange, self.arglist[1] - 1, eHeroAttrType.Origin)
  else
    self.caster:AddRoleProperty(eHeroAttr.attackRange, 2, eHeroAttrType.Origin)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_att, 1)
end

function bs_102801:OnSetHurt(context)
  if context.sender == self.caster and context.skill.isCommonAttack and context.target.belongNum ~= self.caster.belongNum and (context.target ~= self.ass_role or context.target.pow ~= self.ass_pow) then
    if self.ass_role ~= nil and self.ass_role.hp > 0 then
      LuaSkillCtrl:DispelBuff(self.ass_role, self.config.buffId_263, 0, true)
      if self.config.weaponLv >= 2 then
        LuaSkillCtrl:DispelBuff(self.ass_role, self.config.buffId_zw3, 0, true)
      end
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_264, 0, true)
    if self.config.weaponLv >= 2 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_zw4, 0, true)
    end
    local num = context.target.pow * self.arglist[4] // 1000
    local min = self.caster.pow * self.arglist[5] // 1000
    if num > min then
      num = min
    end
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_263, num, nil, true)
    if self.config.weaponLv >= 2 then
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_264, num, nil, true)
    if self.config.weaponLv >= 2 then
      local num2 = context.target.skill_intensity * self.arglist[4] // 1000
      local min2 = self.caster.skill_intensity * self.arglist[5] // 1000
      if num2 > min2 then
        num2 = min2
      end
      LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_zw3, num2, nil, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_zw4, num2, nil, true)
    end
    self.ass_role = context.target
    self.ass_pow = context.target.pow
    self.ass_skill = context.target.skill_intensity
  end
end

function bs_102801:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_102801:LuaDispose()
  base.LuaDispose(self)
  self.ass_role = nil
end

return bs_102801
