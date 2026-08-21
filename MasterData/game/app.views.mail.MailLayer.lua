local MailRes = "ui/mail/"
local uiData = {
  csbFile = "ui/mail/MailLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    mainBg = "mainBg",
    hideMask = "mainBg/hideMask",
    time = "time",
    btnExit = "btnExit",
    listBg = "listBg",
    list = "listBg/list",
    detailLayer = "detailLayer",
    items = "detailLayer/items",
    title = "detailLayer/title",
    countLabel = "countLabel",
    delBtn = "delBtn",
    getBtn = "getBtn",
    postMan = "postMan"
  }
}
local MailLayer = class("MailLayer", UIBase)

function MailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local words = {
  "主厨，您暂时没有邮件",
  "主厨，您有新邮件~",
  "主厨，您的邮件已阅完",
  "主厨，您有未领取的附件"
}

function MailLayer:init(params)
  self.mailList = params.mails
  self.btnExit:setTouchScale()
  self.btnExit:setCallback(function()
    BackManager:pop()
  end)
  self.getBtn:setVisible(false)
  self.contentList = ccui.ListView:create()
  self.contentList:size(cc.size(730, 245))
  self.contentList:setInnerContainerSize(cc.size(730, 245))
  self.contentList:setClippingEnabled(true)
  self.contentList:setBounceEnabled(true)
  self.contentList:anch(0, 1):pos(0, 386):addTo(self.detailLayer)
  UIHelper.MoveToRight({
    node = self.mainBg,
    time = 0.3
  })
  UIHelper.MoveToLeft({
    node = self.postMan,
    time = 0.3
  })
  self.countLabel:setString("收件中...")
  self.hideMask:hide()
  if CHANNEL_NAME == "bili" then
    self.hideMask:show()
  end
  self.delBtn:hide()
  self.delBtn:setCallback(function()
    local canDel = false
    for _, mail in ipairs(self.mailList) do
      if mail.status == 2 or mail.status == 1 and mail.attachments == "" then
        canDel = true
        break
      end
    end
    if not canDel then
      SysError(SYS_ERR_MAIL_CAN_NOT_DEL)
      return
    end
    game:sendData(actionCodes.Email_delRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Email_delRpc, function(event)
      UIHelper.removeWaiting()
      if tolua.isnull(self) then
        return
      end
      local msg = MsgPack.unpack(event.data)
      local result = msg.result
      for _, id in ipairs(result) do
        for index, mail in ipairs(self.mailList) do
          if mail.id == id then
            table.remove(self.mailList, index)
            break
          end
        end
      end
      self:showMails()
    end)
  end)
  self.getBtn:hide()
  self.getBtn:setCallback(function()
    local canGet = false
    for _, mail in ipairs(self.mailList) do
      if mail.status ~= 2 and mail.attachments ~= "" then
        canGet = true
        break
      end
    end
    if not canGet then
      SysError(SYS_ERR_MAIL_CAN_NOT_GET)
      return
    end
    game:sendData(actionCodes.Email_drawAllAttachRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Email_drawAllAttachRpc, function(event)
      UIHelper.removeWaiting()
      if tolua.isnull(self) then
        return
      end
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.items
      })
      for index, mail in ipairs(self.mailList) do
        if msg.ids[mail.id] then
          mail.status = 2
        end
      end
      self:showMails()
    end)
  end)
  self:showMails()
end

