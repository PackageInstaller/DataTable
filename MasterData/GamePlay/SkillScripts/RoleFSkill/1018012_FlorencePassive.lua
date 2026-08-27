local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1018012 = class("bs_1018012", base)
bs_1018012.config = {buffId_love = 10180201, effectId_pass = 101805}

function bs_1018012:ctor()
end

function bs_1018012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if LuaSkillCtrl.IsInTDBattle and LuaSkillCtrl.cluaSkillCtrl ~= nil then
    return
  end
  self:AddAfterHurtTrigger("bs_1018012_3", 1, self.OnAfterHurt, self.caster)
  self:AddBuffDieTrigger("bs_1018012_2", 1, self.OnBuffDie, nil, nil, self.config.buffId_love)
  self:AddAfterAddBuffTrigger("bs_1018012_4", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.config.buffId_love)
  self.time = 0
  self._cacheTargets = {}
end

function bs_1018012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack then
    self.time = self.time + 1
  end
  if self.time >= self.arglist[1] and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange) then
    self.time = 0
    LuaSkillCtrl:CallEffect(target, self.config.effectId_pass, self)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_love, 1, self.arglist[2])
  end
end

function bs_1018012:OnAfterAddBuff(buff, target)
  local skillCollisionCtrl = LuaSkillCtrl.battleCtrl.skillCollisionController
  if skillCollisionCtrl ~= nil then
    skillCollisionCtrl:RemoveCollider(target.collider, target.belong)
    if target.collider ~= nil then
      target.collider:Dispose()
      target.collider = nil
    end
  end
  local cacheBelong = target._thisBelong
  if target._thisBelong ~= nil then
    cacheBelong = target._thisBelong
    target._thisBelong = self.caster.belong
  elseif target.summoner.belong ~= nil then
    cacheBelong = target.summoner.belong
    target.summoner.belong = self.caster.belong
  end
  self._cacheTargets[target] = cacheBelong
end

function bs_1018012:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_love then
    self:RecoverBelong(target)
  end
end

function bs_1018012:RecoverBelong(target)
  local cacheBelong = self._cacheTargets[target]
  if cacheBelong ~= nil then
    local skillCollisionCtrl = LuaSkillCtrl.battleCtrl.skillCollisionController
    if skillCollisionCtrl ~= nil then
      skillCollisionCtrl:RemoveCollider(target.collider, target.belong)
      if target.collider ~= nil then
        target.collider:Dispose()
        target.collider = nil
      end
    end
    if target._thisBelong ~= nil then
      target._thisBelong = cacheBelong
    elseif target.summoner ~= nil then
      target.summoner.belong = cacheBelong
    end
    target:InitSkillCollider()
    self._cacheTargets[target] = nil
  end
end

function bs_1018012:OnCasterDie()
  base.OnCasterDie(self)
  for k, v in pairs(self._cacheTargets) do
    self:RecoverBelong(k)
  end
end

function bs_1018012:LuaDispose()
  base.LuaDispose(self)
end

return bs_1018012
