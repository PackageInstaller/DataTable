local var_0_0 = class("DALCoreActivityUI", import("view.activity.CorePage.SailingShip3.SailingShip3CoreActivityUI"))

var_0_0.finishtime = 50245

function var_0_0.getUIName(arg_1_0)
	return "DALCoreActivityUI"
end

function var_0_0.loadingQueue(arg_2_0)
	return
end

function var_0_0.init(arg_3_0, ...)
	var_0_0.super.init(arg_3_0, ...)
	arg_3_0:OnSetTime()

	return
end

function var_0_0.didEnter(arg_4_0)
	var_0_0.super.didEnter(arg_4_0)

	if not arg_4_0.contextData.activeScenario then
		arg_4_0._tf:GetComponent(typeof(Animation)).enabled = true
	end

	onButton(arg_4_0, arg_4_0.btnBack, function()
		if arg_4_0.pageDic[arg_4_0.activity.id]:IsShowingPopWindow() then
			arg_4_0.pageDic[arg_4_0.activity.id]:ClosePopWindow()
		else
			arg_4_0:emit(var_0_0.ON_BACK)
		end

		return
	end, SOUND_BACK)

	return
end

function var_0_0.ONToggleName(arg_6_0, arg_6_1, arg_6_2)
	setText(arg_6_1:Find("on/name"), i18n("dal_main_sheet" .. arg_6_2:getConfig("is_show")))
	setText(arg_6_1:Find("off/name"), i18n("dal_main_sheet" .. arg_6_2:getConfig("is_show")))
	setText(arg_6_1:Find("on/name_1"), i18n("dal_main_sheet" .. arg_6_2:getConfig("is_show") .. "_en"))
	setText(arg_6_1:Find("off/name_1"), i18n("dal_main_sheet" .. arg_6_2:getConfig("is_show") .. "_en"))

	return
end

function var_0_0.selectActivity(arg_7_0, arg_7_1)
	var_0_0.super.selectActivity(arg_7_0, arg_7_1)
	SetActive(arg_7_0._tf:Find("adapt/Main"), arg_7_1.id == 50241)
	SetActive(arg_7_0._tf:Find("adapt/tab_bg"), arg_7_1.id ~= 50253)
	SetActive(arg_7_0._tf:Find("adapt/Favorability_tan_bg"), arg_7_1.id == 50253)

	return
end

function var_0_0.OnplayAnimation(arg_8_0, arg_8_1)
	return
end

function var_0_0.OnSetTime(arg_9_0)
	setText(arg_9_0._tf:Find("adapt/top/btn_home/text_tip/timetext"), i18n("activity_remain_time"))
	setText(arg_9_0._tf:Find("adapt/top/btn_home/text_tip/time"), math.floor((getProxy(ActivityProxy):getActivityById(arg_9_0.finishtime).stopTime - pg.TimeMgr.GetInstance():GetServerTime()) / 0) .. i18n("word_date"))

	return
end

return var_0_0
