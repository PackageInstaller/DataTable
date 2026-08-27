local bs_304 = class("bs_304", LuaSkillBase)
local base = LuaSkillBase
bs_304.config = {effectId = 10133, buffId = 137}

function bs_304:ctor()
end

function bs_304:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_304:PlaySkill(data)
  self.caster.recordTable["304_T"] = 1
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

function bs_304:OnAttackTrigger(data)
  local targetListall = LuaSkillCtrl:CallTargetSelect(self, 35, 10)
  if targetListall.Count ~= 0 then
    for i = 0, targetListall.Count - 1 do
      local skills = targetListall[i].targetRole:GetBattleSkillList()
      if skills ~= nil and 0 < self.caster.recordTable["304_T"] and skills.Count > 0 then
        for j = 0, skills.Count - 1 do
          if skills[j].isCommonAttack ~= true and skills[j].useLimitTime == 0 then
            local curTotalCd = skills[j].totalCDTime
            LuaSkillCtrl:CallEffect(targetListall[i].targetRole, self.config.effectId, self, nil, nil, 0.7)
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd - 5)
            self.caster.recordTable["304_T"] = self.caster.recordTable["304_T"] - 1
            if 0 <= self.arglist[1] then
              LuaSkillCtrl:CallBuff(self, targetListall[i].targetRole, self.config.buffId, 1, 75)
            end
            break
          end
        end
      end
    end
  end
end

function bs_304:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_304
