local GlobalRes = "ui/global/"
local channelConfigs = require("sdk.ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local uiData = {
  csbFile = "ui/global/TopBar_2.csb",
  order = TOPBAR_LAYER_ORDER,
  widgets = {
    baseNode = "baseNode",
    nodeBg = "baseNode/nodeBg",
    topAngle = "top_bar_angle",
    backBtn = "top_bar_angle/backBtn",
    sysBtn = "baseNode/nodeBg/sysBtn",
    systemBg = "baseNode/nodeBg/systemBg",
    homeBtn = "sign/homeBtn",
    baseDiamondValue = "baseDiamondBar/value",
    btnDiamond = "baseDiamondBar/btnDiamond",
    diamondMask = "baseDiamondBar/diamondMask",
    base1Bar = "base1Bar",
    base1Value = "base1Bar/value",
    base2Bar = "base2Bar",
    base2Value = "base2Bar/value",
    base3Bar = "base3Bar",
    base3Value = "base3Bar/value",
    base4Bar = "base4Bar",
    base4Value = "base4Bar/value",
    gmBtn = "gmBtn",
    sign = "sign",
    title = "sign/title"
  }
}
local logicalData = {}
local TopBar_2 = class("TopBar_2", UIBase)

function TopBar_2:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TopBar_2:init(params)
  if not config.showGm then
    self.gmBtn:hide()
  end
  self.extraData = {}
  self.backBtn:setCallback(function(sender)
    local num = self.topAngle:getNumberOfRunningActions()
    if 0 < num then
      return
    end
    BackManager:pop()
  end)
  self.sysBtn:setTouchScale()
  self.sysBtn:setCallback(function(sender)
    local layer = game:createView("system.SystemSetLayer")
    BackManager:push(function()
      layer:close()
      self:show(TopBarType.money)
    end)
  end)
  self.homeBtn:setTouchScale()
  self.homeBtn:setCallback(function()
    game:enterScene("MainScene")
  end)
  self.gmBtn:setCallback(function(sender)
    if not config.showGm then
      return
    end
    game:createView("global.GmLayer")
  end)
  
  local function goToShop()
    local showType, showText, showBg = self:getShowType()
    local backBtn = self.backBtn:getChildByName("heroListBack")
    local travelBg = self:getChildByName("indexBg")
    local layer = game:createView("shop.ShopLayer", {
      curType = 1,
      selected = 1,
      isHide = true
    })
    if backBtn then
      backBtn:hide()
    end
    if travelBg then
      travelBg:hide()
    end
    BackManager:push(function()
      layer:close()
      if backBtn then
        backBtn:show()
      end
      if travelBg then
        travelBg:show()
      end
      self:show(showType, showText, showBg)
    end)
  end
  
  self.btnDiamond:setTouchScale()
  self.btnDiamond:setCallback(function()
    goToShop()
  end)
  self.diamondMask:setCallback(function()
    goToShop()
  end)
  self.base1Value:setString(math.floor(game.role.material1))
  self.base2Value:setString(math.floor(game.role.material2))
  self.base3Value:setString(math.floor(game.role.material3))
  self.base4Value:setString(math.floor(game.role.material4))
  self:setDiamond(game.role.diamond)
  self.eventHandlers = {
    game.role:addEventListener("set_diamond", function(event)
      self:setDiamond(event.newValue)
    end),
    game.role:addEventListener("set_homeBgTag", function(event)
      self:showSkin()
    end)
  }
  for type = 1, 4 do
    local setName = string.format("set_material%d", type)
    local baseName = string.format("base%dValue", type)
    table.insert(self.eventHandlers, game.role:addEventListener(setName, function(event)
      self[baseName]:stopAllActions()
      UIHelper.numVaryEffect({
        node = self[baseName],
        repeatTimes = 10,
        effectTime = 0.3,
        orginNum = event.oldValue,
        endNum = event.newValue
      })
    end))
  end
  if UIHelper.isiPhoneX() then
    self.sign:setPositionX(self.sign:getPositionX() - UIHelper.getMoveXForX() + 20)
    self.baseNode:setPositionX(self.baseNode:getPositionX() + UIHelper.getMoveXForX())
    self.topAngle:setPositionX(self.topAngle:getPositionX() + UIHelper.getMoveXForX())
  end
  self:showSkin()
end

function TopBar_2:showSkin()
  if game.role.homeBgTag == 6 then
    self.pendantType = globalCsv.pendant or 0
  elseif game.role.homeBgTag == 42 then
    self.pendantType = globalCsv.pendant or 0
  else
    self.pendantType = globalCsv.pendant or 0
  end
  self.systemBg:hide()
  self.sysBtn:hide()
  self:showPendants()
end

function TopBar_2:showPendants()
  if self.pendantType == 0 then
    return
  end
  local paths = {
    "snow_",
    "newyear_",
    "sakura_",
    "summer_",
    ""
  }
  local posXY = {
    [1] = {
      {
        0,
        0,
        0
      }
    },
    [2] = {
      {
        0,
        0,
        0
      }
    },
    [3] = {
      {
        0,
        0,
        0
      }
    },
    [4] = {
      {
        0,
        0,
        1
      }
    },
    [5] = {
      {
        0,
        0,
        0
      }
    }
  }
  local pathName = paths[self.pendantType]
  if not pathName then
    return
  end
  local names = {"top_bar_bg"}
  local nodeNames = {"nodeBg"}
  for index, name in ipairs(names) do
    local dalte = posXY[self.pendantType]
    if dalte[index][3] == 1 then
      local btn = self[nodeNames[index]]
      local size = btn:getContentSize()
      display.newSprite(PendantRes .. pathName .. name .. ".png"):anch(0.5, 1):pos(size.width / 2 + dalte[index][1], size.height + dalte[index][2]):addTo(btn)
    end
  end
