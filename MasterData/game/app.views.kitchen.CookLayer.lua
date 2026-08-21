local ItemCsv = require("csvdata.item")
local UnitCsv = require("csvdata.unit")
local heroRes = "ui/hero/"
local kitchenRes = "ui/kitchen/"
local cookRes = "ui/kitchen/cook/"
local globalRes = "ui/global/"
local uiData = {
  csbFile = "ui/kitchen/CookLayer.csb",
  widgets = {
    btnQuick = "btnQuick",
    btnName = "btnQuick/btnName",
    value2 = "key2/value",
    text = "key3/text",
    bg2 = "key2",
    bg3 = "key3",
    list = "list"
  }
}
local CookLayer = class("CookLayer", UIBase)

function CookLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CookLayer:init(params)
  self.bg2:setCascadeOpacityEnabled(true)
  self.bg3:setCascadeOpacityEnabled(true)
  self.list:setCascadeOpacityEnabled(true)
  self.bg2:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.bg2,
      itemType = globalCsv.quickBuild,
      itemData = ItemCsv[globalCsv.quickBuild]
    })
  end)
  local soup = display.newSprite(cookRes .. "soup_pot.png"):scale(0.5):pos(display.width - 205, 15):addTo(self, 50)
  local guo = UIHelper.createSpineNodeByRes("spine/ui/kitchen/guo"):pos(255, -2):addTo(soup)
  guo:setAnimation(0, "idle", true)
  self.text:setString(string.format("可同时烹饪的厨房:%d", game.role.heroBuildMaxNum))
  self.btnName:setString("批量加速")
  UIHelper.MoveToLeft({
    node = self.bg3,
    time = 0.3,
    pos = {99, 0}
  })
  UIHelper.MoveToLeft({
    node = self.bg2,
    time = 0.3
  })
  UIHelper.MoveToLeft({
    node = self.btnQuick,
    time = 0.3
  })
  UIHelper.MoveToUp({
    node = self.list,
    delay = 0.2,
    pos = {0, 300},
    ease = true
  })
  UIHelper.MoveToUp({node = soup, time = 0.3})
  self.max = math.max(table.nums(game.role.buildListJson or {}), game.role.heroBuildMaxNum)
  self.doneNum = 0
  self.btnQuick:setTouchScale()
  self.btnQuick:setCallback(function()
    local allCount = table.nums(game.role.buildListJson or {})
    if allCount == 0 then
      return
    end
    local keyCount = game.role.items[globalCsv.quickBuild] or 0
    if self.doneNum == 0 and keyCount == 0 then
      UIHelper.showCookTip({
        type = 2,
        callback = function()
          self:updateKeyValues()
        end
      })
      return
    end
    self:sendRequest(0, true, true)
  end)
  self:updateKeyValues()
end

function CookLayer:showData(params)
  self.list:removeAllChildren()
  self.list:requestDoLayout()
  self.showTimeCount = 0
  local now = game:nowTime()
  local cellSize = cc.size(1010, 224)
  local rows = math.ceil(self.max / 2)
  for row = 1, rows do
    local xPos = 280
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:setContentSize(cellSize):addTo(self.list)
    for col = 1, 2 do
      local index = (row - 1) * 2 + col
      if index <= self.max then
        local card = self:createCard(index, now):anch(0.5, 0):pos(xPos, 0):addTo(viewNode):name("cook" .. index)
        xPos = xPos + 460
      end
    end
  end
  self:updateKeyValues()
end

