local UINEventNInvitationStageItem = class("UINEventNInvitationStageItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINEventNInvitationStageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._item = UINBaseItemWithReceived.New()
  self._item:Init(self.ui.uINBaseItemWithReceived)
end

function UINEventNInvitationStageItem:InitInvitationStageItem(index, invitationData, callback)
  self._invitationData = invitationData
  self._index = index
  self._callback = callback
  self.ui.text.text = tostring(index)
  local rewardCfg = self._invitationData:GetInvitaionRewardCfg()[self._index]
  local itemId = rewardCfg.invitation_reward_ids[1]
  local itemNum = rewardCfg.invitation_reward_nums[1]
  self._itemCfg = ConfigData.item[itemId]
  self._item:InitItemWithCount(ConfigData.item[itemId], itemNum, BindCallback(self, self.OnClickItem))
  self:RefreshInvitationStageItem()
end

function UINEventNInvitationStageItem:RefreshInvitationStageItem()
  local isunlock = self._index <= #self._invitationData:GetInvitationInvitees()
  local isPicked = self._invitationData:IsInvitationRewardPicked(self._index)
  self.ui.image.color = isunlock and Color.black or self.ui.color_locked
  self._item:SetPickedUIActive(isPicked)
  self.ui.redDot:SetActive(isunlock and not isPicked)
end

function UINEventNInvitationStageItem:OnClickItem()
  if not self._invitationData:IsInvitationRewardPicked(self._index) and #self._invitationData:GetInvitationInvitees() >= self._index then
    if self._callback ~= nil then
      self._callback(self._index, self)
    end
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:SetNotNeedAnyJump(false)
      if athData ~= nil then
        win:InitAthDetail(self._itemCfg, nil)
      else
        win:InitCommonItemDetail(self._itemCfg)
      end
    end
  end)
end

return UINEventNInvitationStageItem
