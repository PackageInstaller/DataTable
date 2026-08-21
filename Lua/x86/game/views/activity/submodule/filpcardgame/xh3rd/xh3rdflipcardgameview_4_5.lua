local var_0_0 = class("XH3rdFlipCardGameView_4_5", XH3rdFlipCardGameView)

function var_0_0.InitCard(arg_1_0)
	if #XH3rdFlipCardData.data.unlock_card_list <= 6 then
		XH3rdFlipCardTool:SetCardNum(6, 2)
	else
		XH3rdFlipCardTool:SetCardNum(6, 3)
	end

	XH3rdFlipCardTool:InitGame()
end

function var_0_0.RefreshPausedStateUI(arg_2_0)
	local var_2_0 = #XH3rdFlipCardData:GetClueList(arg_2_0.activityId)
	local var_2_1 = #FlipCardCfg[arg_2_0.activityId].details

	arg_2_0.clueText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_CLUE_COLLECTION_PROGRESS"), var_2_0, var_2_1)

	local var_2_2 = FlipCardCfg[arg_2_0.activityId].cost_id

	arg_2_0.tokenImg_.sprite = ItemTools.getItemSprite(var_2_2)
	arg_2_0.startItemImg_.sprite = ItemTools.getItemSprite(var_2_2)
	arg_2_0.tokenNumberText_.text = ItemTools.getItemNum(var_2_2)

	local var_2_3 = #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list
	local var_2_4 = false

	if var_2_3 <= 6 then
		arg_2_0.clueNumText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11_UNLOCK_CLUE"), 2)
		arg_2_0.clueProgressNum_.text = #XH3rdFlipCardData:GetClueList(arg_2_0.activityId) .. "/2"
		var_2_4 = #XH3rdFlipCardData:GetClueList(arg_2_0.activityId) == 2
	else
		arg_2_0.clueNumText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11_UNLOCK_CLUE"), 4)
		arg_2_0.clueProgressNum_.text = #XH3rdFlipCardData:GetClueList(arg_2_0.activityId) .. "/4"
	end

	arg_2_0.clueController_:GetController("achieve"):SetSelectedState(tostring(var_2_4))
	arg_2_0:SetUnlockTimeText()
	SetActive(arg_2_0.clueGo_, var_2_3 < 9)
	SetActive(arg_2_0.unlockGo_, var_2_3 == 9)

	arg_2_0.cardNumText_.text = var_2_3 .. "/" .. #FlipCardCfg[arg_2_0.activityId].normal_card + #FlipCardCfg[arg_2_0.activityId].special_card

	arg_2_0:CheckHasNewCard()
end

function var_0_0.SetUnlockTimeText(arg_3_0)
	local var_3_0 = #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list
	local var_3_1 = 1

	arg_3_0.timeUnlockText_.text = ""

	if XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_3_1) then
		arg_3_0.timeUnlockText_.text = XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_3_1)
	end

	SetActive(arg_3_0.timeUnlockGo_, var_3_0 < 9 and var_3_0 >= 6)
	arg_3_0.timeUnlockController_:GetController("achieve"):SetSelectedState(tostring(not XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_3_1)))
end

return var_0_0
