local bs_82013 = class("bs_82013", LuaSkillBase)
local base = LuaSkillBase
bs_82013.config = {}

function bs_82013:ctor()
end

function bs_82013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.OnUltSkillPlayed)
  self.skillCasterEntity = LuaSkillCtrl:GetPlayerRoleEntity()
end

function bs_82013:OnUltSkillPlayed(role)
  if self.skillCasterEntity.recordTable.elfSkillTrigger == nil then
    self.skillCasterEntity.recordTable.elfSkillTrigger = self.caster
  end
  if self.skillCasterEntity.recordTable.elfSkillTrigger ~= self.caster then
    return
  end
  local skills = LuaSkillCtrl:GetAllUltSkills()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        local curTotalCd = self.arglist[1]
        local skill = skills[j]
        if skill.funcHeroId == role.roleDataId then
          LuaSkillCtrl:CallResetCDForSingleSkill(skill, curTotalCd)
        end
      end
    end
  end
end

function bs_82013:OnCasterDie()
  if self.skillCasterEntity.recordTable.elfSkillTrigger == self.caster then
    self.skillCasterEntity.recordTable.elfSkillTrigger = nil
  end
  base.OnCasterDie(self)
end

function bs_82013:LuaDispose()
  base.LuaDispose(self)
  self.skillCasterEntity = nil
end

return bs_82013
