local UIFriendship = class("UIFriendship", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local FriendshipEnum = require("Game.Friendship.FriendshipEnum")
local UINFriendshipPageTog = require("Game.Friendship.UINFriendshipPageTog")
local UINFriendshipChatPage = require("Game.Friendship.pages.ChatPage.UINFriendshipChatPage")
local UINFriendshipMomentPage = require("Game.Friendship.pages.Moment.UINFriendshipMomentPage")
local UINFriendshipPersonalInfoPage = require("Game.Friendship.pages.PersonalInfoPage.UINFriendshipPersonalInfoPage")

function UIFriendship:OnInit()
  UIUtil.CreateTopBtnGroup(self.ui.topBtnGroup, self, self.Delete)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.networkCtrl:CS_INTIMACY_Detail()
  self.pages = {
    [FriendshipEnum.togTypes.Friends] = self.ui.obj_iMChatNode,
    [FriendshipEnum.togTypes.Moment] = self.ui.obj_momentNode,
    [FriendshipEnum.togTypes.PersonalInfo] = self.ui.obj_favorDetailNode
  }
  local ChatPage = UINFriendshipChatPage.New()
  ChatPage.isInited = false
  local MomentPage = UINFriendshipMomentPage.New()
  MomentPage.isInited = false
  local PersonalInfoPage = UINFriendshipPersonalInfoPage.New()
  PersonalInfoPage.isInited = false
  self.pageClasses = {
    [FriendshipEnum.togTypes.Friends] = ChatPage,
    [FriendshipEnum.togTypes.Moment] = MomentPage,
    [FriendshipEnum.togTypes.PersonalInfo] = PersonalInfoPage
  }
  self.resloader = cs_ResLoader.Create()
  self.appTogglePool = UIItemPool.New(UINFriendshipPageTog, self.ui.tog_apptog)
  self.appToggleDic = {}
  self.ui.tog_apptog:SetActive(false)
  self:GengratePageToggles()
end

function UIFriendship:GengratePageToggles()
  self.appTogglePool:HideAll()
  self.appToggleDic = {}
  local togNum = table.count(FriendshipEnum.togTypes)
  for typeIndex = 0, togNum - 1 do
    local isOn = typeIndex == FriendshipEnum.togTypes.Friends
    local tog = self.appTogglePool:GetOne(true)
    tog:InitAchivTypeToggle(typeIndex, isOn, Bind(self, self.showPage))
    table.insert(self.appToggleDic, tog)
  end
end

function UIFriendship:showPage(pageIndex)
  for index, page in pairs(self.pages) do
    if index == pageIndex then
      page:SetActive(true)
      local pageclass = self.pageClasses[index]
      if pageclass == nil then
        error("pageclass nil:" .. pageIndex)
        return
      end
      if pageclass.isInited == false then
        pageclass:Init(page)
        pageclass:LaterInit(self.resloader)
        pageclass.isInited = true
      end
    else
      page:SetActive(false)
    end
  end
end

function UIFriendship:OnClickCloseButton()
  self:Delete()
end

function UIFriendship:OnHide()
  self:OnCloseWin()
  base.OnHide(self)
end

function UIFriendship:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  for index, page in pairs(self.pages) do
    local pageclass = self.pageClasses[index]
    if pageclass.isInited == true then
      pageclass:Delete()
    end
  end
  base.OnDelete(self)
end

return UIFriendship
