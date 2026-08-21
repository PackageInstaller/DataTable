local BattleRes = "ui/battle/"
local GlobalRes = "ui/global/"
local SkillRes = "ui/battle/skill/"
local BuffSet = require("csvdata.buff")
local SkillSet = require("csvdata.skill")
local Player = require("logical.battle.Player")
local socket = require("socket")
local FORCETAG = 100
local animationData = {
  idle = {track = 1, loop = true},
  move = {
    track = 2,
    loop = true,
    finishToIdle = false
  },
  attack = {
    track = 3,
    loop = false,
    finishToIdle = true
  },
  skill = {
    track = 4,
    loop = false,
    finishToIdle = true
  },
  special = {
    track = 5,
    loop = false,
    finishToIdle = true
  },
  cheer = {track = 6, loop = true},
  dead = {track = 7, loop = false},
  damaged = {
    track = 8,
    loop = false,
    finishToIdle = true
  },
  standby = {track = 9, loop = false},
  attack1 = {
    track = 10,
    loop = false,
    finishToIdle = true
  },
  attack2 = {
    track = 11,
    loop = false,
    finishToIdle = true
  },
  attack3 = {
    track = 12,
    loop = false,
    finishToIdle = true
  },
  special2 = {
    track = 13,
    loop = false,
    finishToIdle = true
  },
  special3 = {
    track = 14,
    loop = false,
    finishToIdle = true
  },
  special4 = {
    track = 15,
    loop = false,
    finishToIdle = true
  },
  special5 = {
    track = 16,
    loop = false,
    finishToIdle = true
  }
}
local attackOrders = {
  "attack",
  "attack1",
  "attack2",
  "attack3"
}
local effectTips = {
  miss = "buff_tips/effect/miss.png",
  advancedMiss = "buff_tips/effect/miss_2.png",
  hurtBounce = "buff_tips/effect/hurtBounce.png",
  unbeatable = "buff_tips/effect/unbeatable.png",
  suckHp = "buff_tips/effect/suckHp.png",
  immune = "buff_tips/effect/immune.png"
}
local textColorMap = {
  normal = {
    color = UIHelper.hex2rgb("ffffff"),
    tebao = "ui/battle/tebao1.png",
    tekang = "ui/battle/tekang1.png",
    size = 44,
    stroke = display.COLOR_BLACK,
    strokeSize = 2
  },
  cure = {
    color = UIHelper.hex2rgb("44ff2b"),
    tebao = "ui/battle/tebao2.png",
    tekang = "ui/battle/tekang2.png",
    size = 44,
    stroke = display.COLOR_BLACK,
    strokeSize = 2
  },
  crit = {
    color = UIHelper.hex2rgb("ff0101"),
    tebao = "ui/battle/tebao3.png",
    tekang = "ui/battle/tekang3.png",
    size = 44,
    stroke = display.COLOR_BLACK,
    strokeSize = 2
  },
  kill = {
    color = UIHelper.hex2rgb("ff0101"),
    tebao = "ui/battle/tebao3.png",
    tekang = "ui/battle/tekang3.png",
    size = 66,
    stroke = display.COLOR_BLACK,
    strokeSize = 2
  },
  miss = {
    color = UIHelper.hex2rgb("a5a5a5"),
    tebao = "ui/battle/tebao4.png",
    tekang = "ui/battle/tekang4.png",
    size = 44,
    stroke = display.COLOR_BLACK,
    strokeSize = 2
  },
  shield = {
    color = UIHelper.hex2rgb("fff000"),
    tebao = "ui/battle/tebao5.png",
    tekang = "ui/battle/tekang5.png",
    size = 44,
    stroke = display.COLOR_BLACK,
    strokeSize = 2
  },
  hurtBounce = {
    color = UIHelper.hex2rgb("5be6ff"),
    tebao = "ui/battle/tebao6.png",
    tekang = "ui/battle/tekang6.png",
    size = 44,
    stroke = display.COLOR_BLACK,
    strokeSize = 2
  }
}
local SpritePlayer = class("SpritePlayer", Player)

