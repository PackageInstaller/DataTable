local IslandActivitySurveyPage = class("IslandActivitySurveyPage", import("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function IslandActivitySurveyPage:SetEnterTag()
	PlayerPrefs.SetInt("survey_enter_" .. tostring(self), 1)

	return
end

function IslandActivitySurveyPage:IsEverEnter()
	return PlayerPrefs.HasKey("survey_enter_" .. tostring(self))
end

function IslandActivitySurveyPage:ClearEnterTag()
	PlayerPrefs.DeleteKey("survey_enter_" .. tostring(self))

	return
end

function IslandActivitySurveyPage:OnInit()
	self.actProxy = getProxy(ActivityProxy)
	self.isOpen, self.surveyID = self.actProxy:isSurveyOpen()

	if self.isOpen then
		self.isDone = self.actProxy:isSurveyDone()
	end

	setText(self.tipText1, i18n("island_survey_ui_1"))
	setText(self.tipText2, i18n("island_survey_ui_2"))
	setText(self.awardTipText, i18n("island_survey_ui_award"))
	setText(self.goTip, i18n("island_survey_ui_button"))

	return
end

function IslandActivitySurveyPage:OnDataSetting()
	return
end

function IslandActivitySurveyPage:OnFirstFlush()
	setActive(self.goBtn, not self.isDone)
	updateCustomDrop(self.awardTF, Drop.New({
		type = pg.survey_data_template[self.surveyID].bonus[1][1],
		id = pg.survey_data_template[self.surveyID].bonus[1][2],
		count = pg.survey_data_template[self.surveyID].bonus[1][3]
	}))
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.SURVEY_REQUEST, {
			surveyID = self.surveyID,
			surveyUrlStr = getSurveyUrl(self.surveyID)
		})

		if IsUnityEditor then
			IslandActivitySurveyPage.ClearEnterTag(self.surveyID)
		end

		return
	end, SFX_PANEL)
	IslandActivitySurveyPage.SetEnterTag(self.surveyID)

	return
end

return IslandActivitySurveyPage
