local UINFriendshipChatPageFriendItem = class("UINFriendshipChatPageFriendItem", UIBaseNode)
local base = UIBaseNode

function UINFriendshipChatPageFriendItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_weChatListItem, self, self.OnClick)
  self.__RefreshFavorLevel = BindCallback(self, self.RefreshFavorLevel)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshFavorLevel)
end

function UINFriendshipChatPageFriendItem:InitHeroInfo(heroData, clickEvent, resloader)
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroData.heroCfg.name)
  self.heroID = heroData.heroCfg.id
  self.heroData = heroData
  resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroData.resCfg.res_Name), function(texture)
    self.ui.img_HeadIcon.texture = texture
  end)
  self.clickEvent = clickEvent
  self:RefreshFavorLevel()
end

function UINFriendshipChatPageFriendItem:RefreshFavorLevel()
  local favoeLevel = PlayerDataCenter.allFriendshipData:GetLevel(self.heroID)
  self.ui.tex_FavorLevel:SetIndex(0, tostring(favoeLevel))
end

function UINFriendshipChatPageFriendItem:OnClick()
  self:SelectThis(true)
  if self.clickEvent ~= nil then
    self.clickEvent(self.heroData)
  end
end

function UINFriendshipChatPageFriendItem:SelectThis(bool)
  self.ui.img_onSelect:SetActive(bool)
end

function UINFriendshipChatPageFriendItem:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshFavorLevel)
  base.OnDelete(self)
end

return UINFriendshipChatPageFriendItem