function SpritePlayer:ctor(params)
  params = params or {}
  params.skillDef = "app.views.battle.SpriteSkill"
  params.buffDef = "app.views.battle.SpriteBuff"
  Player.ctor(self, params)
  self.bossHpBarNode = params.bossHpBarNode
  self.nodeColor = self.helpType == "teamer" and cc.c3b(100, 100, 100) or cc.c3b(255, 255, 255)
  self.nodeSize = cc.size(60, self.unit.hpBarHeight - 20)
  self.displayNode = display.newNode()
  self.displayNode:size(self.nodeSize)
  self.displayNode:setCascadeColorEnabled(true)
  self:initDisplayNode()
  self.attrNodes = {}
  self.hurtNodes = {}
end

function SpritePlayer:initDisplayNode()
  self.displayNode:removeAllChildren()
  display.newSprite("ui/battle/player_shadow.png"):pos(0, 0):addTo(self.displayNode)
  self.armatureNode = UIHelper.createSpineNode(self.unit.type, {
    cache = true,
    scale = self.scale
  })
  self.armatureNode:addTo(self.displayNode)
  self.armatureNode:setScaleX((self.side == SIDE_RIGHT and -1 or 1) * self.armatureNode:getScaleX())
  self.armatureNode:registerSpineEventHandler(handler(self, self.animationEndHandler), sp.EventType.ANIMATION_END)
  self.armatureNode:registerSpineEventHandler(handler(self, self.animationEventHandler), sp.EventType.ANIMATION_EVENT)
  self.armatureNode:setColor(self.nodeColor)
  self.topBar = display.newNode()
  self.topBar:pos(0, self.unit.hpBarHeight):addTo(self.displayNode)
  local hpSlot
  local namePreS = ""
  if self.bossHpBarNode then
    namePreS = "boss"
    hpSlot = display.newSprite(BattleRes .. namePreS .. "hpbar_slot.png"):pos(0, 0):addTo(self.bossHpBarNode)
    display.newSprite(BattleRes .. "bosshpbar_bg.png"):center(hpSlot):addTo(hpSlot, 1000)
    self.hpLabel = display.newTTFLabel({
      text = math.ceil(self.hp / self.fullHp * 100) .. "%",
      size = 20,
      color = UIHelper.hex2rgb("#ffffff")
    })
    self.hpLabel:enableOutline(UIHelper.hex2rgb("#5c1109"), 1)
    self.hpLabel:center(hpSlot):addTo(hpSlot, 1002)
    self.hpLabel:setPositionY(self.hpLabel:getPositionY() + 1)
    self.buffNode = display.newNode():pos(20, -20):addTo(hpSlot, 1002)
    if self.battleTag and 0 < self.battleTag then
      display.newSprite("icon/tree/" .. string.format("attr_done_%d.png", self.battleTag)):anch(0.5, 0.5):scale(0.4):pos(0, hpSlot:getContentSize().height / 2):addTo(hpSlot, 1002)
    end
  else
    hpSlot = display.newSprite(BattleRes .. "hpbar_slot.png"):anch(0.5, 0):addTo(self.topBar)
    local proBg = display.newSprite(GlobalRes .. string.format("profession_bg_%d.png", self.quality)):anch(1, 0.5):pos(0, 5):scale(0.5):addTo(hpSlot)
    display.newSprite(GlobalRes .. string.format("profession_%d.png", self.unit.profession)):center(proBg):addTo(proBg)
    self.buffNode = display.newNode():pos(0, 10):addTo(hpSlot)
    if self.taste and 0 < self.taste then
      display.newSprite(SkillRes .. string.format("taste_%d.png", self.taste)):anch(0, 0.5):scale(0.4):pos(40, 0):addTo(self.topBar)
      if self.battleTag and 0 < self.battleTag then
        display.newSprite("icon/tree/" .. string.format("attr_done_small_%d.png", self.battleTag)):anch(1, 0.5):pos(0, 5):addTo(hpSlot)
        proBg:hide()
      end
    elseif self.battleTag and 0 < self.battleTag then
      display.newSprite("icon/tree/" .. string.format("attr_done_small_%d.png", self.battleTag)):anch(0, 0.5):pos(40, 5):addTo(self.topBar)
    end
  end
  local hpSlotSize = hpSlot:getContentSize()
  self.hpBarAction = display.newProgressTimer(BattleRes .. namePreS .. "hpbar_action.png", cc.PROGRESS_TIMER_TYPE_BAR)
  self.hpBarAction:setMidpoint(cc.p(0, 0.5))
  self.hpBarAction:setBarChangeRate(cc.p(1, 0))
  self.hpBarAction:setPercentage(self.hp * 100 / self.fullHp)
  self.hpBarAction:center(hpSlot):addTo(hpSlot):hide()
  self.shieldBar = display.newProgressTimer(BattleRes .. namePreS .. "hpbar_shield.png", cc.PROGRESS_TIMER_TYPE_BAR)
  self.shieldBar:setMidpoint(cc.p(0, 0.5))
  self.shieldBar:setBarChangeRate(cc.p(1, 0))
  self.shieldBar:setPercentage(0)
  self.shieldBar:center(hpSlot):addTo(hpSlot)
  self.hpBar = display.newProgressTimer(BattleRes .. namePreS .. string.format("hpbar_%s.png", self:getSideKey()), cc.PROGRESS_TIMER_TYPE_BAR)
  self.hpBar:setMidpoint(cc.p(0, 0.5))
  self.hpBar:setBarChangeRate(cc.p(1, 0))
  self.hpBar:setPercentage(self.hp * 100 / self.fullHp)
  self.hpBar:center(hpSlot):addTo(hpSlot)
  if not self.magicValue or self.magicValue == 0 then
  end
