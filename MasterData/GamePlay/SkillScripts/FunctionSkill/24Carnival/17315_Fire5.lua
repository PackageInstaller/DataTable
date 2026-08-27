local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_17315 = class("bs_17315", FireBase)
local base = FireBase
bs_17315.config = {buffId_miniFire = 110150, time = 1}
bs_17315.config = setmetatable(bs_17315.config, {
  __index = base.config
})

function bs_17315:ctor()
end

function bs_17315:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17315", 1, self.OnAfterBattleStart)
  self.timer = nil
end

function bs_17315:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  local eventFunc = BindCallback(self, self.eventFunc)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], eventFunc, nil, -1, self.arglist[1])
end

function bs_17315:eventFunc()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
  if targetList.Count <= 0 then
    return
  end
  local targetRole = targetList[0].targetRole
  if targetList.Count > 0 and targetRole.belongNum == eBattleRoleBelong.enemy then
    self:CallFireBuff(targetRole, 1)
  end
end

function bs_17315:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_17315