function CookLayer:createCard(index, curTime)
  local cookData = game.role.buildListJson[index] or {}
  local cell = UIHelper.newImageView(cookRes .. "item_bg.png")
  cell:setCascadeOpacityEnabled(true)
  if next(cookData) then
    local spine = UIHelper.createSpineNodeByRes("spine/ui/kitchen/weiqi"):scale(0.8):pos(185, 25):addTo(cell)
    spine:setAnimation(0, "jiaoban", true)
    if curTime < cookData.time then
      self.showTimeCount = self.showTimeCount + 1
      if self.showTimeCount > game.role.heroBuildMaxNum then
        display.newSprite(cookRes .. "wait_circle.png"):pos(218, 105):addTo(cell)
        spine:removeFromParent()
        cell:setCallback(function()
          if game.role.heroBuildMaxNum >= globalCsv.heroBuildNumMax then
            return
          end
          MDialog:double({
            title = "烹饪台扩展",
            text = "烹饪台尚未全部开启，是否前往商城购买扩展？",
            okCallback = function()
              local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 4})
              BackManager:push(function()
                layer:close()
                self:showData({})
              end)
              return true
            end,
            cancelCallback = function()
              return true
            end
          })
        end)
      else
        local clockBg = display.newSprite(cookRes .. "time_bg.png"):pos(223, 30):addTo(cell)
        clockBg:setCascadeOpacityEnabled(true)
        local time = display.newTTFLabel({
          text = "",
          size = 21,
          color = UIHelper.hex2rgb("#0f7d03")
        }):anch(0, 0.5):pos(35, 19):addTo(clockBg)
        
        local function setTime()
          local leftTime = cookData.time - game:nowTime()
          if 0 <= leftTime then
            time:setString(UIHelper.getTimeStr(leftTime))
            time:runAction(transition.sequence({
              cc.DelayTime:create(1),
              cc.CallFunc:create(function()
                setTime()
              end)
            }))
          else
            self:showData()
          end
        end
        
        setTime()
        cell:setCallback(function()
          if 0 < (game.role.items[globalCsv.quickBuild] or 0) then
            MDialog:double({
              title = "快速烹饪",
              text = "确定消耗 <img src='ui/global/icon_quick1.png' scale=0.5 />x1 立即完成烹饪么？"
            }, function()
              self:sendRequest(index, game:nowTime() < cookData.time)
            end)
          else
            UIHelper.showCookTip({
              type = 2,
              callback = function()
                self:updateKeyValues()
              end
            })
          end
        end)
      end
    else
      self.doneNum = self.doneNum + 1
      spine:setAnimation(0, "cheer", true)
      local finishBg = display.newSprite(cookRes .. "finish_bg.png"):pos(220, 63):addTo(cell)
      local finishCircle = display.newSprite(cookRes .. "finish_circle.png"):pos(214, 63):addTo(cell)
      display.newSprite(cookRes .. "finish.png"):pos(214, 60):addTo(cell)
      finishCircle:runAction(cc.RepeatForever:create(cc.RotateBy:create(10, 360)))
      cell:setCallback(function()
        self:sendRequest(index)
      end)
    end
  else
    display.newSprite(cookRes .. "image_free.png"):center(cell):addTo(cell)
  end
  return cell
end

function CookLayer:sendRequest(slot, rightNow, all)
  local buildData = game.role.buildListJson[slot]
  if slot ~= 0 and not buildData then
    return
  end
  game:sendData(actionCodes.Store_finishBuildRpc, MsgPack.pack({
    slot = slot,
    rightNow = rightNow,
    all = all
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Store_finishBuildRpc, function(event)
    UIHelper.removeWaiting()
    self.max = math.max(table.nums(game.role.buildListJson), game.role.heroBuildMaxNum)
    self:showData()
    local msg = MsgPack.unpack(event.data)
    local rewards = {}
    local isFirsts = {}
    for _, data in ipairs(msg.result or {}) do
      table.insert(rewards, data.unitId)
      table.insert(isFirsts, data.first)
    end
    local count = table.nums(rewards)
    local tempCount = count
    
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
            if game.role.majorGuideStep == 14 then
              game.role.minorGuideStep = 14
              NewGuideLayer.new({
                step = 14,
                callback = function()
                  game:enterScene("MainScene")
                end
              })
            end
          end
        })
      elseif 1 < count then
        game:createView("kitchen.BuildQuickResultLayer", {
          heros = msg.result
        })
      end
    end
    
    checkHero()
  end)
end

function CookLayer:updateKeyValues()
  self.value2:setString(game.role.items[globalCsv.quickBuild] or 0)
  UIHelper.setMaxWidth(self.value2, 47)
end

return CookLayer
