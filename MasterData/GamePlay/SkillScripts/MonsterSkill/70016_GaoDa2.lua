local bs_70015 = require("GamePlay.SkillScripts.MonsterSkill.70015_GaoDa1")
local bs_70016 = class("bs_70016", bs_70015)
local base = bs_70015
bs_70016.config = {monsterId = 1012, equipmentSummonerId = 1003}
bs_70016.config = setmetatable(bs_70016.config, {
  __index = base.config
})

function bs_70016:ctor()
end

function bs_70016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_70016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70016
