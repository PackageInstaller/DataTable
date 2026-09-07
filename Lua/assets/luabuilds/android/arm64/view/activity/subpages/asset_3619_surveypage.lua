local SurveyPage = class("SurveyPage", import("...base.BaseActivityPage"))

function SurveyPage:SetEnterTag()
	PlayerPrefs.SetInt("survey_enter_" .. tostring(self), 1)

	return
end

function SurveyPage:IsEverEnter()
	return PlayerPrefs.HasKey("survey_enter_" .. tostring(self))
end

function SurveyPage:ClearEnterTag()
	PlayerPrefs.DeleteKey("survey_enter_" .. tostring(self))

	return
end

function SurveyPage:OnInit()
	self.bg = self._tf:Find("BG")
	self.bguo = self._tf:Find("BGUO")
	self.goBtn = self._tf:Find("GO")
	self.awardTF = self._tf:Find("Award")
	self.itemTF = self._tf:Find("Award/IconTpl")
	self.maskTF = self._tf:Find("Award/Mask")
	self.actProxy = getProxy(ActivityProxy)
	self.isOpen, self.surveyID = self.actProxy:isSurveyOpen()

	if self.isOpen then
		self.isDone = self.actProxy:isSurveyDone()
	end

	setActive(self.bg, true)
	setActive(self.bguo, false)
	setActive(self.goBtn, true)

	return
end

function SurveyPage:OnFirstFlush()
	setActive(self.maskTF, self.isDone == true)
	setActive(self.goBtn, not self.isDone)

	local var_5_0 = {
		type = pg.survey_data_template[self.surveyID].bonus[1][1],
		id = pg.survey_data_template[self.surveyID].bonus[1][2],
		count = pg.survey_data_template[self.surveyID].bonus[1][3]
	}

	updateDrop(self.itemTF, var_5_0)
	onButton(self, self.itemTF, function()
		self:emit(BaseUI.ON_DROP, var_5_0)

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.SURVEY_REQUEST, {
			surveyID = self.surveyID,
			surveyUrlStr = getSurveyUrl(self.surveyID)
		})

		if IsUnityEditor then
			SurveyPage.ClearEnterTag(self.surveyID)
		end

		return
	end, SFX_PANEL)
	SurveyPage.SetEnterTag(self.surveyID)
	self:emit(ActivityMainScene.FLUSH_TABS)

	return
end

return SurveyPage
