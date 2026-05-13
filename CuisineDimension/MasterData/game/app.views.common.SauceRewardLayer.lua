local SauceCsv = require("csvdata.sauce")
local GlobalRes = "ui/global/"
local RewardRes = "ui/common/reward/"
local SauceRewardLayer = class("SauceRewardLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function SauceRewardLayer:ctor(params)
  self.params = params or {}
  self.countType = params.countType or 1
  self.showSkip = params.showSkip or false
  self.skipFunc = params.skipFunc
  self:uiLayout(params)
end

function SauceRewardLayer:uiLayout(params)
  local width = display.width
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
  end
  self:size(cc.size(width, display.height))
  self:setTouchEnabled(true)
  self:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  if self.countType == 1 then
    self.unitData = SauceCsv[params.type]
    self:showEffect1(self.unitData.rare)
  else
    self:showEffect2()
  end
  if not tolua.isnull(TopBar) then
    self.topbar = {
      TopBar:getShowType()
    }
  end
end

function SauceRewardLayer:showEffect1(star)
  local scale = 2
  if UIHelper.isiPhoneX() then
    scale = scale * UIHelper.getScaleForX()
  end
  if star <= 2 then
    display.newSprite(RewardRes .. "bg_gray.png"):scale(scale):center(self):addTo(self)
  elseif star == 3 then
    display.newSprite(RewardRes .. "bg_blue.png"):scale(scale):center(self):addTo(self)
  elseif star == 4 then
    display.newSprite(RewardRes .. "bg_purple.png"):scale(scale):center(self):addTo(self)
  elseif star == 5 then
    display.newSprite(RewardRes .. "bg_gold.png"):scale(scale):center(self):addTo(self)
    display.newSprite(RewardRes .. "bandian.png"):scale(scale):center(self):addTo(self)
  end
  display.newSprite(RewardRes .. "xiexian.png"):scale(scale):center(self):addTo(self):runAction(cc.RepeatForever:create(cc.RotateBy:create(45, 360)))
  local fieldScale = star <= 2 and 3 or 4
  self.field = display.newSprite(RewardRes .. "mofazhen.png"):scale(fieldScale):center(self):addTo(self)
  self.field:runAction(cc.Spawn:create({
    cc.FadeTo:create(0.5, 204),
    cc.ScaleTo:create(0.5, fieldScale / 2)
  }))
  self.field:runAction(cc.RepeatForever:create(cc.RotateBy:create(60, 360)))
  if 4 <= star then
    local cycler = cc.ParticleSystemQuad:create(RewardRes .. "cycler.plist")
    cycler:setPositionType(cc.POSITION_TYPE_RELATIVE)
    cycler:pos(display.cx, display.cy):addTo(self)
  end
  if star == 5 then
    local ring = cc.ParticleSystemQuad:create(RewardRes .. "ring.plist")
    ring:setPositionType(cc.POSITION_TYPE_RELATIVE)
    ring:pos(display.cx, display.cy):addTo(self)
  end
  self.nameBg = display.newSprite(RewardRes .. "name_bg.png"):anch(0, 0):pos(0, display.height - 78):addTo(self, 0)
  display.newTTFLabel({
    text = self.unitData.name,
    size = 36,
    color = UIHelper.hex2rgb("#000000")
  }):anch(0, 0.5):pos(60, 26):addTo(self.nameBg):enableOutline(UIHelper.hex2rgb("#ffffff"), 3)
  display.newSprite(RewardRes .. string.format("pro_%d.png", self.unitData.profession)):anch(0, 0.5):pos(5, 27):addTo(self.nameBg)
  self:runAction(transition.sequence({
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      local equip = display.newSprite(self.unitData.cardName):center(self):addTo(self)
      equip:setOpacity(0)
      equip:runAction(cc.FadeIn:create(0.5))
    end),
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      self:setCallback(function()
        self:exit()
      end)
    end)
  }))
  self:runAction(transition.sequence({
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      local card = display.newSprite(self.unitData.image .. ".png"):center(self):addTo(self)
      card:setOpacity(0)
      card:runAction(cc.FadeIn:create(0.3))
    end),
    cc.DelayTime:create(0.1),
    cc.CallFunc:create(function()
      local card = display.newSprite(self.unitData.image .. ".png"):scale(0.4):pos(self:getContentSize().width - 450, 100):addTo(self)
      card:setOpacity(0)
      card:runAction(cc.FadeIn:create(0.3))
    end),
    cc.DelayTime:create(0.1),
    cc.CallFunc:create(function()
      display.newSprite(RewardRes .. "arrow.png"):pos(self:getContentSize().width - 355, 90):addTo(self)
      local card = display.newSprite(self.unitData.image .. "_2.png"):scale(0.4):pos(self:getContentSize().width - 275, 100):addTo(self)
      card:setOpacity(0)
      card:runAction(cc.FadeIn:create(0.3))
    end),
    cc.DelayTime:create(0.1),
    cc.CallFunc:create(function()
      display.newSprite(RewardRes .. "arrow.png"):pos(self:getContentSize().width - 193, 90):addTo(self)
      local card = display.newSprite(self.unitData.image .. "_3.png"):scale(0.4):pos(self:getContentSize().width - 100, 100):addTo(self)
      card:setOpacity(0)
      card:runAction(cc.FadeIn:create(0.3))
    end),
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      self:setCallback(function()
        self:exit()
      end)
    end)
  }))
  self.nameBg:setCascadeOpacityEnabled(true)
  UIHelper.MoveToRight({
    node = self.nameBg,
    delay = 1
  })
  if self.showSkip then
    local btnSkip = UIHelper.newImageView(RewardRes .. "btn_skip.png"):pos(display.width - 75, 605):addTo(self):setLocalZOrder(101)
    btnSkip:setCallback(function()
      self.skipFunc()
      self:exit()
    end)
  end
