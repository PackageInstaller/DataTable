local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_2 = class("sc_2", StorySkillBase)
local base = StorySkillBase
sc_2.config = {}
sc_2.config = setmetatable(sc_2.config, {
  __index = base.config
})

function sc_2:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_2:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self.pf = self:GetRole(1001083)
  if LuaSkillCtrl:GetBattleRoomId() == 1202013 then
    self.meierjiya = self:GetRole(1001084)
    self:flow2()
  else
    self:flow1()
  end
end

function sc_2:flow1()
  self:StopRole(self.pf)
end

function sc_2:flow2()
  self:EnterMovieMode()
  self:SetUnMove(self.pf)
  self:SetUnMove(self.meierjiya)
  self:AddAfterHurtTrigger("sc_2", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  local nList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  for i = nList.Count - 1, 0, -1 do
    LuaSkillCtrl:RemoveLife(nList[i].maxHp + 1, self, nList[i])
  end
  LuaSkillCtrl:StartTimer(nil, 15, function()
    self:MoveRoleToGrid(self.pf, self.meierjiya.x - 1, self.meierjiya.y)
  end)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    LuaSkillCtrl:StartAvgWithPauseGame(nil, 59001141, BindCallback(self, self.flow3))
  end)
end

function sc_2:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  LuaSkillCtrl:RemoveLife(target.maxHp + 1, self, target)
end

function sc_2:flow3()
  LuaSkillCtrl:RemoveLife(self.pf.maxHp // 2, self, self.pf)
  self:MoveRoleToGrid(self.pf, 1, 2)
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
  LuaSkillCtrl:StartTimer(nil, 7, function()
    self.pasika = self:CastSummoner(4, 2, 107101, eBattleRoleBelong.player, attr_table)
    self:StopRole(self.pasika)
    self.pasika:LookAtTarget(self.pf)
    self.effect = LuaSkillCtrl:CallEffect(self.pf, 12201, self, nil, self.pasika)
  end)
  LuaSkillCtrl:CallStartLocalScale(self.meierjiya, Vector3(0, 0, 0), 0.1)
  self:MoveRoleToGrid(self.meierjiya, 5, 2)
  LuaSkillCtrl:StartTimer(nil, 8, function()
    local grid_table = {
      {2, 0},
      {3, 0},
      {2, 1},
      {2, 2},
      {3, 2},
      {2, 3},
      {2, 4},
      {3, 4}
    }
    for k, v in ipairs(grid_table) do
      self:CastSummoner(v[1], v[2], 96, eBattleRoleBelong.neutral, attr_table)
    end
  end)
  LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:CallHeal(self.pf.maxHp // 5, self, self.pf)
  end, nil, -1)
  LuaSkillCtrl:StartTimer(nil, 60, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function sc_2:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return sc_2
