local SeedCsv = require("csvdata.farm_plant")
local ItemCsv = require("csvdata.item")
local FarmBuildCsv = require("csvdata.farm_building")
local FarmRes = "ui/farm/main/"
local PlantRes = "ui/farm/plant/"
local uiData = {
  csbFile = "ui/farm/PlantMainLayer.csb",
  widgets = {
    center = "center",
    center2 = "center2",
    up = "up",
    touchLayer = "touchLayer",
    node1 = "node1",
    node2 = "node2",
    node3 = "node3",
    node4 = "node4",
    node5 = "node5",
    node6 = "node6",
    btnsBg = "btnsBg",
    changeBtn = "btnsBg/changeBtn",
    saveBtn = "btnsBg/saveBtn",
    loveBtn = "btnsBg/loveBtn",
    panel = "panel",
    touch = "panel/touch",
    touch2 = "panel/touch2",
    btn1 = "panel/btn1",
    btn2 = "panel/btn2",
    btn3 = "panel/btn3",
    btn4 = "panel/btn4",
    num = "panel/bg/num",
    list = "panel/list",
    tipNode = "panel/tipNode"
  }
}
local PlantMainLayer = class("PlantMainLayer", UIBase)

function PlantMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PlantMainLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.touchLayer, true)
    UIHelper.fitForiPhoneX(self.up, true)
    UIHelper.fitForiPhoneX(self.touch2, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() + UIHelper.getMoveXForX())
    self.touchLayer:setPositionX(self.touchLayer:getPositionX() - UIHelper.getMoveXForX())
    self.panel:setPositionX(self.panel:getPositionX() + UIHelper.getMoveXForX())
  end
  TopBar:show(TopBarType.full, "次元农场")
  TopBar:showAnimation(true)
  game:playMusic(9)
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  UIHelper.MoveToLeft({
    node = self.btnsBg,
    time = 0.3
  })
  local types = {
    [1] = {
      [ItemType.LoveItem] = 1
    },
    [2] = {
      [ItemType.PangCi] = 1
    },
    [3] = {
      [ItemType.EnergyItem] = 1,
      [ItemType.Seed] = 1
    },
    [4] = {
      [ItemType.QuickPlant] = 1,
      [ItemType.JobPerfer] = 1
    }
  }
  local names = {
    [1] = "食\n材",
    [2] = "礼\n物",
    [3] = "种\n植",
    [4] = "肥\n料"
  }
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() + 5)
    end,
    unchooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() - 5)
    end
  })
  for index, name in ipairs(names) do
    local btn = self["btn" .. index]
    btn:setGroup(group)
    btn:name("btn" .. index)
    btn:setCallback(function()
      self:showList(index, types[index])
    end)
    display.newTTFLabel({
      text = name,
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#3a200a"), 1):pos(22, 48):addTo(btn)
  end
  group:chooseByName("btn1")
  self:showList(1, types[1])
  self.saveBtn:setTouchScale()
  self.saveBtn:setCallback(function()
    group:chooseByName("btn1")
    self:showList(1, types[1])
    self:cleanSelected()
    if UIHelper.isiPhoneX() then
      self.panel:runAction(cc.MoveTo:create(0.2, cc.p(-UIHelper.getMoveXForX(), 0)))
      BackManager:push(function()
        self.panel:runAction(cc.MoveTo:create(0.2, cc.p(1136 + UIHelper.getMoveXForX(), 0)))
      end)
    else
      self.panel:runAction(cc.MoveTo:create(0.2, cc.p(0, 0)))
      BackManager:push(function()
        self.panel:runAction(cc.MoveTo:create(0.2, cc.p(1136, 0)))
      end)
    end
  end)
  self.changeBtn:setTouchScale()
  self.changeBtn:setCallback(function()
    local layer = game:createView("farm.PlantManagersLayer")
    BackManager:push(function()
      TopBar:show(TopBarType.full, "次元农场")
      layer:close()
      self.plantData = json.decode(game.role.farmData.buildList)
      for slot = 1, self.maxNum do
        self:showSlotDetail(slot)
      end
      self:cleanSelected()
    end)
  end)
  self.loveBtn:setTouchScale()
  self.loveBtn:setCallback(function()
    local layer = game:createView("kitchen.KitchenLayer1", {selected = 4})
    BackManager:push(function()
      layer:close()
    end)
  end)
  self.panel:setLocalZOrder(50)
  self.up:setLocalZOrder(55)
  self.touch2:setCallback(function()
    local x = self.panel:getPositionX()
    if UIHelper.isiPhoneX() then
      if x ~= -UIHelper.getMoveXForX() then
        return
      end
    elseif x ~= 0 then
      return
    end
    BackManager:pop()
  end)
  self.touch:setSwallowTouches(true)
  self.touchLayer:setCallback(function()
    self:cleanSelected()
  end)
  self.play = false
  self.zorder = 31
  self.plantData = json.decode(game.role.farmData.buildList)
  self.maxNum = FarmBuildCsv[4][game.role.farmData.level4].land
  local guideLayer = display.getRunningScene():getChildByTag(NEW_GUIDE_LAYER_TAG)
  if guideLayer then
    self.guideStep = guideLayer.guideStep
  end
end

function PlantMainLayer:showData(params)
  self.cards = {}
  for slot = 1, 6 do
    local node = self["node" .. slot]
    node:removeAllChildren()
    local image = slot > self.maxNum and "lock.png" or "open.png"
    display.newSprite(PlantRes .. image):pos(0, 0):addTo(node)
    if self.cards[slot] then
      for _, parent in pairs(self.cards[slot]) do
        parent:removeSelf()
      end
      self.cards[slot] = {}
    end
    self.cards[slot] = {}
  end
  local cardSize = display.newSprite(PlantRes .. "open.png"):getContentSize()
  for slot = 1, 6 do
    if slot > self.maxNum + 1 then
      return
    end
    local xPos, yPos = self["node" .. slot]:getPosition()
    local viewNode = UIHelper.newImageView(PlantRes .. "touch.png")
    viewNode:anch(0.5, 0.5):setRotation(-30):pos(xPos, yPos):addTo(self.center2):name("plantTouch" .. slot)
    local card = UIHelper.extend(ccui.Layout:create())
    card:anch(0.5, 0.5):setContentSize(cardSize):pos(xPos, yPos):addTo(self.center2)
    local extra = display.newNode():pos(xPos, yPos):addTo(self.center2, 30 + slot)
    self.cards[slot] = {
      card = card,
      touch = viewNode,
      extra = extra
    }
    self:showSlotDetail(slot)
  end
end

function PlantMainLayer:showSlotDetail(slot)
  local touch = self.cards[slot].touch
  local card = self.cards[slot].card
  local extra = self.cards[slot].extra
  card:stopAllActions()
  card:removeAllChildren()
  self.play = false
  if slot == self.maxNum + 1 then
    display.newSprite(PlantRes .. "lock_tip.png"):anch(0.5, 0):pos(215, 90):addTo(card)
    touch:setCallback(function()
      if self.play then
        return
      end
      self:cleanSelected(slot)
      SysError(SYS_ERR_FARM_LAND_NOT_OPEN)
    end)
  end
  if slot > self.maxNum then
    return
  end
  local index = tostring(slot)
  local spine
  if self.plantData[index] and self.plantData[index].hero then
    display.newSprite("ui/battle/player_shadow.png"):pos(335, 110):addTo(card)
    spine = UIHelper.createSpineNode(self.plantData[index].hero):pos(335, 110):addTo(card)
    spine:scale(spine:getScale() * 0.9)
    spine:setLocalZOrder(20)
  end
  if 1 >= table.nums(self.plantData[index] or {}) then
    if spine then
      spine:setAnimation(0, "idle", true)
    end
    touch:setCallback(function()
      self:plantSeed(slot)
    end)
    return
  end
  local seedType = self.plantData[index].type
  local seedData = SeedCsv[seedType]
  if self.plantData[index].time <= game:nowTime() then
    local plant = UIHelper.createSpineNodeByRes(seedData.plantRes):anch(0.5, 0):pos(215, 110):addTo(card, 2):name("plant")
    plant:setAnimation(0, "jg", true)
    if spine then
      spine:setAnimation(0, "cheer", true)
    end
    touch:setCallback(function()
      if game.role:isMaxGift() then
        UIHelper.showExtraTip({type = 3, parent = self})
        return
      end
      game:sendData(actionCodes.Farm_getPlantRpc, MsgPack.pack({
        index = self.plantData[index].id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Farm_getPlantRpc, function(event)
        UIHelper.removeWaiting()
        game:playMusic(1303)
        local data = MsgPack.unpack(event.data)
        self.plantData = json.decode(game.role.farmData.buildList)
        MedalRewardLayer.new({
          items = data.dropItems,
          callback = function()
            self:cleanSelected(slot)
            self:showGetAnimation(data.dropItems)
            self:showSlotDetail(slot)
          end
        })
      end)
    end)
    return
  elseif spine then
    spine:setAnimation(0, "idle", true)
  end
  local timeBg = display.newSprite(PlantRes .. "time_bar_bg.png"):pos(212, 80):addTo(card):name("timeBg")
  timeBg:setLocalZOrder(25)
  local timeBar = display.newProgressTimer(PlantRes .. "time_bar.png", 1):center(timeBg):addTo(timeBg):name("bar")
  timeBar:setMidpoint(cc.p(0, 0.5))
  timeBar:setBarChangeRate(cc.p(1, 0))
  timeBar:setPercentage(0)
  local time = display.newTTFLabel({
    text = "成熟时间: 00:00:00",
    size = 14,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 1):pos(80, -1):addTo(timeBg):name("time")
  if self.plantData[index].subUp then
    display.newSprite("ui/farm/sub/image_sub.png"):pos(163, 7):addTo(timeBg)
  end
  local worth = self.plantData[index].worth == 1 and "r" or self.plantData[index].worth == 2 and "sr" or "ssr"
  local allTime = seedData[worth .. "Time"] * 60
  local bFlash = 0.5 <= (self.plantData[index].time - game:nowTime()) / allTime
  local str = bFlash and "ym" or "cz"
  local plant = UIHelper.createSpineNodeByRes(seedData.plantRes):anch(0.5, 0):pos(215, 110):addTo(card, 2):name("plant")
  plant:setAnimation(0, str, true)
  
  local function setTime()
    local left = self.plantData[index].time - game:nowTime()
    if 0 <= left then
      local sub = (allTime - left) / allTime * 100
      time:setString("成熟时间: " .. UIHelper.getTimeStr(left))
      timeBar:setPercentage(sub)
      if 50 < sub and bFlash then
        self:showSlotDetail(slot)
        if self.curSlot == slot then
          display.newSprite(PlantRes .. "select.png"):center(card):addTo(card, 0):name("select")
        end
        return
      end
      card:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          setTime()
        end)
      }))
    else
      time:setString("已成熟")
      extra:removeAllChildren()
      self:showSlotDetail(slot)
    end
  end
  
  setTime()
  touch:setCallback(function()
    if self.play then
      return
    end
    self:showQuick(slot)
  end)
end

function PlantMainLayer:plantSeed(slot)
  if self.play then
    return
  end
  self:cleanSelected(slot)
  local card = self.cards[slot].card
  local extra = self.cards[slot].extra
  local seedIds = {}
  for id in pairs(SeedCsv) do
    table.insert(seedIds, id)
  end
  table.sort(seedIds)
  local Pos = {
    [0] = {-160, 50},
    [1] = {-80, 70},
    [2] = {0, 90},
    [3] = {80, 70},
    [4] = {160, 50}
  }
  local circles, index = {}, 0
  for i, seedId in ipairs(seedIds) do
    local data = SeedCsv[seedId]
    local itemData = ItemCsv[data.seed]
    local seedNum = game.role.items[data.seed] or 0
    local circle = UIHelper.newImageView(PlantRes .. "circle_bg.png"):pos(Pos[index][1], Pos[index][2]):addTo(extra):name("plantName" .. index)
    display.newSprite(itemData.icon):center(circle):addTo(circle)
    display.newSprite(PlantRes .. "circle_fram.png"):center(circle):addTo(circle)
    circle:setCallback(function()
      if game.role:isMaxGift() then
        UIHelper.showExtraTip({type = 3, parent = self})
        return
      end
      if seedNum <= 0 then
        SysError(SYS_ERR_FARM_PLANT_SEED_NOT_ENOUGH)
        return
      end
      self.play = true
      for _, bg in pairs(circles) do
        if bg ~= circle then
          bg:removeSelf()
        end
      end
      game:sendData(actionCodes.Farm_plantRpc, MsgPack.pack({
        index = slot,
        itemId = data.seed
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Farm_plantRpc, function(event)
        UIHelper.removeWaiting()
        game:playMusic(1301)
        if self.guideStep and self.guideStep == 10014 then
          game:enterScene("MainScene", {guideId = 10014, minorStep = 6})
        else
          self.plantData = json.decode(game.role.farmData.buildList)
          circle:setTouchEnabled(false)
          circle:runAction(transition.sequence({
            cc.Spawn:create(cc.MoveTo:create(0.1, cc.p(0, 0)), cc.ScaleTo:create(0.1, 0)),
            cc.CallFunc:create(function()
              self:cleanSelected()
              local small = UIHelper.createSpineNodeByRes(data.plantRes):anch(0.5, 0):scale(0.1):pos(3, 2):addTo(extra)
              small:setAnimation(0, "ym", true)
              small:runAction(transition.sequence({
                cc.ScaleTo:create(0.2, 1),
                cc.CallFunc:create(function()
                  self:showSlotDetail(slot)
                end),
                cc.RemoveSelf:create()
              }))
            end)
          }))
        end
      end)
    end)
    display.newTTFLabel({
      text = seedNum,
      size = 20,
      color = UIHelper.hex2rgb("#38fc0b")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(57, 15):addTo(circle)
    circles[index] = circle
    cost = data.cost
    index = index + 1
  end
end

function PlantMainLayer:showQuick(slot)
  self:cleanSelected(slot)
  local card = self.cards[slot].card
  local extra = self.cards[slot].extra
  local data = self.plantData[tostring(slot)]
  local seedData = SeedCsv[data.type]
  local quickTools = globalCsv.plantQuick:toArray("=", true)
  local interval = 75
  local xPos = 0 - (table.nums(quickTools) - 1) / 2 * interval
  for index, type in pairs(quickTools) do
    local itemData = ItemCsv[type]
    local num = game.role.items[type] or 0
    local circle = UIHelper.newImageView(PlantRes .. "circle_bg.png"):pos(xPos + (index - 1) * interval, -85):addTo(extra)
    display.newSprite(itemData.icon):scale(0.8):center(circle):addTo(circle)
    display.newSprite(PlantRes .. "circle_fram.png"):center(circle):addTo(circle)
    local numLabel = display.newTTFLabel({
      text = num,
      size = 20,
      color = UIHelper.hex2rgb("#38fc0b")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(57, 15):addTo(circle)
    circle:setCallback(function()
      if self.plantData[tostring(slot)].time <= game:nowTime() then
        return
      end
      if (game.role.items[type] or 0) <= 0 then
        SysError(SYS_ERR_FARM_PLANT_FERTILIZER_NOT_ENOUGH)
        return
      end
      game:sendData(actionCodes.Farm_useItemRpc, MsgPack.pack({
        index = data.id,
        itemId = type
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Farm_useItemRpc, function(event)
        UIHelper.removeWaiting()
        game:playMusic(1302)
        self.plantData = json.decode(game.role.farmData.buildList)
        if not tolua.isnull(numLabel) then
          numLabel:setString(game.role.items[type] or 0)
        end
      end)
    end)
  end
end

function PlantMainLayer:showList(btnIndex, types)
  self.list:removeAllChildren()
  self.num:removeAllChildren()
  self.tipNode:removeAllChildren()
  
  function sortById(a, b)
    return a.id < b.id
  end
  
  local items, cur = {}, 0
  for itemId, count in pairs(game.role.items) do
    local item = ItemCsv[itemId]
    if item == nil then
      print("item == nil", itemId)
    end
    if types[item.type] then
      cur = cur + count
      table.insert(items, {id = itemId, count = count})
    end
  end
  table.sort(items, sortById)
  if btnIndex == 1 then
    display.newTTFLabel({
      text = string.format("%d/%d", cur, game.role.giftMaxNum),
      size = 18,
      color = UIHelper.hex2rgb("#c9794f")
    }):addTo(self.num)
  elseif btnIndex == 2 then
    display.newTTFLabel({
      text = string.format("%d", cur),
      size = 18,
      color = UIHelper.hex2rgb("#c9794f")
    }):addTo(self.num)
  else
    display.newSprite(PlantRes .. "max.png"):pos(0, -2):addTo(self.num)
  end
  local cols, size = 4, cc.size(380, 100)
  local rows = math.ceil(#items / cols)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size):addTo(self.list)
    for col = 1, cols do
      local cur = (row - 1) * cols + col
      local data = items[cur]
      if data then
        ItemIcon.new({
          id = data.id,
          count = data.count,
          showTip = true
        }):pos(50 + (col - 1) * 95, 50):addTo(viewNode)
      end
    end
  end
  if #items == 0 then
    if btnIndex < 3 then
      local desc = btnIndex == 1 and "已经没有食材了，快通过种植收获吧" or "已经没有礼物了，可以通过分解食灵获得哦"
      display.newTTFLabel({
        text = desc,
        size = 16,
        color = UIHelper.hex2rgb("#ce8f6a")
      }):pos(-190, 200):addTo(self.tipNode)
    else
      display.newSprite(PlantRes .. string.format("empty_%d.png", btnIndex - 1)):anch(1, 0):addTo(self.tipNode)
    end
  end
  self.list:requestDoLayout()
end

function PlantMainLayer:showGetAnimation(items)
  local delay = 0.5
  for id, num in pairs(items) do
    local item = ItemCsv[id]
    local sprite = display.newSprite(item.icon):anch(1, 0.5):pos(1140, 200):addTo(self)
    if sprite then
      sprite:setOpacity(0)
      sprite:runAction(transition.sequence({
        cc.DelayTime:create(delay),
        cc.CallFunc:create(function()
          sprite:show()
        end),
        cc.FadeIn:create(0.2),
        cc.Spawn:create(cc.MoveTo:create(0.4, cc.p(1090, 70)), cc.ScaleTo:create(0.4, 0)),
        cc.RemoveSelf:create()
      }))
    end
    delay = delay + 0.4
  end
end

function PlantMainLayer:cleanSelected(slot)
  if self.curSlot then
    local card = self.cards[self.curSlot].card
    local extra = self.cards[self.curSlot].extra
    local select = card:getChildByName("select")
    if select then
      select:removeSelf()
      self.curSlot = nil
    end
    extra:removeAllChildren()
    extra:setLocalZOrder(self.zorder)
    self.zorder = 31
  end
  if slot then
    local card = self.cards[slot].card
    local extra = self.cards[slot].extra
    extra:setLocalZOrder(40)
    display.newSprite(PlantRes .. "select.png"):center(card):addTo(card, 0):name("select")
    self.curSlot = slot
    self.zorder = 30 + slot
  end
end

function PlantMainLayer:onExit()
  game.role:setRedDirty("plant")
end

return PlantMainLayer
