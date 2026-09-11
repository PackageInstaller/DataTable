local MoonFillingMakeView = class("MoonFillingMakeView", ReduxView)

function MoonFillingMakeView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonFillingMakeUI"
end

function MoonFillingMakeView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonFillingMakeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonFillingMakeView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.menuList_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, MoonFillingMenuItem)
	self.chooseMenuHandler_ = handler(self, self.OnChooseMenu)
end

function MoonFillingMakeView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.makeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not self.curChoosedID_ then
			ShowTips("MID_AUTUMN_FESTIVAL_FILLING_MAKING_MATERIALS_SELECT")

			return
		end

		MoonCakeAction.MakeFilling(self.activityID_, self.curChoosedID_, self.curTimes_)
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		self.curTimes_ = self.curTimes_ + 1

		self:RefreshMakePanel()
	end)
	self:AddBtnListener(self.subBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		self.curTimes_ = self.curTimes_ - 1

		self:RefreshMakePanel()
	end)
	self:AddBtnListener(self.maxBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		self.curTimes_ = self.maxTimes_

		self:RefreshMakePanel()
	end)
end

function MoonFillingMakeView:Dispose()
	self.menuList_:Dispose()

	self.menuList_ = nil
	self.chooseMenuHandler_ = nil

	MoonFillingMakeView.super.Dispose(self)
end

function MoonFillingMakeView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()

	self.materialAnim_.enabled = false
end

function MoonFillingMakeView:OnExit()
	self.curChoosedID_ = nil
end

function MoonFillingMakeView:RefreshUI()
	self.statusController_:SetSelectedState("none")
	self:RefreshMenu()
end

function MoonFillingMakeView:RefreshMenu()
	self.fillingIdList_ = MoonCakeTools.GetSortedFilling(self.activityID_)

	self.menuList_:StartScroll(#self.fillingIdList_)
end

function MoonFillingMakeView:RefreshMakePanel()
	self:RefreshMultiBtn()
	self:RefreshMaterial()

	self.curTimesText_.text = self.curTimes_
	self.makeBtn_.interactable = self.curTimes_ > 0
	self.chooseFillingIcon_.sprite = ItemTools.getItemSprite(MoonCakeFillingCfg[self.curChoosedID_].patties)
	self.chooseFillingNameText_.text = ItemTools.getItemName(MoonCakeFillingCfg[self.curChoosedID_].patties)
	self.chooseFillingNum_.text = string.format(GetTips("ALREADY_HAVE_COUNT"), ItemTools.getItemNum(MoonCakeFillingCfg[self.curChoosedID_].patties))
end

function MoonFillingMakeView:RefreshMultiBtn()
	self.subBtn_.interactable = self.curTimes_ > self.minTimes_
	self.addBtn_.interactable = self.curTimes_ < self.maxTimes_
	self.maxBtn_.interactable = self.curTimes_ < self.maxTimes_
end

function MoonFillingMakeView:RefreshMaterial()
	for iter_18_0, iter_18_1 in ipairs(MoonCakeFillingCfg[self.curChoosedID_].recipe) do
		self[string.format("materialIcon%d_", iter_18_0)].sprite = ItemTools.getItemSprite(iter_18_1[1])
		self[string.format("materialNum%d_", iter_18_0)].text = "X" .. iter_18_1[2] * self.curTimes_
	end
end

function MoonFillingMakeView:IndexItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(self.fillingIdList_[arg_19_1], self.activityID_)
	arg_19_2:SetChooseHandler(self.chooseMenuHandler_)
end

function MoonFillingMakeView:OnChooseMenu(arg_20_1)
	if self.curChoosedID_ == arg_20_1 then
		return
	end

	self.statusController_:SetSelectedState("select")

	local var_20_0 = self.curChoosedID_ == arg_20_1

	self.curChoosedID_ = arg_20_1

	for iter_20_0, iter_20_1 in ipairs((self.menuList_:GetItemList())) do
		iter_20_1:SetSelect(arg_20_1)
	end

	self.maxTimes_, self.minTimes_ = MoonCakeTools.GetFillingMultiTimes(self.curChoosedID_)
	self.curTimes_ = self.minTimes_

	self:RefreshMakePanel()

	if not var_20_0 then
		self.materialAnim_.enabled = true

		self.materialAnim_:Play("Fx_icon_cx", -1, 0)
		self.materialAnim_:Update(0)
	end
end

function MoonFillingMakeView:OnMoonCakeFillingMade()
	self.maxTimes_, self.minTimes_ = MoonCakeTools.GetFillingMultiTimes(self.curChoosedID_)

	if self.minTimes_ > 0 then
		self.curTimes_ = self.minTimes_

		self:RefreshMakePanel()
		self.menuList_:StartScroll(#self.fillingIdList_, (table.indexof(self.fillingIdList_)))
	else
		self:RefreshUI()

		self.curChoosedID_ = nil

		for iter_21_0, iter_21_1 in ipairs((self.menuList_:GetItemList())) do
			iter_21_1:SetSelect(nil)
		end
	end
end

function MoonFillingMakeView:BindRedPoint()
	return
end

function MoonFillingMakeView:UnBindRedPoint()
	return
end

return MoonFillingMakeView
