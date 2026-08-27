local UINChatBoardEntryBase = require("Game.ChatSystem.UI.ChatBoardEntry.UINChatBoardEntryBase")
local UINChatBoardEntryFriend = class("UINChatBoardEntryFriend", UINChatBoardEntryBase)
local base = UINChatBoardEntryBase
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")

function UINChatBoardEntryFriend:OnInit()
  base.OnInit(self)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.uINUserHead)
end

function UINChatBoardEntryFriend:InitChatBoardEntryFriend(chatBoard, userInfoData, resLoader, onClickChatEntryCallback, isShowRedDot, isSelecting, onClickChatEntryImageCallback)
  self.chatBoard = chatBoard
  self.userInfoData = userInfoData
  self.userHeadNode:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), resLoader)
  self.ui.tex_Level.text = userInfoData:GetUserLevel()
  self.ui.tex_Name.text = userInfoData:GetAlias()
  self.onClickChatEntryCallback = onClickChatEntryCallback
  self.onClickChatEntryImageCallback = onClickChatEntryImageCallback
  if isShowRedDot then
    self:RefreshChatEntryRedDot()
  else
    self.ui.blueDot_Friend:SetActive(false)
  end
  if isSelecting then
    self.ui.obj_OnSelect:SetActive(true)
  else
    self.ui.obj_OnSelect:SetActive(false)
  end
  self:RefreshFrienOnlineState()
end

function UINChatBoardEntryFriend:OnClickEntry()
  if self.onClickChatEntryCallback ~= nil then
    self.onClickChatEntryCallback(self.chatBoard)
  end
end

function UINChatBoardEntryFriend:OnClickEntryImage()
  if self.onClickChatEntryImageCallback ~= nil then
    self.onClickChatEntryImageCallback(self.chatBoard:GetChatBoardId())
  end
end

function UINChatBoardEntryFriend:RefreshChatEntryRedDot()
  self.ui.blueDot_Friend:SetActive(self.chatBoard:GetNewChatNum() > 0)
end

function UINChatBoardEntryFriend:RefreshFrienOnlineState()
  local lastOfflineTs = self.userInfoData:GetOnlineState()
  if lastOfflineTs == nil then
    self.ui.obj_OnLine:SetActive(false)
    self.ui.obj_OffLine:SetActive(false)
    return
  elseif lastOfflineTs == 0 then
    self.ui.obj_OnLine:SetActive(true)
    self.ui.obj_OffLine:SetActive(false)
    return
  end
  self.ui.obj_OnLine:SetActive(false)
  self.ui.obj_OffLine:SetActive(true)
  local timepassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, false)
  local isToday, dayPassTimeStamp = timepassCtrl:GetIsLogicToday(lastOfflineTs)
  if not isToday then
    local timeSpan = dayPassTimeStamp - lastOfflineTs
    local day = math.floor(timeSpan / 86400)
    self.ui.tex_Time:SetIndex(1, tostring(day))
  else
    local timeSpan = PlayerDataCenter.timestamp - lastOfflineTs
    local hour = math.floor(timeSpan / 3600)
    self.ui.tex_Time:SetIndex(0, tostring(hour))
  end
end

return UINChatBoardEntryFriend
