local UINFormationChoiceSupportItem = class("UINFormationChoiceSupportItem", UIBaseNode)
local base = UIBaseNode
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINFmtHeroHpBarItem = require("Game.Formation.UI.2DFormation.UINFmtHeroHpBarItem")
local CS_ClientConsts = CS.ClientConsts

function UINFormationChoiceSupportItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroCardItem = UINHeroCardItem.New()
  self.heroCardItem:Init(self.ui.uINHeroItem)
  UIUtil.AddButtonListener(self.ui.btn_img_empty, self, self.OnClick)
  local eventTrigger = CS.EventTriggerListener.Get(self.heroCardItem.gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDrag))
  eventTrigger:onDrag("+", BindCallback(self, self.OnDrag))
  eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDrag))
  eventTrigger:onClick("+", BindCallback(self, self.OnClick))
end

function UINFormationChoiceSupportItem:InitAsEmpuyCard(clickAct)
  self.clickAct = clickAct
  self.heroCardItem:Hide()
  self.ui.img_support:SetActive(true)
  self.ui.img_Empty:SetActive(true)
  self.ui.isSupport:SetActive(false)
  self.ui.obj_Selected:SetActive(false)
  self.ui.img_TimesUseUP:SetActive(false)
  self.ui.img_Unavailable:SetActive(false)
  self:SetFmtChoiceSupportItemInFmt(false)
end

function UINFormationChoiceSupportItem:InitChoiceItem(heroData, resloader, beginDragAct, onDragAct, endDragAct, clickAct)
  self.beginDragAct = beginDragAct
  self.onDragAct = onDragAct
  self.endDragAct = endDragAct
  self.clickAct = clickAct
  self.heroData = heroData
  self.resloader = resloader
  self.heroCardItem:Show()
  self.heroCardItem:InitHeroCardItem(heroData, resloader)
  self.ui.img_support:SetActive(false)
  self.ui.isSupport:SetActive(true)
  self.ui.obj_Selected:SetActive(false)
  self.ui.img_TimesUseUP:SetActive(false)
  self.ui.img_Unavailable:SetActive(false)
  self:SetFmtChoiceSupportItemInFmt(false)
end

function UINFormationChoiceSupportItem:InitAsExhaustCard()
  self.ui.img_support:SetActive(true)
  self.ui.img_Empty:SetActive(false)
  self.ui.isSupport:SetActive(false)
  self.ui.obj_Selected:SetActive(false)
  self.ui.img_TimesUseUP:SetActive(true)
  self.ui.img_Unavailable:SetActive(false)
end

function UINFormationChoiceSupportItem:InitAsUnavailable(clickAct)
  self.clickAct = clickAct
  self.heroCardItem:Hide()
  self.ui.img_support:SetActive(true)
  self.ui.img_Empty:SetActive(false)
  self.ui.isSupport:SetActive(false)
  self.ui.obj_Selected:SetActive(false)
  self.ui.img_TimesUseUP:SetActive(false)
  self.ui.img_Unavailable:SetActive(true)
  self:SetFmtChoiceSupportItemInFmt(false)
end

function UINFormationChoiceSupportItem:OnBeginDrag(go, eventData)
  if self.beginDragAct ~= nil then
    self.beginDragAct(eventData, self)
  end
end

function UINFormationChoiceSupportItem:OnDrag(go, eventData)
  if self.onDragAct ~= nil then
    self.onDragAct(eventData, self)
  end
end

function UINFormationChoiceSupportItem:OnEndDrag(go, eventData)
  if self.endDragAct ~= nil then
    self.endDragAct(eventData, self)
  end
end

function UINFormationChoiceSupportItem:OnClick(go, eventData)
  if self.clickAct ~= nil then
    self:clickAct()
  end
end

function UINFormationChoiceSupportItem:SetSelectedState(flag)
  self.ui.obj_Selected:SetActive(flag)
end

function UINFormationChoiceSupportItem:SetFmtChoiceSupportItemInFmt(inFmt)
  self.ui.obj_InFmt:SetActive(inFmt)
  self.ui.obj_Selected:SetActive(inFmt)
end

function UINFormationChoiceSupportItem:UpdateFixCfg(fixCfg)
  if self.heroData ~= nil then
    self.heroCardItem:InitHeroCardItem(self.heroData, self.resloader)
  end
end

function UINFormationChoiceSupportItem:UpdFmtHeroChoiceItemHp(hpPer)
  if self.hpBarItem == nil then
    self.hpBarItem = UINFmtHeroHpBarItem.New()
    self.hpBarItem:Init(self.ui.hPBar)
    self.hpBarItem:Show()
  end
  local maxHp = self.heroData:GetAttr(eHeroAttr.maxHp)
  self.hpBarItem:InitFmtHeroHpBarItem(hpPer, maxHp)
  if hpPer == 0 then
    self.ui.cantBattle:SetActive(true)
  elseif hpPer <= 2000 then
    self.ui.isWound:SetActive(true)
  else
    self.ui.cantBattle:SetActive(false)
    self.ui.isWound:SetActive(false)
  end
end

function UINFormationChoiceSupportItem:SetSpecialGameHeroActive(sepcShowType)
  self.heroCardItem:SetSpecialGameHeroActive(sepcShowType)
end

function UINFormationChoiceSupportItem:OnShow()
  if CS_ClientConsts.IsAudit then
    self:Hide()
    return
  end
  base.OnShow(self)
end

function UINFormationChoiceSupportItem:OnDelete()
  if self.hpBarItem ~= nil then
    self.hpBarItem:Delete()
  end
  self.heroCardItem:Delete()
  base.OnDelete(self)
end

return UINFormationChoiceSupportItem
