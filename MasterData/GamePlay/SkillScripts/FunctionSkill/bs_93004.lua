local bs_93004 = class("bs_93004", LuaSkillBase)
local base = LuaSkillBase
bs_93004.config = {monsterId = 57, effectId_start = 10264}

function bs_93004:ctor()
end

function bs_93004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if 1 > targetlist.Count then
    return
  end
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
  if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
    self.intensity = highAttRole[0].targetRole.skill_intensity
  end
end

function bs_93004:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 69, 10)
  if targetlist.Count < 1 then
    if self.timer ~= nil then
      self.timer:Stop()
      self.timer = nil
    end
    return
  end
  local maxHp = 10000
  maxHp = targetlist[0].targetRole.maxHp
  local targetGrid = LuaSkillCtrl:FindEmptyGrid()
  if targetGrid ~= nil then
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, targetGrid.x, targetGrid.y)
    summoner:SetAttr(eHeroAttr.maxHp, maxHp)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.intensity)
    summoner:SetAttr(eHeroAttr.speed, 0)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    summonerEntity.recordTable.deathTime = self.arglist[4]
    LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_start, self)
  end
end

function bs_93004:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_93004
