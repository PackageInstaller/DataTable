local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1029012 = class("bs_1029012", base)
bs_1029012.config = {
  buffId_blind = 3012,
  buffId_oldBlind = 115,
  buffId_attackSpeedUp = 102900,
  selectId_pass = 5
}

function bs_1029012:ctor()
end

function bs_1029012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_1029012_2", 1, self.OnAfterAddBuff, nil, nil, nil, 2, nil, 2)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_1029012_buffDie", 1, self.OnBuffDie)
  self:AddAfterHurtTrigger("bs_1029012_3", 1, self.OnAfterHurt, self.caster)
  self.tiers = 0
end

function bs_1029012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] and sender == self.caster and skill.isCommonAttack == true and target ~= nil and target.hp > 0 and target.belongNum ~= self.caster.belongNum and target.intensity ~= 0 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_blind, 1, self.arglist[3])
  end
end

function bs_1029012:OnAfterAddBuff(buff, target, isOverlay)
  if buff.dataId == self.config.buffId_oldBlind or buff.dataId == 3012 then
    local tier = 0
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_pass, 10)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        if 0 < role:GetBuffTier(self.config.buffId_oldBlind) and role.belongNum ~= self.caster.belongNum then
          tier = tier + 1
        end
        if 0 < role:GetBuffTier(self.config.buffId_blind) and role.belongNum ~= self.caster.belongNum then
          tier = tier + 1
        end
      end
    end
    if 10 < tier then
      tier = 10
    end
    if tier ~= self.tiers then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_attackSpeedUp, 0, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackSpeedUp, tier, nil, true)
      self.tiers = tier
    end
  end
end

function bs_1029012:OnBuffDie(buff, target, removeType)
  if (buff.dataId == self.config.buffId_oldBlind or buff.dataId == 3012) and removeType ~= eBuffRemoveType.Conflict then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_attackSpeedUp, 1, true)
    self.tiers = self.tiers - 1
  end
end

function bs_1029012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1029012
