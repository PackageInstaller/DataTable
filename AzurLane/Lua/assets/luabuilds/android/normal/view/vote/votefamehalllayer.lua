class = var_0_10000

local var_0_0 = "VoteFameHallLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 == var_1_10002 then
		return "VoteFameHallUIForCht"
	else
		return "VoteFameHallUI"
	end

	return
end

function var_0_1.SetPastVoteData(arg_2_0, arg_2_1)
	arg_2_0.voteData = arg_2_1

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "Text")
	local var_3_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.tip = var_3_2(var_3_1, var_3(var_1_10004))

	local var_3_3 = arg_3_0._tf

	arg_3_0.backBtn = var_1.Find(var_3_3, "adapt/back")

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.backBtn

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)
	arg_4_0:InitData()

	return
end

function var_0_1.InitData(arg_6_0)
	arg_6_0.displays = {}
	arg_6_0.btns = {}

	local var_6_0 = 0

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.voteData) do
		local var_6_1 = arg_6_0._tf
		local var_6_2 = var_7.Find(var_6_1, "adapt/btns/btn_" .. iter_6_0)
		local var_6_3 = arg_6_0.displays

		var_6_3[iter_6_0] = iter_6_1
		onToggle = var_6_3

		local var_6_4 = arg_6_0
		local var_6_5 = var_6_2

		local function var_6_6(arg_7_0)
			if arg_7_0 then
				local var_7_0 = arg_6_0

				var_1.Flush(var_7_0, iter_6_0)
			end

			return
		end

		SFX_PANEL = var_1_10012

		var_6_3(var_6_4, var_6_5, var_6_6, var_1_10012)

		arg_6_0.btns[iter_6_0] = var_6_2

		if var_6_0 < iter_6_0 then
			var_6_0 = iter_6_0
		end
	end

	triggerToggle = var_2

	var_2(arg_6_0.btns[var_6_0], true)
	arg_6_0:UpdateBtnsTip()

	return
end

