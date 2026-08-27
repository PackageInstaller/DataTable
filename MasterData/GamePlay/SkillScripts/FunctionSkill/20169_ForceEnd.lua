local bs_20169 = class("bs_20169", LuaSkillBase)
local base = LuaSkillBase
bs_20169.config = {endTime = 325, buffId = 32}

function bs_20169:ctor()
end

function bs_20169:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20169_1", 1, self.OnAfterBattleStart)
end

function bs_20169:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.endTime, arriveCallBack)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 5, 20)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if targetRole.roleDataId == 1000021 or targetRole.roleDataId == 1000022 then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
    end
  end
end

function bs_20169:OnArriveAction()
  local characterEntities = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if characterEntities == nil or characterEntities.Count <= 0 then
    return
  end
  for i = 0, characterEntities.Count - 1 do
    local targetRole = characterEntities[i]
    if targetRole.roleDataId == 1000021 then
      LuaSkillCtrl:CallBuff(self, targetRole, 278, 1, nil, true)
      LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0)
      local arriveCallBack2 = BindCallback(self, self.OnArriveAction2, targetRole)
      LuaSkillCtrl:StartTimer(nil, 7, arriveCallBack2, self, -1, 15)
    end
  end
end

function bs_20169:OnArriveAction2(targetRole)
  LuaSkillCtrl:RemoveLife(targetRole.maxHp // 10, self, targetRole, true, nil, true, true)
end

function bs_20169:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20169
