local bs_27040 = class("bs_27040", LuaSkillBase)
local base = LuaSkillBase
bs_27040.config = {buff = 2302}

function bs_27040:ctor()
end

function bs_27040:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_27040_1", 1, self.OnAfterBattleStart)
  self.circle_entity_num = 0
  self.buff_flag = false
end

function bs_27040:OnAfterBattleStart()
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  local onArrive = BindCallback(self, self.OnArrive)
  self.halo = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, collisionExit, nil, false, false, onArrive, self.caster)
end

function bs_27040:OnArrive()
  local roles = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if roles == nil or roles.Count < 1 then
    return
  end
end

function bs_27040:OnCollisionEnter(collider, index, entity)
  if entity.belongNum ~= eBattleRoleBelong.enemy then
    return
  end
  self.circle_entity_num = self.circle_entity_num + 1
  if self.circle_entity_num >= 1 and self.buff_flag == false then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff, 1)
    self.buff_flag = true
  end
end

function bs_27040:OnCollisionExit(collider, entity)
  if entity.belongNum ~= eBattleRoleBelong.enemy then
    return
  end
  self.circle_entity_num = self.circle_entity_num - 1
  if self.circle_entity_num < 1 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff, 0)
    self.buff_flag = false
  end
end

function bs_27040:OnCasterDie()
  base.OnCasterDie(self)
  if self.halo ~= nil then
    self.halo:EndAndDisposeEmission()
    self.halo = nil
  end
end

function bs_27040:LuaDispose()
  base.LuaDispose(self)
  self.halo = nil
end

return bs_27040
