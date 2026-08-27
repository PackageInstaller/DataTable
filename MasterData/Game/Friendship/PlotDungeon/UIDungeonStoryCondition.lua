local UIDungeonStoryCondition = class("UIDungeonStoryCondition", UIBaseNode)
local base = UIBaseNode

function UIDungeonStoryCondition:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIDungeonStoryCondition:InitWithData(text, isMeet)
  self.ui.text.text = text
  local index = 0
  if isMeet then
    index = 1
  end
  self.ui.img_State:SetIndex(index)
end

function UIDungeonStoryCondition:OnDelete()
  base.OnDelete(self)
end

return UIDungeonStoryCondition
