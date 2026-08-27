local bs_4020003 = class("bs_4020003", LuaSkillBase)
local base = LuaSkillBase
bs_4020003.config = {effectId = 12075, buffId = 2092}

function bs_4020003:ctor()
end

function bs_4020003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4020003_1", 1, self.OnBattleStart)
  self:AddAfterPlaySkillTrigger("bs_4020003_2", 1, self.OnAfterPlaySkill, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, eSkillTag.normalSkill)
end

function bs_4020003:OnBattleStart()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, targetList.Count - 1 do
    local role = targetList[i]
    if role ~= nil and role.roleType == eBattleRoleType.character then
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1)
      LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    end
  end
end

function bs_4020003:OnAfterPlaySkill(skill, role)
  if role.roleType ~= eBattleRoleType.character then
    return
  end
  if role.recordTable.bs_4020003 == true then
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    role.recordTable.bs_4020003 = false
    return
  end
  local range = LuaSkillCtrl:CallRange(1, 1000)
  if range <= self.arglist[1] then
    local callback = BindCallback(self, self.eventFunc, role)
    LuaSkillCtrl:StartTimer(self, 4, callback)
  end
end

function bs_4020003:eventFunc(role)
  local skills = role:GetBattleSkillList()
  LuaSkillCtrl:CallReFillMainSkillCdForRole(role)
  role.recordTable.bs_4020003 = true
end

function bs_4020003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4020003
