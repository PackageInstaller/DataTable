local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_111 = class("sc_111", StorySkillBase)
local base = StorySkillBase
sc_111.config = {buffId_mute_ult = 105205}
sc_111.config = setmetatable(sc_111.config, {
  __index = base.config
})

function sc_111:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_111:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  if self:isBattleRoom(1303901) then
    self:flow_1()
  end
  if self:isBattleRoom(1303902) then
    self:flow_2()
  end
end

function sc_111:flow_1()
  local giant = self:GetRole(20151)
  self:AddSetDeadHurtTrigger("sc_111_dead", 1999, self.OnSetDeadHurt, nil, giant, nil, nil)
  self.ult_list = {
    1002,
    1004,
    1005,
    1090,
    1003,
    1072
  }
  self.tipsList = {}
  self.tipsList[1002] = 12395
  self.tipsList[1003] = 12392
  self.tipsList[1004] = 12394
  self.tipsList[1005] = 12393
  self.tipsList[1072] = 12391
  self.tipsList[1090] = 12396
  self.roleList = {}
  for _, roleID in ipairs(self.ult_list) do
    local temp = self:GetRole(roleID)
    self.roleList[roleID] = temp
    LuaSkillCtrl:CallBuff(self, temp, self.config.buffId_mute_ult, 1)
  end
  local cb = BindCallback(self, self.TimerCallBack)
  self.timer = LuaSkillCtrl:StartTimer(nil, 150, cb, nil, -1, 75)
  self.flag = 0
  self.avg_flag = false
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, playerList.Count - 1 do
    self:SetUndead(playerList[i])
  end
end

function sc_111:OnAfterPlaySkill(skill, role)
  if role.roleDataId == 1071 then
    LuaSkillCtrl:StartAvgWithPauseGame(nil, 59001292, BindCallback(self, self.TheEnd))
  end
end

function sc_111:TheEnd()
  LuaSkillCtrl:ForceEndBattle(true)
end

function sc_111:TimerCallBack()
  self.flag = self.flag + 1
  if self.flag <= #self.ult_list then
    local roleId = self.ult_list[self.flag]
    local tipId = self.tipsList[roleId]
    LuaSkillCtrl:CallPlayEpTipDialogInBattle(tipId)
    LuaSkillCtrl:DispelBuff(self.roleList[roleId], self.config.buffId_mute_ult, 0)
  end
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost)
end

function sc_111:OnSetDeadHurt(context)
  self:EnterMovieMode()
  self:SetUndead(context.target)
  if self.avg_flag == true then
    return
  end
  self.avg_flag = true
  LuaSkillCtrl:StartAvgWithPauseGame(nil, 59001292, BindCallback(self, self.End, context.target))
end

function sc_111:End(boss)
  if LuaSkillCtrl.cluaSkillCtrl ~= nil then
    LuaSkillCtrl:ForceEndBattle(true)
  end
end

function sc_111:flow_2()
  self:EnterMovieMode()
  LuaSkillCtrl:StartAvgWithPauseGame(nil, 59001293, BindCallback(self, self.flow_2_end))
end

function sc_111:flow_2_end()
  self.cheng_xing = nil
  self.cheng_xing = self:GetRole(1000118)
  local effect = LuaSkillCtrl:CallEffect(self.cheng_xing, 13102, self)
  LuaSkillCtrl:StartTimer(nil, 22, function()
    LuaSkillCtrl:CallStartLocalScale(self.cheng_xing, Vector3.New(0, 0, 0), 0.01)
  end)
  LuaSkillCtrl:StartTimer(nil, 75, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function sc_111:TPOut(role)
  if role == nil then
    return
  end
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
  local effect = LuaSkillCtrl:CallEffect(gridTarget, 12140, self)
  LuaSkillCtrl:CallEffectDoScale(effect, 1.5, 2.0)
  LuaSkillCtrl:StartTimer(nil, 7, function()
    LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(0, 0, 0), 0.01)
  end)
end

function sc_111:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_111
