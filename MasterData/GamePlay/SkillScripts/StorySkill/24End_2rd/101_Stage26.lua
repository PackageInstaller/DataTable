local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_101 = class("sc_101", StorySkillBase)
local base = StorySkillBase
sc_101.config = {
  duration = 150,
  summonerId1 = 66,
  summonerId2 = 68
}
sc_101.config = setmetatable(sc_101.config, {
  __index = base.config
})

function sc_101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_101:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  if self:isBattleRoom(1302601) then
    self:flow1()
  elseif self:isBattleRoom(1302602) then
    self:flow2()
  elseif self:isBattleRoom(1302603) then
    self:flow3()
  else
    return
  end
end

function sc_101:flow1()
  LuaSkillCtrl:CallPlayEpTipDialogInBattle(12261)
end

function sc_101:flow2()
  LuaSkillCtrl:CallPlayEpTipDialogInBattle(12262)
end

function sc_101:flow3()
  LuaSkillCtrl:CallPlayEpTipDialogInBattle(12263)
  self.flag3 = 0
  local cb = BindCallback(self, self.flow3_TimerCallBack)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, cb, nil, -1, self.config.duration // 2)
end

function sc_101:flow3_TimerCallBack()
  self.flag3 = (self.flag3 + 1) % 3
  if self.flag3 == 1 then
    self:SkillBack1()
  end
  if self.flag3 == 2 then
    self:SkillBack3()
  end
  if self.flag3 == 0 then
    self:SkillBack2()
  end
end

function sc_101:SkillBack1()
  LuaSkillCtrl:CallPlayEpTipDialogInBattle(12264)
  local attr_table = {
    maxHp = 10000,
    pow = 1000,
    skill_intensity = 1000,
    speed = 0,
    def = 0,
    crit = 0,
    critDamage = 0,
    sunder = 0,
    magic_res = 0,
    magic_pen = 0
  }
  self:ShakeCamera()
  LuaSkillCtrl:StartTimer(nil, 4, function()
    self:CastSummonerDirect(6, 0, self.config.summonerId1, eBattleRoleBelong.enemy, attr_table)
    self:CastSummonerDirect(6, 4, self.config.summonerId1, eBattleRoleBelong.enemy, attr_table)
  end)
end

function sc_101:SkillBack2()
  LuaSkillCtrl:CallPlayEpTipDialogInBattle(12265)
  self:ShakeCamera()
  local elist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if elist == nil or elist.Count < 1 then
    return
  end
  for i = 0, elist.Count - 1 do
    LuaSkillCtrl:AddRoleShield(elist[i], eShieldType.Normal, elist[i].hp * 100 // 1000)
  end
end

function sc_101:SkillBack3()
  LuaSkillCtrl:CallPlayEpTipDialogInBattle(12266)
  local pList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if pList == nil or pList.Count < 1 then
    return
  end
  local rand = LuaSkillCtrl:CallRange(0, pList.Count - 1)
  local selectRole = pList[rand]
  local skillEvent3 = BindCallback(self, self.SkillEventFunc)
  LuaSkillCtrl:CallEffect(selectRole, 12073, self, skillEvent3)
end

function sc_101:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Arrive then
    LuaSkillCtrl:CallBuff(self, target, 130, 1, 75)
  end
end

function sc_101:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer == nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return sc_101
