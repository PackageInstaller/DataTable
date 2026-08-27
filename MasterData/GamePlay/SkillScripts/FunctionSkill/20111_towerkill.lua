local bs_20111 = class("bs_20111", LuaSkillBase)
local base = LuaSkillBase
bs_20111.config = {}

function bs_20111:ctor()
end

function bs_20111:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_20111", 1, self.BeforeEndBattle)
end

function bs_20111:BeforeEndBattle()
  self:DispelTargetBuffFeature(eBuffFeatureType.Invinciable)
  self:DispelTargetBuffFeature(eBuffFeatureType.NoDeath)
  LuaSkillCtrl:LoadOffTowerCharacter(self.caster, false)
end

function bs_20111:DispelTargetBuffFeature(buffFeatureId)
  local targetBuffList = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, buffFeatureId)
  if targetBuffList == nil or targetBuffList.Count <= 0 then
    return
  end
  for i = 0, targetBuffList.Count - 1 do
    LuaSkillCtrl:DispelBuff(self.caster, targetBuffList[i].dataId, 0)
  end
end

function bs_20111:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20111
