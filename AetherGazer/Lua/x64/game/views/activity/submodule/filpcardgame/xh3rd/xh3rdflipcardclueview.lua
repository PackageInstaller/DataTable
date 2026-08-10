local var_0_0 = class("XH3rdFlipCardClueView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return XH3rdFlipCardTool.GetClueUI()
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

	if arg_4_0.clueListTrans_ ~= nil then
		local var_4_0 = arg_4_0.clueListTrans_.childCount

		arg_4_0.clueItemList = {}

		for iter_4_0 = 0, var_4_0 - 1 do
			local var_4_1 = arg_4_0.clueListTrans_:GetChild(iter_4_0)

			table.insert(arg_4_0.clueItemList, XH3rdFlipCardClueItem.New(var_4_1.gameObject, iter_4_0 + 1))
		end
	end

	arg_4_0.checkController_ = ControllerUtil.GetController(arg_4_0.transform_, "check")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.detailMask_, nil, function()
		arg_5_0.checkController_:SetSelectedState("false")
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityId = arg_9_0.params_.activityID
	arg_9_0.titleText_ = arg_9_0.titleText_
	arg_9_0.descText_ = arg_9_0.descText_

	local var_9_0 = FlipCardCfg[arg_9_0.activityId].details

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = FlipCardClueCfg[iter_9_1]

		arg_9_0.clueItemList[iter_9_0]:SetData(var_9_1, arg_9_0.activityId)
	end

	arg_9_0.receiveHandler_ = handler(arg_9_0, arg_9_0.OpenClueDetailView)

	manager.notify:RegistListener(FLIP_CARD_VIEW_CLUE_RESULT, arg_9_0.receiveHandler_)
end

function var_0_0.OpenClueDetailView(arg_10_0, arg_10_1)
	arg_10_0.checkController_:SetSelectedState("true")

	local var_10_0 = FlipCardClueCfg[arg_10_1]

	arg_10_0.titleText_.text = var_10_0.name
	arg_10_0.descText_.text = var_10_0.description
end

function var_0_0.OnExit(arg_11_0)
	manager.notify:RemoveListener(FLIP_CARD_VIEW_CLUE_RESULT, arg_11_0.receiveHandler_)
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.clueItemList) do
		iter_12_1:Dispose()
	end

	arg_12_0.clueListTrans_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
