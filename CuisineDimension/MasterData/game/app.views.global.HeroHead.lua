local HeroRes = "ui/hero/"
local GlobalRes = "ui/global/"
local unitDataSet = require("csvdata.unit")
local evolutionSet = require("csvdata.evolution")
local ItemCsv = require("csvdata.item")
local awakeCsv = require("csvdata.awaken")
local HeroHead = class("HeroHead", function()
  return UIHelper.extend(ccui.ImageView:create())
end)

function HeroHead:ctor(params)
  self:initData(params)
  if params.special then
    self:uiLayoutSpecial()
  else
    self:uiLayout()
  end
  if params.callback then
    self:setTouchEnabled(true)
    self:setCallback(params.callback)
  end
end

function HeroHead:initData(params)
  self.hero = {}
  self.bMax = params.treeMax and params.treeMax == 1 or false
  self.sauceMax = params.sauceMax
  self.showTreeTag = params.showTreeTag or false
  self.level = params.level or self.hero.level or 0
  if params.heroId then
    local realhero = game.role.heros[params.heroId]
    self.sauceMax = realhero:isSauceAdvanceMax()
    self.bMax = realhero:isTreeMax()
    for key, value in pairs(realhero) do
      self.hero[key] = value
    end
    self.hero.type = realhero:getDressType()
  end
  for key, value in pairs(params) do
    self.hero[key] = value
  end
  self.unitData = unitDataSet[self.hero.type]
  self.isBlack = globalCsv.blackHeroUnitIds[self.unitData.type] == 1
  self.isMengJing = globalCsv.mengJingHeroUnitIds[self.unitData.type] == 1
  self.isShengcan = globalCsv.shengcanHeroUnitIds[self.unitData.type] == 1
  self.quality = self.hero.quality or params.quality or 0
  if params.showTalkTip then
    self:setCallback(function()
      MTip:show({
        node = self,
        type = MTipType.item,
        itemData = {
          name = self.unitData.name,
          desc = self.unitData.name .. evolutionSet[self.quality].desc
        }
      })
    end)
  elseif params.showTip then
    self:setCallback(function()
      MTip:show({
        node = self,
        type = MTipType.item,
        itemData = {
          name = self.unitData.name,
          desc = self.unitData.name .. ItemCsv[self.unitData.type + ItemStartId.hero].desc
        }
      })
    end)
  end
end

