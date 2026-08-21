local var_0_0 = class("SurveyPage", import("...base.BaseActivityPage"))

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
	arg_4_0.bg = arg_4_0._tf:Find("BG")
	arg_4_0.bguo = arg_4_0._tf:Find("BGUO")
	arg_4_0.goBtn = arg_4_0._tf:Find("GO")
	arg_4_0.awardTF = arg_4_0._tf:Find("Award")
	arg_4_0.itemTF = arg_4_0._tf:Find("Award/IconTpl")
	arg_4_0.maskTF = arg_4_0._tf:Find("Award/Mask")
	arg_4_0.actProxy = getProxy(ActivityProxy)
	arg_4_0.isOpen, arg_4_0.surveyID = arg_4_0.actProxy:isSurveyOpen()

	if arg_4_0.isOpen then
		arg_4_0.isDone = arg_4_0.actProxy:isSurveyDone()
	end

	setActive(arg_4_0.bg, true)
	setActive(arg_4_0.bguo, false)
	setActive(arg_4_0.goBtn, true)

	return
end

function var_0_0.OnFirstFlush(arg_5_0)
	setActive(arg_5_0.maskTF, arg_5_0.isDone == true)
	setActive(arg_5_0.goBtn, not arg_5_0.isDone)
	updateDrop(arg_5_0.itemTF, {
		type = pg.survey_data_template[arg_5_0.surveyID].bonus[1][1],
		id = pg.survey_data_template[arg_5_0.surveyID].bonus[1][2],
		count = pg.survey_data_template[arg_5_0.surveyID].bonus[1][3]
	})
	onButton(arg_5_0, arg_5_0.itemTF, function()
		arg_5_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.goBtn, function()
		pg.m02:sendNotification(GAME.SURVEY_REQUEST, {
			surveyID = arg_5_0.surveyID,
			surveyUrlStr = getSurveyUrl(arg_5_0.surveyID)
		})

		if IsUnityEditor then
			var_0_0.ClearEnterTag(arg_5_0.surveyID)
		end

		return
	end, SFX_PANEL)
	var_0_0.SetEnterTag(arg_5_0.surveyID)
	arg_5_0:emit(ActivityMainScene.FLUSH_TABS)

	return
end

return var_0_0
