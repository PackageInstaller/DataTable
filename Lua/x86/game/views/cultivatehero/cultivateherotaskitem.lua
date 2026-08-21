local var_0_0 = class("CultivateHeroTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.rewardState_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		CultivateHeroAction.RequireReceiveHeroTaskList(arg_4_0.activityID_, {
			arg_4_0.taskID_
		}, function()
			arg_4_0.onReceived_()
		end)
	end)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.onReceived_ = nil

	arg_7_0.commonItem_:Dispose()

	arg_7_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.activityID_ = arg_8_1
	arg_8_0.taskID_ = arg_8_2

	arg_8_0:RefreshUI()
end

function var_0_0.SetAni(arg_9_0, arg_9_1)
	if arg_9_0.animator_ then
		arg_9_0.animator_:Play(arg_9_1, 0, 0)
		arg_9_0.animator_:Update(0)
	end
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshDesc()
	arg_10_0:RefreshState()
	arg_10_0:RefreshItem()
end

function var_0_0.RefreshDesc(arg_11_0)
	local var_11_0 = CultivateHeroTaskCfg[arg_11_0.taskID_]

	arg_11_0.descText_.text = GetI18NText(var_11_0.desc)

	local var_11_1 = var_11_0.condition
	local var_11_2 = 0

	if HeroTools.GetHeroIsUnlock(var_11_0.hero) then
		if CultivateHeroData:IsHeroTaskReceived(arg_11_0.activityID_, arg_11_0.taskID_) then
			var_11_2 = var_11_1
		else
			local var_11_3 = CultivateHeroData:GetHeroTaskInfoList(arg_11_0.activityID_)[arg_11_0.taskID_]

			if var_11_3 and var_11_3.progress then
				var_11_2 = var_11_1 > var_11_3.progress and var_11_3.progress or var_11_1
			end
		end
	end

	arg_11_0.progressText_.text = string.format("%d/%d", var_11_2, var_11_1)

	local var_11_4 = var_11_2 / var_11_1

	arg_11_0.progressSlider_.value = var_11_4
end

function var_0_0.RefreshItem(arg_12_0)
	arg_12_0.rewardCfg_ = CultivateHeroTaskCfg[arg_12_0.taskID_].reward[1]

	if arg_12_0.commonItem_ == nil then
		arg_12_0.commonItem_ = CommonItemView.New(arg_12_0.rewardItemGo_, true)
		arg_12_0.itemData_ = clone(ItemTemplateData)

		function arg_12_0.itemData_.clickFun(arg_13_0)
			ShowPopItem(POP_ITEM, arg_13_0)
		end
	end

	arg_12_0.itemData_.id = arg_12_0.rewardCfg_[1]
	arg_12_0.itemData_.number = arg_12_0.rewardCfg_[2]

	if arg_12_0.itemGray_ then
		arg_12_0.itemData_.grayFlag = true
	else
		arg_12_0.itemData_.grayFlag = false
	end

	arg_12_0.commonItem_:SetData(arg_12_0.itemData_)
end

function var_0_0.RefreshState(arg_14_0)
	local var_14_0 = CultivateHeroData:GetHeroTaskInfoList(arg_14_0.activityID_)
	local var_14_1 = CultivateHeroData:IsHeroTaskCompleted(arg_14_0.activityID_, arg_14_0.taskID_)
	local var_14_2 = CultivateHeroData:IsHeroTaskReceived(arg_14_0.activityID_, arg_14_0.taskID_)

	if not var_14_1 then
		arg_14_0.itemGray_ = false

		arg_14_0.rewardState_:SetSelectedState("uncomplete")
	elseif not var_14_2 then
		arg_14_0.itemGray_ = false

		arg_14_0.rewardState_:SetSelectedState("unreceive")
	else
		arg_14_0.itemGray_ = true

		arg_14_0.rewardState_:SetSelectedState("received")
	end
end

function var_0_0.SetReveivedHandler(arg_15_0, arg_15_1)
	arg_15_0.onReceived_ = arg_15_1
end

return var_0_0
