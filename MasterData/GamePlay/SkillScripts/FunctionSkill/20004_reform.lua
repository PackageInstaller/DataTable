local bs_20004 = class("bs_20004", LuaSkillBase)
local base = LuaSkillBase
bs_20004.config = {effectId = 10164}

function bs_20004:ctor()
end

function bs_20004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_20004_10", 1, self.OnRoleDie)
  self.flag = true
end

function bs_20004:OnRoleDie(killer, role)
  if role.belongNum == 2 and self.flag then
    self.flag = false
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local count = skills.Count
      if 0 < count then
        for i = 0, count - 1 do
          local curCd = skills[i].totalCDTime
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curCd)
        end
        self:PlayChipEffect()
        LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
      end
    end
  end
end

function bs_20004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20004
