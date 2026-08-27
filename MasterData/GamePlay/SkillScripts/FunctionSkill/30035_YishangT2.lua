local bs_30035 = class("bs_30035", LuaSkillBase)
local base = LuaSkillBase
bs_30035.config = {checkBuffId = 1059, buffId = 1060}

function bs_30035:ctor()
end

function bs_30035:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30035_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.checkBuffId)
  self:AddBeforeBuffDispelTrigger("bs_30035_2", 2, self.BeforeBuffDispel, nil, nil, self.config.checkBuffId)
  self:AddBuffDieTrigger("bs_30035_1", 1, self.OnBuffDie, nil, nil, self.config.checkBuffId)
end

function bs_30035:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.checkBuffId then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buff.tier, nil, true)
  end
end

function bs_30035:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, context.tier)
end

function bs_30035:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.checkBuffId then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, buff.tier)
  end
end

function bs_30035:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30035
