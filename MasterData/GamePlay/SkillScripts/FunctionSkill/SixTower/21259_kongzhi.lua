local sixtower_kongzhi = class("sixtower_kongzhi", LuaSkillBase)
local base = LuaSkillBase
sixtower_kongzhi.config = {
  buffId = 2243,
  hurt_config = 54,
  effectId = 12208
}

function sixtower_kongzhi:ctor()
end

function sixtower_kongzhi:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("sixtower_kongzhi_1", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, nil, nil)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "sixtower_kongzhi_2", 1, self.OnAfterBattleStart)
end

function sixtower_kongzhi:OnAfterBattleStart()
  self:CallBuffToSelf()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[4], BindCallback(self, self.CallBuffToSelf), nil, -1)
end

function sixtower_kongzhi:CallBuffToSelf()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true, nil, true)
end

function sixtower_kongzhi:OnAfterAddBuff(buff, target)
  if not buff.buffCfg.IsControl then
    return
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1, true, true)
end

function sixtower_kongzhi:OnCasterDie()
  base.OnCasterDie(self)
end

return sixtower_kongzhi
