local var_0_0 = class("AchievementInfoItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.rewardItems_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.rewardItems_[iter_1_0] = CommonItemView.New(arg_1_0[string.format("awardItem%dObj_", iter_1_0)])
	end

	arg_1_0:AddListeners()

	arg_1_0.controller_ = arg_1_0.allBtnController_:GetController("all")
	arg_1_0.typeController_ = ControllerUtil.GetController(arg_1_0.transform_, "category")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.receiveBtn_, nil, function()
		local var_3_0 = arg_2_0.achievementID_
		local var_3_1 = AchievementCfg[var_3_0]

		AchievementAction.GetReceiveReward(var_3_0)
	end)
	arg_2_0:AddBtnListener(arg_2_0.goBtn_, nil, function()
		local var_4_0 = arg_2_0.achievementID_
		local var_4_1 = AchievementCfg[var_4_0]

		if var_4_1.source[1] == nil then
			print("成就的跳转是空的", var_4_0)

			return
		end

		AchievementData:SetScrollRecord(true)
		JumpTools.JumpToPage2(var_4_1.source)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = AchievementCfg[arg_5_1]

	if arg_5_1 ~= arg_5_0.achievementID_ then
		arg_5_0.nameText_.text = GetI18NText(var_5_0.name)
		arg_5_0.titleText_.text = GetI18NText(var_5_0.desc)
	end

	local var_5_1 = AchievementData:GetAchievementData(arg_5_1)

	if var_5_1.rewardState == 0 then
		arg_5_0.controller_:SetSelectedState("go")

		arg_5_0.progressText_.text = string.format("%s/%s", var_5_1.process, var_5_0.need)
		arg_5_0.progressBar_.value = var_5_1.process / var_5_0.need

		local var_5_2 = var_5_0.reward

		for iter_5_0, iter_5_1 in pairs(var_5_2) do
			local var_5_3 = clone(ItemTemplateData)

			var_5_3.id = iter_5_1[1]
			var_5_3.number = iter_5_1[2]

			function var_5_3.clickFun(arg_6_0)
				ShowPopItem(POP_SOURCE_ITEM, {
					arg_6_0.id,
					arg_6_0.number
				})
			end

			arg_5_0.rewardItems_[iter_5_0]:SetData(var_5_3)
		end

		for iter_5_2 = #var_5_2 + 1, 3 do
			arg_5_0.rewardItems_[iter_5_2]:SetData(nil)
		end
	elseif var_5_1.rewardState == 1 then
		arg_5_0.controller_:SetSelectedState("receive")

		arg_5_0.progressText_.text = string.format("%s/%s", var_5_0.need, var_5_0.need)
		arg_5_0.progressBar_.value = 1

		local var_5_4 = var_5_0.reward

		for iter_5_3, iter_5_4 in pairs(var_5_4) do
			local var_5_5 = clone(ItemTemplateData)

			var_5_5.id = iter_5_4[1]
			var_5_5.number = iter_5_4[2]

			function var_5_5.clickFun(arg_7_0)
				ShowPopItem(POP_SOURCE_ITEM, {
					arg_7_0.id,
					arg_7_0.number
				})
			end

			arg_5_0.rewardItems_[iter_5_3]:SetData(var_5_5)
		end

		for iter_5_5 = #var_5_4 + 1, 3 do
			arg_5_0.rewardItems_[iter_5_5]:SetData(nil)
		end
	else
		arg_5_0.controller_:SetSelectedState("complete")

		arg_5_0.progressText_.text = string.format("%s/%s", var_5_0.need, var_5_0.need)
		arg_5_0.progressBar_.value = 1

		local var_5_6 = var_5_0.reward

		for iter_5_6, iter_5_7 in pairs(var_5_6) do
			local var_5_7 = clone(ItemTemplateData)

			var_5_7.id = iter_5_7[1]
			var_5_7.number = iter_5_7[2]
			var_5_7.grayFlag = true

			function var_5_7.clickFun(arg_8_0)
				ShowPopItem(POP_SOURCE_ITEM, {
					arg_8_0.id,
					arg_8_0.number
				})
			end

			arg_5_0.rewardItems_[iter_5_6]:SetData(var_5_7)
		end

		for iter_5_8 = #var_5_6 + 1, 3 do
			arg_5_0.rewardItems_[iter_5_8]:SetData(nil)
		end

		arg_5_0.textFinishTime_.text = manager.time:DescCTime(var_5_1.timestamp, "%Y/%m/%d")
	end

	arg_5_0.typeController_:SetSelectedState(var_5_0.type_id)

	arg_5_0.achievementID_ = arg_5_1
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.rewardItems_) do
		if iter_9_1 then
			iter_9_1:Dispose()
		end
	end

	arg_9_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