end

function SauceRewardLayer:showEffect2()
  local star = 0
  for _, sauceType in pairs(self.params.sauces) do
    if star < SauceCsv[sauceType].rare then
      star = SauceCsv[sauceType].rare
    end
  end
  local scale = 2
  if UIHelper.isiPhoneX() then
    scale = scale * UIHelper.getScaleForX()
  end
  if star <= 2 then
    display.newSprite(RewardRes .. "bg_gray.png"):scale(scale):center(self):addTo(self)
  elseif star == 3 then
    display.newSprite(RewardRes .. "bg_green.png"):scale(scale):center(self):addTo(self)
  elseif star == 4 then
    display.newSprite(RewardRes .. "bg_purple.png"):scale(scale):center(self):addTo(self)
  elseif star == 5 then
    display.newSprite(RewardRes .. "bg_gold.png"):scale(scale):center(self):addTo(self)
    display.newSprite(RewardRes .. "bandian.png"):scale(scale):center(self):addTo(self)
  end
  display.newSprite(RewardRes .. "xiexian.png"):scale(scale):center(self):addTo(self):runAction(cc.RepeatForever:create(cc.RotateBy:create(45, 360)))
  local fieldScale = star <= 2 and 3 or 4
  self.field = display.newSprite(RewardRes .. "mofazhen.png"):scale(fieldScale):center(self):addTo(self)
  self.field:runAction(cc.Spawn:create({
    cc.FadeTo:create(0.5, 204),
    cc.ScaleTo:create(0.5, fieldScale / 2)
  }))
  self.field:runAction(cc.RepeatForever:create(cc.RotateBy:create(60, 360)))
  if 4 <= star then
    local cycler = cc.ParticleSystemQuad:create(RewardRes .. "cycler.plist")
    cycler:setPositionType(cc.POSITION_TYPE_RELATIVE)
    cycler:pos(display.cx, display.cy):addTo(self)
  end
  if star == 5 then
    local ring = cc.ParticleSystemQuad:create(RewardRes .. "ring.plist")
    ring:setPositionType(cc.POSITION_TYPE_RELATIVE)
    ring:pos(display.cx, display.cy):addTo(self)
  end
  local bg = display.newSprite(RewardRes .. "sauces_bg.png"):center(self):addTo(self)
  local index = 1
  local max = table.nums(self.params.sauces)
  local yPos = 5 < max and 250 or 190
  local xPos = 5 <= max and 185 or 410 - (max - 1) / 2 * 120
  local temp = xPos
  
  local function create()
    local icon = ItemIcon.new({
      type = ItemStartId.sauce + self.params.sauces[index],
      showTip = true
    }):scale(0.3):pos(xPos, yPos):addTo(bg)
    local effect = UIHelper.loadAnimation(RewardRes, "show", 21, 15)
    effect.sprite:center(icon):addTo(icon)
    effect.sprite:playAnimationOnce(effect.animation, true)
    icon:runAction(cc.ScaleTo:create(0.2, 1))
    xPos = xPos + 120
    if index == 5 then
      xPos = temp
      yPos = yPos - 130
    end
    index = index + 1
  end
  
  self:runAction(transition.sequence({
    cc.Repeat:create(transition.sequence({
      cc.CallFunc:create(function()
        create()
      end),
      cc.DelayTime:create(0.15)
    }), max),
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      self:setCallback(function()
        self:exit()
      end)
    end)
  }))
end

function SauceRewardLayer:exit()
  CommonHelper.stopCV()
  if self.topbar then
    TopBar:show(self.topbar[1], self.topbar[2], self.topbar[3])
  end
  if self.countType == 1 then
    self.params.callback()
  end
  self:removeFromParent()
end

return SauceRewardLayer
