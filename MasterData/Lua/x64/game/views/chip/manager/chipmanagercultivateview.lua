local ChipManagerCultivateView = class("ChipManagerCultivateView", ReduxView)

function ChipManagerCultivateView:UIName()
	return "Widget/System/MimirChip/MimirChipCultivateUI"
end

function ChipManagerCultivateView:UIParent()
	return manager.ui.uiMain.transform
end

function ChipManagerCultivateView:Init()
	self.isBattle = false
	self.tabIndex = 1

	self:BindCfgUI()

	self.iconImg_.immediate = true

	self:AddListeners()

	self.chipManagerUIList_ = LuaList.New(handler(self, self.RefreshChipManagerItem), self.uiList_, self:GetChipManagerItem())
	self.chipUIList_ = LuaList.New(handler(self, self.RefreshChipItem), self.chipuilistUilist_, self:GetChipItem())
	self.chipManagerInfoView_ = self:GetChipManagerInfoView().New(self.panelGo_, self)
	self.chipInfoView_ = self:GetChipInfoView().New(self.panel2Go_, self)
	self.isbattleControl = self.leftControllerexcollection_:GetController("is_BattleSet")
	self.leftSelectControl = self.contentControllerexcollection_:GetController("select")
end

function ChipManagerCultivateView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back(1, {
			isSorted = true
		})
	end)

	self.handler_ = handler(self, self.OnUnlockChipManager)

	manager.notify:RegistListener(UNLOCK_CHIP_MANAGER, self.handler_)

	self.unlockChipHandler_ = handler(self, self.OnUnlockChip)

	manager.notify:RegistListener(UNLOCK_CHIP, self.unlockChipHandler_)

	self.chipManagerList_ = self:GetChipManagerList()
	self.defaultSelectID_ = self.params_.chipManagerID or self.chipManagerList_[1]
	self.chipManagerDataTemplate_ = ChipManagerDataTemplate.New({
		id = self.defaultSelectID_,
		unlockChipManagerIDList_ = ChipData:GetUnlockChipManagerIDList(),
		unlockChipIDList_ = ChipData:GetUnlockChipIDList()
	})

	self.chipManagerUIList_:StartScroll(#self.chipManagerList_, table.keyof(self.chipManagerList_, self.defaultSelectID_))

	self.chipList_ = self:GetChipTypeCntList() or {}

	self.chipUIList_:StartScroll(#self.chipList_)

	self.clickItemHandler_ = handler(self, self.OnClickChipItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_ITEM, self.clickItemHandler_)

	self.defaultSelectChipID_ = self.params_.chipID or self.chipList_[1]

	self:RefreshUI()
	self.chipManagerUIList_:Refresh()
	self.chipUIList_:Refresh()
end

function ChipManagerCultivateView:OnUpdate()
	self.defaultSelectID_ = self.params_.chipManagerID or self.chipManagerList_[1]

	self:RefreshUI()
	self.chipManagerUIList_:Refresh()
	self.chipUIList_:Refresh()
end

function ChipManagerCultivateView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_CHIP_MANAGER, self.handler_)

	self.handler_ = nil

	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, self.clickItemHandler_)
	manager.notify:RemoveListener(UNLOCK_CHIP, self.unlockChipHandler_)

	self.clickItemHandler_ = nil

	if self.chipManagerInfoView_ then
		self.chipManagerInfoView_:OnExit()
	end

	if self.chipInfoView_ then
		self.chipInfoView_:OnExit()
	end

	manager.redPoint:unbindUIandKey(self.notice1_)
	manager.redPoint:unbindUIandKey(self.notice2_)
end

function ChipManagerCultivateView:AddListeners()
	self:AddBtnListener(self.mimirBtn_, nil, function()
		self.leftSelectControl:SetSelectedState("state0")

		self.tabIndex = 1

		self:UpdateRightView(self.tabIndex)
	end)
	self:AddBtnListener(self.mimirchipBtn_, nil, function()
		self.leftSelectControl:SetSelectedState("state1")

		self.tabIndex = 2

		self:UpdateRightView(self.tabIndex)
	end)
end

function ChipManagerCultivateView:UpdateRightView(arg_11_1)
	self.curIndex = arg_11_1

	local var_11_0 = ({
		self.chipManagerInfoView_,
		self.chipInfoView_
	})[self.curIndex]

	if var_11_0 and var_11_0.Enter then
		var_11_0:Enter()
	end

	if var_11_0 and var_11_0.RefreshData then
		if var_11_0.SetTemplateData then
			var_11_0:SetTemplateData(self.chipManagerDataTemplate_)
		end

		var_11_0:RefreshData(({
			self.defaultSelectID_,
			self.defaultSelectChipID_
		})[self.curIndex])
	end
end

