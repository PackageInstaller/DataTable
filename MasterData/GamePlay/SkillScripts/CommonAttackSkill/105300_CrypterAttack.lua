local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105300 = class("bs_105300", bs_1)
local base = bs_1
bs_105300.config = {effectId_trail = 105300}
bs_105300.config = setmetatable(bs_105300.config, {
  __index = base.config
})

function bs_105300:ctor()
end

function bs_105300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105300:ExecuteEffectAttack(data, atkActionId, target, effectId1, effectId2)
  base.ExecuteEffectAttack(self, data, atkActionId, target, effectId1, effectId2)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnCrypterAttack, target, self.caster, self.cskill)
end

function bs_105300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105300
