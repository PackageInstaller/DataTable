local FramCsv = require("csvdata.head_circle")
local PicCsv = require("csvdata.head_pic")
local TalkCsv = require("csvdata.talk_bubble")
local ChatRes = "ui/chat/"
local uiData = {
  csbFile = "ui/chat/ChatMainLayer.csb",
  popup = true,
  widgets = {
    touch = "touch",
    listBg = "listBg",
    list = "listBg/list",
    btnSend = "listBg/btnSend",
    btnsList = "listBg/btnsList"
  }
}
local ChatMainLayer = class("ChatMainLayer", UIBase)

function ChatMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChatMainLayer:init(params)
  local width = self.listBg:getContentSize().width
  self.posXdef = 1136
  if UIHelper.isiPhoneX() then
    self.posXdef = math.floor(self.posXdef + UIHelper.getMoveXForX())
    UIHelper.fitForiPhoneX(self.touch, true)
    self.touch:setPositionX(self.touch:getPositionX() - UIHelper.getMoveXForX())
  end
  self.endPosX = self.posXdef + width
  self.listBg:setPositionX(self.endPosX)
  self.listBg:setCallback(function()
  end)
  game.role.toChatRoleId = game.role.toChatRoleId or 0
  self.chatType = params.chatType or "world"
  self.status = 1
  self.chatData = {}
  self.p2pBtns = {}
  self.first = true
  self.max = 60
  self.touch:setTouchEnabled(true)
  self.touch:setSwallowTouches(true)
  self.btnsList:setLocalZOrder(-1)
  self.chatInput = ccui.EditBox:create(cc.size(388, 38), "ui/chat/input_bg.png")
  self.chatInput:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
  self.chatInput:setFontSize(16)
  self.chatInput:setMaxLength(40)
  self.chatInput:setPlaceHolder("")
  self.chatInput:pos(220, 28):addTo(self.listBg)
  self.chatInput:setFontColor(UIHelper.hex2rgb("#612D06"))
  if game.role.chatContent then
    self.chatInput:setText(game.role.chatContent)
    game.role.chatContent = nil
  end
  self.btnSend:setTouchScale()
  self.btnSend:setCallback(function()
    local canChatCount = 0
    local controlLevel = self.chatType == "cross" and globalCsv.chatControlLevel2 or globalCsv.chatControlLevel
    local levelControl = controlLevel:toArray("=", true)
    local roleLevel = game.role.level
    if roleLevel >= levelControl[1] and roleLevel <= levelControl[2] then
      local chatDailyLimit = globalCsv.chatDailyLimit:toArray("=", true)
      canChatCount = chatDailyLimit[1] + chatDailyLimit[2] * (roleLevel - levelControl[1])
    elseif roleLevel > levelControl[2] then
      canChatCount = -1
    end
    if 0 < game.role.cumulCharge then
      canChatCount = -1
    end
    if canChatCount == 0 then
      if self.chatType == "cross" then
        SysError(SYS_ERR_CHAT_LEVEL_LIMIT3)
      else
        SysError(SYS_ERR_CHAT_LEVEL_LIMIT2)
      end
      return
    end
    if canChatCount ~= -1 and canChatCount <= game.role.dailyChatCount then
      SysError(SYS_ERR_CHAT_LEVEL_LIMIT)
      return
    end
    local content = self.chatInput:getText()
    content = string.gsub(content, "\n", " ")
    local contentTemp = string.gsub(content, " ", "")
    if contentTemp:len() == 0 then
      self.chatInput:setText("")
      return
    end
    local result = self:checkStr(content)
    if not result then
      SysError(SYS_ERR_CHAT_CONTENT_NOT_SUPPORT)
      return
    end
    local chars = content:stringToChars()
    for _, char in ipairs(chars) do
      if not char:checkChatWords() then
        SysError(SYS_ERR_CHAT_CONTENT_NOT_SUPPORT)
        return
      end
    end
    game:sendData(actionCodes.Role_chat, MsgPack.pack({
      cmd = self.chatType,
      content = content,
      objectId = self.chatType == "p2p" and game.role.toChatRoleId or nil
    }))
    self.chatInput:setText("")
  end)
  self.chatHandler = game.role:addEventListener("updateChat", function(event)
    if tolua.isnull(self) then
      return
    end
    game.role.redPoints.p2pRedPoints[game.role.toChatRoleId] = 0
    if event.chatType == "p2p" and (self.chatType ~= "p2p" or game.role.toChatRoleId ~= event.toRoleId) then
      self:initChatBtns()
      self:upDateChatRedPoint()
      return
    end
    if event.chatType == "world" and self.chatType == "world" then
      self:showChats(event.newMsg)
    elseif event.chatType == "cross" and self.chatType == "cross" then
      self:showChats(event.newMsg, event.crossNewMsg)
    elseif event.chatType == "p2p" and game.role.toChatRoleId == event.toRoleId then
      self:showChats(event.newMsg)
    elseif event.chatType == "union" and self.chatType == event.chatType then
      self:showChats(event.newMsg)
    end
  end)
  self:changeUI()
  self:initChatBtns()
  self:upDateChatRedPoint()