function ChipManagerCultivateView:OnClickChipItem(arg_12_1)
	self.defaultSelectChipID_ = arg_12_1

	self:Go("/chipManager", {
		chipManagerID = self.defaultSelectID_,
		chipID = arg_12_1,
		defaultSelectChipID_ = self.chipManagerID_
	})
end

function ChipManagerCultivateView:RefreshUI()
	self:UpdateRightView(self.tabIndex)

	self.iconImg_.spriteSync = "TextureConfig/Managecat_l/" .. ChipCfg[self.defaultSelectID_].picture_id
	self.numText1_.text = string.format("%s/%s", #(self.chipManagerDataTemplate_.unlockChipManagerIDList_ or {}) or 0, #(self.chipManagerList_ or {}) or 0)
	self.numText2_.text = string.format("%s/%s", #(self.chipManagerDataTemplate_.unlockChipIDList_ or {}), #(self.chipList_ or {}))

	manager.redPoint:bindUIandKey(self.notice1_, RedPointConst.CHIP_MANAGER_CHIP, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(self.notice2_, RedPointConst.CHIP_CHIP, {
		x = 0,
		y = 0
	})
end

function ChipManagerCultivateView:OnUnlockChipManager()
	self:RefreshUI()
	self.chipManagerUIList_:Refresh()
end

function ChipManagerCultivateView:OnUnlockChip()
	self:RefreshUI()
	self.chipUIList_:Refresh()
end

function ChipManagerCultivateView:RefreshChipManagerItem(arg_16_1, arg_16_2)
	local var_16_0 = self.chipManagerList_[arg_16_1]

	arg_16_2:SetTemplateData(self.chipManagerDataTemplate_)
	arg_16_2:SetChipManagerID(var_16_0)
	arg_16_2:RefreshUI(var_16_0 == self.defaultSelectID_)
end

function ChipManagerCultivateView:RefreshChipItem(arg_17_1, arg_17_2)
	arg_17_2:SetTemplateData(self.chipManagerDataTemplate_)
	arg_17_2:SetChipID(self.chipList_[arg_17_1])
	arg_17_2:RefreshUI(self.defaultSelectChipID_)
end

function ChipManagerCultivateView:Dispose()
	ChipManagerCultivateView.super.Dispose(self)

	if self.chipInfoView_ then
		self.chipInfoView_:Dispose()

		self.chipInfoView_ = nil
	end

	if self.chipManagerInfoView_ then
		self.chipManagerInfoView_:Dispose()

		self.chipManagerInfoView_ = nil
	end

	if self.chipManagerUIList_ then
		self.chipManagerUIList_:Dispose()

		self.chipManagerUIList_ = nil
	end

	if self.chipUIList_ then
		self.chipUIList_:Dispose()

		self.chipUIList_ = nil
	end
end

function ChipManagerCultivateView:GetChipManagerList()
	return ChipTools.SortChipManager((ChipData:GetEnabledChipManagerID()))
end

function ChipManagerCultivateView:GetUnlockChipManagerList()
	return ChipData:GetUnlockChipManagerIDList()
end

function ChipManagerCultivateView:GetChipTypeCntList()
	local var_21_0 = ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]

	if manager.guide:IsPlaying() then
		table.sort(var_21_0, function(arg_22_0, arg_22_1)
			return arg_22_0 == 105
		end)
	else
		table.sort(var_21_0, function(arg_23_0, arg_23_1)
			if self.chipManagerDataTemplate_ then
				local var_23_0 = ChipTools.GetChipCanLocked(arg_23_0) and 1 or 0
				local var_23_1 = ChipTools.GetChipCanLocked(arg_23_1) and 1 or 0
				local var_23_2 = self.chipManagerDataTemplate_:GetIsUnlockChip(arg_23_0) and 2 or var_23_0
				local var_23_3 = self.chipManagerDataTemplate_:GetIsUnlockChip(arg_23_1) and 2 or var_23_1

				if var_23_2 ~= var_23_3 then
					return var_23_3 < var_23_2
				end
			end

			return arg_23_0 < arg_23_1
		end)
	end

	return var_21_0
end

function ChipManagerCultivateView:GetManagerUnlockView()
	return ChipManagerUnlockView
end

function ChipManagerCultivateView:GetChipManagerItem()
	return ChipManagerItem
end

function ChipManagerCultivateView:GetChipItem()
	return ChipItem
end

function ChipManagerCultivateView:GetChipManagerInfoView()
	return MimirChipManagerInfoView
end

function ChipManagerCultivateView:GetChipInfoView()
	return MimirChipInfoView
end

function ChipManagerCultivateView:RecordStay(arg_29_1)
	if arg_29_1 == "1" then
		OperationRecorder.RecordStayView("STAY_VIEW_AI_STORY", math.floor((Time.realtimeSinceStartup - self.storyTime) * 1000), self.defaultSelectID_)
	end

	self.storyTime = Time.realtimeSinceStartup
end

return ChipManagerCultivateView
