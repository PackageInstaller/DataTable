class = var_0_10000

local var_0_0 = "LittleDaihoPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_0, "help_btn")

	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_1.Find(var_1_1, "step_content")

	UIItemList = var_1_1
	arg_1_0.itemList = var_1_1.New(var_1_2, var_1_2:Find("tpl"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.getBtn

	local function var_2_2()
		if arg_2_0.inLT then
			return
		end

		local var_3_0 = {}
		local var_3_1 = arg_2_0.ptData
		local var_3_2 = var_1.GetAward(var_3_1)

		getProxy = var_3_1
		PlayerProxy = var_2_10003

		local var_3_3 = var_3_1(var_2_10003)
		local var_3_4 = var_2.getRawData(var_3_3)

		pg = var_3_3

		local var_3_5 = var_3_3.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_2_10005

		if var_2_10005 then
			var_2_10005 = 0
		else
			getProxy = var_2_10005
			BagProxy = var_2_10006
			var_2_10006 = var_2_10005(var_2_10006)
			var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_3_5)
		end

		Task = var_2_10006

		local var_3_6, var_3_7 = var_2_10006.StaticJudgeOverflow(var_3_4.gold, var_3_4.oil, var_2_10005, true, true, {
			{
				var_3_2.type,
				var_3_2.id,
				var_3_2.count
			}
		})

		if var_3_6 then
			table = var_8

			var_8.insert(var_3_0, function(arg_4_0)
				pg = var_3_10001

				local var_4_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_4_1 = var_1.ShowMsgBox
				local var_4_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10004
				var_4_2.type = var_3_10004
				i18n = var_3_10004
				var_4_2.content = var_3_10004("award_max_warning")
				var_4_2.items = var_3_7
				var_4_2.onYes = arg_4_0

				var_4_1(var_4_0, var_4_2)

				return
			end)
		end

		table = var_8

		var_8.insert(var_3_0, function(arg_5_0)
			local var_5_0 = arg_2_0

			var_5_0.inLT = true
			cloneTplTo = var_5_0

			local var_5_1 = arg_2_0.itemList.container
			local var_5_2 = var_5_0(var_2.Find(var_5_1, "tpl"), arg_2_0.itemList.container)

			setLocalScale = var_2

			local var_5_3 = var_5_2

			Vector2 = var_4

			var_2(var_5_3, var_4.zero)

			LeanTween = var_2

			local var_5_4 = var_2.scale
			local var_5_5 = var_5_2

			Vector3 = var_4

			local var_5_6 = var_5_4(var_5_5, var_4.one, 0.6)
			local var_5_7 = var_2.setEase

			LeanTweenType = var_4

			local var_5_8 = var_5_7(var_5_6, var_4.easeInBack)
			local var_5_9 = var_2.setOnComplete

			System = var_4

			var_5_9(var_5_8, var_4.Action(arg_5_0))

			return
		end)

		table = var_8

		var_8.insert(var_3_0, function(arg_6_0)
			LeanTween = var_3_10001

			local var_6_0 = var_3_10001.delayedCall
			local var_6_1 = 0.2

			System = var_3_10003

			var_6_0(var_6_1, var_3_10003.Action(arg_6_0))

			return
		end)

		seriesAsync = var_8

		var_8(var_3_0, function()
			arg_2_0.inLT = false

			local var_7_0 = arg_2_0.ptData
			local var_7_1, var_7_2 = var_0.GetResProgress(var_7_0)
			local var_7_3 = arg_2_0
			local var_7_4 = var_2.emit

			ActivityMediator = var_3_10004

			local var_7_5 = var_3_10004.EVENT_PT_OPERATION
			local var_7_6 = {
				cmd = 1
			}
			local var_7_7 = arg_2_0.ptData

			var_7_6.activity_id = var_6.GetId(var_7_7)
			var_7_6.arg1 = var_7_2

			var_7_4(var_7_3, var_7_5, var_7_6)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.helpBtn

	local function var_2_5()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_8_2.type = var_2_10003
		i18n = var_2_10003
		var_8_2.helps = var_2_10003("littleTaihou_npc")

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_3, var_2_4, var_2_5, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	var_0_1.super.OnUpdateFlush(arg_9_0)

	local var_9_0 = arg_9_0.itemList
	local var_9_1 = var_1.align
	local var_9_2 = arg_9_0.ptData

	var_9_1(var_9_0, var_3.GetLevel(var_9_2))

	local var_9_3 = arg_9_0.ptData
	local var_9_4, var_9_5, var_9_6 = var_1.GetResProgress(var_9_3)

	setText = var_9_2

	local var_9_7 = arg_9_0.progress

	if 1 <= var_9_6 then
		setColorStr = var_6

		local var_9_8

		if not var_6(var_9_4, "#9F413AFF") then
			var_9_8 = var_9_4
		end

		var_9_2(var_9_7, var_9_8 .. "/" .. var_9_5)

		return
	end
end

return var_0_1
