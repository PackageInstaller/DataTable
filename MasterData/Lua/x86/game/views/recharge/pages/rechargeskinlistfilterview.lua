local RechargeSkinListFilterView = class("RechargeSkinListFilterView", ReduxView)
local var_0_1 = {
	STATE = 2,
	HERO = 1
}

function RechargeSkinListFilterView:UIName()
	return "Widget/System/Recharge/RechargeFliterUI"
end

function RechargeSkinListFilterView:UIParent()
	return manager.ui.uiPop.transform
end

function RechargeSkinListFilterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeSkinListFilterView:InitUI()
	self:BindCfgUI()

	self.heroUIList_ = LuaList.New(handler(self, self.IndexHeroItem), self.heroListGo_, HeroLongHead)
	self.filterBottomList_ = {}
	self.tabController_ = self.tabControllerEx_:GetController("tab")
	self.selectController_ = self.mainConttollerEx_:GetController("type")
	self.heroController_ = self.mainConttollerEx_:GetController("select")
	self.typeController_ = {}
	self.buyController_ = {}

	for iter_4_0 = 1, 3 do
		self.typeController_[iter_4_0] = self["typeControllerEx_" .. iter_4_0]:GetController("select")
		self.buyController_[iter_4_0] = self["buyControllerEx_" .. iter_4_0]:GetController("select")
	end

	self.heroIDList_ = {}
	self.selectList_ = {}
	self.selectType_ = ShopConst.FILTER_HERO_TYPE.ALL
	self.selectBuy_ = ShopConst.FILTER_STATE_TYPE.ALL
	self.selectPanelType_ = var_0_1.HERO
end

