local bs_104602 = require("GamePlay.SkillScripts.RoleSkill.104602_HazeSkill")
local bs_104606 = class("bs_104606", bs_104602)
local base = bs_104602
bs_104606.config = {weaponLv = 3}
bs_104606.config = setmetatable(bs_104606.config, {
  __index = base.config
})

function bs_104606:ctor()
end

function bs_104606:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104606:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104606
