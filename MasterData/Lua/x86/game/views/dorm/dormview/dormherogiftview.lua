local DormHeroGiftView = class("DormHeroGiftView", ReduxView)

function DormHeroGiftView:UIName()
	return "Widget/BackHouseUI/Dorm/DormGiftFurnitureUI"
end

function DormHeroGiftView:UIParent()
	return manager.ui.uiMain.transform
end

function DormHeroGiftView:OnCtor()
	return
end

function DormHeroGiftView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormHeroGiftView:InitUI()
	self:BindCfgUI()

	self.giftScroll = LuaList.New(handler(self, self.indexItem), self.uilistGo_, FurnitureItem)
	self.multiGiftScroll_ = LuaList.New(handler(self, self.indexItemMulti), self.uilistGo2_, FurnitureItemMulti)
	self.fullController = ControllerUtil.GetController(self.transform_, "state")
	self.btnState = self.btn_okControllerexcollection_:GetController("default0")
	self.multiModeController_ = self.controllerEx_:GetController("selMode")
	self.multiBtnController_ = self.modeControllerEx_:GetController("multiMode")
end

function DormHeroGiftView:OnEnter()
	self.selFurList_ = {}
	self.archiveID = self.params_.archiveID
	self.heroInfo = DormData:GetHeroInfoList()[self.archiveID]

	self:RegisterEvents()

	self.multiModeFlag_ = false

	self:RefreshMultiMode()
	self:RefreshHeroGiftList()
	self:ResetView()

	if not self.heroInfo then
		Debug.LogError("未找到对应角色档案信息")
	end

	if self.params_.heroEID then
		self.heroEID = self.params_.heroEID
	end
end

function DormHeroGiftView:OnExit()
	self.heroEID = nil
	self.selFurID = nil
	self.itemIndex = nil

	self:RemoveAllEventListener()
end

function DormHeroGiftView:indexItem(arg_8_1, arg_8_2)
	local var_8_0 = self.selFurID

	arg_8_2:RefreshUI(self.dataList_[arg_8_1], self.selFurID, DormEnum.FurItemType.Gift, self.archiveID, arg_8_1)
	arg_8_2:OnClickBtn(function(arg_9_0, arg_9_1)
		if var_8_0 == arg_9_0 then
			return
		end

		self.selFurList_ = {}
		self.selFurID = arg_9_0
		self.itemIndex = arg_9_1

		self:RefreshSlider()
		self.giftScroll:Refresh()
	end)
end

function DormHeroGiftView:indexItemMulti(arg_10_1, arg_10_2)
	local var_10_0

	for iter_10_0, iter_10_1 in pairs(self.selFurList_) do
		if iter_10_0 == self.dataList_[arg_10_1] then
			var_10_0 = iter_10_0

			break
		end
	end

	arg_10_2:RefreshUI(self.dataList_[arg_10_1], var_10_0, DormEnum.FurItemType.Gift, self.archiveID, arg_10_1)
	arg_10_2:RefreshCntText(self.selFurList_[var_10_0] or 0, var_10_0 == self.selFurID, DormData:GetHeroInfo(self.archiveID):GetCanGiftNum(self.dataList_[arg_10_1]) > 0)
	arg_10_2:OnClickBtn(function(arg_11_0, arg_11_1)
		if self.selFurID == arg_11_0 then
			return
		end

		self.selFurID = arg_11_0
		self.itemIndex = arg_11_1

		if self.selFurList_[arg_11_0] == nil or self.selFurList_[arg_11_0] == 0 then
			self.selFurList_[arg_11_0] = 1
		end

		self:RefreshSlider()
		self.multiGiftScroll_:Refresh()
	end)
	arg_10_2:OnCancelDown(function(arg_12_0, arg_12_1)
		self.selFurList_[arg_12_0] = 0

		self:RefreshSlider()
		self.multiGiftScroll_:Refresh()
	end)
end

