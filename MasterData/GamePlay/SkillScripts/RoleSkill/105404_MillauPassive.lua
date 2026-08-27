local bs_105401 = require("GamePlay.SkillScripts.RoleSkill.105401_MillauPassive")
local bs_105404 = class("bs_105404", bs_105401)
local base = bs_105401
bs_105404.config = {
  start_cookTier = 0,
  max_cookTier = 3,
  weaponLv = 1,
  buffId_defense = 105415,
  effectID_cook01 = 105429,
  effectID_cook02 = 105430,
  effectID_cook03 = 105431
}
bs_105404.config = setmetatable(bs_105404.config, {
  __index = base.config
})

function bs_105404:ctor()
end

function bs_105404:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.OnUltSkillPlayed)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_105404_1", 1, self.BeforeEndBattle)
  self.cookeffect = nil
end

function bs_105404:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self.cook = self.config.start_cookTier
  self:CallEffect()
  self:ShowAttackCounting(self.cook)
  self.passive.delay = self.passive.delay - self.arglist[12] * self.cook
  self.passive.left = self.passive.left - self.arglist[12] * self.cook
  if self.cook ~= 0 then
    self.cookdis = LuaSkillCtrl:StartTimer(nil, self.arglist[11], self.OnCooKDisCallback, self, -1, 0)
  end
end

function bs_105404:OnCooKDisCallback()
  self.cook = self.cook - 1
  self:CallEffect()
  self:ShowAttackCounting(self.cook)
  local current_time = self.passive.delay - self.passive.left
  self.passive.delay = self.passive.delay + self.arglist[12]
  if current_time < self.passive.delay then
    self.passive.left = self.passive.delay - current_time
  end
  if self.cook <= 0 then
    if self.cookdis ~= nil then
      self.cookdis:Stop()
      self.cookdis = nil
    end
    self.cook = 0
    self.passive.delay = self.arglist[2]
  end
end

function bs_105404:OnUltSkillPlayed(role)
  if role.belongNum == self.caster.belongNum and role.roleType ~= eBattleRoleType.skillCaster then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_defense, 1, self.arglist[13])
    if self.cook < self.config.max_cookTier then
      self.cook = self.cook + 1
      self:CallEffect()
      self:ShowAttackCounting(self.cook)
      local current_time = self.passive.delay - self.passive.left
      self.passive.delay = self.passive.delay - self.arglist[12]
      if current_time < self.passive.delay then
        self.passive.left = self.passive.delay - current_time
      elseif current_time >= self.passive.delay then
        self.passive.left = 0
      end
    elseif self.cook >= self.config.max_cookTier then
      self.cookdis.left = self.arglist[11]
    end
  end
  if self.cook == 1 and self.cookdis == nil then
    self.cookdis = LuaSkillCtrl:StartTimer(nil, self.arglist[11], self.OnCooKDisCallback, self, -1, 0)
  end
  if 1 < self.cook then
    self.cookdis.left = self.cookdis.delay
  end
end

function bs_105404:AutoGive(effect, grid)
  if effect == nil or effect:IsDie() then
    return
  end
  local tempEffect = self.food_list[grid]
  if tempEffect == nil or tempEffect ~= effect then
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  if target == nil then
    return
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 501101, 20)
  local attack_int = 0
  local pass_target1
  if targetList ~= nil and 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i].targetRole
      if role.belongNum == self.caster.belongNum and (attack_int < role.pow or attack_int < role.skill_intensity) and role ~= self.caster then
        pass_target1 = role
        if role.pow >= role.skill_intensity then
          attack_int = role.pow
        else
          attack_int = role.skill_intensity
        end
      end
    end
  end
  if pass_target1 == nil then
    pass_target1 = self.caster
  end
  if pass_target1 ~= nil then
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_dandao, self, pass_target1, false, false, self.SkillEventFunc2, pass_target1)
  end
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
end

function bs_105404:Callback()
  self:AddDropEffectPick(self.caster)
  base.Callback(self)
end

function bs_105404:CallEffect()
  if self.cook <= 2 and self.cook > 0 then
    if self.cookeffect ~= nil then
      self.cookeffect:Die()
      self.cookeffect = nil
    end
    self.cookeffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectID_cook01, self)
  elseif self.cook > 2 and self.cook <= 4 then
    if self.cookeffect ~= nil then
      self.cookeffect:Die()
      self.cookeffect = nil
    end
    self.cookeffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectID_cook02, self)
  elseif self.cook == 5 then
    if self.cookeffect ~= nil then
      self.cookeffect:Die()
      self.cookeffect = nil
    end
    self.cookeffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectID_cook03, self)
  elseif self.cook <= 0 and self.cookeffect ~= nil then
    self.cookeffect:Die()
    self.cookeffect = nil
  end
end

function bs_105404:ShowAttackCounting(nowCount)
  if nowCount == 0 then
    LuaSkillCtrl:HideCounting(self.caster)
    return
  end
  if nowCount <= 2 then
    LuaSkillCtrl:ShowCounting(self.caster, nowCount, self.config.max_cookTier)
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 255, 255, 255)
    return
  end
  if nowCount == 3 or nowCount == 4 then
    LuaSkillCtrl:ShowCounting(self.caster, nowCount, self.config.max_cookTier)
    LuaSkillCtrl:SetCountingColor(self.caster, 0, 203, 250, 255)
    return
  end
  if nowCount == 5 then
    LuaSkillCtrl:ShowCounting(self.caster, nowCount, self.config.max_cookTier)
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 0, 0, 255)
    return
  end
end

function bs_105404:BeforeEndBattle()
  self:ShowAttackCounting(0)
end

function bs_105404:OnCasterDie()
  base.OnCasterDie(self)
  self:ShowAttackCounting(0)
  if self.cookdis ~= nil then
    self.cookdis:Stop()
    self.cookdis = nil
  end
end

return bs_105404
