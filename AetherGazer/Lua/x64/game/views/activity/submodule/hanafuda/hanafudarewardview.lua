local var_0_0 = class("HanafudaGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.rewardList_, HanafudaRewardItem)
	arg_3_0.cardUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexCardItem), arg_3_0.cardList_, HanafudaCardView)
	arg_3_0.checkController_ = ControllerUtil.GetController(arg_3_0.transform_, "check")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.checkMaskBtn_, nil, function()
		arg_5_0.checkController_:SetSelectedState("false")
	end)
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_1, arg_8_0.combineCfgList_[arg_8_1])
	arg_8_2:SetCallBack(function()
		arg_8_0:RefreshUI()
	end)
	arg_8_2:SetCheckCallBack(function(arg_10_0)
		arg_8_0.cardIdList_ = HanafudaCardCombineCfg[arg_10_0].card_list

		arg_8_0.cardUIList_:StartScroll(#arg_8_0.cardIdList_)
		arg_8_0.checkController_:SetSelectedState("true")

		arg_8_0.titleText_.text = HanafudaCardCombineCfg[arg_10_0].name

		arg_8_0.imgTrs_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 700 + 300 * #arg_8_0.cardIdList_)
	end)
end

function var_0_0.IndexCardItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.cardIdList_[arg_11_1]
	local var_11_1 = HanafudaCardCfg[var_11_0]

	arg_11_2:SetData(arg_11_1, var_11_1)
	arg_11_2:FlipToFaceUp()
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.combineCfgList_ = deepClone(HanafudaData:GetCombineList())

	arg_12_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_13_0)
	table.sort(arg_13_0.combineCfgList_, function(arg_14_0, arg_14_1)
		local var_14_0 = HanafudaData:GetIsComplete(arg_14_0.id)
		local var_14_1 = HanafudaData:GetIsRewarded(arg_14_0.id)
		local var_14_2 = HanafudaData:GetIsComplete(arg_14_1.id)
		local var_14_3 = HanafudaData:GetIsRewarded(arg_14_1.id)

		if var_14_1 ~= var_14_3 then
			return not var_14_1 and var_14_3
		elseif var_14_0 ~= var_14_2 then
			return var_14_0 and not var_14_2
		else
			return arg_14_0.id < arg_14_1.id
		end
	end)
	arg_13_0.uiList_:StartScroll(#arg_13_0.combineCfgList_)
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.uiList_ then
		arg_15_0.uiList_:Dispose()
	end

	if arg_15_0.cardUIList_ then
		arg_15_0.cardUIList_:Dispose()
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
