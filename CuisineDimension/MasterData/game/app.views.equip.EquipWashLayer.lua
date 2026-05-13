local EquipCsv = require("csvdata.equip")
local ReforgeCsv = require("csvdata.equip_reforge")
local reforgeRes = "ui/equip/reforge/"
local detailRes = "ui/hero/detail/"
local uiData = {
  csbFile = "ui/equip/EquipWashLayer.csb",
  mask = true,
  popup = true,
  maskClick = function()
    BackManager:pop()
  end,
  widgets = {
    equipNode = "popAction/equipNode",
    expNode = "popAction/expNode",
    ok = "popAction/ok",
    text2 = "popAction/Text2"
  }
}
local EquipWashLayer = class("EquipWashLayer", UIBase)

function EquipWashLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function EquipWashLayer:init(params)
  local equip = game.role.equips[params.equipId]
  self.ok:setTouchScale()
  self.ok:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.ok:setCallback(function()
    local cur = game.role.items[523] or 0
    local need = ReforgeCsv[equip.star].cost
    if cur < need then
      UIHelper.showGiftTip({
        type = 1,
        parent = self,
        callback = function()
          self:showData(params)
        end
      })
      return
    end
    game:sendData(actionCodes.Equip_resetEquipRpc, MsgPack.pack({
      equipId = equip.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Equip_resetEquipRpc, function(event)
      UIHelper.removeWaiting()
      game:playMusic(1200)
      self.ok:setTouchEnabled(false)
      self:showAnimation(params)
    end)
  end)
end

function EquipWashLayer:showData(params)
  self.bars = {}
  self.equipNode:removeAllChildren()
  self.expNode:removeAllChildren()
  local equip = game.role.equips[params.equipId]
  local cur = game.role.items[523] or 0
  local need = ReforgeCsv[equip.star].cost
  local equipData = EquipCsv[equip.type]
  self.text2:setString("重置装备改造次数，并达到最大值")
  local color = cur >= need and "#599d01" or "#cd5106"
  local str = string.format("需要消耗 <div color=%s>%d/%d</div><img src='ui/equip/reforge/m_3.png' />完成再铸", color, cur, need)
  MRichText.new({
    text = str,
    size = 24,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(90, 0):addTo(self.equipNode)
  EquipIcon.new({
    id = params.equipId,
    big = true
  }):addTo(self.equipNode)
  for index = 1, equip.washLimit do
    local xPos = (index - 1) * 70
    local bg = display.newSprite(reforgeRes .. "bar_bg.png"):anch(0, 0.5):pos(xPos, -2):addTo(self.expNode)
    local bar = display.newProgressTimer(reforgeRes .. "bar.png", 1):center(bg):addTo(bg)
    bar:setMidpoint(cc.p(0, 0.5))
    bar:setBarChangeRate(cc.p(1, 0))
    bar:setPercentage(0)
    table.insert(self.bars, bar)
  end
end

function EquipWashLayer:showAnimation(params)
  local delay, dalte = 0, 0.3
  for index, bar in ipairs(self.bars) do
    bar:runAction(transition.sequence({
      cc.DelayTime:create(delay),
      cc.ProgressTo:create(dalte, 100),
      cc.CallFunc:create(function()
        if index == #self.bars then
          self.expNode:runAction(transition.sequence({
            cc.DelayTime:create(0.3),
            cc.CallFunc:create(function()
              BackManager:pop()
            end)
          }))
        end
      end)
    }))
    delay = delay + dalte
  end
end

return EquipWashLayer
