local EquipCsv = require("csvdata.equip")
local ItemCsv = require("csvdata.item")
local FixRes = "ui/equip/fix/"
local uiData = {
  csbFile = "ui/equip/EquipFixLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    mainBg2 = "mainBg2",
    angel1 = "angel1",
    angel2 = "angel2",
    buttom = "buttom",
    fixBtn = "mainBg1/fixBtn",
    mainBg3 = "mainBg1/mainBg3",
    cardNode = "mainBg1/cardNode",
    node5 = "mainBg2/ren/node5",
    circle1 = "mainBg2/circle1",
    circle2 = "mainBg2/circle2",
    circle3 = "mainBg2/circle3"
  }
}
local EquipFixLayer = class("EquipFixLayer", UIBase)

function EquipFixLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local function rule(equip)
  local allDura = EquipCsv[equip.type].durability
  if allDura > equip.durability then
    return false
  end
  return true
end

function EquipFixLayer:init(params)
  self.cards = {}
  for index = 1, 3 do
    local speed = index == 2 and 360 or -360
    self["circle" .. index]:runAction(cc.RepeatForever:create(cc.RotateBy:create(10, speed)))
  end
  self.spine = UIHelper.createSpineNodeByRes("ui/equip/fix/repair"):addTo(self.node5)
  self.spine:setAnimation(0, "moren", true)
  local itemNum = game.role.items[501] or 0
  self.num5 = display.newTTFLabel({
    text = string.format("%d/%d", itemNum, 0),
    size = 18,
    color = UIHelper.hex2rgb(0 <= itemNum and "2dff7c" or "ff4b2d")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, -25):addTo(self.node5)
  self.mainBg3:setCallback(function()
    self:showChooseEquip()
  end)
  self.fixBtn:setTouchScale()
  self.fixBtn:setCallback(function()
    if not next(self.cards) then
      SysError(SYS_ERR_EQUIP_CHOOSE_FIRST)
      return
    end
    if (game.role.items[501] or 0) < self.cost then
      SysError(SYS_ERR_EQUIP_FIX_MATERIAL_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Equip_repairEquipRpc, MsgPack.pack({
      list = self.cards
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Equip_repairEquipRpc, function(event)
      UIHelper.removeWaiting()
      self.cards = {}
      self.node5:runAction(transition.sequence({
        cc.CallFunc:create(function()
          self.fixBtn:setTouchEnabled(false)
          self.mainBg3:setTouchEnabled(false)
          self.spine:setAnimation(0, "repair", false)
        end),
        cc.DelayTime:create(2.5),
        cc.CallFunc:create(function()
          self:createCard()
        end),
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          self.fixBtn:setTouchEnabled(true)
          self.mainBg3:setTouchEnabled(true)
          self.spine:setAnimation(0, "moren", true)
          local bg = display.newSprite(FixRes .. "success_bg.png"):pos(505, 300):addTo(self)
          display.newSprite(FixRes .. "success.png"):center(bg):addTo(bg)
          bg:setOpacity(0)
          bg:setCascadeOpacityEnabled(true)
          bg:runAction(transition.sequence({
            cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 25)), cc.FadeIn:create(0.2)),
            cc.DelayTime:create(0.5),
            cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 25)), cc.FadeOut:create(0.2)),
            cc.RemoveSelf:create()
          }))
        end)
      }))
    end)
  end)
  UIHelper.MoveToRight({
    node = self.mainBg2
  })
  UIHelper.MoveToLeft({
    node = self.mainBg1
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
end

function EquipFixLayer:showData(params)
  self:createCard()
end

function EquipFixLayer:createCard()
  self.cardNode:removeAllChildren()
  self.cost = 0
  if next(self.cards) then
    local num = table.nums(self.cards)
    if 10 < num then
      num = 10
    end
    local index, dalt = 0, math.floor(150 / num)
    for equipId, _ in pairs(self.cards) do
      local card = EquipSmallCard.new({equipId = equipId}):pos(index * dalt, 0):addTo(self.cardNode)
      local equip = game.role.equips[equipId]
      local cost = equip:getRepairCost()
      self.cost = self.cost + cost
      if 9 <= index then
        break
      end
      index = index + 1
    end
  else
    display.newSprite(FixRes .. "unknown.png"):addTo(self.cardNode)
  end
  local itemNum = game.role.items[501] or 0
  self.num5:setString(string.format("%d/%d", itemNum, self.cost))
  self.num5:setTextColor(UIHelper.hex2rgb(itemNum >= self.cost and "2dff7c" or "ff4b2d"))
end

function EquipFixLayer:showChooseEquip()
  local layer = game:createView("equip.ChooseEquipLayer", {
    multiChoose = true,
    choosedList = self.cards,
    fix = true,
    rule = rule,
    callback = function(list)
      self.cards = list
    end
  })
  BackManager:push(function()
    layer:close()
    self:createCard()
  end)
end

return EquipFixLayer
