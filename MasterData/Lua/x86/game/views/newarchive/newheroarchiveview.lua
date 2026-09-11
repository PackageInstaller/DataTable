local NewHeroArchiveView = class("NewHeroArchiveView", ReduxView)

function NewHeroArchiveView:UIName()
	return "UI/HeroArchive/ArchiveStoryMainUI_new"
end

function NewHeroArchiveView:UIParent()
	return manager.ui.uiMain.transform
end

function NewHeroArchiveView:Init()
	self.type_ = 1
	self.index_ = 0
	self.itemIndex_ = 0

	self:InitUI()
	self:AddUIListener()
end

function NewHeroArchiveView:InitUI()
	self:BindCfgUI()
	self.dropDown_.options:Clear()
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("HERO_ARCHIVES_TYPE_1"), nil))
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("HERO_ARCHIVES_TYPE_2"), nil))

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.heroList_, NewHeroArchiveHeroItemView)
	self.allBtnController_ = ControllerUtil.GetController(self.allBtn_.transform, "state")

	self:InitFillterItem()
end

function NewHeroArchiveView:InitFillterItem()
	local var_5_0 = {}

	self.fillterBtnList_ = self.fillterBtnList_ or {}

	for iter_5_0, iter_5_1 in pairs(RaceEffectCfg.all) do
		table.insert(var_5_0, RaceEffectCfg[iter_5_1])
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		if not self.fillterBtnList_[iter_5_2] then
			local var_5_1 = NewHeroArchiveHeroFillterItemView.New(Object.Instantiate(self.fillterItem_), iter_5_2)

			var_5_1.transform_:SetParent(self.btnList_, false)
			var_5_1:SetData(iter_5_3, iter_5_2)
			var_5_1:SetClickCallBack(handler(self, self.ClickFillterBtn))
			SetActive(var_5_1.gameObject_, true)
			table.insert(self.fillterBtnList_, var_5_1)
		end
	end
end

function NewHeroArchiveView:ClickFillterBtn(arg_6_1, arg_6_2)
	if self.index_ == arg_6_2 then
		return
	end

	self.index_ = arg_6_2

	if self.type_ == 1 then
		self.archiveList_ = ArchiveData:GetContinuousHeartArchiveListByType(arg_6_1)
	elseif self.type_ == 2 then
		self.archiveList_ = ArchiveData:GetContinuousSuperHeartArchiveListByType(arg_6_1)
	end

	self.itemIndex_ = 0

	self:RefreshUI()
end

function NewHeroArchiveView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.archiveList_[arg_7_1], self.type_)
	arg_7_2:SetClickCallBack(function()
		self.itemIndex_ = arg_7_1
	end)
end

function NewHeroArchiveView:AddUIListener()
	self:AddBtnListener(self.allBtn_, nil, function()
		if self.index_ == 0 then
			return
		end

		self.index_ = 0
		self.itemIndex_ = 0
		self.archiveList_ = self.type_ == 1 and ArchiveData:GetContinuousHeartArchiveList() or ArchiveData:GetContinuousSuperHeartArchiveList()

		self:RefreshUI()
	end)
	self:AddToggleListener(self.dropDown_, function(arg_11_0)
		self.itemIndex_ = 0
		self.type_ = arg_11_0 == 0 and 1 or 2
		self.index_ = 0
		self.archiveList_ = self.type_ == 1 and ArchiveData:GetContinuousHeartArchiveList() or ArchiveData:GetContinuousSuperHeartArchiveList()

		self:RefreshUI()
	end)
end

function NewHeroArchiveView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.scrollPosX = self:DynamicDivision(self.uiList_:GetScrolledPosition().x)
	self.timer = Timer.New(function()
		local var_13_0 = self:DynamicDivision(self.uiList_:GetScrolledPosition().x)

		self.filmAni_:SetFloat("floatSpeed", (var_13_0 - self.scrollPosX) * 10)

		self.scrollPosX = var_13_0
	end, 0.1, -1, true)

	self.timer:Start()
	self:RefreshUI()
end

function NewHeroArchiveView:DynamicDivision(arg_14_1)
	local var_14_0 = 1

	if arg_14_1 < 0 then
		var_14_0 = -1
		arg_14_1 = -arg_14_1
	end

	while arg_14_1 > 1 do
		arg_14_1 = arg_14_1 / 10
	end

	return arg_14_1 * var_14_0
end

function NewHeroArchiveView:RefreshUI()
	if not self.archiveList_ then
		if self.type_ == 1 then
			self.archiveList_ = ArchiveData:GetContinuousHeartArchiveList()
		elseif self.type_ == 2 then
			self.archiveList_ = ArchiveData:GetContinuousSuperHeartArchiveList()
		end
	end

	ArchiveData:SortHeartArchiveList(self.archiveList_)

	if self.index_ == 0 then
		self.allBtnController_:SetSelectedState("selected")
	else
		self.allBtnController_:SetSelectedState("unselected")
	end

	for iter_15_0, iter_15_1 in pairs(self.fillterBtnList_) do
		iter_15_1:RefreshUI(self.type_, self.index_)
	end

	self.listTimer = Timer.New(function()
		if self.heroList_.gameObject.activeInHierarchy == true then
			self.uiList_:StartScroll(#self.archiveList_)
			self.uiList_:ScrollToIndex(self.itemIndex_, true, false)
			self.listTimer:Stop()

			self.listTimer = nil
		end
	end, 0.1, -1, true)

	self.listTimer:Start()
end

function NewHeroArchiveView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.listTimer then
		self.listTimer:Stop()

		self.listTimer = nil
	end
end

function NewHeroArchiveView:Dispose()
	if self.fillterBtnList_ then
		for iter_18_0, iter_18_1 in pairs(self.fillterBtnList_) do
			iter_18_1:Dispose()
		end
	end

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	NewHeroArchiveView.super.Dispose(self)
end

return NewHeroArchiveView
