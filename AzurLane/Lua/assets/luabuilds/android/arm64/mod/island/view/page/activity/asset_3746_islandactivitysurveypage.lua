class = var_0_10000

local var_0_0 = "IslandActivitySurveyPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function var_0_1.SetEnterTag(arg_1_0)
	PlayerPrefs = var_1_10001

	local var_1_0 = var_1_10001.SetInt
	local var_1_1 = "survey_enter_"

	tostring = var_1_10004

	var_1_0(var_1_1 .. var_1_10004(arg_1_0), 1)

	return
end

function var_0_1.IsEverEnter(arg_2_0)
	PlayerPrefs = var_1_10001

	local var_2_0 = var_1_10001.HasKey
	local var_2_1 = "survey_enter_"

	tostring = var_1_10004

	return var_2_0(var_2_1 .. var_1_10004(arg_2_0))
end

function var_0_1.ClearEnterTag(arg_3_0)
	PlayerPrefs = var_1_10001

	local var_3_0 = var_1_10001.DeleteKey
	local var_3_1 = "survey_enter_"

	tostring = var_1_10004

	var_3_0(var_3_1 .. var_1_10004(arg_3_0))

	return
end

function var_0_1.OnInit(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003
	arg_4_0.actProxy = var_1_10001(var_1_10003)

	local var_4_0 = arg_4_0.actProxy

	arg_4_0.isOpen, arg_4_0.surveyID = var_1.isSurveyOpen(var_4_0)

	if arg_4_0.isOpen then
		local var_4_1 = arg_4_0.actProxy

		arg_4_0.isDone = var_1.isSurveyDone(var_4_1)
	end

	setText = var_1

	local var_4_2 = arg_4_0.tipText1

	i18n = var_1_10004

	var_1(var_4_2, var_1_10004("island_survey_ui_1"))

	setText = var_1

	local var_4_3 = arg_4_0.tipText2

	i18n = var_4

	var_1(var_4_3, var_4("island_survey_ui_2"))

	setText = var_1

	local var_4_4 = arg_4_0.awardTipText

	i18n = var_4

	var_1(var_4_4, var_4("island_survey_ui_award"))

	setText = var_1

	local var_4_5 = arg_4_0.goTip

	i18n = var_4

	var_1(var_4_5, var_4("island_survey_ui_button"))

	return
end

function var_0_1.OnDataSetting(arg_5_0)
	return
end

function var_0_1.OnFirstFlush(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0.goBtn, not arg_6_0.isDone)

	pg = var_1_10001

	local var_6_0 = var_1_10001.survey_data_template[arg_6_0.surveyID].bonus[1]

	updateCustomDrop = var_2

	local var_6_1 = arg_6_0.awardTF

	Drop = var_1_10005

	var_2(var_6_1, var_1_10005.New({
		type = var_6_0[1],
		id = var_6_0[2],
		count = var_6_0[3]
	}))

	onButton = var_2

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.goBtn

	local function var_6_4()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_7_2 = var_2_10003.SURVEY_REQUEST
		local var_7_3 = {
			surveyID = arg_6_0.surveyID
		}

		getSurveyUrl = var_5
		var_7_3.surveyUrlStr = var_5(arg_6_0.surveyID)

		var_7_1(var_7_0, var_7_2, var_7_3)

		IsUnityEditor = var_7_1

		if var_7_1 then
			var_0_1.ClearEnterTag(arg_6_0.surveyID)
		end

		return
	end

	SFX_PANEL = var_7

	var_2(var_6_2, var_6_3, var_6_4, var_7)
	var_0_1.SetEnterTag(arg_6_0.surveyID)

	return
end

return var_0_1
