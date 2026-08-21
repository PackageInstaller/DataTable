local ItemCsv = require("csvdata.item")
local UnitCsv = require("csvdata.unit")
local BuildRes = "ui/kitchen/build/"
local uiData = {
  csbFile = "ui/kitchen/BuildHerosLayer.csb",
  widgets = {
    btnsNode = "mainBg/btnsNode",
    num1 = "mainBg/numBg1/num1",
    num2 = "mainBg/numBg2/num2",
    num3 = "mainBg/numBg3/num3",
    num4 = "mainBg/numBg4/num4",
    num5 = "mainBg/numBg5/num5",
    name3 = "mainBg/name3",
    btnSub = "mainBg/btnSub",
    btnAdd = "mainBg/btnAdd",
    btnMax = "mainBg/btnMax",
    btnInfo = "mainBg/btnInfo",
    btnStart = "mainBg/btnStart",
    btnQuick = "mainBg/btnQuick",
    imageBg = "mainBg/imageBg",
    num = "mainBg/btnStart/num",
    tip = "mainBg/tip",
    bg1 = "key1",
    bg2 = "key2",
    value1 = "key1/value",
    value2 = "key2/value",
    changeBtn = "mainBg/changeBtn"
  }
}
local btnsData = {
  [1] = {
    name = "精选料理I",
    open = function(self)
      return true
    end
  },
  [2] = {
    name = "精选料理II",
    open = function(self)
      return true
    end
  },
  [3] = {
    name = "限时烹饪",
    open = function(self)
      return game.role:activityIsOpen(7)
    end
  },
  [4] = {
    name = "特殊烹饪",
    open = function(self)
      return game.role:activityIsOpen(8)
    end
  }
}
local BuildHerosLayer = class("BuildHerosLayer", UIBase)

function BuildHerosLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function BuildHerosLayer:init(params)
  self.maxCount = 10
  self.curCount = 1
  self.bQuick = game.role.BuildHeroUseQuick or false
  self.maxSlot = 10
  self.parentLayer = params.parentLayer
  self.autoFunc = params.autoFunc or function()
  end
  self.bg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.bg1,
      itemType = globalCsv.buildDrawing,
      itemData = ItemCsv[globalCsv.buildDrawing]
    })
  end)
  self.bg2:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.bg2,
      itemType = globalCsv.quickBuild,
      itemData = ItemCsv[globalCsv.quickBuild]
    })
  end)
  UIHelper.MoveToLeft({
    node = self.bg1,
    time = 0.3
  })
  UIHelper.MoveToLeft({
    node = self.bg2,
    time = 0.3
  })
  local names = {
    "btnSub",
    "btnAdd",
    "btnMax",
    "btnStart",
    "btnInfo",
    "changeBtn"
  }
  for k, name in pairs(names) do
    self[name]:setTouchScale()
  end
  self.name3:setString("消耗")
  self.btnQuick:setImage(BuildRes .. (self.bQuick and "image_quick_b.png" or "image_quick_a.png"))
  self.btnQuick:setCallback(function()
    self.bQuick = not self.bQuick
    self.btnQuick:setImage(BuildRes .. (self.bQuick and "image_quick_b.png" or "image_quick_a.png"))
    self:changeBuildCount(0)
  end)
  self.btnAdd:setCallback(function()
    self:changeBuildCount(1)
  end)
  self.btnSub:setCallback(function()
    self:changeBuildCount(-1)
  end)
  self.btnMax:setCallback(function()
    self:changeBuildCount(self.maxCount)
  end)
  self.btnStart:setCallback(function()
    self:checkCanBuild()
  end)
  self.btnInfo:setCallback(function()
    game:loadView("kitchen.CookInfoLayer").new({
      res = "ui/kitchen/cook/info.png"
    })
  end)
  self.changeBtn:setCallback(function()
    local layer = game:createView("kitchen.PrepareCookLayer", {
      callback = function(material)
        self.materialCost = material
        if game.role.majorGuideStep == 14 then
          self.materialCost = {
            100,
            100,
            100,
            100
          }
          UserData.materialTable = nil
        end
        self:changeBuildCount(0)
      end
    })
    self:hide()
    BackManager:push(function()
      layer:close()
      self:show()
    end)
  end)
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() - 6)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("#fe5b22"))
      local tag = sender:getChildByName("tag")
      tag.func(1)
    end,
    unchooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() + 6)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("#8d4e24"))
      local tag = sender:getChildByName("tag")
      tag.func(-1)
    end
  })
  local xPos, interval = 0, 230
  self:initKeyValue()
