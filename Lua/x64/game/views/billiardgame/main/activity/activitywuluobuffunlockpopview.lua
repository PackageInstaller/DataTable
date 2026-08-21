local var_0_0 = class("ActivityWuluoBuffUnlockPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_UltimateBuffPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListner()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.buffItemList_ = {}
	arg_4_0.buffItemNameTextList_ = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = BilliardGameSmallSkillItemView.New(arg_4_0["buffItemGo_" .. iter_4_0])

		table.insert(arg_4_0.buffItemList_, var_4_0)
		table.insert(arg_4_0.buffItemNameTextList_, arg_4_0["buffName_" .. iter_4_0])
	end
end

function var_0_0.AddUIListner(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		arg_5_0:Back()
		JumpTools.OpenPageByJump("activityWuluoVehicleIllustratePopView", {
			selectTab = 2,
			selectedBuffId = arg_5_0.buffIdList_[1]
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.buffIdList_ = arg_7_0.params_.buffIDList

	for iter_7_0 = 1, 2 do
		arg_7_0.buffItemList_[iter_7_0]:SetBuffData(arg_7_0.buffIdList_[iter_7_0], true)

		local var_7_0 = MergeBallBuffCfg[arg_7_0.buffIdList_[iter_7_0]]

		if var_7_0 then
			arg_7_0.buffItemNameTextList_[iter_7_0].text = var_7_0.name
		end
	end
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.buffItemList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.buffItemList_ = {}

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
