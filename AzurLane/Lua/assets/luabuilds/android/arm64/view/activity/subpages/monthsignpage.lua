class = var_0_10000

local var_0_0 = "MonthSignPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

var_0_1.SHOW_RE_MONTH_SIGN = "show re month sign award"
var_0_1.MILESTONE_SPECIAL_DATA = "month_sign_milestone_day"
var_0_1.MONTH_SIGN_SHOW = {}
var_0_1.MONTH_SIGN_SP_DAYS = {
	30,
	60,
	120,
	240,
	300
}

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0._tf

	arg_1_0.items = var_1.Find(var_1_1, "items")

	local var_1_2 = arg_1_0.items

	arg_1_0.item = var_1.Find(var_1_2, "item")

	local var_1_3 = arg_1_0._tf

	arg_1_0.spDay = var_1.Find(var_1_3, "sp_day")
	arg_1_0.spDayEffects = {}
	MonthSignReSignUI = var_1
	arg_1_0.monthSignReSignUI = var_1.New(arg_1_0._tf, arg_1_0.event, nil)

	local var_1_4 = arg_1_0

	arg_1_0.bind(var_1_4, var_0_1.SHOW_RE_MONTH_SIGN, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0.monthSignReSignUI

		if not var_3.GetLoaded(var_2_0) then
			local var_2_1 = arg_1_0.monthSignReSignUI

			var_3.Load(var_2_1)
		end

		local var_2_2 = arg_1_0.monthSignReSignUI

		var_3.ActionInvoke(var_2_2, "setAwardShow", arg_2_1, arg_2_2)

		return
	end)

	ipairs = var_1
	MonthSignPage = var_1_4

	for iter_1_0, iter_1_1 in var_1(var_1_4.MONTH_SIGN_SP_DAYS) do
		local var_1_5 = arg_1_0.spDay
		local var_1_6 = var_6.Find(var_1_5, iter_1_1 .. "days")
		local var_1_7 = arg_1_0.spDayEffects

		var_1_7[iter_1_1] = var_1_6
		setActive = var_1_7

		var_1_7(var_1_6, false)
	end

	setActive = var_1

	var_1(arg_1_0.spDay, false)

	setText = var_1

	local var_1_8 = arg_1_0._tf
	local var_1_9 = var_3.Find(var_1_8, "login/Text")

	i18n = var_4

	var_1(var_1_9, var_4("yearly_sign_in"))

	setText = var_1

	local var_1_10 = arg_1_0._tf
	local var_1_11 = var_3.Find(var_1_10, "login/count/Text")

	i18n = var_4

	var_1(var_1_11, var_4("word_date"))

	return
end

