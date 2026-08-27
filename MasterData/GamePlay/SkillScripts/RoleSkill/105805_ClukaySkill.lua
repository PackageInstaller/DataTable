local bs_105802 = require("GamePlay.SkillScripts.RoleSkill.105802_ClukaySkill")
local bs_105805 = class("bs_105805", bs_105802)
local base = bs_105802
bs_105805.config = {weaponLv = 2}
bs_105805.config = setmetatable(bs_105805.config, {
  __index = base.config
})

function bs_105805:ctor()
end

function bs_105805:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105805:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_105805:LuaDispose()
  base.LuaDispose(self)
end

return bs_105805
