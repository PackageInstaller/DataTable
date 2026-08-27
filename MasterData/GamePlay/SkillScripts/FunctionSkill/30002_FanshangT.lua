local bs_30002 = class("bs_30002", LuaSkillBase)
local base = LuaSkillBase
bs_30002.config = {
  buffId = 1026,
  buffCF = 3002,
  buffTier = 1,
  aoe_config = {
    effect_shape = eSkillResultShapeType.CellDist,
    aoe_select_code = 4,
    aoe_range = 1
  },
  effectId = 10888
}

function bs_30002:ctor()
end

function bs_30002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30002_2", 10, self.OnAfterBattleStart)
end

function bs_30002:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, self, -1)
end

function bs_30002:OnArriveAction()
  self:PlayChipEffect()
  local buffTier = self.caster.return_damage
  if self.effect == nil then
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
      if self.effect ~= nil then
        self.effect:Die()
        self.effect = nil
      end
    end)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, self.arglist[2], true)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe_config)
  skillResult:BuffResult(self.config.buffCF, self.config.buffTier, self.arglist[2])
  skillResult:EndResult()
end

function bs_30002:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_30002
