local BannerCsv = require("csvdata.banner")
local ShowRes = "ui/home/scrollShow/"
local uiData = {
  csbFile = "ui/home/ScrollShowLayer.csb",
  widgets = {
    center = "center",
    btn = "center/kuang",
    node = "center/node",
    touch = "center/touch",
    pageView = "center/pageView"
  }
}
local Forward = {
  [0] = {
    func = function(self)
    end,
    check = function()
      return false
    end
  },
  [1] = {
    func = function(self)
      self.root:showShop()
    end,
    check = function()
      return true
    end
  },
  [2] = {
    func = function(self, type)
      self.root:showActivity({selected = type})
    end,
    check = function()
      return true
    end
  },
  [3] = {
    func = function(self)
      self.root:showCarbon()
    end,
    check = function()
      return true
    end
  },
  [4] = {
    func = function(self)
      self.root:showFarm()
    end,
    check = function()
      if not CommonHelper.funcOpen("farm") then
        SysError(SYS_ERR_FUNCOPEN_FARM)
        return
      end
      return true
    end
  },
  [5] = {
    func = function(self)
      self.root:showMission()
    end,
    check = function()
      return true
    end
  },
  [6] = {
    func = function(self)
      self.root:showCook()
    end,
    check = function()
      return true
    end
  },
  [7] = {
    func = function(self)
      self.root:showCook({selected = 3})
    end,
    check = function()
      if not CommonHelper.funcOpen("equip") then
        SysError(SYS_ERR_FUNCOPEN_EQUIP)
        return
      end
      return true
    end
  },
  [8] = {
    func = function(self)
      self.root:showShop({curType = 1, selected = 5})
    end,
    check = function()
      return true
    end
  },
  [9] = {
    func = function(self)
      self.root:showFarmDraw()
    end,
    check = function()
      if not CommonHelper.funcOpen("box") then
        SysError(SYS_ERR_FUNCOPEN_DINER_DRAW)
        return
      end
      return true
    end
  },
  [10] = {
    func = function(self)
      self.root:showShop({curType = 2, selected = 2})
    end,
    check = function()
      if not CommonHelper.funcOpen("box") then
        SysError(SYS_ERR_FUNCOPEN_DINER_SHOP)
        return
      end
      return true
    end
  },
  [11] = {
    func = function(self)
      self.root:showShop({curType = 1, selected = 2})
    end,
    check = function()
      return true
    end
  },
  [12] = {
    func = function(self)
      self.root:showHeros({selected = 4})
    end,
    check = function()
      if not CommonHelper.funcOpen("gift") then
        SysError(SYS_ERR_FUNCOPEN_GIFT)
        return
      end
      return true
    end
  },
  [13] = {
    func = function(self)
      self.root:showUnion()
    end,
    check = function()
      return true
    end
  },
  [14] = {
    func = function(self)
      if not game.role:activityIsOpen(60) then
        return
      end
      game:enterScene("MidAutumnScene", {sceneType = "general2"})
    end,
    check = function()
      return true
    end
  }
}
local ScrollShowLayer = class("ScrollShowLayer", UIBase)

function ScrollShowLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ScrollShowLayer:init(params)
  self:setCascadeOpacityEnabled(true)
  self.center:pos(params.pos[1], params.pos[2])
  self.touch:setTouchEnabled(true)
  self.touch:setSwallowTouches(true)
  self.touch:enableNodeEvents()
  local touchEvent = {
    [ccui.TouchEventType.began] = handler(self, self.onTouchBegan),
    [ccui.TouchEventType.moved] = handler(self, self.onTouchMoved),
    [ccui.TouchEventType.ended] = handler(self, self.onTouchEnded),
    [ccui.TouchEventType.canceled] = handler(self, self.onTouchCancelled)
  }
  self.touch:addTouchEventListener(function(sender, type)
    touchEvent[type](sender)
  end)
  self.root = params.root
  self.delay = params.delay or 8
  if game.role.homeBgTag == 6 then
    self.btn:setImage("ui/home/lty/kuang.png")
  elseif game.role.homeBgTag == 42 then
    self.btn:setImage("ui/home/fouryear/kuang.png")
  end
end

