local bs_15332 = class("bs_15332", LuaSkillBase)
local base = LuaSkillBase
bs_15332.config = {buffId = 110091}

function bs_15332:ctor()
end

function bs_15332:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_15332_13", 1, self.OnAfterPlaySkill, nil, nil, self.caster.belongNum, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_15332:OnAfterPlaySkill(skill, role)
  if skill.isUltSkill and skill.skillType == eBattleSkillLogicType.Original then
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetList == nil then
      return
    end
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local targetRole = targetList[i]
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, self.arglist[2])
      end
    end
  end
end

function bs_15332:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15332
