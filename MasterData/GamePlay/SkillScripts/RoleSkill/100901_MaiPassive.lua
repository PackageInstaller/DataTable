local bs_100901 = class("bs_100901", LuaSkillBase)
local base = LuaSkillBase
bs_100901.config = {
  buffId_speed = 100901,
  buffId = 100902,
  buffId2 = 100903,
  buffIdAwake = 100904,
  selectId = 80,
  weaponLv = 0
}

function bs_100901:ctor()
end

function bs_100901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100901_1", 1, self.OnAfterBattleStart)
end

function bs_100901:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role.y == self.caster.y and role.belongNum == self.caster.belongNum then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_speed, 1)
      end
    end
  end
end

function bs_100901:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100901
