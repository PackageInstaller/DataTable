local bs_15091 = class("bs_15091", LuaSkillBase)
local base = LuaSkillBase
bs_15091.config = {buffId = 110086}

function bs_15091:ctor()
end

function bs_15091:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterBuffRemoveTrigger("bs_15091_2", 4, self.AfterBuffRemove, nil, eBattleRoleBelong.enemy, nil, nil, eBuffFeatureType.Stun)
end

function bs_15091:AfterBuffRemove(buffId, target, removeType)
  if target.belongNum == eBattleRoleBelong.enemy and not LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Stun) then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.arglist[2], true)
  end
end

function bs_15091:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15091
