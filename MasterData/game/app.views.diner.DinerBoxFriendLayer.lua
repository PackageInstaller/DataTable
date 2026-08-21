local HeadframCsv = require("csvdata.head_circle")
local HeadpicCsv = require("csvdata.head_pic")
local BoxMainRes = "ui/diner/box/"
local uiData = {
  csbFile = "ui/diner/DinerBoxFriendLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    list = "heroBg/list",
    touch = "heroBg/touch",
    btnsNode = "heroBg/btnsNode"
  }
}
local btnsData = {
  [1] = {
    name = "点赞列表",
    func = function(self)
      self:showLikeMeLayer()
    end
  },
  [2] = {
    name = "好友列表",
    func = function(self)
      self:showFriendsLayer()
    end
  }
}
local DinerBoxFriendLayer = class("DinerBoxFriendLayer", UIBase)

function DinerBoxFriendLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerBoxFriendLayer:init(params)
  self.callback = params.callback
  self.touch:setTouchEnabled(true)
  self.touch:setSwallowTouches(true)
  self.select = params.select or 1
  self.listData = {}
  local xPos = 0
  local group = MRadioGroup:create()
  for index, data in ipairs(btnsData) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(BoxMainRes, {"btn_a.png", "btn_b.png"})
    btn:anch(0, 1):pos(xPos, 0):addTo(self.btnsNode)
    btn:setCallback(function()
      self.select = index
      data.func(self)
    end)
    btn:setName(string.format("btn%d", index))
    btn:setGroup(group)
    display.newTTFLabel({
      text = data.name,
      size = 26
    }):enableOutline(UIHelper.hex2rgb("#863b09"), 2):pos(71, 33):addTo(btn)
    xPos = xPos + 155
  end
  group:chooseByName("btn" .. self.select)
end

function DinerBoxFriendLayer:showData(params)
  btnsData[self.select].func(self)
end

function DinerBoxFriendLayer:showLikeMeLayer()
  self.list:removeAllChildren()
  game:sendData(actionCodes.Diner_nearLikeMeRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Diner_nearLikeMeRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    self.listData = msg.list
    if self.refreshHandler then
      scheduler.unscheduleGlobal(self.refreshHandler)
    end
    self.curRow = 0
    self.refreshHandler = scheduler.scheduleGlobal(function()
      self:refreshListWithDelay()
    end, 0.016666666666666666)
  end)
end

function DinerBoxFriendLayer:showFriendsLayer()
  self.list:removeAllChildren()
  game:sendData(actionCodes.Diner_friendListRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Diner_friendListRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    self.listData = msg.list
    if self.refreshHandler then
      scheduler.unscheduleGlobal(self.refreshHandler)
    end
    self.curRow = 0
    self.refreshHandler = scheduler.scheduleGlobal(function()
      self:refreshListWithDelay()
    end, 0.016666666666666666)
  end)
end

function DinerBoxFriendLayer:refreshListWithDelay()
  for row = self.curRow + 1, self.curRow + 10 do
    if row > #self.listData then
      if self.refreshHandler then
        scheduler.unscheduleGlobal(self.refreshHandler)
        self.refreshHandler = nil
      end
      if not next(self.listData) then
        local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.list):addTo(self.list)
        display.newTTFLabel({
          text = self.select == 1 and "暂时没有点赞信息哦" or "暂时没有好友信息哦",
          size = 22,
          color = UIHelper.hex2rgb("#842c17")
        }):pos(395, 120):addTo(bg)
      end
      self.list:requestDoLayout()
      self.list:jumpToTop()
      return
    end
    self:createCell(row, self.listData[row])
  end
  self.curRow = self.curRow + 10
end

local cellSize = cc.size(856, 130)

function DinerBoxFriendLayer:createCell(idx, data)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cellSize):addTo(self.list)
  local cell = display.newSprite(BoxMainRes .. "friend_cell.png"):center(viewNode):addTo(viewNode)
  local bg = UIHelper.newImageView(HeadpicCsv[data.headIconTag].res):pos(70, 63):addTo(cell)
  display.newSprite(HeadframCsv[data.headFrameTag].res):scale(0.8):center(bg):addTo(bg)
  display.newTTFLabel({
    text = "Lv" .. data.level,
    size = 20,
    color = UIHelper.hex2rgb("#ba471a")
  }):anch(0, 0.5):pos(140, 102):addTo(cell)
  local nameBg = display.newSprite("ui/friend/main/name_bg.png"):anch(0, 0.5):pos(130, 63):addTo(cell)
  display.newTTFLabel({
    text = data.name,
    size = 24,
    color = UIHelper.hex2rgb("#ba471a")
  }):anch(0, 0.5):pos(10, 26):addTo(nameBg)
  display.newTTFLabel({
    text = "满足度:",
    size = 20,
    color = UIHelper.hex2rgb("#ba471a")
  }):anch(0, 0.5):pos(140, 30):addTo(cell)
  display.newTTFLabel({
    text = data.comfortPoint,
    size = 20,
    color = UIHelper.hex2rgb("#ba471a")
  }):anch(0, 0.5):pos(215, 30):addTo(cell)
  display.newSprite(BoxMainRes .. "like_small.png"):anch(0, 0.5):pos(295, 33):addTo(cell)
  display.newTTFLabel({
    text = data.like,
    size = 20,
    color = UIHelper.hex2rgb("#ba471a")
  }):anch(0, 0.5):pos(325, 30):addTo(cell)
  if data.time then
    display.newTTFLabel({
      text = CommonHelper.date(data.time, "YmdX"),
      size = 20,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(490, 63):addTo(cell)
  end
  local btnBox = UIHelper.extend(ccui.Button:create())
  btnBox:setImages(BoxMainRes, {
    "btn_box_big.png",
    "btn_box_big.png"
  })
  btnBox:pos(788, 60):addTo(cell):setTouchScale()
  btnBox:setCallback(function()
    game:sendData(actionCodes.Diner_getBoxDataRpc, MsgPack.pack({
      roleId = data.roleId
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Diner_getBoxDataRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.boxData then
        if not msg.boxData.boxes[1].box then
          SysError(SYS_ERROR_FRIEND_NO_BOX)
          return
        end
        msg.boxData.allList = self:getList()
        if not next(msg.boxData.allList) then
          return
        end
        game:enterScene("DinerScene", {
          boxData = msg.boxData,
          layerType = "look"
        })
        BackManager:push(function()
          game:enterScene("DinerScene")
          BackManager:push(function()
            game:enterScene("MainScene", {})
          end)
        end)
      else
        SysError(SYS_ERROR_FRIEND_NO_PLAYER)
      end
    end)
  end)
end

function DinerBoxFriendLayer:getList()
  local list = {}
  local had = {}
  for _, data in ipairs(self.listData) do
    if not had[data.roleId] then
      had[data.roleId] = true
      table.insert(list, data.roleId)
    end
  end
  return list
end

return DinerBoxFriendLayer
