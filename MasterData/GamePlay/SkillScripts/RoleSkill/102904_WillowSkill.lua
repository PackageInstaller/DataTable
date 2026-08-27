local bs_102902 = require("GamePlay.SkillScripts.RoleSkill.102902_WillowSkill")
local bs_102904 = class("bs_102904", bs_102902)
local base = bs_102902
bs_102904.config = {weaponLv = 1}
bs_102904.config = setmetatable(bs_102904.config, {
  __index = base.config
})

function bs_102904:ctor()
end

function bs_102904:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102904:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102904
