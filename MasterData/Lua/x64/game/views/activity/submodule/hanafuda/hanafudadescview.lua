local HanafudaDescView = class("HanafudaDescView", ReduxView)

function HanafudaDescView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaScorePopUI"
end

function HanafudaDescView:UIParent()
	return manager.ui.uiPop.transform
end

function HanafudaDescView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HanafudaDescView:InitUI()
	self:BindCfgUI()

	self.pageController_ = ControllerUtil.GetController(self.gameObject_.transform, "page")
	self.rulePageController_ = ControllerUtil.GetController(self.ruleTrs_, "description")
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.combineList_, HanafudaCombineItem)
end

function HanafudaDescView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.ruleBtn_, nil, function()
		self.pageController_:SetSelectedState("1")
	end)
	self:AddBtnListener(self.combineBtn_, nil, function()
		self.pageController_:SetSelectedState("2")
		self.uiList_:StartScroll(#self.combineCfgList_)
	end)
	self:AddBtnListener(self.nextBtn_, nil, function()
		if self.descIndex == 4 then
			return
		end

		self.descIndex = self.descIndex + 1

		self:RefreshDesc()
	end)
	self:AddBtnListener(self.forwardBtn_, nil, function()
		if self.descIndex == 1 then
			return
		end

		self.descIndex = self.descIndex - 1

		self:RefreshDesc()
	end)
end

function HanafudaDescView:OnEnter()
	self.callback_ = self.params_.callback
	self.combineCfgList_ = HanafudaData:GetCombineList()
	self.descIndex = 1

	self:RefreshDesc()
	self:RefreshLiner()
end

function HanafudaDescView:RefreshDesc()
	SetActive(self.forwardBtn_.gameObject, self.descIndex ~= 1)
	SetActive(self.nextBtn_.gameObject, self.descIndex ~= 4)
	self.rulePageController_:SetSelectedState(self.descIndex)
	self.selectItem_.transform:SetSiblingIndex(self.descIndex - 1)
end

function HanafudaDescView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, self.combineCfgList_[arg_13_1])
end

function HanafudaDescView:RefreshLiner()
	self:SetBarPosition(0)

	local var_14_0 = self.sliderBg_.transform.childCount
	local var_14_1 = 4

	for iter_14_0 = 1, 4 < self.sliderBg_.transform.childCount and var_14_0 or var_14_1 do
		if iter_14_0 <= var_14_0 then
			local var_14_2 = self.sliderBg_.transform:GetChild(iter_14_0 - 1)

			if iter_14_0 <= var_14_1 then
				SetActive(var_14_2.gameObject, true)
			else
				SetActive(var_14_2.gameObject, false)
			end
		else
			SetActive(Object.Instantiate(self.barTemp_, self.sliderBg_.transform), true)
		end
	end
end

function HanafudaDescView:SetBarPosition(arg_15_1)
	self.selectItem_.transform:SetSiblingIndex(arg_15_1)
end

function HanafudaDescView:OnExit()
	if self.callback_ then
		self.callback_()
	end
end

function HanafudaDescView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	HanafudaDescView.super.Dispose(self)
end

return HanafudaDescView
