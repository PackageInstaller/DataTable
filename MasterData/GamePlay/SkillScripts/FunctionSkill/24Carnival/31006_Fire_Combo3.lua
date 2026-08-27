local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_31006 = class("bs_31006", FireBase)
local base = FireBase
bs_31006.config = {
  buffId_miniFire = 110150,
  effectId = 12092,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  newBuffId_miniFire = 110152
}
bs_31006.config = setmetatable(bs_31006.config, {
  __index = base.config
})

function bs_31006:ctor()
end

function bs_31006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.FireBaseChain = self.arglist[1]
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_31006_1", 1, self.OnAfterBattleStart)
end

function bs_31006:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self:AddAfterAddBuffTrigger("bs_31006_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, eBattleRoleBelong.enemy, self.NowFireBuff)
end

function bs_31006:OnAfterAddBuff(buff, target)
  local tier = target:GetBuffTier(self.NowFireBuff)
  if tier < self.FireMaxTier - 1 then
    return
  end
  if tier >= self.FireMaxTier then
    self:ActiveFireBuff(target, self.arglist[2])
  end
end

function bs_31006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_31006
