local UINEventInvitationMain = class("UINEventInvitationMain", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local UINEventNInvitationStageItem = require("Game.ActivityInvitation.UI.UINEventNInvitationStageItem")
local UINEventInvitationPlayerItem = require("Game.ActivityInvitation.UI.UINEventInvitationPlayerItem")

function UINEventInvitationMain:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Copy, self, self.OnClickCopy)
  UIUtil.AddButtonListener(self.ui.btn_Invite, self, self.OnClickInvite)
  self._itemPool = UIItemPool.New(UINEventNInvitationStageItem, self.ui.itemNode)
  self.ui.itemNode:SetActive(false)
  self._playerPool = UIItemPool.New(UINEventInvitationPlayerItem, self.ui.playerNode)
  self.ui.playerNode:SetActive(false)
  self._resloader = CS.ResLoader.Create()
  self._headItem = UINUserHead.New()
  self._headItem:Init(self.ui.uINUserHead)
  self.__OnLookInvitationUserCallback = BindCallback(self, self.__OnLookInvitationUser)
  self.__OnRewardStageCallback = BindCallback(self, self.__OnRewardStage)
  self.RefreshInvitationMainCallback = BindCallback(self, self.RefreshInvitationMain)
  MsgCenter:AddListener(eMsgEventId.ActivityInvitation, self.RefreshInvitationMainCallback)
  self._emptyList = {
    self.ui.empty
  }
end

function UINEventInvitationMain:InitInvitationMain(invitationData, callback)
  self._invitationData = invitationData
  self._callback = callback
  self._headItem:InitUserHeadUI(PlayerDataCenter.inforData:GetAvatarId(), PlayerDataCenter.inforData:GetAvatarFrameId(), self._resloader)
  self.ui.text_code.text = self._invitationData:GetInvitationCode()
  self:RefreshInvitationMain()
end

function UINEventInvitationMain:RefreshInvitationMain()
  self.ui.btn_Invite.gameObject:SetActive(not self._invitationData:IsInvitationCommonUser() and not self._invitationData:IsInvitationReturnPicked())
  if self._itemPool.listItem[1] == nil then
    local cfgs = self._invitationData:GetInvitaionRewardCfg()
    for i, _ in ipairs(cfgs) do
      local item = self._itemPool:GetOne()
      item:InitInvitationStageItem(i, self._invitationData, self.__OnRewardStageCallback)
    end
  else
    for i, v in ipairs(self._itemPool.listItem) do
      v:RefreshInvitationStageItem()
    end
  end
  for i, v in ipairs(self._playerPool.listItem) do
    v:RefreshInvitationPlayerItem()
  end
  local invitees = self._invitationData:GetInvitationInvitees()
  for i = #self._playerPool.listItem + 1, #invitees do
    local item = self._playerPool:GetOne()
    item:SetInvitationPlayerItem(invitees[i], self._resloader, self.__OnLookInvitationUserCallback)
  end
  local emptyCount = #self._itemPool.listItem - #invitees
  for i = 1, emptyCount do
    local emptyUI = self._emptyList[i]
    if emptyUI == nil then
      emptyUI = self.ui.empty:Instantiate(self.ui.empty.transform.parent)
      table.insert(self._emptyList, emptyUI)
    end
    emptyUI:SetActive(true)
    emptyUI.transform:SetAsLastSibling()
  end
  for i = emptyCount + 1, #self._emptyList do
    self._emptyList[i]:SetActive(false)
  end
  local curCount = #self._playerPool.listItem
  local totalCount = #self._itemPool.listItem
  self.ui.slider.value = (curCount - 1) / (totalCount - 1)
  self.ui.tex_stage:SetIndex(0, tostring(curCount), tostring(totalCount))
end

function UINEventInvitationMain:OnClickCopy()
  CS.UnityEngine.GUIUtility.systemCopyBuffer = self._invitationData:GetInvitationCode()
  AudioManager:PlayAudioById(1124)
  CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7703))
end

function UINEventInvitationMain:OnClickInvite()
  if self._callback ~= nil then
    self._callback()
  end
end

function UINEventInvitationMain:__OnLookInvitationUser(uid)
  UIManager:ShowWindowAsync(UIWindowTypeID.UserFreined, function(win)
    if win == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.ActivityFrameMain)
    win:InitUserFriend()
    win:OnClickSearch(uid)
    win:SetUserFriendCallback(function()
      UIManager:ShowWindowOnly(UIWindowTypeID.ActivityFrameMain)
    end)
  end)
end

function UINEventInvitationMain:__OnRewardStage(index, item)
  self._invitationData:ReqInvitationPicked(index, function()
    if not IsNull(self.transform) then
      self:RefreshInvitationMain()
    end
  end)
end

function UINEventInvitationMain:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.ActivityInvitation, self.RefreshInvitationMainCallback)
  base.OnDelete(self)
end

return UINEventInvitationMain
