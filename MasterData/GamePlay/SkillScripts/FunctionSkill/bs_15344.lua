local bs_15344 = class("bs_15344", LuaSkillBase)
local base = LuaSkillBase
bs_15344.config = {buffId_miniFire = 110150, time = 1}

function bs_15344:ctor()
end

function bs_15344:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15344_1", 1, self.OnAfterBattleStart)
  self.timer = nil
end

function bs_15344:OnAfterBattleStart()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
    if targetList.Count <= 0 then
      return
    end
    local targetRole = targetList[0].targetRole
    if targetList.Count > 0 and targetRole.belongNum == eBattleRoleBelong.enemy then
      if self.caster.recordTable.miniFireBuff == nil then
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_miniFire, self.config.time, 120)
      else
        LuaSkillCtrl:CallBuff(self, targetRole, self.caster.recordTable.miniFireBuff, self.config.time, 120)
      end
    end
  end, nil, -1, self.arglist[1])
end

function bs_15344:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_15344
