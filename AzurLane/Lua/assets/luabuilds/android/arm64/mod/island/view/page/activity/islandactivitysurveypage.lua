local var_0_0 = class("IslandActivitySurveyPage", import("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function var_0_0.SetEnterTag(arg_1_0)
	PlayerPrefs.SetInt("survey_enter_" .. tostring(arg_1_0), 1)

	return
end

function var_0_0.IsEverEnter(arg_2_0)
	return PlayerPrefs.HasKey("survey_enter_" .. tostring(arg_2_0))
end

function var_0_0.ClearEnterTag(arg_3_0)
	PlayerPrefs.DeleteKey("survey_enter_" .. tostring(arg_3_0))

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.actProxy = getProxy(ActivityProxy)
	arg_4_0.isOpen, arg_4_0.surveyID = arg_4_0.actProxy:isSurveyOpen()

	if arg_4_0.isOpen then
		arg_4_0.isDone = arg_4_0.actProxy:isSurveyDone()
	end

	setText(arg_4_0.tipText1, i18n("island_survey_ui_1"))
	setText(arg_4_0.tipText2, i18n("island_survey_ui_2"))
	setText(arg_4_0.awardTipText, i18n("island_survey_ui_award"))
	setText(arg_4_0.goTip, i18n("island_survey_ui_button"))

	return
end

function var_0_0.OnDataSetting(arg_5_0)
	return
end

function var_0_0.OnFirstFlush(arg_6_0)
	setActive(arg_6_0.goBtn, not arg_6_0.isDone)
	updateCustomDrop(arg_6_0.awardTF, Drop.New({
		type = pg.survey_data_template[arg_6_0.surveyID].bonus[1][1],
		id = pg.survey_data_template[arg_6_0.surveyID].bonus[1][2],
		count = pg.survey_data_template[arg_6_0.surveyID].bonus[1][3]
	}))
	onButton(arg_6_0, arg_6_0.goBtn, function()
		pg.m02:sendNotification(GAME.SURVEY_REQUEST, {
			surveyID = arg_6_0.surveyID,
			surveyUrlStr = getSurveyUrl(arg_6_0.surveyID)
		})

		if IsUnityEditor then
			var_0_0.ClearEnterTag(arg_6_0.surveyID)
		end

		return
	end, SFX_PANEL)
	var_0_0.SetEnterTag(arg_6_0.surveyID)

	return
end

return var_0_0
