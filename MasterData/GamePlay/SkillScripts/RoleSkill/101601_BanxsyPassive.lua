local bs_101601 = class("bs_101601", LuaSkillBase)
local base = LuaSkillBase
bs_101601.config = {buffId_color = 101601, effectId_big = 101603}

function bs_101601:ctor()
end

function bs_101601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_101601_3", 1, self.OnAfterHurt, self.caster)
  self:AddBuffDieTrigger("bs_101601_5", 90, self.OnBuffDie, nil, nil, self.config.buffId_color)
  self.effect = {}
end

function bs_101601:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_color, 1)
  end
  if sender == self.caster and not skill.isCommonAttack and skill.dataId == 101602 and isTriggerSet ~= true and self.caster.recordTable.skill_target == target then
    local effect = LuaSkillCtrl:CallEffect(target, self.config.effectId_big, self)
    table.insert(self.effect, effect)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Enemy, nil, collisionEnter, nil)
    LuaSkillCtrl:StartTimer(nil, 75, function()
      if effect == nil then
        return
      end
      LuaSkillCtrl:ClearColliderOrEmission(effect.collider)
      effect:Die()
      effect = nil
    end)
    self.caster.recordTable.skill_target = nil
  end
end

function bs_101601:OnBuffDie(buff, target, removeType)
  if target.belongNum ~= self.caster.belongNum and self.effect ~= nil then
    for _, v in ipairs(self.effect) do
      if v ~= nil then
        v:Die()
      end
    end
    self.effect = nil
    self.effect = {}
  end
end

function bs_101601:OnCollisionEnter(collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= self.caster.belongNum and not entity:IsUnSelect(self.caster) and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_color, 1)
  end
end

function bs_101601:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_101601:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_101601