function DormHeroGiftView:RefreshSlider()
	if not self.selFurID then
		return
	end

	local var_13_0 = self.heroInfo:GetCanGiftNum(self.selFurID)

	if var_13_0 <= 0 then
		self.fullController:SetSelectedState("false")

		self.fullText.text = GetTips("DORM_GIFT_MAX_TIPS")
		self.selFurList_[self.selFurID] = 0

		self:RefreshOkBtnState()
	else
		local var_13_1 = 1

		if self.multiModeFlag_ then
			var_13_1 = self.selFurList_[self.selFurID] or 1
		end

		self.selFurList_[self.selFurID] = var_13_1

		self:SetfurNum(var_13_1)

		self.furNumMax = math.max(var_13_0, 1)
		self.progressSlr_.maxValue = self.furNumMax

		self.fullController:SetSelectedState("true")
	end
end

function DormHeroGiftView:RefreshOkBtnState()
	if self:CanGifting() then
		self.btnState:SetSelectedState("on")
	else
		self.btnState:SetSelectedState("off")
	end
end

function DormHeroGiftView:CanGifting()
	for iter_15_0, iter_15_1 in pairs(self.selFurList_) do
		if iter_15_1 > 0 then
			return true
		end
	end

	return false
end

function DormHeroGiftView:RegisterEvents()
	self:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function()
		self.selFurList_ = {}

		if self.multiModeFlag_ then
			self.selFurList_[self.selFurID] = 0
		end

		self:RefreshHeroGiftList()
		self:ResetView(self.multiModeFlag_)
	end)
	self:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function()
		ShowTips(GetTips("DORM_LEVEL_UP_TIPS"))
	end)
end

