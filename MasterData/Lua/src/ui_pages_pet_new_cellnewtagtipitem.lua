local module = class("cellNewTagTipItem", G_UIModuleBase)
local Type2BgColor = {
  [0] = "#0000004C",
  [1] = "#b8aecb",
  [2] = "#e5d299",
  [3] = "#b7d4e7"
}

function module.bind()
  return {
    img = CS.UnityEngine.Color(1, 1, 1),
    label = "",
    txt_desc = "",
    size_root = C_Vector2(678, 182)
  }
end

function module:show()
  if self.isBind then
    local color = Type2BgColor[self.bind.type or 0]
    local _, color = C_ColorUtility.TryParseHtmlString(color)
    self.bind.img = color
    self.bind.size_root = C_Vector2(678, self.bindComponents.desc.preferredHeight + 110)
    L_GameUtil.forceRebuildLayout(self.bindComponents.cellTrans)
  end
end

function module:showDetail(isOn)
  if isOn then
    self.bind.txt_desc = self.bind.detailDescribe
  else
    self.bind.txt_desc = self.bind.describe
  end
end

return module
