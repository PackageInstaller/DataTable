local this = class("cellWorldLevel", G_UIModuleBase)

function this.bind()
  return {
    text_level = "",
    go_NormalLock = false,
    go_focusLock = false,
    go_content = true,
    go_normal = false,
    go_currentBg = false,
    go_titleNormal = false,
    go_titleCurlevel = false,
    showMaskActive = false,
    text_title = "",
    backBg = "",
    frontBg = "",
    textTitleActive = false,
    colorFocusSizeBackBg = C_LuaUtility.ParseHtmlStringColor("#ffffff"),
    colorFocusSizeFrontBg = C_LuaUtility.ParseHtmlStringColor("#ffffff")
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

function this:refresh()
end

return this
