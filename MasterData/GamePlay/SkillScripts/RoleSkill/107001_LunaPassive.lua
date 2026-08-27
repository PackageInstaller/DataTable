local bs_107001 = class("bs_107001", LuaSkillBase)
local base = LuaSkillBase
bs_107001.config = {
  effect_triger = 107012,
  buff_rune_blue = 107001,
  buff_rune_red = 107002,
  buff_rune_red_count = 107003,
  hurtConfig = 5,
  effectId_skill = 107001,
  buff_rune_blue_count = 107005,
  buffId_fly = 502101
}

function bs_107001:ctor()
end

function bs_107001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_107001_1", 1, self.OnAfterHurt, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil, nil, false)
  self:AddAfterAddBuffTrigger("bs_107001_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, eBattleRoleBelong.enemy, self.config.buff_rune_red_count)
  self:AddOnRoleDieTrigger("bs_107001_3", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_107001_4", 1, self.BeforeEndBattle)
  self.max_rune_blue = self.arglist[2]
  self.caster.recordTable.damge_Ex = self.arglist[4]
  self.caster.recordTable.cost_rune_blue = self.arglist[3]
  self.caster.recordTable.damge_Ex_upgrade = self.arglist[6]
  self.caster.recordTable.damge_Ex_upgrade_times = self.arglist[7]
  self:ShowAttackCounting(0)
end

function bs_107001:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if skill.skillType == eBattleSkillLogicType.Original and (skill.isNormalSkill or skill.isUltSkill) and isMiss == false and not LuaSkillCtrl:GetRoleBuffById(target, self.config.buffId_fly) and isTriggerSet ~= true then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_rune_blue_count, self.arglist[1], 9999, true)
    local num_buff_rune_blue = self.caster:GetBuffTier(self.config.buff_rune_blue_count)
    self:ShowAttackCounting(num_buff_rune_blue)
    if num_buff_rune_blue >= self.max_rune_blue then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_rune_blue, 1, 15, true)
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnPlaylunaExSkill)
      num_buff_rune_blue = self.caster:GetBuffTier(self.config.buff_rune_blue_count)
      self:ShowAttackCounting(num_buff_rune_blue)
    end
  end
end

function bs_107001:OnAfterAddBuff(buff, target)
  local num_buff_rune_red_count = target:GetBuffTier(self.config.buff_rune_red_count)
  if num_buff_rune_red_count >= self.caster.recordTable.maxnum_rune_red then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_rune_red, 1, 120, true)
    local curtime = self.caster.recordTable.curtime_max_rune_red
    local skills = LuaSkillCtrl:GetAllUltSkills()
    if skills ~= nil then
      local skillcount = skills.Count
      if 0 < skillcount then
        for i = 0, skillcount - 1 do
          if skills[i].funcHeroId == self.caster.roleDataId then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curtime)
          end
        end
      end
    end
  end
end

function bs_107001:OnRoleDie(killer, role)
  if role:GetBuffTier(self.config.buff_rune_red_count) > 0 and role.hp == 0 and role ~= nil and role.belongNum == eBattleRoleBelong.enemy then
    local num = role:GetBuffTier(self.config.buff_rune_red_count)
    local num1, num2 = math.modf(num / 2)
    local num_t = num1
    if num2 ~= 0 then
      num_t = num1 + 1
    end
    local target = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
    if target ~= nil then
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_skill, self, role, false, false, self.OnEffectTrigger, num_t)
    end
  end
end

function bs_107001:OnEffectTrigger(num, effect, eventId, target)
  if effect.dataId == self.config.effectId_skill and eventId == eBattleEffectEvent.Trigger and target ~= nil then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_rune_red, num, self.caster.recordTable.time_rune_red, true)
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_rune_red_count, num, self.caster.recordTable.time_rune_red, true)
  end
end

function bs_107001:ShowAttackCounting(nowCount)
  if nowCount == 0 then
    LuaSkillCtrl:HideCounting(self.caster)
    return
  end
  if nowCount < self.max_rune_blue then
    LuaSkillCtrl:ShowCounting(self.caster, nowCount, self.max_rune_blue)
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 255, 255, 255)
  end
  if nowCount == self.max_rune_blue then
    LuaSkillCtrl:ShowCounting(self.caster, nowCount, self.caster.max_rune_blue)
    LuaSkillCtrl:SetCountingColor(self.caster, 0, 203, 250, 255)
  end
end

function bs_107001:BeforeEndBattle()
  self:ShowAttackCounting(0)
end

function bs_107001:OnCasterDie()
  base.OnCasterDie(self)
  self:ShowAttackCounting(0)
end

return bs_107001
