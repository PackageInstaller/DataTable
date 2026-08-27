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
  self:AddLuaTrigger(eSkillLuaTrigger.StoryEvent, self.OnStoryEvent)
  self.timeValue = 450
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.timeValue, timeCallBack)
  self.suer_size = 1.1
  self.tele_count = 0
end

function sc_2:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function sc_2:TimeUp()
  self:StoryFlow1()
end

function sc_2:OnStoryEvent(flag, suer)
  if flag ~= "sp_suer_born" then
    return
  end
  self:StopRole(self.suer)
  self.suer = suer
  self:SetUndead(self.suer)
end

function sc_2:StoryFlow1()
  self.timer1 = LuaSkillCtrl:StartTimer(nil, 30, BindCallback(self, self.RandomTele), nil, 4)
end

function sc_2:RandomTele()
  self.tele_count = self.tele_count + 1
  self.suer_size = self.suer_size + 0.2
  if self.tele_count > 3 then
    if self.timer1 ~= nil then
      self.timer1:Stop()
      self.timer1 = nil
    end
    local pf = LuaSkillCtrl:GetGuardProfession()
    self:MoveRoleToGrid(self.suer, pf.x, pf.y)
    LuaSkillCtrl:StartTimer(nil, 7, function()
      self:DisableStopRole(self.suer)
    end)
    LuaSkillCtrl:StartTimer(nil, 25, function()
      LuaSkillCtrl:RemoveLife(999999, self, pf)
    end)
  else
    local random_grid = LuaSkillCtrl:FindEmptyGrid()
    self:MoveRoleToGrid(self.suer, random_grid.x, random_grid.y, function()
      LuaSkillCtrl:CallStartLocalScale(self.suer, Vector3(self.suer_size, self.suer_size, self.suer_size), 0.3)
    end)
  end
end

function sc_2:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_2
