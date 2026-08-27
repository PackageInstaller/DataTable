local bs_100908 = class("bs_100908", LuaSkillBase)
local base = LuaSkillBase
bs_100908.config = {
  hurtConfig = {
    hit_formula = 9991,
    def_formula = 9996,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  },
  selectId = 5,
  hitInterval = 15,
  buffIdAwake = 100904,
  buffId = 100902,
  buffId2 = 100903,
  effectId_loop1 = 100909,
  effectId_loop_hit = 100910,
  effectId_loop2 = 100911,
  effectId_loop3 = 100912,
  effectId_loop4 = 100913
}

function bs_100908:ctor()
end

function bs_100908:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_100908_03", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffIdAwake)
  self.MapBorder = LuaSkillCtrl:GetMapBorder()
end

function bs_100908:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffIdAwake and self.timer1 == nil then
    self.timer1 = LuaSkillCtrl:StartTimer(nil, self.arglist[2], self.callBack, self, -1, 15)
  end
end

function bs_100908:callBack()
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.clearEffect ~= nil then
    self.clearEffect:Stop()
    self.clearEffect = nil
  end
  if self.MapBorder.x == 6 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(2, 2)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop4, self)
  elseif self.MapBorder.x == 7 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop1, self)
  elseif self.MapBorder.x == 10 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(4, 2)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop3, self)
  else
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(12, 8)
    self.effect = LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_loop2, self)
  end
  LuaSkillCtrl:StartTimer(nil, self.config.hitInterval, function()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 10)
    for i = 0, targetList.Count - 1 do
      local role = targetList[i].targetRole
      if (role.belongNum ~= 1 or role.roleType ~= 4) and role.recordTable.WillowPic ~= true and role.roleDataId ~= 100 then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {
          self.arglist[3]
        }, true, false)
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(role, self.config.effectId_loop_hit, self)
      end
    end
  end, self, self.arglist[4] - 1)
  local skilltime = 30
  self.clearEffect = LuaSkillCtrl:StartTimer(nil, skilltime, function()
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end, self)
end

function bs_100908:OnCasterDie()
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
  if highAttRole == nil or highAttRole.Count == 0 or highAttRole[0] == nil then
    return
  end
  local role = highAttRole[0].targetRole
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffIdAwake, 1, nil)
  if self.timer1 ~= nil then
    self.timer1:Stop()
    self.timer1 = nil
  end
  base.OnCasterDie(self)
end

function bs_100908:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_100908
