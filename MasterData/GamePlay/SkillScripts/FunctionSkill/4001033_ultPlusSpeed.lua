local bs_4001033 = class("bs_4001033", LuaSkillBase)
local base = LuaSkillBase
bs_4001033.config = {buffId = 2020}

function bs_4001033:ctor()
end

function bs_4001033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4001033_1", 1, self.OnAfterPlaySkill)
end

function bs_4001033:OnAfterPlaySkill(skill, role)
  if skill.skillTag ~= eSkillTag.ultSkill then
    return
  end
  local target_List = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, target_List.Count - 1 do
    LuaSkillCtrl:CallBuff(self, target_List[i], self.config.buffId, 1, self.arglist[2], true)
  end
end

function bs_4001033:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001033
