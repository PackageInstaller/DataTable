local bs_15102 = class("bs_15102", LuaSkillBase)
local base = LuaSkillBase
bs_15102.config = {effecIdAoe = 10943, effecIdHit = 10944}

function bs_15102:ctor()
end

function bs_15102:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15102_1", 1, self.OnAfterBattleStart)
  self.hurtTime = nil
end

function bs_15102:OnAfterBattleStart()
  if self.hurtTime ~= nil then
    self.hurtTime:Stop()
    self.hurtTime = nil
  end
  local callback = BindCallback(self, self.FunSkill)
  self.hurtTime = LuaSkillCtrl:StartTimer(nil, self.arglist[1], callback, nil, -1, self.arglist[1])
end

function bs_15102:FunSkill()
  local targetlist = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if targetlist == nil then
    return
  end
  if targetlist.Count > 0 then
    local value = (self.caster.def + self.caster.magic_res) * self.arglist[2] // 1000
    local Num = 0
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i]
      if targetRole.belongNum == eBattleRoleBelong.enemy and not targetRole:IsUnSelect(self.caster) then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 14, {value}, true, true)
        skillResult:EndResult()
        Num = Num + 1
      end
    end
    if 0 < Num then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effecIdAoe, self)
    end
  end
end

function bs_15102:OnCasterDie()
  if self.hurtTime ~= nil then
    self.hurtTime:Stop()
    self.hurtTime = nil
  end
  base.OnCasterDie(self)
end

return bs_15102
