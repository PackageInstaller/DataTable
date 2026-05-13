local UnitDataSet = require("csvdata.unit")
local HeroExpCsv = require("csvdata.hero_exp")
local SuitCsv = require("csvdata.equip_suit")
local EffectCsv = require("csvdata.love_effect")
local globalRes = "ui/global/"
local battleRes = "ui/carbon/battle/"
local heroRes = "ui/hero/"
local TeamHeroCard = class("TeamHeroCard", function()
  return UIHelper.extend(ccui.ImageView:create())
end)

function TeamHeroCard:ctor(params)
  self.clickCallback = params.callback
  self.detail = params.detail
  self.refresh = params.refresh
  self.captain = params.captain
  self.hero = game.role.heros[params.heroId]
  self.type = self.hero:getDressType()
  self.selectedState = 0
  self.isSpecial = params.isSpecial
  self.hpPercent = params.hpPercent or self.hero.hpPercent
  self.unitData = UnitDataSet[self.type]
  self:uiLayout()
  local guideLayer = display.getRunningScene():getChildByTag(NEW_GUIDE_LAYER_TAG)
  if guideLayer then
    self.guideStep = guideLayer.guideStep
  end
end

function TeamHeroCard:uiLayout()
  local quality = self.hero.quality
  local attrValues = self.hero:getTotalAttrValues()
  local hp = attrValues.hp * self.hpPercent / 1000
  hp = self.hpPercent > 500 and math.floor(hp) or math.ceil(hp)
  local big = self.hpPercent <= 300
  self:setImage(string.format(globalRes .. "big_card_bg_%d.png", quality))
  local size = self:getContentSize()
  display.newSprite(UIHelper.getCardRes("list", self.type, big, self.hero.quality)):center(self):addTo(self)
  display.newSprite(string.format(globalRes .. "big_card_middle_%d.png", quality)):center(self):addTo(self)
  if self.hero.lock == 1 then
    display.newSprite(globalRes .. "lock.png"):anch(0, 0.5):pos(10, 450):addTo(self):name("lock")
  end
  local awakeLogoPath = CommonHelper.getAwakeTypePath(self.hero.id)
  if awakeLogoPath then
    display.newSprite(string.format("ui/hero/awake/awake%d.png", awakeLogoPath)):pos(135, 54):addTo(self)
  end
  local star, xInterval = self.hero.unit.star, 22
  local temStar = math.min(star, 5)
  local xBegin = size.width / 2 - (temStar - 1) * xInterval / 2
  local bMax = self.hero:isTreeMax()
  local isBlack = self.hero:isBlackHero()
  local isMengJing = self.hero:isMengJingHero()
  local isShengcan = self.hero:isShengcanHero()
  if isShengcan then
    for index = 1, temStar do
      display.newSprite(globalRes .. (bMax and "star_tree_red.png" or "star.png")):pos(xBegin + (index - 1) * xInterval, 172):addTo(self)
    end
  else
    for index = 1, temStar do
      display.newSprite(globalRes .. (bMax and (isBlack and "star_tree_black.png" or "star_tree.png") or isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png")):pos(xBegin + (index - 1) * xInterval, 172):addTo(self)
    end
  end
  if 5 <= self.hero.loveBreak then
    local kuang = display.newSprite(globalRes .. "big_card_middle_marry.png"):center(self):addTo(self)
    local sweep = UIHelper.loadAnimation(heroRes, "sweep", 30, 15)
    sweep.sprite:center(kuang):addTo(kuang)
    sweep.sprite:setBlendFunc(cc.blendFunc(gl.ONE, gl.ONE))
    sweep.sprite:playAnimationForever(sweep.animation, 2)
  elseif self.hero.loveBreak == 4 and self.hero.love == EffectCsv[4].fullValue then
    self.heart = display.newSprite(globalRes .. "heart.png"):anch(0.5, 0):pos(35, 410):addTo(self)
    self.heart:runAction(cc.RepeatForever:create(transition.sequence({
      cc.RotateBy:create(0.05, -10),
      cc.RotateBy:create(0.1, 20),
      cc.RotateBy:create(0.1, -20),
      cc.RotateBy:create(0.05, 10),
      cc.DelayTime:create(2)
    })))
  end
  local proTag = UIHelper.getProfessionTag(self.unitData.profession, quality, 16, self.hero:showTreeTag()):pos(142, 485):addTo(self)
  if self.hero.formation ~= 0 then
    local formatBg = display.newSprite(globalRes .. "title_bg.png"):pos(45, 487):addTo(self)
    local xPos = self.hero.formation == 4 and 17 or 18
    display.newTTFLabel({
      text = self.hero.formation,
      size = 24,
      color = display.COLOR_WHITE
    }):enableOutline(display.COLOR_BLACK, 1):pos(xPos, 21):addTo(formatBg)
    display.newTTFLabel({
      text = "套餐",
      size = 18,
      color = display.COLOR_WHITE
    }):enableOutline(display.COLOR_BLACK, 1):pos(60, 20):addTo(formatBg)
    if self.captain then
      display.newSprite(globalRes .. "captain.png"):anch(0, 0.5):pos(-7, 462):addTo(self)
    end
  end
  local level = self.hero.level or 0
  if 0 < level then
    local isAdvanceMax = self.hero:isSauceAdvanceMax()
    display.newTTFLabel({
      text = "Lv" .. level,
      size = 18,
      color = UIHelper.hex2rgb(isAdvanceMax and "#0afff1" or "#000000")
    }):anch(0, 0):pos(10, 92):addTo(self):enableOutline(UIHelper.hex2rgb(isAdvanceMax and "#000000" or "#ffffff"), isAdvanceMax and 1 or 2)
    display.newTTFLabel({
      text = "生命",
      size = 16,
      color = display.COLOR_BLACK
    }):enableOutline(display.COLOR_WHITE, 2):anch(0, 0):pos(10, 72):addTo(self)
    display.newTTFLabel({
      text = string.format("美味度: %d", self.hero:getAllValue() or 0),
      size = 16,
      color = display.COLOR_BLACK
    }):enableOutline(display.COLOR_WHITE, 2):anch(0, 0):pos(10, 48):addTo(self):name("battleValue")
    local expBarBg = display.newSprite(globalRes .. "expBar_bg.png"):anch(1, 0.5):pos(152, 102):addTo(self)
    local expBar = display.newProgressTimer(globalRes .. "expBar.png", 1):center(expBarBg):addTo(expBarBg)
    expBar:setMidpoint(cc.p(0, 0.5))
    expBar:setBarChangeRate(cc.p(1, 0))
    if self.hero.level >= self.hero:getLevelLimit() then
      expBar:setPercentage(100)
    else
      expBar:setPercentage(self.hero.exp / HeroExpCsv[self.hero.level].exp * 100)
    end
    local hpBarBg = display.newSprite(globalRes .. "hpBar_bg.png"):anch(1, 0.5):pos(152, 80):addTo(self):name("hpBarBg")
    local hpBar = display.newProgressTimer(globalRes .. "hpBar.png", 1):center(hpBarBg):addTo(hpBarBg)
    hpBar:setMidpoint(cc.p(0, 0.5))
    hpBar:setBarChangeRate(cc.p(1, 0))
    hpBar:setPercentage(self.hpPercent / 10)
    display.newTTFLabel({
      text = string.format("%d/%d", hp, attrValues.hp),
      size = 14,
      color = display.COLOR_WHITE
    }):enableOutline(display.COLOR_BLACK, 1):pos(52, 9):addTo(hpBarBg):name("hpText")
    for i = 1, 2 do
      local value = self.hero["material" .. i]
      local image = 40 < value and "kuang_4.png" or "kuang_3.png"
      local bg = display.newSprite(globalRes .. "kuang_1.png"):pos(35 + (i - 1) * 65, 26):addTo(self)
      local baseBg = display.newProgressTimer(battleRes .. image, display.PROGRESS_TIMER_RADIAL)
      baseBg:center(bg):addTo(bg)
      baseBg:setPercentage(value)
      baseBg:setScaleX(-1)
      display.newSprite(battleRes .. "kuang_2.png"):center(baseBg):addTo(baseBg)
      display.newSprite(string.format("ui/global/base_%d.png", i)):scale(0.75):center(baseBg):addTo(baseBg)
      display.newTTFLabel({
        text = math.floor(self.hero:getCailiao(i)),
        size = 18,
        color = display.COLOR_BLACK
      }):enableOutline(display.COLOR_WHITE, 2):pos(65 + (i - 1) * 65, 26):addTo(self)
    end
  end
  local name = display.newTTFLabel({
    text = self.hero:getName(),
    size = 18,
    color = self.isSpecial and UIHelper.hex2rgb("#ea1313") or display.COLOR_BLACK
  }):pos(size.width / 2, 135):enableOutline(display.COLOR_WHITE, 2):addTo(self)
  local nameWidth = name:getContentSize().width
  if nameWidth > size.width - 10 then
    name:scale((size.width - 10) / nameWidth)
  end
  if self.hero.fragment then
    UIHelper.setImageViewGray(self, 10)
  end
  if self.clickCallback then
    self:setCallback(self.clickCallback)
    self:setSwallowTouches(false)
  end
  self.tagNode = display.newNode():addTo(self)
  local tagStatus = self.hero:getState()
  if tagStatus[1] then
    display.newSprite(globalRes .. "treat_2.png"):pos(81, 212):addTo(self.tagNode)
  elseif tagStatus[2] then
    display.newSprite(globalRes .. "battle_2.png"):pos(81, 212):addTo(self.tagNode)
  elseif tagStatus[3] then
    display.newSprite(globalRes .. "entrust_2.png"):pos(81, 212):addTo(self.tagNode)
  end
  if self.detail then
    local look = UIHelper.extend(ccui.Button:create())
    look:setImages("ui/global/", {"look.png", "look.png"})
    look:pos(138, 213):addTo(self)
    look:setTouchScale()
    look:setCallback(function()
      if self.selectedState ~= 0 then
        return
      end
      self.detail()
    end)
  end
  self.infoLayer = UIHelper.newImageView(heroRes .. "mengban.png"):anch(0, 0):pos(-5, 0):addTo(self)
  self.infoLayer:setTouchEnabled(true)
  self.infoLayer:setSwallowTouches(true)
  self:showInfo(0)
end

function TeamHeroCard:showInfo(state)
  state = state or self.selectedState
  self.infoLayer:removeAllChildren()
  self.infoLayer:hide()
  self.tagNode:hide()
  if state == 0 then
    self.tagNode:show()
  elseif state == 1 then
    self.infoLayer:show()
    self:showFormatInfo()
  elseif state == 2 then
    self.infoLayer:show()
    self:showEquipInfo()
  elseif state == 3 then
    self.infoLayer:show()
    self:showAttrInfo()
  elseif state == 4 then
    self.infoLayer:show()
    self:showSauceInfo()
  end
  self.selectedState = state
end

function TeamHeroCard:showFormatInfo()
  local yPos = 470
  local xPos = 10
  local result = game.role:getFormationRelation(self.hero.formation)
  local effect = result[self.unitData.profession]
  if effect then
    local interval = 5 < #effect and 25 or 30
    for index, data in pairs(effect) do
      local nameLabel = display.newTTFLabel({
        text = data.name,
        size = 18,
        color = UIHelper.hex2rgb("#26cd06")
      }):anch(0, 1):pos(xPos, yPos):addTo(self.infoLayer)
      yPos = yPos - nameLabel:getContentSize().height - 6
      local descLabel = MRichText.new({
        text = data.desc,
        size = 16,
        color = UIHelper.hex2rgb("#d5d5d5"),
        maxWidth = 150
      }):anch(0, 1):pos(xPos, yPos):addTo(self.infoLayer)
      yPos = yPos - descLabel:getContentSize().height - 12
    end
  else
    display.newTTFLabel({
      text = "无装盘加成",
      size = 18,
      color = display.COLOR_WHITE
    }):anch(0, 1):pos(xPos, yPos):addTo(self.infoLayer)
  end
end

function TeamHeroCard:showEquipInfo()
  local yPos = 470
  local xPos = 10
  local suitId = self.hero:isSuitAcitve(true)
  if suitId and suitId ~= 0 then
    local suitData = SuitCsv[suitId]
    local nameLabel = display.newTTFLabel({
      text = suitData.name,
      size = 18,
      color = UIHelper.hex2rgb("#26cd06")
    }):anch(0, 1):pos(xPos, yPos):addTo(self.infoLayer)
    yPos = yPos - nameLabel:getContentSize().height - 6
    for i = 1, 3 do
      local desc = suitData["desc" .. i]
      local descLabel = MRichText.new({
        text = desc,
        size = 16,
        color = UIHelper.hex2rgb("#d5d5d5"),
        maxWidth = 150
      }):anch(0, 1):pos(xPos, yPos):addTo(self.infoLayer)
      yPos = yPos - descLabel:getContentSize().height - 4
    end
  end
  yPos = 275
  local emptySlots = self.hero:getCanEquip()
  local equips = self.hero.equips:toNumMap()
  for slot = 1, 3 do
    local equipId = equips[slot]
    display.newSprite(heroRes .. "line.png"):pos(95, yPos):addTo(self.infoLayer)
    display.newSprite(string.format("ui/hero/equip%d.png", slot)):pos(40, yPos - 45):addTo(self.infoLayer)
    local content = UIHelper.newImageView(heroRes .. "lock_bg.png"):pos(110, yPos - 42):addTo(self.infoLayer):name(self:getName() .. "_equip" .. slot)
    if not equipId then
      display.newSprite(globalRes .. (emptySlots[slot] and "equip_add_2.png" or "equip_add_1.png")):center(content):addTo(content)
    else
      local equipIcon = self:getEquipIcon(equipId):center(content):addTo(content)
    end
    yPos = yPos - 85
    content:setCallback(function()
      self:showEquipDetail(slot, equipId)
    end)
  end
end

function TeamHeroCard:getEquipIcon(equipId)
  local equip = game.role.equips[equipId]
  local icon = display.newSprite(heroRes .. "equip_small_bg.png")
  display.newSprite(string.format("ui/global/bg_%d.png", equip.csvData.star - 2)):scale(0.8):center(icon):addTo(icon)
  display.newSprite(equip.csvData.cardIcon):scale(0.75):center(icon):addTo(icon)
  display.newSprite(heroRes .. "equip_small_frame.png"):center(icon):addTo(icon)
  return icon
end

function TeamHeroCard:showEquipDetail(slot, equipId)
  if not CommonHelper.funcOpen("equip") then
    SysError(SYS_ERR_FUNCOPEN_EQUIP)
    return
  end
  
  local function rule(equip)
    if self.hero.level < equip.csvData.level then
      return true
    end
    return false
  end
  
  local barType, barText = TopBar:getShowType()
  local layer = game:createView("equip.EquipWearLayer", {
    profession = slot,
    heroId = self.hero.id,
    rule = rule,
    equipId = equipId,
    callback = function(choose, part, callback)
      local states = self.hero:getState()
      if states[2] or states[3] then
        SysError(SYS_ERR_EQUIP_HERO_WEAR_LOCK)
        return true
      end
      if choose ~= 0 then
        local equip = game.role.equips[choose]
        if part ~= equip.csvData.profession then
          SysError(SYS_ERR_EQUIP_TYPE_NOT_FIT)
          return true
        end
        if self.hero.level < equip.csvData.level then
          SysError(SYS_ERR_EQUIP_HERO_LEVEL_LOW)
          return true
        end
        local hero = game.role.heros[equip.masterId]
        if hero then
          states = hero:getState()
          if states[2] or states[3] then
            SysError(SYS_ERR_EQUIP_HERO_WEAR_LOCK)
            return true
          end
        end
      end
      local heroId = self.hero.id
      game:sendData(actionCodes.Equip_wearEquipRpc, MsgPack.pack({
        equipId = choose,
        part = part,
        heroId = heroId
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Equip_wearEquipRpc, function(event)
        UIHelper.removeWaiting()
        if self.guideStep and self.guideStep == 10009 then
          NewGuideLayer.new({
            step = 10009,
            majorGuideStep = 10009,
            minorGuideStep = 28
          })
        end
        if tolua.isnull(self) then
          return
        end
        self.hero = game.role.heros[heroId]
        local text = self:getChildByName("battleValue")
        text:setString(string.format("美味度: %d", self.hero:getAllValue()))
        local newAttr = self.hero:getTotalAttrValues()
        local hp = newAttr.hp * self.hpPercent / 1000
        hp = self.hpPercent > 500 and math.floor(hp) or math.ceil(hp)
        local barBg = self:getChildByName("hpBarBg")
        local hpText = barBg:getChildByName("hpText")
        hpText:setString(string.format("%d/%d", hp, newAttr.hp))
        if callback then
          callback()
        end
        if self.refresh then
          self.refresh()
        end
      end)
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(barType, barText)
    local backBtn = TopBar:getBackBtn():getChildByName("heroListBack")
    if backBtn then
      backBtn:show()
    end
  end)
end

function TeamHeroCard:showAttrInfo()
  local totalAttr = self.hero:getTotalAttrValues()
  local baseAttr = self.hero:getTotalAttrValues({skipEquip = true, skipSauce = true})
  local yPos = 170
  local xPos = 15
  for index = 1, 7 do
    local name = AttsEnumEx[index]
    display.newTTFLabel({
      text = AttrDesc[index] .. ":",
      size = 18
    }):anch(0, 0):pos(xPos, yPos):addTo(self.infoLayer)
    local attr = display.newTTFLabel({
      text = totalAttr[name],
      size = 18
    }):anch(0, 0):pos(xPos + 50, yPos):addTo(self.infoLayer)
    local delta = math.ceil(totalAttr[name] - baseAttr[name])
    if 0 < delta then
      display.newTTFLabel({
        text = string.format("(+%d)", delta),
        size = 16,
        color = UIHelper.hex2rgb("#2aff00")
      }):pos(attr:getPositionX() + attr:getContentSize().width + 2, yPos):anch(0, 0):addTo(self.infoLayer)
    end
    yPos = yPos - 20
  end
end

function TeamHeroCard:showSauceInfo()
  local bg = UIHelper.newImageView("ui/sauce/card/card_top_bg.png"):pos(87, 110):addTo(self.infoLayer)
  if self.hero.sauce and self.hero.sauce ~= 0 then
    SauceIcon.new({
      id = self.hero.sauce,
      big = true
    }):center(bg):addTo(bg)
    bg:setCallback(function()
      self:showSauceDetail()
    end)
  elseif self.hero:getCanEquipSauce() then
    UIHelper.newImageView("ui/equip/reforge/add.png"):pos(58, 75):addTo(bg)
    display.newTTFLabel({
      text = "添加酱料",
      size = 18,
      color = UIHelper.hex2rgb("#b5f831")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(58, 25):addTo(bg)
    bg:setCallback(function()
      self:showSauceDetail()
    end)
  else
    UIHelper.newImageView("ui/sauce/card/image_cook.png"):pos(58, 75):addTo(bg)
    display.newTTFLabel({
      text = "暂无可用酱料",
      size = 18,
      color = UIHelper.hex2rgb("#bdafa2")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(56, 25):addTo(bg)
  end
end

function TeamHeroCard:showSauceDetail()
  if not CommonHelper.funcOpen("sauce") then
    SysError(SYS_ERR_FUNCOPEN_EQUIP)
    return
  end
  local states = self.hero:getState()
  if states[1] or states[2] or states[3] then
    SysError(SYS_ERR_EQUIP_HERO_WEAR_LOCK)
    return true
  end
  
  local function rule(sauce)
    if sauce.masterId and sauce.masterId ~= 0 then
      local hero = game.role.heros[sauce.masterId]
      if hero then
        local states = hero:getState()
        if states[1] or states[2] or states[3] then
          return true
        end
      end
    end
    return false
  end
  
  local barType, barText = TopBar:getShowType()
  local layer = game:createView("sauce.SauceWearLayer", {
    rule = rule,
    sauceId = self.hero.sauce,
    heroId = self.hero.id,
    callback = function(choose, callback)
      game:sendData(actionCodes.Sauce_wearRpc, MsgPack.pack({
        id = choose,
        heroId = self.hero.id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Sauce_wearRpc, function(event)
        UIHelper.removeWaiting()
        if tolua.isnull(self) then
          return
        end
        if callback then
          callback()
        end
        if self.refresh then
          self.refresh()
        end
      end)
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(barType, barText)
    local backBtn = TopBar:getBackBtn():getChildByName("heroListBack")
    if backBtn then
      backBtn:show()
    end
  end)
end

function TeamHeroCard:checkLock()
  local heroId = self.hero.id
  self.hero = game.role.heros[heroId]
  local lock = self:getChildByName("lock")
  if self.hero.lock == 1 and not lock then
    display.newSprite(globalRes .. "lock.png"):anch(0, 0.5):pos(10, 450):addTo(self):name("lock")
  end
  if self.hero.lock == 0 and lock then
    lock:removeSelf()
  end
end

function TeamHeroCard:reflashCard()
  self:removeAllChildren()
  local heroId = self.hero.id
  self.hero = game.role.heros[heroId]
  self.type = self.hero:getDressType()
  self.unitData = UnitDataSet[self.type]
  self:uiLayout()
end

function TeamHeroCard:checkCard()
  local dressId = self.hero:getDressType()
end

function TeamHeroCard:checkBattle()
  local valueText = self:getChildByName("battleValue")
  valueText:setString(string.format("美味度: %d", self.hero:getAllValue() or 0))
end

return TeamHeroCard
