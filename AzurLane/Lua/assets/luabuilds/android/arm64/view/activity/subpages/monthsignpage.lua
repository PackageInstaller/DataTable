local var_0_0 = class("MonthSignPage", import("...base.BaseActivityPage"))

var_0_0.SHOW_RE_MONTH_SIGN = "show re month sign award"
var_0_0.MILESTONE_SPECIAL_DATA = "month_sign_milestone_day"
var_0_0.MONTH_SIGN_SHOW = {}
var_0_0.MONTH_SIGN_SP_DAYS = {
	30,
	60,
	120,
	240,
	300
}

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.items = arg_1_0._tf:Find("items")
	arg_1_0.item = arg_1_0.items:Find("item")
	arg_1_0.spDay = arg_1_0._tf:Find("sp_day")
	arg_1_0.spDayEffects = {}
	arg_1_0.monthSignReSignUI = MonthSignReSignUI.New(arg_1_0._tf, arg_1_0.event, nil)

	arg_1_0:bind(var_0_0.SHOW_RE_MONTH_SIGN, function(arg_2_0, arg_2_1, arg_2_2)
		if not arg_1_0.monthSignReSignUI:GetLoaded() then
			arg_1_0.monthSignReSignUI:Load()
		end

		arg_1_0.monthSignReSignUI:ActionInvoke("setAwardShow", arg_2_1, arg_2_2)

		return
	end)

	for iter_1_0, iter_1_1 in ipairs(MonthSignPage.MONTH_SIGN_SP_DAYS) do
		local var_1_0 = arg_1_0.spDay:Find(iter_1_1 .. "days")

		arg_1_0.spDayEffects[iter_1_1] = var_1_0

		setActive(var_1_0, false)
	end

	setActive(arg_1_0.spDay, false)
	setText(arg_1_0._tf:Find("login/Text"), i18n("yearly_sign_in"))
	setText(arg_1_0._tf:Find("login/count/Text"), i18n("word_date"))

	return
end

