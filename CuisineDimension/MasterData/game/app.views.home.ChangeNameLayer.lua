local SysErrCsv = require("csvdata.sys_codes")
local uiData = {
  csbFile = "ui/home/ChangeNameLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    nameNode = "nameNode",
    confirm = "confirm",
    cancel = "cancel"
  }
}
local ChangeNameLayer = class("ChangeNameLayer", UIBase)

function ChangeNameLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChangeNameLayer:init(params)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:setTouchScale()
  self.confirm:setTouchScale()
  self.cancel:setCallback(function()
    BackManager:pop()
  end)
end

function ChangeNameLayer:showData(params)
  local oriName = game.role.name
  local userInput = ccui.EditBox:create(cc.size(388, 38), "ui/home/roleDetail/name_bg.png")
  userInput:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
  userInput:setText(oriName)
  userInput:setFontSize(26)
  userInput:setMaxLength(30)
  userInput:anch(0.5, 0.5):addTo(self.nameNode)
  userInput:setFontColor(UIHelper.hex2rgb("#6f4925"))
  userInput:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
  self.confirm:setCallback(function()
    local nameStr = userInput:getText()
    local len = self:getLength(self:stringToTab(nameStr))
    if len == 0 then
      SysError(SYS_ERR_CHANGE_NAME_NOT_NULL)
      return
    elseif 16 < len then
      local content = SysErrCsv[SYS_ERR_ROLE_CHANGE_NAME_OVERLENGTH].content
      MFlashMsg:show({
        text = string.format(content, 8)
      })
      return
    end
    if oriName == nameStr then
      BackManager:pop()
      return
    end
    local chars = MRichText:stringToChars(nameStr)
    for _, char in ipairs(chars) do
      if not char:isNormalWords() then
        SysError(SYS_ERR_ROLE_CHANGE_NAME_NOT_SUPPORT)
        return
      end
    end
    game:sendData(actionCodes.Role_changeNameRpc, MsgPack.pack({name = nameStr}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_changeNameRpc, function(event)
      UIHelper.removeWaiting()
      local data = MsgPack.unpack(event.data)
      if data.code ~= 0 then
        SysError(SYS_ERR_ROLE_CHANGE_NAME_SUCCESS)
        BackManager:pop()
      end
    end)
  end)
end

function ChangeNameLayer:stringToTab(str)
  local tab = {}
  for utfChar in string.gmatch(str, "[%z\001-\127Â-ô][€-¿]*") do
    table.insert(tab, utfChar)
  end
  return tab
end

function ChangeNameLayer:getLength(strs)
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

return ChangeNameLayer
