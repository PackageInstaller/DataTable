local bs_200303 = require("GamePlay.SkillScripts.MonsterSkill.200303_RN_GouDF")
local bs_203102 = class("bs_203102", bs_200303)
local base = bs_200303
bs_203102.config = {
  effectId = 10591,
  hurtEffectId = 10592,
  effectPick = 2004301,
  effectLine = 2004302,
  buffId = 1095
}
bs_203102.config = setmetatable(bs_203102.config, {
  __index = base.config
})

function bs_203102:ctor()
end

function bs_203102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_203102:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203102
