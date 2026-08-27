local bs_70048 = class("bs_70048", LuaSkillBase)
local base = LuaSkillBase
bs_70048.config = {
  SummonnerId = 1,
  effectId_OnDie = 1,
  effectId_OnCast = 1
}

function bs_70048:ctor()
end

function bs_70048:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.timer = nil
end

function bs_70048:CastSelf()
  local isEmpty = LuaSkillCtrl:GetRoleWithPos(self.caster.x, self.caster.y)
  if not isEmpty then
    return
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.SummonnerId, self.CasterGrid.x, self.CasterGrid.y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAttr(eHeroAttr.def, self.caster.def)
  summoner:SetAttr(eHeroAttr.crit, self.caster.crit)
  summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage)
  summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res)
  summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_70048:OnCasterDie()
  base.OnCasterDie(self)
  local timerCallBack = BindCallback(self, self.CastSelf)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], timerCallBack, nil, -1)
end

function bs_70048:LuaDispose()
  base.LuaDispose(base)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_70048
