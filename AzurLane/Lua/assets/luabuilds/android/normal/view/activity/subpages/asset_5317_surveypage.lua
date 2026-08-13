class = var_0_10000

local var_0_0 = "SurveyPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.SetEnterTag(arg_1_0)
	PlayerPrefs = var_1_10001

	local var_1_0 = var_1_10001.SetInt
	local var_1_1 = "survey_enter_"

	tostring = var_1_10003

	var_1_0(var_1_1 .. var_1_10003(arg_1_0), 1)

	return
end

function var_0_1.IsEverEnter(arg_2_0)
	PlayerPrefs = var_1_10001

	local var_2_0 = var_1_10001.HasKey
	local var_2_1 = "survey_enter_"

	tostring = var_1_10003

	return var_2_0(var_2_1 .. var_1_10003(arg_2_0))
end

function var_0_1.ClearEnterTag(arg_3_0)
	PlayerPrefs = var_1_10001

	local var_3_0 = var_1_10001.DeleteKey
	local var_3_1 = "survey_enter_"

	tostring = var_1_10003

	var_3_0(var_3_1 .. var_1_10003(arg_3_0))

	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.bg = var_1.Find(var_4_0, "BG")

	local var_4_1 = arg_4_0._tf

	arg_4_0.bguo = var_1.Find(var_4_1, "BGUO")

	local var_4_2 = arg_4_0._tf

	arg_4_0.goBtn = var_1.Find(var_4_2, "GO")

	local var_4_3 = arg_4_0._tf

	arg_4_0.awardTF = var_1.Find(var_4_3, "Award")

	local var_4_4 = arg_4_0._tf

	arg_4_0.itemTF = var_1.Find(var_4_4, "Award/IconTpl")

	local var_4_5 = arg_4_0._tf

	arg_4_0.maskTF = var_1.Find(var_4_5, "Award/Mask")
	getProxy = var_1
	ActivityProxy = var_4_5
	arg_4_0.actProxy = var_1(var_4_5)

	local var_4_6 = arg_4_0.actProxy

	arg_4_0.isOpen, arg_4_0.surveyID = var_1.isSurveyOpen(var_4_6)

	if arg_4_0.isOpen then
		local var_4_7 = arg_4_0.actProxy

		arg_4_0.isDone = var_1.isSurveyDone(var_4_7)
	end

	setActive = var_1

	var_1(arg_4_0.bg, true)

	setActive = var_1

	var_1(arg_4_0.bguo, false)

	setActive = var_1

	var_1(arg_4_0.goBtn, true)

	return
end

function var_0_1.OnFirstFlush(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.maskTF, arg_5_0.isDone == true)

	setActive = var_1_10001

	var_1_10001(arg_5_0.goBtn, not arg_5_0.isDone)

	pg = var_1_10001

	local var_5_0 = var_1_10001.survey_data_template[arg_5_0.surveyID].bonus[1]
	local var_5_1 = {
		type = var_5_0[1],
		id = var_5_0[2],
		count = var_5_0[3]
	}

	updateDrop = var_3

	var_3(arg_5_0.itemTF, var_5_1)

	onButton = var_3

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.itemTF

	local function var_5_4()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_DROP, var_5_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_5_2, var_5_3, var_5_4, var_1_10007)

	onButton = var_3

	local var_5_5 = arg_5_0
	local var_5_6 = arg_5_0.goBtn

	local function var_5_7()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_7_2 = var_2_10002.SURVEY_REQUEST
		local var_7_3 = {
			surveyID = arg_5_0.surveyID
		}

		getSurveyUrl = var_4
		var_7_3.surveyUrlStr = var_4(arg_5_0.surveyID)

		var_7_1(var_7_0, var_7_2, var_7_3)

		IsUnityEditor = var_7_1

		if var_7_1 then
			var_0_1.ClearEnterTag(arg_5_0.surveyID)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_5_5, var_5_6, var_5_7, var_1_10007)
	var_0_1.SetEnterTag(arg_5_0.surveyID)

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.emit

	ActivityMainScene = var_5_6

	var_5_9(var_5_8, var_5_6.FLUSH_TABS)

	return
end

return var_0_1
