local bs_201902 = class("bs_201902", LuaSkillBase)
local base = LuaSkillBase
local Stack = require("Framework.Lib.Stack")
bs_201902.config = {
  effecttrail = 10405,
  effecthit = 10406,
  effectSC = 10407,
  effectSY = 10408,
  effectSYend = 10410,
  buffIdSC = 186,
  buffIdSY = 187,
  skillId = 201903,
  select_Id = 42,
  select_range = 10
}

function bs_201902:ctor()
end

function bs_201902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_201902_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_201902_2", 2, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, 201903)
  self:AddAfterAddBuffTrigger("bs_201902_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffIdSC)
  self.caster.recordTable["2019_times"] = self.arglist[3]
  self.caster.recordTable["514_arg2"] = self.arglist[2]
  self.caster.recordTable["514_arg6"] = self.arglist[6]
  self.caster.recordTable["514_arg7"] = self.arglist[7]
end

function bs_201902:OnAfterAddBuff(buff, target)
  if target:GetBuffTier(self.config.buffIdSC) >= self.arglist[3] then
    LuaSkillCtrl:DispelBuff(target, self.config.buffIdSC, 0, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffIdSY, 1, self.arglist[8])
    if self.caster.recordTable.SYRecordRoles == nil then
      self.caster.recordTable.SYRecordRoles = Stack.New()
    end
    self.caster.recordTable.SYRecordRoles:Push(target)
  end
end

function bs_201902:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and target:GetBuffTier(self.config.buffIdSY) < 1 and target.intensity ~= 0 and target:GetBuffTier(self.config.buffIdSC) < self.arglist[3] then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffIdSC, 1, nil)
  end
end

function bs_201902:OnAfterBattleStart()
  if self.caster.recordTable["20044_root2arg1"] ~= nil then
    local pz = BindCallback(self, self.Passiveback)
    self.time = LuaSkillCtrl:StartTimer(nil, self.caster.recordTable["20044_root2arg1"], pz, self, -1, 0)
  end
end

function bs_201902:Passiveback()
  if self.time ~= nil and self.time:IsOver() then
    self.time = nil
  end
  local target = LuaSkillCtrl:CallTargetSelect(self, self.config.select_Id, self.config.select_range)
  if target.Count > 0 then
    for i = 0, target.Count - 1 do
      if 1 > target[i].targetRole:GetBuffTier(self.config.buffIdSY) then
        LuaSkillCtrl:CallEffect(target[i].targetRole, self.config.effecttrail, self, self.SkillEventFunc)
        break
      end
    end
  end
end

function bs_201902:SkillEventFunc(effect, eventId, target)
  if effect.dataId ~= self.config.effecttrail or target.targetRole:GetBuffTier(self.config.buffIdSY) >= 1 and target.intensity ~= 0 then
    return
  end
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffIdSC, self.caster.recordTable["20044_root2arg2"])
    if target.targetRole:GetBuffTier(self.config.buffIdSC) >= self.arglist[3] then
      LuaSkillCtrl:DispelBuff(target.targetRole, self.config.buffIdSC, 0, true)
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffIdSY, 1, self.arglist[8])
      if self.caster.recordTable.SYRecordRoles == nil then
        self.caster.recordTable.SYRecordRoles = Stack.New()
      end
      self.caster.recordTable.SYRecordRoles:Push(target.targetRole)
    end
  end
end

function bs_201902:OnCasterDie()
  base.OnCasterDie(self)
  if self.time ~= nil then
    self.time:Stop()
    self.time = nil
  end
end

return bs_201902
