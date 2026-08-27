local bs_214401 = class("bs_214401", LuaSkillBase)
local base = LuaSkillBase
bs_214401.config = {configId = 5, effectId = 12091}

function bs_214401:ctor()
end

function bs_214401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnQiuCollected, self.OnQiuCollected)
  self.maxRole = nil
  self.count = 0
  self.isShootCount = false
  self.extraSkill = nil
  LuaSkillCtrl:StartTimer(nil, 7, function()
    if self.caster.recordTable.ShootCount ~= nil then
      self.extraSkill = self.caster.recordTable.ShootCount
      self.isShootCount = true
    end
  end)
  LuaSkillCtrl:CallBuff(self, self.caster, 175, 1, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, 88, 1, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, 198, 1, nil)
end

function bs_214401:OnQiuCollected()
  if not self:IsReadyToTake() then
    return
  end
  if self.target == nil or self.target.isDead then
    local list = LuaSkillCtrl:CallTargetSelect(self, 93, 10)
    if list == nil or list.Count < 1 then
      return
    end
    self.target = list[0].targetRole
  end
  local target = self.target
  self.caster:LookAtTarget(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local collisionTrigger = BindCallback(self, self.OnCollision, target)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true, nil, nil)
  self:OnSkillTake()
  if not self.isShootCount then
    return
  end
  self.extraSkill:Growth(self.caster)
end

function bs_214401:OnCollision(target, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity.belongNum == eBattleRoleBelong.player then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.caster.skill_intensity * self.arglist[1] // 1000
  }, true, true)
  skillResult:EndResult()
end

function bs_214401:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_214401:LuaDispose()
  base.LuaDispose(self)
end

return bs_214401