end

local size = cc.size(150, 60)

function ChatMainLayer:initChatBtns()
  self.p2pBtns = {}
  self.btnsList:removeAllChildren()
  local group = MRadioGroup:create()
  local keys
  if game.role.union and game.role.union ~= 0 then
    keys = {
      "world",
      "cross",
      "union"
    }
  else
    keys = {"world", "cross"}
  end
  for idx, key in ipairs(keys) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size):addTo(self.btnsList)
    local chatBtn = UIHelper.extend(ccui.Button:create())
    chatBtn:setImages(ChatRes, {"btn_a.png", "btn_b.png"})
    chatBtn:pos(96, 30):addTo(viewNode):name(key)
    local text = display.newTTFLabel({
      text = textByKey(string.format("chat_%s", key)),
      size = 20,
      color = UIHelper.hex2rgb("#743a0c")
    }):pos(56, 26):addTo(chatBtn)
    chatBtn:setGroup(group)
    UIHelper.makeFontClear(text)
    chatBtn:setCallback(function()
      self:showWorldChats(key)
    end)
  end
  local count = 0
  for index, roleId in pairs(game.role.p2pChatsIndex) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size):addTo(self.btnsList)
    local p2pBtn = UIHelper.extend(ccui.Button:create())
    p2pBtn:setImages(ChatRes, {"btn_a.png", "btn_b.png"})
    p2pBtn:pos(96, 30):addTo(viewNode):name(tostring(roleId))
    local temp = display.newTTFLabel({
      text = self:getNameById(roleId),
      size = 16,
      color = UIHelper.hex2rgb("#743a0c")
    })
    if temp:getContentSize().width > 90 then
      display.newTTFLabel({
        text = self:getNameById(roleId),
        size = 16,
        color = UIHelper.hex2rgb("#743a0c"),
        dimensions = cc.size(93, 15)
      }):anch(0, 0.5):pos(5, 27):addTo(p2pBtn)
      display.newTTFLabel({
        text = "...",
        size = 16,
        color = UIHelper.hex2rgb("#743a0c")
      }):anch(0, 0.5):pos(90, 27):addTo(p2pBtn)
    else
      temp:anch(0, 0.5):pos(5, 27):addTo(p2pBtn)
    end
    p2pBtn:setGroup(group)
    p2pBtn:setCallback(function()
      self:showP2pChats(roleId)
    end)
    local btnClose = UIHelper.extend(ccui.Button:create())
    btnClose:setImages(ChatRes, {
      "btn_close.png",
      "btn_close.png"
    })
    btnClose:pos(-19, 27):addTo(p2pBtn)
    btnClose:setCallback(function()
      table.remove(game.role.p2pChatsIndex, index)
      game.role.p2pChats[roleId] = nil
      game.role.redPoints.p2pRedPoints[roleId] = nil
      if game.role.toChatRoleId == roleId then
        self:showWorldChats()
      end
      self:initChatBtns()
    end)
    self.p2pBtns[roleId] = p2pBtn
    if game.role.toChatRoleId == roleId then
      self.chatType = "p2p"
      count = index
    end
  end
  self.btnsList:doLayout()
  if count ~= 0 then
    self.btnsList:scrollToItem(count, cc.p(0, 0), cc.p(0, 0))
  end
  group:chooseByName(game.role.toChatRoleId == 0 and "world" or tostring(game.role.toChatRoleId))
end

function ChatMainLayer:showWorldChats(Type)
  self.first = true
  self.chatType = Type or "world"
  game.role.toChatRoleId = 0
  self.list:removeAllChildren()
  self:showChats()
end

