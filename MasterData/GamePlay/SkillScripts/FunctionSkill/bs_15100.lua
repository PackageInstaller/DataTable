local bs_15100 = class("bs_15100", LuaSkillBase)
local base = LuaSkillBase
bs_15100.config = {buffId = 110091}

function bs_15100:ctor()
end

function bs_15100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_15100_13", 1, self.OnAfterPlaySkill, nil, nil, self.caster.belongNum, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_15100:OnAfterPlaySkill(skill, role)
  if skill.isUltSkill then
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetList == nil then
      return
    end
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local targetRole = targetList[i]
        local buffTier = targetRole:GetBuffTier(self.config.buffId)
        if targetRole.roleType == eBattleRoleType.character and buffTier < self.arglist[3] then
          LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, self.arglist[2])
        end
      end
    end
  end
end

function bs_15100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15100
