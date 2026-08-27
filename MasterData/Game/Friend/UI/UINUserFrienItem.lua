local UINUserFrienItem = class("UINUserFrienItem", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")

function UINUserFrienItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.friendItem, self, self.OnCliclFriendItem)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
end

function UINUserFrienItem:InitWithFriendData(friendData, clickCallback, resLoader)
  self.friendData = friendData
  self.clickCallback = clickCallback
  self.resLoader = resLoader
  self:FrienItemRefreshUI()
end

function UINUserFrienItem:FrienItemRefreshUI()
  self.ui.tex_Name.text = self.friendData:GetAlias()
  self.ui.tex_Level.text = self.friendData:GetUserLevel()
  self.userHeadNode:InitUserHeadUI(self.friendData:GetAvatarId(), self.friendData:GetAvatarFrameId(), self.resLoader)
  self:RefreshFrienOnlineState()
end

function UINUserFrienItem:RefreshUserHead(avatarId)
  if avatarId == nil or avatarId == 0 then
    return
  end
  local cfg = ConfigData.portrait[avatarId]
  if cfg == nil or cfg.icon == nil then
    error("can't read portraitCfg with id:" .. tostring(avatarId))
    return
  end
  local icon = cfg.icon
  if string.IsNullOrEmpty(icon) ~= nil then
    self.ui.img_UserHead.sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

function UINUserFrienItem:RefreshUserHeadFrame(avatarFrameId)
  if avatarFrameId == nil or avatarFrameId == 0 then
    return
  end
  local cfg = ConfigData.portrait_frame[avatarFrameId]
  if cfg == nil or cfg.icon == nil then
    error("can't read portrait_frameCfg with id:" .. tostring(avatarFrameId))
    return
  end
  local icon = cfg.icon
  if string.IsNullOrEmpty(icon) ~= nil then
    self.ui.img_Frame.sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

function UINUserFrienItem:RefreshFrienOnlineState()
  local lastOfflineTs = self.friendData:GetOnlineState()
  if lastOfflineTs == nil then
    self.ui.onLine:SetActive(false)
    self.ui.offLine:SetActive(false)
    return
  elseif lastOfflineTs == 0 then
    self.ui.onLine:SetActive(true)
    self.ui.offLine:SetActive(false)
    return
  end
  self.ui.onLine:SetActive(false)
  self.ui.offLine:SetActive(true)
  local timepassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, false)
  local isToday, dayPassTimeStamp = timepassCtrl:GetIsLogicToday(lastOfflineTs)
  if not isToday then
    local timeSpan = dayPassTimeStamp - lastOfflineTs
    local day = math.floor(timeSpan / 86400)
    self.ui.tex_OffLineTime:SetIndex(1, tostring(day))
  else
    local timeSpan = PlayerDataCenter.timestamp - lastOfflineTs
    local hour = math.floor(timeSpan / 3600)
    self.ui.tex_OffLineTime:SetIndex(0, tostring(hour))
  end
end

function UINUserFrienItem:OnCliclFriendItem()
  if self.clickCallback ~= nil then
    self.clickCallback(self)
  end
end

function UINUserFrienItem:OnDelete()
  base.OnDelete(self)
end

return UINUserFrienItem
