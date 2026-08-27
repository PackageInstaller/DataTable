local bs_106901 = class("bs_106901", LuaSkillBase)
local base = LuaSkillBase
bs_106901.config = {effectId = 106902}

function bs_106901:ctor()
end

function bs_106901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.OnUltSkillPlayed)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_106901_2", 1, self.OnAfterBattleStart)
  self.caster.recordTable.add_mp = self.arglist[1] * 50
  self.resetCD = self.arglist[2]
end

function bs_106901:OnAfterBattleStart()
  self.caster:AddRoleProperty(eHeroAttr.attackRange, 10, eHeroAttrType.Origin)
end

function bs_106901:OnUltSkillPlayed(role)
  local skills = LuaSkillCtrl:GetAllUltSkills()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        local curTotalCd = self.resetCD
        local skill = skills[j]
        if skill.funcHeroId == role.roleDataId and role ~= self.caster then
          LuaSkillCtrl:CallResetCDForSingleSkill(skill, curTotalCd)
          LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
          return
        end
      end
    end
  end
end

function bs_106901:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106901
