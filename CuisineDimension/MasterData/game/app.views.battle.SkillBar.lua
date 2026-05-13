local SkillRes = "ui/battle/skill/"
local BattleRes = "ui/battle/"
local SkillSpecialSet = require("csvdata.skill_special")
local RoleInfoCsv = require("csvdata.role_info")
local MAX_SKILL_NUM = 3
local AI_INTERVAL_TIME = 0.3
local SkillCard = class("SkillCard", function()
  return UIHelper.newImageView(SkillRes .. "skill_bg.png")
end)

function SkillCard:ctor(params)
  self.skillId = params.skillId
  self.level = params.level
  self.owner = params.owner
  self.bar = params.bar
  self.skillData = SkillSpecialSet[self.skillId][self.level]
  self.specialSkill = self.owner.specialSkill
  self:layout()
end

function SkillCard:layout()
  self:setCascadeOpacityEnabled(true)
  local unitData = self.owner.unit
  local size = self:getContentSize()
  UIHelper.newImageView(SkillRes .. "head_mask.png"):pos(22, size.height - 22):addTo(self)
  local head = UIHelper.newImageView(SkillRes .. "head_bg.png"):pos(22, size.height - 22):addTo(self)
  UIHelper.getClipNode({
    steRes = "ui/global/mask_2.png",
    clipRes = UIHelper.getCardRes("book", unitData.type, nil, self.owner.quality)
  }):scale(0.44):center(head):addTo(head)
  UIHelper.newImageView(SkillRes .. "head_frame.png"):center(head):addTo(head)
  self.icon = UIHelper.newImageView(self.skillData.icon):pos(size.width / 2, 125):addTo(self, -1)
  display.newSprite(SkillRes .. string.format("level_%d.png", self.level)):pos(size.width - 25, size.height - 19):addTo(self)
  display.newTTFLabel({
    text = self.skillData.name,
    size = 20,
    color = UIHelper.hex2rgb("#f3d09d")
  }):enableOutline(UIHelper.hex2rgb("#160101"), 2):pos(size.width / 2, 64):addTo(self)
  self.manaMask = display.newProgressTimer(SkillRes .. "mana_mask.png", cc.PROGRESS_TIMER_TYPE_BAR)
  self.manaMask:pos(size.width / 2, 26):addTo(self)
  self.manaMask:setMidpoint(cc.p(0, 0.5))
  self.manaMask:setBarChangeRate(cc.p(1, 0))
  self.manaMask:setPercentage(100)
  self.cdMask = display.newProgressTimer(SkillRes .. "cd_mask.png", display.PROGRESS_TIMER_RADIAL)
  self.cdMask:center(self.icon):addTo(self.icon):hide()
  self.cdMask:setReverseDirection(true)
  self.cdMask:setPercentage(100)
  local mana = "<div outline=2,#533420>" .. self.specialSkill.mana .. " </div>"
  local delta = self.specialSkill.mana - self.specialSkill.originMana
  if delta ~= 0 then
    mana = string.format("<div outline=2,#533420>%d<div fontsize=18 outline=1,#533420> (%s%d) </div> </div>", self.specialSkill.mana, 0 < delta and "+" or "", delta)
  end
  self.manaLabel = MRichText.new({
    text = mana,
    size = 22,
    color = UIHelper.hex2rgb("#35ff06")
  }):anch(0.5, 0.5):pos(size.width / 2 - 16, 28):addTo(self)
  display.newSprite(SkillRes .. "mana_small.png"):anch(0, 0.5):pos(self.manaLabel:getContentSize().width / 2 + 5, 0):addTo(self.manaLabel)
end

function SkillCard:update()
  if self.bar.manaValue < self.specialSkill.mana then
    self.manaMask:setPercentage(self.bar.manaValue / self.specialSkill.mana * 100)
  end
  self.manaLabel:walkElements(function(node)
    node:setTextColor(UIHelper.hex2rgb(self.bar.manaValue < self.specialSkill.mana and "#ff2711" or "#35ff06"))
  end)
  if self.bar.globalCD > 0 then
    if self.cdMask:isVisible() then
      self.cdMask:setPercentage(self.bar.globalCD / self.bar.golbalCDTotal * 100)
    else
      self.cdMask:show()
      self.icon:getVirtualRenderer():setState(1)
    end
  elseif self.cdMask:isVisible() then
    self.cdMask:hide()
    self.icon:getVirtualRenderer():setState(0)
  end
end

local SkillBar = class("SkillBar", function()
  return UIHelper.extend(ccui.Widget:create())
end)

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

