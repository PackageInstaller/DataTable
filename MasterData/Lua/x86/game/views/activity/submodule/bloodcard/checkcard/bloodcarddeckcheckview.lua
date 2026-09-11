local BloodCardDeckCheckView = class("BloodCardDeckCheckView", ReduxView)

function BloodCardDeckCheckView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardDeckCheckUI"
end

function BloodCardDeckCheckView:UIParent()
	return manager.ui.uiMain.transform
end

function BloodCardDeckCheckView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.cardList_ = LuaList.New(handler(self, self.IndexCardItem), self.cardUIList_, BloodCardVisualCardView)
	self.isSelfController_ = self.controller_:GetController("self")
end

function BloodCardDeckCheckView:AddUIListener()
	self:AddBtnListener(self.selfDeckBtn_, nil, function()
		self.isSelf_ = true

		self:RefreshUI()
	end)
	self:AddBtnListener(self.enemyDeckBtn_, nil, function()
		self.isSelf_ = false

		self:RefreshUI()
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		LuaExchangeHelper.LoadEmpty(LuaHelper.VoidAction(function()
			OpenPageUntilLoaded("/bloodCardGame")
		end))
	end)
	self:AddBtnListener(self.changeBtn_, nil, function()
		JumpTools.OpenPageByJump("/bloodCardBuild", {
			tabIndex = BloodCardData:GetUsingCardIndex()
		})
	end)
end

function BloodCardDeckCheckView:OnEnter()
	self.activityID_ = BloodCardData:GetMainActivityID()
	self.stageID_ = BloodCardData:GetSelectStageID()
	self.isSelf_ = false

	self:RefreshUI()
end

function BloodCardDeckCheckView:RefreshUI()
	self.cardIDList_ = self.isSelf_ and BloodCardData:GetCardGroup(BloodCardData:GetUsingCardIndex()) or BloodCardGameStageCfg[self.stageID_].ai_cards

	table.sort(self.cardIDList_, function(arg_12_0, arg_12_1)
		if BloodCardGameCardCfg[arg_12_0].kind ~= BloodCardGameCardCfg[arg_12_1].kind then
			return BloodCardGameCardCfg[arg_12_0].kind > BloodCardGameCardCfg[arg_12_1].kind
		end

		return arg_12_0 < arg_12_1
	end)

	self.enemyNameText_.text = BloodCardGameNPCCfg[BloodCardData:GetSelectNpc()].name

	if BloodCardGameNPCCfg[BloodCardData:GetSelectNpc()].icon then
		self.enemyImg_.spriteSync = "TextureConfig/BackHouseUI/RoleHead/" .. BloodCardGameNPCCfg[BloodCardData:GetSelectNpc()].icon
	end

	if GameSetting.card_game_player_portrait_icon then
		self.selfImg_.spriteSync = "TextureConfig/BackHouseUI/RoleHead/" .. GameSetting.card_game_player_portrait_icon.value
	end

	self.deckNameText_.text = BloodCardData:GetCardGroupName(BloodCardData:GetUsingCardIndex())
	self.enemyDeckNameText_.text = BloodCardGameStageCfg[self.stageID_].name

	self.isSelfController_:SetSelectedState(tostring(self.isSelf_))
	self.cardList_:StartScroll(#self.cardIDList_)
	SetActive(self.changeBtnGo_, not table.indexof(BloodCardConst.guideStageList, self.stageID_) and BloodCardGameStageCfg[self.stageID_].freedom == 0)
end

function BloodCardDeckCheckView:IndexCardItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, self.cardIDList_[arg_13_1], not self.isSelf_)
	arg_13_2:SetUseNum("false")

	if self.isSelf_ then
		arg_13_2:SetOwnNum(BloodCardData:GetCardOwnNum(self.cardIDList_[arg_13_1]))
	else
		arg_13_2:SetOwnNum(BloodCardGameCardCfg[self.cardIDList_[arg_13_1]].limit)
	end

	arg_13_2:SetClickCallBack(function(arg_14_0, arg_14_1)
		for iter_14_0, iter_14_1 in ipairs(self.cardList_:GetItemList()) do
			iter_14_1:ShowDescTips(arg_14_0, arg_14_1)
		end
	end)
end

function BloodCardDeckCheckView:OnExit()
	manager.windowBar:HideBar()
end

function BloodCardDeckCheckView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function BloodCardDeckCheckView:Dispose()
	if self.cardList_ then
		self.cardList_:Dispose()
	end

	BloodCardDeckCheckView.super.Dispose(self)
end

return BloodCardDeckCheckView
