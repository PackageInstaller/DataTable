local unitCsv = require("csvdata.unit")
local evolutionCsv = require("csvdata.evolution")
local awakenCsv = require("csvdata.awaken")
local starCsv = require("csvdata.star")
local specialCsv = require("csvdata.skill_special")
local ItemCsv = require("csvdata.item")
local qulaityRes = "ui/kitchen/quality/"
local blockCsv = require("csvdata.skill_block")
local MagicRes = "ui/activity/23/"
local heroRes = "ui/hero/detail/"
local qulaityRes = "ui/kitchen/quality/"
local globalRes = "ui/global/"
local uiData = {
  csbFile = "ui/sauce/SauceTransferLayer.csb",
  widgets = {
    mainBg = "mainBg",
    leftBg = "leftBg",
    circleBg1 = "leftBg/circleBg",
    bigCircle1 = "leftBg/bigCircle",
    heroNode1 = "leftBg/leftNode",
    rightBg = "rightBg",
    circleBg2 = "rightBg/circleBg",
    bigCircle2 = "rightBg/bigCircle",
    heroNode2 = "rightBg/rightNode",
    btnTran = "btnTran",
    btnInfo = "btnInfo",
    buttom = "buttom",
    angel1 = "angel1",
    angel2 = "angel2"
  }
}
local AwakeLayer = class("AwakeLayer", UIBase)

function AwakeLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function AwakeLayer:init(params)
  self.bigCircle1:runAction(cc.RepeatForever:create(cc.RotateBy:create(30, -360)))
  self.bigCircle2:runAction(cc.RepeatForever:create(cc.RotateBy:create(30, -360)))
  self.action = {false, false}
  self.hero = {nil, nil}
end

function AwakeLayer:showData(params)
  for i = 1, 2 do
    self:showMainHero(i)
  end
  self.btnTran:setImages("ui/hero/awake/", {"btn_1.png", "btn_1.png"})
  self.btnTran:setCallback(function()
    self:awakeBtnClick()
  end)
  self.btnInfo:setTouchScale()
  self.btnInfo:setCallback(function()
    UIHelper.showOnleImgTip("ui/hero/awake/info_1.png")
  end)
  self.itemReset = globalCsv.resetAwake:toArray("=", true)
  display.newSprite("ui/equip/fix/source_bg_2.png"):pos(530, 455):addTo(self.buttom)
  display.newSprite(ItemCsv[self.itemReset[1]].icon):scale(0.5):pos(530, 455):addTo(self.buttom)
  local itemNum = game.role.items[self.itemReset[1]] or 0
  self.ItemContent = display.newTTFLabel({
    text = string.format("%d/%d", itemNum, self.itemReset[2]),
    size = 28,
    color = UIHelper.hex2rgb(itemNum >= self.itemReset[2] and "2dff7c" or "ff4b2d")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(530, 395):addTo(self.buttom)
end

function AwakeLayer:showMainHero(index)
  if index ~= 1 and index ~= 2 then
    return
  end
  local txtContext = {
    "被重置食灵",
    "接受继承食灵"
  }
  local hero = self.hero and self.hero[index] or nil
  local action = self.action[index]
  local heroNode = index == 1 and self.heroNode1 or self.heroNode2
  heroNode:removeAllChildren()
  if index == 1 and hero or index == 2 and self.hero and self.hero[1] and self.hero[2] then
    local card = self:createHeroCard(index)
    if action then
      card:anch(0.5, 0.5):pos(0, -50):addTo(heroNode)
      card:setCascadeOpacityEnabled(true)
      card:setOpacity(0)
      card:runAction(cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 50)), cc.FadeIn:create(0.2)))
    else
      card:anch(0.5, 0.5):addTo(heroNode)
    end
    card:name("card")
    card:setCallback(function()
      if action then
        return
      end
      self:showChooseHero(index)
    end)
  else
    display.newTTFLabel({
      text = txtContext[index],
      size = 22,
      color = UIHelper.hex2rgb("#b4f730")
    }):pos(-2, -40):addTo(heroNode)
    local btn = UIHelper.newImageView("ui/equip/reforge/add.png"):pos(0, 16):addTo(heroNode)
    btn:setCallback(function()
      self:showChooseHero(index)
    end)
  end
