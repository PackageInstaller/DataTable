local ItemCsv = require("csvdata.item")
local SuppleCsv = require("csvdata.diner_energy")
local SupplyRes = "ui/diner/supply/"
local DinerSupplyLayer = class("DinerSupplyLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function DinerSupplyLayer:ctor(params)
  self:size(display.width, display.height)
  self:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  self.diner = params.diner
  self.func = params.func
  self.type = 0
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(display.width, display.height)
  mask:setBackGroundColorType(1)
  mask:setBackGroundColor(cc.c3b(0, 0, 0))
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  mask:setBackGroundColorOpacity(191)
  mask:anch(0.5, 0.5):center(self):addTo(self)
  mask:setCallback(function()
    self:removeSelf()
  end)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(mask)
  end
  local bg = UIHelper.newImageView(SupplyRes .. "items_bg.png"):center(self):addTo(self)
  bg:setTouchEnabled(true)
  bg:setSwallowTouches(true)
  display.newTTFLabel({text = "食材", size = 18}):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(193, 185):addTo(bg)
  local barDi = display.newSprite(SupplyRes .. "image_bar_bg.png"):anch(0, 0.5):pos(240, 185):addTo(bg)
  local barBg = display.newSprite(SupplyRes .. "bar_bg.png"):pos(218, 10):addTo(barDi)
  self.progress = display.newProgressTimer(SupplyRes .. "bar.png", 1):center(barBg):addTo(barBg)
  self.progress:setMidpoint(cc.p(0, 0.5))
  self.progress:setBarChangeRate(cc.p(1, 0))
  self.progress:setPercentage(0)
  self.count = display.newTTFLabel({text = "0/0", size = 18}):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(192, 7):addTo(barBg)
  self.list = ccui.ListView:create()
  self.list:size(cc.size(788, 126))
  self.list:setInnerContainerSize(cc.size(788, 126))
  self.list:setClippingEnabled(true)
  self.list:setBounceEnabled(true)
  self.list:setDirection(2)
  self.list:anch(0, 0):pos(24, 30):addTo(bg)
  local group = MRadioGroup:create()
  local names = {"食材", "礼物"}
  local xPos = 40
  for index, name in ipairs(names) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/farm/plant/", {"btn_a.png", "btn_b.png"})
    btn:anch(0.5, 0):pos(xPos, -20):addTo(bg):name("type" .. index - 1)
    btn:setLocalZOrder(-1)
    btn:setRotation(90)
    btn:setGroup(group)
    btn:setCallback(function()
      self.type = index - 1
      self:refreshListWithDelay()
    end)
    display.newTTFLabel({
      text = name,
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#3a200a"), 1):setRotation(-90):pos(18, 45):addTo(btn)
    xPos = xPos + 100
  end
  group:chooseByName("type0")
  self:updateProgress()
  self:refreshListWithDelay()
end

function DinerSupplyLayer:refreshListWithDelay()
  self.list:removeAllChildren()
  local exist = false
  local size = display.newSprite(SupplyRes .. "items_cell.png"):getContentSize()
  for id, data in pairs(SuppleCsv) do
    local count = game.role.items[id] or 0
    if data.type == self.type and 0 < count then
      exist = true
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(size):addTo(self.list)
      local cell = UIHelper.newImageView(SupplyRes .. "items_cell.png"):center(viewNode):addTo(viewNode)
      local card = ItemIcon.new({type = id, count = 1}):pos(56, 78):addTo(viewNode)
      local num = display.newTTFLabel({text = count, size = 22}):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(85, 6):addTo(card)
      display.newTTFLabel({
        text = ItemCsv[id].name,
        size = 16,
        color = UIHelper.hex2rgb("#753613")
      }):pos(55, 15):addTo(cell)
      cell:setSwallowTouches(true)
      cell:setCallback(function()
        if (game.role.diner.diners[self.diner].material or 0) >= globalCsv.dinerCarEnergyMax then
          SysError(SYS_ERR_DINER_CAR_SUPPLY_MAX)
          return
        end
        game:sendData(actionCodes.Diner_supplyMaterialRpc, MsgPack.pack({
          slot = self.diner,
          id = id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Diner_supplyMaterialRpc, function(event)
          UIHelper.removeWaiting()
          if self.type == 1 then
            MFlashMsg:show({
              text = string.format("礼物已自动在集市中兑换为%d食材", data.energy)
            })
          end
          if count == 1 then
            self:refreshListWithDelay()
          else
            count = count - 1
            num:setString(count)
          end
          if self.func then
            self.func()
          end
          self:updateProgress()
        end)
      end)
    end
  end
  if not exist then
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(self.list:getContentSize()):addTo(self.list)
    local desc = self.type == 0 and "没有可用礼物，请记得在次元农场中收获哦" or "没有可用花花，分解高级食灵有概率获得哦"
    display.newTTFLabel({
      text = desc,
      size = 20,
      color = UIHelper.hex2rgb("#986339")
    }):center(viewNode):addTo(viewNode)
  end
  self.list:requestDoLayout()
end

function DinerSupplyLayer:updateProgress()
  local cur = game.role.diner.diners[self.diner].material or 0
  self.count:setString(string.format("%d/%d", cur, globalCsv.dinerCarEnergyMax))
  self.progress:setPercentage(cur / globalCsv.dinerCarEnergyMax * 100)
end

return DinerSupplyLayer
