local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_31004 = class("bs_31004", FireBase)
local base = FireBase
bs_31004.config = {buffId_hotFire = 107101}
bs_31004.config = setmetatable(bs_31004.config, {
  __index = base.config
})

function bs_31004:ctor()
end

function bs_31004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.time = 0
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_31004", 1, self.OnAfterBattleStart)
end

function bs_31004:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self:AddAfterAddBuffTrigger("bs_31004_1", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.NowFireBuff, nil, nil)
end

function bs_31004:OnAfterAddBuff(buff, target)
  self.time = self.time + buff.tier
  if self.time >= self.arglist[1] then
    while self.time >= 3 do
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_hotFire, 1, 120)
      self.time = self.time - 3
    end
  end
end

function bs_31004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_31004