function DormHeroGiftView:AddUIListener()
	self:AddBtnListenerScale(self.giftBtn_, nil, function()
		if table.length(self.selFurList_) > 0 then
			DormAction:GiftFurToHero(self.archiveID, self.selFurList_, self.heroEID)
		end
	end)
	self:AddBtnListenerScale(self.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddToggleListener(self.progressSlr_, function()
		if self.multiModeFlag_ == false and self.progressSlr_.value < 1 then
			self.progressSlr_.value = 1
		elseif self.multiModeFlag_ and self.progressSlr_.value <= 0 then
			self.progressSlr_.value = 0
		end

		if self.selFurID then
			self:SetfurNum(self.progressSlr_.value)
		end
	end)
	self:AddPressingByTimeListener(self.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if self.multiModeFlag_ == false and self.selFurID and self.progressSlr_.value > 1 then
			self:SetfurNum(self.progressSlr_.value - 1)

			return true
		elseif self.multiModeFlag_ and self.selFurID and self.progressSlr_.value > 0 then
			self:SetfurNum(self.progressSlr_.value - 1)

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.addNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if self.selFurID and self.progressSlr_.value < self.furNumMax then
			self:SetfurNum(self.progressSlr_.value + 1)

			return true
		end

		return false
	end)
	self:AddBtnListenerScale(self.modeBtn_, nil, function()
		local var_25_0 = 0

		for iter_25_0, iter_25_1 in pairs(self.selFurList_) do
			if iter_25_1 > 0 then
				var_25_0 = var_25_0 + 1
			end
		end

		if var_25_0 >= 2 then
			ShowMessageBox({
				content = GetTips("DORM_GIFT_MODE_SWITCH"),
				OkCallback = function()
					self:ClickSwitchMode()
				end,
				CancelCallback = function()
					return
				end
			})
		else
			self:ClickSwitchMode()
		end
	end)
end

function DormHeroGiftView:ClickSwitchMode()
	self.multiModeFlag_ = not self.multiModeFlag_

	self:RefreshMultiMode()
	self:RefreshHeroGiftList()
end

function DormHeroGiftView:RefreshMultiMode()
	self.selFurList_ = {}

	if self.selFurID then
		self.selFurList_[self.selFurID] = 1
	end

	if self.multiModeFlag_ then
		self.multiModeController_:SetSelectedState("multiple")
		self.multiBtnController_:SetSelectedState("on")
	else
		self.multiModeController_:SetSelectedState("single")
		self.multiBtnController_:SetSelectedState("off")
	end

	self:RefreshSlider()
end

function DormHeroGiftView:SetfurNum(arg_30_1)
	self.numText_.text = arg_30_1
	self.progressSlr_.value = arg_30_1
	self.reduceNumBtn_.interactable = multiModeFlag_ and arg_30_1 >= 1 or arg_30_1 > 1
	self.addNumBtn_.interactable = arg_30_1 < self.progressSlr_.maxValue
	self.selFurList_[self.selFurID] = arg_30_1

	if self.multiModeFlag_ then
		self.multiGiftScroll_:Refresh()
	end

	self:RefreshOkBtnState()
end

function DormHeroGiftView:RefreshHeroGiftList()
	self.dataList_ = {}

	for iter_31_0, iter_31_1 in pairs((DormData:GetFurnitureInfoList())) do
		if BackHomeFurniture[iter_31_0].is_give == 1 and iter_31_1.num > iter_31_1.give_num then
			table.insert(self.dataList_, iter_31_0)
		end
	end

	CommonTools.UniversalSortEx(self.dataList_, {
		map = function(arg_32_0)
			if DormData:GetHeroInfo(self.archiveID):GetCanGiftNum(arg_32_0) == 0 then
				return 1
			else
				return 2
			end
		end
	}, {
		ascend = true,
		map = function(arg_33_0)
			return arg_33_0
		end
	})

	if not self.selFurID and #self.dataList_ > 0 then
		self.selFurID = self.dataList_[1]
	end

	if self.multiModeFlag_ == false then
		self.giftScroll:StartScroll(#self.dataList_)

		if self.itemIndex then
			self.giftScroll:ScrollToIndex(self.itemIndex, true, false)
		end

		if #self.dataList_ == 0 then
			self.listText.text = ""

			self.fullController:SetSelectedState("false")
			self.btnState:SetSelectedState("off")
		end
	else
		self.multiGiftScroll_:StartScroll(#self.dataList_)

		if self.itemIndex then
			self.multiGiftScroll_:ScrollToIndex(self.itemIndex, true, false)
		end

		if #self.dataList_ == 0 then
			self.listText.text = ""

			self.fullController:SetSelectedState("false")
			self.btnState:SetSelectedState("off")
		end
	end
end

function DormHeroGiftView:ResetView(arg_34_1)
	if self.selFurID then
		local var_34_0 = false

		for iter_34_0, iter_34_1 in ipairs(self.dataList_) do
			if iter_34_1 == self.selFurID then
				var_34_0 = true

				break
			end
		end

		if not var_34_0 then
			self.fullController:SetSelectedState("false")
			self.btnState:SetSelectedState("off")

			self.fullText.text = ""

			return
		end

		local var_34_1 = self.heroInfo:GetCanGiftNum(self.selFurID)

		if var_34_1 <= 0 then
			self.fullController:SetSelectedState("false")
			self.btnState:SetSelectedState("off")

			self.fullText.text = GetTips("DORM_GIFT_MAX_TIPS")
		else
			self.progressSlr_.minValue = 0
			self.furNumMax = var_34_1
			self.progressSlr_.maxValue = self.furNumMax

			self.fullController:SetSelectedState("true")
			self.btnState:SetSelectedState("on")

			if arg_34_1 then
				self:SetfurNum(0)
			else
				self:SetfurNum(1)
			end
		end
	else
		self.fullController:SetSelectedState("false")
		self.btnState:SetSelectedState("off")

		self.fullText.text = ""
	end
end

function DormHeroGiftView:Dispose()
	if self.giftScroll then
		self.giftScroll:Dispose()
	end

	if self.multiGiftScroll_ then
		self.multiGiftScroll_:Dispose()
	end

	DormHeroGiftView.super.Dispose(self)
end

return DormHeroGiftView
