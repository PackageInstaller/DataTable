local base = require("Game.Sector.SectorLevel.UINLevelSimpleItem")
local UINActLevelSimpleItem = class("UINActLevelSimpleItem", base)
local ActSectorEnum = require("Game.ActivitySummer.UI.Sector.actSectorEnum")

function UINActLevelSimpleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  base.OnInit(self)
end

function UINActLevelSimpleItem:InitSectorLevelItem(stageCfg, arrangeCfg, clickEvent, resLoader)
  base.InitSectorLevelItem(self, stageCfg, arrangeCfg, clickEvent, resLoader)
  self:SwitchActLTypeUI(stageCfg, arrangeCfg)
end

function UINActLevelSimpleItem:SwitchActLTypeUI(stageCfg, arrangeCfg)
  self:_ShowUI(ActSectorEnum.eSectorMode.Support)
  local ctrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if ctrl == nil then
    return
  end
  local showTypeID = ctrl:TryGetShowTypeID(stageCfg.sector, arrangeCfg, stageCfg.show_type)
  if showTypeID == ActSectorEnum.eSectorMode.Normal then
    self:_ShowUI(ActSectorEnum.eSectorMode.Normal)
  end
end

function UINActLevelSimpleItem:_ShowUI(eSectorMode)
  local isSupport = eSectorMode == ActSectorEnum.eSectorMode.Support
  local imgIdx = isSupport and 0 or 1
  local col = isSupport and Color.black or Color.white
  self.ui.img_Button:SetIndex(imgIdx)
  self.ui.tex_SubTile.color = col
  self.ui.tex_Tile.color = col
  self.ui.img_Pic.color = col
end

function UINActLevelSimpleItem:OnDelete()
  base.OnDelete(self)
end

return UINActLevelSimpleItem
