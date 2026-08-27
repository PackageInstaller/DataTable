local bs_82011 = class("bs_82011", LuaSkillBase)
local base = LuaSkillBase
bs_82011.config = {buffId_2 = 701}

function bs_82011:ctor()
end

function bs_82011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_82011_1", 1, self.OnAfterPlaySkill, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_82011:OnAfterPlaySkill(skill, role)
  if role ~= nil and role.roleType == 1 and skill.isUltSkill then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_2, 1, self.arglist[2], true)
  end
end

function bs_82011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_82011
