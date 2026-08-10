local var_0_0 = class("ActivityPushBoxEventItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.levelCon_ = ControllerUtil.GetController(arg_3_0.transform_, "level")
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.selectCon_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
			saveData("activity_push_box", tostring(arg_4_0.id_), 1)
			arg_4_0.stateCon_:SetSelectedState("off")
		end

		if arg_4_0.clickFunc_ then
			arg_4_0.clickFunc_(arg_4_0.id_, arg_4_0.isClose_)
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.isClose_ = false
	arg_7_0.id_ = arg_7_1
	arg_7_0.cfg_ = ActivityCelebrationOrderCfg[arg_7_1]

	if arg_7_0.cfg_.type == PushBoxConst.EVENT_TYPE.BATTLE then
		arg_7_0:RefreshBattle()
	elseif arg_7_0.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
		arg_7_0:RefreshBox()
	end
end

function var_0_0.RefreshBattle(arg_8_0)
	arg_8_0.typeCon_:SetSelectedState("challenge")
	arg_8_0.levelCon_:SetSelectedState(arg_8_0.cfg_.hard)
end

function var_0_0.RefreshBox(arg_9_0)
	arg_9_0.typeCon_:SetSelectedState("box")

	local var_9_0 = getData("activity_push_box", tostring(arg_9_0.id_)) or 0

	arg_9_0.stateCon_:SetSelectedState(var_9_0 == 0 and "on" or "off")
end

function var_0_0.RefreshCountDown(arg_10_0, arg_10_1)
	arg_10_0.isClose_ = true
	arg_10_0.id_ = arg_10_1
	arg_10_0.cfg_ = ActivityCelebrationOrderCfg[arg_10_1]

	if ActivityPushBoxData:GetNextID(arg_10_0.cfg_.main_activity, arg_10_0.id_) == 0 then
		arg_10_0.typeCon_:SetSelectedState("finial")

		return
	end

	arg_10_0.typeCon_:SetSelectedState("rest")

	arg_10_0.cfg_ = ActivityCelebrationOrderCfg[arg_10_1]

	local var_10_0 = manager.time:GetServerTime()
	local var_10_1 = manager.time:GetNextFreshTime()

	arg_10_0.countDownTxt_.text = manager.time:DescCDTime(var_10_1 - var_10_0)
	arg_10_0.timer_ = Timer.New(function()
		var_10_0 = manager.time:GetServerTime()
		arg_10_0.countDownTxt_.text = manager.time:DescCDTime(var_10_1 - var_10_0)
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.RegistClickFunc(arg_12_0, arg_12_1)
	arg_12_0.clickFunc_ = arg_12_1
end

function var_0_0.SetSelect(arg_13_0, arg_13_1)
	if arg_13_1 ~= arg_13_0.id_ then
		arg_13_0.selectCon_:SetSelectedState("no")
	elseif arg_13_0.cfg_.type == PushBoxConst.EVENT_TYPE.BATTLE then
		arg_13_0.selectCon_:SetSelectedState("challenge")
	elseif arg_13_0.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
		arg_13_0.selectCon_:SetSelectedState("box")
	end
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_0.Show(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
	arg_15_0:StopTimer()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:StopTimer()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()

	arg_17_0.clickFunc_ = nil

	arg_17_0.super.Dispose(arg_17_0)
end

return var_0_0
