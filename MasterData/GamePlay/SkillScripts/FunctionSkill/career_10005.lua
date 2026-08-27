local career_10005 = class("career_10005", LuaSkillBase)
local base = LuaSkillBase
career_10005.config = {effectId = 10164}

function career_10005:ctor()
end

function career_10005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTriggerForTable("career_10005_1", 2, self.OnAfterPlaySkill, {
    senderBelongNum = self.caster.belongNum
  })
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_10005_2", 1, self.OnAfterBattleStart)
end

function career_10005:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.cd_reduce, self.arglist[2], eHeroAttrType.Origin)
    end
  end
end

function career_10005:OnAfterPlaySkill(skill, role)
  if skill.maker.belongNum == eBattleRoleBelong.player and (skill.maker.career == 4 or skill.maker.recordTable.transfCareer == 4) and not skill.isCommonAttack and self.arglist[1] == 3 and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[3] then
    local skills = skill.maker:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[4] // 1000
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
    LuaSkillCtrl:CallEffect(skill.maker, self.config.effectId, self)
  end
end

function career_10005:OnCasterDie()
  base.OnCasterDie(self)
end

return career_10005
