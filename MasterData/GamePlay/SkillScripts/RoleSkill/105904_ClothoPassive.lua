local bs_105901 = require("GamePlay.SkillScripts.RoleSkill.105901_ClothoPassive")
local bs_105904 = class("bs_105904", bs_105901)
local base = bs_105901
bs_105904.config = {weaponLv = 1}
bs_105904.config = setmetatable(bs_105904.config, {
  __index = base.config
})

function bs_105904:ctor()
end

function bs_105904:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_105904", 1, self.OnAfterHurt, {
    target = self.caster,
    extraArg3 = true
  })
  self.count = 0
end

function bs_105904:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss == true and target ~= nil and target.hp > 0 then
    self.count = self.count + 1
    if self.count >= self.arglist[8] then
      if self.caster.recordTable.Soul_Num < self.SoulnumMax then
        self.caster.recordTable.Soul_Num = self.caster.recordTable.Soul_Num + 1
        self.times = self.times + 1
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_times, 1)
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
      end
      self.count = 0
    end
  end
end

function bs_105904:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105904
