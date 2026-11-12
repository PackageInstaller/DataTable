local AchievementHomepageCtrl = class("AchievementHomepageCtrl", BaseCtrl)
AchievementHomepageCtrl._mapNodeConfig = {
  TMPAcheivementCount = {sComponentName = "TMP_Text"},
  TMPTitle = {sComponentName = "TMP_Text", nCount = 5},
  TMPCupCount = {sComponentName = "TMP_Text", nCount = 3}
}
AchievementHomepageCtrl._mapEventConfig = {
  AchievementRefresh = "OnEvent_ReceiveReward"
}
AchievementHomepageCtrl._mapRedDotConfig = {}

function AchievementHomepageCtrl:Awake()
end

function AchievementHomepageCtrl:FadeIn()
end

function AchievementHomepageCtrl:FadeOut()
end

function AchievementHomepageCtrl:OnEnable()
  for i = 1, 5 do
    NovaAPI.SetTMPText(self._mapNode.TMPTitle[i], ConfigTable.GetUIText("Achievement_Type_" .. i))
  end
end

function AchievementHomepageCtrl:OnDisable()
end

function AchievementHomepageCtrl:OnDestroy()
end

function AchievementHomepageCtrl:OnRelease()
end

function AchievementHomepageCtrl:OnEvent_ReceiveReward()
  self.mapCount = PlayerData.Achievement:GetAchievementAllTypeCount()
  NovaAPI.SetTMPText(self._mapNode.TMPAcheivementCount, self.mapCount.nCompleted)
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[1], self.mapCount.nSSR)
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[2], self.mapCount.nSR)
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[3], self.mapCount.nR)
end

return AchievementHomepageCtrl
