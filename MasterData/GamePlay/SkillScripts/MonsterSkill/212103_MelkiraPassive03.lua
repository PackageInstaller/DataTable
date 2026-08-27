local bs_212103 = class("bs_212103", LuaSkillBase)
local base = LuaSkillBase
bs_212103.config = {
  effect = 212115,
  effect_big = 212121,
  effect_small = 212120,
  HurtConfigID = 3
}

function bs_212103:ctor()
end

function bs_212103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.MapBorder = LuaSkillCtrl:GetMapBorder()
  self:AddAfterHurtTrigger("bs_212103", 1, self.OnAfterHurt, nil, self.caster)
  self.caster.recordTable.P2 = false
  self.caster.recordTable.P3 = false
  self.caster.recordTable.P4 = false
end

function bs_212103:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local hprate = self.caster._curHp * 1000 // self.caster.maxHp
  if hprate <= self.arglist[3] and self.caster.recordTable.P4 == false then
    self.caster.recordTable.P2 = true
    self.caster.recordTable.P3 = true
    self.caster.recordTable.P4 = true
    self:doskill()
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[5], BindCallback(self, self.doskill), nil, -1, 0)
  elseif hprate <= self.arglist[2] and self.caster.recordTable.P3 == false then
    self.caster.recordTable.P2 = true
    self.caster.recordTable.P3 = true
    self:doskill()
  elseif hprate <= self.arglist[1] and self.caster.recordTable.P2 == false then
    self.caster.recordTable.P2 = true
    self:doskill()
  end
end

function bs_212103:doskill()
  if self.MapBorder.x == 6 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(2, 2)
    LuaSkillCtrl:CallEffect(effectGrid, self.config.effect_small, self)
  elseif self.MapBorder.x == 7 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
    LuaSkillCtrl:CallEffect(effectGrid, self.config.effect, self)
  elseif self.MapBorder.x == 10 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(4, 2)
    LuaSkillCtrl:CallEffect(effectGrid, self.config.effect_big, self)
  end
  local playerList = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if playerList ~= nil and playerList.Count > 0 then
    for i = playerList.Count - 1, 0, -1 do
      if playerList[i] ~= nil and 0 < playerList[i].targetRole.hp then
        local role = playerList[i]
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
          self.arglist[4]
        })
        skillResult:EndResult()
      end
    end
  end
end

function bs_212103:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_212103
