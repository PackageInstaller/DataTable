class = var_0_10000

local var_0_0 = "TeaTimePuzzlePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")
	arg_1_0.total = 15

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_1.Find(var_1_1, "AD/Text")
	local var_1_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.Text = var_1_3(var_1_2, var_4(var_1_10006))

	local var_1_4 = arg_1_0._tf

	arg_1_0.container = var_1.Find(var_1_4, "AD/container")

	local var_1_5 = arg_1_0._tf

	arg_1_0.GOBtn = var_1.Find(var_1_5, "AD/go")

	local var_1_6 = arg_1_0._tf

	arg_1_0.got = var_1.Find(var_1_6, "AD/got")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getData1List(var_2_0)
	local var_2_2 = {}

	ipairs = var_2_0

	for iter_2_0, iter_2_2 in var_2_0(var_2_1 or {}) do
		var_1_10008 = iter_2_2 - 24
		assert = var_1_10009
		var_1_10011 = 0 < var_1_10008

		var_1_10009(var_1_10011, "puzzlaIndex should more than zero" .. iter_2_2)

		table = var_1_10009

		var_1_10009.insert(var_2_2, var_1_10008)
	end

	local var_2_3 = {}
	local var_2_4 = arg_2_0.activity

	if var_4.left4Day(var_2_4) then
		for iter_2_2 = 1, arg_2_0.total do
			table = var_1_10008
			var_1_10008 = var_1_10008.insert

			local var_2_5 = var_2_3

			pg = var_1_10011

			var_1_10008(var_2_5, var_1_10011.gametip["activity_puzzle_get" .. iter_2_2].tip)
		end
	end

	getProxy = var_4
	TaskProxy = var_2_4

	local var_2_6 = var_4(var_2_4)

	getProxy = var_5
	ActivityProxy = iter_2_2

	local var_2_7 = var_5(iter_2_2)

	onButton = var_2_4

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.GOBtn

	local function var_2_10()
		local var_3_0 = var_2_6
		local var_3_1 = var_0.getTasks(var_3_0)
		local var_3_2 = var_2_7
		local var_3_3 = var_1.getActivityById

		ActivityConst = var_2_10004

		if not var_3_3(var_3_2, var_2_10004.TEATIME_TW) or var_1:isEnd() then
			return
		end

		local var_3_4 = var_1
		local var_3_5 = var_1.getConfig(var_3_4, "config_data")
		local var_3_6 = false

		pairs = var_3_4

		for iter_3_0, iter_3_1 in var_3_4(var_3_1) do
			_ = var_2_10009
			var_2_10009 = var_2_10009.any
			_ = var_2_10011

			if var_2_10009(var_2_10011.flatten(var_3_5), function(arg_4_0)
				return arg_4_0 == iter_3_1.id
			end) then
				var_3_6 = true

				break
			end
		end

		if var_3_6 then
			local var_3_7 = arg_2_0
			local var_3_8 = var_4.emit

			ActivityMediator = iter_3_0
			iter_3_0 = iter_3_0.EVENT_GO_SCENE
			SCENE = iter_3_1

			var_3_8(var_3_7, iter_3_0, iter_3_1.TASK, {
				page = "activity"
			})
		else
			local var_3_9 = arg_2_0
			local var_3_10 = var_4.emit

			ActivityMediator = iter_3_0

			local var_3_11 = iter_3_0.EVENT_GO_SCENE

			SCENE = iter_3_1

			var_3_10(var_3_9, var_3_11, iter_3_1.NAVALACADEMYSCENE)
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_2_4(var_2_8, var_2_9, var_2_10, var_1_10011)

	local var_2_11 = var_2_6:getTasks()
	local var_2_12 = var_2_7
	local var_2_13 = var_2_7.getActivityById

	ActivityConst = var_2_10

	local var_2_14 = var_2_13(var_2_12, var_2_10.TEATIME_TW)
	local var_2_15 = var_7.isEnd(var_2_14)

	setActive = var_2_12

	var_2_12(arg_2_0.GOBtn, not var_2_15)

	setActive = var_2_12

	var_2_12(arg_2_0.got, var_2_15)

	local var_2_16 = arg_2_0.Text

	var_2_16.text = "<color=#A9F548FF>" .. #var_2_2 .. "</color>/" .. arg_2_0.total
	PuzzlaView = var_2_16
	arg_2_0.puzzlaView = var_2_16.New({
		bg = "bg_1",
		go = arg_2_0.container,
		list = var_2_2,
		descs = var_2_3,
		fetch = arg_2_0.activity.data1 == 1
	}, nil)

	function arg_2_0.puzzlaView.onFinish()
		if arg_2_0.activity.data1 ~= 1 then
			local var_5_0 = arg_2_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_5_1(var_5_0, var_2_10003.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_2_0.activity.id
			})
		end

		return
	end

	return
end

function var_0_1.OnDestroy(arg_6_0)
	clearImageSprite = var_1_10001

	var_1_10001(arg_6_0.bg)

	if arg_6_0.puzzlaView then
		local var_6_0 = arg_6_0.puzzlaView

		var_1.dispose(var_6_0)
	end

	return
end

return var_0_1
