local var_0_0 = class("HanafudaShowCombinePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaCombinationUI"
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

	arg_4_0.uiList_ = {}

	for iter_4_0 = 1, 6 do
		local var_4_0 = Object.Instantiate(arg_4_0.cardGo_, arg_4_0.listTrs_)
		local var_4_1 = HanafudaCardView.New(var_4_0)

		table.insert(arg_4_0.uiList_, var_4_1)
		SetActive(var_4_0, false)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:GoNextCombine()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_success", "")

	arg_7_0.combineIdList_ = arg_7_0.params_.combineIdList
	arg_7_0.curCombineIdIndex_ = 1
	arg_7_0.callback_ = arg_7_0.params_.callback
	arg_7_0.timer_ = Timer.New(function()
		arg_7_0:GoNextCombine()
	end, 1, -1, true)

	arg_7_0.timer_:Start()
	arg_7_0:RefreshUI()
end

function var_0_0.GoNextCombine(arg_9_0)
	if arg_9_0.curCombineIdIndex_ == #arg_9_0.combineIdList_ then
		arg_9_0:Back()

		if arg_9_0.callback_ then
			arg_9_0:callback_()
		end
	else
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_success", "")

		arg_9_0.curCombineIdIndex_ = arg_9_0.curCombineIdIndex_ + 1

		arg_9_0:RefreshUI()
	end
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = arg_10_0.combineIdList_[arg_10_0.curCombineIdIndex_]
	local var_10_1 = HanafudaCardCombineCfg[var_10_0]

	arg_10_0.cardIdList_ = var_10_1.card_list
	arg_10_0.combineNameText_.text = var_10_1.name
	arg_10_0.scoreText_.text = var_10_1.score

	arg_10_0:IndexItem()
end

function var_0_0.IndexItem(arg_11_0)
	for iter_11_0 = 1, 6 do
		local var_11_0 = arg_11_0.uiList_[iter_11_0]

		if arg_11_0.cardIdList_[iter_11_0] then
			local var_11_1 = arg_11_0.cardIdList_[iter_11_0]
			local var_11_2 = HanafudaCardCfg[var_11_1]

			var_11_0:SetData(iter_11_0, var_11_2)
			var_11_0:FlipToFaceUp()
			SetActive(var_11_0.gameObject_, true)
		else
			SetActive(var_11_0.gameObject_, false)
		end
	end

	arg_11_0.imgTrs_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 700 + 300 * #arg_11_0.cardIdList_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.listTrs_)
end

function var_0_0.OnExit(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.uiList_ then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.uiList_) do
			iter_13_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
