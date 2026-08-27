local bs_25290 = class("bs_25290", LuaSkillBase)
local base = LuaSkillBase
bs_25290.config = {buffId_fire = 107101, buffId_Death = 2144}

function bs_25290:ctor()
end

function bs_25290:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_25290_1", 1, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, self.config.buffId_fire)
end

function bs_25290:OnAfterAddBuff(buff, target)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId_Death, 1, self.arglist[2], true)
end

function bs_25290:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25290