function var_0_1.OnDataSetting(arg_3_0)
	pg = var_1_10001
	arg_3_0.config = var_1_10001.activity_month_sign[arg_3_0.activity.data2]

	if not arg_3_0.config then
		return true
	end

	pg = var_1

	local var_3_0 = var_1.TimeMgr.GetInstance()

	arg_3_0.monthDays = var_1.CalcMonthDays(var_3_0, arg_3_0.activity.data1, arg_3_0.activity.data2)
	pg = var_1

	local var_3_1 = var_1.TimeMgr.GetInstance()
	local var_3_2 = var_1.GetServerTime(var_3_1)

	tonumber = var_2
	pg = var_4

	local var_3_3 = var_4.TimeMgr.GetInstance()
	local var_3_4 = var_2(var_4.STimeDescS(var_3_3, var_3_2, "%m"))

	pg = var_3_1

	local var_3_5 = var_3_1.activity_template

	ActivityConst = var_4

	if var_3_4 == var_3_5[var_4.MONTH_SIGN_ACTIVITY_ID].config_client[1] then
		arg_3_0.specialTag = true
		pg = var_4

		local var_3_6 = var_4.activity_template

		ActivityConst = var_5
		arg_3_0.specialDay = var_3_6[var_5.MONTH_SIGN_ACTIVITY_ID].config_client[2]
		pg = var_4

		local var_3_7 = var_4.activity_template

		ActivityConst = var_5
		arg_3_0.isShowFrame = var_3_7[var_5.MONTH_SIGN_ACTIVITY_ID].config_client[3]
	end

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	UIItemList = var_1_10001
	arg_4_0.list = var_1_10001.New(arg_4_0.items, arg_4_0.item)

	local var_4_0 = arg_4_0.list

	var_1.make(var_4_0, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_5_1 + 1

			_ = var_2_10004

			local var_5_1 = var_2_10004.map(arg_4_0.config["day" .. var_5_0], function(arg_6_0)
				Drop = var_3_10001

				return var_3_10001.Create(arg_6_0)
			end)

			updateDrop = var_2_10005

			var_2_10005(arg_5_2, var_5_1[1])

			onButton = var_2_10005

			local var_5_2 = arg_4_0
			local var_5_3 = arg_5_2

			local function var_5_4()
				if #var_5_1 == 1 then
					local var_7_0 = arg_4_0
					local var_7_1 = var_0.emit

					BaseUI = var_3_10003

					var_7_1(var_7_0, var_3_10003.ON_DROP, var_5_1[1])
				else
					local var_7_2 = arg_4_0
					local var_7_3 = var_0.emit

					BaseUI = var_3_10003

					var_7_3(var_7_2, var_3_10003.ON_DROP_LIST, {
						content = "",
						item2Row = true,
						itemList = var_5_1
					})
				end

				return
			end

			SFX_PANEL = var_2_10010

			var_2_10005(var_5_2, var_5_3, var_5_4, var_2_10010)

			setText = var_2_10005

			var_2_10005(arg_5_2:Find("day/Text"), "Day " .. var_5_0)

			setActive = var_2_10005

			var_2_10005(arg_5_2:Find("got"), var_5_0 <= #arg_4_0.activity.data1_list)

			setActive = var_2_10005

			var_2_10005(arg_5_2:Find("today"), var_5_0 == #arg_4_0.activity.data1_list)

			if arg_4_0.specialTag and var_5_0 == arg_4_0.specialDay then
				local var_5_5 = arg_5_2:Find("icon_bg/SpecialFrame")

				if arg_4_0.isShowFrame == 1 then
					setActive = var_6

					var_6(var_5_5, false)
				else
					setActive = var_6

					var_6(var_5_5, true)
				end
			end
		end

		return
	end)
	arg_4_0:UpdateLoginInfo()

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	if arg_8_0:isDirtyRes() then
		return
	end

	arg_8_0:UpdateLoginInfo()

	local var_8_0 = arg_8_0.list

	var_1.align(var_8_0, arg_8_0.monthDays)

	if arg_8_0.specialTag then
		local var_8_1 = arg_8_0._tf
		local var_8_2 = var_1.Find(var_8_1, "DayNumText")
		local var_8_3

		if arg_8_0.specialDay - #arg_8_0.activity.data1_list < 0 then
			var_8_3 = 0
		end

		setText = var_3

		var_3(var_8_2, var_8_3)

		var_1_10005 = arg_8_0._tf

		local var_8_4 = var_3.Find(var_1_10005, "ProgressBar")

		GetComponent = var_4
		var_4(var_8_4, "Slider").value = #arg_8_0.activity.data1_list
	end

	local var_8_5 = arg_8_0.activity

	if var_1.getSpecialData(var_8_5, "month_sign_awards") then
		local var_8_6 = #var_1

		if 0 < var_8_6 then
			getProxy = var_8_6
			PlayerProxy = var_4

			local var_8_7 = var_8_6(var_4)
			local var_8_8 = var_2.getPlayerId(var_8_7)

			table = var_3

			local var_8_9 = var_3.contains

			MonthSignPage = var_1_10005

			if not var_8_9(var_1_10005.MONTH_SIGN_SHOW, arg_8_0.activity.id .. ":" .. var_8_8) then
				table = var_3

				local var_8_10 = var_3.insert

				MonthSignPage = var_5

				var_8_10(var_5.MONTH_SIGN_SHOW, arg_8_0.activity.id .. ":" .. var_8_8)

				local var_8_11 = arg_8_0.monthSignReSignUI

				if not var_3.GetLoaded(var_8_11) then
					local var_8_12 = arg_8_0.monthSignReSignUI

					var_3.Load(var_8_12)
				end

				local var_8_13 = arg_8_0.monthSignReSignUI

				var_3.ActionInvoke(var_8_13, "setAwardShow", var_1)
			elseif arg_8_0.monthSignReSignUI then
				local var_8_14 = arg_8_0.monthSignReSignUI

				var_3.ActionInvoke(var_8_14, "setAwardShow", var_1)
			end
		end
	end

	return
end

function var_0_1.showReMonthSign(arg_9_0)
	return
end

function var_0_1.OnDestroy(arg_10_0)
	if arg_10_0.spEffectLT then
		LeanTween = var_1

		var_1.cancel(arg_10_0.spEffectLT)

		arg_10_0.spEffectLT = nil
	end

	removeAllChildren = var_1

	var_1(arg_10_0.items)

	arg_10_0.monthSignPageTool = nil

	local var_10_0 = arg_10_0.monthSignReSignUI

	var_1.Destroy(var_10_0)

	arg_10_0.monthSignReSignUI = nil

	return
end

function var_0_1.UseSecondPage(arg_11_0, arg_11_1)
	tonumber = var_1_10002
	pg = var_1_10004

	local var_11_0 = var_1_10004.TimeMgr.GetInstance()
	local var_11_1 = var_1_10002(var_4.CurrentSTimeDesc(var_11_0, "%m", true))

	pg = var_1_10003

	return var_11_1 == var_1_10003.activity_template[arg_11_1.id].config_client[1]
end

function var_0_1.isDirtyRes(arg_12_0)
	if arg_12_0.specialTag then
		local var_12_0 = arg_12_0:getUIName()
		local var_12_1 = arg_12_0.activity

		if var_12_0 ~= var_2.getConfig(var_12_1, "page_info").ui_name2 then
			return true
		end
	end

	return
end

function var_0_1.UpdateLoginInfo(arg_13_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_13_2 = var_13_1(var_13_0, var_1_10004.ACTIVITY_TYPE_LOGIN_RECORD)
	local var_13_3 = arg_13_0._tf
	local var_13_4 = var_2.Find(var_13_3, "login")

	setActive = var_13_0

	var_13_0(var_13_4, var_13_2 and not var_13_2:isEnd())

	if var_13_2 and not var_13_2:isEnd() then
		unpack = var_3

		local var_13_5, var_13_6, var_13_7 = var_3(var_13_2:getConfig("time"))

		setText = var_6

		local var_13_8 = var_13_4:Find("month")

		string = var_1_10009

		var_6(var_13_8, var_1_10009.format("%02d/%02d/%02d-%02d/%02d/%02d", var_13_6[1][1] % 100, var_13_6[1][2], var_13_6[1][3], var_13_7[1][1] % 100, var_13_7[1][2], var_13_7[1][3]))

		setText = var_6

		var_6(var_13_4:Find("count/day"), var_13_2:getData1())
	end

	return
end

function var_0_1.TryShowSpEffect(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.activity
	local var_14_1 = var_2.getSpecialData(var_14_0, var_0_1.MILESTONE_SPECIAL_DATA)
	local var_14_2 = arg_14_0.spDayEffects[var_14_1]
	local var_14_3 = var_3.Find(var_14_2, "heidi")
	local var_14_4 = var_4.GetComponent

	typeof = var_1_10008

	local var_14_5 = var_14_4(var_14_3, var_1_10008("UnityEngine.ParticleSystem"))
	local var_14_6 = arg_14_0:GetEffectLeftTime(var_14_5)
	local var_14_7 = arg_14_0.activity

	var_7.setSpecialData(var_14_7, var_0_1.MILESTONE_SPECIAL_DATA, nil)

	setActive = var_7

	var_7(arg_14_0.spDay, true)

	if arg_14_0.spEffectLT then
		LeanTween = var_7

		var_7.cancel(arg_14_0.spEffectLT)

		arg_14_0.spEffectLT = nil
	end

	setActive = var_7

	var_7(var_3, true)

	LeanTween = var_7

	local var_14_8 = var_7.value

	go = var_9

	local var_14_9 = var_14_8(var_9(var_3), 0, 1, var_14_6)
	local var_14_10 = var_7.setOnComplete

	System = var_10
	arg_14_0.spEffectLT = var_14_10(var_14_9, var_10.Action(function()
		arg_14_0.spEffectLT = nil

		local var_15_0 = arg_14_0

		var_0.HideSPEffect(var_15_0, arg_14_1)

		return
	end)).uniqueId

	return
end

function var_0_1.GetEffectLeftTime(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.main.duration
	local var_16_1 = var_2.startLifetime.constantMax

	return var_2.startDelay.constantMax + var_16_0 + var_16_1
end

function var_0_1.HideSPEffect(arg_17_0, arg_17_1)
	pairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.spDayEffects) do
		if iter_17_1 then
			setActive = var_1_10007

			var_1_10007(iter_17_1, false)
		end
	end

	setActive = var_2

	var_2(arg_17_0.spDay, false)

	existCall = var_2

	var_2(arg_17_1)

	return
end

function var_0_1.ShouldPlaySpEffect(arg_18_0)
	if not arg_18_0 then
		return false
	end

	local var_18_0 = arg_18_0:getConfig("type")

	ActivityConst = var_1_10002

	if var_18_0 ~= var_1_10002.ACTIVITY_TYPE_MONTHSIGN then
		return false
	end

	local var_18_1

	if arg_18_0:getSpecialData(var_0_1.MILESTONE_SPECIAL_DATA) then
		::label_18_0::

		table = var_18_1
		var_18_1 = var_18_1.contains(var_0_1.MONTH_SIGN_SP_DAYS, var_1)
	end

	return var_18_1
end

return var_0_1
