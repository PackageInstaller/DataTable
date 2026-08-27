local card_10008 = class("card_10008", LuaSkillBase)
local base = LuaSkillBase
card_10008.config = {buffId = 107101, buffId1 = 1505}

function card_10008:ctor()
end

function card_10008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("card_10008_10", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId)
end

function card_10008:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId and target.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId1, 1, 75, true)
  end
end

function card_10008:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10008
