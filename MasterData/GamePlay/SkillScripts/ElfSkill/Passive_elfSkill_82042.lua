local bs_82042 = class("bs_82042", LuaSkillBase)
local base = LuaSkillBase
bs_82042.config = {buffId = 711}

function bs_82042:ctor()
end

function bs_82042:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_82042_1", 2, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, eBattleRoleType.realSummoner)
  self:AddAfterAddBuffTrigger("bs_82042_2", 1, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.player, self.config.buffId)
  self.skillCasterEntity = LuaSkillCtrl:GetPlayerRoleEntity()
end

function bs_82042:OnRoleDie(killer, role)
  if self.skillCasterEntity.recordTable.elfSkillTrigger == nil then
    self.skillCasterEntity.recordTable.elfSkillTrigger = self.caster
  end
  if self.skillCasterEntity.recordTable.elfSkillTrigger ~= self.caster then
    return
  end
  if role.belongNum == eBattleRoleBelong.player and role.roleType == eBattleRoleType.realSummoner then
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 80, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      LuaSkillCtrl:CallBuff(self, highAttRole[0].targetRole, self.config.buffId, 1, nil, false)
    end
  end
end

function bs_82042:OnAfterAddBuff(buff, target)
  if self.skillCasterEntity.recordTable.elfSkillTrigger == nil then
    self.skillCasterEntity.recordTable.elfSkillTrigger = self.caster
  end
  if self.skillCasterEntity.recordTable.elfSkillTrigger ~= self.caster then
    return
  end
  if buff.dataId == self.config.buffId and target.hp > 0 and target.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:StartTimer(nil, self.arglist[3], function(tempObj)
      if tempObj ~= nil and not tempObj.isDead and tempObj:GetBuffTier(self.config.buffId) > 0 then
        LuaSkillCtrl:DispelBuff(tempObj, self.config.buffId, 1)
      end
    end, target)
  end
end

function bs_82042:OnCasterDie()
  base.OnCasterDie(self)
  if self.skillCasterEntity.recordTable.elfSkillTrigger == self.caster then
    self.skillCasterEntity.recordTable.elfSkillTrigger = nil
  end
end

function bs_82042:LuaDispose()
  base.LuaDispose(self)
  self.skillCasterEntity = nil
end

return bs_82042
