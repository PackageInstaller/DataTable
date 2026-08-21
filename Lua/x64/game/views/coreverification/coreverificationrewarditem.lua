local var_0_0 = class("CoreVerificationRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		if arg_3_0.type_ < 5 then
			if CoreVerificationRewardCfg[arg_3_0.data_].reward_type ~= 4 and CoreVerificationData:GetCanReset() then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CORE_VERIFICATION_RESETTIPS3"),
					OkCallback = function()
						arg_3_0:GetReward()
					end
				})
			else
				arg_3_0:GetReward()
			end
		elseif arg_3_0.type_ == 5 then
			-- block empty
		elseif CoreVerificationChallengeTools.IsJumpAllStage(arg_3_0.activityId_) then
			arg_3_0:GetReward()
		elseif CoreVerificationChallengeData:IsGetTaskReward() then
			arg_3_0:GetReward()
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CORE_VERIFICATION_CL_LOCK_TIPS_1"),
				OkCallback = function()
					arg_3_0:GetReward()
				end
			})
		end
	end)
end

function var_0_0.GetReward(arg_7_0)
	if arg_7_0.type_ < 5 then
		CoreVerificationAction.GetReward({
			reward_list = {
				arg_7_0.data_
			}
		})
	else
		local var_7_0 = arg_7_0.activityId_

		CoreVerificationChallengeTools.GetReward(var_7_0, {
			arg_7_0.data_
		})
	end

	arg_7_0.controller_:SetSelectedState("complete")
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.rewardItems_ = {}
	arg_8_0.controller_ = arg_8_0.allBtnController_:GetController("all")
	arg_8_0.processCon_ = arg_8_0.processController_:GetController("Progressbar")
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.data_ = arg_9_1
	arg_9_0.type_ = arg_9_2
	arg_9_0.activityId_ = arg_9_3

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = false

	if arg_10_0.type_ < 5 then
		arg_10_0.processCon_:SetSelectedIndex(0)

		var_10_0 = CoreVerificationRewardCfg[arg_10_0.data_]

		local var_10_2, var_10_3, var_10_4, var_10_5 = CoreVerificationData:GetTaskProcess(arg_10_0.data_)

		arg_10_0.progressBar_.value = var_10_2 / var_10_3
		arg_10_0.progressText_.text = string.format("%s/%s", var_10_2, var_10_3)

		if var_10_5 then
			arg_10_0.controller_:SetSelectedState("complete")

			var_10_1 = true
		elseif var_10_4 then
			arg_10_0.controller_:SetSelectedState("receive")

			var_10_1 = false
		else
			arg_10_0.controller_:SetSelectedState("lock")

			var_10_1 = false
		end

		local var_10_6 = ConditionCfg[var_10_0.condition]

		arg_10_0.titleText_.text = string.format(GetI18NText(var_10_6.desc), var_10_6.params[1])
	elseif arg_10_0.type_ == 5 then
		arg_10_0.processCon_:SetSelectedIndex(1)

		var_10_0 = CoreVerificationClRewardCfg[arg_10_0.data_]

		local var_10_7 = CoreVerificationChallengeTools.GetTaskStateById(arg_10_0.data_, arg_10_0.activityId_)

		if var_10_7 == 2 then
			arg_10_0.controller_:SetSelectedState("complete")

			var_10_1 = true
		elseif var_10_7 == 1 then
			arg_10_0.controller_:SetSelectedState("receive")

			var_10_1 = false
		else
			arg_10_0.controller_:SetSelectedState("lock")

			var_10_1 = false
		end

		arg_10_0.titleText_.text = string.format(GetI18NText(var_10_0.reward_desc), var_10_0.reward_rank[1], var_10_0.reward_rank[2])
	else
		arg_10_0.processCon_:SetSelectedIndex(0)

		var_10_0 = CoreVerificationClRewardCfg[arg_10_0.data_]

		local var_10_8 = CoreVerificationChallengeTools.GetTaskStateById(arg_10_0.data_, arg_10_0.activityId_)

		if var_10_8 == 2 then
			arg_10_0.controller_:SetSelectedState("complete")

			var_10_1 = true
		elseif var_10_8 == 1 then
			arg_10_0.controller_:SetSelectedState("receive")

			var_10_1 = false
		else
			arg_10_0.controller_:SetSelectedState("lock")

			var_10_1 = false
		end

		local var_10_9 = ConditionCfg[var_10_0.condition]
		local var_10_10 = CoreVerificationChallengeTools.GetModeCfg(arg_10_0.activityId_)

		if var_10_9.type == 11304 then
			local var_10_11 = var_10_10[var_10_9.params[1]]

			arg_10_0.titleText_.text = string.format(GetI18NText(var_10_9.desc), GetI18NText(var_10_11.stage_name))

			local var_10_12 = var_10_8 > 0 and 1 or 0
			local var_10_13 = 1

			arg_10_0.progressBar_.value = var_10_12 / var_10_13
			arg_10_0.progressText_.text = string.format("%s/%s", var_10_12, var_10_13)
		elseif var_10_9.type == 11305 then
			local var_10_14 = var_10_10[var_10_9.params[1]]

			arg_10_0.titleText_.text = string.format(GetI18NText(var_10_9.desc), GetI18NText(var_10_14.stage_name), var_10_9.params[2])

			local var_10_15 = var_10_8 > 0 and 1 or 0
			local var_10_16 = 1

			arg_10_0.progressBar_.value = var_10_15 / var_10_16
			arg_10_0.progressText_.text = string.format("%s/%s", var_10_15, var_10_16)
		elseif var_10_9.type == 11306 then
			local var_10_17 = var_10_10[var_10_9.params[2]]

			arg_10_0.titleText_.text = string.format(GetI18NText(var_10_9.desc), GetI18NText(var_10_17.stage_name))

			local var_10_18 = var_10_8 > 0 and 1 or 0
			local var_10_19 = 1

			arg_10_0.progressBar_.value = var_10_18 / var_10_19
			arg_10_0.progressText_.text = string.format("%s/%s", var_10_18, var_10_19)
		elseif var_10_9.type == 11307 then
			local var_10_20 = var_10_10[var_10_9.params[1]]

			arg_10_0.titleText_.text = string.format(GetI18NText(var_10_9.desc), GetI18NText(var_10_20.stage_name), var_10_9.params[2])

			local var_10_21 = CoreVerificationChallengeTools.GetDataCls(arg_10_0.activityId_)
			local var_10_22
			local var_10_23 = var_10_9.params[2]

			if nullable(var_10_21, "GetCurPoint") then
				var_10_22 = var_10_21:GetCurPoint()
			else
				var_10_22 = 0
			end

			if var_10_23 < var_10_22 or var_10_8 == 2 or var_10_8 == 1 then
				var_10_22 = var_10_23
			end

			arg_10_0.progressBar_.value = var_10_22 / var_10_23
			arg_10_0.progressText_.text = string.format("%s/%s", var_10_22, var_10_23)
		end
	end

	if arg_10_0.type_ == 5 then
		SetActive(arg_10_0.allBtnController_.gameObject, false)
	end

	local var_10_24 = var_10_0.reward or {}

	for iter_10_0, iter_10_1 in ipairs(var_10_24) do
		local var_10_25 = formatReward(iter_10_1)
		local var_10_26 = clone(ItemTemplateData)

		if arg_10_0.rewardItems_[iter_10_0] == nil then
			arg_10_0.rewardItems_[iter_10_0] = CommonItemView.New(arg_10_0[string.format("awardItem%dObj_", iter_10_0)])
			arg_10_0.rewardItems_[iter_10_0].ResetTransform = function()
				return
			end
		end

		var_10_26.id = var_10_25.id
		var_10_26.number = var_10_25.num
		var_10_26.timeValid = iter_10_1.timeValid or 0
		var_10_26.grayFlag = var_10_1
		var_10_26.clickFun = handler(arg_10_0, arg_10_0.OnClickCommonItem)

		arg_10_0.rewardItems_[iter_10_0]:SetData(var_10_26)
	end

	for iter_10_2 = #var_10_0.reward + 1, #arg_10_0.rewardItems_ do
		arg_10_0.rewardItems_[iter_10_2]:SetData(nil)
	end

	SetActive(arg_10_0.progressText_.gameObject, arg_10_0.type_ ~= 5)
	SetActive(arg_10_0.allBtnController_.gameObject, arg_10_0.type_ ~= 5)
end

function var_0_0.OnClickCommonItem(arg_12_0, arg_12_1)
	ShowPopItem(POP_ITEM, {
		arg_12_1.id,
		arg_12_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:UpdateView()
end

function var_0_0.Dispose(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.rewardItems_) do
		iter_14_1:Dispose()
	end

	arg_14_0.rewardItems_ = {}

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