end

function SpritePlayer:onChangeUnitType()
  self.armatureNode:unregisterSpineEventHandler(sp.EventType.ANIMATION_END)
  self.armatureNode:unregisterSpineEventHandler(sp.EventType.ANIMATION_EVENT)
  self.armatureNode:removeSelf()
  self.armatureNode = UIHelper.createSpineNode(self.unit.type, {
    cache = true,
    scale = self.scale
  })
  self.armatureNode:addTo(self.displayNode)
  self.armatureNode:setScaleX((self.side == SIDE_RIGHT and -1 or 1) * self.armatureNode:getScaleX())
  self.armatureNode:registerSpineEventHandler(handler(self, self.animationEndHandler), sp.EventType.ANIMATION_END)
  self.armatureNode:registerSpineEventHandler(handler(self, self.animationEventHandler), sp.EventType.ANIMATION_EVENT)
  self.armatureNode:setColor(self.nodeColor)
  self.animationName = nil
  self.lastAnimationTrack = nil
  self.clearAnimation = nil
end

function SpritePlayer:onHpChange(params)
  local origPercent = math.ceil(params.original * 100 / self.fullHp)
  local nowPercent = math.ceil(self.hp * 100 / self.fullHp)
  local shieldBuff = self:hasShieldBuff()
  if 0 < #shieldBuff then
    self:onChangeShield()
  else
    self.shieldBar:hide()
    if 10 < origPercent - nowPercent then
      local time = 0 < nowPercent and 0.3 or 0.15
      self.hpBarAction:show()
      self.hpBarAction:stopAllActions()
      self.hpBarAction:runAction(transition.sequence({
        cc.ProgressFromTo:create(time, origPercent, nowPercent),
        cc.Hide:create()
      }))
    end
    self.hpBar:setPercentage(nowPercent)
    if self.hpLabel then
      self.hpLabel:setString(math.ceil(self.hp / self.fullHp * 100) .. "%")
    end
    if nowPercent <= 0 then
      self.topBar:runAction(transition.sequence({
        cc.DelayTime:create(0.15),
        cc.Hide:create()
      }))
    end
  end
  local skillType = params.skillType or "normal"
  local hurtType = params.type or "normal"
  local hurtValue = params.value
  local hurtParams = params.hurtParams or {}
  local hurtExtrTag = hurtParams.hurtExtrTag
  local emengType = params.emengType or ""
  local hurtNode = display.newNode()
  if emengType == "" then
    print(1)
  end
  if effectTips[hurtType] then
    display.newSprite(effectTips[hurtType]):pos(0, self.unit.hpBarHeight / 2):addTo(self.displayNode, DISPLAY_ABOVE_ORDER + 1):runAction(transition.sequence({
      cc.ScaleTo:create(0.1, 2),
      cc.DelayTime:create(0.1),
      cc.Spawn:create({
        transition.sequence({
          cc.ScaleTo:create(0.2, 0.9),
          cc.ScaleTo:create(0.4, 0.6)
        }),
        cc.MoveBy:create(0.6, cc.p(0, self.unit.hpBarHeight)),
        cc.FadeOut:create(0.6)
      }),
      cc.RemoveSelf:create()
    }))
    if hurtType ~= "hurtBounce" then
      return
    end
  end
  if hurtValue == 0 then
    return
  end
  if skillType == "special" and not hurtParams.sumHurt then
    local font = hurtType == "crit" and "font/num_r1.fnt" or "font/num_y1.fnt"
    ui.newBMFontLabel({
      text = emengType == "tebao" and "t" .. math.abs(hurtValue) or emengType == "tekang" and "d" .. math.abs(hurtValue) or math.abs(hurtValue),
      font = font
    }):anch(0.5, 0):pos(0, self.unit.hpBarHeight + 20):addTo(self.displayNode, DISPLAY_ABOVE_ORDER + 1):scale(0.6):runAction(transition.sequence({
      cc.ScaleTo:create(0.1, 2),
      cc.DelayTime:create(0.15),
      cc.Spawn:create({
        transition.sequence({
          cc.ScaleTo:create(0.2, 0.9),
          cc.ScaleTo:create(0.3, 0.6)
        }),
        cc.MoveBy:create(0.5, cc.p(0, self.unit.hpBarHeight)),
        cc.FadeOut:create(0.5)
      }),
      cc.RemoveSelf:create()
    }))
  else
    local colorSet = textColorMap[hurtType] and textColorMap[hurtType] or textColorMap.normal
    local fontSize = colorSet.size
    if hurtExtrTag == "doubleHurt" then
      fontSize = fontSize + 50
    end
    local randomHeight, randomWidth = math.randomInt(0, 60), math.randomInt(0, 60)
    local hurtLabel = display.newTTFLabel({
      text = math.abs(hurtValue),
      color = colorSet.color,
      size = fontSize,
      font = "font/NYALA.TTF"
    }):enableOutline(colorSet.stroke, colorSet.strokeSize):anch(0, 0):pos(-40 + randomWidth, self.unit.hpBarHeight / 2 + randomHeight):addTo(self.displayNode, DISPLAY_ABOVE_ORDER + 1):scale(1.5)
    if emengType ~= "" then
      display.newSprite(colorSet[emengType]):anch(1, 0):pos(0, 11):addTo(hurtLabel)
    end
    hurtLabel:runAction(transition.sequence({
      cc.Spawn:create({
        transition.sequence({
          cc.ScaleTo:create(0.2, 0.9),
          cc.ScaleTo:create(0.3, 0.6)
        }),
        cc.BezierBy:create(0.5, {
          cc.p(30, 40),
          cc.p(60, 100),
          cc.p(100, 10)
        }),
        transition.sequence({
          cc.DelayTime:create(0.2),
          cc.FadeOut:create(0.3)
        })
      }),
      cc.RemoveSelf:create()
    }))
    if hurtParams.sumHurt then
      self:showSumHurt(hurtParams.skillId, math.abs(hurtValue), emengType)
    end
  end
