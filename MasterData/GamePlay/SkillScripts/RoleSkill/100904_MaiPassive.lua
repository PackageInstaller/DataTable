local bs_100901 = require("GamePlay.SkillScripts.RoleSkill.100901_MaiPassive")
local bs_100904 = class("bs_100904", bs_100901)
local base = bs_100901
bs_100904.config = {
  Role_id = 1009,
  extra_skill = 100907,
  weaponLv = 1,
  buffId = 100902,
  buffId2 = 100903,
  buffIdAwake = 100904,
  selectId = 80
}
bs_100904.config = setmetatable(bs_100904.config, {
  __index = base.config
})

function bs_100904:ctor()
end

function bs_100904:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:AddExtraAddSkill(self.config.extra_skill, self.level)
  self.caster.recordTable.weaponLv = self.config.weaponLv
end

function bs_100904:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 20)
  if highAttRole == nil then
    return
  end
  local role = highAttRole[0].targetRole
  if self.config.weaponLv >= 3 then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId2, 1, nil, true)
  else
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil, true)
  end
  LuaSkillCtrl:StartTimer(self, 15, function()
    LuaSkillCtrl:CallBuff(self, role, self.config.buffIdAwake, 1, nil)
  end, self, 0)
end

function bs_100904:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100904
