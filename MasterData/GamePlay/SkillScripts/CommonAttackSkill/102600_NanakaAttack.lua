local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102600 = class("bs_102600", bs_1)
local base = bs_1
bs_102600.config = {
  effectId_trail = 10719,
  effectId_trail_summer = 1071903,
  effectId_trail_vow = 1071904,
  audioId1 = 254,
  audioId2 = 255,
  audioId5 = 342
}
bs_102600.config = setmetatable(bs_102600.config, {
  __index = base.config
})

function bs_102600:ctor()
end

function bs_102600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102600:ExecuteEffectAttack(data, atkActionId, target, effectId1, effectId2)
  if data.audioId4 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
  end
  local SkinId = LuaSkillCtrl:GetCasterSkinId(self.caster)
  if SkinId == 302606 then
    effectId1 = effectId1 or data.effectId_trail_summer
  elseif SkinId == 302607 then
    effectId1 = effectId1 or data.effectId_trail_vow
  else
    effectId1 = effectId1 or data.effectId_trail
  end
  LuaSkillCtrl:CallEffectWithArg(target, effectId1, self, nil, false, self.SkillEventFunc, data)
end

function bs_102600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102600
