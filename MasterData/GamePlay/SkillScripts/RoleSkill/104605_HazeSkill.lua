local bs_104602 = require("GamePlay.SkillScripts.RoleSkill.104602_HazeSkill")
local bs_104605 = class("bs_104605", bs_104602)
local base = bs_104602
bs_104605.config = {weaponLv = 2}
bs_104605.config = setmetatable(bs_104605.config, {
  __index = base.config
})

function bs_104605:ctor()
end

function bs_104605:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104605:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104605
