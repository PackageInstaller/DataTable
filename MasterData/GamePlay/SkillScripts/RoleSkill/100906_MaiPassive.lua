local bs_100904 = require("GamePlay.SkillScripts.RoleSkill.100904_MaiPassive")
local bs_100906 = class("bs_100906", bs_100904)
local base = bs_100904
bs_100906.config = {weaponLv = 3}
bs_100906.config = setmetatable(bs_100906.config, {
  __index = base.config
})

function bs_100906:ctor()
end

function bs_100906:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100906:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_100906:LuaDispose()
  base.LuaDispose(self)
end

return bs_100906
