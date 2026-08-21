local var_0_0 = class("TangramRegionRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.statusConst_ = {
		UNFINISH = 0,
		RECEIVED = 1
	}

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil

	arg_4_0.commonItem_:Dispose()

	arg_4_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.activityID_ = arg_5_1
	arg_5_0.regionID_ = arg_5_2
	arg_5_0.rewardCfg_ = TangramPuzzleTools.GetRegionRewardList(arg_5_1, arg_5_0.regionID_)

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0:RefreshReward()
	arg_6_0:RefreshStatus()
end

function var_0_0.RefreshReward(arg_7_0)
	if not arg_7_0.commonItem_ then
		arg_7_0.commonItem_ = CommonItemView.New(arg_7_0.rewardItemGo_)
	end

	if not arg_7_0.itemDataTemplate_ then
		arg_7_0.itemDataTemplate_ = clone(ItemTemplateData)
		arg_7_0.itemDataTemplate_.id = arg_7_0.rewardCfg_[1][1]
		arg_7_0.itemDataTemplate_.number = arg_7_0.rewardCfg_[1][2]

		function arg_7_0.itemDataTemplate_.clickFun(arg_8_0)
			ShowPopItem(POP_ITEM, {
				arg_8_0.id,
				arg_8_0.number
			})
		end

		arg_7_0.commonItem_:SetData(arg_7_0.itemDataTemplate_)
	end
end

function var_0_0.RefreshStatus(arg_9_0)
	if TangramPuzzleData:GetRegionReceivedDic(arg_9_0.activityID_)[arg_9_0.regionID_] == true then
		arg_9_0.status_ = arg_9_0.statusConst_.RECEIVED
	else
		arg_9_0.status_ = arg_9_0.statusConst_.UNFINISH
	end

	arg_9_0.statusController_:SetSelectedIndex(arg_9_0.status_)
end

return var_0_0