end

function AwakeLayer:createHeroCard(index)
  local unitData = unitCsv[self.hero[index]:getDressType()]
  local quality = self.hero[index].quality
  local attrValues = self.hero[index]:getTotalAttrValues()
  local hp = attrValues.hp * self.hero[index].hpPercent / 1000
  hp = self.hero[index].hpPercent > 500 and math.floor(hp) or math.ceil(hp)
  local big = self.hero[index].hpPercent <= 300
  local content = UIHelper.newImageView(globalRes .. string.format("small_card_bg_%d.png", quality))
  UIHelper.newImageView(UIHelper.getCardRes("book", unitData.type, big, quality)):scale(0.92):pos(content:getContentSize().width / 2, 146):addTo(content)
  local starBg = UIHelper.newImageView(string.format(globalRes .. "star_bg_%d.png", quality)):pos(98, 85):addTo(content)
  starBg:setCascadeOpacityEnabled(true)
  local star, xInterval = self.hero[index].unit.star, 20
  local xBegin = starBg:getContentSize().width / 2 - (star - 1) * xInterval / 2 + 1
  local bMax = self.hero[index]:isTreeMax()
  local isBlack = self.hero[index]:isBlackHero()
  local isShengcan = self.hero[index]:isShengcanHero()
  if isShengcan then
    for index = 1, star do
      UIHelper.newImageView(globalRes .. (bMax and "star_tree_red.png" or "star.png")):pos(xBegin + (index - 1) * xInterval, 14):addTo(starBg)
    end
  else
    for index = 1, star do
      UIHelper.newImageView(globalRes .. (bMax and (isBlack and "star_tree_black.png" or "star_tree.png") or isBlack and "star_black.png" or "star.png")):pos(xBegin + (index - 1) * xInterval, 14):addTo(starBg)
    end
  end
  local marryBg = display.newSprite(globalRes .. "small_card_marry_bg.png"):center(content):addTo(content)
  marryBg:setCascadeOpacityEnabled(true)
  if self.hero[index].loveBreak >= 5 then
    display.newSprite(globalRes .. "small_card_marry.png"):center(marryBg):addTo(marryBg)
  end
  UIHelper.newText({
    text = "食灵: " .. self.hero[index]:getName(),
    size = 16,
    color = UIHelper.hex2rgb("#000000")
  }):pos(15, 59):enableOutline(UIHelper.hex2rgb("#ffffff"), 1):anch(0, 0.5):addTo(content)
  UIHelper.newText({
    text = "美味度: " .. self.hero[index]:getAllValue(),
    size = 16,
    color = UIHelper.hex2rgb("#000000")
  }):pos(15, 40):enableOutline(UIHelper.hex2rgb("#ffffff"), 1):anch(0, 0.5):addTo(content)
  local isAdvanceMax = self.hero[index]:isSauceAdvanceMax()
  UIHelper.newText({
    text = string.format("Lv: %d", self.hero[index].level),
    size = 24,
    color = UIHelper.hex2rgb(isAdvanceMax and "#0afff1" or "#000000")
  }):enableOutline(UIHelper.hex2rgb(isAdvanceMax and "#000000" or "#ffffff"), isAdvanceMax and 1 or 2):anch(0, 0.5):pos(15, 23):addTo(content)
  local awakeLogoPath = CommonHelper.getAwakeTypePath(self.hero[index].id)
  if awakeLogoPath then
    display.newSprite(string.format("ui/hero/awake/awake%d.png", awakeLogoPath)):pos(170, 109):addTo(content)
  end
  local pro = UIHelper.getProfessionTag(self.hero[index].unit.profession, quality, 18, self.hero[index]:showTreeTag()):scale(0.9):pos(176, 193):addTo(content)
  pro:setCascadeOpacityEnabled(true)
  content:scale(1.1)
  return content
