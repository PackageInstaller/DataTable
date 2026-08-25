local CommunityShowList = {
  CommunityDefine.CommunityName.FaceBook,
  CommunityDefine.CommunityName.Discord,
  CommunityDefine.CommunityName.X,
  CommunityDefine.CommunityName.Youtube,
  CommunityDefine.CommunityName.Tiktok,
  CommunityDefine.CommunityName.Reddit,
  CommunityDefine.CommunityName.Steam
}
local CommunityJumpView, Super = NewClass("CommunityJumpView", BaseView)
CommunityJumpView.uiResCls = UI_Community_Steer_TipsResource

function CommunityJumpView:_GetUIResCls()
  if ZoneFeatureUtils.IsZoneFeatureOpen(cd.ZoneFeature.JPDiscord) then
    return UI_Community_Steer_Tips_JPResource
  end
  return UI_Community_Steer_TipsResource
end

function CommunityJumpView:OnBuildView()
  self:_InitCommunityEntry()
  self:_InitThanksLetter()
  self:SetText(self.ui.Text_Describe, LT.Text("CommunityJumpTips"))
end

function CommunityJumpView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Thanks, System.fn(self, self._OnClickThanksLetter))
end

function CommunityJumpView:_InitCommunityEntry()
  for idx, communityName in ipairs(CommunityShowList) do
    local entryNode = self.ui["Btn_Steer_" .. idx]
    if entryNode then
      self:AddViewComponent(entryNode, CommunityEntryItem, communityName)
    end
  end
end

function CommunityJumpView:_InitThanksLetter()
  local gratitudeReward = DT.GetOriginalConstant("TranslateGratitudeReward")
  local rewardTid = gratitudeReward[1]
  local rewardCount = gratitudeReward[2]
  local entryRes = UI_Community_Item_PlatformResource(self.ui.Btn_Thanks.gameObject)
  self:SetImage(entryRes.Image_Item, ItemDataUtils.GetItemIcon(rewardTid))
  self:SetText(entryRes.Text_RewardCount, ItemNumUtils.GetStr(rewardCount))
  entryRes.Group_Reward.gameObject:SetActive(self:_CheckCanReceiveReward())
  self:AddViewComponentOnce(entryRes.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, function()
    do return self._CheckCanReceiveReward end
    return self._CheckCanReceiveReward, self
  end)
end

function CommunityJumpView:_CheckCanReceiveReward()
  return 1 ~= PlayerDataUtils.GetTranslateGratitudeRewardStatsData()
end

function CommunityJumpView:_OnClickThanksLetter()
  UIManager.Instance:Reopen(Urls.GratitudePanel)
  if self:_CheckCanReceiveReward() then
    SettingDataUtils.ReqGainTranslateGratitudeReward()
  end
end

return CommunityJumpView
