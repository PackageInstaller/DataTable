local FollowCommunityReward = DT.GetOriginalConstant("FollowCommunityReward")
local RewardTid = FollowCommunityReward[1]
local RewardCount = FollowCommunityReward[2]
local CommunityEntryItem, Super = System.NewComponent("CommunityEntryItem")

function CommunityEntryItem:ctor(uiNode, communityName)
  Super.ctor(self)
  self.ui = UI_Community_Item_PlatformResource(uiNode)
  self.communityName = communityName
  self.communityUrl = CommunityCfgUtils.GetCommunityUrl(self.communityName, self:_GetPublishArea())
end

function CommunityEntryItem:OnBind(binder)
  if not self.communityUrl then
    self.ui.uiNode:SetActive(false)
    return
  end
  self.ui.uiNode:SetActive(true)
  binder:BindZ1Button(self.ui.uiNode, System.fn(self, self._OnClick))
  binder:SetText(self.ui.Text_Name, self.communityName)
  binder:SetText(self.ui.Text_RewardCount, ItemNumUtils.GetStr(RewardCount))
  binder:SetImage(self.ui.Image_Item, ItemDataUtils.GetItemIcon(RewardTid))
  binder:BindToVisible(self.ui.Group_Reward, System.fn(self, self._CheckCanReceiveReward))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, nil, function()
    do return self._CheckCanReceiveReward end
    return self._CheckCanReceiveReward, self
  end))
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
