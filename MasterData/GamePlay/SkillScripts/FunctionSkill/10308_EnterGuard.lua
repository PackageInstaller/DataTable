local bs_10308 = class("bs_10308", LuaSkillBase)
local base = LuaSkillBase
bs_10308.config = {buffId = 110007}

function bs_10308:ctor()
end

function bs_10308:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10308_1", 1, self.OnAfterBattleStart)
end

function bs_10308:OnAfterBattleStart(isMidway)
  if not isMidway then
    return
  end
  self:PlayChipEffect()
  LuaSkillCtrl:AddPlayerTowerMp(self.arglist[1])
  if self.caster == nil then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2])
end

function bs_10308:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10308
