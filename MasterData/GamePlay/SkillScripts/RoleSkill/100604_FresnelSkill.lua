local bs_100602 = require("GamePlay.SkillScripts.RoleSkill.100602_FresnelSkill")
local bs_100604 = class("bs_100604", bs_100602)
local base = bs_100602
bs_100604.config = {
  buffId_rj = 107101,
  weaponLv = 1,
  hurt_config = 38
}
bs_100604.config = setmetatable(bs_100604.config, {
  __index = base.config
})

function bs_100604:ctor()
end

function bs_100604:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.rjCount = 0
end

function bs_100604:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_rj and target ~= nil and target.hp > 0 then
    self.rjCount = self.rjCount + 1
    if self.rjCount >= 4 then
      LuaSkillCtrl:CallEffect(target, self.config.effectId_lz, self)
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_fire, 1)
      self.rjCount = self.rjCount - 4
    end
  end
end

function bs_100604:OnCasterDie()
  base.OnCasterDie(self)
  self.rjCount = nil
end

return bs_100604
