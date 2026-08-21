local var_0_0 = class("BloodCardDeckCheckView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardDeckCheckUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.cardList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexCardItem), arg_3_0.cardUIList_, BloodCardVisualCardView)
	arg_3_0.isSelfController_ = arg_3_0.controller_:GetController("self")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selfDeckBtn_, nil, function()
		arg_4_0.isSelf_ = true

		arg_4_0:RefreshUI()
	end)
	arg_4_0:AddBtnListener(arg_4_0.enemyDeckBtn_, nil, function()
		arg_4_0.isSelf_ = false

		arg_4_0:RefreshUI()
	end)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		LuaExchangeHelper.LoadEmpty(LuaHelper.VoidAction(function()
			OpenPageUntilLoaded("/bloodCardGame")
		end))
	end)
	arg_4_0:AddBtnListener(arg_4_0.changeBtn_, nil, function()
		JumpTools.OpenPageByJump("/bloodCardBuild", {
			tabIndex = BloodCardData:GetUsingCardIndex()
		})
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityID_ = BloodCardData:GetMainActivityID()
	arg_10_0.stageID_ = BloodCardData:GetSelectStageID()
	arg_10_0.isSelf_ = false

	arg_10_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_11_0)
	if arg_11_0.isSelf_ then
		arg_11_0.cardIDList_ = BloodCardData:GetCardGroup(BloodCardData:GetUsingCardIndex())
	else
		arg_11_0.cardIDList_ = BloodCardGameStageCfg[arg_11_0.stageID_].ai_cards
	end

	table.sort(arg_11_0.cardIDList_, function(arg_12_0, arg_12_1)
		if BloodCardGameCardCfg[arg_12_0].kind ~= BloodCardGameCardCfg[arg_12_1].kind then
			return BloodCardGameCardCfg[arg_12_0].kind > BloodCardGameCardCfg[arg_12_1].kind
		end

		return arg_12_0 < arg_12_1
	end)

	arg_11_0.enemyNameText_.text = BloodCardGameNPCCfg[BloodCardData:GetSelectNpc()].name

	if BloodCardGameNPCCfg[BloodCardData:GetSelectNpc()].icon then
		arg_11_0.enemyImg_.spriteSync = "TextureConfig/BackHouseUI/RoleHead/" .. BloodCardGameNPCCfg[BloodCardData:GetSelectNpc()].icon
	end

	if GameSetting.card_game_player_portrait_icon then
		arg_11_0.selfImg_.spriteSync = "TextureConfig/BackHouseUI/RoleHead/" .. GameSetting.card_game_player_portrait_icon.value
	end

	arg_11_0.deckNameText_.text = BloodCardData:GetCardGroupName(BloodCardData:GetUsingCardIndex())
	arg_11_0.enemyDeckNameText_.text = BloodCardGameStageCfg[arg_11_0.stageID_].name

	arg_11_0.isSelfController_:SetSelectedState(tostring(arg_11_0.isSelf_))
	arg_11_0.cardList_:StartScroll(#arg_11_0.cardIDList_)
	SetActive(arg_11_0.changeBtnGo_, not table.indexof(BloodCardConst.guideStageList, arg_11_0.stageID_) and BloodCardGameStageCfg[arg_11_0.stageID_].freedom == 0)
end

function var_0_0.IndexCardItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, arg_13_0.cardIDList_[arg_13_1], not arg_13_0.isSelf_)
	arg_13_2:SetUseNum("false")

	if arg_13_0.isSelf_ then
		arg_13_2:SetOwnNum(BloodCardData:GetCardOwnNum(arg_13_0.cardIDList_[arg_13_1]))
	else
		arg_13_2:SetOwnNum(BloodCardGameCardCfg[arg_13_0.cardIDList_[arg_13_1]].limit)
	end

	arg_13_2:SetClickCallBack(function(arg_14_0, arg_14_1)
		for iter_14_0, iter_14_1 in ipairs(arg_13_0.cardList_:GetItemList()) do
			iter_14_1:ShowDescTips(arg_14_0, arg_14_1)
		end
	end)
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.cardList_ then
		arg_17_0.cardList_:Dispose()
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
