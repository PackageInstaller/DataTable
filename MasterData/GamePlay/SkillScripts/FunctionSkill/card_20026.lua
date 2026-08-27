local card_20026 = class("card_20026", LuaSkillBase)
local base = LuaSkillBase
card_20026.config = {}

function card_20026:ctor()
end

function card_20026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("card_20026_10", 1, self.OnAfterAddBuff, nil, nil, nil, nil, nil, eBuffType.Debeneficial)
end

function card_20026:OnAfterAddBuff(buff, target)
  local maker = buff.maker
  if buff.buffType == 2 and target.belongNum == eBattleRoleBelong.enemy and maker.belongNum == eBattleRoleBelong.player and maker.roleType ~= eBattleRoleType.skillCaster then
    local buffId = buff.dataId
    local buffDuration = buff.totalTime
    local buffSkill = buff.battleSkill
    LuaSkillCtrl:CallBuffWithOriginSkill(buffSkill, maker, buffId, 1, 75, true, target, true)
  end
end

function card_20026:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20026
