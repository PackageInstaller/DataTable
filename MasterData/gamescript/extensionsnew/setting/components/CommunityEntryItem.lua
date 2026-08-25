local FollowCommunityReward = DT.GetOriginalConstant("FollowCommunityReward")
local RewardTid = FollowCommunityReward[1]
local RewardCount = FollowCommunityReward[2]
local CommunityEntryItem, Super = NewViewComponent("CommunityEntryItem")

function CommunityEntryItem:ctor(uiNode, view, communityName)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Community_Item_PlatformResource(uiNode)
  self.communityName = communityName
  self.communityUrl = CommunityCfgUtils.GetCommunityUrl(self.communityName, self:_GetPublishArea())
end

function CommunityEntryItem:OnEnterComponent()
  if not self.communityUrl then
    self.ui.uiNode:SetActive(false)
    return
  end
  self.ui.uiNode:SetActive(true)
  self:AddButtonClickListener(self.ui.uiNode, System.fn(self, self._OnClick))
  self:SetText(self.ui.Text_Name, self.communityName)
  self:SetText(self.ui.Text_RewardCount, ItemNumUtils.GetStr(RewardCount))
  self:SetImage(self.ui.Image_Item, ItemDataUtils.GetItemIcon(RewardTid))
  self.ui.Group_Reward.gameObject:SetActive(self:_CheckCanReceiveReward())
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, function()
    do return self._CheckCanReceiveReward end
    return self._CheckCanReceiveReward, self
  end)
end

function CommunityEntryItem:OnExitComponent()
  self:RemoveViewComponentOnce(self.ui.Com_RedDot, UICompRedDot)
  Super.OnExitComponent(self)
end

function CommunityEntryItem:_CheckCanReceiveReward()
  return 1 ~= PlayerDataUtils.GetAttentionCommunityStatsData(self.communityName)
end

function CommunityEntryItem:_OnClick()
  ApplicationUtils.OpenURL(self.communityUrl)
  if SdkMgr.Instance:IsSdkLogin() and self:_CheckCanReceiveReward() then
    SettingDataUtils.ReqGainAttentionCommunityReward(self.communityName)
  end
end

function CommunityEntryItem:_GetPublishArea()
  local pkgInfo = SdkMgr.Instance:GetPkgInfo()
  return pkgInfo and pkgInfo.publish_area
end

return CommunityEntryItem
