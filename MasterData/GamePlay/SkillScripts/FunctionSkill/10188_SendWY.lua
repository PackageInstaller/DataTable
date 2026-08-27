local bs_10188 = class("bs_10188", LuaSkillBase)
local base = LuaSkillBase
bs_10188.config = {buffId = 175}

function bs_10188:ctor()
end

function bs_10188:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10188_2", 10, self.OnAfterBattleStart)
end

function bs_10188:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.caoTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack)
end

function bs_10188:OnArriveAction()
  if self.caoTimer ~= nil and self.caoTimer:IsOver() then
    self.caoTimer = nil
  end
  local grid = LuaSkillCtrl:GetNearestEmptyEfcGrid(self.caster, 10)
  if grid ~= nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2])
    LuaSkillCtrl:CallEffect(self.caster, 10263, self)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, 10264, self)
  end
end

function bs_10188:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10188