function ChatMainLayer:showP2pChats(roleId)
  self.first = true
  self.chatType = "p2p"
  game.role.toChatRoleId = roleId
  game.role.redPoints.p2pRedPoints[roleId] = 0
  self:upDateChatRedPoint()
  self.list:removeAllChildren()
  self:showChats()
end

function ChatMainLayer:getNameById(roleId)
  for _, data in pairs(game.role.p2pChats[roleId] or {}) do
    if data.player.roleId == roleId then
      return data.player.name
    end
  end
  for _, data in pairs(game.role.friend or {}) do
    if data.roleId == roleId then
      return data.name
    end
  end
  return "陌生人"
end

function ChatMainLayer:checkStr(str)
  if not str then
    return
  end
  local patten = {
    "http",
    "ftp",
    "www.",
    ".com",
    ".cn",
    ".net",
    ".org",
    ".cc",
    ".info"
  }
  for _, p in ipairs(patten) do
    if str:match(p) then
      return
    end
  end
  return true
end

function ChatMainLayer:showChats(msg, cross)
  if self.chatType == "world" then
    self.chatData = game.role.worldChats
  elseif self.chatType == "cross" then
    self.chatData = game.role.crossChats
  elseif self.chatType == "union" then
    self.chatData = game.role.unionChats
  else
    self.chatData = game.role.p2pChats[game.role.toChatRoleId] or {}
  end
  if cross then
    for _, data in ipairs(cross) do
      self:updateChatList(data)
    end
  else
    self:updateChatList(msg)
  end
end

function ChatMainLayer:updateChatList(msg)
  if not next(self.chatData) or not self.first and not msg then
    return
  end
  if self.first then
    self.first = false
    if self.refreshHandler then
      scheduler.unscheduleGlobal(self.refreshHandler)
    end
    self.curRow = 0
    self.refreshHandler = scheduler.scheduleGlobal(function()
      self:refreshListWithDelay()
    end, 0.016666666666666666)
  else
    local endData = msg
    local curCount = table.nums(self.list:getItems())
    local curIndex = self.list:getIndex(self.list:getBottommostItemInCurrentView())
    local oldPosY = self.list:getInnerContainerPosition().y
    local oldHeight = self.list:getInnerContainerSize().height
    if curCount >= self.max then
      self.list:removeItem(0)
    end
    self:createCell(endData)
    self.list:forceDoLayout()
    if endData.player.roleId == game.role.id or curCount == curIndex + 1 then
      self.list:jumpToBottom()
    else
      local newHeight = self.list:getInnerContainerSize().height
      local newPosY = oldPosY - (newHeight - oldHeight)
      self.list:stopAutoScroll()
      self.list:setInnerContainerPosition({x = 0, y = newPosY})
    end
  end
end

function ChatMainLayer:upDateChatRedPoint()
  for roleId, value in pairs(game.role.redPoints.p2pRedPoints or {}) do
    local p2pBtn = self.p2pBtns[roleId]
    if p2pBtn then
      local show = 0 < value
      local red = p2pBtn:getChildByTag(99)
      if red and not show then
        p2pBtn:removeChildByTag(99)
      elseif not red and show then
        display.newSprite(ChatRes .. "chat_new.png"):pos(10, 50):addTo(p2pBtn, nil, 99)
      end
    end
  end
end

