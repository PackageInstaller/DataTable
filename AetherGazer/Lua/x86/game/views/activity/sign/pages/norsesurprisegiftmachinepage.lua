local var_0_0 = class("NorseSurpriseGiftMachinePage", ReduxView)
local var_0_1 = {
	{
		"anim01_1",
		"anim01_2",
		"anim01_3"
	},
	{
		"anim02_1",
		"anim02_2",
		"anim02_3"
	},
	{
		"anim03_1",
		"anim03_2"
	},
	{
		"anim04_1",
		"anim04_2",
		"anim04_3"
	},
	{
		"anim05_1",
		"anim05_2"
	}
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftMachineUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, NorseSurpriseGiftMachineItem)
	arg_3_0.onDrawHandler = handler(arg_3_0, arg_3_0.OnNorseGiftDrawSuccess)
	arg_3_0.onReceiveHandler = handler(arg_3_0, arg_3_0.OnNorseGiftReceiveSuccess)
	arg_3_0.onPlayAnimHandler = handler(arg_3_0, arg_3_0.OnNorseGiftPlayAnimDraw)
	arg_3_0.stateCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("bottom_btn_switch")
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	HeroLongHead.SetProxy(arg_4_2, arg_4_0.heroDataProxy)
	arg_4_2:SetData(arg_4_0.draw_list[arg_4_1])

	if arg_4_0.heartList and #arg_4_0.heartList > 0 then
		arg_4_2:SetState(arg_4_0.heartList, arg_4_0.result_role_id)
	else
		arg_4_2:ResetState()
	end

	if arg_4_1 == arg_4_0.needPlayDrawAnimIndex then
		arg_4_2:PlayAnim(true)

		arg_4_0.needPlayDrawAnimIndex = -1
	else
		arg_4_2:PlayAnim(false)
	end
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnReceive_, nil, function()
		if #NorseSurpriseGiftReceiveData:GetDrawRoleData() <= 0 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_4")
		else
			JumpTools.OpenPageByJump("norseSurpriseGiftReceivePage")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnStart_, nil, function()
		local var_7_0 = NorseSurpriseGiftReceiveData:GetChooseRoleData()
		local var_7_1 = NorseSurpriseGiftReceiveData:GetDrawRoleData()

		if #var_7_0 < 6 then
			JumpTools.OpenPageByJump("norseSurpriseGiftInStockPage")
		elseif ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN) < 1 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_3")
		elseif var_7_1 and #var_7_1 >= 5 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_6")
		else
			manager.windowBar:HideBar()

			arg_5_0.btnStart_.interactable = false
			arg_5_0.btnReceive_.interactable = false
			arg_5_0.btnInfo_.interactable = false
			arg_5_0.btnWish_.interactable = false
			arg_5_0.startAnim_.enabled = true

			arg_5_0.startAnim_:Play("Fx_niudanji_cx", -1, 0)
			arg_5_0.startAnim_:Update(0)
			AnimatorTools.PlayAnimatorWithCallback(arg_5_0.startAnim_, "Fx_niudanji_cx", function()
				arg_5_0.startAnim_.enabled = false

				if arg_5_0.draw_list then
					local var_8_0 = var_0_1[#arg_5_0.draw_list + 1]

					for iter_8_0, iter_8_1 in ipairs(var_8_0) do
						arg_5_0[iter_8_1].enabled = true

						arg_5_0[iter_8_1]:Play("Fx_ball_saoguang")
					end

					arg_5_0.animDrop_:Play("ball_trop", -1, 0)
					AnimatorTools.PlayAnimatorWithCallback(arg_5_0.animDrop_, "ball_trop", function()
						NorseSurpriseGiftReceiveAction.DrawCapsule(242832)

						arg_5_0.btnStart_.interactable = true
						arg_5_0.btnReceive_.interactable = true
						arg_5_0.btnInfo_.interactable = true
						arg_5_0.btnWish_.interactable = true
					end, false)
				end
			end, false)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnInfo_, nil, function()
		JumpTools.OpenPageByJump("norseSurpriseGiftChoosePage")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnWish_, nil, function()
		JumpTools.OpenPageByJump("norseSurpriseGiftWishPoolPage")
	end)
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_RANDOM_TARGET_COIN
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_OPTIONAL_RANDOM_RULE")
end

