local ValentineGameV2HeroInfoView = class("ValentineGameV2HeroInfoView", ReduxView)

function ValentineGameV2HeroInfoView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineStageUI"
end

function ValentineGameV2HeroInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameV2HeroInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ValentineGameV2HeroInfoView:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.rewardList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ValentineGameV2RewardItem)
end

function ValentineGameV2HeroInfoView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.cfg_.reward_item_list[arg_5_1])
end

function ValentineGameV2HeroInfoView:AddUIListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(self.activityID_) then
			if ValentineGameData:GetData(self.activityID_).isClear and type(ActivityValentineCfg[self.activityID_].cost_item) == "table" and not checkGold(ActivityValentineCfg[self.activityID_].cost_item[1][2], true) then
				return
			end

			JumpTools.OpenPageByJump("/valentineGameV2GameStartView", {
				activityID = self.activityID_
			})
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(self.activityID_).startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.activityID_).startTime))))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		ValentineGameAction:GetReward(self.activityID_)
	end)
end

function ValentineGameV2HeroInfoView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.cfg_ = ActivityValentineCfg[self.activityID_]

	self:RefreshUI()
end

function ValentineGameV2HeroInfoView:RefreshUI()
	self.nameText_.text = self.cfg_.name
	self.desText_.text = self.cfg_.desc
	self.finishNumText_.text = #ValentineGameData:GetData(self.activityID_).selectQuestionID .. "/" .. #self.cfg_.hero_qa_id
	self.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. self.cfg_.hero_id .. "_split_1")

	self.heroImage_:SetNativeSize()
	self.rewardList_:StartScroll(#self.cfg_.reward_item_list)

	local var_10_0 = ValentineGameData:GetData(self.activityID_)

	if var_10_0 and var_10_0.isReward then
		self.stateController_:SetSelectedState("received")
	elseif var_10_0 and var_10_0.isClear then
		self.stateController_:SetSelectedState("complete")
	else
		self.stateController_:SetSelectedState("test")
	end

	if var_10_0 and var_10_0.isClear then
		SetActive(self.costGo_, true)

		self.costIcon_.sprite = getSprite("Atlas/Currency", self.cfg_.cost_item[1][1])
		self.costText_.text = self.cfg_.cost_item[1][2]
	else
		SetActive(self.costGo_, false)
	end
end

function ValentineGameV2HeroInfoView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_VALENTINE_DESCRIBE")
end

function ValentineGameV2HeroInfoView:OnExit()
	manager.windowBar:HideBar()
end

function ValentineGameV2HeroInfoView:OnValentineGameReward()
	self:RefreshUI()
end

function ValentineGameV2HeroInfoView:Dispose()
	if self.rewardList_ then
		self.rewardList_:Dispose()

		self.rewardList_ = nil
	end

	self.super.Dispose(self)
end

return ValentineGameV2HeroInfoView
