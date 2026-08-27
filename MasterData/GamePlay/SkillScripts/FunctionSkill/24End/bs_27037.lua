local bs_27037 = class("bs_27037", LuaSkillBase)
local base = LuaSkillBase
bs_27037.config = {buff = 2300}

function bs_27037:ctor()
end

function bs_27037:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_27037_1", 1, self.OnAfterBattleStart)
  self.circle_entity_num = 0
  self.buff_flag = false
  self.first_flag = true
end

function bs_27037:OnAfterBattleStart()
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  local onArrive = BindCallback(self, self.OnArrive)
  self.halo = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, collisionExit, nil, false, false, onArrive, self.caster)
end

function bs_27037:OnArrive()
  local roles = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if roles == nil or roles.Count < 1 then
    return
  end
  for i = 0, roles.Count - 1 do
    self:OnCollisionEnter(nil, nil, roles[i])
  end
  if self.circle_entity_num == 0 and self.buff_flag == false then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff, 1)
    self.buff_flag = true
  end
end

function bs_27037:OnCollisionEnter(collider, index, entity)
  if entity.belongNum ~= eBattleRoleBelong.player then
    return
  end
  self.circle_entity_num = self.circle_entity_num + 1
  if self.circle_entity_num >= 1 and self.buff_flag == true then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff, 0)
    self.buff_flag = false
  end
end

function bs_27037:OnCollisionExit(collider, entity)
  if entity.belongNum ~= eBattleRoleBelong.player then
    return
  end
  self.circle_entity_num = self.circle_entity_num - 1
  if self.circle_entity_num < 1 and self.buff_flag == false then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff, 1)
    self.buff_flag = true
  end
end

function bs_27037:OnCasterDie()
  base.OnCasterDie(self)
  if self.halo ~= nil then
    self.halo:EndAndDisposeEmission()
    self.halo = nil
  end
end

function bs_27037:LuaDispose()
  base.LuaDispose(self)
  self.halo = nil
end

return bs_27037
