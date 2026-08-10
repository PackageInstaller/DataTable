local var_0_0 = class("XH3rsWaterReviewItemView", ReduxView)

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

	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select")
	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.roleStatusController1_ = ControllerUtil.GetController(arg_3_0.head1Go_.transform, "status")
	arg_3_0.roleStatusController2_ = ControllerUtil.GetController(arg_3_0.head2Go_.transform, "status")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickListener_ ~= nil then
			arg_4_0.clickListener_(arg_4_0.index_, arg_4_0.data_)
		end
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "yes" or "no")
end

function var_0_0.RegisterClickListener(arg_8_0, arg_8_1)
	arg_8_0.clickListener_ = arg_8_1
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.index_ = arg_9_1
	arg_9_0.data_ = arg_9_2
	arg_9_0.activityId_ = arg_9_3

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0 = ActivityWaterCfg[arg_10_0.data_.schedule_id]

	arg_10_0.nameText_.text = var_10_0.schedule_name

	local var_10_1 = arg_10_0.data_.competition_list[1].competition_id
	local var_10_2 = ActivityWaterCompetitionCfg[var_10_1]
	local var_10_3 = HeroStandardSystemCfg[var_10_2.hero_id].hero_id
	local var_10_4 = arg_10_0.data_.competition_list[2].competition_id
	local var_10_5 = ActivityWaterCompetitionCfg[var_10_4]
	local var_10_6 = HeroStandardSystemCfg[var_10_5.hero_id].hero_id

	arg_10_0.head1_.sprite = HeroTools.GetHeadSprite(var_10_3)
	arg_10_0.head2_.sprite = HeroTools.GetHeadSprite(var_10_6)

	local var_10_7
	local var_10_8
	local var_10_9

	if arg_10_0.data_.competition_list[1].assistance_process > arg_10_0.data_.competition_list[2].assistance_process then
		var_10_7 = "win"
		var_10_9 = "lose"
	elseif arg_10_0.data_.competition_list[1].assistance_process == arg_10_0.data_.competition_list[2].assistance_process then
		var_10_7 = "draw"
		var_10_9 = "draw"
	else
		var_10_7 = "lose"
		var_10_9 = "win"
	end

	if arg_10_0.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(arg_10_0.activityId_).schedule_id then
		var_10_7 = "current"
		var_10_9 = "current"

		arg_10_0.statusController_:SetSelectedState("progress")
	else
		arg_10_0.statusController_:SetSelectedState("over")
	end

	arg_10_0.roleStatusController1_:SetSelectedState(var_10_7)
	arg_10_0.roleStatusController2_:SetSelectedState(var_10_9)

	if arg_10_0.data_.is_success and arg_10_0.data_.is_success > 0 and not ActivityWaterData:HaveGotHistoryReward(arg_10_0.data_.schedule_id) then
		SetActive(arg_10_0.noticeGo_, true)
	else
		SetActive(arg_10_0.noticeGo_, false)
	end
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.data_ = nil
	arg_14_0.clickListener_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
