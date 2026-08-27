local bs_94101 = class("bs_94101", LuaSkillBase)
local base = LuaSkillBase
bs_94101.config = {buffId = 205}

function bs_94101:ctor()
end

function bs_94101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_94101_1", 1, self.OnAfterBattleStart)
end

function bs_94101:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1])
  local skills = self.caster:GetBattleSkillList()
  if skills ~= nil then
    local count = skills.Count
    if 0 < count then
      for i = 0, count - 1 do
        local curCd = 0
        if skills[i].isCommonAttack then
          skills[i]:ResetCDTimeRatio(0)
        end
      end
    end
  end
end

function bs_94101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94101
