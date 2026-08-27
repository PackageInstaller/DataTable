local bs_105902 = require("GamePlay.SkillScripts.RoleSkill.105902_ClothoSkill")
local bs_105905 = class("bs_105905", bs_105902)
local base = bs_105902
bs_105905.config = {
  buff_blind = 115,
  buff_damageup = 105908,
  weaponLv = 2
}
bs_105905.config = setmetatable(bs_105905.config, {
  __index = base.config
})

function bs_105905:ctor()
end

function bs_105905:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105905:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105905
