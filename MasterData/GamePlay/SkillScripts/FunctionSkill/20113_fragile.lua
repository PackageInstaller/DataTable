local bs_20113 = class("bs_20113", LuaSkillBase)
local base = LuaSkillBase
bs_20113.config = {effectId = 135, buffId = 1217}

function bs_20113:ctor()
end

function bs_20113:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_20113_11", 1, self.OnRoleDie)
end

function bs_20113:OnRoleDie(killer, role, killSkill)
  if role.belongNum == 2 and killer.belongNum == 1 then
    LuaSkillCtrl:CallBuff(self, killer, self.config.buffId, 1, nil)
    self.effect0 = LuaSkillCtrl:CallEffect(killer, self.config.effectId, self)
    LuaSkillCtrl:StartTimer(nil, 23, function()
      if self.effect0 ~= nil then
        self.effect0:Die()
        self.effect0 = nil
      end
    end)
  end
end

function bs_20113:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20113
