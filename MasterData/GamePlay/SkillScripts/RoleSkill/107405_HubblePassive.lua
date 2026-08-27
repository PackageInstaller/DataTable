local bs_107401 = require("GamePlay.SkillScripts.RoleSkill.107401_HubblePassive")
local bs_107405 = class("bs_107404", bs_107401)
local base = bs_107401
bs_107405.config = {weaponLv = 2}
bs_107405.config = setmetatable(bs_107405.config, {
  __index = base.config
})

function bs_107405:ctor()
end

function bs_107405:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:AddExtraAddSkill(107409, self.level)
end

function bs_107405:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107405