end

function AwakeLayer:showChooseHero(index)
  local function rule(hero)
    if hero.id == (self.hero and self.hero[index] and self.hero[index].id or 0) then
      return true
    end
    if index == 1 and 1 > hero.awake then
      return true
    end
    if not (index ~= 2 or self.hero[1]) or index == 2 and self.hero[1].type ~= hero.type then
      return true
    end
    if not awakenCsv[hero.type] then
      return true
    end
    if self.hero[1] and index == 2 and self.hero[1].awake <= hero.awake then
      return true
    end
    return false
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    rule = rule,
    type = 10,
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
      self.btnTran:show()
      self.hero[index] = hero
      self:showMainHero(index)
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "食灵")
  end)
end

function AwakeLayer:awakeBtnClick()
  if self.action[1] or self.action[2] then
    return
  end
  if not (self.hero and self.hero[1]) or not self.hero[2] then
    SysError(SYS_ERR_HERO_USE_INHERIT)
    return
  end
  if self.hero[2].awake > self.hero[1].awake then
    SysError(SYS_ERR_HERO_USED_AWAKE_TOHIGH)
    return
  end
  if self.hero[1].type ~= self.hero[2].type then
    SysError(SYS_ERR_HERO_USED_AWAKE_NOTSAMETYPE)
    return
  end
  if self.hero[1].id == self.hero[2].id then
    SysError(SYS_ERR_QUALITY_SAUCE_COUNT_NOT_ENOUGH)
    return
  end
  self.action = {true, true}
  if not game.role.items[self.itemReset[1]] or game.role.items[self.itemReset[1]] < self.itemReset[2] then
    SysError(SYS_ERR_QUALITY_SAUCE_COUNT_NOT_ENOUGH)
    return
  end
  game:sendData(actionCodes.Hero_awakeRpc, MsgPack.pack({
    heros = {
      [1] = self.hero[1].id,
      [2] = self.hero[2].id
    }
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Hero_awakeRpc, function(event)
    UIHelper.removeWaiting()
    game:playMusic(1102)
    self.heroNode1:runAction(transition.sequence({
      cc.CallFunc:create(function()
        self:showBigCardAnimation()
      end),
      cc.DelayTime:create(0.5)
    }))
    self.ItemContent:setString(string.format("%d/%d", game.role.items[self.itemReset[1]] or 0, self.itemReset[2]))
  end)
end

function AwakeLayer:showBigCardAnimation()
  local magic = UIHelper.loadAnimation(qulaityRes, "quality_magic", 28, 30)
  magic.sprite:center(self.circleBg1):addTo(self.circleBg1)
  magic.sprite:playAnimationOnce(magic.animation, false)
  local card = self.heroNode1:getChildByName("card")
  local mask = display.newSprite(qulaityRes .. "mask.png"):anch(0.5, 0):pos(0, -152):addTo(self.heroNode1, 10)
  mask:setOpacity(0)
  self.circleBg1:runAction(transition.sequence({
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
          local newCard = self:createHeroCard(1)
          newCard:anch(0.5, 0.5):pos(0, 0):addTo(self.heroNode1)
          newCard:setCascadeOpacityEnabled(true)
          newCard:runAction(transition.sequence({
            cc.DelayTime:create(1),
            cc.FadeOut:create(1),
            cc.CallFunc:create(function()
              self:showMainHero(1)
              self:showMainHero(2)
              self.hero = {nil, nil}
              self.action = {false, false}
            end)
          }))
          magic.sprite:runAction(transition.sequence({
            cc.FadeOut:create(0.2),
            cc.RemoveSelf:create()
          }))
          local effect = UIHelper.loadAnimation(qulaityRes, "quality_bigbox", 24, 30)
          effect.sprite:anch(0.5, 0):pos(0, -152):addTo(self.heroNode1, 5)
          effect.sprite:playAnimationOnce(effect.animation, true)
        end),
        cc.RemoveSelf:create()
      }))
    end)
  }))
end

return AwakeLayer
