local base = require("Game.Sector.SectorLevel.UINLevelSimpleItem")
local UINActLevelWin23Item = class("UINActLevelSimpleItem", base)
local ActSectorEnum = require("Game.ActivitySummer.UI.Sector.actSectorEnum")

function UINActLevelWin23Item:OnInit()
  base.OnInit(self)
end

function UINActLevelWin23Item:InitSectorLevelItem(stageCfg, arrangeCfg, clickEvent, resLoader)
  base.InitSectorLevelItem(self, stageCfg, arrangeCfg, clickEvent, resLoader)
end

function UINActLevelWin23Item:RefreshNoEntry()
  self.ui.noEntry:SetActive(not self.isUnlock)
end

function UINActLevelWin23Item:ShowBlueDotLevelItem(show)
end

function UINActLevelWin23Item:RefreshLevelState()
  self.isClear = PlayerDataCenter.sectorStage:IsStageComplete(self.stageCfg.id)
  self.ui.clearLevel:SetActive(self.isClear)
  self.isUnlock = PlayerDataCenter.sectorStage:IsStageUnlock(self.stageCfg.id)
  self:RefreshNoEntry()
  self:ShowPreviewItem()
end

function UINActLevelWin23Item:ShowPreviewItem()
  if self.stageCfg.show_item > 0 then
    local itemCfg = ConfigData.item[self.stageCfg.show_item]
    local smallIcon = itemCfg.small_icon
    if self.ui.obj_isFrag then
      if itemCfg.action_type == eItemActionType.HeroCardFrag then
        self.ui.obj_isFrag:SetActive(true)
        self.ui.obj_isHero:SetActive(true)
        self.ui.img_isSmallIcon.gameObject:SetActive(false)
      elseif not string.IsNullOrEmpty(smallIcon) then
        self.ui.obj_isFrag:SetActive(true)
        self.ui.obj_isHero:SetActive(false)
        self.ui.img_isSmallIcon.gameObject:SetActive(true)
        self.ui.img_isSmallIcon.sprite = CRH:GetSprite(smallIcon)
      else
        self.ui.obj_isFrag:SetActive(false)
        self.ui.obj_isHero:SetActive(false)
        self.ui.img_isSmallIcon.gameObject:SetActive(false)
      end
    end
    self.ui.previewItem:SetActive(true)
    self.ui.img_PreviewItem.sprite = CRH:GetSpriteByItemId(self.stageCfg.show_item)
  else
    self.ui.previewItem:SetActive(false)
  end
end

function UINActLevelWin23Item:OnClickLevelItem()
  base.OnClickLevelItem(self)
  if self.stageCfg then
    local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
    if win23Ctrl then
      win23Ctrl:RecordNowStageId(self.stageCfg.id)
    end
  end
end

function UINActLevelWin23Item:OnDelete()
  base.OnDelete(self)
end

return UINActLevelWin23Item
