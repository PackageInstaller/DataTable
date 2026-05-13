local UnitDataSet = require("csvdata.unit")
local DressCsv = require("csvdata.hero_skin")
local globalRes = "ui/global/"
local formatRes = "ui/equip/format/"
local TeamEquipCard = class("TeamEquipCard", function()
  return UIHelper.extend(ccui.ImageView:create())
end)

function TeamEquipCard:ctor(params)
  self.clickCallback = params.callback
  self.detail = params.detail
  self.refresh = params.refresh
  self.normal = params.normal or "equip"
  self.hero = game.role.heros[params.heroId]
  self.type = self.hero:getDressType()
  self.unitData = UnitDataSet[self.type]
  self:uiLayout()
end

function TeamEquipCard:uiLayout()
  self.equipBg = {}
  local quality = self.hero.quality
  local big = self.hero.hpPercent <= 300
  self:setImage(string.format(globalRes .. "big_card_bg_%d.png", quality))
  local size = self:getContentSize()
  display.newSprite(UIHelper.getCardRes("list", self.type, big, self.hero.quality)):center(self):addTo(self)
  display.newSprite(string.format(globalRes .. "big_card_middle_%d.png", quality)):center(self):addTo(self)
  local proTag = UIHelper.getProfessionTag(self.unitData.profession, quality, 16, self.hero:showTreeTag()):pos(142, 485):addTo(self)
  if self.hero.lock == 1 then
    display.newSprite(globalRes .. "lock.png"):anch(0, 0.5):pos(10, 450):addTo(self):name("lock")
  end
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
    if self.hero.captain then
      display.newSprite(globalRes .. "captain.png"):anch(0, 0.5):pos(-7, 462):addTo(self)
    end
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
      display.newSprite(globalRes .. (bMax and (isBlack and "star_tree_black.png" or "star_tree.png") or isMengJing and "star_extra.png" or "star.png")):pos(xBegin + (index - 1) * xInterval, 172):addTo(self)
    end
  end
  if self.hero.fragment then
    UIHelper.setImageViewGray(self, 10)
  end
  if self.clickCallback then
    self:setCallback(self.clickCallback)
    self:setSwallowTouches(false)
  end
  self.tagNode = display.newNode():addTo(self)
  if self.detail then
    local look = UIHelper.extend(ccui.Button:create())
    look:setImages(globalRes, {"look.png", "look.png"})
    look:pos(138, 213):addTo(self)
    look:setTouchScale()
    look:setCallback(function()
      self.detail()
    end)
  end
  local tagStatus = self.hero:getState()
  if tagStatus[1] then
    display.newSprite(globalRes .. "treat_2.png"):pos(81, 212):addTo(self.tagNode)
  elseif tagStatus[2] then
    display.newSprite(globalRes .. "battle_2.png"):pos(81, 212):addTo(self.tagNode)
  elseif tagStatus[3] then
    display.newSprite(globalRes .. "entrust_2.png"):pos(81, 212):addTo(self.tagNode)
  end
  if self.normal == "equip" then
    local xPos, yPos, dalt = 47, 116, 68
    for index = 1, 4 do
      local image = UIHelper.newImageView(formatRes .. "image_1.png"):pos(xPos, yPos):addTo(self)
      display.newSprite(formatRes .. "image_2.png"):center(image):addTo(image)
      xPos = xPos + dalt
      if index == 2 then
        xPos = 47
        yPos = yPos - dalt
      end
      self.equipBg[index] = image
    end
    self:showEquips()
  elseif self.normal == "sauce" then
    local image = UIHelper.newImageView("ui/sauce/card/card_top_bg.png"):pos(81, 80):addTo(self)
    self.equipBg[1] = image
    self:showSauces()
  end
end

function TeamEquipCard:showEquips()
  local Parts = self.hero:getCanEquip()
  for part, bg in ipairs(self.equipBg) do
    if part == 4 then
      return
    end
    bg:removeAllChildren()
    local equipId = self.hero.equips:getv(part, 0)
    if equipId ~= 0 then
      EquipIcon.new({id = equipId}):scale(0.7):center(bg):addTo(bg)
    else
      local image = Parts[part] and "green.png" or "grey.png"
      display.newSprite(formatRes .. image):center(bg):addTo(bg)
    end
    bg:setCallback(function()
      self:showEquipDetail(part, equipId)
    end)
  end
end

function TeamEquipCard:showSauces()
  local bg = self.equipBg[1]
  bg:removeAllChildren()
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

function TeamEquipCard:showSauceDetail()
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
  end)
end

function TeamEquipCard:showEquipDetail(slot, equipId)
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
            minorGuideStep = 26
          })
        end
        if tolua.isnull(self) then
          return
        end
        self.hero = game.role.heros[heroId]
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

function TeamEquipCard:reflashCard()
  self:removeAllChildren()
  local heroId = self.hero.id
  self.hero = game.role.heros[heroId]
  self.type = self.hero:getDressType()
  self.unitData = UnitDataSet[self.type]
  self:uiLayout()
end

return TeamEquipCard
