local var_0_0 = class("ActivityReforgeWaveItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = arg_3_0.controllerEx_:GetController("status")
	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("isselect")
	arg_3_0.heroHeadItemList_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.heroHeadItemList_[iter_3_0] = ActivityReforgeHeroHeadItem.New(arg_3_0["heroHeadGo" .. iter_3_0 .. "_"])
	end
end

function var_0_0.SetClickHandle(arg_4_0, arg_4_1)
	arg_4_0.clickHandle_ = arg_4_1
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.index_ = arg_5_1
	arg_5_0.waveID_ = arg_5_2

	if arg_5_0.index_ == arg_5_3 then
		arg_5_0.selectController_:SetSelectedState("true")
	else
		arg_5_0.selectController_:SetSelectedState("false")
	end

	arg_5_0.waveNum_.text = arg_5_0.index_
	arg_5_0.teamInfo_ = ActivityReforgeData:GetWaveTeamInfo(arg_5_0.waveID_)

	if arg_5_0.teamInfo_ == nil then
		arg_5_0.statusController_:SetSelectedState("normal")
	else
		arg_5_0.statusController_:SetSelectedState("hero")

		local var_5_0 = ActivityReforgeTeamCfg[arg_5_0.teamInfo_.teamID]

		for iter_5_0 = 1, 3 do
			arg_5_0.heroHeadItemList_[iter_5_0]:SetData(var_5_0.team_info[arg_5_0.teamInfo_.level][iter_5_0])
		end
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		if arg_6_0.clickHandle_ then
			arg_6_0.clickHandle_(arg_6_0.index_)
		end
	end)
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0 = 1, 3 do
		arg_8_0.heroHeadItemList_[iter_8_0]:Dispose()

		arg_8_0.heroHeadItemList_[iter_8_0] = nil
	end

	arg_8_0.heroHeadItemList_ = nil
	arg_8_0.clickHandle_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
