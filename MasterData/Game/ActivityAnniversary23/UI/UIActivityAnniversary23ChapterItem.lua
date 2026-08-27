local base = UIBaseNode
local UIActivityAnniversary23ChapterItem = class("UIActivityAnniversary23ChapterItem", base)

function UIActivityAnniversary23ChapterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIActivityAnniversary23ChapterItem:InitChapterItem(avgCfg, index, isLast)
  if avgCfg ~= nil then
    local desName = LanguageUtil.GetLocaleText(avgCfg.name)
    self.ui.tex_CNUnlock.text = desName
    self.ui.tex_index.text = index
    if isLast then
      self.ui.obj_Fill:SetActive(false)
    end
  end
end

function UIActivityAnniversary23ChapterItem:InitCommonChapterItem(name, index, isLast)
  local desName = LanguageUtil.GetLocaleText(name)
  self.ui.tex_CNUnlock.text = desName
  self.ui.tex_index.text = index
  if isLast then
    self.ui.obj_Fill:SetActive(false)
  end
end

return UIActivityAnniversary23ChapterItem
