local bs_92006 = class("bs_92006", LuaSkillBase)
local base = LuaSkillBase
bs_92006.config = {effectId = 10964}

function bs_92006:ctor()
end

function bs_92006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_92006_1", 1, self.OnAfterBattleStart)
end

function bs_92006:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
end

function bs_92006:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local damage = self.caster.maxHp * self.arglist[2] // 1000
      if targetList[i].belongNum ~= self.caster.belongNum then
        LuaSkillCtrl:RemoveLife(damage, self, targetList[i], true, nil, true)
        LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
      end
    end
  end
end

function bs_92006:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_92006
