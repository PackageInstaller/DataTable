local card_20024 = class("card_20024", LuaSkillBase)
local base = LuaSkillBase
card_20024.config = {
  summoner1 = 20072,
  summoner2 = 20073,
  effectId_down = 10111,
  effectId_bomb_end = 10968,
  effectId = 212501
}

function card_20024:ctor()
end

function card_20024:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_20024_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("card_20024_1", 99, self.OnRoleDie, eBattleRoleBelong.player, nil, nil, nil)
end

function card_20024:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self._summoner = BindCallback(self, self.Summoner)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
end

function card_20024:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
    return
  end
  if self.summonerTimer ~= nil then
    self.summonerTimer:Stop()
    self.summonerTimer = nil
  end
  self.index = 0
  self.summonerTimer = LuaSkillCtrl:StartTimer(self, 2, self._summoner, targetlist, targetlist.Count - 1, 2)
end

function card_20024:Summoner(targetlist)
  if targetlist.Count <= self.index then
    return
  end
  local target = targetlist[self.index]
  if target.isDead == true then
    return
  end
  local targetGrid = LuaSkillCtrl:FindEmptyGridAroundRole(target)
  if targetGrid ~= nil then
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summoner2, targetGrid.x, targetGrid.y, eBattleRoleBelong.neutral)
    summoner:SetAttr(eHeroAttr.maxHp, target.maxHp * self.arglist[2] // 1000 + 1)
    summoner:SetAttr(eHeroAttr.pow, 0)
    summoner:SetAttr(eHeroAttr.skill_intensity, 0)
    summoner:SetAttr(eHeroAttr.speed, 0)
    summoner:SetAttr(eHeroAttr.def, 0)
    summoner:SetAttr(eHeroAttr.sunder, 0)
    summoner:SetAttr(eHeroAttr.magic_res, 0)
    summoner:SetAttr(eHeroAttr.magic_pen, 0)
    summoner:SetAsRealEntity(1)
    LuaSkillCtrl:AddSummonerRole(summoner)
  end
  self.index = self.index + 1
end

function card_20024:OnRoleDie(killer, role, skill)
  if killer.belongNum == eBattleRoleBelong.player and role.roleDataId == self.config.summoner2 then
    local damg = role.maxHp * self.arglist[3] // 1000
    local targetPos = LuaSkillCtrl:GetMapCenterPos()
    local targetnull = LuaSkillCtrl:GetTargetWithGrid(targetPos.x, targetPos.y)
    LuaSkillCtrl:CallEffect(targetnull, self.config.effectId_bomb_end, self)
    LuaSkillCtrl:RemoveLife(damg, self, killer, true, nil, true)
  end
end

function card_20024:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20024
