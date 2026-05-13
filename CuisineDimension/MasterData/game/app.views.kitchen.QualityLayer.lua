local unitCsv = require("csvdata.unit")
local evolutionCsv = require("csvdata.evolution")
local starCsv = require("csvdata.star")
local specialCsv = require("csvdata.skill_special")
local blockCsv = require("csvdata.skill_block")
local heroExpCsv = require("csvdata.hero_exp")
local innateCsv = require("csvdata.innate")
local heroRes = "ui/hero/detail/"
local qulaityRes = "ui/kitchen/quality/"
local globalRes = "ui/global/"
local uiData = {
  csbFile = "ui/kitchen/QualityLayer.csb",
  widgets = {
    panel1 = "panel1",
    attrNode = "panel1/attrNode",
    skill1 = "panel1/skill1",
    skill2 = "panel1/skill2",
    panel2 = "panel2",
    card1 = "panel2/card1",
    card2 = "panel2/card2",
    card3 = "panel2/card3",
    card4 = "panel2/card4",
    card5 = "panel2/card5",
    card6 = "panel2/card6",
    card7 = "panel2/card7",
    card8 = "panel2/card8",
    card9 = "panel2/card9",
    card10 = "panel2/card10",
    evoBtn = "panel2/evoBtn",
    leftPanel = "leftPanel",
    circleBg = "leftPanel/circleBg",
    bigCircle = "leftPanel/bigCircle",
    heroNode = "leftPanel/heroNode",
    circle = "leftPanel/circle",
    imageR = "leftPanel/imageR",
    imageL = "leftPanel/imageL",
    descPanel = "descPanel",
    level = "descPanel/level",
    buttom = "buttom",
    angel1 = "angel1",
    angel2 = "angel2"
  }
}
local attrs = {
  "hp",
  "atk",
  "hit",
  "miss",
  "phyDef",
  "material1",
  "material2"
}
local texts = {
  "生命:",
  "攻击:",
  "命中:",
  "闪避:",
  "防御:",
  "食油:",
  "魔力:"
}
local QualityLayer = class("QualityLayer", UIBase)

function QualityLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function QualityLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.buttom)
    self.panel1:setPositionX(self.panel1:getPositionX() + 160)
    self.panel2:setPositionX(self.panel2:getPositionX() + 160)
    self.angel2:setPositionX(self.angel2:getPositionX() + 200)
  end
  self.bigCircle:runAction(cc.RepeatForever:create(cc.RotateBy:create(30, -360)))
  self.circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  self.eatList = {}
  self.cards = {}
  self.action = false
  self.canEvol = false
  self:showMainHero()
  self:showPanel1("?")
  self:showPanel2()
  self.descPanel:hide()
  UIHelper.MoveToRight({
    node = self.leftPanel
  })
  UIHelper.MoveToLeft({
    node = self.panel1
  })
  UIHelper.MoveToLeft({
    node = self.panel2
  })
  UIHelper.MoveToUp({
    node = self.buttom,
    delay = 0.2
  })
  UIHelper.MoveToUp({
    node = self.angel1,
    delay = 0.3
  })
  UIHelper.MoveToUp({
    node = self.angel2,
    delay = 0.3
  })
  self.evoBtn:setTouchScale()
  self.evoBtn:hide()
  self.evoBtn:setCallback(function()
    if self.action then
      return
    end
    if not self.hero then
      SysError(SYS_ERR_QUALITY_HERO_CHOOSE)
      return
    end
    if self.hero.quality >= 5 then
      return
    end
    local needNum = evolutionCsv[self.hero.quality].cardUse
    if needNum > #self.eatList then
      SysError(SYS_ERR_QUALITY_HERO_COUNT_NOT_ENOUGH)
      return
    end
    self.action = true
    game:sendData(actionCodes.Hero_qualityRpc, MsgPack.pack({
      heroId = self.hero.id,
      ids = self.eatList
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Hero_qualityRpc, function(event)
      UIHelper.removeWaiting()
      game:playMusic(1102)
      CommonHelper.playCV(self.hero.type, "quality")
      self.heroNode:runAction(transition.sequence({
        cc.CallFunc:create(function()
          self:showSmallCardAnimation()
          self:showBigCardAnimation()
        end),
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function()
          self.eatList = {}
          self.cards = {}
          self:showPanel2(0)
        end)
      }))
    end)
  end)
end

function QualityLayer:showMainHero(action)
  self.heroNode:removeAllChildren()
  if self.hero then
    self.descPanel:show()
    self:showDescPanel()
    local card = self:createHeroCard()
    if action then
      local xPosR = self.imageR:getPositionX()
      local xPosL = self.imageL:getPositionX()
      self.imageR:setPositionX(xPosR + 35)
      self.imageL:setPositionX(xPosL - 35)
      self.imageR:show()
      self.imageL:show()
      self.imageR:runAction(cc.MoveBy:create(0.2, cc.p(-35, 0)))
      self.imageL:runAction(cc.MoveBy:create(0.2, cc.p(35, 0)))
      card:anch(0.5, 0.5):pos(0, -50):addTo(self.heroNode)
      card:setCascadeOpacityEnabled(true)
      card:setOpacity(0)
      card:runAction(cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 50)), cc.FadeIn:create(0.2)))
    else
      card:anch(0.5, 0.5):addTo(self.heroNode)
    end
    card:name("card")
    card:setCallback(function()
      if self.action then
        return
      end
      self:showChooseHero()
    end)
  else
    self.imageR:hide()
    self.imageL:hide()
    display.newTTFLabel({
      text = "添加食灵",
      size = 22,
      color = UIHelper.hex2rgb("#b4f730")
    }):pos(-2, -40):addTo(self.heroNode)
    local btn = UIHelper.newImageView("ui/equip/reforge/add.png"):pos(0, 16):addTo(self.heroNode)
    btn:setCallback(function()
      self:showChooseHero()
    end)
  end
end

