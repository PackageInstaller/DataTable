local bs_15060 = class("bs_15060", LuaSkillBase)
local base = LuaSkillBase
bs_15060.config = {
  buffYSId = 1241,
  buffId_Taunt = 3002,
  buffId_Taunt2 = 1024,
  buffId_Taunt3 = 1025
}

function bs_15060:ctor()
end

function bs_15060:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_15060_8", 1, self.OnAfterAddBuff, nil, self.caster)
  self:AddBeforeBuffDispelTrigger("bs_15060_1", 2, self.BeforeBuffDispel, self.caster)
  self:AddBuffDieTrigger("bs_15060_3", 3, self.OnBuffDie, self.caster)
end

function bs_15060:OnAfterAddBuff(buff, target)
  if target == self.caster and (buff.dataId == self.config.buffId_Taunt or buff.dataId == self.config.buffId_Taunt2 or buff.dataId == self.config.buffId_Taunt3) then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffYSId, 1, nil, true)
    self:PlayChipEffect()
    self:OnSkillTake()
  end
end

function bs_15060:BeforeBuffDispel(targetRole, context)
  if context.buffId == self.config.buffId_Taunt or context.buffId == self.config.buffId_Taunt2 or context.dataId == self.config.buffId_Taunt3 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffYSId, 0)
  end
end

function bs_15060:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_Taunt or buff.dataId == self.config.buffId_Taunt2 or buff.dataId == self.config.buffId_Taunt3 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffYSId, 0)
  end
end

function bs_15060:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15060
