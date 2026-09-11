local EquipRecView = class("EquipRecView", ReduxView)

function EquipRecView:UIName()
	return "UI/Equip/NewEquipRecommendUI"
end

function EquipRecView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipRecView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function EquipRecView:InitUI()
	self:BindCfgUI()

	self.items_ = {}
	self.list_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, EquipRecGroupItem)
end

function EquipRecView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.equipRecIdList_[arg_5_1], self.heroId_)
end

function EquipRecView:AddUIListeners()
	self.list_:SetPageChangeHandler(handler(self, self.OnPageChange))
	self:AddBtnListener(self.prevBtn_, nil, function()
		self.list_:SwitchToPage(self.pageIndex_ - 1)
	end)
	self:AddBtnListener(self.nextBtn_, nil, function()
		self.list_:SwitchToPage(self.pageIndex_ + 1)
	end)
end

function EquipRecView:RemoveUIListeners()
	self.list_:SetPageChangeHandler(nil)
end

function EquipRecView:OnPageChange(arg_10_1)
	self.pageIndex_ = arg_10_1
	self.params_.pageIndex = arg_10_1

	SetActive(self.prevBtn_.gameObject, arg_10_1 > 1)
	SetActive(self.nextBtn_.gameObject, arg_10_1 < 3)

	if self.params_.onPageChange then
		self.params_.onPageChange(arg_10_1)
	end
end

function EquipRecView:OnEnter()
	self.heroId_ = self.params_.hid
	self.cfg = EquipRecommendCfg[self.heroId_]
	self.equipRecIdList_ = {
		self.cfg.equip_list1,
		self.cfg.equip_list2,
		self.cfg.equip_list3
	}

	if self.params_.pageIndex ~= nil and self.params_.pageIndex > 0 then
		self.list_:StartScroll(3, self.params_.pageIndex, true, false)
		self.list_:SwitchToPage(self.params_.pageIndex)
	else
		self.list_:StartScroll(3, 1, true, false)
		self.list_:SwitchToPage(1)
	end
end

function EquipRecView:OnAddProposal()
	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function EquipRecView:OnMainHomeViewTop()
	self.params_.pageIndex = nil
end

function EquipRecView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self.params_.index = 1

		self:Back()

		self.scrollPos_ = nil
	end)
end

function EquipRecView:OnExit()
	manager.windowBar:HideBar()
end

function EquipRecView:Dispose()
	self:RemoveUIListeners()
	self:RemoveAllListeners()

	if self.items_ then
		for iter_17_0, iter_17_1 in ipairs(self.items_) do
			iter_17_1:Dispose()
		end

		self.items_ = nil
	end

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	EquipRecView.super.Dispose(self)
end

return EquipRecView
