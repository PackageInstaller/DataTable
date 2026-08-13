class = var_0_10000

local var_0_0 = "ChapterPreCombatMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_START = "ChapterPreCombatMediator:ON_START"
var_0_1.ON_SWITCH_SHIP = "ChapterPreCombatMediator:ON_SWITCH_SHIP"
var_0_1.ON_SWITCH_FLEET = "ChapterPreCombatMediator:ON_SWITCH_FLEET"
var_0_1.ON_OP = "ChapterPreCombatMediator:ON_OP"
var_0_1.ON_AUTO = "ChapterPreCombatMediator:ON_AUTO"
var_0_1.ON_SUB_AUTO = "ChapterPreCombatMediator:ON_SUB_AUTO"
var_0_1.GET_CHAPTER_DROP_SHIP_LIST = "ChapterPreCombatMediator:GET_CHAPTER_DROP_SHIP_LIST"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GET_CHAPTER_DROP_SHIP_LIST, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.GET_CHAPTER_DROP_SHIP_LIST, {
			chapterId = arg_2_1,
			callback = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SWITCH_SHIP, function(arg_3_0, arg_3_1)
		getProxy = var_2_10002
		ChapterProxy = var_2_10003

		local var_3_0 = var_2_10002(var_2_10003)
		local var_3_1 = var_2.getActiveChapter(var_3_0).fleet

		var_4.synchronousShipIndex(var_3_1, arg_3_1)

		local var_3_2 = var_2
		local var_3_3 = var_2.updateChapter
		local var_3_4 = var_3

		ChapterConst = var_2_10007

		var_3_3(var_3_2, var_3_4, var_2_10007.DirtyFleet)

		return
	end)
	arg_1_0:bind(var_0_1.ON_AUTO, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.onAutoBtn(var_4_0, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUB_AUTO, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0

		var_2.onAutoSubBtn(var_5_0, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_START, function(arg_6_0)
		getProxy = var_2_10001
		ChapterProxy = var_2_10002

		local var_6_0 = var_2_10001(var_2_10002)
		local var_6_1 = var_1.getActiveChapter(var_6_0).fleet
		local var_6_2 = var_1
		local var_6_3 = var_1.getStageId(var_6_2, var_6_1.line.row, var_6_1.line.column)

		seriesAsync = var_6_2

		var_6_2({
			function(arg_7_0)
				local var_7_0 = {}

				pairs = var_3_10002

				for iter_7_0, iter_7_1 in var_3_10002(var_6_1.ships) do
					table = var_3_10007

					var_3_10007.insert(var_7_0, iter_7_1)
				end

				Fleet = var_2

				var_2.EnergyCheck(var_7_0, var_6_1.name, function(arg_8_0)
					if arg_8_0 then
						arg_7_0()
					end

					return
				end)

				return
			end,
			function(arg_9_0)
				getProxy = var_3_10001
				PlayerProxy = var_3_10002

				local var_9_0 = var_3_10001(var_3_10002)
				local var_9_1 = var_1.getRawData(var_9_0)

				if var_1.GoldMax(var_9_1, 1) then
					i18n = var_2

					local var_9_2 = var_2("gold_max_tip_title")

					i18n = var_3

					local var_9_3 = var_9_2 .. var_3("resource_max_tip_battle")

					pg = var_3

					local var_9_4 = var_3.MsgboxMgr.GetInstance()

					var_3.ShowMsgBox(var_9_4, {
						content = var_9_3,
						onYes = arg_9_0
					})
				else
					arg_9_0()
				end

				return
			end
		}, function()
			local var_10_0 = arg_1_0
			local var_10_1 = var_0.sendNotification

			GAME = var_3_10002

			local var_10_2 = var_3_10002.BEGIN_STAGE
			local var_10_3 = {}

			SYSTEM_SCENARIO = var_3_10004
			var_10_3.system = var_3_10004
			var_10_3.stageId = var_6_3

			var_10_1(var_10_0, var_10_2, var_10_3)

			return
		end)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_OP, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.sendNotification

		GAME = var_2_10004

		var_11_1(var_11_0, var_2_10004.CHAPTER_OP, arg_11_1)

		return
	end)

	getProxy = var_1
	ChapterProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActiveChapter(var_1_1).fleet
	local var_1_3 = var_2:getStageId(var_1_2.line.row, var_1_2.line.column)
	local var_1_4 = arg_1_0.viewComponent

	var_5.setSubFlag(var_1_4, var_1.getSubAidFlag(var_2, var_1_3))

	local var_1_5 = arg_1_0.viewComponent
	local var_1_6 = var_5.setPlayerInfo

	getProxy = var_7
	PlayerProxy = var_8

	local var_1_7 = var_7(var_8)

	var_1_6(var_1_5, var_7.getRawData(var_1_7))
	arg_1_0:display()

	return
end

function var_0_1.onAutoBtn(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.isOn
	local var_12_1 = arg_12_1.toggle
	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.sendNotification

	GAME = var_1_10006

	var_12_3(var_12_2, var_1_10006.AUTO_BOT, {
		isActiveBot = var_12_0,
		toggle = var_12_1
	})

	return
end

function var_0_1.onAutoSubBtn(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.isOn
	local var_13_1 = arg_13_1.toggle
	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.sendNotification

	GAME = var_1_10006

	var_13_3(var_13_2, var_1_10006.AUTO_SUB, {
		isActiveSub = var_13_0,
		toggle = var_13_1
	})

	return
end

function var_0_1.listNotificationInterests(arg_14_0)
	local var_14_0 = {}

	PlayerProxy = var_1_10002
	var_14_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_14_0[2] = var_2.BEGIN_STAGE_ERRO
	GAME = var_2
	var_14_0[3] = var_2.CHAPTER_OP_DONE

	return var_14_0
end

function var_0_1.handleNotification(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:getName()
	local var_15_1 = arg_15_1
	local var_15_2 = arg_15_1.getBody(var_15_1)

	PlayerProxy = var_15_1

	local var_15_3

	if var_15_0 == var_15_1.UPDATED then
		var_1_10005 = arg_15_0.viewComponent
		var_15_3 = var_15_3.setPlayerInfo
		getProxy = var_1_10006
		PlayerProxy = var_1_10007
		var_1_10007 = var_1_10006(var_1_10007)

		var_15_3(var_1_10005, var_6.getRawData(var_1_10007))

		goto label_15_0
	end

	GAME = var_15_3

	local var_15_4

	if var_15_0 == var_15_3.BEGIN_STAGE_ERRO then
		setActive = var_15_4

		var_15_4(arg_15_0.viewComponent._startBtn, true)

		if var_15_2 == 3 then
			pg = var_15_4
			var_1_10005 = var_15_4.MsgboxMgr.GetInstance()
			var_15_4 = var_15_4.ShowMsgBox

			local var_15_5 = {
				hideNo = true
			}

			i18n = var_1_10007
			var_15_5.content = var_1_10007("battle_preCombatMediator_timeout")

			function var_15_5.onYes()
				local var_16_0 = arg_15_0.viewComponent
				local var_16_1 = var_0.emit

				BaseUI = var_2_10002

				var_16_1(var_16_0, var_2_10002.ON_CLOSE)

				return
			end

			var_15_4(var_1_10005, var_15_5)
		end

		goto label_15_0
	end

	GAME = var_15_4

	if var_15_0 == var_15_4.CHAPTER_OP_DONE then
		local var_15_6 = var_15_2.type

		ChapterConst = var_1_10005

		if var_15_6 ~= var_1_10005.OpStrategy then
			local var_15_7 = var_15_2.type

			ChapterConst = var_5

			if var_15_7 ~= var_5.OpRepair then
				do
					local var_15_8 = var_15_2.type

					ChapterConst = var_5

					if var_15_8 == var_5.OpRequest then
						arg_15_0:display()
					end
				end

				::label_15_0::

				return
			end
		end
	end
end

function var_0_1.display(arg_17_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)
	local var_17_1 = var_1.getActiveChapter(var_17_0)
	local var_17_2 = arg_17_0.viewComponent

	var_3.updateChapter(var_17_2, var_17_1)

	return
end

return var_0_1
