local bs_70015 = require("GamePlay.SkillScripts.MonsterSkill.70015_GaoDa1")
local bs_70019 = class("bs_70019", bs_70015)
local base = bs_70015
bs_70019.config = {
  monsterId = 1015,
  equipmentSummonerId = 1003,
  effectId = 12025
}
bs_70019.config = setmetatable(bs_70019.config, {
  __index = base.config
})

function bs_70019:ctor()
end

function bs_70019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_70019:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70019
