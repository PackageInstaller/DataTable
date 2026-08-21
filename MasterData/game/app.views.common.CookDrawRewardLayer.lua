local GlobalRes = "ui/global/"
local RewardRes = "ui/common/reward/"
local ItemCsv = require("csvdata.item")
local CookDrawRewardLayer = class("CookDrawRewardLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function CookDrawRewardLayer:ctor(params)
  self.params = params or {}
  self:uiLayout(params)
end

function CookDrawRewardLayer:uiLayout(params)
  local width = display.width
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
  end
  self:size(cc.size(width, display.height))
  self:setTouchEnabled(true)
  self:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  self:showEffect(params)
end

function CookDrawRewardLayer:showEffect(params)
  local star = params.star
  local scale = 2
  if UIHelper.isiPhoneX() then
    scale = scale * UIHelper.getScaleForX()
  end
  if star <= 2 then
    display.newSprite(RewardRes .. "bg_gray.png"):scale(scale):center(self):addTo(self)
  elseif star == 3 then
    display.newSprite(RewardRes .. "bg_green.png"):scale(scale):center(self):addTo(self)
  elseif star == 4 then
    display.newSprite(RewardRes .. "bg_blue.png"):scale(scale):center(self):addTo(self)
  elseif 5 <= star then
    display.newSprite(RewardRes .. "bg1.png"):scale(scale):center(self):addTo(self)
    display.newSprite(RewardRes .. "bg2.png"):scale(scale):center(self):addTo(self):opacity(0):runAction(cc.RepeatForever:create(transition.sequence({
      cc.FadeIn:create(6),
      cc.FadeOut:create(6)
    })))
    local bg3 = display.newSprite(RewardRes .. "bg3.png"):scale(scale):center(self):addTo(self):opacity(0)
    bg3:runAction(transition.sequence({
      cc.DelayTime:create(3),
      cc.CallFunc:create(function()
        bg3:runAction(cc.RepeatForever:create(transition.sequence({
          cc.FadeIn:create(6),
          cc.FadeOut:create(6)
        })))
      end)
    }))
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
  local xPos, yPos = 100, 255
  if #params.items > 10 then
    yPos = 295
  end
  
  local function create()
    local icon
    if not params.items or not params.items[index] then
      return
    end
    local item = ItemCsv[params.items[index].id]
    icon = ItemIcon.new({
      type = item.itemId,
      count = params.items[index].count,
      showTip = true
    }):scale(0.3):pos(xPos, yPos):addTo(bg)
    local effect = UIHelper.loadAnimation(RewardRes, "show", 21, 15)
    effect.sprite:center(icon):addTo(icon)
    effect.sprite:playAnimationOnce(effect.animation, true)
    if item.star == 5 then
      local flash = UIHelper.loadAnimation(RewardRes, "gold", 30, 30)
      flash.sprite:pos(43, 51):addTo(icon)
      flash.sprite:playAnimationForever(flash.animation)
    elseif item.star == 4 then
      local flash = UIHelper.loadAnimation(RewardRes, "reward_blue", 30, 30)
      flash.sprite:pos(43, 51):addTo(icon)
      flash.sprite:playAnimationForever(flash.animation)
    elseif item.star == 6 then
      local flash = UIHelper.loadAnimation(RewardRes, "rainbow", 30, 30)
      flash.sprite:pos(43, 51):addTo(icon)
      flash.sprite:playAnimationForever(flash.animation)
    end
    icon:runAction(cc.ScaleTo:create(0.2, 1))
    xPos = xPos + 155
    if index % 5 == 0 then
      xPos = 100
      if #params.items > 10 then
        yPos = yPos - 105
      else
        yPos = yPos - 155
      end
    end
    index = index + 1
  end
  
  self:runAction(transition.sequence({
    cc.Repeat:create(transition.sequence({
      cc.CallFunc:create(function()
        create()
      end),
      cc.DelayTime:create(0.15)
    }), #params.items),
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      self:setCallback(function()
        self:exit()
      end)
    end)
  }))
end

function CookDrawRewardLayer:exit()
  CommonHelper.stopCV()
  self:removeFromParent()
end

return CookDrawRewardLayer
