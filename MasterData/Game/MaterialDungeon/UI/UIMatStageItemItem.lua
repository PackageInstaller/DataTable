local UINDungeonStageItemBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonStageItemBase")
local UIMatStageItemItem = class("UIMatStageItemItem", UINDungeonStageItemBase)
local base = UINDungeonStageItemBase

function UIMatStageItemItem:OnDelete()
  base.OnDelete(self)
end

return UIMatStageItemItem