function MailLayer:showMails()
  self.countLabel:setString(string.format("收件箱：%d/50", #self.mailList))
  if #self.mailList == 0 then
    self:showPostman()
    self.listBg:hide()
    self.delBtn:hide()
    self.getBtn:hide()
    self.detailLayer:hide()
    return
  end
  self.listBg:show()
  self.delBtn:show()
  self.list:removeAllChildren()
  self.postMan:hide()
  self.curCell = nil
  table.sort(self.mailList, function(a, b)
    local itemA = a.attachments == "" and 0 or 10000000
    local itemB = b.attachments == "" and 0 or 10000000
    local factorA = (2 - a.status) * 100000000 + a.createtime + itemA
    local factorB = (2 - b.status) * 100000000 + b.createtime + itemB
    return factorA > factorB
  end)
  local cellSize = display.newSprite(MailRes .. "cell_1.png"):getContentSize()
  cellSize.height = cellSize.height + 2
  for index, mailData in ipairs(self.mailList) do
    local viewNode = ccui.Widget:create()
    viewNode:size(cellSize):addTo(self.list)
    local cell = UIHelper.newImageView(MailRes .. "cell_1.png")
    cell:center(viewNode):addTo(viewNode)
    local open = mailData.status == 2 or mailData.status == 1 and mailData.attachments == ""
    display.newSprite(MailRes .. (open and "open.png" or "close.png")):pos(30, 35):addTo(cell):name("openTag")
    if mailData.status == 0 then
      display.newSprite(MailRes .. "new.png"):pos(15, 55):addTo(cell):name("newTag")
    end
    local longth = string.len(mailData.title)
    local title = display.newTTFLabel({
      text = mailData.title,
      size = 18,
      align = cc.TEXT_ALIGNMENT_RIGHT,
      color = UIHelper.hex2rgb("6c2e08"),
      dimensions = cc.size(80, 18)
    }):anch(1, 0.5):pos(160, 55):addTo(cell)
    if 12 < longth then
      display.newTTFLabel({
        text = "...",
        size = 18,
        color = UIHelper.hex2rgb("6c2e08")
      }):anch(1, 0.5):pos(160, 55):addTo(cell)
      title:pos(140, 55)
    end
    local time = CommonHelper.date(mailData.createtime)
    local timeStr = time.year .. "/" .. time.month .. "/" .. time.day
    display.newTTFLabel({
      text = timeStr,
      size = 18,
      color = UIHelper.hex2rgb("6c2e08")
    }):anch(1, 0.5):pos(160, 13):addTo(cell)
    cell:setCallback(function()
      self:showDetail(index)
      self:checkRed()
    end)
    mailData.cell = cell
    if 50 <= index then
      break
    end
  end
  self.list:requestDoLayout()
  self:showDetail(1)
  self:checkRed()
end

function MailLayer:showDetail(index)
  local mail = self.mailList[index]
  if not mail then
    return
  end
  self.contentList:removeAllChildren()
  self.detailLayer:show()
  if self.curCell then
    self.curCell:setImage(MailRes .. "cell_1.png")
  end
  local cell = mail.cell
  cell:setImage(MailRes .. "cell_2.png")
  self.curCell = cell
  if mail.status == 0 then
    game:sendData(actionCodes.Email_checkRpc, MsgPack.pack({
      id = mail.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Email_checkRpc, function(event)
      UIHelper.removeWaiting()
      cell:removeChildByName("newTag")
    end)
    mail.status = 1
    if mail.attachments == "" then
      local openTag = cell:getChildByName("openTag")
      openTag:setTexture(MailRes .. "open.png")
    end
  end
  self.title:setString(mail.title)
  local time = CommonHelper.date(mail.createtime)
  local timeStr = time.year .. "/" .. time.month .. "/" .. time.day
  self.time:setString(timeStr)
  self.items:removeAllChildren()
  local text = MRichText.new({
    text = mail.content,
    color = UIHelper.hex2rgb("#815f3d"),
    size = 18,
    maxWidth = 680
  })
  local height = math.max(245, text:getContentSize().height)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(730, height)):addTo(self.contentList)
  text:anch(0, 1):pos(15, height):addTo(viewNode)
  self.contentList:setInnerContainerSize(cc.size(730, height))
  self.contentList:requestDoLayout()
  if mail.status == 2 or mail.attachments == "" then
    return
  end
  local items = mail.attachments:toNumMap()
  local index, interval = 1, -100
  for type, count in pairs(items) do
    if 0 < type then
      ItemIcon.new({
        type = type,
        count = count,
        showTip = true
      }):anch(1, 0):scale(0.9):pos((index - 1) * interval, -25):addTo(self.items)
      index = index + 1
    end
  end
  local okBtn = UIHelper.extend(ccui.Button:create())
  okBtn:setImages("ui/global/", {
    "btn_common.png",
    "btn_common.png"
  })
  okBtn:anch(0, 0):scale(0.9):pos(-420, -83):addTo(self.items)
  okBtn:setCallback(function()
    game:sendData(actionCodes.Email_drawAttachRpc, MsgPack.pack({
      id = mail.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Email_drawAttachRpc, function(event)
      UIHelper.removeWaiting()
      if tolua.isnull(self) then
        return
      end
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.items
      })
      mail.status = 2
      self:showMails()
    end)
  end)
  display.newTTFLabel({
    text = "领取",
    size = 30,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(70, 30):addTo(okBtn)
end

function MailLayer:showPostman()
  self.postMan:show()
  self.postMan:removeAllChildren()
  local contentType = self:findContentType()
  local contentBg = display.newSprite(MailRes .. "content_bg.png"):pos(-30, 380):addTo(self.postMan)
  display.newTTFLabel({
    text = words[contentType],
    size = 22,
    color = UIHelper.hex2rgb("#3e1700")
  }):pos(130, 35):addTo(contentBg)
end

function MailLayer:findContentType()
  if table.nums(self.mailList) == 0 then
    return 1
  end
  local new, draw = false, false
  for _, mailData in pairs(self.mailList) do
    if mailData.status == 0 then
      new = true
    end
    if mailData.status == 1 and mailData.attachments ~= "" then
      draw = true
    end
  end
  if new then
    return 2
  end
  if draw then
    return 4
  end
  return 3
end

function MailLayer:checkRed()
  game.role:setRedDirty("email")
end

return MailLayer
