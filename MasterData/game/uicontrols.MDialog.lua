local GlobalRes = "ui/global/"
local Dialog = {}
local uiData = {
  csbFile = "ui/global/DialogLayer.csb",
  mask = true,
  popup = true,
  opacity = 115,
  widgets = {
    center = "center",
    content = "content",
    title = "title",
    okBtn = "confirm",
    cancelBtn = "cancel",
    text = "text"
  }
}
local uiDataRich = {
  csbFile = "ui/global/DialogLayer.csb",
  mask = true,
  popup = true,
  opacity = 115,
  widgets = {
    center = "center",
    content = "content",
    title = "title",
    okBtn = "confirm",
    cancelBtn = "cancel",
    text = "text"
  }
}
local SingleButtonDialog = class("SingleButtonDialog", UIBase)

function SingleButtonDialog:ctor(params)
  params = params or {}
  uiData.opacity = params.opacity or uiData.opacity
  uiData.tag = params.tag
  uiData.zorder = params.zorder
  uiData.order = params.order
  UIBase.ctor(self, uiData, params)
end

function SingleButtonDialog:init(params)
  game:playMusic(1022)
  self.params = params
  self.text = params.text
  self.size = params.size or 26
  self.color = params.color or UIHelper.hex2rgb("#633c25")
  self.okText = params.okText
  self.callback = params.callback
  if not self.params.title then
  end
  self.title:setString(self.params.title or textByKey("dialog_title"))
  self.cancelBtn:removeSelf()
  local bg = self.okBtn:getParent()
  local richText = MRichText.new({
    text = self.text,
    color = self.color,
    size = self.size,
    maxWidth = 440
  })
  richText:anch(0.5, 0.5):center(self.content):addTo(self.content)
  if self.okText then
    self.okBtn:setTitleText(self.okText)
  end
  self.okBtn:pos(bg:getContentSize().width / 2, self.okBtn:getPositionY())
  self.okBtn:setCallback(function(sender)
    local result = true
    if self.callback then
      if self.callback() == false then
      end
      result = true
    end
    if result then
      self:close()
    end
  end)
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
end

function SingleButtonDialog:setString(params)
  self.content:removeAllChildren()
  local richText = MRichText.new({
    text = params.text,
    color = params.color or self.color,
    size = params.size or self.size
  })
  richText:anch(0.5, 0.5):center(self.content):addTo(self.content)
end

local DoubleButtonDialog = class("DoubleButtonDialog", UIBase)

function DoubleButtonDialog:ctor(params)
  params = params or {}
  uiData.tag = params.tag
  uiData.opacity = params.opacity or uiData.opacity
  uiData.order = params.order
  UIBase.ctor(self, uiData, params)
end

function DoubleButtonDialog:init(params)
  game:playMusic(1022)
  self.params = params
  self.text = params.text
  self.size = params.size or 20
  self.color = params.color or UIHelper.hex2rgb("#633c25")
  self.okText = params.okText
  self.cancelText = params.cancelText
  self.okCallback = params.okCallback
  self.cancelCallback = params.cancelCallback
  self.callback = params.callback
  self.bgClick = params.bgClick
  if not self.params.title then
  end
  self.title:setString(self.params.title or textByKey("dialog_title"))
  local bg = self.okBtn:getParent()
  if params.showSkip then
    local selected = 1
    local tempBg = UIHelper.newImageView("ui/treat/block_bg.png"):pos(235, 90):addTo(bg)
    display.newTTFLabel({
      text = "本日不再提示",
      size = 20,
      color = self.color
    }):anch(0, 0.5):pos(255, 90):addTo(bg)
    tempBg:setCallback(function()
      tempBg:removeAllChildren()
      selected = selected % 2 + 1
      if selected == 2 then
        display.newSprite("ui/treat/yes.png"):center(tempBg):addTo(tempBg)
        UserData.dialogSkipTime = CommonHelper.date(nil, "Ymd", true)
      else
        UserData.dialogSkipTime = nil
      end
    end)
  end
  local richText = MRichText.new({
    text = self.text,
    color = self.color,
    size = self.size,
    maxWidth = 440
  })
  richText:anch(0.5, 0.5):center(self.content):addTo(self.content)
  if self.okText then
    self.okBtn:setTitleText(self.okText)
  end
  self.okBtn:setCallback(function(sender)
    local result = true
    if self.okCallback then
      result = self.okCallback()
    end
    if self.callback then
      self.callback()
    end
    if params.showSkip then
      GameState.save(UserData)
    end
    if result then
      self:close()
    end
  end)
  if self.cancelText then
    self.cancelBtn:setTitleText(self.cancelText)
  end
  self.cancelBtn:setCallback(function(sender)
    local result = true
    if self.cancelCallback then
      result = self.cancelCallback()
    end
    if result then
      self:close()
    end
  end)
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancelBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
end

DialogType = {common = 1, sell = 2}
local RichDialog = class("RichDialog", UIBase)

function RichDialog:ctor(params)
  params = params or {}
  uiDataRich.opacity = params.opacity or uiDataRich.opacity
  uiDataRich.order = params.order
  UIBase.ctor(self, uiDataRich, params)
end

