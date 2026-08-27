local bs_70015 = require("GamePlay.SkillScripts.MonsterSkill.70015_GaoDa1")
local bs_70017 = class("bs_70017", bs_70015)
local base = bs_70015
bs_70017.config = {monsterId = 1013, equipmentSummonerId = 1004}
bs_70017.config = setmetatable(bs_70017.config, {
  __index = base.config
})

function bs_70017:ctor()
end

function bs_70017:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_70017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70017
