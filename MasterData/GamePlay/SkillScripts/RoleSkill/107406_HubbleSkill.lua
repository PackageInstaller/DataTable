local bs_107404 = require("GamePlay.SkillScripts.RoleSkill.107404_HubbleSkill")
local bs_107406 = class("bs_107406", bs_107404)
local base = bs_107404
bs_107406.config = {weaponLv = 3}
bs_107406.config = setmetatable(bs_107406.config, {
  __index = base.config
})

function bs_107406:ctor()
end

function bs_107406:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107406:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107406
