local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1001012 = class("bs_1001012", base)
bs_1001012.config = {
  effectId_trail = 100208,
  effectId_line = 100207,
  buffId_cockhourse = 3010,
  buffId_dizzy = 100201,
  time = nil,
  tier = 1,
  tier_skill = 1,
  selectId_pass = 20,
  selectId_skill = 29,
  select_range = 10
}

function bs_1001012:ctor()
end

function bs_1001012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_1001012_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_cockhourse)
  self:AddAfterHurtTrigger("bs_1001012_1", 1, self.OnAfterHurt, self.caster)
  self:AddSetDeadHurtTrigger("bs_1001012_3", 20, self.OnSetDeadHurt)
end

function bs_1001012:OnSetDeadHurt(context)
  if self.caster == nil then
    return
  end
  if self.caster.belongNum ~= context.target.belongNum and context.target:GetBuffTier(self.config.buffId_cockhourse) > 0 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_pass, self.config.select_range, context.target)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role_target = targetList[i].targetRole
        if role_target.intensity ~= 0 then
          local tier = context.target:GetBuffTier(self.config.buffId_cockhourse)
          LuaSkillCtrl:CallEffect(targetList[i].targetRole, self.config.effectId_line, self, nil, context.target)
          LuaSkillCtrl:CallEffectWithArgOverride(targetList[i].targetRole, self.config.effectId_trail, self, context.target, false, false, self.SkillEventFunc, tier)
          break
        end
      end
    end
    LuaSkillCtrl:DispelBuff(context.target, self.config.buffId_cockhourse, 0, true)
  end
end

function bs_1001012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss and target.intensity ~= 0 and 0 < target.hp then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_cockhourse, self.config.tier, self.config.time)
  end
  if sender == self.caster and skill.dataId == 100202 and isTriggerSet ~= true then
    local transferList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, self.config.select_range)
    if transferList ~= 0 then
      for i = 0, transferList.Count - 1 do
        local role = transferList[i].targetRole
        if role ~= nil and role.intensity ~= 0 then
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_cockhourse, self.config.tier_skill, self.config.time)
        end
      end
    end
  end
end

function bs_1001012:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_cockhourse then
    local restTier = target:GetBuffTier(self.config.buffId_cockhourse)
    if restTier >= self.arglist[1] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_dizzy, self.config.tier, self.arglist[2])
      LuaSkillCtrl:DispelBuff(target, self.config.buffId_cockhourse, self.arglist[1], true)
    end
  end
end

function bs_1001012:SkillEventFunc(tier, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_cockhourse, tier, self.config.time)
  end
end

function bs_1001012:OnCasterDie()
  self.caster:SetRoleState(CS.eBattleRoleState.Normal)
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
end

return bs_1001012
