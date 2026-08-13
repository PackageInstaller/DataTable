class = var_0_10000

local var_0_0 = "DALCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.SailingShip3.SailingShip3CoreActivityUI"))

var_0_1.finishtime = 50245

function var_0_1.getUIName(arg_1_0)
	return "DALCoreActivityUI"
end

function var_0_1.loadingQueue(arg_2_0)
	return
end

function var_0_1.init(arg_3_0, ...)
	var_0_1.super.init(arg_3_0, ...)
	arg_3_0:OnSetTime()

	return
end

function var_0_1.didEnter(arg_4_0)
	var_0_1.super.didEnter(arg_4_0)

	local var_4_1

	if not arg_4_0.contextData.activeScenario then
		local var_4_0 = arg_4_0._tf

		var_4_1 = var_4_1.GetComponent
		typeof = var_1_10003
		Animation = var_1_10004
		var_4_1 = var_4_1(var_4_0, var_1_10003(var_1_10004))
		var_4_1.enabled = true
	end

	onButton = var_4_1

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.btnBack

	local function var_4_4()
		local var_5_0 = arg_4_0.pageDic[arg_4_0.activity.id]

		if var_0.IsShowingPopWindow(var_5_0) then
			var_0:ClosePopWindow()
		else
			local var_5_1 = arg_4_0

			var_1.emit(var_5_1, var_0_1.ON_BACK)
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_4_1(var_4_2, var_4_3, var_4_4, var_1_10005)

	return
end

function var_0_1.ONToggleName(arg_6_0, arg_6_1, arg_6_2)
	setText = var_1_10003

	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.Find(var_6_0, "on/name")

	i18n = var_6_0

	var_1_10003(var_6_1, var_6_0("dal_main_sheet" .. arg_6_2:getConfig("is_show")))

	setText = var_1_10003

	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.Find(var_6_2, "off/name")

	i18n = var_6_2

	var_1_10003(var_6_3, var_6_2("dal_main_sheet" .. arg_6_2:getConfig("is_show")))

	setText = var_1_10003

	local var_6_4 = arg_6_1
	local var_6_5 = arg_6_1.Find(var_6_4, "on/name_1")

	i18n = var_6_4

	var_1_10003(var_6_5, var_6_4("dal_main_sheet" .. arg_6_2:getConfig("is_show") .. "_en"))

	setText = var_1_10003

	local var_6_6 = arg_6_1
	local var_6_7 = arg_6_1.Find(var_6_6, "off/name_1")

	i18n = var_6_6

	var_1_10003(var_6_7, var_6_6("dal_main_sheet" .. arg_6_2:getConfig("is_show") .. "_en"))

	return
end

function var_0_1.selectActivity(arg_7_0, arg_7_1)
	var_0_1.super.selectActivity(arg_7_0, arg_7_1)

	SetActive = var_2

	local var_7_0 = arg_7_0._tf

	var_2(var_3.Find(var_7_0, "adapt/Main"), arg_7_1.id == 50241)

	SetActive = var_2

	local var_7_1 = arg_7_0._tf

	var_2(var_3.Find(var_7_1, "adapt/tab_bg"), arg_7_1.id ~= 50253)

	SetActive = var_2

	local var_7_2 = arg_7_0._tf

	var_2(var_3.Find(var_7_2, "adapt/Favorability_tan_bg"), arg_7_1.id == 50253)

	return
end

function var_0_1.OnplayAnimation(arg_8_0, arg_8_1)
	return
end

function var_0_1.OnSetTime(arg_9_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)
	local var_9_1 = var_1.getActivityById(var_9_0, arg_9_0.finishtime).stopTime

	pg = var_9_0

	local var_9_2 = var_9_0.TimeMgr.GetInstance()
	local var_9_3 = var_9_1 - var_2.GetServerTime(var_9_2)

	setText = var_2

	local var_9_4 = arg_9_0._tf
	local var_9_5 = var_3.Find(var_9_4, "adapt/top/btn_home/text_tip/timetext")

	i18n = var_9_4

	var_2(var_9_5, var_9_4("activity_remain_time"))

	setText = var_2

	local var_9_6 = arg_9_0._tf
	local var_9_7 = var_3.Find(var_9_6, "adapt/top/btn_home/text_tip/time")

	math = var_9_6

	local var_9_8 = var_9_6.floor(var_9_3 / 0)

	i18n = var_5

	var_2(var_9_7, var_9_8 .. var_5("word_date"))

	return
end

return var_0_1
