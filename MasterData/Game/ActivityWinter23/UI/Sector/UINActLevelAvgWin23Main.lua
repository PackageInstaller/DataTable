local base = require("Game.Sector.SectorLevel.UINLevelAvgMain")
local UINActLevelAvgWin23Main = class("UINActLevelAvgMain", base)
local ActSectorEnum = require("Game.ActivitySummer.UI.Sector.actSectorEnum")

function UINActLevelAvgWin23Main:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  base.OnInit(self)
end

function UINActLevelAvgWin23Main:InitActLAvgMain(avgCfg, arrangeCfg, clickEvent, resLoader)
  base.InitLAvgMain(self, avgCfg, arrangeCfg, clickEvent, resLoader)
  self:RefreshWin23AvgIcon(resLoader)
end

function UINActLevelAvgWin23Main:RefreshWin23AvgIcon(resLoader)
  self.ui.img_icon.gameObject:SetActive(false)
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorLevelIcon"), function(spriteAtlas)
    if spriteAtlas == nil or IsNull(self.transform) then
      return
    end
    local stageIcon = AtlasUtil.GetResldSprite(spriteAtlas, "SStageTutorial")
    self.ui.img_icon.gameObject:SetActive(true)
    self.ui.img_icon.sprite = stageIcon
  end)
end

function UINActLevelAvgWin23Main:RefreshLAvgMainState()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  self.isUnlock = avgPlayCtrl:IsAvgUnlock(self.avgCfg.id)
  self.ui.noEntry:SetActive(not self.isUnlock)
  self.ui.clearLevel:SetActive(avgPlayCtrl:IsAvgPlayed(self.avgCfg.id))
end

function UINActLevelAvgWin23Main:OnDelete()
  base.OnDelete(self)
end

return UINActLevelAvgWin23Main
