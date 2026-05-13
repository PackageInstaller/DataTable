local uiData = {
  csbFile = "ui/union/UnionDeclarationLayer.csb",
  mask = true,
  widgets = {
    touch = "touch",
    panel = "panel",
    mask = "panel/mask",
    title = "panel/title",
    btnClose = "panel/btnClose",
    confirm = "panel/confirm",
    cancel = "panel/cancel"
  }
}
local UnionDeclarationLayer = class("UnionDeclarationLayer", UIBase)

function UnionDeclarationLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionDeclarationLayer:init(params)
  self.mask:setSwallowTouches(true)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.btnClose:setCallback(function()
    BackManager:pop()
  end)
  self.cancel:setCallback(function()
    BackManager:pop()
  end)
  self.callback = params.callback or function()
  end
  self:showDetail()
end

function UnionDeclarationLayer:showDetail()
  local unionDeclaration = "点击此处输入申请宣言"
  local userInput = ccui.EditBox:create(cc.size(585, 142), "ui/home/roleDetail/name_bg.png")
  userInput:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
  userInput:setFontSize(20)
  userInput:setMaxLength(40)
  userInput:setPlaceHolder(unionDeclaration)
  userInput:setPlaceholderFontSize(20)
  userInput:setPlaceholderFontColor(UIHelper.hex2rgb("#86522a"))
  userInput:anch(0.5, 0.5):pos(336, 173):addTo(self.panel)
  userInput:setFontColor(UIHelper.hex2rgb("#6f4925"))
  userInput:setText("请让我加入协会吧")
  self.confirm:setCallback(function()
    local txtStr = userInput:getText()
    local len = self:getLength(self:stringToTab(txtStr))
    if len == 0 then
      SysError(SYS_ERR_UNION_INPUT_NOT_NULL)
      return
    end
    self.callback(txtStr)
  end)
end

function UnionDeclarationLayer:stringToTab(str)
  local tab = {}
  if not str then
    return tab
  end
  for utfChar in string.gmatch(str, "[%z\001-\127�-�][�-�]*") do
    table.insert(tab, utfChar)
  end
  return tab
end

function UnionDeclarationLayer:getLength(strs)
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

return UnionDeclarationLayer