function RechargeSkinListFilterView:OnEnter()
	self.filterParams_ = clone(self.params_.filterParams)

	self:InitHeroDataList()
	self:InitSelectList()
	self.heroUIList_:StartScroll(#self.heroIDList_)
	self:RefreshFilterBottom()
	self:RefreshPanel()
end

function RechargeSkinListFilterView:RefreshFilterBottom()
	for iter_6_0, iter_6_1 in ipairs(self.selectList_) do
		local var_6_0 = self.filterBottomList_[iter_6_0]

		if self.filterBottomList_[iter_6_0] == nil then
			var_6_0 = CommonFilterBottomItem.New((Object.Instantiate(self.filterBottomItemGo_, self.filterBottomContent_)))
			self.filterBottomList_[iter_6_0] = var_6_0
		end

		var_6_0:Refresh({
			name = HeroTools.GetHeroFullName(iter_6_1)
		})
	end

	for iter_6_2 = #self.selectList_ + 1, #self.filterBottomList_ do
		SetActive(self.filterBottomList_[iter_6_2].gameObject_, false)
	end
end

function RechargeSkinListFilterView:OnExit()
	return
end

function RechargeSkinListFilterView:Dispose()
	self.heroUIList_:Dispose()

	self.heroUIList_ = nil

	for iter_8_0, iter_8_1 in ipairs(self.filterBottomList_) do
		iter_8_1:Dispose()
	end

	RechargeSkinListFilterView.super.Dispose(self)
end

function RechargeSkinListFilterView:AddUIListener()
	self:AddBtnListener(self.btnConfirm_, nil, function()
		manager.notify:Invoke(RECHARGE_SKIN_LIST_FILTER_APPLY, {
			heroIDList = self.selectList_,
			goodType = self.selectType_,
			stateType = self.selectBuy_
		})
		self:Back()
	end)
	self:AddBtnListener(self.heroBtn_, nil, function()
		self:SwitchPanel(var_0_1.HERO)
	end)
	self:AddBtnListener(self.stateBtn_, nil, function()
		self:SwitchPanel(var_0_1.STATE)
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttomBtn_, nil, function()
		self:ClearSelect()
	end)

	for iter_9_0 = 1, 3 do
		self:AddBtnListener(self["typeBtn_" .. iter_9_0], nil, function()
			if self.selectType_ == iter_9_0 then
				return
			end

			self.selectType_ = iter_9_0

			self:RefreshPanel()
		end)
	end

	for iter_9_1 = 1, 3 do
		self:AddBtnListener(self["buyBtn_" .. iter_9_1], nil, function()
			if self.selectBuy_ == iter_9_1 then
				return
			end

			self.selectBuy_ = iter_9_1

			self:RefreshPanel()
		end)
	end
end

function RechargeSkinListFilterView:SwitchPanel(arg_17_1)
	if self.selectPanelType_ ~= arg_17_1 then
		self.selectPanelType_ = arg_17_1

		self:RefreshPanel()
	end
end

function RechargeSkinListFilterView:RefreshPanel()
	if self.selectPanelType_ == var_0_1.HERO then
		self.selectController_:SetSelectedIndex(0)
		self.tabController_:SetSelectedIndex(0)
	else
		self.selectController_:SetSelectedIndex(1)
		self.tabController_:SetSelectedIndex(1)
	end

	self.heroUIList_:StartScroll(#self.heroIDList_)

	for iter_18_0 = 1, 3 do
		self.typeController_[iter_18_0]:SetSelectedIndex(self.selectType_ == iter_18_0 and 1 or 0)
		self.buyController_[iter_18_0]:SetSelectedIndex(self.selectBuy_ == iter_18_0 and 1 or 0)
	end
end

function RechargeSkinListFilterView:InitHeroDataList()
	self.heroIDList_ = HeroCfg.get_id_list_by_private[0]

	table.sort(self.heroIDList_, function(arg_20_0, arg_20_1)
		local var_20_0 = HeroData:GetHeroData(arg_20_0)
		local var_20_1 = HeroData:GetHeroData(arg_20_1)
		local var_20_2 = getBattlePower(var_20_0)
		local var_20_3 = getBattlePower(var_20_1)

		if var_20_0.unlock ~= var_20_1.unlock then
			return var_20_0.unlock > var_20_1.unlock
		end

		local var_20_4 = HeroData:IsFavorite(arg_20_0)
		local var_20_5 = HeroData:IsFavorite(arg_20_1)

		if var_20_4 ~= var_20_5 and (not var_20_4 or not var_20_5) then
			return var_20_4 ~= false
		end

		if var_20_2 ~= var_20_3 then
			return var_20_3 < var_20_2
		end

		return arg_20_1 < arg_20_0
	end)
end

function RechargeSkinListFilterView:IndexHeroItem(arg_21_1, arg_21_2)
	local var_21_0 = self.heroIDList_[arg_21_1]

	arg_21_2.gameObject_.name = tostring(self.heroIDList_[arg_21_1])

	arg_21_2:SetProxy(self.heroViewProxy_)
	arg_21_2:SetHeroId(self.heroIDList_[arg_21_1], HeroConst.HERO_DATA_TYPE.DEFAULT)

	arg_21_2.nameText_.text = GetI18NText(HeroCfg[self.heroIDList_[arg_21_1]].name)

	arg_21_2:SetSelected(table.keyof(self.selectList_, self.heroIDList_[arg_21_1]) ~= nil)
	arg_21_2:RegisterClickListener(function()
		local var_22_0 = table.keyof(self.selectList_, var_21_0) == nil

		arg_21_2:SetSelected(var_22_0)

		if var_22_0 then
			table.insert(self.selectList_, var_21_0)
		else
			table.removebyvalue(self.selectList_, var_21_0)
		end

		self:RefreshSelectHeroList()
	end)
	arg_21_2:SetUnlockDisplay(false)
	arg_21_2:SetFavor(false)
end

function RechargeSkinListFilterView:RefreshSelectHeroList()
	self.heroUIList_:Refresh()

	if #self.selectList_ <= 0 then
		self.heroController_:SetSelectedState("off")
	else
		self.heroController_:SetSelectedState("on")
		self:RefreshFilterBottom()
	end
end

function RechargeSkinListFilterView:ClearSelect()
	self.selectList_ = {}

	self:RefreshSelectHeroList()
end

function RechargeSkinListFilterView:InitSelectList()
	self.selectList_ = self.filterParams_.heroIDList
	self.selectType_ = self.filterParams_.goodType
	self.selectBuy_ = self.filterParams_.stateType

	self:RefreshSelectHeroList()
end

return RechargeSkinListFilterView