function HeroHead:uiLayout()
  self:setImage(string.format("ui/global/bg_%d.png", self.quality))
  local size = self:getContentSize()
  local star = self.unitData.star
  UIHelper.getClipNode({
    steRes = "ui/global/mask_1.png",
    clipRes = UIHelper.getCardRes("book", self.unitData.type, nil, self.hero.quality)
  }):scale(0.7):center(self):addTo(self)
  UIHelper.newImageView("ui/global/star_bg.png"):pos(size.width / 2, 11):addTo(self)
  UIHelper.newImageView(string.format("ui/global/frame_%d.png", self.quality)):center(self):addTo(self)
  if self.hero.loveEffect and (self.hero.loveBreak or 0) >= 5 then
    local sweep = UIHelper.loadAnimation(GlobalRes, "hero_item_love_effect", 30, 15)
    sweep.sprite:center(self):addTo(self)
    sweep.sprite:setBlendFunc(cc.blendFunc(gl.ONE, gl.ONE))
    sweep.sprite:runAction(cc.RepeatForever:create(transition.sequence({
      cc.DelayTime:create(1),
      cc.Animate:create(sweep.animation),
      cc.DelayTime:create(1)
    })))
  end
  local proBg = UIHelper.newImageView(string.format("ui/global/profession_bg_%d.png", self.quality)):scale(0.8):pos(78, 77):addTo(self)
  local imageName = self.showTreeTag and "ui/global/profession_s_%d.png" or "ui/global/profession_%d.png"
  UIHelper.newImageView(string.format(imageName, self.unitData.profession)):center(proBg):addTo(proBg)
  if 0 < star then
    local xInterval = 14
    local temStar = math.min(star, 5)
    local xBegin = size.width / 2 - (temStar - 1) * xInterval / 2
    if self.isShengcan then
      for index = 1, temStar do
        UIHelper.newImageView(GlobalRes .. (self.bMax and "small_star_tree_red.png" or "small_star.png")):pos(xBegin + (index - 1) * xInterval, 11):addTo(self)
      end
    else
      for index = 1, temStar do
        UIHelper.newImageView(GlobalRes .. (self.bMax and (self.isBlack and "small_star_tree_black.png" or "small_star_tree.png") or self.isMengJing and "small_star_extra.png" or self.isBlack and "small_star_black.png" or "small_star.png")):pos(xBegin + (index - 1) * xInterval, 11):addTo(self)
      end
    end
  end
  local level = self.level
  if 0 < level then
    UIHelper.newText({
      text = string.format("Lv%d", level),
      size = 18,
      color = UIHelper.hex2rgb(self.sauceMax and "#0afff1" or "#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 1):pos(5, size.height - 1):addTo(self)
  end
  local tempid = self.hero.type % 10000
  if 999 < tempid then
    tempid = (tempid - tempid % 10) / 10
  end
  if awakeCsv[tempid] then
    local awakeLogoPath = self.hero.id and CommonHelper.getAwakeTypePath(self.hero.id) or CommonHelper.getAwakeNoTypePath(1, tempid, self.hero.awake, unitDataSet[tempid].star)
    if awakeLogoPath then
      display.newSprite(string.format("ui/hero/awake/awake%d_s.png", awakeLogoPath)):pos(77, 45):addTo(self)
    end
  end
end

function HeroHead:uiLayoutSpecial()
  self:setImage(string.format("ui/global/bg_%d.png", self.quality))
  local size = self:getContentSize()
  local star = self.unitData.star
  UIHelper.getClipNode({
    steRes = "ui/global/mask_1.png",
    clipRes = UIHelper.getCardRes("book", self.unitData.type, nil, self.hero.quality)
  }):scale(0.7):center(self):addTo(self)
  UIHelper.newImageView("ui/global/star_bg.png"):pos(size.width / 2, 11):addTo(self)
  UIHelper.newImageView("ui/global/item_frame.png"):center(self):addTo(self)
  if self.hero.loveEffect and (self.hero.loveBreak or 0) >= 5 then
    local sweep = UIHelper.loadAnimation(GlobalRes, "hero_item_love_effect", 30, 15)
    sweep.sprite:center(self):addTo(self)
    sweep.sprite:setBlendFunc(cc.blendFunc(gl.ONE, gl.ONE))
    sweep.sprite:runAction(cc.RepeatForever:create(transition.sequence({
      cc.DelayTime:create(1),
      cc.Animate:create(sweep.animation),
      cc.DelayTime:create(1)
    })))
  end
  local proBg = UIHelper.newImageView(string.format("ui/global/profession_bg_%d.png", 6)):scale(0.8):pos(78, 77):addTo(self)
  UIHelper.newImageView(string.format("ui/global/profession_%d.png", self.unitData.profession)):center(proBg):addTo(proBg)
  if 0 < star then
    local xInterval = 14
    local temStar = math.min(star, 5)
    local xBegin = size.width / 2 - (temStar - 1) * xInterval / 2
    for index = 1, temStar do
      UIHelper.newImageView(GlobalRes .. (self.isMengJing and "small_star_extra.png" or self.isBlack and "small_star_black.png" or "small_star.png")):pos(xBegin + (index - 1) * xInterval, 11):addTo(self)
    end
  end
  local level = self.hero.level or 0
  if 0 < level then
    UIHelper.newText({
      text = string.format("Lv%d", level),
      size = 18,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 1):pos(5, size.height - 1):addTo(self)
  end
end

return HeroHead
