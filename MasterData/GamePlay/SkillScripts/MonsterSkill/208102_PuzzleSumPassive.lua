local bs_208102 = class("bs_208102", LuaSkillBase)
local base = LuaSkillBase
bs_208102.config = {
  buffIdYS = 105006,
  buffId_3002 = 3002,
  buffId = 105001,
  buffId_tip = 105005
}

function bs_208102:ctor()
end

function bs_208102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self.arg1 = self.caster.recordTable.arg_1
  self.arg2 = self.caster.recordTable.arg_2
  self.role = self.caster.recordTable.role
  self.arg3 = self.caster.recordTable.arg_3
  self.arg4 = self.caster.recordTable.arg_4
end

function bs_208102:OnRealSummonerCaster(role)
  if role == self.caster then
    LuaSkillCtrl:CallRoleAction(self.caster, 102, 1)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdYS, 1)
    local KillSelf = BindCallback(self, self.KillSelf, role)
    LuaSkillCtrl:StartTimer(self, self.arg1, KillSelf)
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnPuzzleNewSummoner, self.caster)
    self.tigger = true
    LuaSkillCtrl:StartTimer(nil, 1, function()
      self.tigger = false
    end)
    local tarList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if tarList.Count > 0 then
      for i = 0, tarList.Count - 1 do
        if tarList[i].roleDataId == self.arg2 then
          self:KillSelf(role)
        end
      end
    end
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    local collisionExit = BindCallback(self, self.OnCollisionExit)
    self.halo = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
    local collisionEnter1 = BindCallback(self, self.OnCollisionEnter1)
    self.halo1 = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 175, 0, eColliderInfluenceType.Enemy, collisionEnter1, nil, nil, nil, false, false, nil, self.caster)
  end
  if role.roleDataId == self.arg2 then
    self:KillSelf(role)
  end
end

function bs_208102:OnCollisionEnter(collider, index, entity)
  if entity:GetBuffTier(self.config.buffId) < 1 and entity.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId, self.arg3, nil, true)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_tip, 1, nil)
  end
end

function bs_208102:OnCollisionExit(collider, entity)
  if entity:GetBuffTier(self.config.buffId) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId, 0)
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_tip, 0)
  end
end

function bs_208102:OnCollisionEnter1(collider, index, entity)
  if self.tigger == true then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_3002, 1, self.arg4)
  end
end

function bs_208102:KillSelf(role)
  local hurt = self.caster.maxHp + 1
  LuaSkillCtrl:StartTimer(self, 3, function()
    LuaSkillCtrl:RemoveLife(hurt, self, self.caster, false, nil, false, true, eHurtType.RealDmg, true)
  end)
end

function bs_208102:OnCasterDie()
  if self.halo ~= nil then
    self.halo:EndAndDisposeEmission()
    self.halo = nil
  end
  if self.halo1 ~= nil then
    self.halo1:EndAndDisposeEmission()
    self.halo1 = nil
  end
  base.OnCasterDie(self)
end

function bs_208102:LuaDispose()
  if self.halo ~= nil then
    self.halo:EndAndDisposeEmission()
    self.halo = nil
  end
  if self.halo1 ~= nil then
    self.halo1:EndAndDisposeEmission()
    self.halo1 = nil
  end
  base.LuaDispose(self)
end

return bs_208102
