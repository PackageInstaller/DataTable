local base = require("Game.ActivityHallowmas.UI.Bouns.UINHalloweenBounsItemEmptyElement")
local UINChristmasBoundsItemEmptyElement = class("UINChristmasBoundsItemEmptyElement", base)

function UINChristmasBoundsItemEmptyElement:SetBoundsItemLoopEft(getFunc)
  self._loopEftFunc = getFunc
end

function UINChristmasBoundsItemEmptyElement:__SetBounsItemExtra()
  self._item:SetLoopEftCreateFunc(self._loopEftFunc)
end

return UINChristmasBoundsItemEmptyElement