end

function BuildHerosLayer:showData(params)
  if not UserData.materialTable then
    UserData.materialTable = {}
    for i = 1, 4 do
      UserData.materialTable[i] = globalCsv.minBuildCost
    end
  end
  self.materialCost = UserData.materialTable
  self.imageBg:removeAllChildren()
  local index, all = 1, globalCsv.buildHerosImage or {1}
  
  local function createImage()
    local image = display.newSprite(BuildRes .. string.format("title_image_%d.png", all[index])):center(self.imageBg):addTo(self.imageBg, nil, -index)
    image:setOpacity(0)
    image:runAction(transition.sequence({
      cc.FadeIn:create(0.5),
      cc.DelayTime:create(5),
      cc.FadeOut:create(0.5),
      cc.RemoveSelf:create()
    }))
    index = index + 1
    if index > #all then
      index = 1
    end
  end
  
  self.imageBg:runAction(cc.RepeatForever:create(transition.sequence({
    cc.CallFunc:create(function()
      createImage()
    end),
    cc.DelayTime:create(5.5)
  })))
  if #all <= 1 then
    self.imageBg:stopAllActions()
    self.imageBg:removeAllChildren()
    display.newSprite(BuildRes .. string.format("title_image_%d.png", all[index])):center(self.imageBg):addTo(self.imageBg, nil, -1)
  end
  self:changeBuildCount(0)
end

function BuildHerosLayer:initKeyValue()
  self.value1:setString(game.role.items[globalCsv.buildDrawing] or 0)
  self.value2:setString(game.role.items[globalCsv.quickBuild] or 0)
  UIHelper.setMaxWidth(self.value1, 55)
  UIHelper.setMaxWidth(self.value2, 47)
  self.tip:setString(string.format("当前烹饪队列: %d/10", table.nums(game.role.buildListJson or {})))
  UIHelper.makeFontClear(self.tip)
end

function BuildHerosLayer:changeBuildCount(dalte)
  self.curCount = self.curCount + dalte
  if self.curCount > self.maxCount then
    self.curCount = self.maxCount
  end
  if self.curCount < 1 then
    self.curCount = 1
  end
  self.num:setString(self.curCount)
  self.num5:setString("x" .. self.curCount)
  self.num5:setTextColor(UIHelper.hex2rgb((game.role.items[globalCsv.buildDrawing] or 0) >= self.curCount and "#833809" or "#fc4e01"))
  UIHelper.makeFontClear(self.num5)
  for i = 1, 4 do
    local need = self.materialCost[i] * self.curCount
    self["num" .. i]:setString(self.materialCost[i] .. "x" .. self.curCount)
    self["num" .. i]:setTextColor(UIHelper.hex2rgb(need <= game.role["material" .. i] and "#833809" or "#fc4e01"))
    UIHelper.makeFontClear(self["num" .. i])
  end
  self.btnQuick:removeAllChildren()
  local str = string.format("%s <img src='%s' scale=0.45 />x%d", ItemCsv[globalCsv.quickBuild].name, ItemCsv[globalCsv.quickBuild].icon, self.curCount)
  MRichText.new({
    text = str,
    size = 20,
    color = UIHelper.hex2rgb((game.role.items[globalCsv.quickBuild] or 0) < self.curCount and self.bQuick and "#fc4e01" or "#833809")
  }):anch(0, 0.5):pos(55, 29):addTo(self.btnQuick)
end

