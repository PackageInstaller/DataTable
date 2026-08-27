local bs_70015 = require("GamePlay.SkillScripts.MonsterSkill.70015_GaoDa1")
local bs_70018 = class("bs_70018", bs_70015)
local base = bs_70015
bs_70018.config = {
  monsterId = 1014,
  equipmentSummonerId = 1002,
  effectId = 12025
}
bs_70018.config = setmetatable(bs_70018.config, {
  __index = base.config
})

function bs_70018:ctor()
end

function bs_70018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_70018:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70018
