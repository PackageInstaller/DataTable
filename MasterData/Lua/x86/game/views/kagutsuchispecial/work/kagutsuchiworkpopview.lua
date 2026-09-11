local KagutsuchiWorkPopView = class("KagutsuchiWorkPopView", ReduxView)

function KagutsuchiWorkPopView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionWorkUI/JapanRegionWorkDispatchUI"
end

function KagutsuchiWorkPopView:UIParent()
	return manager.ui.uiPop.transform
end

function KagutsuchiWorkPopView:Init()
	self:BindCfgUI()
	self:AddListeners()
	self:RegistEventListener(NEW_DAY, handler(self, self.OnNewDay))

	self.winController_ = ControllerUtil.GetController(self.transform_, "window")
	self.entrustingController_ = ControllerUtil.GetController(self.transform_, "entrusting")
	self.heroScroll = LuaList.New(handler(self, self.IndexItem), self.heroUiList_, KagutsuchiWorkEntrustHeroItem)
	self.commonItem_ = CommonItem.New(self.rewardGo_)
end

function KagutsuchiWorkPopView:OnEnter()
	self.isEntrusting = true

	self:RefreshHeroList()
	self:RefreshUI()
end

function KagutsuchiWorkPopView:OnExit()
	self.isEntrusting = false
	self.isEntrustFinished = false
end

function KagutsuchiWorkPopView:AddListeners()
	self:AddBtnListener(self.bgmask_, nil, function()
		self.isEntrusting = false
		self.isEntrustFinished = false

		self:Back()
	end)
	self:AddBtnListener(self.entrustCancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.finishBtn_, nil, function()
		self.isEntrusting = false
		self.isEntrustFinished = false

		self:Back()
	end)
	self:AddBtnListener(self.entrustStartBtn_, nil, function()
		if self.heroselectedNum < KagutsuchiWorkData:GetMinEntrustHeroNum() then
			ShowTips("ACTIVITY_KAGUTSUCHI_BATTLE_ENTRUST_FAIL_TIPS")

			return
		end

		self:StartEntrust()
	end)
end

function KagutsuchiWorkPopView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetHeroData(self.heroIdList[arg_11_1])
	arg_11_2:TrySetSelected(self.heroSelected[arg_11_1])
	arg_11_2:RefreshUI()
	arg_11_2:SetClickHandler(function(arg_12_0, arg_12_1)
		if self.heroSelected[arg_11_1] then
			arg_11_2:TrySetSelected(false)

			self.heroSelected[arg_11_1] = false
			self.heroselectedNum = self.heroselectedNum - 1

			arg_11_2:RefreshUI()
			self:RefreshUI()
		elseif self.heroselectedNum >= KagutsuchiWorkData:GetMinEntrustHeroNum() then
			return
		elseif arg_11_2:TrySetSelected(true) then
			self.heroSelected[arg_11_1] = true
			self.heroselectedNum = self.heroselectedNum + 1

			arg_11_2:RefreshUI()
			self:RefreshUI()
		end
	end)
end

function KagutsuchiWorkPopView:RefreshHeroList()
	if self.params_.isBattle then
		return
	end

	self.heroIdList = KagutsuchiWorkData:GetEntrustHeroIdList()

	self:SortHeroIdList()

	self.heroSelected = {}

	for iter_13_0 = 1, #self.heroIdList do
		self.heroSelected[iter_13_0] = false
	end

	self.heroselectedNum = 0

	self.heroScroll:StartScroll(#self.heroIdList)
end

function KagutsuchiWorkPopView:JumpToBattlePage()
	gameContext:Go("/sectionSelectHero", {
		section = self.params_.stageId,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME,
		activityID = self.params_.activityId
	})
end

function KagutsuchiWorkPopView:StartEntrust()
	local var_15_0 = {}

	for iter_15_0 = 1, #self.heroIdList do
		if self.heroSelected[iter_15_0] then
			table.insert(var_15_0, self.heroIdList[iter_15_0])
		end
	end

	KagutsuchiWorkAction:StartEntrust(self.params_.gridId, var_15_0, handler(self, self.FinishEntrust))
end

function KagutsuchiWorkPopView:FinishEntrust(arg_16_1)
	self.isEntrustFinished = true
	self.entrustReward = self.params_.entrustReward

	self:RefreshUI()

	if self.params_.entrustFinishHandler_ then
		self.params_.entrustFinishHandler_(arg_16_1)
	end
end

function KagutsuchiWorkPopView:RefreshUI()
	if self.params_.isBattle then
		self:RefreshBattleUI()
	else
		self:RefreshEntrustUI()
	end
end

function KagutsuchiWorkPopView:RefreshBattleUI()
	self.battleTitleText_.text = self.params_.battleName
	self.battleLevelText_.text = "Lv." .. self.params_.battleLevel
	self.battleSummaryText_.text = self.params_.battleSummary
	self.battleRewardText_.text = "x" .. self.params_.battleReward
	self.battleCostText_.text = "x" .. self.params_.battleCost

	self.winController_:SetSelectedState("battle")
end

function KagutsuchiWorkPopView:RefreshEntrustUI()
	if self.isEntrustFinished then
		self.commonItem_:RefreshData({
			id = ItemCfg[CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id].id,
			type = ItemCfg[CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id].type,
			number = self.params_.entrustReward
		})

		self.finishText_.text = self.params_.entrustCompleteText

		self.winController_:SetSelectedState("finish")
	elseif self.isEntrusting then
		local var_19_0 = KagutsuchiWorkData:GetMinEntrustHeroNum()

		self.entrustingNumText_.text = string.format("%d/%d", self.heroselectedNum, var_19_0)

		if self.heroselectedNum == var_19_0 then
			self.entrustingController_:SetSelectedState("valid")
		else
			self.entrustingController_:SetSelectedState("invalid")
		end

		self.winController_:SetSelectedState("entrusting")
	end
end

function KagutsuchiWorkPopView:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	if self.heroScroll then
		self.heroScroll:Dispose()

		self.heroScroll = nil
	end

	KagutsuchiWorkPopView.super.Dispose(self)
end

function KagutsuchiWorkPopView:OnNewDay()
	if gameContext:IsOpenRoute("kagutsuchiWorkPop") then
		self:Back()
	end
end

function KagutsuchiWorkPopView:OnKagutsuchiWorkDataInit()
	self:OnNewDay()
end

function KagutsuchiWorkPopView:SortHeroIdList()
	table.sort(self.heroIdList, function(arg_24_0, arg_24_1)
		return self:GetHeroPriority(arg_24_0) > self:GetHeroPriority(arg_24_1)
	end)
end

function KagutsuchiWorkPopView:GetHeroPriority(arg_25_1)
	local var_25_0 = HeroData:GetHeroData(arg_25_1)

	if var_25_0.unlock == 0 then
		return 1
	end

	if var_25_0.level < KagutsuchiWorkData:GetMinEntrustHeroLevel() then
		return 2
	end

	if KagutsuchiWorkData:IsEntrusted(arg_25_1) then
		return 3
	end

	return 4
end

return KagutsuchiWorkPopView
