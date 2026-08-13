class = var_0_10000

local var_0_0 = "IslandCheaterTavernFinishPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCheaterTavernFinishUI"
end

function var_0_1.NeedCache(arg_2_0)
	return false
end

function var_0_1.OnLoaded(arg_3_0)
	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.uiquitBtn, function()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		local var_4_1 = arg_3_0
		local var_4_2 = var_0.emit

		CheaterTavernEvent = var_2_10003

		var_4_2(var_4_1, var_2_10003.FINSH_PAGE_QUIT)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.conninueBtn, function()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end)

	setText = var_1_10001

	local var_3_0 = arg_3_0.quitText

	i18n = var_4

	var_1_10001(var_3_0, var_4("bar_ui_end1"))

	setText = var_1_10001

	local var_3_1 = arg_3_0.continueText

	i18n = var_4

	var_1_10001(var_3_1, var_4("bar_ui_end2"))

	setText = var_1_10001

	local var_3_2 = arg_3_0.uiPtNameText

	i18n = var_4

	var_1_10001(var_3_2, var_4("bar_ui_game3"))

	return
end

function var_0_1.AddListeners(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.AddListener

	GAME = var_1_10004

	var_6_1(var_6_0, var_1_10004.ISLAND_CHEATER_REAL_END_NOTIFY, arg_6_0.OnGameEndNotify)

	return
end

function var_0_1.RemoveListeners(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.RemoveListener

	GAME = var_1_10004

	var_7_1(var_7_0, var_1_10004.ISLAND_CHEATER_REAL_END_NOTIFY, arg_7_0.OnGameEndNotify)

	return
end

function var_0_1.OnInit(arg_8_0)
	local var_8_0 = arg_8_0.uirightAdapt
	local var_8_1 = var_1.GetComponent

	typeof = var_1_10004
	Animation = var_1_10006
	arg_8_0.animation = var_8_1(var_8_0, var_1_10004(var_1_10006))

	return
end

function var_0_1.OnGameEndNotify(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetIsland()
	local var_9_1 = var_2.GetCheaterTavernAgency(var_9_0)
	local var_9_2 = var_2.GetMainPlayer(var_9_1).id

	if arg_9_1.win_user == var_9_2 then
		return
	end

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.RefreshUI

	IslandCheaterTavernConst = var_1_10007

	var_9_4(var_9_3, var_1_10007.SettlementType.ByFinal)

	return
end

function var_0_1.RefreshUI(arg_10_0, arg_10_1)
	IslandCheaterTavernRecordTools = var_1_10002

	local var_10_0 = var_1_10002.RecordResult

	IslandCheaterTavernConst = var_1_10004

	if arg_10_1 == var_1_10004.SettlementType.ByScore then
		IslandCheaterTavernRecordTools = var_10_1

		local var_10_1

		if not var_10_1.LOST then
			IslandCheaterTavernRecordTools = var_10_1
			var_10_1 = var_10_1.WIN
		end

		var_10_0(var_10_1)

		local var_10_2 = arg_10_0:GetIsland()

		arg_10_0.cheaterTavernAgency = var_2.GetCheaterTavernAgency(var_10_2)

		local var_10_3 = arg_10_0.cheaterTavernAgency
		local var_10_4 = var_2.GetMainPlayer(var_10_3)
		local var_10_5 = var_2.GetRank(var_10_4)
		local var_10_6 = var_2
		local var_10_7 = var_2.GetAddScore(var_10_6)

		setActive = var_10_4

		var_10_4(arg_10_0.uiSus, var_10_5 == 1)

		setActive = var_10_4

		var_10_4(arg_10_0.uiFail, var_10_5 ~= 1)

		setText = var_10_4

		var_10_4(arg_10_0.uiWinNameText, var_2:GetName())

		setActive = var_10_4

		var_10_4(arg_10_0.conninueBtn, var_10_5 ~= 1)

		PlayRoomTools = var_10_4

		local var_10_8 = var_10_4.GetPtScoreIcon

		PlayRoomTools = var_7

		local var_10_9 = var_10_8(var_7.GetGameTypeID())

		GetImageSpriteFromAtlasAsync = var_10_6

		var_10_6("Island/IslandCheaterTavernIcon/" .. var_10_9, "", arg_10_0.uiPtIcon)

		PlayRoomTools = var_10_6

		local var_10_10 = var_10_6.GetPtScrore

		PlayRoomTools = var_8

		local var_10_11 = var_10_10(var_8.GetGameTypeID())

		setText = var_7

		var_7(arg_10_0.uiPtText, var_10_11)

		setActive = var_7

		local var_10_12 = arg_10_0.uiScore

		getProxy = var_10
		PlayRoomProxy = var_1_10012

		local var_10_13 = var_10(var_1_10012)
		local var_10_14 = var_10.GetRoomData(var_10_13).roomType

		PlayRoomConst = var_1_10011

		var_7(var_10_12, var_10_14 == var_1_10011.PLAY_ROOM_TYPE.MATCH)

		local var_10_15 = var_10_7 >= 0 and "+" or ""

		setText = var_8

		var_8(arg_10_0.uiPtAddText, var_10_15 .. var_10_7)

		if var_10_5 == 1 then
			local var_10_16 = arg_10_0.animation

			var_8.Play(var_10_16, "Anim_IslandCheaterTavernFinishUI_win")
		else
			local var_10_17 = arg_10_0.animation

			var_8.Play(var_10_17, "Anim_IslandCheaterTavernFinishUI_los")
		end

		IslandCheaterTavernConst = var_8

		if arg_10_1 == var_8.SettlementType.ByFinal then
			setActive = var_8

			var_8(arg_10_0.conninueBtn, false)
		end

		return
	end
end

function var_0_1.Show(arg_11_0, arg_11_1)
	var_0_1.super.Show(arg_11_0)
	arg_11_0:RefreshUI(arg_11_1)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	var_0_1.super.OnDestroy(arg_12_0)

	return
end

function var_0_1.OnHide(arg_13_0)
	return
end

return var_0_1
