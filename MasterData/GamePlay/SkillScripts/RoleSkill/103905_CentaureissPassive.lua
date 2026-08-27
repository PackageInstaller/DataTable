local bs_103905 = class("bs_103905", LuaSkillBase)
local base = LuaSkillBase
bs_103905.config = {
  buffId_back = 151,
  buffId_dizzy = 66,
  effectId_high = 103904,
  audioId1 = 103901,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    returndamage_formula = 0
  },
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  HurtConfig = 2,
  effectId_hit = 103907,
  buff_resistance = 103903
}

function bs_103905:ctor()
end

function bs_103905:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_103901_3", 1, self.OnAfterHurt, self.caster)
  self:AddAfterAddBuffTrigger("bs_103901_4", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.config.buffId_dizzy)
  self.attackNum = 0
end

function bs_103905:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender ~= self.caster then
    return
  end
  local isHasBuff = target:GetBuffTier(self.config.buff_resistance) > 0
  if not isTriggerSet and isHasBuff and isMiss ~= true and skill.skillType == eBattleSkillLogicType.Original then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {
      self.arglist[5]
    }, true, nil)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self, nil, nil, nil, true)
  end
  if skill.isCommonAttack and isHasBuff and isMiss ~= true then
    local skills = self.caster:GetBattlePassiveSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], self.arglist[7])
        end
      end
    end
  end
  if not isTriggerSet and target.belongNum == eBattleRoleBelong.enemy then
    self.attackNum = self.attackNum + 1
    if self.attackNum == self.arglist[3] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buff_resistance, 1, self.arglist[4], false)
      self.attackNum = 0
    end
  end
  if skill.isCommonAttack and self:IsReadyToTake() then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_high, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
    for i = 0, skillResult.roleList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_dizzy, 1, self.arglist[2])
    end
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    self:OnSkillTake()
  end
end

function bs_103905:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_dizzy and LuaSkillCtrl:RoleContainsCtrlBuff(target) and target.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_resistance, 1, self.arglist[4], false)
  end
end

function bs_103905:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103905
