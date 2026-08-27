local bs_107402 = require("GamePlay.SkillScripts.RoleSkill.107402_HubbleSkill")
local bs_107404 = class("bs_107404", bs_107402)
local base = bs_107402
bs_107404.config = {
  weaponLv = 1,
  HurtConfig = 14,
  effectId_trail_hit2 = 107417
}
bs_107404.config = setmetatable(bs_107404.config, {
  __index = base.config
})

function bs_107404:ctor()
end

function bs_107404:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetDeadHurt, "bs_107404_1", 1, self.OnSetDeadHurt)
  self:AddOnRoleDieTrigger("bs_107404_3", 99, self.OnRoleDie, nil, nil, nil, nil)
  self.hurt = 0
end

function bs_107404:OnSetDeadHurt(context)
  if context.skill.isNormalSkill and context.sender == self.caster and not context.isTriggerSet and self.caster.recordTable.tar == context.target then
    self.hurt = (context.hurt - context.target._curHp) * self.arglist[8] // 1000
  end
end

function bs_107404:OnRoleDie(killer, role, skill)
  if killer == self.caster and skill == self.cskill and self.hurt > 0 and self.caster.recordTable.tar == role then
    local targetlist = LuaSkillCtrl:FindRolesAroundRole(role)
    if targetlist ~= nil and 0 < targetlist.Count then
      LuaSkillCtrl:CallEffect(role, self.config.effectId_trail_hit2, self, nil, nil, nil, true)
      for i = targetlist.Count - 1, 0, -1 do
        local role = targetlist[i]
        if role.belongNum ~= eBattleRoleBelong.player then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {
            self.hurt
          }, true, false, nil, 103)
          skillResult:EndResult()
        end
      end
    end
  end
end

function bs_107404:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107404
