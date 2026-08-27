local base = require("Game.Sector.SectorLevel.UINLevelAvgMain")
local UINActLevelAvgMain = class("UINActLevelAvgMain", base)
local ActSectorEnum = require("Game.ActivitySummer.UI.Sector.actSectorEnum")

function UINActLevelAvgMain:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  base.OnInit(self)
end

function UINActLevelAvgMain:InitActLAvgMain(avgCfg, arrangeCfg, clickEvent, resLoader)
  base.InitLAvgMain(self, avgCfg, arrangeCfg, clickEvent, resLoader)
  self:SwitchActLAvgTypeUI(avgCfg, arrangeCfg)
end

function UINActLevelAvgMain:SwitchActLAvgTypeUI(avgCfg, arrangeCfg)
  self.ui.img_Hard.enabled = false
  self.ui.img_Simple.enabled = false
  local ctrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if ctrl == nil then
    return
  end
  local showTypeID = ctrl:TryGetShowTypeID(avgCfg.sectorId, arrangeCfg, avgCfg.show_type)
  if showTypeID == nil then
    return
  end
  self.ui.img_Hard.enabled = showTypeID == ActSectorEnum.eSectorMode.Normal
  self.ui.img_Simple.enabled = showTypeID == ActSectorEnum.eSectorMode.Support
end

function UINActLevelAvgMain:OnDelete()
  base.OnDelete(self)
end

return UINActLevelAvgMain
