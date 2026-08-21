local uiData = {
  csbFile = "ui/home/ChangeNameLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    nameNode = "nameNode",
    confirm = "confirm",
    cancel = "cancel",
    Text1 = "Text1",
    Text2 = "Text2"
  }
}
local ChangeHeroNameLayer = class("ChangeHeroNameLayer", UIBase)

function ChangeHeroNameLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChangeHeroNameLayer:init(params)
  self.Text1:setString("名字修改")
  self.Text2:setString("请输入新的名字（1~6个字）")
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:setTouchScale()
  self.confirm:setTouchScale()
  self.cancel:setCallback(function()
    BackManager:pop()
  end)
end

function ChangeHeroNameLayer:showData(params)
  local hero = game.role.heros[params.heroId]
  local oriName = hero:getName()
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
      SysError(SYS_ERR_CHANGE_HERO_NAME_NOT_NULL)
      return
    elseif 12 < len then
      SysError(SYS_ERR_CHANGE_HERO_NAME_OVERLENGTH)
      return
    end
    if oriName == nameStr then
      BackManager:pop()
      return
    end
    local chars = MRichText:stringToChars(nameStr)
    for _, char in ipairs(chars) do
      if not char:isNormalWords() then
        SysError(SYS_ERR_CHANGE_HERO_NAME_NOT_SUPPORT)
        return
      end
    end
    game:sendData(actionCodes.Hero_changeNameRpc, MsgPack.pack({
      heroId = hero.id,
      name = nameStr
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Hero_changeNameRpc, function(event)
      UIHelper.removeWaiting()
      local data = MsgPack.unpack(event.data)
      if data.code == 1 then
        SysError(SYS_ERR_CHANGE_HERO_NAME_SUCCESS)
        BackManager:pop()
      end
    end)
  end)
end

function ChangeHeroNameLayer:stringToTab(str)
  local tab = {}
  for utfChar in string.gmatch(str, "[%z\001-\127�-�][�-�]*") do
    table.insert(tab, utfChar)
  end
  return tab
end

function ChangeHeroNameLayer:getLength(strs)
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

return ChangeHeroNameLayer
