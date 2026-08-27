local bs_70010 = require("GamePlay.SkillScripts.MonsterSkill.70010_Core1_Equip")
local bs_70014 = class("bs_70014", bs_70010)
local base = bs_70010
bs_70014.config = {
  equipmentSummonerId = 1004,
  buffId_mark = 1233,
  skillId = 70025
}
bs_70014.config = setmetatable(bs_70014.config, {
  __index = base.config
})

function bs_70014:ctor()
end

function bs_70014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_70014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70014