end

function SpritePlayer:showSumHurt(id, hurtValue, emengType)
  local skillId = id
  if not skillId or not hurtValue then
    return
  end
  if not self.unit then
    return
  end
  if not self.displayNode then
    return
  end
  if tolua.isnull(self.displayNode) then
    return
  end
  if not self.hurtNodes[skillId] then
    self.hurtNodes[skillId] = {}
  end
  local hurt = self.hurtNodes[skillId]
  if hurt.tip then
    hurt.tip:removeSelf()
  end
  hurt.value = (hurt.value or 0) + hurtValue
  local tip = ui.newBMFontLabel({
    text = emengType == "tebao" and "t" .. hurt.value or emengType == "tekang" and "d" .. hurt.value or hurt.value,
    font = "font/num_y1.fnt"
  }):anch(0.5, 0):pos(0, self.unit.hpBarHeight + 20):addTo(self.displayNode, DISPLAY_ABOVE_ORDER + 1):scale(0.6)
  hurt.tip = tip
  tip:runAction(transition.sequence({
    cc.ScaleTo:create(0.1, 1.2),
    cc.ScaleTo:create(0.1, 1),
    cc.DelayTime:create(0.2),
    cc.Spawn:create({
      cc.MoveBy:create(0.3, cc.p(0, self.unit.hpBarHeight)),
      cc.FadeOut:create(0.3)
    }),
    cc.CallFunc:create(function()
      self.hurtNodes[skillId] = nil
    end),
    cc.RemoveSelf:create()
  }))
end

