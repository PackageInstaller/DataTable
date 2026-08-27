local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_104600 = class("bs_104600", bs_1)
local base = bs_1
bs_104600.config = {
  effectId_trail = 104601,
  effectId_trail_ex = 104601,
  effectId_split_shoot = 104616,
  effectId_split_shoot_ex = 104616
}
bs_104600.config = setmetatable(bs_104600.config, {
  __index = base.config
})

function bs_104600:ctor()
end

function bs_104600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104600:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnCommonAttackTrigger, target, self.caster, self.cskill)
  base.OnAttackTrigger(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
end

function bs_104600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104600
