local bs_105002 = require("GamePlay.SkillScripts.RoleSkill.105002_PuzzleSkill")
local bs_105005 = class("bs_105005", bs_105002)
local base = bs_105002
bs_105005.config = {weaponLv = 2}
bs_105005.config = setmetatable(bs_105005.config, {
  __index = base.config
})

function bs_105005:ctor()
end

function bs_105005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105005
