class = var_0_10000

local var_0_0 = "IslandCheaterTavernStartGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCheaterTavernBaseView"))

function var_0_1.Show(arg_1_0)
	pg = var_1_10001
	arg_1_0.startCardList = var_1_10001.gameset.bar_card.description

	local var_1_0 = arg_1_0.cardItemList

	var_1.align(var_1_0, #arg_1_0.startCardList)

	local var_1_1 = arg_1_0.cheaterTavernAgency
	local var_1_2 = var_1.GetMainPlayer(var_1_1)

	if not var_1.IsOut(var_1_2) then
		IslandCheaterTavernRecordTools = var_2

		var_2.AddTurnCnt()
	end

	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0.uiParent_ = arg_2_0._tf.parent

	arg_2_0.super.Init(arg_2_0)

	UIItemList = var_1
	arg_2_0.cardItemList = var_1.New(arg_2_0.uiStartGameItemList, arg_2_0.uiStartGameItem)

	local var_2_0 = arg_2_0.cardItemList

	var_1.make(var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_2_0

			var_3.OnUpdateItem(var_3_0, arg_3_1, arg_3_2)
		end

		return
	end)

	return
end

function var_0_1.OnCheaterEveryRoundStart(arg_4_0)
	arg_4_0:SetActiveState(true)
	arg_4_0:Show()

	pg = var_1

	local var_4_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.OnCheaterEveryRoundStartDone(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_5_0, arg_5_0._tf, arg_5_0.uiParent_)
	arg_5_0:SetActiveState(false)

	return
end

function var_0_1.OnUpdateItem(arg_6_0, arg_6_1, arg_6_2)
	tf = var_1_10003

	local var_6_0 = var_1_10003(arg_6_2)
	local var_6_1 = arg_6_1 + 1
	local var_6_2 = arg_6_0.startCardList[var_6_1][1]

	pg = var_1_10007

	local var_6_3 = var_1_10007.bar_card[var_6_2]
	local var_6_4 = var_5[2]

	GetImageSpriteFromAtlasAsync = var_1_10009

	var_1_10009("Island/IslandCheaterTavernIcon/" .. var_6_3.card_res, "", var_6_0:Find("cardImage"))

	setText = var_1_10009

	var_1_10009(var_6_0:Find("numBg/numText"), "x" .. var_6_4)

	local var_6_5 = arg_6_0.cheaterTavernAgency
	local var_6_6 = var_9.GetRealCard(var_6_5)

	setActive = var_6_5

	var_6_5(var_6_0:Find("selected"), var_6_6 == var_6_2)

	return
end

function var_0_1.OnInit(arg_7_0)
	return
end

function var_0_1.OnHide(arg_8_0)
	if arg_8_0._tf.parent ~= arg_8_0.uiParent_ then
		pg = var_1

		local var_8_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_8_0, arg_8_0._tf, arg_8_0.uiParent_)
	end

	return
end

return var_0_1
