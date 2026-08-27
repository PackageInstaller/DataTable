local bs_101401 = require("GamePlay.SkillScripts.RoleSkill.101401_ChocoPassive")
local bs_101404 = class("bs_101404", bs_101401)
local base = bs_101401
bs_101404.config = {weaponLv = 1, effect_heal = 101417}
bs_101404.config = setmetatable(bs_101404.config, {
  __index = base.config
})

function bs_101404:ctor()
end

function bs_101404:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101404:OnAfterBattleStart()
  self.passive = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    local num = self.caster:GetBuffTier(self.config.buffId_choocolate) * (self.arglist[4] + self.arglist[2])
    local UltMp = self.caster:GetBuffTier(self.config.buffId_choocolate) * self.arglist[3] / 1000 * ConfigData.game_config.ultMpCost
    local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId_pass, 2)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local target = targetList[i].targetRole
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {num})
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(target, self.config.effectId_passive, self)
      end
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect_heal, self)
    LuaSkillCtrl:CallAddPlayerHmp(UltMp)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_choocolate, 0, true)
  end, self, -1)
end

function bs_101404:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_choocolate, 1, nil, true)
  end
end

function bs_101404:OnCasterDie()
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
  base.OnCasterDie(self)
end

return bs_101404
