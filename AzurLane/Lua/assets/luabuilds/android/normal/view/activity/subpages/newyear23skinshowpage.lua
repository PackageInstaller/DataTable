class = var_0_10000

local var_0_0 = "NewYear23SkinShowPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnLoaded(arg_1_0)
	return
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.goBtn = var_1.Find(var_2_0, "BtnGO")

	local var_2_1 = arg_2_0._tf

	arg_2_0.skinShopBtn = var_1.Find(var_2_1, "BtnShop")
	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.skinShopBtn

	local function var_2_4()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_3_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_3_1(var_3_0, var_3_2, var_2_10003.SKINSHOP)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_2, var_2_3, var_2_4, var_1_10005)

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.goBtn

	local function var_2_7()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.NEWYEAR_BACKHILL_2023)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_5, var_2_6, var_2_7, var_1_10005)

	local var_2_8 = arg_2_0._tf

	arg_2_0.rtBg = var_1.Find(var_2_8, "AD")

	local var_2_9 = arg_2_0.rtBg

	arg_2_0.rtFront = var_1.Find(var_2_9, "front")

	return
end

function var_0_1.OnDataSetting(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.TimeMgr.GetInstance()

	arg_5_0.showList = {}
	ipairs = var_2

	local var_5_1 = arg_5_0.activity

	for iter_5_0, iter_5_1 in var_2(var_3.getConfig(var_5_1, "config_client").display_link) do
		if iter_5_1[2] ~= 0 then
			local var_5_2 = var_5_0
			local var_5_3 = var_5_0.inTime

			pg = var_1_10009

			if var_5_3(var_5_2, var_1_10009.shop_template[iter_5_1[2]].time) then
				table = var_5_3

				local var_5_4 = var_5_3.insert
				local var_5_5 = arg_5_0.showList

				math = var_1_10009

				var_5_4(var_5_5, var_1_10009.random(#arg_5_0.showList + 1), iter_5_1[1])
			end
		end
	end

	return
end

function var_0_1.OnFirstFlush(arg_6_0)
	arg_6_0:ActionInvoke("ShowOrHide", false)

	arg_6_0.index = 1
	GetSpriteFromAtlasAsync = var_1

	var_1("clutter/newyear23skinshowpage_" .. arg_6_0.showList[arg_6_0.index], "", function(arg_7_0)
		if arg_6_0._state == var_0_1.STATES.DESTROY then
			return
		end

		setImageSprite = var_1

		var_1(arg_6_0.rtBg, arg_7_0)

		setImageAlpha = var_1

		var_1(arg_6_0.rtFront, 0)

		local var_7_0 = arg_6_0

		var_1.ActionInvoke(var_7_0, "ShowOrHide", true)

		local var_7_1 = arg_6_0

		var_1.DelayCall(var_7_1)

		return
	end)

	return
end

function var_0_1.DelayCall(arg_8_0)
	local var_8_0 = {}

	table = var_1_10002

	var_1_10002.insert(var_8_0, function(arg_9_0)
		local var_9_0 = arg_8_0

		LeanTween = var_2_10002

		local var_9_1 = var_2_10002.delayedCall
		local var_9_2 = 3

		System = var_2_10004
		var_9_0.uniqueId = var_9_1(var_9_2, var_2_10004.Action(arg_9_0)).uniqueId

		return
	end)

	table = var_2

	var_2.insert(var_8_0, function(arg_10_0)
		local var_10_0 = arg_8_0

		var_10_0.index = arg_8_0.index % #arg_8_0.showList + 1
		GetSpriteFromAtlasAsync = var_10_0

		var_10_0("clutter/newyear23skinshowpage_" .. arg_8_0.showList[arg_8_0.index], "", function(arg_11_0)
			if arg_8_0._state == var_0_1.STATES.DESTROY then
				return
			end

			arg_8_0.nextSprite = arg_11_0

			arg_10_0()

			return
		end)

		return
	end)

	parallelAsync = var_2

	var_2(var_8_0, function()
		setImageSprite = var_2_10000

		local var_12_0 = arg_8_0.rtFront

		getImageSprite = var_2_10002

		var_2_10000(var_12_0, var_2_10002(arg_8_0.rtBg))

		setImageAlpha = var_2_10000

		var_2_10000(arg_8_0.rtFront, 1)

		setImageSprite = var_2_10000

		var_2_10000(arg_8_0.rtBg, arg_8_0.nextSprite)

		local var_12_1 = arg_8_0

		LeanTween = var_1

		local var_12_2 = var_1.alpha(arg_8_0.rtFront, 0, 0.5)
		local var_12_3 = var_1.setEase

		LeanTweenType = var_3

		local var_12_4 = var_12_3(var_12_2, var_3.easeOutSine)
		local var_12_5 = var_1.setOnComplete

		System = var_3
		var_12_1.uniqueId = var_12_5(var_12_4, var_3.Action(function()
			local var_13_0 = arg_8_0

			var_0.DelayCall(var_13_0)

			return
		end)).uniqueId

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	if arg_14_0.uniqueId then
		LeanTween = var_1

		var_1.cancel(arg_14_0.uniqueId)
	end

	return
end

return var_0_1
