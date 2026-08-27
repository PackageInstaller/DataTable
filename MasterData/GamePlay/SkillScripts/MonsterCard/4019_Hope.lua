local bs_4019 = class("bs_4019", LuaSkillBase)
local base = LuaSkillBase
bs_4019.config = {
  effectIdline = 10430,
  effectId1 = 10428,
  effectId2 = 10429,
  effectId3 = 102506,
  effectId4 = 10432,
  monsterId = 401901,
  select_id = 42,
  select_range = 10
}
local SyncAttrList = {
  eHeroAttr.moveSpeed,
  eHeroAttr.dodge,
  eHeroAttr.crit,
  eHeroAttr.critDamage,
  eHeroAttr.sunder,
  eHeroAttr.damage_increase,
  eHeroAttr.injury_reduce,
  eHeroAttr.heal,
  eHeroAttr.treatment,
  eHeroAttr.magic_pen,
  eHeroAttr.cd_reduce,
  eHeroAttr.resistance
}

function bs_4019:ctor()
end

function bs_4019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4019_1", 1, self.OnAfterBattleStart)
  self.caster.recordTable.hope_hurt = self.arglist[4]
end

function bs_4019:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, 5, function()
    self:CallSummoner()
  end, nil, self.arglist[5] - 1, 5)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, nil, true)
end

function bs_4019:FindEmptyGrid()
  local grid
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      grid = LuaSkillCtrl:FindEmptyGridAroundRole(targetlist[i].targetRole)
      if grid ~= nil then
        return grid
      end
    end
    grid = LuaSkillCtrl:FindEmptyGridsWithinRange(targetlist[0].targetRole.x, targetlist[0].targetRole.y, 3)
  end
  return grid
end

function bs_4019:CallSummoner()
  local grid = self:FindEmptyGrid()
  if grid == nil then
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId2, self)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, grid.x, grid.y)
  local Rolelist = LuaSkillCtrl:CallTargetSelect(self, 79, 20)
  if Rolelist ~= nil and Rolelist.Count > 0 then
    local highHPRole = Rolelist[Rolelist.Count - 1].targetRole
    if highHPRole ~= nil then
      summoner:SetAttr(eHeroAttr.maxHp, highHPRole.maxHp * self.arglist[1] // 1000)
      summoner:SetAttr(eHeroAttr.pow, highHPRole.pow * self.arglist[2] // 1000)
      summoner:SetAttr(eHeroAttr.speed, highHPRole.speed)
      summoner:SetAttr(eHeroAttr.def, highHPRole.def * self.arglist[3] // 1000)
      summoner:SetAttr(eHeroAttr.magic_res, highHPRole.magic_res * self.arglist[3] // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, highHPRole.skill_intensity * self.arglist[2] // 1000)
      for i, v in ipairs(SyncAttrList) do
        local curValue = highHPRole:GetRealProperty(v)
        summoner:SetAttr(v, curValue)
      end
      summoner:SetAsRealEntity(1)
      LuaSkillCtrl:AddSummonerRole(summoner)
    end
  end
end

function bs_4019:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_4019:LuaDispose()
  base.LuaDispose(self)
end

return bs_4019
