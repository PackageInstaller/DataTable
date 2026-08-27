local bs_70010 = require("GamePlay.SkillScripts.MonsterSkill.70010_Core1_Equip")
local bs_70012 = class("bs_70012", bs_70010)
local base = bs_70010
bs_70012.config = {
  equipmentSummonerId = 1002,
  buffId_mark = 1231,
  skillId = 70023
}
bs_70012.config = setmetatable(bs_70012.config, {
  __index = base.config
})

function bs_70012:ctor()
end

function bs_70012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_70012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70012
