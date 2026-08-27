local bs_20043 = class("bs_20043", LuaSkillBase)
local base = LuaSkillBase
bs_20043.config = {
  cakeSummonerId = 16,
  buffId_198 = 198,
  buffId_253 = 253,
  cakeBornInterval = 300,
  cakeFallEffect = 10832,
  cakeEffect = 10408
}

function bs_20043:ctor()
  self.__createCakeFunc = BindCallback(self, self.CreateCakeAndTauntToCaster)
end

function bs_20043:InitSkill(isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_20043_1", 1, self.OnAfterBattleStart)
end

function bs_20043:OnAfterBattleStart()
  self.checkAndCreateCakeTimer = LuaSkillCtrl:StartTimer(self, self.config.cakeBornInterval, self.__createCakeFunc, nil, -1, self.config.cakeBornInterval)
end

function bs_20043:CreateCakeAndTauntToCaster()
  if self.checkAndCreateCakeTimer ~= nil and self.checkAndCreateCakeTimer:IsOver() then
    self.checkAndCreateCakeTimer = nil
  end
  local grid = LuaSkillCtrl:FindEmptyGrid(nil)
  if grid == nil then
    if self.checkAndCreateCakeTimer ~= nil then
      self.checkAndCreateCakeTimer:Stop()
      self.checkAndCreateCakeTimer = nil
    end
    return
  end
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local cakeEffect = LuaSkillCtrl:CallEffectWithArg(gridTarget, self.config.cakeFallEffect, self, false, false, self.AfterEffectArive, grid)
  LuaSkillCtrl:PreSetRolePos(grid, self.caster)
end

function bs_20043:AfterEffectArive(grid, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CanclePreSetPos(self.caster)
    local cakeSum = LuaSkillCtrl:CreateSummoner(self, self.config.cakeSummonerId, grid.x, grid.y, eBattleRoleBelong.player)
    if cakeSum == nil then
      return
    end
    cakeSum:SetAttr(eHeroAttr.maxHp, 99999)
    cakeSum:SetAttr(eHeroAttr.attackRange, 10)
    cakeSum:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(cakeSum)
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId_253, 1, nil, true)
    LuaSkillCtrl:CallEffect(summonerEntity, self.config.cakeEffect, self)
    summonerEntity.recordTable.caster = self.caster
    summonerEntity.recordTable.cakeEffect = effect
  end
end

function bs_20043:OnCasterDie()
  LuaSkillCtrl:CanclePreSetPos(self.caster)
  if self.checkAndCreateCakeTimer ~= nil then
    self.checkAndCreateCakeTimer:Stop()
    self.checkAndCreateCakeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_20043
