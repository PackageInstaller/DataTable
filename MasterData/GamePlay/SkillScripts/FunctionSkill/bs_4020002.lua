local bs_4020002 = class("bs_4020002", LuaSkillBase)
local base = LuaSkillBase
bs_4020002.config = {
  buffId = 2090,
  buffId2 = 2091,
  effectId = 12074,
  HurtConfigId = 14
}

function bs_4020002:ctor()
end

function bs_4020002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4020002_1", 1, self.OnBattleStart)
  self.timer = nil
end

function bs_4020002:OnBattleStart()
  local arriveCallBack = BindCallback(self, self.eventFunc)
  self.timer = LuaSkillCtrl:StartTimer(self, self.arglist[1], arriveCallBack, nil, -1)
end

function bs_4020002:eventFunc()
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId, 1, self.arglist[2], true)
    LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId2, 1, 4, true)
  end
end

function bs_4020002:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_4020002:LuaDispose()
  base.LuaDispose(self)
  self.timer = nil
end

return bs_4020002
