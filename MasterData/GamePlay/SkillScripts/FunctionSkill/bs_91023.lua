local bs_91023 = class("bs_91023", LuaSkillBase)
local base = LuaSkillBase
bs_91023.config = {buffId = 2045, buffTier = 1}

function bs_91023:ctor()
end

function bs_91023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91023_1", 1, self.OnAfterBattleStart)
end

function bs_91023:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role.belongNum == self.caster.belongNum then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
      end
    end
  end
end

function bs_91023:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91023
