local bs_105505 = require("GamePlay.SkillScripts.RoleSkill.105505_HannahPassive")
local bs_105506 = class("bs_105506", bs_105505)
local base = bs_105505
bs_105506.config = {
  buffId_focus = 105501,
  buffid_damageUp = 105510,
  weaponLv = 3
}
bs_105506.config = setmetatable(bs_105506.config, {
  __index = base.config
})

function bs_105506:ctor()
end

function bs_105506:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_105506_2", 4, self.OnAfterAddBuff, self.caster, nil, nil, eBattleRoleBelong.enemy, self.config.buffId_focus)
  self:AddBuffDieTrigger("bs_105506_2", 10, self.OnBuffDie, nil, eBattleRoleBelong.enemy, self.config.buffId_focus)
end

function bs_105506:OnAfterAddBuff(buff, target)
  if target ~= nil and target.hp > 0 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffid_damageUp, 1)
  end
end

function bs_105506:OnBuffDie(buff, target, removeType)
  if target ~= nil and target.hp > 0 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffid_damageUp, 1)
  end
end

return bs_105506
