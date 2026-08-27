local bs_30031 = class("bs_30031", LuaSkillBase)
local base = LuaSkillBase
bs_30031.config = {buffId_shixue = 257, buff_baoji = 1195}

function bs_30031:ctor()
end

function bs_30031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30031_7", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffId_shixue)
  self:AddBeforeBuffDispelTrigger("bs_30031_1", 1, self.BeforeBuffDispel, self.caster, nil, self.config.buffId_shixue)
  self:AddBuffDieTrigger("bs_30035_2", 1, self.OnBuffDie, self.caster, nil, self.config.buffId_shixue)
end

function bs_30031:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_shixue then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_baoji, buff.tier, nil, true)
  end
end

function bs_30031:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_baoji, context.tier)
end

function bs_30031:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_shixue then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_baoji, buff.tier)
  end
end

function bs_30031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30031
