local bs_25276 = class("bs_25276", LuaSkillBase)
local base = LuaSkillBase
bs_25276.config = {buffId = 195}

function bs_25276:ctor()
end

function bs_25276:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_25276_2", 1, self.OnAfterAddBuff, nil, nil, eBattleRoleBelong.player, eBattleRoleBelong.enemy, nil, nil, eBuffFeatureType.BeatBack)
end

function bs_25276:OnAfterAddBuff(buff, target)
  if target.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 2, 75)
  end
end

function bs_25276:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25276
