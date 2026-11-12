local AchievementToggle = class("AchievementToggle", BaseCtrl)
AchievementToggle._mapNodeConfig = {
  TMPTitle = {sComponentName = "TMP_Text", nCount = 5},
  TMPTitleOpen = {sComponentName = "TMP_Text", nCount = 5},
  imgTab = {nCount = 5}
}
AchievementToggle._mapEventConfig = {}
AchievementToggle._mapRedDotConfig = {}

function AchievementToggle:Awake()
end

function AchievementToggle:FadeIn()
end

function AchievementToggle:FadeOut()
end

function AchievementToggle:OnEnable()
end

function AchievementToggle:OnDisable()
end

function AchievementToggle:OnDestroy()
end

function AchievementToggle:OnRelease()
end

function AchievementToggle:SetText(sTitle1, sTitle2, sTitle3, sTitle4, sTitle5)
  NovaAPI.SetTMPText(self._mapNode.TMPTitle[1], sTitle1)
  NovaAPI.SetTMPText(self._mapNode.TMPTitle[2], sTitle2)
  NovaAPI.SetTMPText(self._mapNode.TMPTitle[3], sTitle3)
  NovaAPI.SetTMPText(self._mapNode.TMPTitle[4], sTitle4)
  NovaAPI.SetTMPText(self._mapNode.TMPTitle[5], sTitle5)
  NovaAPI.SetTMPText(self._mapNode.TMPTitleOpen[1], sTitle1)
  NovaAPI.SetTMPText(self._mapNode.TMPTitleOpen[2], sTitle2)
  NovaAPI.SetTMPText(self._mapNode.TMPTitleOpen[3], sTitle3)
  NovaAPI.SetTMPText(self._mapNode.TMPTitleOpen[4], sTitle4)
  NovaAPI.SetTMPText(self._mapNode.TMPTitleOpen[5], sTitle5)
end

function AchievementToggle:SetState(nIdx)
  for index, goTab in ipairs(self._mapNode.imgTab) do
    goTab:SetActive(nIdx == index)
  end
end

return AchievementToggle