function SpritePlayer:onChangeAttribute(params)
  if params.name ~= "Atk" and params.name ~= "PhyDef" then
    return
  end
  local status = params.value > 0 and "up" or "down"
  local name = string.format("battleEff/fight/%s%s.png", status, params.name)
  local nameIcon = display.newSprite(name)
  local currentIndex
  for index = 1, #self.attrNodes do
    if not self.attrNodes[index] then
      currentIndex = index
      break
    end
  end
  currentIndex = currentIndex or #self.attrNodes + 1
  self.attrNodes[currentIndex] = true
  local attrCount = table.nums(self.attrNodes)
  local delay = (attrCount - 1) * 0.2
  nameIcon:anch(0.5, 0):scale(0.5):pos(0, self.unit.hpBarHeight / 2):addTo(self.displayNode)
  nameIcon:runAction(transition.sequence({
    cc.DelayTime:create(delay),
    cc.Show:create(),
    cc.Spawn:create({
      cc.MoveBy:create(0.2, cc.p(0, 20)),
      cc.ScaleTo:create(0.1, 1)
    }),
    cc.CallFunc:create(function()
      self.attrNodes[currentIndex] = nil
    end),
    cc.DelayTime:create(0.4),
    cc.Spawn:create({
      cc.MoveBy:create(0.3, cc.p(0, 20)),
      cc.ScaleTo:create(0.3, 0.75)
    }),
    cc.Spawn:create({
      cc.MoveBy:create(0.5, cc.p(0, 40)),
      cc.FadeOut:create(0.5)
    }),
    cc.RemoveSelf:create()
  }))
end

function SpritePlayer:onChangeShield()
  local shieldBuff = self:hasShieldBuff()
  if 0 < #shieldBuff then
    self.shieldBar:show()
    local shield = 0
    for _, buffType in ipairs(shieldBuff) do
      for _, buff in ipairs(self.buffTypes[buffType]) do
        if not buff.hasFinished then
          shield = shield + buff.recordValue
        end
      end
    end
    if shield > self.shieldValue then
      self.shieldAddValue = shield - self.shieldValue
      self:onShieldAdd()
    end
    self.shieldValue = shield
    local fullHp = self.fullHp + shield
    self.hpBar:setPercentage(math.ceil(self.hp * 100 / fullHp))
    if self.hpLabel then
      self.hpLabel:setString(math.ceil(self.hp / self.fullHp * 100) .. "%")
    end
    self.shieldBar:setPercentage(math.ceil((self.hp + shield) * 100 / fullHp))
  else
    self.shieldBar:hide()
  end
end

function SpritePlayer:updateBuffIcon()
  local buffs = {}
  for id, buffData in pairs(self.buffIds) do
    table.insert(buffs, {
      id = id,
      timestamp = buffData.timestamp,
      count = buffData.num
    })
  end
  table.sort(buffs, function(a, b)
    return a.timestamp > b.timestamp
  end)
  self.buffNode:removeAllChildren()
  local count, interval = 1, 17
  local totalCount = self.bossHpBarNode and 11 or 5
  for index, buffData in ipairs(buffs) do
    local buffSet = BuffSet[buffData.id]
    local buffCount = buffData.count
    if buffSet and buffSet.Icon ~= "" then
      local icon = display.newSprite("buff_tips/bufficon/" .. buffSet.Icon)
      icon:anch(0, 0):pos((count - 1) * interval, 0):addTo(self.buffNode)
      count = count + 1
      if 1 < buffCount then
        local numLabel = display.newTTFLabel({text = buffCount, size = 14}):pos(10, 5):addTo(icon)
        numLabel:enableOutline(UIHelper.hex2rgb("#000000"), 1)
        if buffSet.id == 869 or buffSet.id == 879 or buffSet.id == 889 then
          numLabel:setString(buffCount * 10)
        end
      end
      if totalCount < count then
        break
      end
    end
  end
end

function SpritePlayer:animationEndHandler(event)
  if self.clearAnimation and event.trackIndex == self.clearAnimation then
    self.clearAnimation = nil
    return
  end
  self.animationStatus = "end"
  self.animationName = nil
  self.armatureNode:setTimeScale(1)
  self.lastAnimationTrack = nil
  self:disposeSkill()
  if event.animation == "standby" and self:canDoEvent("special") then
    self:doEvent("special")
    return
  end
  local animationControl = animationData[event.animation]
  if animationControl and animationControl.finishToIdle and self:canDoEvent("idle") then
    self:doEvent("idle")
    return
  end
end

