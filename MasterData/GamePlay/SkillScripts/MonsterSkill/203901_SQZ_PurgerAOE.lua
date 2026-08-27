local bs_200203 = require("GamePlay.SkillScripts.MonsterSkill.200203_SQZ_PurgerAOE")
local bs_203901 = class("bs_203901", bs_200203)
local base = bs_200203
bs_203901.config = {attackTime = 2, select_id = 43}
bs_203901.config = setmetatable(bs_203901.config, {
  __index = base.config
})

function bs_203901:ctor()
end

function bs_203901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_203901:OnMoveAttackTrigger(targetList)
  if self.config.audioId1 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
  local index = 0
  for i = 0, self.config.attackTime - 1 do
    if targetList[index].targetRole.intensity == 0 then
      index = 0
    end
    if targetList[index].targetRole ~= nil then
      LuaSkillCtrl:CallEffect(targetList[index].targetRole, self.config.effectId, self, self.SkillEventFunc)
    end
    index = index + 1
    if index >= targetList.Count then
      break
    end
  end
end

function bs_203901:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203901
