local bs_301102 = require("GamePlay.SkillScripts.MonsterSkill.301102_Control2")
local bs_206510 = class("bs_206510", bs_301102)
local base = bs_301102
bs_206510.config = {
  deathRoleId = 40032,
  monsterId = 36,
  effectId = 10264,
  selfDeathTime = 5
}
bs_206510.config = setmetatable(bs_206510.config, {
  __index = base.config
})

function bs_206510:ctor()
end

function bs_206510:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_206510:OnAfterBattleStart()
end

function bs_206510:Death()
  LuaSkillCtrl:RemoveLife(self.caster.hp + 1, self, self.caster, true, nil, false, true)
end

function bs_206510:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_206510
