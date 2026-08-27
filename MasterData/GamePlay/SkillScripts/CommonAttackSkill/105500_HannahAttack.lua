local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105500 = class("bs_105500", bs_1)
local base = bs_1
bs_105500.config = {effectId_trail = 105501, effectId = 105520}
bs_105500.config = setmetatable(bs_105500.config, {
  __index = base.config
})

function bs_105500:ctor()
end

function bs_105500:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105500:RealPlaySkill(target, data)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 305503 then
    LuaSkillCtrl:StartTimer(self, 8, function()
      LuaSkillCtrl:CallEffect(target, self.config.effectId, self, nil, nil, nil, nil)
    end)
  end
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 305504 then
    LuaSkillCtrl:StartTimer(self, 8, function()
      LuaSkillCtrl:CallEffect(target, self.config.effectId, self, nil, nil, nil, nil)
    end)
  end
  base.RealPlaySkill(self, target, data)
end

function bs_105500:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105500
