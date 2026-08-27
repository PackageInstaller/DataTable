local bs_30057 = class("bs_30057", LuaSkillBase)
local base = LuaSkillBase
bs_30057.config = {buffWKId = 1248, buffId = 1251}

function bs_30057:ctor()
end

function bs_30057:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10321_7", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffWKId)
  self:AddBeforeBuffDispelTrigger("bs_10321_1", 1, self.BeforeBuffDispel, self.caster, nil, self.config.buffWKId)
  self:AddBuffDieTrigger("bs_10321_2", 1, self.OnBuffDie, self.caster, nil, self.config.buffWKId)
end

function bs_30057:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffWKId then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_30057:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
end

function bs_30057:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffWKId then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_30057:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30057
