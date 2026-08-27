local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_17317 = class("bs_17317", FireBase)
local base = FireBase
bs_17317.config = {buffId_extra = 2225}
bs_17317.config = setmetatable(bs_17317.config, {
  __index = base.config
})

function bs_17317:ctor()
end

function bs_17317:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17318_1", 1, self.OnAfterBattleStart)
end

function bs_17317:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self:AddAfterAddBuffTrigger("bs_17317", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.NowFireBuff)
  self:AddBeforeBuffDispelTrigger("bs_17317_1", 1, self.OnBeforBuffDispel, self.caster, nil, self.NowFireBuff)
  self:AddBuffDieTrigger("bs_17317_2", 1, self.OnBuffDie, self.caster, nil, self.NowFireBuff)
end

function bs_17317:OnAfterAddBuff(buff, target)
  local tier = target:GetBuffTier(self.NowFireBuff)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_extra, 0, true, false)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_extra, tier, nil, true, nil, true)
end

function bs_17317:OnBeforBuffDispel(target, context)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_extra, 0, true, false)
end

function bs_17317:OnBuffDie(buff, target, removeType)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_extra, 0, true, false)
end

function bs_17317:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17317
