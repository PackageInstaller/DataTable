local bs_202603 = require("GamePlay.SkillScripts.MonsterSkill.202603_WisdomSkill")
local bs_203203 = class("bs_203203", bs_202603)
local base = bs_202603
bs_203203.config = {
  effectIdline = 10581,
  effectIdmiao = 10582,
  effectId = 10583,
  effectIdtrail = 10584
}
bs_203203.config = setmetatable(bs_203203.config, {
  __index = base.config
})

function bs_203203:ctor()
end

function bs_203203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_203203:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203203
