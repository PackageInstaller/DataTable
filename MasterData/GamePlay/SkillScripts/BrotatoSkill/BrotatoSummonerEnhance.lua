local BrotatoSummonerEnhance = class("BrotatoSummonerEnhance", LuaSkillBase)
local base = LuaSkillBase
BrotatoSummonerEnhance.config = {roleDeadTime = 10}

function BrotatoSummonerEnhance:ctor()
end

function BrotatoSummonerEnhance:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self:AddOnRoleDieTrigger("BrotatoSummonerEnhance_1", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
end

function BrotatoSummonerEnhance:OnRealSummonerCaster(role)
  local infoCfg = ConfigData.brotato_summoner_amend[role.roleDataId]
  if infoCfg ~= nil then
    role:AddRoleProperty(eHeroAttr.moveSpeed, infoCfg.move_speed_factor, eHeroAttrType.Ratio)
  end
end

function BrotatoSummonerEnhance:OnRoleDie(killer, role, killSkill)
  LuaSkillCtrl:StartTimer(nil, self.config.roleDeadTime, function(targetRole)
    targetRole.battleRoleView:SetRoleVisible(false)
  end, role)
end

return BrotatoSummonerEnhance
