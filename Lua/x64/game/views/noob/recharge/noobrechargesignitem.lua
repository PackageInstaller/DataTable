local var_0_0 = class("ActivityNoobUpgradeView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "status")
	arg_1_0.rewardList_ = {}

	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transform_ = nil

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.rewardList_) do
		iter_3_1:Dispose()
	end

	arg_3_0.rewardList_ = nil
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index_ = arg_4_1
	arg_4_0.textDay_.text = string.format(GetTips("ACTIVITY_GREENHORN_TASK_STAGE"), arg_4_1)
	arg_4_0.textDat2_.text = "0" .. arg_4_1
	arg_4_0.rewardCfg_ = {
		arg_4_2[2],
		arg_4_2[3]
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.rewardCfg_) do
		if not arg_4_0.rewardList_[iter_4_0] then
			local var_4_0 = clone(ItemTemplateData)

			var_4_0.id = iter_4_1[1]
			var_4_0.number = iter_4_1[2]

			function var_4_0.clickFun(arg_5_0)
				ShowPopItem(POP_ITEM, {
					arg_5_0.id,
					arg_5_0.number
				})
			end

			arg_4_0.rewardList_[iter_4_0] = CommonItemPool.New(arg_4_0.rewardPanel_, var_4_0, true)
		end
	end

	arg_4_0:RefreshStatus()
end

function var_0_0.RefreshStatus(arg_6_0)
	local var_6_0 = ActivityNewbieTools.GetFirstRechargeStatus()
	local var_6_1 = var_6_0.signTimes
	local var_6_2 = var_6_0.lastSignTimestamp

	if not var_6_0.secondGearStatus then
		arg_6_0.controller_:SetSelectedState("normal")
	elseif var_6_1 >= arg_6_0.index_ then
		arg_6_0.controller_:SetSelectedState("received")
	elseif arg_6_0.index_ == var_6_1 + 1 and var_6_2 < manager.time:GetTodayFreshTime() then
		arg_6_0.controller_:SetSelectedState("complete")
	else
		arg_6_0.controller_:SetSelectedState("normal")
	end
end

return var_0_0
