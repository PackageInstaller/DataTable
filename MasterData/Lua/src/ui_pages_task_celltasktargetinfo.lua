local item = class("cellTaskTargetInfo", G_UIModuleBase)

function item.bind()
  return {
    txt_info = "",
    toggle_isDone = false,
    color_bg = nil,
    color_iconDone = nil,
    color_iconUndone = nil
  }
end

function item:refresh()
  local textColorStr = self.bind.isSecondary and "#8fb9b9" or "#ffa200"
  local _
  if self.bind.toggle_isDone then
    local colorStr = self.bind.isSecondary and "#8fb9b9" or "#ffa200"
    _, self.bind.color_bg = C_ColorUtility.TryParseHtmlString(colorStr .. "1a")
    _, self.bind.color_iconDone = C_ColorUtility.TryParseHtmlString(colorStr)
    self.bind.txt_info = L_GameUtil.fillColor(string.format("<s>%s</s>", self.bind.txt_info), textColorStr)
  else
    local colorStr = self.bind.isSecondary and "#bad2d1" or "#fdd275"
    _, self.bind.color_bg = C_ColorUtility.TryParseHtmlString(colorStr .. "1a")
    _, self.bind.color_iconUndone = C_ColorUtility.TryParseHtmlString(colorStr)
    self.bind.txt_info = L_GameUtil.fillColor(self.bind.txt_info, textColorStr)
  end
end

return item
