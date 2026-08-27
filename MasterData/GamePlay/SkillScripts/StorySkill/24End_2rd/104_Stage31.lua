local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_104 = class("sc_104", StorySkillBase)
local base = StorySkillBase
sc_104.config = {
  maxHp = 1000000,
  pow = 10000,
  intensity = 10000,
  actionId = 1104,
  monsterId = 24,
  buffId = 278,
  buffId_wo = 1219,
  buufID_miansi = 3009,
  buffFeature_Invinciable = 2,
  totalTime = 300,
  buff_doubleAttack = 1121
}
sc_104.config = setmetatable(sc_104.config, {
  __index = base.config
})

function sc_104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_104:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  if not self:isBattleRoom(1303124) then
    return
  end
  local cb = BindCallback(self, self.TimerCallBack)
  self.timer = LuaSkillCtrl:StartTimer(nil, 75, cb)
end

function sc_104:TimerCallBack()
  self:ShakeCamera()
  self:EnterMovieMode()
  local role = LuaSkillCtrl:GetRoleWithPos(5, 2)
  LuaSkillCtrl:DispelBuff(role, 88, 0)
  LuaSkillCtrl:DispelBuff(role, 175, 0)
  LuaSkillCtrl:RemoveLife(role.maxHp + 1, self, role)
  LuaSkillCtrl:StartTimer(nil, 15, function()
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, 4, 2, eBattleRoleBelong.enemy)
    summoner:SetAttr(eHeroAttr.maxHp, self.config.maxHp)
    summoner:SetAttr(eHeroAttr.pow, self.config.pow)
    summoner:SetAttr(eHeroAttr.intensity, self.config.intensity)
    summoner:SetAttr(eHeroAttr.speed, self.config.speed)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    LuaSkillCtrl:CallRoleAction(summonerEntity, 1104, 1)
    local arriveCallBack = BindCallback(self, self.Jiechu)
    LuaSkillCtrl:StartTimer(nil, 100, arriveCallBack)
    local arriveCallBack1 = BindCallback(self, self.Xindie)
    LuaSkillCtrl:StartTimer(nil, 45, arriveCallBack1)
  end)
end

function sc_104:Jiechu()
  LuaSkillCtrl:ForceEndBattle(true)
end

function sc_104:Xindie()
  LuaSkillCtrl:CallEffect(targetRole, 10263, self)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  self:ShakeCamera()
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetList[i], 66, 1, nil)
    self:SetUndead(targetList[i])
  end
end

function sc_104:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_104
