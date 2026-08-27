local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_106 = class("sc_106", StorySkillBase)
local base = StorySkillBase
sc_106.config = {buff = 2305}
sc_106.config = setmetatable(sc_106.config, {
  __index = base.config
})

function sc_106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_106:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self.pasika = self:GetRole(1071)
  if self.pasika == nil or self.pasika.belongNum ~= eBattleRoleBelong.player then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.pasika, self.config.buff, 1)
  local target = self:GetRole(1071)
  if target == nil then
    return
  end
  local damage = target.maxHp * 100 // 1000
  if damage >= target.hp then
    damage = target.hp - 1
  end
  LuaSkillCtrl:RemoveLife(target.maxHp * 100 // 1000, self, target, nil, nil, true, nil, eHurtType.RealDmg, true)
end

function sc_106:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_106
