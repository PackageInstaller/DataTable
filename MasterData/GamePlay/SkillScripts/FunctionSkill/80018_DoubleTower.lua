local bs_80018 = class("bs_80018", LuaSkillBase)
local base = LuaSkillBase
bs_80018.config = {curCd = 30, buffId_doblueTower = 196}

function bs_80018:ctor()
end

function bs_80018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_80018_1", 1, self.OnAfterBattleStart)
end

function bs_80018:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(self, 1, function()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local targetListRole = targetList[i].targetRole
        LuaSkillCtrl:DispelBuff(targetListRole, self.config.buffId_doblueTower, 0)
      end
    end
  end)
  LuaSkillCtrl:CallCreateEfcGrid(0, 0, 22)
  LuaSkillCtrl:CallCreateEfcGrid(6, 0, 22)
  LuaSkillCtrl:CallCreateEfcGrid(0, 4, 22)
  LuaSkillCtrl:CallCreateEfcGrid(6, 4, 22)
end

function bs_80018:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80018
