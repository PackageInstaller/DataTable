local var_0_0 = class("SPHeroChallengeEntrustStartItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.showIndex = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = arg_3_0.controller:GetController("state")
	arg_3_0.rankController = arg_3_0.controller:GetController("rank")
	arg_3_0.commonItemView = CommonItemView.New(arg_3_0.commonItem)

	arg_3_0:AddUIListener()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.rankController:SetSelectedState(1)

	if arg_4_1 then
		arg_4_0.showIndex = arg_4_1.showIndex

		if arg_4_1.state == "lock" then
			arg_4_0.stateController:SetSelectedState("lock")

			local var_4_0, var_4_1 = SPHeroChallengeTools:GetEntrustLockDesc(arg_4_0.showIndex)

			arg_4_0.lockDesc.text = var_4_1
		elseif arg_4_1.state == "empty" then
			arg_4_0.stateController:SetSelectedState("empty")
		elseif arg_4_1.state == "start" then
			arg_4_0.stateController:SetSelectedState("start")
			arg_4_0:RefreshBaseInfo()
			arg_4_0:RefreshStartInfo()
		elseif arg_4_1.state == "end" then
			arg_4_0.stateController:SetSelectedState("end")
			arg_4_0:RefreshBaseInfo()
			arg_4_0:RefreshEndInfo()
		end
	end
end

function var_0_0.RefreshBaseInfo(arg_5_0)
	local var_5_0 = SPHeroChallengeData:GetCurActivityInfo()

	if var_5_0 then
		arg_5_0.info = var_5_0:GetShowIndexEntrustInfo(arg_5_0.showIndex)

		local var_5_1 = ActivityHeroChallengeTaskCfg[arg_5_0.info.entrustID]

		arg_5_0.nameText.text = var_5_1.name

		arg_5_0.rankController:SetSelectedState(tostring(var_5_1.task_level))

		local var_5_2 = {
			id = var_5_1.reward_list[1][1],
			number = var_5_1.reward_list[1][2],
			clickFun = function(arg_6_0)
				ShowPopItem(POP_ITEM, {
					arg_6_0.id,
					arg_6_0.number
				})
			end
		}

		arg_5_0.commonItemView:SetData(var_5_2)
	end
end

function var_0_0.RefreshStartInfo(arg_7_0)
	arg_7_0.curIcon.sprite = ItemTools.getItemSprite(SpHeroChallengeConst.accelerateID)

	arg_7_0:RefreshTime()
end

function var_0_0.RefreshTime(arg_8_0)
	local var_8_0 = arg_8_0.stateController:GetSelectedState()
	local var_8_1 = SPHeroChallengeData:GetCurActivityInfo()

	if var_8_0 == "start" then
		local var_8_2, var_8_3 = var_8_1:GetEntrustEndTime(arg_8_0.info.index)

		if var_8_2 == nil then
			return
		end

		if var_8_3 then
			if not var_8_2 then
				arg_8_0.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:DescCdTime3(var_8_3)
				arg_8_0.accDesc.text = SPHeroChallengeTools:GetAcceleratorNumByIndex(arg_8_0.info.index)
			elseif not arg_8_0.info.refreshFlag then
				SPHeroChallengeAction:RefreshEntrust()

				arg_8_0.info.refreshFlag = true
			end
		end
	end
end

function var_0_0.RefreshEndInfo(arg_9_0)
	return
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.endbtnBtn_, nil, function()
		local var_11_0 = SPHeroChallengeData:GetAccelerateNum()
		local var_11_1 = SPHeroChallengeTools:GetAcceleratorNumByIndex(arg_10_0.info.index)

		if var_11_0 < var_11_1 then
			ShowTips(GetTips("ACTIVITY_HERO_CHALLENGE_ACCELERATOR_LACK"))

			return
		end

		SPHeroChallengeAction:UseEntrustAccelerator(var_11_1, arg_10_0.info.index)
	end)
	arg_10_0:AddBtnListener(arg_10_0.emptyBtn_, nil, function()
		if arg_10_0.clickEmptyFunc then
			arg_10_0.clickEmptyFunc(arg_10_0.showIndex)
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.reciveBtn, nil, function()
		local var_13_0 = SPHeroChallengeData:GetCurActivityInfo()

		if var_13_0 then
			local var_13_1 = var_13_0:GetCanGetRewardEntrustIndexList()

			if #var_13_1 > 0 then
				SPHeroChallengeAction:GetEntrustAward(var_13_1)
			else
				ShowTips("ACTIVITY_HERO_CHALLENGE_NONE_ENTRUST_FINISH")
			end
		end
	end)
end

function var_0_0.ClickEmptyFunc(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0.clickEmptyFunc = arg_14_1
	end
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.commonItemView then
		arg_15_0.commonItemView:Dispose()
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
