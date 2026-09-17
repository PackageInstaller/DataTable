local module = class("cellCatalogAttr", G_UIModuleBase)
local bgColorFull = "#A5582580"
local bgColor = "#00000040"

function module.bind()
  return {
    bg_color = C_Color(0, 0, 0, 0),
    img_icon = "",
    txt_value = "",
    txtFull_value = "",
    go_txt = true,
    go_txtFull = false
  }
end

function module.methods()
  return {}
end

function module:refresh()
  if self.bind.index % 2 == 1 then
    if self.bind.isFull then
      local _, tempColor = C_ColorUtility.TryParseHtmlString(bgColorFull)
      self.bind.bg_color = tempColor
    else
      local _, tempColor = C_ColorUtility.TryParseHtmlString(bgColor)
      self.bind.bg_color = tempColor
    end
  end
  self.bind.txt_value = tostring(self.bind.attrVal)
  self.bind.txtFull_value = tostring(self.bind.attrVal)
  self.bind.go_txt = self.bind.isFull
  self.bind.go_txtFull = not self.bind.isFull
  self.bind.img_icon = L_GameTpl:getBattleInfoTpl():getIcon(L_GameTpl:getBattleInfoTpl():getTplById(self.bind.attrId))
end

return module
