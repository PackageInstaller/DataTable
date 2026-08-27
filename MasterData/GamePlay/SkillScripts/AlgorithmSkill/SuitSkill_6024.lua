local bs_6024 = class("bs_6024", LuaSkillBase)
local base = LuaSkillBase
bs_6024.config = {buffId_1 = 602401}

function bs_6024:ctor()
end

function bs_6024:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_6024_13", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.normalSkill)
end

function bs_6024:OnAfterPlaySkill(skill, role)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId_1, 1, self.arglist[2], true)
    end
  end
end

function bs_6024:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6024
