local bs_21034 = class("bs_21034", LuaSkillBase)
local base = LuaSkillBase
bs_21034.config = {checkBuffId = 110015, buffId = 1009}

function bs_21034:ctor()
end

function bs_21034:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_21034_7", 2, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.checkBuffId)
  self:AddBeforeBuffDispelTrigger("bs_21034_6", 2, self.BeforeBuffDispel, self.caster, nil, self.config.checkBuffId)
end

function bs_21034:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.checkBuffId then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil)
  end
end

function bs_21034:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, self.arglist[1])
end

function bs_21034:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21034
