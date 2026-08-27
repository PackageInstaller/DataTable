local bs_101402 = require("GamePlay.SkillScripts.RoleSkill.101402_ChocoSkill")
local bs_101405 = class("bs_101405", bs_101402)
local base = bs_101402
bs_101405.config = {
  weaponLv = 2,
  buffId_choocolate = 101402,
  buffId_cookie = 101403,
  buffId_Taunt = 3002,
  effectId_CF = 123
}
bs_101405.config = setmetatable(bs_101405.config, {
  __index = base.config
})

function bs_101405:ctor()
end

function bs_101405:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_101405_1", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum, self.caster.roleType)
end

function bs_101405:OnAttackTrigger(target, data)
  if target == nil or target.hp <= 0 then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self, self.SkillEventFunc)
  if target.career == 1 then
    local range = 2
    local targetlist_enemy = LuaSkillCtrl:CallTargetSelectWithRange(self, 9, range, target)
    if targetlist_enemy ~= nil and 0 < targetlist_enemy.Count then
      for i = 0, targetlist_enemy.Count - 1 do
        if targetlist_enemy[i] ~= nil then
          LuaSkillCtrl:CallBuff(self, targetlist_enemy[i].targetRole, self.config.buffId_Taunt, 1, self.arglist[3], false, target)
        end
      end
    end
  end
end

function bs_101405:OnBuffExecute(buff, targetRole)
  if targetRole:GetBuffTier(self.config.buffId_cookie) > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
      self.arglist[6] + self.arglist[4]
    })
    skillResult:EndResult()
  end
end

function bs_101405:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target:GetBuffTier(self.config.buffId_cookie) > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_choocolate, 1, nil, true)
  end
end

function bs_101405:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101405
