local bs_25281 = class("bs_25281", LuaSkillBase)
local base = LuaSkillBase
bs_25281.config = {
  summonerId = 71,
  effectId_down = 10111,
  maxHpPer = 100,
  powPer = 1000,
  skill_intensityPer = 1000,
  critPer = 0,
  critDamagePer = 0,
  defPer = 0,
  sunderPer = 0,
  magic_resPer = 0,
  magic_penPer = 0
}

function bs_25281:ctor()
end

function bs_25281:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
end

function bs_25281:OnRoleSplash(role, grid, lastCoordX, lastCoordY)
  if role ~= self.caster then
    return
  end
  local toCastGrid = LuaSkillCtrl:GetGridWithPos(lastCoordX, lastCoordY)
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.CreatBoomer, toCastGrid))
end

function bs_25281:OnRolePhaseMoveStart(role, luaSkill, lastCoordX, lastCoordY)
  if role ~= self.caster then
    return
  end
  local toCastGrid = LuaSkillCtrl:GetGridWithPos(lastCoordX, lastCoordY)
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.CreatBoomer, toCastGrid))
end

function bs_25281:CreatBoomer(grid)
  local role = LuaSkillCtrl:GetRoleWithPos(grid.x, grid.y)
  local x, y
  if role ~= nil then
    local emptyGrid = LuaSkillCtrl:FindEmptyGridWithinRange(role, 3)
    x, y = emptyGrid.x, emptyGrid.y
  else
    x, y = grid.x, grid.y
  end
  if x == nil and y == nil then
    return
  end
  local master = self.caster
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summonerId, x, y, eBattleRoleBelong.player)
  summoner:SetAttr(eHeroAttr.maxHp, master.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, master.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, master.skill_intensity * self.config.skill_intensityPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, master.speed)
  summoner:SetAttr(eHeroAttr.def, master.def * self.config.defPer // 1000)
  summoner:SetAttr(eHeroAttr.crit, master.crit * self.config.critPer // 1000)
  summoner:SetAttr(eHeroAttr.critDamage, master.critDamage * self.config.critDamagePer // 1000)
  summoner:SetAttr(eHeroAttr.sunder, master.sunder * self.config.sunderPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, master.magic_res * self.config.magic_resPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_pen, master.magic_pen * self.config.magic_penPer // 1000)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
end

function bs_25281:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_25281:LuaDispose()
  base.LuaDispose(self)
end

return bs_25281