function SpritePlayer:animationEventHandler(event)
  local skillAnimationNames = {
    attack = true,
    attack1 = true,
    attack2 = true,
    attack3 = true,
    skill = true,
    special = true,
    special2 = true,
    special3 = true,
    special4 = true,
    special5 = true
  }
  if skillAnimationNames[event.animation] then
    self.animationStatus = "event"
    self:releaseSkill()
  elseif event.animation == "dead" then
  end
end

function SpritePlayer:playAnimation(name)
  if self.animationName == name then
    return
  end
  for _, data in pairs(animationData) do
    if name == "dead" then
      self.armatureNode:clearTracks()
    elseif data.loop then
      self.armatureNode:clearTrack(data.track)
    end
  end
  self.animationStatus = "start"
  self.animationName = name
  self.armatureNode:setToSetupPose()
  local animationControl = animationData[name]
  if not animationControl.loop and self.lastAnimationTrack and animationControl.track ~= self.lastAnimationTrack then
    self.clearAnimation = self.lastAnimationTrack
    self.armatureNode:clearTrack(self.lastAnimationTrack)
  end
  if self.armatureNode:containAnimation(name) then
    self.armatureNode:setAnimation(animationControl.track, name, animationControl.loop)
  else
    printError("animation not found ..." .. self.unit.type .. name)
    if self:canDoEvent("idle") then
      self:doEvent("idle")
    end
    return false
  end
  if not animationControl.loop then
    self.lastAnimationTrack = animationControl.track
  end
  if name == "special" then
    self:dispatchEvent({
      name = "onSpecialAnimation",
      blockId = self.unit.specialBlock
    })
  end
  return true
end

function SpritePlayer:onPause(shipAnimation)
  UIHelper.pauseNode(self.displayNode)
  if not shipAnimation then
    self.armatureNode:pause()
  end
end

function SpritePlayer:onResume(shipAnimation)
  UIHelper.resumeNode(self.displayNode)
  if not shipAnimation then
    self.armatureNode:resume()
  end
end

function SpritePlayer:dispose()
  self.displayNode:removeSelf()
end

function SpritePlayer:onIdle(event)
  self:playAnimation("idle")
end

function SpritePlayer:onMove(event)
  self:playAnimation("move")
end

function SpritePlayer:onUpdatePosition()
  self.displayNode:pos(self.position.x, self.position.y)
end

function SpritePlayer:onUpdateDirection()
  self.armatureNode:setScaleX(self.armatureNode:getScaleX() * -1)
end

function SpritePlayer:onHurt(event)
  self:playAnimation("damaged")
end

function SpritePlayer:onAttack(event)
  local index = 1
  if self.attackOrderIdx > 0 then
    index = self.attackOrderIdx
    self.attackOrderIdx = self.attackOrderIdx + 1
    if self.attackOrderIdx > #self.attackOrders then
      self.attackOrderIdx = 1
    end
  end
  self:playAnimation(attackOrders[index])
end

function SpritePlayer:onBlock(event)
  self:playAnimation("skill")
end

function SpritePlayer:onSpecial(event)
  local animation = "special"
  if self.currentSkillAnimation and self.currentSkillAnimation > 1 then
    animation = animation .. self.currentSkillAnimation
  end
  self:playAnimation(animation)
  if self.currentSkillId > 0 then
    local skill = SkillSet[self.currentSkillId]
    if skill and 0 < skill.specialSoundId then
      game:playMusic(skill.specialSoundId)
    end
  end
  self.currentSkillAnimation = nil
end

function SpritePlayer:onCheer(event)
  self:playAnimation("cheer")
end

function SpritePlayer:onStandby(event)
  self:playAnimation("standby")
end

function SpritePlayer:onReborn(event)
  self.topBar:show()
  self.armatureNode:setColor(self.nodeColor)
  self.armatureNode:stopAllActions()
  self.armatureNode:opacity(255)
  self:playAnimation("attack")
end

function SpritePlayer:onDead(event)
  self.topBar:hide()
  self:playAnimation("dead")
end

function SpritePlayer:setForceTag(show)
  self.topBar:removeChildByTag(FORCETAG)
  if show then
    local tag = UIHelper.createSpineNodeByRes("spine/ui/battle/lock")
    tag:anch(0.5, 0):pos(0, -self.unit.hpBarHeight / 2):addTo(self.topBar, nil, FORCETAG)
    tag:setAnimation(0, "special", false)
  end
end

return SpritePlayer
