local bs_10303 = class("bs_10303", LuaSkillBase)
local base = LuaSkillBase
bs_10303.config = {buffId = 66}

function bs_10303:ctor()
end

function bs_10303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10303_1", 1, self.OnAfterBattleStart)
end

function bs_10303:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.caoTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
end

function bs_10303:OnArriveAction()
  local GridId = LuaSkillCtrl:GetRoleEfcGrid(self.caster)
  if GridId == 1106 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2])
  end
end

function bs_10303:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10303