function var_0_0.OnEnter(arg_14_0)
	var_0_0.super.OnEnter(arg_14_0)
	arg_14_0:RegistEventListener(NORSE_GIFT_DRAW_SUCCESS, arg_14_0.onDrawHandler)
	arg_14_0:RegistEventListener(NORSE_GIFT_RECEIVE_SUCCESS, arg_14_0.onReceiveHandler)
	arg_14_0:RegistEventListener(NORSE_GIFT_PLAYANIM_DRAW, arg_14_0.onPlayAnimHandler)
	manager.redPoint:bindUIandKey(arg_14_0.btnStart_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.redPoint:bindUIandKey(arg_14_0.btnReceive_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	arg_14_0:RefreshView()
end

function var_0_0.OnExit(arg_15_0)
	var_0_0.super.OnExit(arg_15_0)
	arg_15_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_15_0.btnStart_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.redPoint:unbindUIandKey(arg_15_0.btnReceive_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.windowBar:HideBar()

	arg_15_0.needPlayDrawAnimIndex = -1
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	if arg_16_0.uiList_ then
		arg_16_0.uiList_:Dispose()

		arg_16_0.uiList_ = nil
	end
end

function var_0_0.RefreshCurrency(arg_17_0)
	if ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN) < 1 then
		arg_17_0.currencyTxt_.text = "<color=#FF000B>x1</color>"
	else
		arg_17_0.currencyTxt_.text = "<color=#262626>x1</color>"
	end
end

function var_0_0.RefreshView(arg_18_0)
	arg_18_0.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	arg_18_0.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()
	arg_18_0.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	arg_18_0:RefreshBtn()
	arg_18_0:RefreshCurrency()

	if arg_18_0.draw_list and #arg_18_0.draw_list > 0 and arg_18_0.uiList_ then
		arg_18_0.uiList_:StartScroll(#arg_18_0.draw_list)
	end

	arg_18_0:RefreshBall(#arg_18_0.draw_list)
end

function var_0_0.RefreshBall(arg_19_0, arg_19_1)
	for iter_19_0 = 1, arg_19_1 do
		for iter_19_1, iter_19_2 in ipairs(var_0_1[iter_19_0]) do
			SetActive(arg_19_0[iter_19_2].gameObject, false)
		end
	end
end

function var_0_0.RefreshBtn(arg_20_0)
	if arg_20_0.result_role_id and arg_20_0.result_role_id ~= 0 then
		arg_20_0.stateCtrl:SetSelectedIndex(1)
		SetActive(arg_20_0.costGo_, false)
	end
end

function var_0_0.OnNorseGiftDrawSuccess(arg_21_0, arg_21_1)
	NorseSurpriseGiftReceiveData:UpdateRedPointData(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
	JumpTools.OpenPageByJump("norseSurpriseGiftResultsview", {
		data = arg_21_1
	})
end

function var_0_0.OnNorseGiftReceiveSuccess(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = HeroCfg[arg_22_2.role_id]

	arg_22_0.result_role_id = arg_22_2.role_id
	arg_22_0.item_list = arg_22_1.item_list

	HeroAction.UnlockHeroSuccess(var_22_0.id)
	print("--->播放获取角色动画")
	gameContext:Go("obtainView", {
		itemList = {
			var_22_0
		},
		doNextHandler = handler(arg_22_0, arg_22_0.JumpToReward)
	})
end

function var_0_0.JumpToReward(arg_23_0)
	getReward2(arg_23_0.item_list)
	print("奖励弹窗---->", arg_23_0.result_role_id)
	arg_23_0:RefreshView()
end

function var_0_0.OnNorseGiftPlayAnimDraw(arg_24_0)
	arg_24_0.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	arg_24_0.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()
	arg_24_0.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	arg_24_0:RefreshBtn()
	arg_24_0:RefreshCurrency()

	arg_24_0.needPlayDrawAnimIndex = #arg_24_0.draw_list

	if arg_24_0.draw_list and #arg_24_0.draw_list > 0 and arg_24_0.uiList_ then
		arg_24_0.uiList_:StartScroll(#arg_24_0.draw_list)
	end

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN) < 1 then
		arg_24_0.currencyTxt_.text = "<color=#FF000B>x1</color>"
	else
		arg_24_0.currencyTxt_.text = "<color=#262626>x1</color>"
	end
end

return var_0_0
