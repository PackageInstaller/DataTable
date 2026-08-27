local bs_106004 = require("GamePlay.SkillScripts.RoleSkill.106004_DupinPassive")
local bs_106006 = class("bs_106006", bs_106004)
local base = bs_106004
bs_106006.config = {weaponLv = 3, buffId_EX = 106007}
bs_106006.config = setmetatable(bs_106006.config, {
  __index = base.config
})

function bs_106006:ctor()
end

function bs_106006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.exClueCount = 0
  self:AddAfterAddBuffTrigger("bs_106001_03", 1, self.OnAfterAddBuff, self.caster, self.caster, nil, nil, self.config.buffId_A)
end

function bs_106006:OnAfterAddBuff(buff, target)
  if target == self.caster and self.caster.recordTable.exClueCount >= self.arglist[4] then
    local ClueCount = self.caster.recordTable.exClueCount % self.arglist[4]
    self.permanentClue = math.min(self.arglist[6], self.permanentClue + self.arglist[5])
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_EX, self.arglist[5])
    self.caster.recordTable.exClueCount = ClueCount
  end
end

function bs_106006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106006
