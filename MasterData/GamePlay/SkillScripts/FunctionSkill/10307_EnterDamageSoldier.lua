local bs_10307 = class("bs_10307", LuaSkillBase)
local base = LuaSkillBase
bs_10307.config = {
  effectId = 12023,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10078,
    crit_formula = 0
  }
}

function bs_10307:ctor()
end

function bs_10307:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10307_1", 1, self.OnAfterBattleStart)
  self.time = nil
  self.Effect = nil
end

function bs_10307:OnAfterBattleStart(isMidway)
  if not isMidway then
    return
  end
  if self.caster == nil then
    return
  end
  if self.time ~= nil then
    self.time:Stop()
    self.time = nil
  end
  self:PlayChipEffect()
  LuaSkillCtrl:AddPlayerTowerMp(self.arglist[1])
  local callback = BindCallback(self, self.DamageSoldier)
  local efcCallBack = BindCallback(self, self.CallEfc)
  local loopTime = self.arglist[2] // 15
  LuaSkillCtrl:StartTimer(self, 3, efcCallBack)
  self.time = LuaSkillCtrl:StartTimer(self, 15, callback, nil, loopTime, 15)
  LuaSkillCtrl:StartTimer(self, 15 * loopTime, function()
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end, self)
end

function bs_10307:CallEfc()
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
end

function bs_10307:DamageSoldier()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if targetList == nil or targetList.Count < 1 then
    return
  end
  self:PlayChipEffect()
  for i = 0, targetList.Count - 1 do
    local targetRole = targetList[i].targetRole
    if targetRole ~= nil and 0 < targetRole.hp and targetRole.belongNum ~= self.caster.belongNum then
      self:PlayChipEffect()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, nil, true)
    end
  end
end

function bs_10307:OnCasterDie()
  base.OnCasterDie(self)
  if self.time ~= nil then
    self.time:Stop()
    self.time = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_10307:LuaDispose()
  base.LuaDispose(self)
  self.time = nil
end

return bs_10307
