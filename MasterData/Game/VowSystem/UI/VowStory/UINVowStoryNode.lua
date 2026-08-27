local UINVowStoryNode = class("UINVowStoryNode", UIBaseNode)
local base = UIBaseNode
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINVowSkinItem = require("Game.VowSystem.UI.VowStory.UINVowSkinItem")
local VowEnum = require("Game.VowSystem.Data.VowEnum")
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")

function UINVowStoryNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_HeroGoNow, self, self.OnClickGoVow)
  UIUtil.AddButtonListener(self.ui.btn_SkinGoNow, self, self.OnClickGoShop)
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.OnClickClose)
  self.heroCardItem = UINHeroCardItem.New()
  self.heroCardItem:Init(self.ui.uINHeroItem)
  self.skinItem = UINVowSkinItem.New()
  self.skinItem:Init(self.ui.skinItem)
end

function UINVowStoryNode:InitVowStoryNode(heroId, resloader, closeCallback)
  self.heroId = heroId
  self.resloader = resloader
  self.closeCallback = closeCallback
  self.heroData = PlayerDataCenter:GetHeroData(self.heroId)
  self.heroVowCfg = self.heroData:GetVowCfg()
  self:RefreshHeroVowState()
  self:RefreshSkinVowState()
end

function UINVowStoryNode:RefreshHeroVowState()
  local vowState = self.heroData:GetHeroVowState()
  local isVowed = vowState == VowEnum.EVowState.Vowed
  self.ui.tex_HeroDes:SetIndex(isVowed and 1 or 0)
  self.ui.obj_HeroCompleted:SetActive(isVowed)
  self.ui.btn_HeroGoNow.gameObject:SetActive(not isVowed)
  self.heroCardItem:InitHeroCardItem(self.heroData, self.resloader)
end

function UINVowStoryNode:RefreshSkinVowState()
  local skinId = self.heroVowCfg.vow_story_condition[2]
  local isHaveSkin = PlayerDataCenter.skinData:IsHaveSkin(skinId)
  self.ui.tex_SkinDes:SetIndex(isHaveSkin and 1 or 0)
  self.ui.obj_SkinCompleted:SetActive(isHaveSkin)
  self.ui.btn_SkinGoNow.gameObject:SetActive(not isHaveSkin)
  self.skinItem:InitVowSkinItem(self.resloader, self.heroId, skinId)
end

function UINVowStoryNode:OnClickGoVow()
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  vowSystemCtrl:TryVowHero(self.heroId)
end

function UINVowStoryNode:OnClickGoShop()
  local giftId = self.heroVowCfg.gift_id
  local giftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  local giftInfo = giftCtrl:GetPayGiftDataById(giftId)
  if giftInfo and giftInfo:IsUnlock() then
    JumpManager:Jump(JumpManager.eJumpTarget.DynShop, nil, nil, {
      ShopEnum.ShopId.gift
    })
    return
  end
  JumpManager:Jump(JumpManager.eJumpTarget.ShopVow)
end

function UINVowStoryNode:OnClickClose()
  if self.closeCallback then
    self.closeCallback()
  end
end

function UINVowStoryNode:OnDelete()
end

return UINVowStoryNode
