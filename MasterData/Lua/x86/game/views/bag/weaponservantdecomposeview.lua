local WeaponServantDecomposeView = class("WeaponServantDecomposeView", ReduxView)

function WeaponServantDecomposeView:UIName()
	return "Widget/System/Bag/SplitServantUI"
end

function WeaponServantDecomposeView:UIParent()
	return manager.ui.uiMain.transform
end

function WeaponServantDecomposeView:Init()
	self.rewardIndex_ = 0
	self.rewardItems_ = {}

	self:InitUI()
	self:AddUIListener()
end

function WeaponServantDecomposeView:InitUI()
	self:BindCfgUI()

	self.servantDetailView_ = WeaponServantMainDetailModule.New(self.servantDetailGo_)

	self.servantDetailView_:SwitchBtnStyle(4)

	self.servantItemList_ = LuaList.New(handler(self, self.indexServantItem), self.uiListGo_, CommonItemView)
	self.returnItemList_ = LuaList.New(handler(self, self.indexRewardItem), self.returnItemListGo_, CommonItemView)
	self.previewController_ = self.controllerEx_:GetController("preview")
	self.emptyController_ = self.controllerEx_:GetController("empty")
	self.btnController_ = self.controllerEx_:GetController("btnState")
	self.orderController_ = self.orderCon_:GetController("sort")
	self.filterController_ = self.filterCon_:GetController("color")
	self.starToggle_ = {}

	for iter_4_0 = 3, 4 do
		self.starToggle_[iter_4_0] = self["toggle_" .. iter_4_0]
	end
end

function WeaponServantDecomposeView:AddUIListener()
	self:AddBtnListener(self.btnShowFilter_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Decompose_Servant_Filter_List
		})
	end)
	self:AddToggleListener(self.dropDown_, function(arg_7_0)
		self.priority_ = arg_7_0 == 0 and 1 or 0

		self:RefreshData()
	end)
	self:AddBtnListener(self.btnOrder_, nil, function()
		self.order_ = self.order_ == 0 and 1 or 0

		self.orderController_:SetSelectedState(self.order_ == 0 and "up" or "down")
		self:RefreshData()
	end)

	for iter_5_0 = 3, 4 do
		self:AddToggleListener(self.starToggle_[iter_5_0], function(arg_9_0)
			self:QuickSelectServant(iter_5_0, arg_9_0)
		end)
	end

	self:AddBtnListener(self.btnShowPreview_, nil, function()
		self:RefreshRewardItem()
		self.previewController_:SetSelectedState("show")
	end)
	self:AddBtnListener(self.btnPreviewMask_, nil, function()
		self.previewController_:SetSelectedState("hide")
	end)
	self:AddBtnListener(self.btnConfirm_, nil, function()
		if self.currentSelectNum_ > 0 then
			self:RefreshRewardItem()
			JumpTools.OpenPageByJump("decomposeConfirmPop", {
				type = "servant",
				itemList = self.usedServantList_,
				returnList = self.rewardList_
			})
		end
	end)
end

function WeaponServantDecomposeView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})

	self.refreshSelectIndex_ = 1
	self.usedServantList_ = {}
	self.currentSelectNum_ = 0
	self.priority_ = 1
	self.order_ = 1

	self:Render()
	self:RenderFilterBtn()
	self.filterController_:SetSelectedState("normal")
	self.previewController_:SetSelectedState("hide")
	self:RegistEventListener(COMMON_FILTER_OK, handler(self, self.OnFilterChange))
end

function WeaponServantDecomposeView:Render()
	self:RefreshData()
end

