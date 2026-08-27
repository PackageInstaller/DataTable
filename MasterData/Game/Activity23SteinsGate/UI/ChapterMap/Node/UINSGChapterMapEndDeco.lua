local base = UIBaseNode
local UINSGChapterMapEndDeco = class("UINSGChapterMapEndDeco", base)

function UINSGChapterMapEndDeco:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSGChapterMapEndDeco:RefreshAct23SGDecoNum(num)
  self.ui.txt_Deco.text = tostring(num)
end

function UINSGChapterMapEndDeco:OnDelete()
  base.OnDelete(self)
end

return UINSGChapterMapEndDeco
