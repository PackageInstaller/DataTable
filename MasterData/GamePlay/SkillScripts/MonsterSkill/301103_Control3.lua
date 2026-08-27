local bs_301102 = require("GamePlay.SkillScripts.MonsterSkill.301102_Control2")
local bs_301103 = class("bs_301103", bs_301102)
local base = bs_301102
bs_301103.config = {
  deathRoleId = 40030,
  monsterId = 35,
  effectId = 10264,
  selfDeathTime = 75
}
bs_301103.config = setmetatable(bs_301103.config, {
  __index = base.config
})

function bs_301103:ctor()
end

function bs_301103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_301103:CallBack(x, y)
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, x, y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * 2)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:StartTimer(nil, self.config.selfDeathTime, self.Death, self)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 5, 20)
  if 1 > targetlist.Count then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if targetRole.roleDataId == 1045 then
      targetRole:AddRoleProperty(eHeroAttr.attackRange, -3, eHeroAttrType.Extra)
      targetRole:AddRoleProperty(eHeroAttr.moveSpeed, -100, eHeroAttrType.Extra)
    end
  end
end

function bs_301103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_301103
