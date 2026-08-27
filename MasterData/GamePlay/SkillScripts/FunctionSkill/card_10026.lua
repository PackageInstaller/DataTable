local card_10026 = class("card_10026", LuaSkillBase)
local base = LuaSkillBase
card_10026.config = {buffId1 = 1602}

function card_10026:ctor()
end

function card_10026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("card_10026_10", 1, self.OnAfterAddBuff, nil, nil, nil, nil, nil, eBuffType.Debeneficial)
end

function card_10026:OnAfterAddBuff(buff, target)
  if buff.buffType == 2 and target.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId1, 1, 75, true)
  end
end

function card_10026:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10026
