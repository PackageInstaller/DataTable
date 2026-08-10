local var_0_0 = class("BilliardBattleResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/BilliardGame/BilliardGame_CheckoutPopUI"
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

	arg_4_0.statusController = arg_4_0.controller_:GetController("Checkout")
	arg_4_0.foodController = arg_4_0.controller_:GetController("Winfood")
	arg_4_0.context = {
		victory = false
	}
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.foodItemList_, BilliardBattleResultFoodItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.foodItems[arg_5_1]

	arg_5_2:Render(var_5_0, arg_5_0)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.sucBtn_, arg_6_0, function()
		arg_6_0:OnSucBtnClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, arg_6_0, function()
		arg_6_0:OnBackBtnClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, arg_6_0, function()
		arg_6_0:OnMaskBtnClick()
	end)
end

function var_0_0.OnSucBtnClick(arg_10_0)
	if arg_10_0.context.victory then
		OnExitBilliardBattle(arg_10_0.context.victory)
	else
		manager.ui:SetCanvasAlpha(0)
		BilliardGameMgr:Restart()
	end
end

function var_0_0.OnMaskBtnClick(arg_11_0)
	if arg_11_0.isTipsOpen then
		SetActive(arg_11_0.tipsObj_, false)

		arg_11_0.isTipsOpen = false
	end
end

function var_0_0.OnChildClick(arg_12_0, arg_12_1)
	arg_12_0.isTipsOpen = true

	SetActive(arg_12_0.tipsObj_, true)

	arg_12_0.tipsObj_.transform.position = arg_12_1:GetTipTrans().position
	arg_12_0.tipsTxt_.text = ItemTools.getItemDesc(arg_12_1:GetItemId())
end

function var_0_0.OnBackBtnClick(arg_13_0)
	manager.ui:SetCanvasAlpha(0)
	LuaExchangeHelper.GoToMain(CustomLoadingConst.BilliardGame_Loading)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.needJumpToNextStage = false

	local var_14_0 = arg_14_0.params_.victory

	arg_14_0.context.victory = var_14_0

	arg_14_0.foodController:SetSelectedState("off")
	SetActive(arg_14_0.collectTxt_.gameObject, false)

	if var_14_0 then
		manager.audio:PlayEffect("minigame_activity_4_3", "minigame_activity_4_3_cook_gold04", "")
		arg_14_0.statusController:SetSelectedState("win")
		arg_14_0.backBtnObj_:SetActive(false)
		arg_14_0.sucBtnObj_:SetActive(true)

		arg_14_0.sucBtnTxt_.text = GetTips("BILLIARD_GAME_BACK_ADVENTURE")

		local var_14_1, var_14_2, var_14_3 = BilliardBattleNeedJumpToCook(true)

		if var_14_2 then
			arg_14_0.foodController:SetSelectedState("on")

			if var_14_3 then
				local var_14_4 = getRewardFromDropCfg(var_14_3, true)
				local var_14_5 = {}

				for iter_14_0, iter_14_1 in ipairs(var_14_4) do
					table.insert(var_14_5, iter_14_1.id)
				end

				arg_14_0.foodItems = var_14_5

				arg_14_0.scrollHelper_:StartScroll(#arg_14_0.foodItems)
			end
		end

		if var_14_1 then
			SetActive(arg_14_0.collectTxt_.gameObject, true)

			arg_14_0.sucBtnTxt_.text = GetTips("BILLIARD_GAME_COME_TO_COOK_GAME")
			arg_14_0.collectTxt_.text = GetTips("BILLIARD_GAME_COME_READY_TO_COOK")
		end

		if BilliardGameMgr:GetLevelId() == BilliardGameConst.FirstLevelId then
			local var_14_6 = SummerPubLevelCfg[BilliardGameMgr:GetLevelId()]
			local var_14_7 = BilliardGameMgr:GetStageId()
			local var_14_8 = 0
			local var_14_9 = false

			if var_14_7 == var_14_6.stage_id[1] then
				var_14_9 = true
				var_14_8 = SummerPubData:GetClearNumByStageID(BilliardGameMgr:GetLevelId(), 1)
			end

			if var_14_8 == 0 and var_14_9 then
				arg_14_0.needJumpToNextStage = true
				arg_14_0.sucBtnTxt_.text = GetTips("ACTIVITY_HERO_ENHANCE_BUTTON_CONTINUE")
			end
		end
	else
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_cook_done02", "")
		arg_14_0.statusController:SetSelectedState("lose")
		arg_14_0.backBtnObj_:SetActive(true)
		arg_14_0.sucBtnObj_:SetActive(true)

		arg_14_0.sucBtnTxt_.text = GetTips("BILLIARD_GAME_CONTINUE_ADVENTURE")
		arg_14_0.backBtnTxt_.text = GetTips("BILLIARD_GAME_BACK_ADVENTURE")
	end
end

function var_0_0.OnExit(arg_15_0)
	var_0_0.super.OnExit(arg_15_0)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
