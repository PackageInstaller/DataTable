local bs_70010 = require("GamePlay.SkillScripts.MonsterSkill.70010_Core1_Equip")
local bs_70013 = class("bs_70013", bs_70010)
local base = bs_70010
bs_70013.config = {
  equipmentSummonerId = 1003,
  buffId_mark = 1232,
  skillId = 70024
}
bs_70013.config = setmetatable(bs_70013.config, {
  __index = base.config
})

function bs_70013:ctor()
end

function bs_70013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_70013:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70013
