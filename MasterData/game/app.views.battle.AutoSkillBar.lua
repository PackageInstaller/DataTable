local SkillSpecialSet = require("csvdata.skill_special")
local RoleInfoCsv = require("csvdata.role_info")
local MAX_SKILL_NUM = 3
local AI_INTERVAL_TIME = 0.3
local AutoSkillBar = class("AutoSkillBar")

local function getResetSkillCD(formatEffect)
  formatEffect = formatEffect or {}
  local add = 0
  local percent = 100
  for _, effect in ipairs(formatEffect) do
    if effect.active then
      if effect.type == 5 then
        add = add + effect.value
      elseif effect.type == 6 then
        percent = percent + effect.value
      end
    end
  end
  return math.max(globalCsv.Reload_MinCd, (globalCsv.Reload_Cd + add) * percent / 100) / 1000
end

function AutoSkillBar:ctor(params)
  self.skillList = {}
  self.skillCache = {}
  self.players = {}
  self.isPause = false
  self.manaValue = globalCsv.initMana
  if game.role.majorGuideStep == 11 then
    self.manaValue = self.manaValue + 6
  end
  self.manaGrowth = globalCsv.manaGrowth
  self.ResetSkillCD = getResetSkillCD(params.formatEffect)
  self.lastTime = os.time()
  self.globalCD = 0
  self.golbalCDTotal = 1
  self.resetSkillNumCD = self.ResetSkillCD
  self.skillLimit = 0
  local level = params.level or 1
  self.manaFactor = RoleInfoCsv[level].mana
  self.skillOrder = params.skillOrder
  self.isAI = true
  self.AIInterval = 0
  self.pvpRelease = false
  self.pvpBattle = params.pvpBattle
end

function AutoSkillBar:update(dt)
  if self.isPause then
    return
  end
  if self.skillLimit <= 0 and #self.skillList == 0 then
    self.resetSkillNumCD = self.resetSkillNumCD - dt
    if 0 > self.resetSkillNumCD then
      self:resetLimit()
    else
      return
    end
  end
  if self.manaValue < globalCsv.maxMana then
    self:setMana(dt * self.manaGrowth * self.manaFactor, true)
  end
  if 0 < self.globalCD then
    self.globalCD = self.globalCD - dt
  end
  if self.isAI then
    self:AIUpdate(dt)
  end
end

function AutoSkillBar:resetLimit()
  for _, player in ipairs(self.players) do
    player:resetSpecialSkillNum()
  end
  self.globalCD = 0
  self.golbalCDTotal = 1
  self.resetSkillNumCD = self.ResetSkillCD
  self:checkDraw()
end

function AutoSkillBar:setMana(value, ignoreCheck)
  if 0 < value and self.manaValue >= globalCsv.maxMana or value < 0 and 0 >= self.manaValue then
    return
  end
  if 0 >= self.skillLimit and #self.skillList == 0 then
    return
  end
  self.manaValue = self.manaValue + value
end

function AutoSkillBar:drawCard()
  if self.delayDraw then
    return
  end
  if self.manaValue < globalCsv.drawCost then
    return
  end
  if self:isFull() then
    return
  end
  if self.skillLimit <= 0 then
    return
  end
  local players = {}
  for _, player in ipairs(self.players) do
    if player:getState() ~= "Dead" and 0 < player.hp and player.specialSkill.curNum < player.specialSkill.numLimit then
      table.insert(players, player)
    end
  end
  if #players == 0 then
    return
  end
  local dataset = {}
  for index, player in ipairs(players) do
    dataset[index] = {
      weight = (player.specialSkill.numLimit - player.specialSkill.curNum) * player.specialSkill.weight
    }
  end
  local index = math.randWeight(dataset)
  local player = players[index]
  player = player or players[1]
  player:createSpecialSkill(true)
  self:setMana(-globalCsv.drawCost)
  self:checkDraw()
end

function AutoSkillBar:checkDraw(animation)
  local num, origin = 0, 0
  for _, player in ipairs(self.players) do
    if player:getState() ~= "Dead" and 0 < player.hp and player.specialSkill.numLimit then
      num = num + player.specialSkill.numLimit - player.specialSkill.curNum
      origin = origin + player.specialSkill.originNum
    end
  end
  self.skillLimit = num
end

function AutoSkillBar:addPlayer(player)
  table.insert(self.players, player)
  self:checkDraw(true)
end

function AutoSkillBar:isFull()
  return #self.skillList >= MAX_SKILL_NUM
end

function AutoSkillBar:addSkill(skillId, level, owner)
  if self:isFull() then
    return
  end
  local card = {
    skillId = skillId,
    level = level,
    owner = owner,
    skillData = SkillSpecialSet[skillId][level]
  }
  table.insert(self.skillList, card)
  local handler = owner:addEventListener("playerDead", function(event)
    self:disposeSkill(card)
    owner:removeEventListener(handler)
  end)
end

function AutoSkillBar:releaseSkill(card)
  local releaser = card.owner
  local mana = releaser.specialSkill.mana
  if mana > self.manaValue then
    return
  end
  if self.globalCD > 0 then
    return
  end
  if releaser:getState() == "Dead" then
    return
  end
  self:setMana(-mana)
  self.globalCD = releaser.specialSkill.cd
  self.golbalCDTotal = self.globalCD
  releaser:releaseSkillById(card.skillData.skillId, true)
  self:disposeSkill(card)
  return true
end

function AutoSkillBar:AIUpdate(dt)
  self.AIInterval = self.AIInterval - dt
  if self.AIInterval > 0 then
    return
  end
  self.AIInterval = AI_INTERVAL_TIME
  if self.pvpBattle then
    self:pvpLogic(dt)
    return
  end
  if 0 < self.skillLimit and #self.skillList < MAX_SKILL_NUM and self.manaValue >= globalCsv.drawCost then
    self:drawCard()
    return
  end
  if 0 < #self.skillList then
    local card = self.skillList[1]
    if card then
      self:releaseSkill(card)
    end
  end
end

function AutoSkillBar:pvpLogic(dt)
  if self.pvpRelease then
    if #self.skillList == 0 then
      self.pvpRelease = false
      return
    end
    local order = 10
    local pIndex = 1
    for index, card in ipairs(self.skillList) do
      if order > card.owner.pvpSkillOrder then
        order = card.owner.pvpSkillOrder
        pIndex = index
      end
    end
    local card = self.skillList[pIndex]
    self:releaseSkill(card)
    return
  end
  if 0 < self.skillLimit and #self.skillList < MAX_SKILL_NUM and self.manaValue >= globalCsv.drawCost then
    self:drawCard()
  end
  if #self.skillList >= MAX_SKILL_NUM or self.skillLimit == 0 then
    self.pvpRelease = true
  end
end

function AutoSkillBar:disposeSkill(card)
  if not card then
    return
  end
  for index, _card in ipairs(self.skillList) do
    if card == _card then
      table.remove(self.skillList, index)
      break
    end
  end
end

function AutoSkillBar:pause()
  self.isPause = true
end

function AutoSkillBar:resume()
  self.isPause = false
end

return AutoSkillBar
