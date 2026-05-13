local ButtonEx = {}
BUTTON_STATE_NORMAL = 1
BUTTON_STATE_SELECTED = 2
BUTTON_STATE_DISABLE = 3
ButtonEx.musicId = 1000

function ButtonEx:setGroup(group)
  self.group = group
  self.group:add(self)
end

function ButtonEx:setCallback(callback)
  local function callback3(sender)
    if self.group then
      self.group:choose(self)
    end
    if callback then
      callback(sender)
      game:playMusic(self.musicId)
    end
  end
  
  self:setCallbackTotal(nil, nil, callback3, nil)
end

function ButtonEx:setMusicId(m_id)
  self.musicId = m_id
end

function ButtonEx:setTouchScale()
  self.touchScale = true
end

function ButtonEx:setCallbackTotal(callback1, callback2, callback3, callback4)
  local function func(sender, type)
    if type == ccui.TouchEventType.began then
      if callback1 then
        callback1(sender)
      end
      if self.touchScale then
        self:scale(self:getScale() * 9 / 10)
      end
    elseif type == ccui.TouchEventType.moved then
      if callback2 then
        callback2(sender)
      end
    elseif type == ccui.TouchEventType.ended then
      if callback3 then
        callback3(sender)
      end
      if self.touchScale then
        self:scale(self:getScale() * 10 / 9)
      end
    elseif type == ccui.TouchEventType.canceled then
      if callback4 then
        callback4(sender)
      end
      if self.touchScale then
        self:scale(self:getScale() * 10 / 9)
      end
    end
  end
  
  self:addTouchEventListener(func)
  self.callback = callback3
end

function ButtonEx:setImages(path, files)
  self.images = {}
  self.texType = path and ccui.TextureResType.localType or ccui.TextureResType.plistType
  self.images[1] = path and path .. "/" .. files[1] or files[1]
  self:loadTextureNormal(self.images[1], self.texType)
  if files[1] == "btn_common.png" then
    self:__commonStyle()
  end
  if files[2] then
    self.images[2] = path and path .. "/" .. files[2] or files[2]
    self:loadTexturePressed(self.images[2], self.texType)
  end
  if files[3] then
    self.images[3] = path and path .. "/" .. files[3] or files[3]
    self:loadTextureDisabled(self.images[3], self.texType)
  end
end

function ButtonEx:setEnabled(b)
  self:setBright(b)
  self:setTouchEnabled(b)
  self.enabled = b
  if self.defaultColor then
    if b then
      self:setTitleColor(self.defaultColor)
      self:getTitleRenderer():enableOutline(self.defaultOutline, 1)
    else
      self:setTitleColor(self.defaultGray)
      self:getTitleRenderer():enableOutline(self.defaultGrayOutline, 1)
    end
  end
end

function ButtonEx:isEnabled()
  return self.enabled
end

function ButtonEx:setState(state)
  if state == BUTTON_STATE_NORMAL then
    self:setBrightStyle(BRIGHT_NORMAL)
  elseif state == BUTTON_STATE_SELECTED then
    self:setBrightStyle(BRIGHT_HIGHLIGHT)
  else
    self:setEnabled(false)
  end
end

function ButtonEx:setString(params)
  params = params or {}
  local text = params.text or ""
  local color = params.color or self.defaultColor or display.COLOR_WHITE
  local fontSize = params.fontSize or self.defaultSize or params.size or 26
  local font = params.font or display.DEFAULT_TTF_FONT
  self:setTitleFontSize(fontSize)
  self:setTitleColor(color)
  self:setTitleText(text)
  self:setTitleFontName(font)
  if self.defaultOutline then
    self:getTitleRenderer():enableOutline(self.defaultOutline, 1)
  end
  if self.defaultShadowColor then
    self:getTitleRenderer():enableShadow(self.defaultShadowColor, cc.size(0, -2), 1)
  end
end

function ButtonEx:__commonStyle()
  self:setTouchScale()
  self.defaultColor = UIHelper.hex2rgb("#ffffff")
  self.defaultGray = UIHelper.hex2rgb("#676e3d")
  self.defaultGrayOutline = UIHelper.hex2rgb("#3f1b09")
  self.defaultSize = 28
  self.defaultOutline = UIHelper.hex2rgb("#6d2b15")
  self.defaultShadowColor = UIHelper.hex2rgb("#000000")
end

function ButtonEx:commonStyle()
  self:__commonStyle()
  self:setTitleFontSize(self.defaultSize)
  self:setTitleColor(self.defaultColor)
  self:getTitleRenderer():enableOutline(self.defaultOutline, 1)
end

function ButtonEx:addFollowChild(widget, offset)
  local renderer1 = self:getVirtualRenderer()
  self:setBrightStyle(1)
  local renderer2 = self:getVirtualRenderer()
  self:setBrightStyle(0)
  offset = offset or cc.p(0, 0)
  renderer1:addChild(widget)
  widget:setPosition(cc.p(renderer1:getContentSize().width / 2 + offset.x, renderer1:getContentSize().height / 2 + offset.y))
  local widget2 = widget:clone()
  renderer2:addChild(widget2)
  widget2:setPosition(cc.p(renderer2:getContentSize().width / 2 + offset.x, renderer2:getContentSize().height / 2 + offset.y))
end

return ButtonEx
