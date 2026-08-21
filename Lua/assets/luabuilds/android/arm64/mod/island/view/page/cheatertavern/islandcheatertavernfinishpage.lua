local var_0_0 = class("IslandCheaterTavernFinishPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCheaterTavernFinishUI"
end

function var_0_0.NeedCache(arg_2_0)
	return false
end

function var_0_0.OnLoaded(arg_3_0)
	onButton(arg_3_0, arg_3_0.uiquitBtn, function()
		arg_3_0:Hide()
		arg_3_0:emit(CheaterTavernEvent.FINSH_PAGE_QUIT)

		return
	end)
	onButton(arg_3_0, arg_3_0.conninueBtn, function()
		arg_3_0:Hide()

		return
	end)
	setText(arg_3_0.quitText, i18n("bar_ui_end1"))
	setText(arg_3_0.continueText, i18n("bar_ui_end2"))
	setText(arg_3_0.uiPtNameText, i18n("bar_ui_game3"))

	return
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddListener(GAME.ISLAND_CHEATER_REAL_END_NOTIFY, arg_6_0.OnGameEndNotify)

	return
end

function var_0_0.RemoveListeners(arg_7_0)
	arg_7_0:RemoveListener(GAME.ISLAND_CHEATER_REAL_END_NOTIFY, arg_7_0.OnGameEndNotify)

	return
end

function var_0_0.OnInit(arg_8_0)
	arg_8_0.animation = arg_8_0.uirightAdapt:GetComponent(typeof(Animation))

	return
end

function var_0_0.OnGameEndNotify(arg_9_0, arg_9_1)
	if arg_9_1.win_user == arg_9_0:GetIsland():GetCheaterTavernAgency():GetMainPlayer().id then
		return
	end

	arg_9_0:RefreshUI(IslandCheaterTavernConst.SettlementType.ByFinal)

	return
end

function var_0_0.RefreshUI(arg_10_0, arg_10_1)
	if arg_10_1 == IslandCheaterTavernConst.SettlementType.ByScore then
		local var_10_1 = IslandCheaterTavernRecordTools.LOST or IslandCheaterTavernRecordTools.WIN

		var_10_0(var_10_1)

		arg_10_0.cheaterTavernAgency = arg_10_0:GetIsland():GetCheaterTavernAgency()

		local var_10_2 = arg_10_0.cheaterTavernAgency:GetMainPlayer()
		local var_10_3 = var_10_2:GetRank()
		local var_10_4 = var_10_2:GetAddScore()

		setActive(arg_10_0.uiSus, var_10_3 == 1)
		setActive(arg_10_0.uiFail, var_10_3 ~= 1)
		setText(arg_10_0.uiWinNameText, var_10_2:GetName())
		setActive(arg_10_0.conninueBtn, var_10_3 ~= 1)
		GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. PlayRoomTools.GetPtScoreIcon(PlayRoomTools.GetGameTypeID()), "", arg_10_0.uiPtIcon)
		setText(arg_10_0.uiPtText, (PlayRoomTools.GetPtScrore(PlayRoomTools.GetGameTypeID())))

		local var_10_5 = getProxy(PlayRoomProxy)

		setActive(arg_10_0.uiScore, var_10_5:GetRoomData().roomType == PlayRoomConst.PLAY_ROOM_TYPE.MATCH)
		setText(arg_10_0.uiPtAddText, (var_10_4 >= 0 and "+" or "") .. var_10_4)

		if var_10_3 == 1 then
			arg_10_0.animation:Play("Anim_IslandCheaterTavernFinishUI_win")
		else
			arg_10_0.animation:Play("Anim_IslandCheaterTavernFinishUI_los")
		end

		if arg_10_1 == IslandCheaterTavernConst.SettlementType.ByFinal then
			setActive(arg_10_0.conninueBtn, false)
		end

		return
	end
end

function var_0_0.Show(arg_11_0, arg_11_1)
	var_0_0.super.Show(arg_11_0)
	arg_11_0:RefreshUI(arg_11_1)

	return
end

function var_0_0.OnDestroy(arg_12_0)
	var_0_0.super.OnDestroy(arg_12_0)

	return
end

function var_0_0.OnHide(arg_13_0)
	return
end

return var_0_0
