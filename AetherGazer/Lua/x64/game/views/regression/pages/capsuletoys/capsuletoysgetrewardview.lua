local var_0_0 = class("CapsuleToysGetRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ReturnTwo/RT2stBonusWindowsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardItemList_ = {}
	arg_4_0.itemDataList_ = {}
	arg_4_0.typeController_ = ControllerUtil.GetController(arg_4_0.transform_, "type")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = arg_8_0.params_.list

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not arg_8_0.itemDataList_[iter_8_0] then
			arg_8_0.itemDataList_[iter_8_0] = clone(ItemTemplateData)
			arg_8_0.itemDataList_[iter_8_0].clickFun = function(arg_9_0)
				ShowPopItem(POP_ITEM, {
					arg_9_0.id,
					arg_9_0.number
				})
			end
		end

		arg_8_0.itemDataList_[iter_8_0].id = iter_8_1[1]
		arg_8_0.itemDataList_[iter_8_0].number = iter_8_1[2]

		if arg_8_0.rewardItemList_[iter_8_0] then
			arg_8_0.rewardItemList_[iter_8_0]:SetData(arg_8_0.itemDataList_[iter_8_0], false)
		else
			arg_8_0.rewardItemList_[iter_8_0] = arg_8_0:GetRewardItem(arg_8_0.itemDataList_[iter_8_0])
		end
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.rewardItemList_ do
		arg_8_0.rewardItemList_[iter_8_2]:Show(false)
	end

	if #var_8_0 > 5 then
		arg_8_0.typeController_:SetSelectedIndex(1)
	else
		arg_8_0.typeController_:SetSelectedIndex(0)
	end
end

function var_0_0.GetRewardItem(arg_10_0, arg_10_1)
	return CommonItemPool.New(arg_10_0.goRewardPanel_, arg_10_1, false)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)

	if arg_11_0.rewardItemList_ then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.rewardItemList_) do
			iter_11_1:Dispose()
		end

		arg_11_0.rewardItemList_ = nil
	end

	arg_11_0.itemDataList_ = nil
end

return var_0_0
