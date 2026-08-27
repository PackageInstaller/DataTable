local bs_15228 = class("bs_15228", LuaSkillBase)
local base = LuaSkillBase
bs_15228.config = {effectId = 10164}

function bs_15228:ctor()
end

function bs_15228:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15228_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_15228_3", 1, self.OnAfterHurt, nil, self.caster)
  self.time = 0
end

function bs_15228:OnAfterBattleStart()
end

function bs_15228:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and self.time == 0 and target.hp * 1000 // target.maxHp <= self.arglist[1] then
    self.time = 1
    self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local targetRole = targetList[i].targetRole
        if targetRole.career == 5 then
          local skills = targetRole:GetBattleSkillList()
          if skills ~= nil then
            local count = skills.Count
            if 0 < count then
              for j = 0, count - 1 do
                local curCd = skills[j].totalCDTime
                if not skills[j].isCommonAttack then
                  LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curCd)
                end
              end
              LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
            end
          end
        end
      end
    end
  end
end

function bs_15228:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15228
