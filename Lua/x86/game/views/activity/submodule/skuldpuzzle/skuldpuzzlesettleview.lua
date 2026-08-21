local var_0_0 = class("SkuldPuzzleSettleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_ResultPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.btnStateController = arg_4_0.controller_:GetController("btnState")
	arg_4_0.trustShowController = arg_4_0.controller_:GetController("trustShow")
	arg_4_0.rewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexRewardItem), arg_4_0.uilistGo_, CommonItemView)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnconfirmBtn_, nil, function()
		if SkuldStageCfg[arg_5_0.levelID].section == 9 then
			JumpTools.OpenPageByJump("/skuldSystemStageView", {
				isFinal = true,
				startNext = false
			}, true)
		else
			JumpTools.OpenPageByJump("/skuldSystemStageView", {
				isFinal = false,
				startNext = false
			}, true)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btncontinueBtn_, nil, function()
		arg_5_0:OnContinueBtn()
	end)
end

local var_0_1 = {
	PIECE = 2,
	BATTLE = 1
}

function var_0_0.OnContinueBtn(arg_8_0)
	if not arg_8_0:IsOpenContinueBtn() then
		return
	end

	local var_8_0 = arg_8_0.levelID + 1

	SkuldSystemAction.OpenSkuldBattle(var_8_0, BattleConst.SKULD, true)
end

function var_0_0.IsOpenContinueBtn(arg_9_0)
	return SkuldStageCfg[arg_9_0.levelID].ending == 1
end

function var_0_0.IndexRewardItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.rewardList[arg_10_1]
	local var_10_1 = clone(ItemTemplateData)

	var_10_1.id = var_10_0[1]
	var_10_1.number = var_10_0[2]

	function var_10_1.clickFun(arg_11_0)
		ShowPopItem(POP_ITEM, {
			arg_11_0.id,
			arg_11_0.number
		})
	end

	arg_10_2:SetData(var_10_1)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.levelID = arg_12_0.params_.levelID

	arg_12_0:RefreshUI()
	SkuldSystemData:UpdateSkuldStageArchiveRed()
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = SkuldStageCfg[arg_13_0.levelID]
	local var_13_1 = arg_13_0.params_.rewardList
	local var_13_2 = CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id
	local var_13_3 = 0
	local var_13_4 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if iter_13_1.id == var_13_2 then
			var_13_3 = iter_13_1.num
		else
			local var_13_5 = {
				iter_13_1.id,
				iter_13_1.num
			}

			table.insert(var_13_4, var_13_5)
		end
	end

	arg_13_0.rewardList = var_13_4

	arg_13_0.rewardList_:StartScroll(#var_13_4)

	if var_13_3 > 0 then
		arg_13_0.trustShowController:SetSelectedState("show")
	else
		arg_13_0.trustShowController:SetSelectedState("hide")
	end

	local var_13_6 = ItemTools.getItemNum(var_13_2)

	arg_13_0.valueAgoTxt_.text = var_13_6 - var_13_3
	arg_13_0.valueNowTxt_.text = var_13_6

	if arg_13_0:IsOpenContinueBtn() then
		arg_13_0.btnStateController:SetSelectedState("normal")
	else
		arg_13_0.btnStateController:SetSelectedState("noContinue")
	end
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.rewardList_ then
		arg_16_0.rewardList_:Dispose()

		arg_16_0.rewardList_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
