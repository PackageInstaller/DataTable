class = var_0_10000

local var_0_0 = "MainActivityBtnView4Mellow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...theme_classic.view.MainActivityBtnView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_1

	arg_1_0.mapEventTr = arg_1_1.Find(var_1_0, "right/1/act/act_battle")
	MainActivityBtnMellowAdapt = var_3

	local var_1_1 = var_3.New

	MainActMapBtn = var_1_0
	arg_1_0.mapBtn = var_1_1(var_1_0.New(arg_1_0.mapEventTr, arg_1_0.event, true, true))

	local var_1_2 = arg_1_1

	arg_1_0.mapSubEventTr = arg_1_1.Find(var_1_2, "right/1/act/act_sub_battle")
	MainActivityBtnMellowAdapt = var_3

	local var_1_3 = var_3.New

	MainActSubMapBtn = var_1_2
	arg_1_0.mapSubBtn = var_1_3(var_1_2.New(arg_1_0.mapSubEventTr, arg_1_0.event, true, true))

	local var_1_4 = arg_1_1

	arg_1_0.voteEventTr = arg_1_1.Find(var_1_4, "right/1/act/act_vote")
	MainActivityBtnMellowAdapt = var_3

	local var_1_5 = var_3.New

	NewMainVoteEntranceBtn = var_1_4
	arg_1_0.voteBtn = var_1_5(var_1_4.New(arg_1_0.voteEventTr, arg_1_0.event))

	local var_1_6 = arg_1_1

	arg_1_0.subActEventTr = arg_1_1.Find(var_1_6, "right/1/act/act_sub")
	MainActivityBtnMellowAdapt = var_3

	local var_1_7 = var_3.New

	MainSubActBtn = var_1_6
	arg_1_0.subActBtn = var_1_7(var_1_6.New(arg_1_0.subActEventTr, arg_1_0.event, true, true))

	return
end

function var_0_1.InitBtns(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.actBtnTpl = var_1.Find(var_2_0, "right/activity/tpl")

	var_0_1.super.InitBtns(arg_2_0)

	_ = var_1

	local var_2_1 = var_1.select(arg_2_0.activityBtns, function(arg_3_0)
		isa = var_2_10001

		local var_3_0 = arg_3_0

		MainActMapBtn = var_2_10004

		return not var_2_10001(var_3_0, var_2_10004)
	end)

	_ = var_1_10002
	arg_2_0.activityBtns = var_1_10002.map(var_2_1, function(arg_4_0)
		MainActivityBtnMellowAdapt = var_2_10001

		return var_2_10001.New(arg_4_0)
	end)
	_ = var_2
	arg_2_0.specailBtns = var_2.map(arg_2_0.specailBtns, function(arg_5_0)
		assert = var_2_10001
		_G = var_2_10003

		var_2_10001(var_2_10003[arg_5_0.__cname .. "MellowAdapt"])

		_G = var_2_10001

		return var_2_10001[arg_5_0.__cname .. "MellowAdapt"].New(arg_5_0)
	end)

	return
end

function var_0_1.GetBtn(arg_6_0, arg_6_1)
	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.activityBtns) do
		isa = var_1_10007

		if var_1_10007(iter_6_1.activityBtn, arg_6_1) then
			return iter_6_1
		end
	end

	ipairs = var_2

	for iter_6_2, iter_6_3 in var_2(arg_6_0.specailBtns) do
		isa = var_1_10007

		if var_1_10007(iter_6_3.spActBtn, arg_6_1) then
			return iter_6_3
		end
	end

	return nil
end

function var_0_1.Flush(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1, var_7_2 = arg_7_0.FilterActivityBtns(var_7_0)

	ipairs = var_7_0

	for iter_7_0, iter_7_1 in var_7_0(var_7_1) do
		iter_7_1:Init(iter_7_0)
	end

	ipairs = var_3

	for iter_7_2, iter_7_3 in var_3(var_7_2) do
		iter_7_3:Clear()
	end

	local var_7_3 = arg_7_0
	local var_7_4, var_7_5 = arg_7_0.FilterSpActivityBtns(var_7_3)

	ipairs = var_7_3

	for iter_7_4, iter_7_5 in var_7_3(var_7_4) do
		iter_7_5:Init()
	end

	ipairs = var_5

	for iter_7_6, iter_7_7 in var_5(var_7_5) do
		iter_7_7:Clear()
	end

	local var_7_6 = arg_7_0.mapBtn

	if var_5.InShowTime(var_7_6) then
		local var_7_7 = arg_7_0.mapBtn

		var_5.Init(var_7_7)
	else
		local var_7_8 = arg_7_0.mapBtn

		var_5.Clear(var_7_8)
	end

	local var_7_9 = arg_7_0.mapSubBtn

	if var_5.InShowTime(var_7_9) then
		local var_7_10 = arg_7_0.mapSubBtn

		var_5.Init(var_7_10)
	else
		local var_7_11 = arg_7_0.mapSubBtn

		var_5.Clear(var_7_11)
	end

	local var_7_12 = arg_7_0.voteBtn

	if var_5.InShowTime(var_7_12) then
		local var_7_13 = arg_7_0.voteBtn

		var_5.Init(var_7_13)
	else
		local var_7_14 = arg_7_0.voteBtn

		var_5.Hide(var_7_14)
	end

	local var_7_15 = arg_7_0.subActBtn

	if var_5.InShowTime(var_7_15) then
		local var_7_16 = arg_7_0.subActBtn

		var_5.Init(var_7_16)
	else
		local var_7_17 = arg_7_0.subActBtn

		var_5.Clear(var_7_17)
	end

	return
end

function var_0_1.GetDirection(arg_8_0)
	Vector2 = var_1_10001

	return var_1_10001.zero
end

function var_0_1.Dispose(arg_9_0)
	var_0_1.super.Dispose(arg_9_0)

	local var_9_0 = arg_9_0.mapBtn

	var_1.Dispose(var_9_0)

	arg_9_0.mapBtn = nil

	local var_9_1 = arg_9_0.mapSubBtn

	var_1.Dispose(var_9_1)

	arg_9_0.mapSubBtn = nil

	local var_9_2 = arg_9_0.voteBtn

	var_1.Dispose(var_9_2)

	arg_9_0.voteBtn = nil

	local var_9_3 = arg_9_0.subActBtn

	var_1.Dispose(var_9_3)

	arg_9_0.subActBtn = nil

	return
end

return var_0_1
