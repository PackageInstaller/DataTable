local base = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23Item")
local UINActLevelWin23RepeatItem = class("UINActLevelWin23RepeatItem", base)
local ActSectorEnum = require("Game.ActivitySummer.UI.Sector.actSectorEnum")

function UINActLevelWin23RepeatItem:OnInit()
  base.OnInit(self)
end

function UINActLevelWin23RepeatItem:InitSectorLevelItem(stageCfg, arrangeCfg, clickEvent, resLoader)
  base.InitSectorLevelItem(self, stageCfg, arrangeCfg, clickEvent, resLoader)
  self:RefreshDropText()
end

function UINActLevelWin23RepeatItem:RefreshDropText()
  local farmDescCfg = ConfigData.sector_chapter_farm_desc
  local stageDescCfg = farmDescCfg[self.stageCfg.id]
  if stageDescCfg then
    local desc = LanguageUtil.GetLocaleText(stageDescCfg.drop_up_desc)
    if not string.IsNullOrEmpty(desc) then
      self.ui.obj_DropUp:SetActive(true)
      self.ui.drop_text.text = desc
      return
    end
  end
  self.ui.obj_DropUp:SetActive(false)
end

function UINActLevelWin23RepeatItem:SetIsSpecialState(bool)
  self.isSpecial = bool
end

function UINActLevelWin23RepeatItem:ShowPreviewItem()
  if not self.isSpecial then
    base.ShowPreviewItem(self)
  else
    self.ui.previewItem:SetActive(false)
  end
end

function UINActLevelWin23RepeatItem:OnDelete()
  base.OnDelete(self)
end

return UINActLevelWin23RepeatItem
