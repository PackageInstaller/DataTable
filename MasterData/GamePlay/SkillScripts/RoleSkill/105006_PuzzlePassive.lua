local bs_105001 = require("GamePlay.SkillScripts.RoleSkill.105001_PuzzlePassive")
local bs_105006 = class("bs_105006", bs_105001)
local base = bs_105001
bs_105006.config = {weaponLv = 3}
bs_105006.config = setmetatable(bs_105006.config, {
  __index = base.config
})

function bs_105006:ctor()
end

function bs_105006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105006
