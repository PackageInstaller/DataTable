class = var_0_10000

local var_0_0 = "AnimeLoginPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.LoginTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.dayProgressImg = var_1.Find(var_1_0, "DayProgress")

	local var_1_1 = arg_1_0._tf

	arg_1_0.awardImg = var_1.Find(var_1_1, "Award")

	local var_1_2 = arg_1_0.awardImg

	arg_1_0.maskImg = var_1.Find(var_1_2, "Mask")
	addSlip = var_1
	SLIP_TYPE_HRZ = var_1_2

	var_1(var_1_2, arg_1_0.awardImg, function()
		if arg_1_0.curShowDay > 1 then
			triggerButton = var_0

			var_0(arg_1_0.arrowLeft)
		end

		return
	end, function()
		if arg_1_0.curShowDay < arg_1_0.allDaycount then
			triggerButton = var_0

			var_0(arg_1_0.arrowRight)
		end

		return
	end)

	local var_1_3 = arg_1_0._tf

	arg_1_0.arrowLeft = var_1.Find(var_1_3, "ArrowLeft")

	local var_1_4 = arg_1_0._tf

	arg_1_0.arrowRight = var_1.Find(var_1_4, "ArrowRight")
	onButton = var_1

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.arrowLeft

	local function var_1_7()
		arg_1_0.curShowDay = arg_1_0.curShowDay - 1

		local var_4_0 = arg_1_0

		var_0.updateAwardInfo(var_4_0, arg_1_0.curShowDay)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_5, var_1_6, var_1_7, var_5)

	onButton = var_1

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.arrowRight

	local function var_1_10()
		arg_1_0.curShowDay = arg_1_0.curShowDay + 1

		local var_5_0 = arg_1_0

		var_0.updateAwardInfo(var_5_0, arg_1_0.curShowDay)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_8, var_1_9, var_1_10, var_5)

	local var_1_11 = arg_1_0._tf

	arg_1_0.pointTpl = var_1.Find(var_1_11, "Point")

	local var_1_12 = arg_1_0._tf

	arg_1_0.pointContainer = var_1.Find(var_1_12, "PointList")
	UIItemList = var_1
	arg_1_0.pointUIItemList = var_1.New(arg_1_0.pointContainer, arg_1_0.pointTpl)

	local var_1_13 = arg_1_0.pointUIItemList

	var_1.make(var_1_13, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			arg_6_1 = arg_6_1 + 1

			local var_6_0 = arg_6_2:Find("Selected")

			if arg_6_1 <= arg_1_0.nday then
				setImageAlpha = var_4

				var_4(arg_6_2, 1)
			else
				setImageAlpha = var_4

				var_4(arg_6_2, 0.3)
			end

			setActive = var_4

			var_4(var_6_0, arg_6_1 == arg_1_0.curShowDay)
		end

		return
	end)

	return
end

function var_0_1.OnDataSetting(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.activity_7_day_sign
	local var_7_1 = arg_7_0.activity

	arg_7_0.config = var_7_0[var_2.getConfig(var_7_1, "config_id")]
	arg_7_0.allDaycount = #arg_7_0.config.front_drops
	arg_7_0.nday = arg_7_0.activity.data1
	arg_7_0.curShowDay = arg_7_0.nday

	return
end

function var_0_1.OnFirstFlush(arg_8_0)
	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	arg_9_0.nday = arg_9_0.activity.data1
	arg_9_0.curShowDay = arg_9_0.nday

	arg_9_0:updateAwardInfo(arg_9_0.curShowDay)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	return
end

function var_0_1.updateAwardInfo(arg_11_0, arg_11_1)
	setImageSprite = var_1_10002

	local var_11_0 = arg_11_0.dayProgressImg

	GetSpriteFromAtlas = var_1_10004

	var_1_10002(var_11_0, var_1_10004("ui/activityuipage/animelogin_atlas", "tianshu_" .. arg_11_1), true)

	setImageSprite = var_1_10002

	local var_11_1 = arg_11_0.awardImg

	GetSpriteFromAtlas = var_4

	var_1_10002(var_11_1, var_4("ui/activityuipage/animelogin_atlas", "icon_" .. arg_11_1), true)

	setActive = var_1_10002

	var_1_10002(arg_11_0.maskImg, arg_11_1 <= arg_11_0.nday)

	setActive = var_1_10002

	var_1_10002(arg_11_0.arrowLeft, arg_11_1 ~= 1)

	setActive = var_1_10002

	var_1_10002(arg_11_0.arrowRight, arg_11_1 ~= arg_11_0.allDaycount)

	local var_11_2 = arg_11_0.pointUIItemList

	var_2.align(var_11_2, arg_11_0.allDaycount)

	return
end

return var_0_1
