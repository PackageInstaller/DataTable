local bs_70015 = require("GamePlay.SkillScripts.MonsterSkill.70015_GaoDa1")
local bs_70020 = class("bs_70020", bs_70015)
local base = bs_70015
bs_70020.config = {
  monsterId = 1016,
  equipmentSummonerId = 1004,
  effectId = 12025
}
bs_70020.config = setmetatable(bs_70020.config, {
  __index = base.config
})

function bs_70020:ctor()
end

function bs_70020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_70020:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70020
