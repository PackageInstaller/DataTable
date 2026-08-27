local bs_207301 = class("bs_207301", LuaSkillBase)
local base = LuaSkillBase
bs_207301.config = {
  effectId = 207303,
  effectId1 = 207302,
  HurtConfigID = 3,
  effectId_ex = 210004,
  effectId1_ex = 210003
}

function bs_207301:ctor()
end

function bs_207301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_207301:PlaySkill()
  self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
  self:AddAfterHurtTrigger("bs_207301_1", 1, self.OnAfterHurt, nil, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.moveTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
    self.caster.recordTable.onAction2 = nil
  end)
  self.caster.recordTable.onAction2 = true
end

function bs_207301:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and sender == self.caster and not isMiss then
    if self.dataID == 210003 then
      LuaSkillCtrl:CallEffect(target, self.config.effectId1_ex, self)
    else
      LuaSkillCtrl:CallEffect(target, self.config.effectId1, self)
    end
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target, 1, false)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local skills = targetList[i]:GetBattleSkillList()
        if targetList[i].belongNum == eBattleRoleBelong.player then
          if skills ~= nil then
            local skillCount = skills.Count
            if 0 < skillCount then
              for j = 0, skillCount - 1 do
                local curTotalCd = skills[j].totalCDTime * -1 * self.arglist[3] // 1000
                if not skills[j].isCommonAttack then
                  LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
                end
              end
            end
          end
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
            self.arglist[2]
          }, true)
          skillResult:EndResult()
          if self.dataID == 210003 then
            LuaSkillCtrl:CallEffect(targetList[i], self.config.effectId_ex, self)
          else
            LuaSkillCtrl:CallEffect(targetList[i], self.config.effectId, self)
          end
        end
      end
    end
  end
end

function bs_207301:OnCasterDie()
  if self.moveTimer ~= nil then
    self.moveTimer:Stop()
    self.moveTimer = nil
  end
  base.OnCasterDie(self)
end

function bs_207301:LuaDispose()
  if self.moveTimer ~= nil then
    self.moveTimer:Stop()
    self.moveTimer = nil
  end
  base.LuaDispose(self)
end

return bs_207301
