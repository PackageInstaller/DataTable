local bs_25410 = class("bs_25410", LuaSkillBase)
local base = LuaSkillBase
bs_25410.config = {effectId = 10164, buffId = 2158}

function bs_25410:ctor()
end

function bs_25410:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25410_2", 1, self.OnAfterBattleStart)
end

function bs_25410:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[4], arriveCallBack, self, -1)
end

function bs_25410:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local skills = self.caster:GetBattleSkillList()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        local curTotalCd = skills[j].totalCDTime * self.arglist[1] // 1000
        LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
      end
    end
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
end

function bs_25410:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25410
