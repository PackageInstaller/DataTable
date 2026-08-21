local var_0_0 = class("SurviveSoloRewardItem", ReduxView)

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

	arg_3_0.btn_ = {}
	arg_3_0.title_ = {}
	arg_3_0.rewards_ = {}
	arg_3_0.stateCon_ = {}
	arg_3_0.rewardPanel_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.btn_[iter_3_0] = arg_3_0["btn_" .. iter_3_0]
		arg_3_0.title_[iter_3_0] = arg_3_0["title_" .. iter_3_0]
		arg_3_0.rewards_[iter_3_0] = {}
		arg_3_0.stateCon_[iter_3_0] = ControllerUtil.GetController(arg_3_0["item_" .. iter_3_0].transform, "state")
		arg_3_0.rewardPanel_[iter_3_0] = arg_3_0["rewardPanel_" .. iter_3_0]
	end
end

function var_0_0.AddUIListeners(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.btn_) do
		arg_4_0:AddBtnListener(arg_4_0.btn_[iter_4_0], nil, function()
			SurviveSoloAction:GetReward(arg_4_0.activityID_, arg_4_0.cfg_.reward_item_list[iter_4_0][1])
		end)
	end
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.Refresh(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.activityID_ = arg_7_1
	arg_7_0.mainActivityID_ = arg_7_2
	arg_7_0.cfg_ = ActivitySoloSlayerCfg[arg_7_0.activityID_]

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.level_.text = GetI18NText(BattleSoloSlayerCfg[arg_8_0.cfg_.stage_id].name)

	local var_8_0 = SurviveSoloData:GetData(arg_8_0.activityID_)

	for iter_8_0 = 1, 3 do
		local var_8_1 = arg_8_0.cfg_.reward_item_list[iter_8_0]

		arg_8_0.title_[iter_8_0].text = string.format(GetTips("ACTIVITY_SOLO_SLAYER_REWARD"), var_8_1[1])

		for iter_8_1, iter_8_2 in ipairs(var_8_1[2]) do
			if not arg_8_0.rewards_[iter_8_0][iter_8_1] then
				local var_8_2 = Object.Instantiate(arg_8_0.rewardItem_, arg_8_0.rewardPanel_[iter_8_0])

				arg_8_0.rewards_[iter_8_0][iter_8_1] = SurviveSoloTools.GetRewardItemSkin(arg_8_0.mainActivityID_).New(var_8_2, arg_8_0.rewardPanel_[iter_8_0])
			end

			arg_8_0.rewards_[iter_8_0][iter_8_1]:SetData(iter_8_2, POP_ITEM)
		end

		for iter_8_3 = #var_8_1[2] + 1, #arg_8_0.rewards_[iter_8_0] do
			arg_8_0.rewards_[iter_8_0][iter_8_3]:Show(false)
		end

		if var_8_0 and var_8_0.time >= var_8_1[1] then
			if table.indexof(var_8_0.rewards, var_8_1[1]) then
				arg_8_0.stateCon_[iter_8_0]:SetSelectedState("received")
			else
				arg_8_0.stateCon_[iter_8_0]:SetSelectedState("complete")
			end
		else
			arg_8_0.stateCon_[iter_8_0]:SetSelectedState("incomplete")
		end
	end
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	for iter_10_0 = 1, 3 do
		for iter_10_1, iter_10_2 in ipairs(arg_10_0.rewards_[iter_10_0]) do
			iter_10_2:Dispose()

			iter_10_2 = nil
		end

		arg_10_0.rewards_[iter_10_0] = nil
	end

	arg_10_0.rewards_ = {}

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