function var_0_1.Flush(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.displays[arg_8_1]

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(var_8_0) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.vote_champion[iter_8_1]

		local var_8_1 = arg_8_0._tf
		local var_8_2 = var_9.Find(var_8_1, arg_8_1 .. "/" .. var_1_10008.rank)
		local var_8_3 = var_1_10008.story
		local var_8_4 = var_1_10008.task

		onButton = var_12

		local var_8_5 = arg_8_0
		local var_8_6 = var_8_2

		local function var_8_7()
			local var_9_0 = arg_8_0

			var_0.GetAward(var_9_0, var_8_3, var_8_4)

			return
		end

		SFX_PANEL = var_1_10016

		var_12(var_8_5, var_8_6, var_8_7, var_1_10016)
	end

	arg_8_0:UpdateTips(arg_8_1)

	arg_8_0.year = arg_8_1

	return
end

function var_0_1.UpdateTips(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_0.displays[arg_10_1]

	getProxy = var_1_10003
	AttireProxy = var_1_10004

	local var_10_1 = var_1_10003(var_1_10004)
	local var_10_2 = {
		{
			"",
			false
		},
		{
			"",
			false
		},
		{
			"",
			false
		}
	}

	ipairs = var_5

	for iter_10_0, iter_10_1 in var_5(var_10_0) do
		pg = var_1_10010

		local var_10_3 = var_1_10010.vote_champion[iter_10_1].story
		local var_10_4 = var_1_10010.task

		getProxy = var_1_10013
		TaskProxy = var_1_10014

		local var_10_5 = var_1_10013(var_1_10014)

		if not var_1_10013.getTaskById(var_10_5, var_10_4) then
			var_1_10014 = var_1_10013:getFinishTaskById(var_10_4)
		end

		local var_10_6 = arg_10_0._tf
		local var_10_7 = var_15.Find(var_10_6, arg_10_1 .. "/" .. var_1_10010.rank .. "/title/tip")

		pg = var_10_6

		local var_10_8 = var_10_6.task_data_template[var_10_4].award_display[1]
		local var_10_9 = var_10_1
		local var_10_10 = var_10_1.getAttireFrame

		AttireConst = var_19

		local var_10_11 = var_10_10(var_10_9, var_19.TYPE_ICON_FRAME, var_10_8[2])

		var_10_2[iter_10_0][2] = var_10_11 ~= nil and var_10_11:isOwned()

		local var_10_12 = var_10_2[iter_10_0]

		ShipGroup = var_19
		var_10_12[1] = var_19.getDefaultShipConfig(var_1_10010.ship_group).name
		setActive = var_10_12

		local var_10_13 = var_10_7
		local var_10_14

		if var_1_10014 and var_1_10014:isFinish() then
			var_10_14 = not var_1_10014:isReceive() and (var_10_11 == nil or not var_10_11:isOwned())
		end

		var_10_12(var_10_13, var_10_14)
	end

	_ = var_5

	local var_10_15 = var_5.map(var_10_2, function(arg_11_0)
		if arg_11_0[2] then
			local var_11_0 = arg_11_0[1]
			local var_11_1 = "(<color=#92fc63>"

			i18n = var_2_10003

			local var_11_2

			if not (var_11_0 .. var_11_1 .. var_2_10003("word_got") .. "</color>)") then
				var_11_2 = arg_11_0[1]
			end

			return var_11_2
		end
	end)
	local var_10_16 = arg_10_0.tip

	i18n = var_7
	var_10_16.text = var_7("vote_fame_tip", var_10_15[1], var_10_15[2], var_10_15[3])

	return
end

function var_0_1.UpdateBtnsTip(arg_12_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)

	getProxy = var_1_10002
	AttireProxy = var_1_10003

	local var_12_1 = var_1_10002(var_1_10003)

	pairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(arg_12_0.displays) do
		_ = var_1_10008
		var_1_10008 = var_1_10008.any(iter_12_1, function(arg_13_0)
			pg = var_2_10001

			local var_13_0 = var_2_10001.vote_champion[arg_13_0].task
			local var_13_1 = var_12_0
			local var_13_2

			if not var_3.getTaskById(var_13_1, var_13_0) then
				var_13_1 = var_12_0
				var_13_2 = var_3.getFinishTaskById(var_13_1, var_13_0)
			end

			pg = var_13_1

			local var_13_3 = var_13_1.task_data_template[var_13_0].award_display[1]
			local var_13_4 = var_12_1
			local var_13_5 = var_5.getAttireFrame

			AttireConst = var_2_10007

			local var_13_6 = var_13_5(var_13_4, var_2_10007.TYPE_ICON_FRAME, var_13_3[2])
			local var_13_7

			if var_13_2 and var_13_2:isFinish() then
				var_13_7 = not var_13_2:isReceive() and (var_13_6 == nil or not var_13_6:isOwned())
			end

			return var_13_7
		end)
		setActive = var_9

		local var_12_2 = arg_12_0.btns[iter_12_0]

		var_9(var_10.Find(var_12_2, "tip"), var_1_10008)
	end

	return
end

function var_0_1.GetAward(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {
		function(arg_15_0)
			pg = var_2_10001

			local var_15_0 = var_2_10001.NewStoryMgr.GetInstance()

			var_1.Play(var_15_0, arg_14_1, arg_15_0, true)

			return
		end,
		function(arg_16_0)
			getProxy = var_2_10001
			TaskProxy = var_2_10002

			local var_16_0 = var_2_10001(var_2_10002)
			local var_16_1

			if not var_1.getTaskById(var_16_0, arg_14_2) then
				var_16_1 = var_1:getFinishTaskById(arg_14_2)
			end

			if var_16_1 and var_16_1:isFinish() and not var_16_1:isReceive() then
				local var_16_2 = arg_14_0
				local var_16_3 = var_3.emit

				VoteFameHallMediator = var_2_10005

				var_16_3(var_16_2, var_2_10005.ON_SUBMIT_TASK, var_16_1.id)
			end

			arg_16_0()

			return
		end
	}

	seriesAsync = var_4

	var_4(var_14_0)

	return
end

function var_0_1.willExit(arg_17_0)
	return
end

return var_0_1
