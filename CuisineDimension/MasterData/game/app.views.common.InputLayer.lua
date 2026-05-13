local SysErrCsv = require("csvdata.sys_codes")
local uiData = {
  csbFile = "ui/carbon/NewBattleResultLayer.csb",
  mask = true,
  popup = true,
  widgets = {touch = "touch"}
}
local InputLayer = class("InputLayer", UIBase)

function InputLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function InputLayer:init(params)
  self.dalteX = 0
  if UIHelper.isiPhoneX() then
    self.dalteX = UIHelper.getMoveXForX()
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.color = params.color or "#998271"
  self.size = params.size or 20
  self.longth = params.longth or 10
  self.content = params.content or ""
  self.holdContent = params.holdContent or "请输入内容"
  self.holdSize = params.holdSize or 20
  self.holdColor = params.holdColor or "#998271"
  self.callback = params.callback or function()
  end
  self.inputMode = params.inputMode or cc.EDITBOX_INPUT_MODE_SINGLELINE
  self.touch:setTouchEnabled(true)
  self.touch:setCallback(function()
    BackManager:pop()
  end)
end

function InputLayer:showData()
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(700, 100)
  mask:anch(0.5, 0.5):pos(display.cx + self.dalteX, 400):addTo(self)
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  local userInput = ccui.EditBox:create(cc.size(602, 42), "ui/global/input_bg.png")
  userInput:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
  userInput:setText(self.content)
  userInput:setFontSize(self.size)
  userInput:setMaxLength(self.longth * 2)
  userInput:setFontColor(UIHelper.hex2rgb(self.color))
  userInput:setInputMode(self.inputMode)
  userInput:setPlaceHolder(self.holdContent)
  userInput:setPlaceholderFontSize(self.holdSize)
  userInput:setPlaceholderFontColor(UIHelper.hex2rgb(self.holdColor))
  userInput:anch(0.5, 0.5):pos(310, 40):addTo(mask)
  display.newTTFLabel({
    text = string.format("最多可输入%s个字", self.longth),
    size = 24
  }):pos(350, 85):addTo(mask)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages("ui/global/", {
    "input_ok.png",
    "input_ok.png"
  })
  btn:pos(660, 40):addTo(mask):setTouchScale()
  btn:setCallback(function()
    local content = userInput:getText()
    local len = self:getLength(self:stringToTab(content))
    if len == 0 then
      SysError(SYS_ERR_UNION_INPUT_NOT_NULL)
      return
    elseif len > self.longth * 2 then
      MFlashMsg:show({
        text = "输入内容超过限制了哦"
      })
      local content = SysErrCsv[SYS_ERR_ROLE_CHANGE_NAME_OVERLENGTH].content
      MFlashMsg:show({
        text = string.format(content, 20)
      })
      return
    end
    self.callback(content)
  end)
  display.newTTFLabel({text = "确定", size = 24}):enableOutline(UIHelper.hex2rgb("#8A450E"), 1):pos(44, 24):addTo(btn)
end

function InputLayer:stringToTab(str)
  local tab = {}
  for utfChar in string.gmatch(str, "[%z\001-\127�-�][�-�]*") do
    table.insert(tab, utfChar)
  end
  return tab
end

function InputLayer:getLength(strs)
  local width = 0
  for _, str in pairs(strs) do
    local len = string.len(str)
    if 1 < len then
      width = width + 2
    else
      width = width + 1
    end
  end
  return width
end

return InputLayer
