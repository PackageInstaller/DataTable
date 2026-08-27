local bs_104601 = require("GamePlay.SkillScripts.RoleSkill.104601_HazePassive")
local bs_104604 = class("bs_104604", bs_104601)
local base = bs_104601
bs_104604.config = {weaponLv = 1}
bs_104604.config = setmetatable(bs_104604.config, {
  __index = base.config
})

function bs_104604:ctor()
end

function bs_104604:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104604:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104604
