local bs_101401 = require("GamePlay.SkillScripts.RoleSkill.101401_ChocoPassive")
local bs_101406 = class("bs_101406", bs_101401)
local base = bs_101401
bs_101406.config = {
  weaponLv = 3,
  effect_heal = 101417,
  effect_jishu1 = 101418,
  effect_jieshu = 101419,
  buffId_Ult = 104905
}
bs_101406.config = setmetatable(bs_101406.config, {
  __index = base.config
})

function bs_101406:ctor()
end

function bs_101406:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.OnUltSkillPlayed)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_101406_4", 1, self.BeforeEndBattle)
  self.lastUltRole = nil
  self.UltNum = 0
end

function bs_101406:OnAfterBattleStart()
  self.passive = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    local num = self.caster:GetBuffTier(self.config.buffId_choocolate) * self.arglist[4]
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

function bs_101406:OnUltSkillPlayed(role)
  local isLastUltRoleUltTaked = role == self.lastUltRole
  if role.belongNum == self.caster.belongNum and role.roleType ~= eBattleRoleType.skillCaster then
    self.UltNum = self.UltNum + 1
    self.Mask = LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Ult, 1)
    if self.caster:GetBuffTier(self.config.buffId_Ult) == 1 then
      self.MaskEffect = self.Mask.listBattleEffect[0]
    end
    local MaskEffectNum = self.caster:GetBuffTier(self.config.buffId_Ult) - 1
    LuaSkillCtrl:EffectSetCountActive(self.MaskEffect, MaskEffectNum, true)
  end
end

function bs_101406:BeforeEndBattle()
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.UltNum * self.arglist[5] / 1000)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_jieshu, self)
end

function bs_101406:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101406
