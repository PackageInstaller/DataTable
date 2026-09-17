local cls = class("cellEntrustTaskTag", G_UIModuleBase)
local _dungeonEntrustTagTpl = L_GameTpl:getDungeonEntrustTagTpl()

function cls.bind()
  return {
    txt_tagName = "",
    color_bg = C_Color.white,
    color_text = C_Color.white
  }
end

function cls:refresh()
  local tagTpl = _dungeonEntrustTagTpl:getTplById(self.bind.id)
  self.bind.txt_tagName = _dungeonEntrustTagTpl:getName(tagTpl)
  local _, bgColor = C_ColorUtility.TryParseHtmlString(_dungeonEntrustTagTpl:getBgColor(tagTpl))
  bgColor.a = 0.8
  local _, textColor = C_ColorUtility.TryParseHtmlString(_dungeonEntrustTagTpl:getTextColor(tagTpl))
  self.bind.color_bg = bgColor
  self.bind.color_text = textColor
end

function cls:close(options)
  cls.super.close(self, options)
end

return cls
