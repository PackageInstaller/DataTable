local bs_7019 = class("bs_7019", LuaSkillBase)
local base = LuaSkillBase
bs_7019.config = {
  hurt_config = 10,
  buffId = 110125,
  effectId = 12088,
  effectId1 = 12087
}

function bs_7019:ctor()
  self.arriveCallBack = BindCallback(self, self.CallBack)
end

function bs_7019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.time ~= nil then
    self.time:Stop()
    self.time = nil
  end
  self.time = LuaSkillCtrl:StartTimer(nil, 15, self.arriveCallBack, self, -1, 0)
end

function bs_7019:CallBack()
  if self.time ~= nil and self.time:IsOver() then
    self.time = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  if targetlist.Count > 0 then
    for i = targetlist.Count - 1, 0, -1 do
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist[i].targetRole)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_config, {1}, true)
      skillResult:EndResult()
    end
  end
end

function bs_7019:OnCasterDie()
  base.OnCasterDie(self)
  if self.time ~= nil then
    self.time:Stop()
    self.time = nil
  end
end

function bs_7019:LuaDispose()
  base.LuaDispose(self)
  self.time = nil
end

return bs_7019
