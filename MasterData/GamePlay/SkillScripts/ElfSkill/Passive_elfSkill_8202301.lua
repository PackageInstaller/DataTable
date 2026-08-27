local bs_8202301 = class("bs_8202301", LuaSkillBase)
local base = LuaSkillBase
bs_8202301.config = {
  buff_ranjie = 107101,
  buff_zibao = 715,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  hurtConfig = 3,
  buff_ExSkill = 703,
  effect_id = 605
}

function bs_8202301:ctor()
end

function bs_8202301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_8202301_1", 2, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.enemy, nil)
  self:AddAfterAddBuffTrigger("bs_8202301_2", 1, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, self.config.buff_ranjie)
  self:AddBeforeBuffDispelTrigger("bs_8202301_3", 1, self.OnBeforBuffDispel, nil, eBattleRoleBelong.enemy, self.config.buff_ranjie)
  self:AddBuffDieTrigger("bs_8202301_4", 1, self.OnBuffDie, nil, eBattleRoleBelong.enemy, self.config.buff_ranjie)
end

function bs_8202301:OnAfterAddBuff(buff, target)
  if target ~= nil and target.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_zibao, 1, nil, true)
  end
end

function bs_8202301:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buff_ranjie and target ~= nil and target.belongNum ~= eBattleRoleBelong.neutral and target.hp > 0 and target:GetBuffTier(self.config.buff_zibao) >= 1 then
    LuaSkillCtrl:DispelBuff(target, self.config.buff_zibao, 0)
  end
end

function bs_8202301:OnBeforBuffDispel(target, context)
  if context.buffId == self.config.buff_ranjie and target ~= nil and target.belongNum ~= eBattleRoleBelong.neutral and target:GetBuffTier(self.config.buff_zibao) >= 1 then
    LuaSkillCtrl:DispelBuff(target, self.config.buff_zibao, 0)
  end
end

function bs_8202301:OnRoleDie(killer, role)
  if role:GetBuffTier(self.config.buff_zibao) >= 1 then
    if role.hp <= 0 and role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral then
      LuaSkillCtrl:CallEffect(role, self.config.effect_id, self)
      LuaSkillCtrl:StartTimer(nil, 12, function()
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, self.config.aoe_config)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
          self.arglist[1]
        }, true)
        skillResult:EndResult()
      end)
    end
    LuaSkillCtrl:DispelBuff(role, self.config.buff_ranjie, 0)
    LuaSkillCtrl:DispelBuff(role, self.config.buff_zibao, 0)
  end
end

function bs_8202301:OnCasterDie()
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
  if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
    local target = highAttRole[0].targetRole
    if target ~= nil and 0 < target.hp and target.roleType == 1 and target ~= self.caster then
      LuaSkillCtrl:CallBuff(self, target, self.config.buff_ExSkill, 1, nil, true)
    end
  end
  base.OnCasterDie(self)
end

return bs_8202301
