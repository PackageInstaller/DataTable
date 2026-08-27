local bs_4010 = class("bs_4010", LuaSkillBase)
local base = LuaSkillBase
bs_4010.config = {
  buffId = 40101,
  def_formula = {def_formula = 0}
}

function bs_4010:ctor()
end

function bs_4010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4010_1", 1, self.OnAfterBattleStart)
  self:AddHurtResultStartTriggerForTable("bs_4010_2", 40, self.OnHurtResultStart, {
    sender = self.caster,
    senderBelongNum = eBattleRoleBelong.player,
    extraArg1 = eSkillTag.commonAttack
  })
end

function bs_4010:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_4010:OnHurtResultStart(skill, context)
  if skill.skillType == eBattleSkillLogicType.Original and skill.isCommonAttack and context.sender == self.caster and context.hurt_type ~= 2 then
    local random = LuaSkillCtrl:CallRange(1, 1000)
    if random <= self.arglist[2] then
      local critFurmula = context.config.def_formula
      if critFurmula ~= nil then
        context.new_config = self.config.def_formula
        setmetatable(context.new_config, {
          __index = context.config
        })
        return
      end
    end
  end
end

function bs_4010:LuaDispose()
  base.LuaDispose(self)
end

function bs_4010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010
