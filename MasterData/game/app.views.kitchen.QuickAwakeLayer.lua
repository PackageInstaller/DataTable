local AwakenCsv = require("csvdata.awaken")
local MainRes = "ui/kitchen/main/"
local awakeRes = "ui/hero/awake/"
local qulaityRes = "ui/kitchen/quality/"
local globalRes = "ui/global/"
local awakeRes = "ui/hero/awake/"
local uiData = {
  csbFile = "ui/kitchen/QuickAwakeLayer.csb",
  widgets = {
    mainBg = "mainBg",
    btnInfo = "btnInfo",
    buttom = "buttom",
    angel1 = "angel1",
    angel2 = "angel2"
  }
}
local QuickAwakeLayer = class("QuickAwakeLayer", UIBase)

function QuickAwakeLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function QuickAwakeLayer:init(params)
  self.mainChooseCards = {}
  self.mainSelectHeros = {}
  self.chooseList = {}
  self.conditions = {}
  self.awakeInfo = {}
  self.addBgs = {}
  self.btnInfo:hide()
  self:ChooseMainHero()
end

function QuickAwakeLayer:showData()
end

function QuickAwakeLayer:ChooseMainHero()
  for star = 3, 5 do
    local card = self:createAddMainHero(star)
    self.mainChooseCards[star] = card
  end
end

function QuickAwakeLayer:createAddMainHero(star)
  local card = UIHelper.newImageView(qulaityRes .. "bg_1.png")
  UIHelper.newImageView(globalRes .. "item_frame.png"):center(card):addTo(card)
  UIHelper.newImageView(globalRes .. "add.png"):pos(46, 53):addTo(card)
  card:pos(280, 360 - (star - 3) * 130):addTo(self.mainBg)
  local desc = display.newTTFLabel({
    text = "添加食灵",
    size = 14,
    color = UIHelper.hex2rgb("#b3a27e")
  }):pos(45, 25):addTo(card)
  local desc = display.newTTFLabel({
    text = string.format("选择%d星食灵", star),
    size = 16
  }):pos(45, -10):addTo(card)
  card:setCallback(function()
    self:chooseMainAwakeHero(star)
  end)
  return card
end

function QuickAwakeLayer:chooseMainAwakeHero(star)
  local function rule(hero)
    local awakeData = AwakenCsv[hero.type] or nil
    
    if not awakeData then
      return true
    end
    if hero.unit.star ~= star then
      return true
    end
    local awake = hero.awake or 0
    if awake >= #awakeData then
      return true
    end
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    rule = rule,
    star = star,
    type = 20,
    callback = function(choose)
      local hero = game.role.heros[choose]
      self.mainSelectHeros[star] = hero
      local cardView = self.mainChooseCards[star]
      if cardView then
        cardView:removeAllChildren()
        local card1 = HeroHead.new({
          heroId = hero.id,
          loveEffect = true
        })
        card1:center(cardView):addTo(cardView)
        cardView:setCallback(function()
          self:chooseMainAwakeHero(star)
        end)
      end
      local awakeData = AwakenCsv[hero.type]
      self:ChooseHeroCondition(awakeData[hero.awake + 1], hero, star)
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "食灵")
  end)
end