function BuildHerosLayer:checkCostEnough()
  local diamond, costData = 0, {}
  for itemId, data in pairs(globalCsv.cook_autocomplete) do
    if itemId <= 4 then
      local cur, need = game.role["material" .. itemId], self.materialCost[itemId] * self.curCount
      if cur < need then
        costData[itemId] = math.ceil((need - cur) / data.count) * data.cost
        diamond = diamond + costData[itemId]
      end
    elseif itemId == 28 then
      local cur = game.role.items[itemId] or 0
      if cur < self.curCount then
        costData[itemId] = math.ceil((self.curCount - cur) / data.count) * data.cost
        diamond = diamond + costData[itemId]
      end
    else
      local cur = game.role.items[itemId] or 0
      if self.bQuick and cur < self.curCount then
        costData[itemId] = math.ceil((self.curCount - cur) / data.count) * data.cost
        diamond = diamond + costData[itemId]
      end
    end
  end
  return diamond, costData
end

function BuildHerosLayer:checkCanBuild()
  if self.curCount < 0 or self.curCount > 10 then
    return
  end
  if game.role:isMaxHero() then
    UIHelper.showExtraTip({type = 1, parent = self})
    return
  end
  local useCount = table.nums(game.role.buildListJson or {})
  if not self.bQuick and useCount + self.curCount > self.maxSlot then
    MDialog:single({
      title = "温馨提示",
      color = UIHelper.hex2rgb("#fc4e01"),
      size = 22,
      text = string.format("烹饪区仅剩余 %d 个位置，请调整烹饪数量", self.maxSlot - useCount)
    })
    return
  end
  local diamond, costData = self:checkCostEnough()
  if 0 < diamond then
    game:createView("kitchen.BuildHerosCostLayer", {
      all = diamond,
      cost = costData,
      okCallback = function()
        local showType, showText, showBg = TopBar:getShowType()
        local layer = game:createView("shop.ShopLayer", {
          curType = 1,
          selected = 3,
          isHide = true
        })
        if self.parentLayer and not tolua.isnull(self.parentLayer) then
          self.parentLayer:hide()
        end
        BackManager:push(function()
          if self.parentLayer and not tolua.isnull(self.parentLayer) then
            self.parentLayer:show()
          end
          self:initKeyValue()
          layer:close()
          TopBar:show(showType, showText, showBg)
        end)
      end,
      cancleCallback = function()
        if diamond > game.role.diamond then
          UIHelper.showDiamondTip({
            parent = self.parentLayer
          })
        else
          self:sendRequest(true)
        end
      end
    })
  else
    self:sendRequest(false)
  end
end

function BuildHerosLayer:sendRequest(costDiamond)
  game.role.BuildHeroUseQuick = self.bQuick
  game:sendData(actionCodes.Store_produceRpc, MsgPack.pack({
    count = self.curCount,
    quick = self.bQuick,
    material = self.materialCost,
    buy = costDiamond
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Store_produceRpc, function(event)
    UIHelper.removeWaiting()
    GameState.save(UserData)
    if tolua.isnull(self) then
      return
    end
    self:changeBuildCount(0)
    self:initKeyValue()
    local tempCount = self.curCount
    local msg = MsgPack.unpack(event.data)
    local rewards = {}
    local isFirsts = {}
    if not self.bQuick and not msg.quick then
      self.autoFunc()
      return
    end
    for _, data in ipairs(msg.result or {}) do
      table.insert(rewards, data.unitId)
      table.insert(isFirsts, data.first)
    end
    
    local function checkHero()
      if next(rewards) then
        HeroRewardLayer.new({
          type = rewards[1],
          showSkip = 1 < tempCount and true or false,
          bFirst = isFirsts[1],
          skipFunc = function()
            tempCount = 1
            local tempRewards = {}
            local tempIsFirsts = {}
            for k, res in ipairs(isFirsts) do
              if k == 1 or res or UnitCsv[rewards[k]].star == 5 then
                table.insert(tempRewards, rewards[k])
                table.insert(tempIsFirsts, res)
              end
            end
            rewards = tempRewards
            isFirsts = tempIsFirsts
          end,
          callback = function()
            if next(rewards) then
              table.remove(rewards, 1)
              table.remove(isFirsts, 1)
            end
            checkHero()
          end
        })
      elseif 1 < self.curCount then
        game:createView("kitchen.BuildQuickResultLayer", {
          heros = msg.result
        })
      end
    end
    
    checkHero()
  end)
end

return BuildHerosLayer
