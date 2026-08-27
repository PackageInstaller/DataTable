local bs_70010 = require("GamePlay.SkillScripts.MonsterSkill.70010_Core1_Equip")
local bs_70011 = class("bs_70011", bs_70010)
local base = bs_70010
bs_70011.config = {
  equipmentSummonerId = 1001,
  buffId_mark = 1235,
  skillId = 70027
}
bs_70011.config = setmetatable(bs_70011.config, {
  __index = base.config
})

function bs_70011:ctor()
end

function bs_70011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_70011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70011
