local Entity = import(".Entity")
local Beauty = class("Beauty", Entity)
local beautyList = require("csvdata.goddess_list")
local skillCsv = require("csvdata.skill")
local MOVE_UNIT = 180
local SKILL_CD = 5

function Beauty:ctor(params)
  Beauty.super.ctor(self, params)
  params = params or {}
  self.side = params.side or SIDE_LEFT
  self.id = params.id
  self.index = params.index or 1
  self.battle = params.battle
  self.xPos = params.xPos
  self.star = params.star or 1
  self.isTeamer = params.isTeamer or false
  self.skillLevel = 1
  self.skillCd = 0
  self.onAI = false
  self.skillBlockNum = 0
  self.releaseNum = 0
  self.reflections = {
    skill = params.skillDef or "app.views.battle.SpriteSkill"
  }
  self.unit = beautyList[params.id]
  self:bindEventListeners()
  self:initStatusMap()
end

function Beauty:initStatusMap()
  self:setupState({
    initial = "None",
    events = {
      {
        name = "nothing",
        from = "None",
        to = "Fly"
      },
      {
        name = "nothing",
        from = "Fly",
        to = "Fly"
      },
      {
        name = "nothing",
        from = "Skill",
        to = "Fly"
      },
      {
        name = "nothing",
        from = "FlyMove",
        to = "Fly"
      },
      {
        name = "skyRound",
        from = "Fly",
        to = "FlyMove"
      },
      {
        name = "skyRound",
        from = "Skill",
        to = "FlyMove"
      },
      {
        name = "favor",
        from = "Fly",
        to = "Skill"
      },
      {
        name = "favor",
        from = "FlyMove",
        to = "Skill"
      },
      {
        name = "win",
        from = "Fly",
        to = "Cheer"
      },
      {
        name = "win",
        from = "FlyMove",
        to = "Cheer"
      },
      {
        name = "win",
        from = "Skill",
        to = "Cheer"
      }
    },
    callbacks = {
      onenterIdle = function(event)
        if event.from ~= "None" then
          self.idleTime = math.randomInt(60, 180) / 60
        else
          self.idleTime = 1
        end
        self:onIdle(event)
      end,
      onenterFly = function(event)
        self.idleTime = math.randomInt(60, 180) / 60
        self:onFly(event)
      end,
      onenterMove = function(event)
        self:onMove(event)
      end,
      onenterFlyMove = function(event)
        self:onFlyMove(event)
      end,
      onenterSkill = function(event)
        self:onSkill(event)
      end,
      onenterCheer = function(event)
        self:onCheer(event)
      end
    }
  })
end

function Beauty:bindEventListeners()
  self:addEventListener("beautyReleaseSkill", function()
    self:doEvent("favor")
    local SkillClass = require(self.reflections.skill)
    local beautySkill = SkillClass:create({
      id = self.unit.skillId,
      level = self.skillLevel,
      owner = self,
      battle = self.battle
    })
    beautySkill:effect({begin = true})
    self:onSkillShow()
  end)
end

function Beauty:updateAIStat(name)
end

function Beauty:handleAttackPassive(params)
end

function Beauty:syncFrameEvent(event)
  local canSync = false
  if self.battle.battleType == BattleType.Pk_Pvp then
    canSync = self.side == SIDE_LEFT
  else
    canSync = not self.isTeamer
  end
  if not canSync then
    return
  end
  self.battle:addFrameEvent(event)
end

function Beauty:notifyAngryChange(event)
  self:syncFrameEvent({
    name = "updateAngryValue",
    side = self.side,
    index = self.index,
    number = event.currentNum - event.originalNum
  })
  self:dispatchEvent(event)
  self:onRefreshState(event)
end

function Beauty:update(dt)
  if self.hasPaused then
    return
  end
  if self.skillCd > 0 then
    self.skillCd = self.skillCd - dt
  end
  local state = self:getState()
  if state == "Skill" then
    return
  end
  local idleStates = {
    Fly = {event = "skyRound"}
  }
  if idleStates[state] then
    self.idleTime = self.idleTime - dt
  end
  if idleStates[state] and 0 >= self.idleTime then
    if self.onAI then
      self:releaseSkill()
    elseif self.side == SIDE_LEFT then
      self:doEvent(idleStates[state].event)
    elseif self.battle.battleType == BattleType.PvP then
      self:releaseSkill()
    end
    return
  end
  local frontestPlayer = self.battle:frontestTeamer(self.side)
  if idleStates[state] and frontestPlayer and self.battle:distance(frontestPlayer, self) > math.random(100, 150) then
    self:doEvent(idleStates[state].event)
    return
  end
  local moveStep = MOVE_UNIT * dt
  
  local function move(forward, distance)
    if forward then
      self.xPos = self.side == SIDE_LEFT and self.xPos + distance or self.xPos - distance
    else
      self.xPos = self.side == SIDE_LEFT and self.xPos - distance or self.xPos + distance
    end
    self:onUpdatePosition()
  end
  
  if state == "FlyMove" then
    local center = frontestPlayer and frontestPlayer.xPos or self.xPos
    local forward = self.side == SIDE_LEFT and center > self.xPos or self.side == SIDE_RIGHT and center < self.xPos
    if math.abs(center - self.xPos) < moveStep + math.random(5, 30) then
      self:doEvent("nothing")
    end
    move(forward, moveStep)
    return
  end
end

function Beauty:addAngryValue(params)
  params = params or {number = 1}
  if params.number > 0 and self.skillBlockNum >= 30 then
    return
  end
  local originalNum = self.skillBlockNum
  self.skillBlockNum = self.skillBlockNum + params.number
  self.skillBlockNum = math.min(30, self.skillBlockNum)
  self:notifyAngryChange({
    name = "updateAngryValue",
    originalNum = originalNum,
    currentNum = self.skillBlockNum
  })
end

function Beauty:releaseSkill()
  if self.skillBlockNum < 10 then
    return
  end
  if self.skillCd > 0 then
    return
  end
  self:doEvent("favor")
  self.skillBlockNum = self.skillBlockNum - 10
  self.releaseNum = self.releaseNum + 1
  local SkillClass = require(self.reflections.skill)
  local beautySkill = SkillClass:create({
    id = self.unit.skillId,
    level = self.skillLevel,
    owner = self,
    battle = self.battle
  })
  beautySkill:effect({begin = true})
  self:syncFrameEvent({
    name = "beautyReleaseSkill",
    index = self.index,
    side = self.side
  })
  self:notifyAngryChange({
    name = "updateAngryValue",
    originalNum = self.skillBlockNum + 10,
    currentNum = self.skillBlockNum
  })
  self:onSkillShow()
  self:dispatchEvent({
    name = "releaseSkill"
  })
  self.skillCd = SKILL_CD
end

function Beauty:turnOnAI(value)
  self.onAI = value
end

return Beauty