function ScrollShowLayer:showData(params)
  self.curIndex = 1
  self.showCsv = {}
  self.funcs = {}
  self.auto = true
  local showTypes = json.decode(game.role.activityBackStatus) or {}
  for _, data in ipairs(BannerCsv) do
    if data.type > 0 then
      if showTypes[tostring(data.type)] then
        if data.type == 25 then
          if CHANNEL_KEY == "quick" then
          else
            table.insert(self.showCsv, data)
          end
        else
          table.insert(self.showCsv, data)
        end
      end
    else
      table.insert(self.showCsv, data)
    end
  end
  self:initPanel()
end

function ScrollShowLayer:initPanel()
  self.node:removeAllChildren()
  self.pageView:removeAllChildren()
  self.btn:stopAllActions()
  self.max = #self.showCsv
  local posX = -(self.max - 1) / 2 * 16
  for index, data in ipairs(self.showCsv) do
    local layout = ccui.Widget:create()
    layout:setContentSize(self.pageView:getContentSize())
    layout:setCascadeOpacityEnabled(true)
    local Image = UIHelper.newImageView(data.res):anch(0, 0):addTo(layout)
    self.pageView:addPage(layout)
    self["point" .. index] = display.newSprite(ShowRes .. "quan.png"):pos(posX, 10):addTo(self.node)
    self["point" .. index]:setCascadeOpacityEnabled(true)
    self.funcs[tostring(index)] = function()
      local Set = Forward[data.path]
      if Set.check() then
        self.root:openUI()
        Set.func(self, data.type)
      end
    end
    if index == 1 then
      self.point = display.newSprite(ShowRes .. "point.png"):center(self.point1):addTo(self.point1)
    end
    posX = posX + 16
  end
  self:resumeAnimat()
end

function ScrollShowLayer:resumeAnimat()
  self.btn:runAction(cc.RepeatForever:create(transition.sequence({
    cc.DelayTime:create(self.delay),
    cc.CallFunc:create(function()
      self:initSelectedPoint(1)
    end)
  })))
end

function ScrollShowLayer:initSelectedPoint(dir)
  if self.max == 0 then
    return
  end
  dir = dir or 1
  local curIndex = self.curIndex + dir
  if curIndex < 1 then
    curIndex = self.max
  end
  if curIndex > self.max then
    curIndex = 1
  end
  self.point:removeSelf()
  self.point = display.newSprite(ShowRes .. "point.png"):center(self["point" .. curIndex]):addTo(self["point" .. curIndex])
  self.curIndex = curIndex
  if dir < 0 and curIndex == self.max then
    self.pageView:scrollToPage(self.max - 1, 0.3)
    return
  end
  if curIndex == 1 then
    self.pageView:scrollToPage(0, 0.3)
  else
    self.pageView:scrollToPage(curIndex - 1)
  end
end

function ScrollShowLayer:onTouchBegan(sender)
  local beginPos = sender:getBeginPos()
  self.drag = {
    time = os.clock(),
    x = beginPos.x,
    y = beginPos.y
  }
end

function ScrollShowLayer:onTouchMoved(sender)
  if not self.drag then
    return
  end
  local movedPos = sender:getMovePos()
  if movedPos.x < 0 then
    movedPos.x = 0
  end
  if movedPos.x > 460 then
    movedPos.x = 460
  end
  local dalte = movedPos.x - self.drag.x
  local speed = dalte / (os.clock() - self.drag.time) / 100
  if math.abs(dalte) > 150 or math.abs(speed) > 30 then
    self.drag = nil
    self:initSelectedPoint(dalte < 0 and 1 or -1)
  end
  if not self.auto then
    return
  end
  self.auto = false
  self.btn:stopAllActions()
end

function ScrollShowLayer:onTouchEnded(sender)
  if self.max == 0 then
    return
  end
  local pos = sender:getEndPos()
  if self.drag and math.abs(pos.x - self.drag.x) + math.abs(pos.y - self.drag.y) < 15 then
    self.btn:stopAllActions()
    self.funcs[tostring(self.curIndex)]()
  end
  self.drag = nil
  self.auto = true
  self:resumeAnimat()
end

function ScrollShowLayer:onTouchCancelled(sender)
  self:onTouchEnded(sender)
end

function ScrollShowLayer:getKuang()
  return self.btn
end

function ScrollShowLayer:close()
  self.btn:stopAllActions()
end

return ScrollShowLayer