function SkillBar:ctor(params)
  params = params or {}
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.skillList = {}
  self.skillCache = {}
  self.players = {}
  self.freeSkillNum = 3
  self.isPause = false
  self.manaValue = globalCsv.initMana
  if game.role.majorGuideStep == 11 then
    self.manaValue = self.manaValue + 6
    self.freeSkillNum = 0
  end
  local talentUpP = game.role:getTalentValue(10)
  local talentUpC = game.role:getTalentValue(9)
  self.manaGrowth = globalCsv.manaGrowth * (1 + talentUpP / 100) + talentUpC
  self.ResetSkillCD = getResetSkillCD(params.formatEffect)
  self.lastTime = os.time()
  self.globalCD = 0
  self.golbalCDTotal = 1
  self.resetSkillNumCD = self.ResetSkillCD
  self.skillLimit = 0
  self.manaFactor = RoleInfoCsv[game.role.level].mana
  self.isAI = false
  self.AIInterval = 0
  self.pveRelease = false
  self.pvpRelease = false
  self.pvpBattle = params.pvpBattle
  self.sauceBattle = params.sauceBattle
  if self.pvpBattle or self.sauceBattle then
    self.freeSkillNum = 0
  end
  self:initElements()
end

function SkillBar:initElements()
  self.skillBg = UIHelper.newImageView(SkillRes .. "skillbar_bg.png"):anch(1, 0):addTo(self)
  self.size = self.skillBg:getContentSize()
  local manaBg = display.newSprite(SkillRes .. "mana_slot.png"):pos(-53, 83):rotation(-90):addTo(self)
  self.manaBar = display.newProgressTimer(SkillRes .. "mana_bar.png", cc.PROGRESS_TIMER_TYPE_BAR)
  self.manaBar:center(manaBg):addTo(manaBg)
  self.manaBar:setMidpoint(cc.p(0, 0.5))
  self.manaBar:setBarChangeRate(cc.p(1, 0))
  self.manaBar:setPercentage(self.manaValue / globalCsv.maxMana * 100)
  display.newSprite(SkillRes .. "mana_frame.png"):center(manaBg):addTo(manaBg)
  self.manaBg = manaBg
  local drawBg = display.newSprite(SkillRes .. "draw_bg.png"):anch(1, 0):pos(-24, 2):addTo(self)
  self.drawBtn = UIHelper.extend(ccui.Button:create())
  self.drawBtn:setImages(SkillRes, {
    "draw_btn_a.png",
    "draw_btn_a.png",
    "draw_btn_c.png"
  })
  self.drawBtn:setTouchScale()
  self.drawBtn:pos(65, 65):addTo(drawBg):name("drawBtn")
  self.coastLabel = display.newTTFLabel({
    text = globalCsv.drawCost,
    size = 20,
    color = display.COLOR_WHITE
  }):enableOutline(UIHelper.hex2rgb("#2b0700"), 2):pos(65, 23):addTo(self.drawBtn)
  self.manaLabel = display.newTTFLabel({
    text = self.manaValue,
    size = 23,
    color = display.COLOR_WHITE
  }):enableOutline(UIHelper.hex2rgb("#550779"), 2):pos(92, 143):addTo(drawBg)
  local shellBg = display.newSprite(SkillRes .. "auto_shell_1.png"):pos(64, 63):addTo(drawBg):hide()
  display.newSprite(SkillRes .. "auto_shell_2.png"):center(shellBg):addTo(shellBg):runAction(cc.RepeatForever:create(cc.RotateBy:create(8, 360)))
  display.newSprite(SkillRes .. "auto_shell_3.png"):center(shellBg):addTo(shellBg)
  display.newSprite(SkillRes .. "auto_shell_4.png"):center(shellBg):addTo(shellBg)
  self.skillNumCDDi = display.newSprite(SkillRes .. "skill_cd_di.png"):pos(65, 65):addTo(drawBg):hide()
  display.newSprite(SkillRes .. "skill_cd_zi.png"):pos(60, 65):addTo(self.skillNumCDDi)
  self.skillNumCDLab = display.newTTFLabel({
    text = 0,
    size = 46,
    color = UIHelper.hex2rgb("#ffe400")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(60, 30):addTo(self.skillNumCDDi)
  local autoNode = display.newNode():addTo(self.skillBg)
  local bigBg = display.newSprite(SkillRes .. "auto_bg.png"):pos(45, 48):addTo(autoNode)
  local bigGear = display.newSprite(SkillRes .. "auto_big.png"):pos(36, 37):addTo(bigBg)
  display.newSprite(SkillRes .. "auto_big_1.png"):pos(36, 37):addTo(bigBg)
  local smallBg = UIHelper.newImageView(SkillRes .. "auto_bg_1.png"):pos(83, 82):addTo(autoNode, -1)
  local smallGear = display.newSprite(SkillRes .. "auto_small.png"):pos(83, 82):addTo(autoNode)
  display.newSprite(SkillRes .. "auto_small_1.png"):pos(83, 82):addTo(autoNode):scale(0.9)
  local autoLabel = display.newTTFLabel({text = "", size = 16}):enableOutline(UIHelper.hex2rgb("#27170f"), 1):pos(81, 82):addTo(autoNode)
  self.autoNode = autoNode
  
  local function setAuto(force)
    local auto = force or 0 < (UserData.auto or 0)
    if auto then
      self.drawBtn:hide()
      shellBg:show()
      display.newSprite(SkillRes .. "auto_shell_5.png"):center(shellBg):addTo(shellBg):runAction(transition.sequence({
        cc.FadeOut:create(0.1),
        cc.RemoveSelf:create()
      }))
      bigGear:runAction(cc.RepeatForever:create(cc.RotateBy:create(4, 360)))
      smallGear:runAction(cc.RepeatForever:create(cc.RotateBy:create(3.2, -360)))
      autoLabel:setString("自动")
    else
      self.drawBtn:show()
      shellBg:hide()
      bigGear:stopAllActions()
      smallGear:stopAllActions()
      autoLabel:setString("手动")
    end
    self.isAI = auto
    if self.isAI and #self.skillList == MAX_SKILL_NUM then
      self.pveRelease = true
    end
  end
  
  setAuto()
  smallBg:setCallback(function()
    if self.pvpBattle then
      return
    end
    local auto = 0 < (UserData.auto or 0)
    UserData.auto = auto and 0 or 1
    setAuto()
  end)
  self.numLabel = display.newTTFLabel({
    text = 0,
    size = 48,
    color = UIHelper.hex2rgb("#ffec6c")
  }):enableOutline(UIHelper.hex2rgb("#2b0700"), 2):pos(42, 50):addTo(self.skillBg)
  display.newSprite(SkillRes .. "skill_angle.png"):anch(1, 0):addTo(self)
  self.drawBtn:setCallback(function()
    self:drawCard()
  end)
  local fullEffect = UIHelper.loadAnimation(SkillRes, "cost_full", 20, 30)
  fullEffect.sprite:pos(65, 86):addTo(drawBg):hide()
  fullEffect.sprite:playAnimationForever(fullEffect.animation)
  fullEffect.sprite:setBlendFunc(cc.blendFunc(gl.ONE, gl.ONE))
  self.fullEffect = fullEffect.sprite
  if self.pvpBattle then
    setAuto(true)
  end
end

function SkillBar:update(dt)
  if self.isPause then
    return
  end
  if self.skillLimit <= 0 and #self.skillList == 0 then
    self.resetSkillNumCD = self.resetSkillNumCD - dt
    if 0 > self.resetSkillNumCD then
      self:resetLimit()
    else
      self.skillNumCDLab:setString(math.ceil(self.resetSkillNumCD))
      return
    end
  end
  if self.manaValue < globalCsv.maxMana and self.freeSkillNum < 1 then
    self:setMana(dt * self.manaGrowth * self.manaFactor, true)
  end
  if 0 < self.globalCD then
    self.globalCD = self.globalCD - dt
  end
  for _, card in ipairs(self.skillList) do
    if not card.effect then
      card:update()
    end
  end
  if self.isAI or 0 < self.freeSkillNum then
    self:AIUpdate(dt)
  end
end

function SkillBar:resetLimit()
  for _, player in ipairs(self.players) do
    player:resetSpecialSkillNum()
  end
  self.globalCD = 0
  self.golbalCDTotal = 1
  self.resetSkillNumCD = self.ResetSkillCD
  self:checkDraw()
end

function SkillBar:setMana(value, ignoreCheck)
  if 0 < value and self.manaValue >= globalCsv.maxMana or value < 0 and 0 >= self.manaValue then
    return
  end
  if 0 >= self.skillLimit and #self.skillList == 0 then
    return
  end
  self.manaValue = self.manaValue + value
  self.manaBar:setPercentage(self.manaValue / globalCsv.maxMana * 100)
  self.manaLabel:setString(math.floor(self.manaValue))
  if self.manaValue >= globalCsv.maxMana then
    self.fullEffect:show()
  else
    self.fullEffect:hide()
  end
end

function SkillBar:drawCard()
  if self.delayDraw then
    return
  end
  if self.manaValue < globalCsv.drawCost and self.freeSkillNum < 1 then
    self:showError("厨力不足")
    return
  end
  if self:isFull() then
    self:showError("料理技存满啦")
    return
  end
  if self.skillLimit <= 0 then
    self:showError("料理技能已经用完")
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
  if game.role.majorGuideStep == 11 and game.role.minorGuideStep < 17 then
    index = 4
  end
  local player = players[index]
  player = player or players[1]
  player:createSpecialSkill(true)
  self:setMana(self.freeSkillNum > 0 and 0 or -globalCsv.drawCost)
  self.freeSkillNum = math.max(self.freeSkillNum - 1, 0)
  self:checkDraw()
  if self.skillLimit <= 0 and #self.skillList == 0 then
    self.fullEffect:hide()
  end
end

function SkillBar:checkDraw(animation)
  local num, origin = 0, 0
  for _, player in ipairs(self.players) do
    if player:getState() ~= "Dead" and 0 < player.hp and player.specialSkill.numLimit then
      num = num + player.specialSkill.numLimit - player.specialSkill.curNum
      origin = origin + player.specialSkill.originNum
    end
  end
  self.skillLimit = num
  self.numLabel:stopAllActions()
  self.numLabel:setString(self.skillLimit)
  self.drawBtn:setEnabled(0 < self.skillLimit)
  self.freeSkillNum = math.min(self.freeSkillNum, self.skillLimit)
  if 0 >= self.skillLimit and #self.skillList == 0 and self.skillBg:getPosition() == 0 then
    self.skillBg:runAction(transition.sequence({
      cc.MoveBy:create(0.8, cc.p(490, 0))
    }))
    self.autoNode:hide()
    self.skillNumCDDi:show()
    self.drawBtn:hide()
    self.skillNumCDLab:setString(math.ceil(self.resetSkillNumCD))
  end
  if 0 < self.skillLimit and self.skillBg:getPosition() == 490 then
    self.skillBg:stopAllActions()
    self.skillBg:runAction(transition.sequence({
      cc.MoveBy:create(0.8, cc.p(-490, 0))
    }))
    self.autoNode:show()
    self.skillNumCDDi:hide()
    if not self.isAI then
      self.drawBtn:show()
    end
  end
  if animation and 0 < num - origin then
    self.numLabel:setString(origin)
    self.numLabel:removeAllChildren()
    local bg = display.newSprite(SkillRes .. "effect_num.png"):pos(50, 50):addTo(self.numLabel)
    display.newTTFLabel({
      text = num - origin,
      size = 30,
      color = UIHelper.hex2rgb("#35ff06")
    }):pos(21, 24):addTo(bg)
    bg:runAction(transition.sequence({
      cc.DelayTime:create(4),
      cc.CallFunc:create(function()
        UIHelper.numVaryEffect({
          node = self.numLabel,
          endNum = num,
          orginNum = origin
        })
      end),
      cc.ScaleTo:create(0.2, 1.5),
      cc.ScaleTo:create(0.2, 0),
      cc.RemoveSelf:create()
    }))
  end
  if animation then
    self.delayDraw = true
    self.skillNumCDLab:runAction(transition.sequence({
      cc.DelayTime:create(4.2),
      cc.CallFunc:create(function()
        self.delayDraw = false
      end)
    }))
  end
end

function SkillBar:addPlayer(player, skip)
  skip = skip or false
  table.insert(self.players, player)
  if not skip then
    self:checkDraw(true)
  end
  player:addEventListener("playerDead", function(event)
    local hasCard = false
    for _, card in ipairs(self.skillList) do
      if card.owner == player then
        hasCard = true
        break
      end
    end
    if not hasCard then
      self:checkDraw()
    end
  end)
end

function SkillBar:isFull()
  return #self.skillList >= MAX_SKILL_NUM
end

function SkillBar:addSkill(skillId, level, owner)
  if self:isFull() then
    return
  end
  local card = SkillCard:create({
    skillId = skillId,
    level = level,
    owner = owner,
    bar = self
  })
  card:anch(0, 0):pos(self.size.width, 3):addTo(self.skillBg):name("skillCard")
  card:setCallback(function()
    if self.pvpBattle then
      return
    end
    self:releaseSkill(card)
  end)
  local handler = owner:addEventListener("playerDead", function(event)
    self:disposeEffect(card)
    owner:removeEventListener(handler)
  end)
  table.insert(self.skillList, card)
  self:layout()
end

function SkillBar:releaseSkill(card)
  local releaser = card.owner
  local mana = card.specialSkill.mana
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
  self.globalCD = card.specialSkill.cd
  self.golbalCDTotal = self.globalCD
  releaser:releaseSkillById(card.skillData.skillId, true)
  self:touchEffect(card)
  return true
end

function SkillBar:layout()
  if #self.skillList == 0 then
    return
  end
  local interval = 155
  local xBegin = 115
  for index, card in ipairs(self.skillList) do
    if not card.effect then
      card:stopAllActions()
      card:runAction(cc.MoveTo:create(0.2, cc.p(xBegin + (index - 1) * interval, 3)))
    end
  end
end

function SkillBar:touchEffect(card)
  local x, y = card:getPosition()
  local size = card:getContentSize()
  local effect = UIHelper.loadAnimation(SkillRes, "touch", 20, 30, true)
  effect.sprite:pos(x + size.width / 2 - 3, y + size.height / 2 + 10):addTo(self.skillBg)
  effect.sprite:playAnimationOnce(effect.animation, true)
  card.effect = true
  card:runAction(transition.sequence({
    cc.FadeOut:create(0.3),
    cc.CallFunc:create(function()
      card:removeSelf()
      for index, _card in ipairs(self.skillList) do
        if card == _card then
          table.remove(self.skillList, index)
          break
        end
      end
      self:layout()
      self:checkDraw()
    end)
  }))
  card:setTouchEnabled(false)
  game:playMusic(1019)
end

function SkillBar:disposeEffect(card)
  if tolua.isnull(card) then
    return
  end
  local x, y = card:getPosition()
  local size = card:getContentSize()
  local effect = UIHelper.loadAnimation(SkillRes, "dispose", 22, 30, true)
  effect.sprite:pos(x + size.width / 2 - 3, y + size.height / 2 + 10):addTo(self.skillBg)
  effect.sprite:playAnimationOnce(effect.animation, true)
  card.effect = true
  card:runAction(transition.sequence({
    cc.FadeOut:create(0.2),
    cc.CallFunc:create(function()
      card:removeSelf()
      for index, _card in ipairs(self.skillList) do
        if card == _card then
          table.remove(self.skillList, index)
          break
        end
      end
      self:layout()
      self:checkDraw()
    end)
  }))
  card:setTouchEnabled(false)
end

function SkillBar:showError(msg)
  if self.lastMessage and not tolua.isnull(self.lastMessage) then
    self.lastMessage:removeSelf()
  end
  local bg = display.newSprite(SkillRes .. "skill_tip.png")
  bg:pos(-110, 205):addTo(self)
  self.lastMessage = bg
  local richText = MRichText.new({
    text = msg,
    size = 26,
    color = UIHelper.hex2rgb("#3e1700")
  })
  richText:anch(0.5, 0.5):pos(89, 44):addTo(bg)
  bg:scale(0.4)
  local actions = {}
  actions[#actions + 1] = cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, 1))
  actions[#actions + 1] = cc.DelayTime:create(2)
  actions[#actions + 1] = cc.CallFunc:create(function()
    self.lastMessage = nil
  end)
  actions[#actions + 1] = cc.RemoveSelf:create()
  bg:runAction(transition.sequence(actions))
  game:playMusic(1001)
end

function SkillBar:AIUpdate(dt)
  self.AIInterval = self.AIInterval - dt
  if self.AIInterval > 0 then
    return
  end
  self.AIInterval = AI_INTERVAL_TIME
  if self.pvpBattle then
    self:pvpLogic(dt)
    return
  end
  if self.pveRelease then
    if #self.skillList == 0 then
      self.pveRelease = false
      return
    end
    local card = self.skillList[1]
    if card then
      self:releaseSkill(card)
    end
    return
  end
  if 0 < self.freeSkillNum or 0 < self.skillLimit and #self.skillList < MAX_SKILL_NUM and self.manaValue >= globalCsv.drawCost then
    self:drawCard()
  end
  if #self.skillList >= MAX_SKILL_NUM or self.skillLimit == 0 then
    self.pveRelease = true
  end
end

function SkillBar:pvpLogic(dt)
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

function SkillBar:pause()
  self.isPause = true
end

function SkillBar:resume()
  self.isPause = false
end

return SkillBar
