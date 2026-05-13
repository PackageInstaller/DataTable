local HeadframCsv = require("csvdata.head_circle")
local HeadpicCsv = require("csvdata.head_pic")
local FilterLogic = import("..friend.FilterFriendLogic")
local MainRes = "ui/friend/main/"
local uiData = {
  csbFile = "ui/friend/FriendMainLayer.csb",
  widgets = {
    mainBg = "mainBg",
    btnsBg = "btnsBg",
    up = "up",
    mask = "mask",
    btnList = "btnsBg/btnList",
    list = "panel/list",
    extra = "panel/extra",
    rightBg = "panel/extra/rightBg",
    myId = "panel/extra/myId",
    btnSearch = "panel/extra/btnSearch",
    btnRefresh = "panel/extra/btnRefresh",
    filterBg = "filterBg",
    order2 = "filterBg/order2",
    order3 = "filterBg/order3",
    num = "filterBg/num"
  }
}
local btnData = {
  [1] = {
    name = "好友列表",
    red = "newFriend"
  },
  [2] = {
    name = "好友添加",
    red = ""
  },
  [3] = {
    name = "好友申请",
    red = "newApply"
  }
}
local orderData2 = {
  [1] = "等级排序",
  [2] = "登录排序"
}
local orderData3 = {
  [1] = "降序",
  [2] = "升序"
}
local orderRules2 = {
  [1] = "level",
  [2] = "login"
}
local orderRules3 = {
  [1] = "Desc",
  [2] = "Asc"
}
local FriendMainLayer = class("FriendMainLayer", UIBase)

function FriendMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function FriendMainLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - 75)
  end
  TopBar:show(TopBarType.full, "好友")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  UIHelper.MoveToLeft({
    node = self.filterBg,
    delay = 0.2
  })
  self.selectType = params.selected or 1
  self.refreshCD = 10
  self.friendsCount = 0
  self.btns = {}
  self.handlers = {}
  self.randomList = {}
  self.size = display.newSprite(MainRes .. "cell.png"):getContentSize()
  self.size.height = self.size.height + 6
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  self.mask:hide()
  self.group = MRadioGroup:create()
  local btnSize = display.newSprite("ui/hero/taocan_1.png"):getContentSize()
  local delay = 0.4
  for index, data in ipairs(btnData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(btnSize):addTo(self.btnList)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/hero/", {
      "taocan_1.png",
      "taocan_2.png"
    })
    btn:center(viewNode):addTo(viewNode)
    btn:setString({
      text = data.name,
      size = 22
    })
    btn:setCascadeOpacityEnabled(true)
    btn:setCallback(function()
      self.selectType = index
      self:refreshContent()
    end)
    btn:setName(string.format("name%d", index))
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
    btn:setGroup(self.group)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.friend[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(15, 5))
    end
    UIHelper.MoveToRight({
      node = btn,
      delay = delay,
      time = 0.18
    })
    delay = delay + 0.1
  end
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "friend" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.friend[red])
        if bShow and (self.selectType == 1 and red == "newFriend" or self.selectType == 3 and red == "newApply") then
          self:refreshContent()
        end
        UIHelper.showRedPoint(btn, bShow, cc.p(15, 5))
      end
    end
  end))
  self.group:chooseByName("name" .. self.selectType)
  for i = 2, 3 do
    self["order" .. i]:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#054b6c"), 1)
    self["order" .. i]:setTouchScale()
  end
  self.sortOrder1 = {}
  self.sortOrder2 = 1
  self.sortOrder3 = 1
  self.order2:setString({
    text = orderData2[self.sortOrder2],
    size = 20
  })
  self.order3:setString({
    text = orderData3[self.sortOrder3],
    size = 20
  })
  local rule = orderRules2[self.sortOrder2] .. orderRules3[self.sortOrder3]
  self.friendFilter = FilterLogic.new({sortRule = rule})
  self.order2:setCallback(function(sender)
    self.sortOrder2 = self.sortOrder2 + 1
    if self.sortOrder2 > #orderRules2 then
      self.sortOrder2 = 1
    end
    self.order2:setString({
      text = orderData2[self.sortOrder2],
      size = 20
    })
    rule = orderRules2[self.sortOrder2] .. orderRules3[self.sortOrder3]
    self:setFilter({order = rule})
    self:refreshContent()
  end)
  self.order3:setCallback(function(sender)
    self.sortOrder3 = self.sortOrder3 + 1
    if self.sortOrder3 > #orderRules3 then
      self.sortOrder3 = 1
    end
    self.order3:setString({
      text = orderData3[self.sortOrder3],
      size = 20
    })
    rule = orderRules2[self.sortOrder2] .. orderRules3[self.sortOrder3]
    self:setFilter({order = rule})
    self:refreshContent()
  end)
  local userInput = ccui.EditBox:create(cc.size(290, 26), "ui/friend/main/text_bg.png")
  userInput:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
  userInput:setFontSize(20)
  userInput:setMaxLength(15)
  userInput:setPlaceHolder("输入ID")
  userInput:setPlaceholderFontSize(20)
  userInput:setPlaceholderFontColor(UIHelper.hex2rgb("#86522a"))
  userInput:center(self.rightBg):addTo(self.rightBg)
  userInput:setFontColor(UIHelper.hex2rgb("#dea826"))
  self.needWait = false
  self.myId:setString("我的ID:" .. game.role.id)
  self.btnRefresh:setTouchScale()
  self.btnRefresh:setCallback(function()
    if self.needWait then
      SysError(SYS_ERROR_FRIEND_ID_IS_EXIST)
      return
    end
    self:refreshContent()
  end)
  self.btnSearch:setTouchScale()
  self.btnSearch:setCallback(function()
    local id = userInput:getText()
    if id == "" then
      return
    end
    if type(tonumber(id)) ~= "number" then
      SysError(SYS_ERROR_FRIEND_ID_IS_WRONG)
      return
    end
    if tonumber(id) == game.role.id then
      SysError(SYS_ERROR_FRIEND_ID_IS_SELF)
      return
    end
    game:sendData(actionCodes.Friend_searchRpc, MsgPack.pack({
      roleId = tonumber(id)
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Friend_searchRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.result then
        SysError(msg.result)
        return
      end
      game:createView("friend.FriendDetailLayer", {
        role = msg.roleInfo,
        showAdd = true
      })
    end)
  end)
  self:refreshContent()
end

function FriendMainLayer:refreshContent()
  self.list:removeAllChildren()
  if self.selectType == 1 then
    self.order2:show()
    self.order3:show()
    self.extra:hide()
    self:showFriendList()
  elseif self.selectType == 2 then
    self.order2:hide()
    self.order3:hide()
    self.extra:show()
    self:showRandomList()
  else
    self.order2:hide()
    self.order3:hide()
    self.extra:hide()
    self:showApplyList()
  end
end

function FriendMainLayer:showFriendList()
  game:sendData(actionCodes.Friend_listRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Friend_listRpc, function(event)
    UIHelper.removeWaiting()
    if game.role.friendRed.newFriend then
      game.role.friendRed.newFriend = nil
      game.role:setRedDirty("friend")
    end
    local msg = MsgPack.unpack(event.data)
    game.role.friend = msg.list
    self.friendFilter:setSource(game.role.friend)
    self.show = self.friendFilter:getResult()
    self.friendsCount = table.nums(game.role.friend)
    self:reSetFriendNum()
    self.friendList = {}
    for i = 1, #self.show do
      table.insert(self.friendList, self.show[i].roleId)
    end
    if self.refreshHandler then
      scheduler.unscheduleGlobal(self.refreshHandler)
    end
    self.curRow = 0
    self.refreshHandler = scheduler.scheduleGlobal(function()
      self:refreshListWithDelay()
    end, 0.016666666666666666)
  end)
end

function FriendMainLayer:refreshListWithDelay()
  for row = self.curRow + 1, self.curRow + 10 do
    if row > #self.show then
      if self.refreshHandler then
        scheduler.unscheduleGlobal(self.refreshHandler)
        self.refreshHandler = nil
      end
      if not next(self.show) then
        local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.list):addTo(self.list)
        display.newTTFLabel({
          text = "主厨，您暂时还没有好友哦",
          size = 22,
          color = UIHelper.hex2rgb("#842c17")
        }):pos(395, 120):addTo(bg)
      end
      self.list:requestDoLayout()
      return
    end
    local data = self.show[row]
    local viewNode = UIHelper.extend(ccui.Widget:create())
    viewNode:size(self.size):addTo(self.list)
    local cell = display.newSprite(MainRes .. "cell.png"):center(viewNode):addTo(viewNode)
    local bg = UIHelper.newImageView(HeadpicCsv[data.headIconTag].res):pos(70, 63):addTo(cell)
    display.newSprite(HeadframCsv[data.headFrameTag].res):scale(0.8):center(bg):addTo(bg)
    display.newTTFLabel({
      text = "Lv" .. data.level,
      size = 20,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(140, 95):addTo(cell)
    local nameBg = display.newSprite(MainRes .. "name_bg.png"):anch(0, 0.5):pos(130, 63):addTo(cell)
    local name = display.newTTFLabel({
      text = data.name,
      size = 24,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(10, 20):addTo(nameBg)
    if data.unionName and data.unionName ~= "" then
      display.newTTFLabel({
        text = string.format("[%s]", data.unionName),
        size = 16,
        color = UIHelper.hex2rgb("#4aa60c")
      }):anch(0, 0.5):pos(10 + name:getContentSize().width, 18):addTo(nameBg)
    end
    local btnBox = UIHelper.extend(ccui.Button:create())
    btnBox:setImages(MainRes, {"box.png", "box.png"})
    btnBox:pos(687, 63):addTo(cell):setTouchScale()
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
          msg.boxData.allList = self.friendList
          game:enterScene("DinerScene", {
            boxData = msg.boxData,
            layerType = "look"
          })
          BackManager:push(function()
            game:enterScene("MainScene", {layer = "friend"})
          end)
        else
          SysError(SYS_ERROR_FRIEND_NO_PLAYER)
        end
      end)
    end)
    if data.online then
      display.newTTFLabel({
        text = "在线",
        size = 16,
        color = UIHelper.hex2rgb("#4aa60c")
      }):anch(0, 0.5):pos(280, 95):addTo(cell)
      local image = UIHelper.newImageView(MainRes .. "chat_a.png"):pos(770, 63):addTo(cell)
      image:setCallback(function()
        game.role.toChatRoleId = data.roleId
        for _, roleId in pairs(game.role.p2pChatsIndex) do
          if roleId == data.roleId then
            game:enterScene("MainScene", {layer = "chat"})
            return
          end
        end
        table.insert(game.role.p2pChatsIndex, 1, data.roleId)
        game:enterScene("MainScene", {layer = "chat"})
      end)
    else
      display.newTTFLabel({
        text = "最后上线: " .. UIHelper.getPassTimeDesc(game:nowTime() - data.lastLoginTime),
        size = 16,
        color = UIHelper.hex2rgb("#ba471a")
      }):anch(0, 0.5):pos(280, 95):addTo(cell)
      local image = UIHelper.newImageView(MainRes .. "chat_b.png"):pos(770, 63):addTo(cell)
      image:setCallback(function()
        SysError(SYS_ERROR_CHAT_NOT_ONLINE)
      end)
    end
    local btnAdd = UIHelper.extend(ccui.Button:create())
    btnAdd:setImages(MainRes, {
      "btn_delete.png",
      "btn_delete.png"
    })
    btnAdd:pos(855, 63):addTo(cell):setTouchScale()
    btnAdd:setCallback(function()
      MDialog:double({
        title = "删除提示",
        text = "删除好友后双方将解除好友关系，确定要删除吗？"
      }, function()
        game:sendData(actionCodes.Friend_deleteRpc, MsgPack.pack({
          roleId = data.roleId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Friend_deleteRpc, function(event)
          UIHelper.removeWaiting()
          game.role.p2pChats[data.roleId] = nil
          game.role.redPoints.p2pRedPoints[data.roleId] = nil
          for index, id in pairs(game.role.p2pChatsIndex) do
            if id == data.roleId then
              table.remove(game.role.p2pChatsIndex, index)
              break
            end
          end
          self:removeAction(viewNode, function()
            self:refreshContent()
          end)
        end)
      end)
    end)
    viewNode:setCallback(function()
      game:createView("friend.FriendDetailLayer", {role = data})
    end)
    if data.isNew then
      display.newSprite("ui/global/msg_new.png"):scale(0.64):pos(898, 115):addTo(cell)
    end
  end
  self.curRow = self.curRow + 10
end

function FriendMainLayer:showApplyList()
  game:sendData(actionCodes.Friend_applyListRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Friend_applyListRpc, function(event)
    UIHelper.removeWaiting()
    if game.role.friendRed.newApply then
      game.role.friendRed.newApply = nil
      game.role:setRedDirty("friend")
    end
    local msg = MsgPack.unpack(event.data)
    local roles = msg.list
    for index, data in pairs(roles) do
      local viewNode = UIHelper.extend(ccui.Widget:create())
      viewNode:size(self.size):addTo(self.list)
      local cell = display.newSprite(MainRes .. "cell.png"):center(viewNode):addTo(viewNode)
      local bg = UIHelper.newImageView(HeadpicCsv[data.headIconTag].res):pos(70, 63):addTo(cell)
      display.newSprite(HeadframCsv[data.headFrameTag].res):scale(0.8):center(bg):addTo(bg)
      display.newTTFLabel({
        text = "Lv" .. data.level,
        size = 20,
        color = UIHelper.hex2rgb("#ba471a")
      }):anch(0, 0.5):pos(140, 95):addTo(cell)
      local space = game:nowTime() - data.lastLoginTime
      display.newTTFLabel({
        text = "最后上线: " .. UIHelper.getPassTimeDesc(space),
        size = 16,
        color = UIHelper.hex2rgb("#ba471a")
      }):anch(0, 0.5):pos(280, 95):addTo(cell)
      local nameBg = display.newSprite(MainRes .. "name_bg.png"):anch(0, 0.5):pos(130, 63):addTo(cell)
      display.newTTFLabel({
        text = data.name,
        size = 24,
        color = UIHelper.hex2rgb("#ba471a")
      }):anch(0, 0.5):pos(10, 20):addTo(nameBg)
      local btnAgree = UIHelper.extend(ccui.Button:create())
      btnAgree:setImages(MainRes, {
        "btn_agree.png",
        "btn_agree.png"
      })
      btnAgree:setString({text = "同意", size = 20})
      btnAgree:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
      btnAgree:pos(855, 63):addTo(cell):setTouchScale()
      local btnAgainst = UIHelper.extend(ccui.Button:create())
      btnAgainst:setImages(MainRes, {
        "btn_against.png",
        "btn_against.png"
      })
      btnAgainst:setString({text = "拒绝", size = 20})
      btnAgainst:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
      btnAgainst:pos(760, 63):addTo(cell):setTouchScale()
      btnAgree:setCallback(function()
        if self.friendsCount >= globalCsv.friendListLimit then
          SysError(SYS_ERROR_FRIEND_SELF_FULL)
          return
        end
        game:sendData(actionCodes.Friend_handleApplyRpc, MsgPack.pack({
          cmd = 1,
          roleId = data.roleId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Friend_handleApplyRpc, function(event)
          UIHelper.removeWaiting()
          local msgRes = MsgPack.unpack(event.data)
          if not msgRes.result then
            self:reSetFriendNum(1)
            self:removeAction(viewNode, function()
              self:refreshContent()
            end)
          else
            SysError(msgRes.result)
          end
        end)
      end)
      btnAgainst:setCallback(function()
        game:sendData(actionCodes.Friend_handleApplyRpc, MsgPack.pack({
          cmd = 0,
          roleId = data.roleId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Friend_handleApplyRpc, function(event)
          UIHelper.removeWaiting()
          self:removeAction(viewNode, function()
            self:refreshContent()
          end)
        end)
      end)
      viewNode:setCallback(function()
        game:createView("friend.FriendDetailLayer", {role = data})
      end)
    end
    if not next(roles) then
      local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.list):addTo(self.list)
      display.newTTFLabel({
        text = "主厨，您暂时没有好友请求哦",
        size = 22,
        color = UIHelper.hex2rgb("#842c17")
      }):pos(395, 120):addTo(bg)
    end
    self.list:requestDoLayout()
  end)
end

function FriendMainLayer:showRandomList()
  if self.needWait then
    self:createRandomFriend()
    return
  end
  self.extra:runAction(transition.sequence({
    cc.CallFunc:create(function()
      self.needWait = true
    end),
    cc.DelayTime:create(self.refreshCD),
    cc.CallFunc:create(function()
      self.needWait = false
    end)
  }))
  game:sendData(actionCodes.Friend_randomRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Friend_randomRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    self.randomList = msg.list
    self:createRandomFriend()
  end)
end

function FriendMainLayer:createRandomFriend()
  for index, data in pairs(self.randomList) do
    local viewNode = UIHelper.extend(ccui.Widget:create())
    viewNode:size(self.size):addTo(self.list)
    local cell = display.newSprite(MainRes .. "cell.png"):center(viewNode):addTo(viewNode)
    local bg = UIHelper.newImageView(HeadpicCsv[data.headIconTag].res):pos(70, 63):addTo(cell)
    display.newSprite(HeadframCsv[data.headFrameTag].res):scale(0.8):center(bg):addTo(bg)
    display.newTTFLabel({
      text = "Lv" .. data.level,
      size = 20,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(140, 95):addTo(cell)
    local space = game:nowTime() - data.lastLoginTime
    display.newTTFLabel({
      text = "最后上线: " .. UIHelper.getPassTimeDesc(space),
      size = 16,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(280, 95):addTo(cell)
    local nameBg = display.newSprite(MainRes .. "name_bg.png"):anch(0, 0.5):pos(130, 63):addTo(cell)
    display.newTTFLabel({
      text = data.name,
      size = 24,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(10, 20):addTo(nameBg)
    local btnAdd = UIHelper.extend(ccui.Button:create())
    btnAdd:setImages(MainRes, {
      "btn_add.png",
      "btn_add.png"
    })
    btnAdd:pos(855, 63):addTo(cell):setTouchScale()
    btnAdd:setCallback(function()
      if self.friendsCount >= globalCsv.friendListLimit then
        SysError(SYS_ERROR_FRIEND_SELF_FULL)
        return
      end
      game:sendData(actionCodes.Friend_applyRpc, MsgPack.pack({
        roleId = data.roleId
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Friend_applyRpc, function(event)
        UIHelper.removeWaiting()
        local msgRes = MsgPack.unpack(event.data)
        if not msgRes.result then
          btnAdd:removeSelf()
          return
        end
        SysError(msgRes.result)
      end)
    end)
    viewNode:setCallback(function()
      game:createView("friend.FriendDetailLayer", {role = data})
    end)
  end
  if not next(self.randomList) then
    local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.list):addTo(self.list)
    display.newTTFLabel({
      text = "主厨，暂时没有匹配到玩家，请稍后再试",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(440, 120):addTo(bg)
  end
  self.list:requestDoLayout()
end

function FriendMainLayer:reSetFriendNum(dalte)
  if dalte then
    self.friendsCount = self.friendsCount + dalte
  end
  self.num:setString(string.format("%d/%d", self.friendsCount, globalCsv.friendListLimit))
end

function FriendMainLayer:setFilter(params)
  if params.order then
    self.friendFilter:orderByRule({
      rule = params.order
    })
  end
  if params.profession then
    self.friendFilter:filterByProfession({
      profession = params.profession
    })
  end
end

function FriendMainLayer:removeAction(node, callback)
  node:runAction(transition.sequence({
    cc.CallFunc:create(function()
      self.mask:show()
    end),
    cc.MoveBy:create(0.3, cc.p(950, 0)),
    cc.CallFunc:create(function()
      self.mask:hide()
      if callback then
        callback()
      end
    end)
  }))
end

function FriendMainLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
end

return FriendMainLayer
