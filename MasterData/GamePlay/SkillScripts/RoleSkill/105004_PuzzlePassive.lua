local bs_105001 = require("GamePlay.SkillScripts.RoleSkill.105001_PuzzlePassive")
local bs_105004 = class("bs_105004", bs_105001)
local base = bs_105001
bs_105004.config = {weaponLv = 1}
bs_105004.config = setmetatable(bs_105004.config, {
  __index = base.config
})

function bs_105004:ctor()
end

function bs_105004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105004