end

function TopBar_2:setDiamond(value)
  self.baseDiamondValue:setString(value)
  if self.baseDiamondValue:getContentSize().width >= 60 then
    self.baseDiamondValue:setScaleX(60 / self.baseDiamondValue:getContentSize().width)
  else
    self.baseDiamondValue:setScaleX(1)
  end
end

function TopBar_2:moveOut(skipTopAngle)
  self.baseNode:runAction(cc.MoveTo:create(0.45, cc.p(self.xPos, display.height + 60)))
  local xPos, signx = 1230, 72
  if UIHelper.isiPhoneX() then
    xPos = xPos + UIHelper.getMoveXForX()
    signx = signx - UIHelper.getMoveXForX() + 20
  end
  self.sign:runAction(cc.MoveTo:create(0.45, cc.p(signx, display.height + 60)))
  if not skipTopAngle then
    self.topAngle:runAction(cc.MoveTo:create(0.45, cc.p(xPos, 640)))
  end
end

function TopBar_2:moveIn(skipTopAngle)
  self.baseNode:runAction(cc.MoveTo:create(0.45, cc.p(self.xPos, display.height)))
  local xPos, signx = 1136, 72
  if UIHelper.isiPhoneX() then
    xPos = xPos + UIHelper.getMoveXForX()
    signx = signx - UIHelper.getMoveXForX() + 20
  end
  self.sign:runAction(cc.MoveTo:create(0.45, cc.p(signx, display.height)))
  if not skipTopAngle then
    self.topAngle:runAction(cc.MoveTo:create(0.45, cc.p(xPos, 640)))
  end
end

function TopBar_2:getBackBtn()
  return self.backBtn
end

function TopBar_2:showAnimation(sign, time, delay, skipTopAngle)
  time = time or 0.5
  delay = delay or 0
  if sign then
    UIHelper.MoveToDown({
      node = self.sign,
      delay = delay,
      time = time
    })
  end
  if not skipTopAngle then
    UIHelper.MoveToLeft({
      node = self.topAngle,
      delay = delay,
      time = time
    })
  end
  UIHelper.MoveToDown({
    node = self.baseNode,
    time = time
  })
end

function TopBar_2:hideElements(elements)
  for _, name in ipairs(elements) do
    self[name]:hide()
  end
  return self
end

function TopBar_2:showElements(elements)
  for _, name in ipairs(elements) do
    if name ~= "title" and name ~= "gmBtn" then
      self[name]:show()
    end
    if name == "gmBtn" and not config.showGm then
    else
      self[name]:show()
    end
  end
  return self
end

TopBarType = {
  hide = 0,
  full = 1,
  back = 2,
  money = 3,
  shop = 4
}

function TopBar_2:show(type, text, showBg)
  self.root_panel:show()
  if not type then
    return
  end
  local TypeFunc = {
    [0] = function()
      self:hide()
    end,
    [1] = function()
      self:showElements({
        "btnDiamond",
        "diamondMask",
        "baseNode",
        "gmBtn",
        "topAngle",
        "sign"
      })
      self:hideElements({"nodeBg"})
    end,
    [2] = function()
      self:showElements({
        "btnDiamond",
        "diamondMask",
        "topAngle",
        "sign"
      })
      self:hideElements({"baseNode"})
    end,
    [3] = function()
      self:showElements({
        "btnDiamond",
        "diamondMask",
        "baseNode",
        "gmBtn",
        "nodeBg"
      })
      self:hideElements({"topAngle", "sign"})
    end,
    [4] = function()
      self:showElements({
        "baseNode",
        "gmBtn",
        "topAngle",
        "sign"
      })
      self:hideElements({
        "btnDiamond",
        "diamondMask",
        "nodeBg"
      })
    end
  }
  local func = TypeFunc[type]
  if func then
    func()
    if text then
      self.title:setString(text)
    else
      self:hideElements({"sign"})
    end
    if showBg then
      self:showElements({"nodeBg"})
    end
  else
    self:hide()
  end
  self.xPos = type == 3 and 828 or 650
  if UIHelper.isiPhoneX() then
    self.xPos = self.xPos + 125
  end
  self.baseNode:setPositionX(self.xPos)
  self.showType = type
end

function TopBar_2:hide()
  self.root_panel:hide()
end

function TopBar_2:getShowType()
  local showType = self.showType or TopBarType.full
  if not self.root_panel:isVisible() then
    showType = TopBarType.hide
  end
  local showText
  if self.sign:isVisible() then
    showText = self.title:getString()
  end
  local showBg
  if self.nodeBg:isVisible() then
    showBg = true
  end
  return showType, showText, showBg
end

function TopBar_2:onExit()
  for _, handler in ipairs(self.eventHandlers) do
    game.role:removeEventListener(handler)
  end
  self.extraData = {}
end

return TopBar_2
