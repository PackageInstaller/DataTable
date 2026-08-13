class = var_0_10000

local var_0_0 = "RyzaPtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))
local var_0_2 = 9

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.kalaSpine = var_1.Find(var_1_0, "shadow/kala")

	local var_1_1 = arg_1_0.kalaSpine

	arg_1_0.kalaAnim = var_1.GetComponent(var_1_1, "SpineAnimUI")

	local var_1_2 = arg_1_0.bg

	arg_1_0.puniSpine = var_1.Find(var_1_2, "puni")

	local var_1_3 = arg_1_0.puniSpine

	arg_1_0.puniAnim = var_1.GetComponent(var_1_3, "SpineAnimUI")

	local var_1_4 = arg_1_0.bg

	arg_1_0.feedBtn = var_1.Find(var_1_4, "feed_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.clickMask = var_1.Find(var_1_5, "click_mask")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)
	arg_2_0:InitAnimData()

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.feedBtn

	local function var_2_2()
		local var_3_0 = {}

		table = var_2_10001

		var_2_10001.insert(var_3_0, function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.PlayFeedAnim(var_4_0, arg_4_0)

			return
		end)

		local var_3_1 = arg_2_0.ptData
		local var_3_2 = var_1.GetAward(var_3_1)

		getProxy = var_2_10002
		PlayerProxy = var_4

		local var_3_3 = var_2_10002(var_4)
		local var_3_4 = var_2.getRawData(var_3_3)

		pg = var_4

		local var_3_5 = var_4.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_3_3

		if var_3_3 then
			var_3_3 = 0
		else
			getProxy = var_3_3
			BagProxy = var_2_10007

			local var_3_6 = var_3_3(var_2_10007)

			var_3_3 = var_3_3.GetLimitCntById(var_3_6, var_3_5)
		end

		Task = var_2_10006

		local var_3_7, var_3_8 = var_2_10006.StaticJudgeOverflow(var_3_4.gold, var_3_4.oil, var_3_3, true, true, {
			{
				var_3_2.type,
				var_3_2.id,
				var_3_2.count
			}
		})

		if var_3_7 then
			table = var_8

			var_8.insert(var_3_0, function(arg_5_0)
				pg = var_3_10001

				local var_5_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_5_1 = var_1.ShowMsgBox
				local var_5_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10005
				var_5_2.type = var_3_10005
				i18n = var_3_10005
				var_5_2.content = var_3_10005("award_max_warning")
				var_5_2.items = var_3_8
				var_5_2.onYes = arg_5_0

				var_5_1(var_5_0, var_5_2)

				return
			end)
		end

		seriesAsync = var_8

		var_8(var_3_0, function()
			local var_6_0 = arg_2_0.ptData
			local var_6_1, var_6_2 = var_0.GetResProgress(var_6_0)
			local var_6_3 = arg_2_0
			local var_6_4 = var_2.emit

			ActivityMediator = var_3_10005

			local var_6_5 = var_3_10005.EVENT_PT_OPERATION
			local var_6_6 = {
				cmd = 1
			}
			local var_6_7 = arg_2_0.ptData

			var_6_6.activity_id = var_7.GetId(var_6_7)
			var_6_6.arg1 = var_6_2

			var_6_4(var_6_3, var_6_5, var_6_6)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	var_0_1.super.OnUpdateFlush(arg_7_0)

	local var_7_0 = arg_7_0.ptData
	local var_7_1 = var_1.GetLevelProgress(var_7_0)

	isActive = var_1_10002

	if var_1_10002(arg_7_0.getBtn) and arg_7_0.specialPhase[var_7_1] then
		setActive = var_2

		var_2(arg_7_0.getBtn, false)

		setActive = var_2

		var_2(arg_7_0.feedBtn, true)
	else
		setActive = var_2

		var_2(arg_7_0.feedBtn, false)
	end

	return
end

function var_0_1.UpdateSpineIdle(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.kalaAnim

	var_2.SetAction(var_8_0, "pt_ui", 0)

	if arg_8_1 > arg_8_0.puniPhaseCfg[#arg_8_0.puniPhaseCfg] then
		local var_8_1 = arg_8_0.puniPhaseCfg

		math = var_3

		local var_8_2 = var_8_1[var_3.random(#arg_8_0.puniPhaseCfg)]
		local var_8_3, var_8_4, var_8_5 = arg_8_0:GetAnimName(var_8_2)
		local var_8_6 = arg_8_0.puniAnim

		var_6.SetAction(var_8_6, var_8_3, 0)
		arg_8_0:PlayIdleFeedAnim(var_8_4, var_8_5)
	else
		local var_8_7 = arg_8_0:GetAnimName()
		local var_8_8 = arg_8_0.puniAnim

		var_3.SetAction(var_8_8, var_8_7, 0)
	end

	return
end

function var_0_1.PlayIdleFeedAnim(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:PlayKalaAnim()

	local var_9_0 = arg_9_0.puniAnim

	var_3.SetActionCallBack(var_9_0, function(arg_10_0)
		if arg_10_0 == "finish" then
			local var_10_0 = arg_9_0.puniAnim

			var_1.SetActionCallBack(var_10_0, nil)

			local var_10_1 = arg_9_0.puniAnim

			var_1.SetAction(var_10_1, arg_9_2, 0)
		end

		return
	end)

	local var_9_1 = arg_9_0.puniAnim

	var_3.SetAction(var_9_1, arg_9_1, 0)

	return
end

function var_0_1.PlayFeedAnim(arg_11_0, arg_11_1)
	setActive = var_1_10002

	var_1_10002(arg_11_0.clickMask, true)

	pg = var_1_10002

	local var_11_0 = var_1_10002.UIMgr.GetInstance()

	var_2.OverlayPanel(var_11_0, arg_11_0.clickMask)
	arg_11_0:PlayKalaAnim()
	arg_11_0:PlayPuniChangeAnim(function()
		setActive = var_2_10000

		var_2_10000(arg_11_0.clickMask, false)

		pg = var_2_10000

		local var_12_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_12_0, arg_11_0.clickMask, arg_11_0.bg)

		if arg_11_1 then
			arg_11_1()
		end

		return
	end)

	return
end

function var_0_1.PlayKalaAnim(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.kalaAnim

	var_2.SetActionCallBack(var_13_0, function(arg_14_0)
		if arg_14_0 == "finish" then
			local var_14_0 = arg_13_0.kalaAnim

			var_1.SetActionCallBack(var_14_0, nil)

			local var_14_1 = arg_13_0.kalaAnim

			var_1.SetAction(var_14_1, "pt_ui", 0)

			if arg_13_1 then
				arg_13_1()
			end
		end

		return
	end)

	local var_13_1 = arg_13_0.kalaAnim

	var_2.SetAction(var_13_1, "event_weishi", 0)

	return
end

function var_0_1.PlayPuniChangeAnim(arg_15_0, arg_15_1)
	local var_15_0, var_15_1, var_15_2 = arg_15_0:GetAnimName()
	local var_15_3 = arg_15_0.puniAnim

	var_5.SetActionCallBack(var_15_3, function(arg_16_0)
		if arg_16_0 == "finish" then
			local var_16_0 = arg_15_0.puniAnim

			var_1.SetActionCallBack(var_16_0, nil)

			local var_16_1 = arg_15_0.puniAnim

			var_1.SetAction(var_16_1, var_15_2, 0)

			if arg_15_1 then
				arg_15_1()
			end
		end

		return
	end)

	local var_15_4 = arg_15_0.puniAnim

	var_5.SetAction(var_15_4, var_15_1, 0)

	return
end

function var_0_1.InitAnimData(arg_17_0)
	local var_17_0 = arg_17_0.activity

	arg_17_0.puniPhaseCfg = var_1.getConfig(var_17_0, "config_client").puni_phase
	arg_17_0.specialPhase = {}
	ipairs = var_1

	for iter_17_0, iter_17_1 in var_1(arg_17_0.puniPhaseCfg) do
		arg_17_0.specialPhase[iter_17_1] = true
	end

	arg_17_0.phase2anims = {}

	local var_17_1 = arg_17_0.ptData
	local var_17_2, var_17_3 = var_1.GetLevelProgress(var_17_1)
	local var_17_4 = 1

	for iter_17_2 = 1, arg_17_0.puniPhaseCfg[#arg_17_0.puniPhaseCfg] do
		local var_17_5 = {}

		table = var_1_10009

		var_1_10009.insert(var_17_5, "normal_" .. var_17_4)

		if arg_17_0.specialPhase[iter_17_2] then
			table = var_1_10009

			var_1_10009.insert(var_17_5, "action" .. var_17_4)

			table = var_1_10009

			var_1_10009.insert(var_17_5, "normal_" .. var_17_4 + 1)

			var_17_4 = var_17_4 + 1
		end

		table = var_1_10009

		var_1_10009.insert(arg_17_0.phase2anims, var_17_5)
	end

	return
end

function var_0_1.GetAnimName(arg_18_0, arg_18_1)
	local var_18_1

	if not arg_18_1 or not arg_18_1 then
		::label_18_0::

		local var_18_0 = arg_18_0.ptData

		var_18_1 = var_2.GetLevelProgress(var_18_0)
	end

	if var_18_1 > arg_18_0.puniPhaseCfg[#arg_18_0.puniPhaseCfg] then
		local var_18_2 = "normal_"

		math = var_4

		return var_18_2 .. var_4.random(var_0_2)
	else
		return arg_18_0.phase2anims[var_18_1][1], var_3[2], var_3[3]
	end

	return
end

function var_0_1.OnShowFlush(arg_19_0)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.UpdateSpineIdle
	local var_19_2 = arg_19_0.ptData

	var_19_1(var_19_0, var_4.GetLevelProgress(var_19_2))

	return
end

return var_0_1
