local bs_103001 = class("bs_103001", LuaSkillBase)
local base = LuaSkillBase
bs_103001.config = {buffId_int = 103000}

function bs_103001:ctor()
end

function bs_103001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_103001_1", 10, self.OnAfterBattleStart)
end

function bs_103001:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role.y == self.caster.y and role.x == self.caster.x + 1 and role.belongNum == self.caster.belongNum then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_int, 1)
        self.caster.recordTable.pass_target = role
      end
    end
  end
end

function bs_103001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103001
