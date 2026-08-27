local UINCustomHeroGiftNode = class("UINCustomHeroGiftNode", UIBaseNode)
local base = UIBaseNode
local eSelfSelectGift = require("Game.PayGift.eSelfSelectGift")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINCustomHeroGiftNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SelectHero, self, self.OnClickCustomHeroGiftSelect)
  self._itemNode = UINBaseItemWithCount.New()
  self._itemNode:Init(self.ui.uINBaseItemWithCount)
  self._itemNode:Hide()
end

function UINCustomHeroGiftNode:BindGiftHeroSelectCallback(callback)
  self._callback = callback
end

function UINCustomHeroGiftNode:RefreshCustomHeroGiftSelect(heroId)
  self._heroId = heroId
  self.ui.img_AddHero.gameObject:SetActive(self._heroId == nil)
  if self._heroId ~= nil then
    if PlayerDataCenter:ContainsHeroData(self._heroId) then
      self._itemNode:Show()
      self.ui.img_ItemPic.gameObject:SetActive(false)
      local itemId = ConfigData.game_config.customHeroGiftConvert[1]
      local count = ConfigData.game_config.customHeroGiftConvert[2]
      self._itemNode:InitItemWithCount(ConfigData.item[itemId], count, self._callback)
    else
      self._itemNode:Hide()
      self.ui.img_ItemPic.gameObject:SetActive(true)
      self.ui.img_ItemPic.sprite = CRH:GetHeroSkinSprite(self._heroId)
    end
  end
  if 0 < (self._heroId or 0) then
    local heroCfg = ConfigData.hero_data[self._heroId]
    local rankCfg = ConfigData.hero_rank[heroCfg.rank]
    self.ui.img_Quality.color = HeroRareColor[rankCfg.rare]
    self.ui.text.text = ConfigData:GetTipContent(413)
  else
    self.ui.img_Quality.color = Color.white
    self.ui.text.text = ConfigData:GetTipContent(412)
    self._itemNode:Hide()
    self.ui.img_ItemPic.gameObject:SetActive(false)
  end
  self:__RefreshSelectedState()
end

function UINCustomHeroGiftNode:RefreshCustomChipGiftSelect(heroId, selfSelectCfg)
  self.ui.img_Quality.color = Color.white
  self.ui.img_ItemPic.gameObject:SetActive(false)
  self._heroId = heroId
  self.ui.img_AddHero.gameObject:SetActive(self._heroId == nil)
  if (self._heroId or 0) == 0 then
    self._itemNode:Hide()
    self.ui.text.text = ConfigData:GetTipContent(416)
    self:__RefreshSelectedState()
    return
  end
  local localSelfSelectCfg = selfSelectCfg or ConfigData.customized_gift[eSelfSelectGift.type.heroFragWithOutLimit]
  local heroCfg = ConfigData.hero_data[heroId]
  local itemId = heroCfg.fragment
  local count = localSelfSelectCfg.param1[1]
  self._itemNode:Show()
  self._itemNode:InitItemWithCount(ConfigData.item[itemId], count, self._callback)
  self.ui.text.text = ConfigData:GetTipContent(417)
  self:__RefreshSelectedState()
end

function UINCustomHeroGiftNode:__RefreshSelectedState()
  if self.ui.tweens == nil then
    return
  end
  local isEmpty = (self._heroId or 0) == 0
  self.ui.tweens[1].gameObject:SetActive(isEmpty)
  for i, v in ipairs(self.ui.tweens) do
    if isEmpty then
      v:DORestart()
    else
      v:DORewind()
    end
  end
end

function UINCustomHeroGiftNode:OnClickCustomHeroGiftSelect()
  if self._callback then
    self._callback()
  end
end

function UINCustomHeroGiftNode:OnDelete()
  for i, v in ipairs(self.ui.tweens) do
    v:DOKill()
  end
  base.OnDelete(self)
end

return UINCustomHeroGiftNode
