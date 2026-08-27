local bs_104801 = require("GamePlay.SkillScripts.RoleSkill.104801_NoraPassive")
local bs_104805 = class("bs_104805", bs_104801)
local base = bs_104801
bs_104805.config = {weaponLv = 2}
bs_104805.config = setmetatable(bs_104805.config, {
  __index = base.config
})

function bs_104805:ctor()
end

function bs_104805:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104805:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_104805:LuaDispose()
  base.LuaDispose(self)
end

return bs_104805
