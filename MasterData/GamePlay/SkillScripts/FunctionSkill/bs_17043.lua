local bs_17043 = class("bs_17043", LuaSkillBase)
local base = LuaSkillBase
bs_17043.config = {
  effectId = 60613,
  effectIdAttack = 60612,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17043:ctor()
end

function bs_17043:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.PickUpCoins, self.OnPickUpCoins)
  self.typenum = 3
  self.coins_num = 0
end

function bs_17043:OnPickUpCoins()
  self.coins_num = self.coins_num + 1
  if self.coins_num >= self.arglist[3] then
    local roleslist = LuaSkillCtrl:CallTargetSelect(self, 1002, 10)
    if roleslist.Count > self.arglist[2] then
      for i = 0, self.arglist[2] - 1 do
        LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack, self, self.SkillEventFunc)
      end
    end
    if roleslist.Count <= self.arglist[2] then
      for i = 0, roleslist.Count - 1 do
        LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack, self, self.SkillEventFunc)
      end
    end
    self.coins_num = 0
  end
end

function bs_17043:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    local tar = target.targetRole
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.Callthrows, tar, self.typenum, self.arglist[1], true)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, nil)
    if self.caster.recordTable["25211_Flag"] == true then
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.caster.recordTable["25211_arg"] + self.arglist[1]
      }, true)
    else
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.arglist[1]
      }, true)
    end
    skillResult:EndResult()
  end
end

function bs_17043:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17043
