local UINDungeonStageItemBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonStageItemBase")
local UIHeroChapterItem = class("UIHeroChapterItem", UINDungeonStageItemBase)
local base = UINDungeonStageItemBase

function UIHeroChapterItem:OnDelete()
  base.OnDelete(self)
end

return UIHeroChapterItem
