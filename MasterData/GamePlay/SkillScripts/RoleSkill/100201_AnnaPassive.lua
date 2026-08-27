local bs_100201 = class("bs_100201", LuaSkillBase)
local base = LuaSkillBase
bs_100201.config = {
  effectId_trail = 100208,
  effectId_line = 100207,
  buffId_cockhourse2 = 100203,
  buffId_bk = 100204,
  buffId_cockhourse = 3010,
  buffId_dizzy = 100201,
  buffId_dizzy_cha = 100202,
  time = nil,
  tier = 1,
  tier_skill = 1,
  selectId_pass = 20,
  selectId_skill = 9,
  select_range = 15,
  weaponLv = 0
}

function bs_100201:ctor()
end

function bs_100201:InitSkill(isMidwaySkill)
  self.cockHourseBuffId = nil
  if self.config.weaponLv >= 1 then
    self.cockHourseBuffId = self.config.buffId_cockhourse2
  else
    self.cockHourseBuffId = self.config.buffId_cockhourse
  end
  self.caster.recordTable.cockBuffId = self.cockHourseBuffId
  self:AddAfterAddBuffTrigger("bs_100201_7", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.cockHourseBuffId)
  self:AddAfterHurtTrigger("bs_100201_1", 1, self.OnAfterHurt, self.caster)
  self:AddSetDeadHurtTrigger("bs_100201_3", 20, self.OnSetDeadHurt)
end

function bs_100201:OnSetDeadHurt(context)
  if self.caster == nil then
    return
  end
  if self.caster.belongNum ~= context.target.belongNum and context.target:GetBuffTier(self.cockHourseBuffId) > 0 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_pass, self.config.select_range, context.target)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role_target = targetList[i].targetRole
        if role_target.intensity ~= 0 and role_target ~= nil and 0 < role_target.hp then
          local tier = context.target:GetBuffTier(self.cockHourseBuffId)
          LuaSkillCtrl:CallEffect(targetList[i].targetRole, self.config.effectId_line, self, nil, context.target)
          LuaSkillCtrl:CallEffectWithArgOverride(targetList[i].targetRole, self.config.effectId_trail, self, context.target, false, false, self.SkillEventFunc, tier)
          break
        end
      end
    end
    LuaSkillCtrl:DispelBuff(context.target, self.cockHourseBuffId, 0, true)
  end
end

function bs_100201:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss and target.intensity ~= 0 and 0 < target.hp then
    LuaSkillCtrl:CallBuff(self, target, self.cockHourseBuffId, self.config.tier, self.config.time)
  end
  if sender == self.caster and (skill.dataId == 100202 or skill.dataId == 100205) and isTriggerSet ~= true then
    local transferList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, self.config.select_range)
    if transferList ~= 0 then
      for i = 0, transferList.Count - 1 do
        local role = transferList[i].targetRole
        if role ~= nil and role.intensity ~= 0 then
          LuaSkillCtrl:CallBuff(self, role, self.cockHourseBuffId, self.config.tier, self.config.time)
        end
      end
    end
  end
end

function bs_100201:OnAfterAddBuff(buff, target)
  local maker = buff.battleSkill.maker
  if buff.dataId == self.cockHourseBuffId and target.belongNum ~= maker.belongNum and target ~= self.caster then
    local restTier = target:GetBuffTier(self.cockHourseBuffId)
    if restTier >= self.arglist[1] and self.caster ~= nil then
      if 1 <= self.config.weaponLv then
        LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnAnnaStun, target)
        local time = self.arglist[2] + self.arglist[3]
        local Skin_ID = LuaSkillCtrl:GetCasterSkinId(maker)
        if Skin_ID == 300203 or Skin_ID == 300208 or Skin_ID == 300210 then
          LuaSkillCtrl:CallBuffLifeEvent(self, target, self.config.buffId_dizzy, self.config.tier, time, BindCallback(self, self.OnBuffLifeEvent, target))
        else
          LuaSkillCtrl:CallBuff(self, target, self.config.buffId_dizzy, self.config.tier, time)
        end
      else
        local Skin_ID = LuaSkillCtrl:GetCasterSkinId(maker)
        if Skin_ID == 300203 or Skin_ID == 300208 or Skin_ID == 300210 then
          LuaSkillCtrl:CallBuffLifeEvent(self, target, self.config.buffId_dizzy, self.config.tier, self.arglist[2], BindCallback(self, self.OnBuffLifeEvent, target))
        else
          LuaSkillCtrl:CallBuff(self, target, self.config.buffId_dizzy, self.config.tier, self.arglist[2])
        end
      end
      LuaSkillCtrl:DispelBuff(target, self.cockHourseBuffId, self.arglist[1], true)
    end
  end
end

function bs_100201:OnBuffLifeEvent(role, lifeType, arg)
  if lifeType == eBuffLifeEvent.NewAdd then
    LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(0.1, 0.9, 0.1), 0.1)
  elseif lifeType == eBuffLifeEvent.Remove then
    LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(1, 1, 1), 0.1)
  end
end

function bs_100201:SkillEventFunc(tier, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and target ~= nil then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.cockHourseBuffId, tier, self.config.time)
  end
end

function bs_100201:OnCasterDie()
  self.caster:SetRoleState(CS.eBattleRoleState.Normal)
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  LuaSkillCtrl:RemoveHandleAllTrigger(self.cskill)
  self:RemoveAllLuaTrigger()
end

return bs_100201