function ChatMainLayer:createCell(data)
  local viewNode = ccui.Widget:create()
  if data.player.roleId ~= -1 then
    viewNode:setContentSize(cc.size(490, 84))
    local isSelf = data.player.roleId == game.role.id
    local headIconTag = isSelf and game.role.headIconTag or data.player.headIconTag
    local headFrameTag = isSelf and game.role.headFrameTag or data.player.headFrameTag
    local talkFrametag = isSelf and game.role.talkFrameTag or data.player.talkFrameTag
    local headBg = UIHelper.newImageView(PicCsv[headIconTag or 1].res):scale(0.5):pos(35, 35):addTo(viewNode)
    display.newSprite(FramCsv[headFrameTag or 1].res):center(headBg):addTo(headBg)
    headBg:setCallback(function()
      if data.serverId then
        MDialog:double({
          text = "请选择你要进行的操作",
          okText = "屏蔽"
        }, function()
          MDialog:double({
            text = "确定要屏蔽该玩家的聊天信息吗?"
          }, function()
            local str = UserData.informCrossStr or ""
            UserData.informCrossStr = str:setv(data.player.roleId, 1)
            GameState.save(UserData)
          end)
        end)
        return
      end
      game:sendData(actionCodes.Friend_searchRpc, MsgPack.pack({
        roleId = data.player.roleId
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
          showAdd = true,
          chatData = data
        })
      end)
    end)
    local name = display.newTTFLabel({
      text = data.player.name,
      size = 18
    }):anch(0, 0.5):pos(115, 68):addTo(viewNode)
    local unionName
    if data.chatType ~= "union" and data.player.union ~= 0 then
      unionName = display.newTTFLabel({
        text = string.format("[%s]", data.player.unionName),
        size = 16,
        color = UIHelper.hex2rgb("#21fff2")
      }):anch(0, 0.5):pos(120 + name:getContentSize().width, 68):addTo(viewNode)
    end
    local tip = display.newSprite(ChatRes .. (data.serverId and "cross" or self.chatType) .. ".png"):pos(103, 67):addTo(viewNode):name("tip")
    local Tm = CommonHelper.date(data.time)
    local time = display.newTTFLabel({
      text = string.format("%02d:%02d:%02d", Tm.hour, Tm.min, Tm.sec),
      size = 16
    }):anch(1, 0.5):pos(450, 65):addTo(viewNode)
    local textBg = display.newSprite(TalkCsv[talkFrametag].res):anch(0, 0.5):pos(70, 27):addTo(viewNode)
    local label = display.newTTFLabel({
      text = data.content,
      size = 16,
      color = UIHelper.hex2rgb("#612D06"),
      dimensions = cc.size(360, 30)
    }):anch(0, 0.5):pos(95, 30):addTo(viewNode)
    if isSelf then
      textBg:setFlippedX(true)
      textBg:setPositionX(40)
      headBg:setPositionX(465)
      name:anch(1, 0.5):setPositionX(385)
      if unionName then
        unionName:anch(1, 0.5):setPositionX(380 - name:getContentSize().width)
      end
      time:anch(0, 0.5):setPositionX(40)
      label:setPositionX(45)
      tip:setPositionX(400)
    end
  else
    viewNode:setContentSize(cc.size(470, 40))
    display.newSprite(ChatRes .. "build.png"):pos(35, 23):addTo(viewNode)
    MRichText.new({
      text = data.content,
      color = UIHelper.hex2rgb("#ffffff"),
      size = 18,
      maxWidth = 400
    }):anch(0, 0.5):pos(60, 23):addTo(viewNode)
  end
  self.list:insertCustomItem(viewNode, table.nums(self.list:getItems()))
end

function ChatMainLayer:refreshListWithDelay()
  for row = self.curRow + 1, self.curRow + 10 do
    if row > #self.chatData then
      if self.refreshHandler then
        scheduler.unscheduleGlobal(self.refreshHandler)
        self.refreshHandler = nil
      end
      self.list:forceDoLayout()
      self.list:jumpToBottom()
      return
    end
    local data = self.chatData[row]
    if data.chatType == self.chatType then
      self:createCell(data)
    end
  end
  self.curRow = self.curRow + 10
end

function ChatMainLayer:changeUI()
  local xPos = self.listBg:getPositionX()
  if xPos > self.posXdef and xPos < self.endPosX then
    return
  end
  if self.status == 1 then
    self.status = 2
    self.listBg:runAction(transition.sequence({
      cc.EaseOut:create(cc.MoveTo:create(0.3, cc.p(self.posXdef, 320)), 0.8),
      cc.CallFunc:create(function()
        self:showChats()
      end),
      cc.DelayTime:create(0.3),
      cc.CallFunc:create(function()
        self.touch:setCallback(function()
          self:changeUI()
        end)
      end)
    }))
  else
    self.status = 1
    self.listBg:runAction(transition.sequence({
      cc.EaseOut:create(cc.MoveTo:create(0.3, cc.p(self.endPosX, 320)), 0.8),
      cc.CallFunc:create(function()
        game.role.toChatRoleId = 0
        self:close()
      end)
    }))
  end
end

function ChatMainLayer:onExit()
  if self.chatHandler then
    game.role:removeEventListener(self.chatHandler)
    self.chatHandler = nil
  end
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
  local content = self.chatInput:getText()
  if content ~= "" then
    game.role.chatContent = content
  end
end

return ChatMainLayer
