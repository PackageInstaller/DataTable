local bs_100701 = require("GamePlay.SkillScripts.RoleSkill.100701_ChelseaPassive")
local bs_100704 = class("bs_100704", bs_100701)
local base = bs_100701
bs_100704.config = {
  weaponLv = 1,
  roleDataId = 1007,
  skillDataId = 100703
}
bs_100704.config = setmetatable(bs_100704.config, {
  __index = base.config
})

function bs_100704:ctor()
end

function bs_100704:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local funchero = LuaSkillCtrl:GetOriginRole(self.caster.roleDataId)
  local skilllv = 1
  local skill = funchero.skillIDList
  if skill ~= nil then
    local skillCount = skill.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        if skill[j].dataId == self.config.skillDataId then
          skilllv = skill[j].level
        end
      end
    end
  end
  local bindHeroId = self.caster.roleDataId
  LuaSkillCtrl:AddChipChipConsumeSkill(100707, skilllv, bindHeroId)
end

function bs_100704:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100704
