local UUINFriendshipPersonalInfoPage = class("UUINFriendshipPersonalInfoPage", UIBaseNode)
local base = UIBaseNode
local UINFriendshipAttrItem = require("Game.Friendship.pages.PersonalInfoPage.UINFriendshipAttrItem")

function UUINFriendshipPersonalInfoPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tex_UserName.text = PlayerDataCenter.playerName
  self.attrItemPool = UIItemPool.New(UINFriendshipAttrItem, self.ui.obj_attriItem)
  self.ui.obj_attriItem:SetActive(false)
  self.__RefreshTotalLevel = BindCallback(self, self.RefreshTotalLevel)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshTotalLevel)
end

function UUINFriendshipPersonalInfoPage:LaterInit(resloader)
  self.resloader = resloader
  self:RefreshTotalLevel()
end

function UUINFriendshipPersonalInfoPage:RefreshAttrs(totalLevel)
  self.attrItemPool:HideAll()
  local cfg = ConfigData.friendship_total_level[totalLevel]
  for index, logic in ipairs(cfg.logic) do
    local attrItem = self.attrItemPool:GetOne(true)
    attrItem:InitAttrItem(cfg.para1[index], cfg.para2[index])
  end
end

function UUINFriendshipPersonalInfoPage:RefreshTotalLevel()
  local totalLevel = PlayerDataCenter.allFriendshipData:GetTotalLevel() or 0
  self.ui.tex_TotalfavorLevel:SetIndex(0, tostring(totalLevel))
  self:RefreshAttrs(totalLevel)
end

function UUINFriendshipPersonalInfoPage:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshTotalLevel)
  self.attrItemPool:DeleteAll()
  base.OnDelete(self)
end

return UUINFriendshipPersonalInfoPage
