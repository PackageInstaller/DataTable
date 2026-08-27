local bs_31001 = class("bs_31001", LuaSkillBase)
local base = LuaSkillBase
bs_31001.config = {
  summonerId = 91,
  summonerId_override = 92,
  summonerNum = 1,
  maxHp_per = 100,
  def_per = 100,
  magic_res_per = 100
}

function bs_31001:ctor()
end

function bs_31001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_31001", 1, self.OnAfterBattleStart)
  self.master = nil
end

function bs_31001:OnAfterBattleStart()
  self.master = self:FindMaxMagic()
  self.targetId = self.config.summonerId
  if self.caster.recordTable.bs_31002 ~= nil then
    self.targetId = self.config.summonerId_override
  end
  self:CallSummoner()
  if self.caster.recordTable.bs_31003 ~= nil then
    self:CallSummoner()
  end
end

function bs_31001:CallSummoner()
  local target = self:FindMaxHp()
  local grid
  local grids = LuaSkillCtrl:FindEmptyGridAroundRole(target)
  if grids ~= nil then
    grid = grids
  end
  if grid == nil then
    grid = LuaSkillCtrl:FindEmptyGridWithinRange(target, 2)
  end
  if grid == nil then
    grid = LuaSkillCtrl:FindEmptyGridWithinRange(target, 3)
  end
  if grid == nil or LuaSkillCtrl:GetRoleWithPos(grid.x, grid.y) ~= nil then
    return
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.targetId, grid.x, grid.y, eBattleRoleBelong.neutral)
  summoner:SetAttr(eHeroAttr.maxHp, self.master.maxHp * self.config.maxHp_per // 1000)
  summoner:SetAttr(eHeroAttr.def, self.master.def * self.config.def_per // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, self.master.magic_res * self.config.magic_res_per // 1000)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:StartTimer(nil, 7, function()
    LuaSkillCtrl:CallEffect(summonerEntity, 70001, self)
  end)
end

function bs_31001:FindMaxHp()
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  local max_target = list[0]
  for i = 0, list.Count - 1 do
    if max_target.maxHp < list[i].maxHp then
      max_target = list[i]
    end
  end
  return max_target
end

function bs_31001:FindMaxMagic()
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local max_target = list[0]
  for i = 0, list.Count - 1 do
    if max_target.skill_intensity < list[i].skill_intensity then
      max_target = list[i]
    end
  end
  return max_target
end

function bs_31001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_31001
