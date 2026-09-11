local ChipSchemeView = class("ChipSchemeView", ReduxView)

function ChipSchemeView:UIName()
	return "Widget/System/MimirChip/MimirPopUI"
end

function ChipSchemeView:UIParent()
	return manager.ui.uiPop.transform
end

function ChipSchemeView:Init()
	self:BindCfgUI()

	self.schemeUIList_ = LuaList.New(handler(self, self.RefreshSchemeItem), self.uiList_, self:GetChipSchemeItem())

	self:AddBtnListener(self.btn_backBtn_, nil, function()
		self:Back()
	end)
end

function ChipSchemeView:OnEnter()
	self.chipManagerID_ = self.params_.chipManagerID
	self.dataTemplate = self.params_.template
	self.sortSchemeList_ = self:GetSchemeList()

	self.schemeUIList_:StartScroll(#self.sortSchemeList_, 1)
	self:RefreshUI()

	self.enabledSchemeHandler_ = handler(self, self.OnEnabledScheme)

	manager.notify:RegistListener(ENABLED_SCHEME, self.enabledSchemeHandler_)

	self.deleteSchemeHandler_ = handler(self, self.OnDeleteScheme)

	manager.notify:RegistListener(DELETE_CHIP_SCHEME, self.deleteSchemeHandler_)

	self.saveHandler_ = handler(self, self.OnSaveChipScheme)

	manager.notify:RegistListener(SAVE_CHIP_SCHEME, self.saveHandler_)
end

function ChipSchemeView:OnExit()
	manager.notify:RemoveListener(ENABLED_SCHEME, self.enabledSchemeHandler_)

	self.enabledSchemeHandler_ = nil

	manager.notify:RemoveListener(DELETE_CHIP_SCHEME, self.deleteSchemeHandler_)

	self.deleteSchemeHandler_ = nil

	manager.notify:RemoveListener(SAVE_CHIP_SCHEME, self.saveHandler_)

	self.saveHandler_ = nil
	self.useIndex = nil
end

function ChipSchemeView:RefreshSchemeItem(arg_7_1, arg_7_2)
	arg_7_2:SetTemplateData(self.dataTemplate)
	arg_7_2:RefreshUI(self.chipManagerID_, arg_7_1, self.sortSchemeList_[arg_7_1], self.useIndex)
end

function ChipSchemeView:RefreshUI()
	self.numText_.text = string.format("%s/%s", table.length((ChipData:GetSchemeList())), GameSetting.ai_chip_proposal_num_max.value[1])
end

function ChipSchemeView:GetChipSchemeItem()
	return ChipSchemeItem
end

function ChipSchemeView:GetSchemeList()
	local var_10_0 = ChipTools.SortScheme(self.chipManagerID_)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1.id == 0 then
			self.useIndex = 1
		end
	end

	return var_10_0
end

function ChipSchemeView:GetSchemeList()
	local var_11_0 = self:GetEquipChipList()
	local var_11_1 = {
		{
			id = 0,
			name = GetTips("CURRENT_SCHEME"),
			chipList = var_11_0
		}
	}

	for iter_11_0, iter_11_1 in pairs((ChipData:GetSchemeList())) do
		local var_11_2 = #var_11_0 == #iter_11_1.chipList

		for iter_11_2, iter_11_3 in ipairs(iter_11_1.chipList) do
			if not table.keyof(var_11_0, iter_11_3) then
				var_11_2 = false

				break
			end
		end

		if var_11_2 then
			var_11_1[1] = clone(iter_11_1)
		else
			table.insert(var_11_1, clone(iter_11_1))
		end
	end

	for iter_11_4, iter_11_5 in ipairs(var_11_1) do
		if iter_11_5.id == 0 then
			self.useIndex = 1
		end
	end

	return var_11_1
end

function ChipSchemeView:GetEquipChipList()
	print("ChipSchemeView  GetEquipChipList")

	return self.dataTemplate:GetEquipChipList()
end

function ChipSchemeView:OnEnabledScheme()
	self.useIndex = nil

	self:OnDeleteScheme()
end

function ChipSchemeView:OnDeleteScheme()
	self.sortSchemeList_ = self:GetSchemeList()

	self.schemeUIList_:StartScroll(#self.sortSchemeList_)
	self:RefreshUI()
end

function ChipSchemeView:OnSaveChipScheme(arg_15_1)
	self.useIndex = nil
	self.sortSchemeList_ = self:GetSchemeList()

	self.schemeUIList_:StartScroll(#self.sortSchemeList_)
	self:RefreshUI()
end

function ChipSchemeView:Dispose()
	ChipSchemeView.super.Dispose(self)

	if self.schemeUIList_ then
		self.schemeUIList_:Dispose()

		self.schemeUIList_ = nil
	end
end

return ChipSchemeView
