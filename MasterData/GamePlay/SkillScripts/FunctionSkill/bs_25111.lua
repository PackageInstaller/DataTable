local bs_25111 = class("bs_25111", LuaSkillBase)
local base = LuaSkillBase
bs_25111.config = {buffId = 195}

function bs_25111:ctor()
end

function bs_25111:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_25111_2", 1, self.OnAfterAddBuff, nil, nil, eBattleRoleBelong.player, eBattleRoleBelong.enemy, nil, nil, eBuffFeatureType.BeatBack)
end

function bs_25111:OnAfterAddBuff(buff, target)
  if target.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, 75)
  end
end

function bs_25111:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25111
