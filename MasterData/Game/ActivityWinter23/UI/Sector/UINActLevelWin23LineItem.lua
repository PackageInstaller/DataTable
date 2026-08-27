local base = require("Game.Sector.SectorLevel.UINLevelLine")
local UINActLevelWin23LineItem = class("UINActLevelWin23LineItem", base)
local eLevelLineType = require("Game.Sector.Enum.eLevelLineType")

function UINActLevelWin23LineItem:OnInit()
  base.OnInit(self)
end

function UINActLevelWin23LineItem:InitSectorLevelItem(stageCfg, arrangeCfg, clickEvent, resLoader)
  base.InitSectorLevelItem(self, stageCfg, arrangeCfg, clickEvent, resLoader)
  self:RefreshDropText()
end

function UINActLevelWin23LineItem:RefreshLevelLineState(lineType)
  base.RefreshLevelLineState(self, lineType)
  if lineType == eLevelLineType.BetweenLevelFull then
    self.ui.fill.color = self.ui.line_color[1]
  elseif lineType == eLevelLineType.BetweenLevel then
    self.ui.fill.color = self.ui.line_color[2]
    self:__SetLength(self.length, self.ui.maxWidth, 1)
    self.ui.img_lineItem.enabled = false
  else
    self.ui.fill.color = self.ui.line_color[2]
  end
end

function UINActLevelWin23LineItem:OnDelete()
  base.OnDelete(self)
end

return UINActLevelWin23LineItem
