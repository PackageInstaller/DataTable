local bs_4005 = class("bs_4005", LuaSkillBase)
local base = LuaSkillBase
bs_4005.config = {HurtConfigID = 14, effectId_aoe = 209413}

function bs_4005:ctor()
end

function bs_4005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4005", 1, self.OnAfterBattleStart)
end

function bs_4005:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.OnLoopDamage), nil, -1, 0)
end

function bs_4005:OnLoopDamage()
  local shieldNum = LuaSkillCtrl:GetRoleAllShield(self.caster)
  if shieldNum == 0 then
    return
  end
  local shieldNum_damage = shieldNum * self.arglist[2] // 1000
  local value = self.caster.maxHp * self.arglist[3] // 1000
  if shieldNum_damage > value then
    shieldNum_damage = value
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local target = targetList[i].targetRole
      if target ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {shieldNum_damage}, true)
        skillResult:EndResult()
      end
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_aoe, self, nil, nil, nil, true)
  end
end

function bs_4005:LuaDispose()
  base.LuaDispose(self)
end

function bs_4005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4005
