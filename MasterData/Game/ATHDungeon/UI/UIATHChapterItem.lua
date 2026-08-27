local UINDungeonStageItemBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonStageItemBase")
local UIATHChapterItem = class("UIATHChapterItem", UINDungeonStageItemBase)
local base = UINDungeonStageItemBase

function UIATHChapterItem:OnDelete()
  base.OnDelete(self)
  self.clickEvent = nil
end

function UIATHChapterItem:SetAthStageClickEvent(func)
  self.clickEvent = func
end

function UIATHChapterItem:__onClick()
  base.__onClick(self)
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

return UIATHChapterItem
