local bs_25280 = class("bs_25280", LuaSkillBase)
local base = LuaSkillBase
bs_25280.config = {effectId_1 = 12094, effectId_2 = 12098}

function bs_25280:ctor()
end

function bs_25280:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_25280_1", 1, self.OnSetDeadHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25280_2", 1, self.AfterBattleStart)
  self.GridsWithAround = nil
end

function bs_25280:AfterBattleStart()
  local effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_1, self)
  if self.GridsWithAround == nil then
    self.GridsWithAround = LuaSkillCtrl:FindAllGridsWithinRange(self.caster, 2, false)
  end
end

function bs_25280:OnSetDeadHurt(context)
  if context.target == nil then
    return
  end
  local grid = LuaSkillCtrl:GetGridWithRole(context.target)
  local isAround = false
  for i = 0, self.GridsWithAround.Count - 1 do
    if self.GridsWithAround[i] == grid then
      isAround = true
      break
    end
  end
  if isAround then
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId_2, self)
    LuaSkillCtrl:AddCacheGold(self.arglist[1])
  end
end

function bs_25280:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25280
