local var_0_0 = class("MainActivityBtnView4Mellow", import("...theme_classic.view.MainActivityBtnView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.mapEventTr = arg_1_1:Find("right/1/act/act_battle")
	arg_1_0.mapBtn = MainActivityBtnMellowAdapt.New(MainActMapBtn.New(arg_1_0.mapEventTr, arg_1_0.event, true, true))
	arg_1_0.mapSubEventTr = arg_1_1:Find("right/1/act/act_sub_battle")
	arg_1_0.mapSubBtn = MainActivityBtnMellowAdapt.New(MainActSubMapBtn.New(arg_1_0.mapSubEventTr, arg_1_0.event, true, true))
	arg_1_0.voteEventTr = arg_1_1:Find("right/1/act/act_vote")
	arg_1_0.voteBtn = MainActivityBtnMellowAdapt.New(NewMainVoteEntranceBtn.New(arg_1_0.voteEventTr, arg_1_0.event))
	arg_1_0.subActEventTr = arg_1_1:Find("right/1/act/act_sub")
	arg_1_0.subActBtn = MainActivityBtnMellowAdapt.New(MainSubActBtn.New(arg_1_0.subActEventTr, arg_1_0.event, true, true))

	return
end

function var_0_0.InitBtns(arg_2_0)
	arg_2_0.actBtnTpl = arg_2_0._tf:Find("right/activity/tpl")

	var_0_0.super.InitBtns(arg_2_0)

	arg_2_0.activityBtns = _.map(_.select(arg_2_0.activityBtns, function(arg_3_0)
		return not isa(arg_3_0, MainActMapBtn)
	end), function(arg_4_0)
		return MainActivityBtnMellowAdapt.New(arg_4_0)
	end)
	arg_2_0.specailBtns = _.map(arg_2_0.specailBtns, function(arg_5_0)
		assert(_G[arg_5_0.__cname .. "MellowAdapt"])

		return _G[arg_5_0.__cname .. "MellowAdapt"].New(arg_5_0)
	end)

	return
end

function var_0_0.GetBtn(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.activityBtns) do
		if isa(iter_6_1.activityBtn, arg_6_1) then
			return iter_6_1
		end
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.specailBtns) do
		if isa(iter_6_3.spActBtn, arg_6_1) then
			return iter_6_3
		end
	end

	return nil
end

function var_0_0.Flush(arg_7_0)
	local var_7_0, var_7_1 = arg_7_0:FilterActivityBtns()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		iter_7_1:Init(iter_7_0)
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_1) do
		iter_7_3:Clear()
	end

	local var_7_2, var_7_3 = arg_7_0:FilterSpActivityBtns()

	for iter_7_4, iter_7_5 in ipairs(var_7_2) do
		iter_7_5:Init()
	end

	for iter_7_6, iter_7_7 in ipairs(var_7_3) do
		iter_7_7:Clear()
	end

	if arg_7_0.mapBtn:InShowTime() then
		arg_7_0.mapBtn:Init()
	else
		arg_7_0.mapBtn:Clear()
	end

	if arg_7_0.mapSubBtn:InShowTime() then
		arg_7_0.mapSubBtn:Init()
	else
		arg_7_0.mapSubBtn:Clear()
	end

	if arg_7_0.voteBtn:InShowTime() then
		arg_7_0.voteBtn:Init()
	else
		arg_7_0.voteBtn:Hide()
	end

	if arg_7_0.subActBtn:InShowTime() then
		arg_7_0.subActBtn:Init()
	else
		arg_7_0.subActBtn:Clear()
	end

	return
end

function var_0_0.GetDirection(arg_8_0)
	return Vector2.zero
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	arg_9_0.mapBtn:Dispose()

	arg_9_0.mapBtn = nil

	arg_9_0.mapSubBtn:Dispose()

	arg_9_0.mapSubBtn = nil

	arg_9_0.voteBtn:Dispose()

	arg_9_0.voteBtn = nil

	arg_9_0.subActBtn:Dispose()

	arg_9_0.subActBtn = nil

	return
end

return var_0_0
