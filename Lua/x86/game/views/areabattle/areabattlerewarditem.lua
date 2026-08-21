local var_0_0 = class("AreaBattleRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = arg_3_0.controller_:GetController("status")

	arg_3_0:AddUIListener()

	arg_3_0.commonItem1 = CommonItemView.New(arg_3_0.rewardItem1_)
	arg_3_0.commonItem2 = CommonItemView.New(arg_3_0.rewardItem2_)
	arg_3_0.commonItem3 = CommonItemView.New(arg_3_0.rewardItem3_)
	arg_3_0.commonData1 = clone(ItemTemplateData)
	arg_3_0.commonData2 = clone(ItemTemplateData)
	arg_3_0.commonData3 = clone(ItemTemplateData)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		AreaBattleAction.GetReward(arg_4_0.activityID, {
			arg_4_0.cfg[1]
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.index = arg_6_1
	arg_6_0.cfg = arg_6_2
	arg_6_0.data = arg_6_3
	arg_6_0.activityID = arg_6_4

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.descText_.text = string.format(GetTips("ACTIVITY_AREA_BATTLE_REWARD_DESC"), arg_7_0.cfg[1])

	arg_7_0.controller_:SetSelectedState("state2")

	for iter_7_0 = 1, 3 do
		SetActive(arg_7_0["rewardItem" .. iter_7_0 .. "_"], arg_7_0.cfg[2][iter_7_0] ~= nil)

		if arg_7_0.cfg[2][iter_7_0] then
			local var_7_0 = arg_7_0["commonData" .. iter_7_0]

			var_7_0.id = arg_7_0.cfg[2][iter_7_0][1]
			var_7_0.number = arg_7_0.cfg[2][iter_7_0][2]

			function var_7_0.clickFun(arg_8_0)
				ShowPopItem(POP_ITEM, {
					arg_8_0.id,
					arg_8_0.number
				})
			end

			arg_7_0["commonItem" .. iter_7_0]:SetData(var_7_0)
		end
	end

	if arg_7_0.data.allChallengeValue >= arg_7_0.cfg[1] then
		arg_7_0.controller_:SetSelectedState("state1")

		if arg_7_0.data.gotChallengeRewardList[arg_7_0.cfg[1]] then
			arg_7_0.controller_:SetSelectedState("state3")
		end
	end
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateView()
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.commonItem1 then
		arg_10_0.commonItem1:Dispose()

		arg_10_0.commonItem1 = nil
	end

	if arg_10_0.commonItem2 then
		arg_10_0.commonItem2:Dispose()

		arg_10_0.commonItem2 = nil
	end

	if arg_10_0.commonItem3 then
		arg_10_0.commonItem3:Dispose()

		arg_10_0.commonItem3 = nil
	end

	var_0_0.super.Dispose(arg_10_0)
	Object.Destroy(arg_10_0.gameObject_)
end

return var_0_0
