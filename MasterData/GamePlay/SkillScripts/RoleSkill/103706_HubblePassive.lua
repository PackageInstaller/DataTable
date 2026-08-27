local bs_103701 = require("GamePlay.SkillScripts.RoleSkill.103701_HubblePassive")
local bs_103706 = class("bs_103706", bs_103701)
local base = bs_103701
bs_103706.config = {
  weaponLv = 3,
  uplv = 2,
  skillDataId = 103703,
  Role_id = 1037
}
bs_103706.config = setmetatable(bs_103706.config, {
  __index = base.config
})

function bs_103706:ctor()
end

function bs_103706:InitSkill(isMidwaySkill)
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
  LuaSkillCtrl:AddChipChipConsumeSkill(103707, skilllv, bindHeroId)
  self:AddLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.OnUltSkillPlayed, 2)
  self.BenchRole = LuaSkillCtrl:GetOriginRole(self.config.Role_id)
end

function bs_103706:OnUltSkillPlayed(role, skill)
  if skill.isUltSkill and skill.funcHeroId == self.caster.roleDataId and self.BenchRole ~= nil and not self.BenchRole.roleOnBench then
    self:Passivetirger(self.arglist[4])
  end
end

function bs_103706:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103706
