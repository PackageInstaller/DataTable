local bs_215002 = class("bs_215002", LuaSkillBase)
local base = LuaSkillBase
bs_215002.config = {
  buffId_Boss = 3017,
  HurtConfigID = 59,
  effectId_loop_1 = 215007,
  effectId_loop_2 = 215006,
  effectId_loop_3 = 215008,
  effectId_loop_4 = 215005
}

function bs_215002:ctor()
end

function bs_215002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_215002", 1, self.OnAfterBattleStart)
  self.MapBorder = LuaSkillCtrl:GetMapBorder()
end

function bs_215002:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Boss, 1, nil, true)
  end
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.OnLoopDamage), nil, -1, 0)
end

function bs_215002:OnLoopDamage()
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.loop_atk ~= nil then
    self.loop_atk:Stop()
    self.loop_atk = nil
  end
  if self.clearEffect ~= nil then
    self.clearEffect:Stop()
    self.clearEffect = nil
  end
  if self.MapBorder.x == 6 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(2, 2)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop_3, self)
  elseif self.MapBorder.x == 7 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop_1, self)
  elseif self.MapBorder.x == 10 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(4, 2)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop_2, self)
  else
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(12, 8)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop_4, self)
  end
  self.clearEffect = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    if self.loop_atk ~= nil then
      self.loop_atk:Stop()
      self.loop_atk = nil
    end
  end, nil)
  local loop = BindCallback(self, self.loopattack)
  self.loop_atk = LuaSkillCtrl:StartTimer(nil, 5, loop, nil, -1, 0)
end

function bs_215002:loopattack()
  local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if enemyList.Count > 0 then
    for i = 0, enemyList.Count - 1 do
      local role = enemyList[i].targetRole
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
        self.arglist[3]
      })
      skillResult:EndResult()
    end
  end
end

function bs_215002:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_215002
