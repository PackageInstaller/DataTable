local bs_107504 = class("bs_107504", LuaSkillBase)
local base = LuaSkillBase
bs_107504.config = {
  selectId = 9,
  buff_taunt = 3002,
  buff_test_big = 107504,
  selectRange = 10,
  effectId_taunt = 107511,
  effectId_taunt_newyear = 107521,
  buff_hurt = 107512
}

function bs_107504:ctor()
end

function bs_107504:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.hurtArea = nil
  self:AddAfterAddBuffTrigger("107504_4", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buff_test_big)
  self:AddBuffDieTrigger("bs_107504_6", 1, self.OnBuffDie, nil, nil, self.config.buff_test_big)
end

function bs_107504:OnAfterAddBuff()
  local roles = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 2, true)
  if roles.Count > 0 then
    for i = 0, roles.Count - 1 do
      if roles[i].intensity ~= 0 and roles[i].belongNum == 2 then
        LuaSkillCtrl:CallBuff(self, roles[i], self.config.buff_taunt, 1, self.arglist[1])
      end
    end
  end
  local _onEnter = BindCallback(self, self.OnEnter)
  local _onExite = BindCallback(self, self.OnExite)
  if self.hurtArea == nil then
    self.hurtArea = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 175, 0, eColliderInfluenceType.Enemy, _onEnter, nil, _onExite, nil, false, false, nil, self.caster)
  else
    LuaSkillCtrl:SetCircleColliderAndEffectRadius(self.hurtArea.collider, 175, nil)
  end
end

function bs_107504:OnEnter(collider, index, entity)
  LuaSkillCtrl:CallBuff(self, entity, self.config.buff_hurt, 1, self.arglist[1], true)
end

function bs_107504:OnBuffDie(buff, target, removeType)
  if self.hurtArea == nil then
    return
  end
  if removeType == eBuffRemoveType.Timeout and self.hurtArea.collider ~= nil then
    LuaSkillCtrl:SetCircleColliderAndEffectRadius(self.hurtArea.collider, 0, nil)
  end
end

function bs_107504:OnExite(collider, entity)
  LuaSkillCtrl:DispelBuff(entity, self.config.buff_hurt, 1, true)
end

function bs_107504:OnCasterDie()
  base.OnCasterDie(self)
  if self.hurtArea ~= nil then
    self.hurtArea:EndAndDisposeEmission()
    self.hurtArea = nil
  end
end

function bs_107504:LuaDispose()
  base.LuaDispose(self)
  self.hurtArea = nil
end

return bs_107504
