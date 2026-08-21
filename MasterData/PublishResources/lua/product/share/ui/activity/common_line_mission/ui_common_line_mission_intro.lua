_class("UICommonLineMissionIntro", UIController)
UICommonLineMissionIntro = UICommonLineMissionIntro

function UICommonLineMissionIntro:OnShow(uiParams)
  self.campaignID = uiParams[1]
  self:InitWidget()
  self:_OnValue()
end

function UICommonLineMissionIntro:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._content = self:GetUIComponent("UILocalizationText", "Content")
end

function UICommonLineMissionIntro:_OnValue()
  self._title:SetText(StringTable.Get("str_activity_story_intro_title_" .. self.campaignID))
  self._content:SetText(StringTable.Get("str_activity_story_intro_content_" .. self.campaignID))
end

function UICommonLineMissionIntro:BtnCloseOnClick(go)
  self:CloseDialog()
end
