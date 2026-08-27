local gs_44 = class("gs_44", LuaGridBase)
local base = LuaGridBase
gs_44.config = {
  duration = 90,
  SummonnerId = 87,
  maxHp = 9000,
  effectId_ForSummoner = 12140,
  effectId_OnCast = 12141
}

function gs_44:ctor()
end

function gs_44:CastSummoner()
  local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_OnCast, self)
  local isEmpty = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
  if isEmpty ~= nil then
    return
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.SummonnerId, self.x, self.y, eBattleRoleBelong.neutral)
  summoner:SetAttr(eHeroAttr.maxHp, self.config.maxHp)
  summoner:SetAttr(eHeroAttr.pow, 0)
  summoner:SetAttr(eHeroAttr.skill_intensity, 0)
  summoner:SetAttr(eHeroAttr.speed, 0)
  summoner:SetAttr(eHeroAttr.def, 0)
  summoner:SetAttr(eHeroAttr.crit, 0)
  summoner:SetAttr(eHeroAttr.critDamage, 0)
  summoner:SetAttr(eHeroAttr.sunder, 0)
  summoner:SetAttr(eHeroAttr.magic_res, 0)
  summoner:SetAttr(eHeroAttr.magic_pen, 0)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_ForSummoner, self)
end

function gs_44:OnGridBattleStart(role)
  local bind = BindCallback(self, self.CastSummoner)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, bind, nil, -1, self.config.duration)
end

function gs_44:OnGridBeCorvered(role, coverGrid)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_44:LuaDispose()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  base.LuaDispose(self)
end

return gs_44
