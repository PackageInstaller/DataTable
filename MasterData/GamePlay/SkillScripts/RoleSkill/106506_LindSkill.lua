local bs_106505 = require("GamePlay.SkillScripts.RoleSkill.106505_LindSkill")
local bs_106506 = class("bs_106506", bs_106505)
local base = bs_106505
bs_106506.config = {weaponLv = 3}
bs_106506.config = setmetatable(bs_106506.config, {
  __index = base.config
})

function bs_106506:ctor()
end

function bs_106506:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106506:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106506