function WeaponServantDecomposeView:RefreshData()
	self.itemList_ = ServantTools:GetServantList(nil, ServantTools.GetWeaponShowData(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id, {
		hideEquip = true,
		hideLock = true,
		hideStar = {
			5
		}
	}), nil, self.priority_, self.order_)
	self.totalNum_ = #self.itemList_
	self.selectNum_.text = string.format("%s/%s", self.currentSelectNum_, self.totalNum_)

	self.servantItemList_:StartScroll(#self.itemList_)
	self.emptyController_:SetSelectedState(#self.itemList_ > 0 and "show" or "hide")
end

function WeaponServantDecomposeView:RefreshRightInfo(arg_16_1, arg_16_2)
	if self.selectedItem_ then
		self.selectedItem_:RefreshSelectState2(false)
	end

	arg_16_1:RefreshSelectState2(true)

	self.selectedItem_ = arg_16_1

	self.servantDetailView_:OnRenderServant(arg_16_2)
	SetActive(self.servantDetailView_.lockBtn_.gameObject, false)
end

function WeaponServantDecomposeView:RefreshRewardItem()
	self.rewardList_ = next(self.usedServantList_) ~= nil and ServantTools.GetServantDecomposeRewardItem(self.usedServantList_) or {}

	self.returnItemList_:StartScroll(#self.rewardList_)
end

function WeaponServantDecomposeView:indexServantItem(arg_18_1, arg_18_2)
	local var_18_0 = clone(ItemTemplateData)
	local var_18_1 = self.itemList_[arg_18_1]

	var_18_0.id = self.itemList_[arg_18_1].id
	var_18_0.uid = var_18_1.uid
	var_18_0.addLevel = WeaponServantData:GetServantDataByUID(var_18_1.uid).stage

	function var_18_0:clickFun()
		self:RefreshRightInfo(arg_18_2, var_18_1)

		if self.usedServantList_[self.uid] then
			arg_18_2:RefreshSelectState(false)

			self.usedServantList_[self.uid] = nil
			self.currentSelectNum_ = self.currentSelectNum_ - 1

			self:CheckToggleState(var_18_1)
		else
			arg_18_2:RefreshSelectState(true)

			self.usedServantList_[self.uid] = var_18_1
			self.currentSelectNum_ = self.currentSelectNum_ + 1
		end

		self.btnController_:SetSelectedState(self.currentSelectNum_ > 0 and "split" or "grey")

		self.selectNum_.text = string.format("%s/%s", self.currentSelectNum_, self.totalNum_)
	end

	arg_18_2:SetData(var_18_0)
	arg_18_2:RefreshSelectState(self.usedServantList_[var_18_1.uid] ~= nil)

	if self.refreshSelectIndex_ == arg_18_1 then
		self:RefreshRightInfo(arg_18_2, var_18_1)
	end
end

function WeaponServantDecomposeView:indexRewardItem(arg_20_1, arg_20_2)
	local var_20_0 = clone(ItemTemplateData)

	var_20_0.id = self.rewardList_[arg_20_1].id
	var_20_0.number = self.rewardList_[arg_20_1].number

	arg_20_2:SetData(var_20_0)
end

function WeaponServantDecomposeView:CheckToggleState(arg_21_1)
	if not self.usedServantList_[arg_21_1.uid] and self.starToggle_[ItemCfg[arg_21_1.id].display_rare].isOn then
		self.unSelectItem_ = arg_21_1
		self.starToggle_[ItemCfg[arg_21_1.id].display_rare].isOn = false
	end
end

function WeaponServantDecomposeView:QuickSelectServant(arg_22_1, arg_22_2)
	if arg_22_2 then
		for iter_22_0, iter_22_1 in ipairs(self.itemList_) do
			if WeaponServantCfg[iter_22_1.id].starlevel == arg_22_1 and iter_22_1.stage == 1 then
				if self.usedServantList_[iter_22_1.uid] == nil then
					self.currentSelectNum_ = self.currentSelectNum_ + 1
				end

				self.usedServantList_[iter_22_1.uid] = iter_22_1
			end
		end
	elseif self.unSelectItem_ then
		self.usedServantList_[self.unSelectItem_.uid] = nil
		self.unSelectItem_ = nil
	else
		for iter_22_2, iter_22_3 in pairs(self.usedServantList_) do
			if WeaponServantCfg[iter_22_3.id].starlevel == arg_22_1 then
				self.usedServantList_[iter_22_2] = nil
				self.currentSelectNum_ = self.currentSelectNum_ - 1
			end
		end
	end

	self:RefreshSelect()
end

function WeaponServantDecomposeView:RefreshSelect()
	for iter_23_0, iter_23_1 in pairs(self.servantItemList_:GetItemList()) do
		iter_23_1:RefreshSelectState(self.usedServantList_[iter_23_1:GetData().uid] ~= nil)
	end

	self.selectNum_.text = string.format("%s/%s", self.currentSelectNum_, self.totalNum_)

	self.btnController_:SetSelectedState(self.currentSelectNum_ > 0 and "split" or "grey")
end

function WeaponServantDecomposeView:OnServantDecomposeResult(arg_24_1, arg_24_2)
	getReward2(mergeReward2(arg_24_1.return_list))

	self.refreshSelectIndex_ = 1

	self:ClearSelect()
	self:Render()
end

function WeaponServantDecomposeView:ClearSelect()
	self.usedServantList_ = {}
	self.currentSelectNum_ = 0

	self.btnController_:SetSelectedState("grey")

	for iter_25_0, iter_25_1 in pairs(self.starToggle_) do
		iter_25_1.isOn = false
	end
end

function WeaponServantDecomposeView:OnFilterChange()
	self:ClearSelect()
	self:Render()
	self:RenderFilterBtn()
end

function WeaponServantDecomposeView:RenderFilterBtn()
	if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id) then
		self.filterController_:SetSelectedState("orange")
	else
		self.filterController_:SetSelectedState("normal")
	end
end

function WeaponServantDecomposeView:OnExit()
	CommonFilterData:ClearFilter(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id)

	for iter_28_0, iter_28_1 in pairs(self.starToggle_) do
		iter_28_1.isOn = false
	end

	manager.windowBar:HideBar()
end

function WeaponServantDecomposeView:Dispose()
	self:RemoveAllListeners()
	self.servantItemList_:Dispose()
	self.returnItemList_:Dispose()
	self.servantDetailView_:Dispose()
	WeaponServantDecomposeView.super.Dispose(self)
end

return WeaponServantDecomposeView
