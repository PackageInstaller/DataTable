class = var_0_10000

local var_0_0 = "NewOrleansMapPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_1, "item")

	local var_1_2 = arg_1_0.item

	arg_1_0.itemMask = var_1.Find(var_1_2, "icon_mask")

	local var_1_3 = arg_1_0.bg

	arg_1_0.gotaskBtn = var_1.Find(var_1_3, "gotask")

	local var_1_4 = arg_1_0.bg

	arg_1_0.gobattleBtn = var_1.Find(var_1_4, "gobattle")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_data")

	_ = var_2_0
	arg_2_0.taskIDList = var_2_0.flatten(var_2_1)
	getProxy = var_2
	TaskProxy = var_3
	arg_2_0.taskProxy = var_2(var_3)

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.gobattleBtn

	local function var_3_2()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_4_0 = var_2_10000(var_2_10001)
		local var_4_1 = var_0.getActivityById

		pg = var_2_10002

		if not var_4_1(var_4_0, var_2_10002.activity_const.NEW_ORLEANS_Map_BATTLE.act_id) or var_0:isEnd() then
			pg = var_4_0

			local var_4_2 = var_4_0.TipsMgr.GetInstance()
			local var_4_3 = var_1.ShowTips

			i18n = var_2_10003

			var_4_3(var_4_2, var_2_10003("challenge_end_tip"))

			return
		end

		local var_4_4 = arg_3_0
		local var_4_5 = var_1.emit

		ActivityMediator = var_2_10003

		var_4_5(var_4_4, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.gotaskBtn, function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_5_0 = var_2_10000(var_2_10001)
		local var_5_1 = var_0.getActivityById

		pg = var_2_10002

		if not var_5_1(var_5_0, var_2_10002.activity_const.NEW_ORLEANS_Map_BATTLE.act_id) or var_0:isEnd() then
			pg = var_5_0

			local var_5_2 = var_5_0.TipsMgr.GetInstance()
			local var_5_3 = var_1.ShowTips

			i18n = var_2_10003

			var_5_3(var_5_2, var_2_10003("challenge_end_tip"))

			return
		end

		local var_5_4 = arg_3_0
		local var_5_5 = var_1.emit

		ActivityMediator = var_2_10003

		local var_5_6 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_5_5(var_5_4, var_5_6, var_2_10004.TASK, {
			page = "activity"
		})

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0:findCurTaskIndex()
	local var_6_1 = arg_6_0.taskIDList[var_6_0]
	local var_6_2 = arg_6_0.taskProxy

	arg_6_0.curTaskVO = var_3.getTaskVO(var_6_2, var_6_1)

	local var_6_3 = var_3:getConfig("award_display")[1]
	local var_6_4 = {
		type = var_6_3[1],
		id = var_6_3[2],
		count = var_6_3[3]
	}

	updateDrop = var_6

	var_6(arg_6_0.item, var_6_4)

	onButton = var_6

	local var_6_5 = arg_6_0
	local var_6_6 = arg_6_0.item

	local function var_6_7()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		BaseUI = var_2_10002

		var_7_1(var_7_0, var_2_10002.ON_DROP, var_6_4)

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_6_5, var_6_6, var_6_7, var_1_10010)

	local var_6_8 = var_3
	local var_6_9 = var_3.getTaskStatus(var_6_8)

	setActive = var_6_8

	var_6_8(arg_6_0.itemMask, var_6_9 == 2)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

function var_0_1.findCurTaskIndex(arg_9_0)
	local var_9_0

	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.taskIDList) do
		local var_9_1 = arg_9_0.taskProxy
		local var_9_2 = var_7.getTaskVO(var_9_1, iter_9_1)

		if var_7.getTaskStatus(var_9_2) <= 1 then
			var_9_0 = iter_9_0

			break
		elseif iter_9_0 == #arg_9_0.taskIDList then
			var_9_0 = iter_9_0
		end
	end

	return var_9_0
end

return var_0_1
