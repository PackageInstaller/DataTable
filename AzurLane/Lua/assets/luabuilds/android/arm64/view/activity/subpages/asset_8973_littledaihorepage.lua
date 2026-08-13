class = var_0_10000

local var_0_0 = "LittleDaihoRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_0, "help_btn")

	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_1.Find(var_1_1, "step_content")

	UIItemList = var_1_10002
	arg_1_0.itemList = var_1_10002.New(var_1_2, var_1_2:Find("tpl"))

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

		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_3_3 = var_2_10002(var_2_10004)
		local var_3_4 = var_2.getRawData(var_3_3)

		pg = var_2_10004

		local var_3_5 = var_2_10004.gameset.urpt_chapter_max.description[1]

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

			var_8.insert(var_3_0, function(arg_4_0)
				pg = var_3_10001

				local var_4_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_4_1 = var_1.ShowMsgBox
				local var_4_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10005
				var_4_2.type = var_3_10005
				i18n = var_3_10005
				var_4_2.content = var_3_10005("award_max_warning")
				var_4_2.items = var_3_8
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
			local var_5_2 = var_5_0(var_3.Find(var_5_1, "tpl"), arg_2_0.itemList.container)

			setLocalScale = var_2

			local var_5_3 = var_5_2

			Vector2 = var_5_1

			var_2(var_5_3, var_5_1.zero)

			LeanTween = var_2

			local var_5_4 = var_2.scale
			local var_5_5 = var_5_2

			Vector3 = var_5

			local var_5_6 = var_5_4(var_5_5, var_5.one, 0.6)
			local var_5_7 = var_2.setEase

			LeanTweenType = var_5

			local var_5_8 = var_5_7(var_5_6, var_5.easeInBack)
			local var_5_9 = var_2.setOnComplete

			System = var_5

			var_5_9(var_5_8, var_5.Action(arg_5_0))

			return
		end)

		table = var_8

		var_8.insert(var_3_0, function(arg_6_0)
			LeanTween = var_3_10001

			local var_6_0 = var_3_10001.delayedCall
			local var_6_1 = 0.2

			System = var_3_10004

			var_6_0(var_6_1, var_3_10004.Action(arg_6_0))

			return
		end)

		seriesAsync = var_8

		var_8(var_3_0, function()
			arg_2_0.inLT = false

			local var_7_0 = arg_2_0.ptData
			local var_7_1, var_7_2 = var_0.GetResProgress(var_7_0)
			local var_7_3 = arg_2_0
			local var_7_4 = var_2.emit

			ActivityMediator = var_3_10005

			local var_7_5 = var_3_10005.EVENT_PT_OPERATION
			local var_7_6 = {
				cmd = 1
			}
			local var_7_7 = arg_2_0.ptData

			var_7_6.activity_id = var_7.GetId(var_7_7)
			var_7_6.arg1 = var_7_2

			var_7_4(var_7_3, var_7_5, var_7_6)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.battleBtn

	local function var_2_5()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_8_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_8_1(var_8_0, var_8_2, var_2_10004.LEVEL)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.helpBtn

	local function var_2_8()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_9_2.type = var_2_10004
		i18n = var_2_10004
		var_9_2.helps = var_2_10004("littleTaihou_npc")

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_6, var_2_7, var_2_8, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	var_0_1.super.OnUpdateFlush(arg_10_0)

	local var_10_0 = arg_10_0.itemList
	local var_10_1 = var_1.align
	local var_10_2 = arg_10_0.ptData

	var_10_1(var_10_0, var_4.GetLevel(var_10_2))

	local var_10_3 = arg_10_0.ptData
	local var_10_4, var_10_5, var_10_6 = var_1.GetResProgress(var_10_3)

	setText = var_4

	local var_10_7 = arg_10_0.progress

	if 1 <= var_10_6 then
		setColorStr = var_7

		local var_10_8

		if not var_7(var_10_4, "#9F413AFF") then
			var_10_8 = var_10_4
		end

		var_4(var_10_7, var_10_8 .. "/" .. var_10_5)

		return
	end
end

return var_0_1
