local pureColor = class("pureColor", G_UIModuleBase)

function pureColor.bind()
  return {
    color = C_Color(1, 1, 1, 1)
  }
end

function pureColor.methods()
  return {}
end

function pureColor:open()
end

function pureColor:setParam(colorStr)
  self.bind.color = C_LuaUtility.ParseHtmlStringColor(colorStr)
end

return pureColor
