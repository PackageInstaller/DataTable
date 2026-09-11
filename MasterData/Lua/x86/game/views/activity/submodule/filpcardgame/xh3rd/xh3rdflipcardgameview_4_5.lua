local XH3rdFlipCardGameView_4_5 = class("XH3rdFlipCardGameView_4_5", XH3rdFlipCardGameView)

function XH3rdFlipCardGameView_4_5:InitCard()
	if #XH3rdFlipCardData.data.unlock_card_list <= 6 then
		XH3rdFlipCardTool:SetCardNum(6, 2)
	else
		XH3rdFlipCardTool:SetCardNum(6, 3)
	end

	XH3rdFlipCardTool:InitGame()
end

function XH3rdFlipCardGameView_4_5:RefreshPausedStateUI()
	self.clueText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_CLUE_COLLECTION_PROGRESS"), #XH3rdFlipCardData:GetClueList(self.activityId), #FlipCardCfg[self.activityId].details)
	self.tokenImg_.sprite = ItemTools.getItemSprite(FlipCardCfg[self.activityId].cost_id)
	self.startItemImg_.sprite = ItemTools.getItemSprite(FlipCardCfg[self.activityId].cost_id)
	self.tokenNumberText_.text = ItemTools.getItemNum(FlipCardCfg[self.activityId].cost_id)

	local var_2_0 = #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list
	local var_2_1 = false

	if #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list <= 6 then
		self.clueNumText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11_UNLOCK_CLUE"), 2)
		self.clueProgressNum_.text = #XH3rdFlipCardData:GetClueList(self.activityId) .. "/2"
		var_2_1 = #XH3rdFlipCardData:GetClueList(self.activityId) == 2
	else
		self.clueNumText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11_UNLOCK_CLUE"), 4)
		self.clueProgressNum_.text = #XH3rdFlipCardData:GetClueList(self.activityId) .. "/4"
	end

	self.clueController_:GetController("achieve"):SetSelectedState(tostring(var_2_1))
	self:SetUnlockTimeText()
	SetActive(self.clueGo_, var_2_0 < 9)
	SetActive(self.unlockGo_, var_2_0 == 9)

	self.cardNumText_.text = var_2_0 .. "/" .. #FlipCardCfg[self.activityId].normal_card + #FlipCardCfg[self.activityId].special_card

	self:CheckHasNewCard()
end

function XH3rdFlipCardGameView_4_5:SetUnlockTimeText()
	local var_3_0 = #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list
	local var_3_1 = 1

	self.timeUnlockText_.text = ""

	if XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_3_1) then
		self.timeUnlockText_.text = XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_3_1)
	end

	SetActive(self.timeUnlockGo_, var_3_0 < 9 and var_3_0 >= 6)
	self.timeUnlockController_:GetController("achieve"):SetSelectedState(tostring(not XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_3_1)))
end

return XH3rdFlipCardGameView_4_5
