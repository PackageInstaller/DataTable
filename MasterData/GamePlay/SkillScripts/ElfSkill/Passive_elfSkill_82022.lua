local bs_82022 = class("bs_82022", LuaSkillBase)
local base = LuaSkillBase
bs_82022.config = {buff_ranjie = 107101}

function bs_82022:ctor()
end

function bs_82022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_82022_1", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buff_ranjie)
  self.skillCasterEntity = LuaSkillCtrl:GetPlayerRoleEntity()
end

function bs_82022:OnAfterAddBuff(buff, target)
  if self.skillCasterEntity.recordTable.elfSkillTrigger == nil then
    self.skillCasterEntity.recordTable.elfSkillTrigger = self.caster
  end
  if self.skillCasterEntity.recordTable.elfSkillTrigger ~= self.caster then
    return
  end
  if buff.battleSkill.dataId ~= 82022 then
    local Role
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 80, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      Role = highAttRole[0].targetRole
    else
      return
    end
    if buff.dataId == self.config.buff_ranjie and target ~= nil and 0 < target.hp and target.belongNum ~= eBattleRoleBelong.player and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buff_ranjie, 1, 120, false, Role)
    end
  end
end

function bs_82022:OnCasterDie()
  if self.skillCasterEntity.recordTable.elfSkillTrigger == self.caster then
    self.skillCasterEntity.recordTable.elfSkillTrigger = nil
  end
  base.OnCasterDie(self)
end

function bs_82022:LuaDispose()
  base.LuaDispose(self)
  self.skillCasterEntity = nil
end

return bs_82022
