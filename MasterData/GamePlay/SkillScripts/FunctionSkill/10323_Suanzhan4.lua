local bs_10323 = class("bs_10323", LuaSkillBase)
local base = LuaSkillBase
bs_10323.config = {
  buffWKId = 1248,
  buffDuration = 60,
  buffDuration2 = 120,
  buffDamageTime = 15,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10185,
    crit_formula = 0
  },
  effectIdHit = 10939,
  effectIdXS = 10940
}

function bs_10323:ctor()
end

function bs_10323:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_10323_10", 1, self.OnRoleDie, self.caster, nil, nil, nil, nil, nil, self.config.skillId)
  self.num = 0
end

function bs_10323:OnRoleDie(killer, role)
  if killer == self.caster and role.belongNum ~= 0 then
    local targetlist = LuaSkillCtrl:GetAllFriendRoles()
    if #targetlist < 1 then
      return
    end
    for k, v in pairs(targetlist) do
      local targetRole = v
      if targetRole == nil then
        break
      end
      local buffTier = targetRole:GetBuffTier(self.config.buffWKId)
      if buffTier == 0 and targetRole.belongNum == self.caster.belongNum then
        if self.caster.recordTable["30056_WK"] then
          LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffWKId, self.arglist[1], self.config.buffDuration2)
          self.num = self.num + 1
          local arriveCallBack = BindCallback(self, self.OnArriveAction, targetRole)
          local damageTime = self.config.buffDuration2 // self.config.buffDamageTime
          if self.timer == nil then
            self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDamageTime, arriveCallBack, nil, damageTime, self.config.buffDamageTime)
          else
            if self.timer ~= nil then
              self.timer:Stop()
              self.timer = nil
            end
            self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDamageTime, arriveCallBack, nil, damageTime, self.config.buffDamageTime)
          end
        else
          LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffWKId, self.arglist[1], self.config.buffDuration)
          self.num = self.num + 1
          local arriveCallBack = BindCallback(self, self.OnArriveAction, targetRole)
          local damageTime = self.config.buffDuration // self.config.buffDamageTime
          if self.timer == nil then
            self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDamageTime, arriveCallBack, nil, damageTime, self.config.buffDamageTime)
          else
            if self.timer ~= nil then
              self.timer:Stop()
              self.timer = nil
            end
            self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDamageTime, arriveCallBack, nil, damageTime, self.config.buffDamageTime)
          end
        end
      end
      if 1 <= self.num then
        break
      end
    end
    self.num = 0
  end
end

function bs_10323:OnArriveAction(targetRole)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local tier = targetRole:GetBuffTier(self.config.buffWKId)
  if 0 < tier then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1, 10)
    if targetlist.Count == 0 then
      return
    end
    if targetlist[0].targetRole == nil then
      return
    end
    local targetRole = targetlist[0].targetRole
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {tier}, true)
    LuaSkillCtrl:CallEffect(targetRole, self.config.effectIdHit, self)
    skillResult:EndResult()
  elseif self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_10323:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_10323:LuaDispose()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  base.LuaDispose(self)
end

return bs_10323
