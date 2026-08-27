local bs_82012 = class("bs_82012", LuaSkillBase)
local base = LuaSkillBase
bs_82012.config = {}

function bs_82012:ctor()
end

function bs_82012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.OnUltSkillPlayed)
  self.skillCasterEntity = LuaSkillCtrl:GetPlayerRoleEntity()
end

function bs_82012:OnUltSkillPlayed(role)
  if self.skillCasterEntity.recordTable.elfSkillTrigger == nil then
    self.skillCasterEntity.recordTable.elfSkillTrigger = self.caster
  end
  if self.skillCasterEntity.recordTable.elfSkillTrigger ~= self.caster then
    return
  end
  if role.belongNum == eBattleRoleBelong.player and role.roleType == eBattleRoleType.character then
    LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[1] / 1000)
  end
end

function bs_82012:OnCasterDie()
  if self.skillCasterEntity.recordTable.elfSkillTrigger == self.caster then
    self.skillCasterEntity.recordTable.elfSkillTrigger = nil
  end
  base.OnCasterDie(self)
end

function bs_82012:LuaDispose()
  base.LuaDispose(self)
  self.skillCasterEntity = nil
end

return bs_82012
