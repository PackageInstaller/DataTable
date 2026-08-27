local bs_94204 = class("bs_94204", LuaSkillBase)
local base = LuaSkillBase
bs_94204.config = {buffId = 110060}

function bs_94204:ctor()
end

function bs_94204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_94204_13", 1, self.OnAfterPlaySkill)
end

function bs_94204:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.dataId == 5131 or skill.dataId == 5132 or skill.dataId == 5133 then
    local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if playerList.Count > 0 then
      for i = 0, playerList.Count - 1 do
        local targetRole = playerList[i]
        LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0, false)
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, self.arglist[2], ture)
      end
    end
  end
end

function bs_94204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94204