function RichDialog:init(params)
  game:playMusic(1022)
  self.params = params
  self.callback = params.callback
  self.cancelback = params.cancelback
  self.title:setString(self.params.title or textByKey("dialog_title"))
  local bg = self.okBtn:getParent()
  local size = self.content:getContentSize()
  local dialogType = {
    [DialogType.common] = function(params)
      self.text:setString(params.text)
    end,
    [DialogType.sell] = function(params)
      MRichText.new({
        text = params.text,
        size = 22,
        color = UIHelper.hex2rgb("#633c25")
      }):anch(0.5, 0.5):pos(229.5, 65):addTo(self.content)
      MRichText.new({
        text = params.desc,
        size = 18,
        color = UIHelper.hex2rgb("#633c25")
      }):anch(0.5, 0.5):pos(229.5, 35):addTo(self.content)
    end
  }
  local extraType = self.params.type
  local func = dialogType[extraType]
  if func then
    func(self.params)
  else
    print("Error: MDiaLog::RichDialog DialogType not defined")
  end
  self.okBtn:setCallback(function(sender)
    if type(self.callback) == "function" then
      self.callback()
    end
    self:close()
  end)
  self.cancelBtn:setCallback(function(sender)
    if self.cancelback and type(self.cancelback) == "function" then
      self.cancelback()
    end
    self:close()
  end)
  self.okBtn:commonStyle()
  self.cancelBtn:commonStyle()
end

local DialogOptional = class("DialogOptional", UIBase)

function DialogOptional:ctor(params)
  params = params or {}
  UIBase.ctor(self, uiData, params)
end

function DialogOptional:init(params)
  game:playMusic(1022)
  self.params = params
  self.text = params.text
  self.size = params.size or 20
  self.color = params.color or UIHelper.hex2rgb("#633c25")
  self.items = params.items
  self.okText = params.okText
  self.cancelText = params.cancelText
  self.okCallback = params.okCallback
  self.cancelCallback = params.cancelCallback
  self.callback = params.callback
  self.bgClick = params.bgClick
  self.selectItem = nil
  self.title:setString(self.params.title or textByKey("dialog_title"))
  local bg = self.okBtn:getParent()
  if self.okText then
    self.okBtn:setTitleText(self.okText)
  end
  self.okBtn:setCallback(function(sender)
    local result = true
    if self.okCallback then
      result = self.okCallback(self.selectItem)
    end
    if self.callback then
      self.callback()
    end
    if result then
      self:close()
    end
  end)
  if self.cancelText then
    self.cancelBtn:setTitleText(self.cancelText)
  end
  self.cancelBtn:setCallback(function(sender)
    local result = true
    if self.cancelCallback then
      result = self.cancelCallback()
    end
    if result then
      self:close()
    end
  end)
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancelBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self:showItemsList()
end

function DialogOptional:showItemsList()
  local size = self.content:getContentSize()
  local list = ccui.ListView:create()
  list:size(size)
  list:setInnerContainerSize(size)
  list:setClippingEnabled(true)
  list:anch(0, 0):pos(0, 0):addTo(self.content)
  list:setDirection(2)
  local datas = self.items:toTableArray()
  for _, item in pairs(datas) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(100, 100)):addTo(list)
    local giftImage = ItemIcon.new({
      type = tonumber(item[1]),
      count = tonumber(item[2]),
      showTip = true,
      selectCallback = function(type, content)
        self.selectItem = type
        if self.selectImage then
          self.selectImage:removeSelf()
          self.selectImage = nil
        end
        self.selectImage = display.newSprite("ui/global/item_select.png"):center(content):addTo(content)
      end
    }):scale(0.9):pos(50, 50):addTo(viewNode)
  end
  list:doLayout()
end

function Dialog:single(params, callback)
  params.callback = callback
  local dialog = SingleButtonDialog.new(params)
  if UIHelper.isiPhoneX() then
    local glView = cc.Director:getInstance():getOpenGLView()
    local framesize = glView:getFrameSize()
    local scaleY = framesize.height / display.height
    local viewWidth = display.width * scaleY
    dialog:setPositionX((framesize.width - viewWidth) / 2 / scaleY)
  end
  return dialog
end

function Dialog:double(params, callback)
  params.callback = callback
  local dialog = DoubleButtonDialog.new(params)
  if UIHelper.isiPhoneX() then
    local glView = cc.Director:getInstance():getOpenGLView()
    local framesize = glView:getFrameSize()
    local scaleY = framesize.height / display.height
    local viewWidth = display.width * scaleY
    dialog:setPositionX((framesize.width - viewWidth) / 2 / scaleY)
  end
  return dialog
end

function Dialog:rich(params, callback, cancelback)
  params.callback = callback
  params.cancelback = cancelback
  local dialog = RichDialog.new(params)
  if UIHelper.isiPhoneX() then
    local glView = cc.Director:getInstance():getOpenGLView()
    local framesize = glView:getFrameSize()
    local scaleY = framesize.height / display.height
    local viewWidth = display.width * scaleY
    dialog:setPositionX((framesize.width - viewWidth) / 2 / scaleY)
  end
  return dialog
end

function Dialog:optional(params, callback)
  params.callback = callback
  local dialog = DialogOptional.new(params)
  if UIHelper.isiPhoneX() then
    local glView = cc.Director:getInstance():getOpenGLView()
    local framesize = glView:getFrameSize()
    local scaleY = framesize.height / display.height
    local viewWidth = display.width * scaleY
    dialog:setPositionX((framesize.width - viewWidth) / 2 / scaleY)
  end
  return dialog
end

return Dialog