function var_0_0.OnDataSetting(arg_3_0)
	arg_3_0.config = pg.activity_month_sign[arg_3_0.activity.data2]

	if not arg_3_0.config then
		return true
	end

	arg_3_0.monthDays = pg.TimeMgr.GetInstance():CalcMonthDays(arg_3_0.activity.data1, arg_3_0.activity.data2)

	if tonumber(pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "%m")) == pg.activity_template[ActivityConst.MONTH_SIGN_ACTIVITY_ID].config_client[1] then
		arg_3_0.specialTag = true
		arg_3_0.specialDay = pg.activity_template[ActivityConst.MONTH_SIGN_ACTIVITY_ID].config_client[2]
		arg_3_0.isShowFrame = pg.activity_template[ActivityConst.MONTH_SIGN_ACTIVITY_ID].config_client[3]
	end

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	arg_4_0.list = UIItemList.New(arg_4_0.items, arg_4_0.item)

	arg_4_0.list:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = arg_5_1 + 1

			updateDrop(arg_5_2, _.map(arg_4_0.config["day" .. arg_5_1 + 1], function(arg_6_0)
				return Drop.Create(arg_6_0)
			end)[1])
			onButton(arg_4_0, arg_5_2, function()
				if #var_0 == 1 then
					arg_4_0:emit(BaseUI.ON_DROP, var_0[1])
				else
					arg_4_0:emit(BaseUI.ON_DROP_LIST, {
						content = "",
						item2Row = true,
						itemList = var_0
					})
				end

				return
			end, SFX_PANEL)
			setText(arg_5_2:Find("day/Text"), "Day " .. var_5_0)
			setActive(arg_5_2:Find("got"), var_5_0 <= #arg_4_0.activity.data1_list)
			setActive(arg_5_2:Find("today"), var_5_0 == #arg_4_0.activity.data1_list)

			if arg_4_0.specialTag and var_5_0 == arg_4_0.specialDay then
				local var_5_1 = arg_5_2:Find("icon_bg/SpecialFrame")

				if arg_4_0.isShowFrame == 1 then
					setActive(var_5_1, false)
				else
					setActive(var_5_1, true)
				end
			end
		end

		return
	end)
	arg_4_0:UpdateLoginInfo()

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	if arg_8_0:isDirtyRes() then
		return
	end

	arg_8_0:UpdateLoginInfo()
	arg_8_0.list:align(arg_8_0.monthDays)

	if arg_8_0.specialTag then
		local var_8_0 = arg_8_0.specialDay - #arg_8_0.activity.data1_list

		if arg_8_0.specialDay - #arg_8_0.activity.data1_list < 0 then
			var_8_0 = 0
		end

		setText(arg_8_0._tf:Find("DayNumText"), var_8_0)

		GetComponent(arg_8_0._tf:Find("ProgressBar"), "Slider").value = #arg_8_0.activity.data1_list
	end

	local var_8_1 = arg_8_0.activity:getSpecialData("month_sign_awards")

	if var_8_1 and #var_8_1 > 0 then
		local var_8_2 = getProxy(PlayerProxy):getPlayerId()

		if not table.contains(MonthSignPage.MONTH_SIGN_SHOW, arg_8_0.activity.id .. ":" .. var_8_2) then
			table.insert(MonthSignPage.MONTH_SIGN_SHOW, arg_8_0.activity.id .. ":" .. var_8_2)

			if not arg_8_0.monthSignReSignUI:GetLoaded() then
				arg_8_0.monthSignReSignUI:Load()
			end

			arg_8_0.monthSignReSignUI:ActionInvoke("setAwardShow", var_8_1)
		elseif arg_8_0.monthSignReSignUI then
			arg_8_0.monthSignReSignUI:ActionInvoke("setAwardShow", var_8_1)
		end
	end

	return
end

function var_0_0.showReMonthSign(arg_9_0)
	return
end

function var_0_0.OnDestroy(arg_10_0)
	if arg_10_0.spEffectLT then
		LeanTween.cancel(arg_10_0.spEffectLT)

		arg_10_0.spEffectLT = nil
	end

	removeAllChildren(arg_10_0.items)

	arg_10_0.monthSignPageTool = nil

	arg_10_0.monthSignReSignUI:Destroy()

	arg_10_0.monthSignReSignUI = nil

	return
end

function var_0_0.UseSecondPage(arg_11_0, arg_11_1)
	local var_11_0 = pg.TimeMgr.GetInstance()

	return tonumber(var_11_0:CurrentSTimeDesc("%m", true)) == pg.activity_template[arg_11_1.id].config_client[1]
end

function var_0_0.isDirtyRes(arg_12_0)
	if arg_12_0.specialTag and arg_12_0:getUIName() ~= arg_12_0.activity:getConfig("page_info").ui_name2 then
		return true
	end

	return
end

function var_0_0.UpdateLoginInfo(arg_13_0)
	local var_13_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOGIN_RECORD)
	local var_13_1 = arg_13_0._tf:Find("login")

	setActive(var_13_1, var_13_0 and not var_13_0:isEnd())

	if var_13_0 and not var_13_0:isEnd() then
		local var_13_2, var_13_3, var_13_4 = unpack(var_13_0:getConfig("time"))

		setText(var_13_1:Find("month"), string.format("%02d/%02d/%02d-%02d/%02d/%02d", var_13_3[1][1] % 100, var_13_3[1][2], var_13_3[1][3], var_13_4[1][1] % 100, var_13_4[1][2], var_13_4[1][3]))
		setText(var_13_1:Find("count/day"), var_13_0:getData1())
	end

	return
end

function var_0_0.TryShowSpEffect(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.spDayEffects[arg_14_0.activity:getSpecialData(var_0_0.MILESTONE_SPECIAL_DATA)]

	arg_14_0.activity:setSpecialData(var_0_0.MILESTONE_SPECIAL_DATA, nil)
	setActive(arg_14_0.spDay, true)

	if arg_14_0.spEffectLT then
		LeanTween.cancel(arg_14_0.spEffectLT)

		arg_14_0.spEffectLT = nil
	end

	setActive(var_14_0, true)

	arg_14_0.spEffectLT = LeanTween.value(go(var_14_0), 0, 1, (arg_14_0:GetEffectLeftTime((var_14_0:Find("heidi"):GetComponent(typeof("UnityEngine.ParticleSystem")))))):setOnComplete(System.Action(function()
		arg_14_0.spEffectLT = nil

		arg_14_0:HideSPEffect(arg_14_1)

		return
	end)).uniqueId

	return
end

function var_0_0.GetEffectLeftTime(arg_16_0, arg_16_1)
	return arg_16_1.main.startDelay.constantMax + arg_16_1.main.duration + arg_16_1.main.startLifetime.constantMax
end

function var_0_0.HideSPEffect(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.spDayEffects) do
		if iter_17_1 then
			setActive(iter_17_1, false)
		end
	end

	setActive(arg_17_0.spDay, false)
	existCall(arg_17_1)

	return
end

function var_0_0.ShouldPlaySpEffect(arg_18_0)
	if not arg_18_0 then
		return false
	end

	if arg_18_0:getConfig("type") ~= ActivityConst.ACTIVITY_TYPE_MONTHSIGN then
		return false
	end

	local var_18_0 = arg_18_0:getSpecialData(var_0_0.MILESTONE_SPECIAL_DATA)

	return var_18_0 and table.contains(var_0_0.MONTH_SIGN_SP_DAYS, var_18_0)
end

return var_0_0
