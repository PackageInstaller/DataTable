local GlobalRes = "ui/global/"
local RewardRes = "ui/common/reward/"
local EquipRewardLayer = class("EquipRewardLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function EquipRewardLayer:ctor(params)
  self.params = params or {}
  self.countType = params.countType or 1
  self.unitData = game.role.equips[params.type].csvData
  self:uiLayout(params)
end

function EquipRewardLayer:uiLayout(params)
  local width = display.width
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
  end
  self:size(cc.size(width, display.height))
  self:setTouchEnabled(true)
  self:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  if self.countType == 1 then
    self:showEffect1(self.unitData.star)
  else
    self:showEffect2(self.unitData.star)
  end
  if not tolua.isnull(TopBar) then
    self.topbar = {
      TopBar:getShowType()
    }
  end
end

function EquipRewardLayer:showEffect1(star)
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
  elseif star == 5 then
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
  self.nameBg = display.newSprite(RewardRes .. "name_bg.png"):anch(0, 0):pos(0, display.height - 78):addTo(self, 0)
  display.newTTFLabel({
    text = self.unitData.name,
    size = 24,
    color = UIHelper.hex2rgb("#000000")
  }):pos(135, 22):addTo(self.nameBg)
  display.newSprite(RewardRes .. "circle_bg.png"):anch(0.5, 0):pos(19, 2):addTo(self.nameBg)
  display.newSprite(GlobalRes .. string.format("profession_equip_%d.png", self.unitData.profession)):anch(0.5, 0):pos(19, 0):addTo(self.nameBg)
  display.newSprite(RewardRes .. string.format("pro_equip_%d.png", self.unitData.profession)):anch(0, 1):pos(6, 2):addTo(self.nameBg)
  local star, xInterval = self.unitData.star, 30
  local xBegin = 138 - (star - 1) * xInterval / 2
  for index = 1, star do
    display.newSprite(RewardRes .. "star.png"):pos(xBegin + (index - 1) * xInterval, -19):addTo(self.nameBg)
  end
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
  self.nameBg:setCascadeOpacityEnabled(true)
  UIHelper.MoveToRight({
    node = self.nameBg,
    delay = 1
  })
end

function EquipRewardLayer:showEffect2()
  local star = 0
  for _, equipId in pairs(self.params.equips) do
    if star < game.role.equips[equipId].star then
      star = game.role.equips[equipId].star
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
    display.newSprite(RewardRes .. "bg_blue.png"):scale(scale):center(self):addTo(self)
  elseif star == 5 then
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
  local bg = display.newSprite(RewardRes .. "equips_bg.png"):center(self):addTo(self)
  local index = 1
  local xPos, yPos = 110, 355
  
  local function create()
    local icon
    if index < 11 then
      local equip = game.role.equips[self.params.equips[index]]
      icon = ItemIcon.new({
        type = (equip.type > 1000 and ItemStartId.newEquip or ItemStartId.equip) + equip.type,
        showTip = true,
        equipId = equip.id
      }):scale(0.3):pos(xPos, yPos):addTo(bg)
    else
      icon = ItemIcon.new({
        type = 501,
        count = 10,
        showTip = true
      }):scale(0.3):pos(420, 75):addTo(bg)
    end
    local effect = UIHelper.loadAnimation(RewardRes, "show", 21, 15)
    effect.sprite:center(icon):addTo(icon)
    effect.sprite:playAnimationOnce(effect.animation, true)
    if index < 11 and game.role.equips[self.params.equips[index]].star == 5 then
      local flash = UIHelper.loadAnimation(RewardRes, "flash", 20, 15)
      flash.sprite:pos(43, 51):addTo(icon)
      flash.sprite:playAnimationForever(flash.animation)
    end
    icon:runAction(cc.ScaleTo:create(0.2, 1))
    xPos = xPos + 155
    if index == 5 then
      xPos = 110
      yPos = yPos - 155
    end
    index = index + 1
  end
  
  self:runAction(transition.sequence({
    cc.Repeat:create(transition.sequence({
      cc.CallFunc:create(function()
        create()
      end),
      cc.DelayTime:create(0.15)
    }), 11),
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      self:setCallback(function()
        self:exit()
      end)
    end)
  }))
end

function EquipRewardLayer:exit()
  CommonHelper.stopCV()
  if self.topbar then
    TopBar:show(self.topbar[1], self.topbar[2], self.topbar[3])
  end
  if self.countType == 1 then
    self.params.callback1()
  end
  self:removeFromParent()
end

return EquipRewardLayer
