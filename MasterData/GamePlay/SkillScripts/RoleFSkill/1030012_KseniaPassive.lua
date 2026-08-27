local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1030012 = class("bs_1030012", base)
bs_1030012.config = {buffId_int = 103000}

function bs_1030012:ctor()
end

function bs_1030012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1030012_1", 10, self.OnAfterBattleStart)
end

function bs_1030012:OnAfterBattleStart()
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

function bs_1030012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1030012
