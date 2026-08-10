local var_0_0 = class("PuzzleNewRegionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.regionCfg_ = arg_1_2
	arg_1_0.regionID_ = arg_1_2[1]
	arg_1_0.puzzleDic_ = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2[2]) do
		arg_1_0.puzzleDic_[iter_1_1] = arg_1_3[iter_1_1]
	end

	arg_1_0.rewardCfg_ = arg_1_4
	arg_1_0.statusConst_ = {
		UNFINISH = 0,
		RECEIVED = 1
	}

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.receiveCallback_ = nil
	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil

	arg_5_0.commonItem_:Dispose()

	arg_5_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.activityID_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshReward()
	arg_7_0:RefreshStatus()
end

function var_0_0.RefreshReward(arg_8_0)
	if arg_8_0.commonItem_ == nil then
		arg_8_0.commonItem_ = CommonItemView.New(arg_8_0.rewardItemGo_, true)
		arg_8_0.itemData_ = clone(ItemTemplateData)

		function arg_8_0.itemData_.clickFun(arg_9_0)
			ShowPopItem(POP_ITEM, {
				arg_9_0.id,
				arg_9_0.number
			})
		end
	end

	arg_8_0.itemData_.id = arg_8_0.rewardCfg_[1][1]
	arg_8_0.itemData_.number = arg_8_0.rewardCfg_[1][2]

	arg_8_0.commonItem_:SetData(arg_8_0.itemData_)
end

function var_0_0.RefreshStatus(arg_10_0)
	if PuzzleNewData:GetRegionReceivedList(arg_10_0.activityID_)[arg_10_0.regionID_] == true then
		arg_10_0.status_ = arg_10_0.statusConst_.RECEIVED
	else
		arg_10_0.status_ = arg_10_0.statusConst_.UNFINISH

		local var_10_0 = PuzzleNewData:GetCurPuzzleList(arg_10_0.activityID_)
		local var_10_1 = 0

		for iter_10_0, iter_10_1 in pairs(arg_10_0.puzzleDic_) do
			if var_10_0[iter_10_1] and var_10_0[iter_10_1] == iter_10_0 then
				var_10_1 = var_10_1 + 1
			end
		end

		local var_10_2 = #arg_10_0.regionCfg_[2]

		arg_10_0.curText_.text = var_10_1
		arg_10_0.needText_.text = string.format("/%d", var_10_2)
	end

	arg_10_0.statusController_:SetSelectedIndex(arg_10_0.status_)
end

function var_0_0.RegisterReceiveCallback(arg_11_0, arg_11_1)
	arg_11_0.receiveCallback_ = arg_11_1
end

return var_0_0