function QualityLayer:showPanel1(mark)
  self.attrNode:removeAllChildren()
  self.skill1:removeAllChildren()
  self.skill2:removeAllChildren()
  local hero
  local old, new = {}, {}
  if self.hero then
    hero = self.hero
    old = hero:getTotalAttrValues()
    new = hero:getTotalAttrValues({
      quality = hero.quality + 1
    })
  end
  for i = 1, 5 do
    local yPos = (i - 1) * -21
    display.newSprite(heroRes .. attrs[i] .. ".png"):pos(0, yPos - 2):addTo(self.attrNode)
    display.newTTFLabel({
      text = texts[i],
      size = 18,
      color = UIHelper.hex2rgb("#703902")
    }):pos(40, yPos):addTo(self.attrNode)
    display.newTTFLabel({
      text = mark or old[attrs[i]],
      size = 18,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(80, yPos):addTo(self.attrNode)
    for index = 1, 4 do
      display.newSprite(qulaityRes .. "arrow.png"):pos(140 + (index - 1) * 6, yPos):addTo(self.attrNode)
    end
    display.newTTFLabel({
      text = mark or new[attrs[i]],
      size = 18,
      color = UIHelper.hex2rgb("#3a9721")
    }):anch(0, 0.5):pos(180, yPos):addTo(self.attrNode)
  end
  for i = 1, 2 do
    local yPos = (i + 4) * -21
    display.newSprite(heroRes .. attrs[i + 5] .. ".png"):pos(0, yPos - 2):addTo(self.attrNode)
    display.newTTFLabel({
      text = texts[i + 5],
      size = 18,
      color = UIHelper.hex2rgb("#703902")
    }):pos(40, yPos):addTo(self.attrNode)
    for index = 1, 4 do
      display.newSprite(qulaityRes .. "arrow.png"):pos(140 + (index - 1) * 6, yPos):addTo(self.attrNode)
    end
    local count1, count2 = 0, 0
    if not mark then
      count1 = self.hero.unit["material" .. i] * evolutionCsv[self.hero.quality].materialCarry
      count2 = self.hero.unit["material" .. i] * evolutionCsv[self.hero.quality + 1].materialCarry
    end
    display.newTTFLabel({
      text = mark or math.floor(count1),
      size = 18,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(80, yPos):addTo(self.attrNode)
    display.newTTFLabel({
      text = mark or math.floor(count2),
      size = 18,
      color = UIHelper.hex2rgb("#3a9721")
    }):anch(0, 0.5):pos(180, yPos):addTo(self.attrNode)
  end
  if mark then
    for i = 1, 2 do
      local node = self["skill" .. i]
      local text = i == 1 and "料理技" or "固有技"
      display.newSprite(heroRes .. "skill_bg.png"):scale(0.8):addTo(node)
      local content = display.newSprite(heroRes .. "mask.png"):addTo(node)
      display.newTTFLabel({
        text = "?",
        size = 24,
        color = UIHelper.hex2rgb("#703902")
      }):center(content):addTo(content)
      display.newTTFLabel({
        text = text,
        size = 14,
        color = UIHelper.hex2rgb("#703902")
      }):pos(0, -35):addTo(node)
    end
  elseif self.hero.unit.star == 6 then
    local innateLevel = evolutionCsv[self.hero.quality].innateLevel
    local innateNewLevel = evolutionCsv[self.hero.quality + 1].innateLevel
    local innateData = innateCsv[self.hero.unit.type][innateLevel]
    local newInnateData = innateCsv[self.hero.unit.type][innateNewLevel]
    local typeString = {
      [1] = {
        text = "技能等级提高",
        typeName = "skillLevel"
      },
      [2] = {
        text = "属性提升解锁",
        typeName = "statusLevel"
      },
      [3] = {
        text = "属性提升",
        typeName = "statusLevel"
      },
      [4] = {
        text = "进阶装盘解锁",
        typeName = "formationUp"
      },
      [5] = {
        text = "梦境祝福解锁",
        typeName = "characteristic"
      },
      [6] = {
        text = "梦境祝福提升",
        typeName = "characteristic"
      },
      [7] = {
        text = "梦特技解锁",
        typeName = "dreamLevel"
      },
      [8] = {
        text = "梦特技提升",
        typeName = "dreamLevel"
      }
    }
    for i = 1, 2 do
      local node = self["skill" .. i]
      local text = i == 1 and "天赋" or typeString[newInnateData.type].text
      local typeLevel = innateData[typeString[newInnateData.type].typeName]
      local newTypeLevel = newInnateData[typeString[newInnateData.type].typeName]
      local level = i == 1 and innateLevel or typeLevel
      local newLevel = i == 1 and innateNewLevel or newTypeLevel
      display.newSprite(heroRes .. "skill_bg.png"):scale(0.8):addTo(node)
      UIHelper.getClipNode({
        steRes = heroRes .. "skill_mask.png",
        clipRes = i == 1 and innateData.icon or innateData.typeIcon
      }):scale(0.47):pos(0, 0):addTo(node)
      display.newSprite(heroRes .. "mask.png"):addTo(node)
      display.newTTFLabel({
        text = text,
        size = 14,
        color = UIHelper.hex2rgb("#703902")
      }):pos(0, -35):addTo(node)
      display.newTTFLabel({
        text = "Lv" .. level,
        size = 16,
        color = UIHelper.hex2rgb("#703902")
      }):pos(43, 0):addTo(node)
      display.newTTFLabel({
        text = "Lv" .. newLevel,
        size = 16,
        color = UIHelper.hex2rgb("#703902")
      }):pos(96, 0):addTo(node)
      for index = 1, 4 do
        display.newSprite(qulaityRes .. "arrow.png"):pos(60 + (index - 1) * 6, 0):addTo(node)
      end
    end
  else
    local level = evolutionCsv[self.hero.quality].skillLevel
    local newLevel = evolutionCsv[self.hero.quality + 1].skillLevel
    for i = 1, 2 do
      local skillId = i == 1 and self.hero:getSpecialId() or self.hero:getBlockId()
      local node = self["skill" .. i]
      if skillId ~= 0 then
        local skillData = i == 1 and specialCsv[skillId][level] or blockCsv[skillId][level]
        local text = i == 1 and "料理技" or "固有技"
        display.newSprite(heroRes .. "skill_bg.png"):scale(0.8):addTo(node)
        UIHelper.getClipNode({
          steRes = heroRes .. "skill_mask.png",
          clipRes = skillData.icon
        }):scale(0.47):pos(0, 0):addTo(node)
        display.newSprite(heroRes .. "mask.png"):addTo(node)
        display.newTTFLabel({
          text = text,
          size = 14,
          color = UIHelper.hex2rgb("#703902")
        }):pos(0, -35):addTo(node)
        display.newTTFLabel({
          text = "Lv" .. level,
          size = 16,
          color = UIHelper.hex2rgb("#703902")
        }):pos(43, 0):addTo(node)
        display.newTTFLabel({
          text = "Lv" .. newLevel,
          size = 16,
          color = UIHelper.hex2rgb("#703902")
        }):pos(96, 0):addTo(node)
        for index = 1, 4 do
          display.newSprite(qulaityRes .. "arrow.png"):pos(60 + (index - 1) * 6, 0):addTo(node)
        end
      end
    end
  end
end

function QualityLayer:showPanel2(num)
  local cur = num or self.hero and evolutionCsv[self.hero.quality].cardUse or 0
  for i = 1, 10 do
    local cardBg = self["card" .. i]
    cardBg:removeAllChildren()
    local card
    local heroId = self.eatList[i]
    if heroId then
      card = HeroHead.new({heroId = heroId, loveEffect = true}):center(cardBg):addTo(cardBg)
      table.insert(self.cards, card)
    else
      local image = i > cur and "ui/kitchen/quality/cook.png" or "ui/global/equip_add_2.png"
      UIHelper.newImageView(image):center(cardBg):addTo(cardBg):name("add")
      card = UIHelper.newImageView("ui/global/item_frame.png"):center(cardBg):addTo(cardBg)
    end
    if i <= cur and self.canEvol then
      card:setCallback(function()
        if self.action then
          return
        end
        
        local function eatRule(_hero)
          local states = _hero:getState()
          if states[1] or states[2] or states[3] then
            return true
          end
          if _hero.lock == 1 or _hero.id == self.hero.id or _hero.formation > 0 or _hero.type ~= self.hero.type and _hero.type ~= globalCsv.evolutionEssence then
            return true
          end
          return false
        end
        
        local layer = game:createView("hero.ChooseHeroLayer", {
          rule = eatRule,
          multiChoose = true,
          choosedList = self.eatList,
          max = cur,
          type = 4,
          callback = function(choose)
            self.eatList = {}
            self.cards = {}
            for id, _ in pairs(choose) do
              table.insert(self.eatList, id)
            end
            self:showPanel2()
          end
        })
        BackManager:push(function()
          layer:close()
          TopBar:show(TopBarType.full, "食灵")
        end)
      end)
    elseif i <= cur then
      local add = cardBg:getChildByName("add")
      UIHelper.setImageViewGray(add)
    end
  end
end

function QualityLayer:showDescPanel()
  local evolData = evolutionCsv[self.hero.quality]
  local color1 = self.hero.level >= evolData.level and "#3a9721" or "#ff3b72"
  self.level:setString(string.format("%d/%d", self.hero.level, evolData.level))
  self.level:setTextColor(UIHelper.hex2rgb(color1))
  if self.hero.level >= evolData.level then
    self.evoBtn:show()
    self.canEvol = true
  else
    self.evoBtn:hide()
    self.canEvol = false
  end
end

function QualityLayer:createHeroCard()
  local unitData = unitCsv[self.hero:getDressType()]
  local quality = self.hero.quality
  local attrValues = self.hero:getTotalAttrValues()
  local hp = attrValues.hp * self.hero.hpPercent / 1000
  hp = self.hero.hpPercent > 500 and math.floor(hp) or math.ceil(hp)
  local big = self.hero.hpPercent <= 300
  local content = UIHelper.newImageView(globalRes .. string.format("small_card_bg_%d.png", quality))
  UIHelper.newImageView(UIHelper.getCardRes("book", unitData.type, big, quality)):scale(0.92):pos(content:getContentSize().width / 2, 146):addTo(content)
  local starBg = UIHelper.newImageView(string.format(globalRes .. "star_bg_%d.png", quality)):pos(98, 85):addTo(content)
  starBg:setCascadeOpacityEnabled(true)
  local star, xInterval = self.hero.unit.star, 20
  local temStar = math.min(star, 5)
  local xBegin = starBg:getContentSize().width / 2 - (temStar - 1) * xInterval / 2 + 1
  local bMax = self.hero:isTreeMax()
  local isBlack = self.hero:isBlackHero()
  local isMengJing = self.hero:isMengJingHero()
  local isShengcan = self.hero:isShengcanHero()
  if isShengcan then
    for index = 1, temStar do
      UIHelper.newImageView(globalRes .. (bMax and "star_tree_red.png" or "star.png")):pos(xBegin + (index - 1) * xInterval, 14):addTo(starBg)
    end
  else
    for index = 1, temStar do
      UIHelper.newImageView(globalRes .. (bMax and (isBlack and "star_tree_black.png" or "star_tree.png") or isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png")):pos(xBegin + (index - 1) * xInterval, 14):addTo(starBg)
    end
  end
  local marryBg = display.newSprite(globalRes .. "small_card_marry_bg.png"):center(content):addTo(content)
  marryBg:setCascadeOpacityEnabled(true)
  if 5 <= self.hero.loveBreak then
    display.newSprite(globalRes .. "small_card_marry.png"):center(marryBg):addTo(marryBg)
  end
  UIHelper.newText({
    text = "食灵: " .. self.hero:getName(),
    size = 16,
    color = UIHelper.hex2rgb("#000000")
  }):pos(15, 59):enableOutline(UIHelper.hex2rgb("#ffffff"), 1):anch(0, 0.5):addTo(content)
  UIHelper.newText({
    text = "美味度: " .. self.hero:getAllValue(),
    size = 16,
    color = UIHelper.hex2rgb("#000000")
  }):pos(15, 40):enableOutline(UIHelper.hex2rgb("#ffffff"), 1):anch(0, 0.5):addTo(content)
  local isAdvanceMax = self.hero:isSauceAdvanceMax()
  UIHelper.newText({
    text = string.format("Lv: %d", self.hero.level),
    size = 24,
    color = UIHelper.hex2rgb(isAdvanceMax and "#0afff1" or "#000000")
  }):enableOutline(UIHelper.hex2rgb(isAdvanceMax and "#000000" or "#ffffff"), isAdvanceMax and 1 or 2):anch(0, 0.5):pos(15, 23):addTo(content)
  local pro = UIHelper.getProfessionTag(self.hero.unit.profession, quality, 18, self.hero:showTreeTag()):scale(0.9):pos(176, 193):addTo(content)
  pro:setCascadeOpacityEnabled(true)
  content:scale(1.1)
  return content
end

function QualityLayer:showChooseHero()
  local function rule(hero)
    if hero.id == (self.hero and self.hero.id or 0) then
      return true
    end
    if hero.quality >= MAX_QUALITY_LEVEL then
      return true
    end
    return false
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    rule = rule,
    type = 3,
    callback = function(choose)
      if choose == 0 then
        choose = nil
      end
      local hero = game.role.heros[choose]
      if hero then
        local state = hero:getState()
        if state[1] then
          SysError(SYS_ERR_HERO_LOCKED_CURE_QUAILTY_UP)
          return true
        end
        if state[2] then
          SysError(SYS_ERR_HERO_LOCKED_FIGHT_QUAILTY_UP)
          return true
        end
        if state[3] then
          SysError(SYS_ERR_HERO_LOCKED_CONSIGATION_QUAILTY_UP)
          return true
        end
      end
      self.eatList = {}
      self.evoBtn:show()
      self.hero = hero
      self:showMainHero(true)
      self:showPanel1()
      self:showPanel2()
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "食灵")
  end)
end

function QualityLayer:showSmallCardAnimation()
  for index, card in ipairs(self.cards) do
    local effect = UIHelper.loadAnimation(qulaityRes, "quality_smallbox", 14, 30)
    effect.sprite:center(card):addTo(card)
    effect.sprite:playAnimationOnce(effect.animation, true)
  end
end

function QualityLayer:showBigCardAnimation()
  self:ImagesAnimatHide()
  local magic = UIHelper.loadAnimation(qulaityRes, "quality_magic", 28, 30)
  magic.sprite:center(self.circleBg):addTo(self.circleBg)
  magic.sprite:playAnimationOnce(magic.animation, false)
  local card = self.heroNode:getChildByName("card")
  local mask = display.newSprite(qulaityRes .. "mask.png"):anch(0.5, 0):pos(0, -152):addTo(self.heroNode, 10)
  mask:setOpacity(0)
  self.circleBg:runAction(transition.sequence({
    cc.CallFunc:create(function()
      mask:runAction(transition.sequence({
        cc.FadeIn:create(1),
        cc.CallFunc:create(function()
          card:removeSelf()
        end)
      }))
    end),
    cc.CallFunc:create(function()
      mask:runAction(cc.Sequence:create({
        cc.OrbitCamera:create(1, 1, 0, 0, 10, 360, 0),
        cc.OrbitCamera:create(0.5, 1, 0, 0, 360, 0, 0),
        cc.OrbitCamera:create(1, 1, 0, 0, 360, 0, 0),
        cc.CallFunc:create(function()
          self:showDescPanel()
          local newCard = self:createHeroCard()
          newCard:anch(0.5, 0.5):pos(0, 0):addTo(self.heroNode)
          newCard:setCascadeOpacityEnabled(true)
          newCard:runAction(transition.sequence({
            cc.DelayTime:create(1),
            cc.FadeOut:create(1),
            cc.CallFunc:create(function()
              self.hero = nil
              self:showPanel1("?")
              self:showMainHero()
              self.action = false
              self.descPanel:hide()
            end)
          }))
          magic.sprite:runAction(transition.sequence({
            cc.FadeOut:create(0.2),
            cc.CallFunc:create(function()
              self:ImagesAnimatShow()
            end),
            cc.RemoveSelf:create()
          }))
          local effect = UIHelper.loadAnimation(qulaityRes, "quality_bigbox", 24, 30)
          effect.sprite:anch(0.5, 0):pos(0, -152):addTo(self.heroNode, 5)
          effect.sprite:playAnimationOnce(effect.animation, true)
        end),
        cc.RemoveSelf:create()
      }))
    end)
  }))
end

function QualityLayer:ImagesAnimatHide()
  self.imageR:runAction(cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(35, 0)), cc.FadeOut:create(0.3)))
  self.imageL:runAction(cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(-35, 0)), cc.FadeOut:create(0.3)))
end

function QualityLayer:ImagesAnimatShow()
  self.imageR:runAction(cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(-35, 0)), cc.FadeIn:create(0.3)))
  self.imageL:runAction(cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(35, 0)), cc.FadeIn:create(0.3)))
end

return QualityLayer
