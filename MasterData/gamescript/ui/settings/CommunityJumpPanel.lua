local CommunityShowList = {
  CommunityDefine.CommunityName.FaceBook,
  CommunityDefine.CommunityName.Discord,
  CommunityDefine.CommunityName.X,
  CommunityDefine.CommunityName.Youtube,
  CommunityDefine.CommunityName.Tiktok,
  CommunityDefine.CommunityName.Reddit,
  CommunityDefine.CommunityName.Steam
}
local CommunityJumpPanel, Super = System.NewClass("CommunityJumpPanel", UIBasePanel)
CommunityJumpPanel.uiResCls = UI_Community_Steer_TipsResource

function CommunityJumpPanel:ctor()
  Super.ctor(self)
end

function CommunityJumpPanel:_GetUIResCls()
  if ZoneFeatureUtils.IsZoneFeatureOpen(cd.ZoneFeature.JPDiscord) then
    return UI_Community_Steer_Tips_JPResource
  end
  return UI_Community_Steer_TipsResource
end

function CommunityJumpPanel:OnBind(binder)
  self:_OnBindCommunityEntry(binder)
  self:_OnBindThanksLetter(binder)
  binder:BindToText(self.ui.Text_Describe, function()
    do return LT.Text end
    return LT.Text, "CommunityJumpTips"
  end)
end

function CommunityJumpPanel:_OnBindCommunityEntry(binder)
  for idx, communityName in ipairs(CommunityShowList) do
    local entryNode = self.ui["Btn_Steer_" .. idx]
    if not entryNode then
    else
      binder:BindComponent(CommunityEntryItem(entryNode, communityName))
    end
  end
end

function CommunityJumpPanel:_OnBindThanksLetter(binder)
  binder:BindButtonClick(self.ui.Btn_Thanks, function()
    self:_OnClickThanksLetter()
  end)
  local GratitudeReward = DT.GetOriginalConstant("TranslateGratitudeReward")
  local RewardTid = GratitudeReward[1]
  local RewardCount = GratitudeReward[2]
  local entryNode = UI_Community_Item_PlatformResource(self.ui.Btn_Thanks.gameObject)
  binder:SetImage(entryNode.Image_Item, ItemDataUtils.GetItemIcon(RewardTid))
  binder:SetText(entryNode.Text_RewardCount, ItemNumUtils.GetStr(RewardCount))
  binder:BindToVisible(entryNode.Group_Reward, System.fn(self, self._CheckCanReceiveReward))
  binder:BindComponent(RedDotComponent(entryNode.Com_RedDot, CommonDefine.RedDotType.Dot, nil, function()
    do return self._CheckCanReceiveReward end
    return self._CheckCanReceiveReward, self
  end))
end

function CommunityJumpPanel:_CheckCanReceiveReward()
  return 1 ~= PlayerDataUtils.GetTranslateGratitudeRewardStatsData()
end

function CommunityJumpPanel:_OnClickThanksLetter()
  UIManager.Instance:Reopen(Urls.GratitudePanel)
  if self:_CheckCanReceiveReward() then
    SettingDataUtils.ReqGainTranslateGratitudeReward()
  end
end

return CommunityJumpPanel