function QuickAwakeLayer:ChooseHeroCondition(data, hero, star)
  self.chooseList[star] = {}
  self.conditions[star] = {}
  if self.awakeInfo[star] then
    for _, item in pairs(self.awakeInfo[star]) do
      item:removeSelf()
    end
  end
  self.awakeInfo[star] = {}
  if self.addBgs[star] then
    for _, bg in pairs(self.addBgs[star]) do
      bg:removeSelf()
    end
  end
  self.addBgs[star] = {}
  local costTable = data.cost:toTableArray()
  local xPos = 630 - (#costTable - 1) / 2 * 105
  for idx, _data in ipairs(costTable) do
    local limits = {
      lType = tonumber(_data[1]) == 0 and 0 or data.id,
      lStar = tonumber(_data[2]),
      lWake = tonumber(_data[3]),
      lNum = tonumber(_data[4]),
      heroStar = star
    }
    self.conditions[star][idx] = limits
    self.chooseList[star][idx] = {}
    self.addBgs[star][idx] = display.newSprite(awakeRes .. "add_mask.png"):pos(xPos, 380 - (star - 3) * 130):addTo(self.mainBg)
    xPos = xPos + 105
  end
  self:showAwakeBtn(hero, data, star)
  self:showChooseUI(hero, data, star)
end

function QuickAwakeLayer:showAwakeBtn(hero, data, star)
  local desc = display.newTTFLabel({
    text = string.format("已觉醒%d阶", hero.awake),
    size = 16
  }):pos(400, 360 - (star - 3) * 130):addTo(self.mainBg)
  local awakeBtn = UIHelper.newImageView(awakeRes .. "btn.png"):scale(0.8):pos(940, 360 - (star - 3) * 130):addTo(self.mainBg)
  table.insert(self.awakeInfo[star], desc)
  table.insert(self.awakeInfo[star], awakeBtn)
  awakeBtn:setCallback(function()
    if hero.awake >= data.stage then
      SysError(SYS_ERR_HERO_AWAKE_STAGE_SUCCESS)
      return
    end
    if not self:checkAwakeCost(hero, star) then
      return
    end
    local heros = ""
    for _, list in ipairs(self.chooseList[star]) do
      local temp = {}
      for heroId, _ in pairs(list) do
        table.insert(temp, heroId)
      end
      heros = heros .. " " .. table.concat(temp, "=")
    end
    game:sendData(actionCodes.Hero_awakeUpRpc, MsgPack.pack({
      cost = heros,
      id = hero.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Hero_awakeUpRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_HERO_AWAKE_SUCCESS)
      for idx, _ in pairs(self.conditions[star]) do
        self.chooseList[star][idx] = {}
      end
      if self.mainChooseCards[star] then
        self.mainChooseCards[star]:removeSelf()
        local card = self:createAddMainHero(star)
        self.mainChooseCards[star] = card
      end
      for _, bg in pairs(self.addBgs[star]) do
        bg:removeSelf()
      end
      self.addBgs[star] = {}
      self.conditions[star] = {}
      self.chooseList[star] = {}
      desc:removeSelf()
      awakeBtn:removeSelf()
    end)
  end)
end

function QuickAwakeLayer:showChooseUI(hero, data, star)
  for idx, limits in ipairs(self.conditions[star]) do
    local bg = self.addBgs[star][idx]
    bg:removeAllChildren()
    local card, descText
    if limits.lType == data.id then
      card = HeroHead.new({
        heroId = hero.id,
        level = 0,
        quality = 0
      }):addTo(bg)
      descText = "同名卡"
    else
      card = UIHelper.newImageView(string.format("%s%d.png", awakeRes, hero.unit.profession)):addTo(bg)
      descText = "同职业"
      if 0 < limits.lStar then
        descText = descText .. string.format("%d星", limits.lStar)
        local xBegin = card:getContentSize().width / 2 - (limits.lStar - 1) * 14 / 2
        for index = 1, limits.lStar do
          UIHelper.newImageView("ui/global/small_star.png"):pos(xBegin + (index - 1) * 14, 11):addTo(card)
        end
      end
    end
    if 0 < limits.lWake then
      display.newSprite(string.format("%sawake%d.png", awakeRes, self:getAwakeLogoIndex(hero, limits.lWake, limits.lStar))):pos(-25, 25):addTo(bg)
      if hero.awake == 2 and 2 <= limits.lWake and idx == 3 then
        descText = descText .. "2/3觉"
      else
        descText = descText .. string.format("%d觉", limits.lWake)
      end
    end
    local slot = idx
    card:setCallback(function()
      if hero.awake >= data.stage then
        SysError(SYS_ERR_HERO_AWAKE_STAGE_SUCCESS)
        return
      end
      
      local function rule(_hero)
        if hero.id == _hero.id or _hero.lock == 1 then
          return true
        end
        if self:checkHasChooseHero(_hero.id) then
          return true
        end
        for i, list in pairs(self.chooseList[limits.heroStar]) do
          if i ~= slot and self.chooseList[limits.heroStar][i][_hero.id] then
            return true
          end
        end
        if limits.lWake == 0 and _hero.unit.type == 97 then
          return false
        end
        if limits.lType ~= 0 and _hero.unit.type ~= limits.lType then
          return true
        end
        if _hero.unit.profession ~= hero.unit.profession then
          return true
        end
        if limits.lWake < 2 then
          if limits.lWake ~= _hero.awake then
            return true
          end
        elseif limits.lWake > _hero.awake then
          return true
        end
        if limits.lStar ~= 0 and _hero.unit.star ~= limits.lStar then
          return true
        end
      end
      
      local layer = game:createView("hero.ChooseAwakeHeroNewLayer", {
        num = limits.lNum,
        rule = rule,
        list = self.chooseList[limits.heroStar][slot],
        callback = function(choose)
          for heroId, _ in pairs(choose) do
            local hero = game.role.heros[heroId]
            if not hero then
              return
            end
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
          if not self.chooseList[limits.heroStar] then
            self.chooseList[limits.heroStar] = {}
          end
          self.chooseList[limits.heroStar][slot] = {}
          for heroId, _ in pairs(choose) do
            self.chooseList[limits.heroStar][slot][heroId] = slot
          end
          self:showChooseUI(hero, data, star)
          return false
        end
      })
      BackManager:push(function()
        layer:close()
        TopBar:show(TopBarType.full, "食灵资料")
      end)
    end)
    descText = descText .. string.format("%d个", limits.lNum)
    local label = display.newTTFLabel({text = descText, size = 16}):pos(0, -55):addTo(bg)
    if label:getContentSize().width > 90 then
      label:setScaleX(90 / label:getContentSize().width)
    end
    display.newTTFLabel({
      text = string.format("%d/%d", table.nums(self.chooseList[limits.heroStar][idx]), limits.lNum),
      size = 20
    }):pos(0, -72):addTo(bg)
    if table.nums(self.chooseList[limits.heroStar][idx]) == 0 then
      UIHelper.newImageView(awakeRes .. "btn_add.png"):pos(33, 32):addTo(bg)
    end
  end
end

function QuickAwakeLayer:getAwakeLogoIndex(hero, wakeLv, star)
  local startSet = {
    [3] = {4},
    [4] = {2, 4},
    [5] = {
      2,
      3,
      4
    }
  }
  return startSet[star or hero.unit.star][wakeLv or hero.awake] or 1
end

function QuickAwakeLayer:checkHasChooseHero(id)
  for star, list1 in pairs(self.chooseList) do
    for idx, list in pairs(list1) do
      for heroId, _ in pairs(list) do
        if heroId == id then
          return true
        end
      end
    end
  end
  return false
end

function QuickAwakeLayer:checkAwakeCost(mainHero, star)
  for idx, limits in pairs(self.conditions[star]) do
    local list = self.chooseList[star][idx]
    if table.nums(list) < limits.lNum then
      SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
      return
    end
    for heroId, _ in pairs(list) do
      local hero = game.role.heros[heroId]
      if not hero then
        SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
        return
      end
      local bType, bStar, bWake, bPro
      if limits.lWake == 0 and hero.unit.type == 97 then
        bType, bStar, bWake, bPro = true, true, true, true
      else
        bStar = hero.unit.star == limits.lStar
        bWake = hero.awake >= limits.lWake
        bPro = hero.unit.profession == mainHero.unit.profession
        if limits.lType == 1 then
          bType = hero.unit.type == mainHero.unit.type
        else
          bType = true
        end
      end
      if not (bType and bStar and bWake) or not bPro then
        SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
        return
      end
    end
  end
  return true
end

return QuickAwakeLayer
