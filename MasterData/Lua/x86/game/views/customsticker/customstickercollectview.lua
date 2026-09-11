local CustomStickerCollectView = class("CustomStickerCollectView", ReduxView)

function CustomStickerCollectView:UIName()
	return "Widget/System/UserInfor/sticker_new/StickerCollectUI"
end

function CustomStickerCollectView:UIParent()
	return manager.ui.uiMain.transform
end

function CustomStickerCollectView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CustomStickerCollectView:InitUI()
	self:BindCfgUI()

	self.mainPageNum_ = 1
	self.subPageNum_ = 1
	self.tabFilterPanel_ = CustomStickerFilterPanel.New(self.filterPanelGo_)
	self.tabFilterSuitMap_ = {}
	self.filterGetState_ = 0
	self.filterDescendState_ = true
	self.filterMap_ = {}
	self.filterState_ = false
	self.rightListData_ = {}
	self.suitList_ = LuaList.New(handler(self, self.IndexSuitItem), self.suitUIList_, CustomStickerCollectSuitItem)
	self.stList_ = LuaList.New(handler(self, self.IndexListItem), self.stUIList_, CustomStickerListItem)
	self.fgList_ = LuaList.New(handler(self, self.IndexListItem), self.fgUIList_, CustomStickerListItem)
	self.bgList_ = LuaList.New(handler(self, self.IndexListItem), self.bgUIList_, CustomStickerListItem)
	self.mainTabController_ = self.mainControllerEx_:GetController("mainTab")
	self.subTabController_ = self.mainControllerEx_:GetController("subTab")
	self.collectController_ = self.mainControllerEx_:GetController("collect")
	self.colorController_ = self.filterController_:GetController("color")
	self.sortController_ = self.orderControllerEx_:GetController("sort")

	self:InitDropdownData()
end

function CustomStickerCollectView:InitDropdownData()
	self.filterDd_.options:Clear()
	self.filterDd_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("ALL"), nil))
	self.filterDd_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("ACQUIRED"), nil))
	self.filterDd_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("NOTACQUIRED"), nil))
	self.filterDd_:RefreshShownValue()
end

function CustomStickerCollectView:AddUIListeners()
	self:AddBtnListener(self.main1Btn_, nil, function()
		if self.mainPageNum_ ~= 1 then
			PlayerData:ClearStickerCollectPageRedPoint(self.subPageNum_)
			self:RefreshMainPage(1)
		end
	end)
	self:AddBtnListener(self.main2Btn_, nil, function()
		if self.mainPageNum_ ~= 2 then
			PlayerData:ClearStickerCollectPageRedPoint(0)
			self:RefreshMainPage(2)
		end
	end)

	for iter_6_0 = 1, 3 do
		self:AddBtnListener(self["sub" .. iter_6_0 .. "Btn_"], nil, function()
			if self.subPageNum_ ~= iter_6_0 then
				PlayerData:ClearStickerCollectPageRedPoint(self.subPageNum_)
				self:RefreshSubPage(iter_6_0)
			end
		end)
	end

	self:AddBtnListener(self.filterBtn_, nil, function()
		self.tabFilterPanel_:OpenPanel()
	end)
	self:AddBtnListener(self.orderBtn_, nil, function()
		if self.filterDescendState_ then
			self.filterDescendState_ = false

			self.sortController_:SetSelectedState("up")
			self:RefreshSubPage(self.subPageNum_)
		else
			self.filterDescendState_ = true

			self.sortController_:SetSelectedState("down")
			self:RefreshSubPage(self.subPageNum_)
		end
	end)
	self:AddBtnListener(self.tipsBtn_, nil, function()
		if self.collectController_:GetSelectedState() == "close" then
			self.collectController_:SetSelectedState("open")
		elseif self.collectController_:GetSelectedState() == "open" then
			self.collectController_:SetSelectedState("close")
		end
	end)
	self:AddToggleListener(self.filterDd_, function(arg_13_0)
		self.filterGetState_ = arg_13_0

		self:RefreshSubPage(self.subPageNum_)
	end)
end

function CustomStickerCollectView:IndexSuitItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.rightListData_[arg_14_1])
end

function CustomStickerCollectView:IndexListItem(arg_15_1, arg_15_2)
	local var_15_0 = ProfileDecorateItemCfg[self.rightListData_[arg_15_1]]
	local var_15_1 = false
	local var_15_2 = false
	local var_15_3 = true
	local var_15_4 = false
	local var_15_5

	if self.subPageNum_ == 1 then
		var_15_4 = PlayerData:GetSticker(self.rightListData_[arg_15_1]).lock

		function var_15_5()
			JumpTools.OpenPageByJump("customStickerCollectPop", {
				stickerID = var_15_0.id
			})
		end
	elseif self.subPageNum_ == 2 then
		var_15_4 = PlayerData:GetStickerBg(self.rightListData_[arg_15_1]).lock

		function var_15_5()
			JumpTools.OpenPageByJump("customStickerCollectPop", {
				stickerID = var_15_0.id
			})
		end
	elseif self.subPageNum_ == 3 then
		var_15_4 = PlayerData:GetStickerFg(self.rightListData_[arg_15_1]).lock

		function var_15_5()
			JumpTools.OpenPageByJump("customStickerCollectPop", {
				stickerID = var_15_0.id
			})
		end
	end

	arg_15_2:SetData(var_15_0, var_15_1, var_15_2, var_15_3, var_15_4, false, var_15_5, true)
end

function CustomStickerCollectView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.filterMap_ = {}
	self.filterState_ = false

	self.colorController_:SetSelectedState("normal")
	self.tabFilterPanel_:SetData(StickerSuitCfg.all, function(arg_20_0, arg_20_1)
		self.filterMap_ = arg_20_0
		self.filterState_ = not arg_20_1

		self.colorController_:SetSelectedState(self.filterState_ and "orange" or "normal")
		self:RefreshSubPage(self.subPageNum_)
	end)
	self:RefreshMainPage(1)
	self:RefreshCollectTips()
	manager.redPoint:bindUIandKey(self.main1Btn_.transform, RedPointConst.CUSTOM_STICKER_SUIT_REWARD)
	manager.redPoint:bindUIandKey(self.main2Btn_.transform, RedPointConst.CUSTOM_STICKER_CATEGORY)
	manager.redPoint:bindUIandKey(self.sub1Btn_.transform, RedPointConst.CUSTOM_STICKER_ST)
	manager.redPoint:bindUIandKey(self.sub2Btn_.transform, RedPointConst.CUSTOM_STICKER_BG)
	manager.redPoint:bindUIandKey(self.sub3Btn_.transform, RedPointConst.CUSTOM_STICKER_FG)
end

function CustomStickerCollectView:RefreshCollectTips()
	local var_21_0 = #PlayerData:GetStickerList(true)
	local var_21_1 = #PlayerData:GetStickerList()
	local var_21_2 = #PlayerData:GetStickerBgList(true)
	local var_21_3 = #PlayerData:GetStickerBgList()
	local var_21_4 = #PlayerData:GetStickerFgList(true)
	local var_21_5 = #PlayerData:GetStickerFgList()

	self.stNumText_.text = var_21_1 .. "/" .. var_21_0
	self.bgNumText_.text = var_21_3 .. "/" .. var_21_2
	self.fgNumText_.text = var_21_5 .. "/" .. var_21_4
	self.percentText_.text = math.floor((var_21_1 + var_21_3 + var_21_5) / (var_21_0 + var_21_2 + var_21_4) * 100) .. "%"
	self.progressText_.text = var_21_1 + var_21_3 + var_21_5 .. "/" .. var_21_0 + var_21_2 + var_21_4
end

function CustomStickerCollectView:RefreshMainPage(arg_22_1)
	self.mainPageNum_ = arg_22_1

	self.mainTabController_:SetSelectedState(tostring(arg_22_1))

	if arg_22_1 == 1 then
		self.rightListData_ = StickerSuitCfg.all

		table.sort(self.rightListData_, function(arg_23_0, arg_23_1)
			return arg_23_1 < arg_23_0
		end)
		self.suitList_:StartScroll(#self.rightListData_)
	elseif arg_22_1 == 2 then
		self:RefreshSubPage(1)
	end
end

function CustomStickerCollectView:RefreshSubPage(arg_24_1)
	self.subPageNum_ = arg_24_1

	self.subTabController_:SetSelectedState(tostring(arg_24_1))

	if arg_24_1 == 1 then
		self.rightListData_ = {}

		local var_24_0 = {}

		if self.filterGetState_ == 0 then
			var_24_0 = PlayerData:GetStickerList(true)
		elseif self.filterGetState_ == 1 then
			var_24_0 = PlayerData:GetStickerList()
		elseif self.filterGetState_ == 2 then
			var_24_0 = PlayerData:GetStickerList(false, true)
		end

		if self.filterState_ then
			for iter_24_0, iter_24_1 in pairs(var_24_0) do
				if self.filterMap_[PlayerData:GetSticker(iter_24_1).suit] then
					table.insert(self.rightListData_, iter_24_1)
				end
			end
		else
			self.rightListData_ = var_24_0
		end

		if self.filterDescendState_ then
			table.sort(self.rightListData_, function(arg_25_0, arg_25_1)
				local var_25_0 = PlayerData:GetSticker(arg_25_1)

				if PlayerData:GetSticker(arg_25_0).lock == var_25_0.lock then
					return arg_25_1 < arg_25_0
				end

				return var_25_0.lock
			end)
		else
			table.sort(self.rightListData_, function(arg_26_0, arg_26_1)
				local var_26_0 = PlayerData:GetSticker(arg_26_1)

				if PlayerData:GetSticker(arg_26_0).lock == var_26_0.lock then
					return arg_26_0 < arg_26_1
				end

				return var_26_0.lock
			end)
		end

		self.stList_:StartScroll(#self.rightListData_)
	elseif arg_24_1 == 2 then
		self.rightListData_ = {}

		local var_24_1 = {}

		if self.filterGetState_ == 0 then
			var_24_1 = PlayerData:GetStickerBgList(true)
		elseif self.filterGetState_ == 1 then
			var_24_1 = PlayerData:GetStickerBgList()
		elseif self.filterGetState_ == 2 then
			var_24_1 = PlayerData:GetStickerBgList(false, true)
		end

		if self.filterState_ then
			for iter_24_2, iter_24_3 in pairs(var_24_1) do
				if self.filterMap_[PlayerData:GetStickerBg(iter_24_3).suit] then
					table.insert(self.rightListData_, iter_24_3)
				end
			end
		else
			self.rightListData_ = var_24_1
		end

		local var_24_2 = GameSetting.sticker_background_default.value[1]

		if self.filterDescendState_ then
			table.sort(self.rightListData_, function(arg_27_0, arg_27_1)
				local var_27_0 = PlayerData:GetStickerBg(arg_27_1)

				if PlayerData:GetStickerBg(arg_27_0).lock == var_27_0.lock then
					if arg_27_0 == var_24_2 then
						return false
					end

					if arg_27_1 == var_24_2 then
						return true
					end

					return arg_27_1 < arg_27_0
				end

				return var_27_0.lock
			end)
		else
			table.sort(self.rightListData_, function(arg_28_0, arg_28_1)
				local var_28_0 = PlayerData:GetStickerBg(arg_28_1)

				if PlayerData:GetStickerBg(arg_28_0).lock == var_28_0.lock then
					if arg_28_0 == var_24_2 then
						return true
					end

					if arg_28_1 == var_24_2 then
						return false
					end

					return arg_28_0 < arg_28_1
				end

				return var_28_0.lock
			end)
		end

		self.bgList_:StartScroll(#self.rightListData_)
	elseif arg_24_1 == 3 then
		self.rightListData_ = {}

		local var_24_3 = {}

		if self.filterGetState_ == 0 then
			var_24_3 = PlayerData:GetStickerFgList(true)
		elseif self.filterGetState_ == 1 then
			var_24_3 = PlayerData:GetStickerFgList()
		elseif self.filterGetState_ == 2 then
			var_24_3 = PlayerData:GetStickerFgList(false, true)
		end

		if self.filterState_ then
			for iter_24_4, iter_24_5 in pairs(var_24_3) do
				if self.filterMap_[PlayerData:GetStickerFg(iter_24_5).suit] then
					table.insert(self.rightListData_, iter_24_5)
				end
			end
		else
			self.rightListData_ = var_24_3
		end

		if self.filterDescendState_ then
			table.sort(self.rightListData_, function(arg_29_0, arg_29_1)
				local var_29_0 = PlayerData:GetStickerFg(arg_29_1)

				if PlayerData:GetStickerFg(arg_29_0).lock == var_29_0.lock then
					return arg_29_1 < arg_29_0
				end

				return var_29_0.lock
			end)
		else
			table.sort(self.rightListData_, function(arg_30_0, arg_30_1)
				local var_30_0 = PlayerData:GetStickerFg(arg_30_1)

				if PlayerData:GetStickerFg(arg_30_0).lock == var_30_0.lock then
					return arg_30_0 < arg_30_1
				end

				return var_30_0.lock
			end)
		end

		self.fgList_:StartScroll(#self.rightListData_)
	end
end

function CustomStickerCollectView:OnTop()
	return
end

function CustomStickerCollectView:OnExit()
	manager.windowBar:HideBar()
	self.collectController_:SetSelectedState("close")

	self.filterDd_.value = 0
	self.filterDescendState_ = true

	self.sortController_:SetSelectedState("down")
	manager.redPoint:unbindUIandKey(self.main1Btn_.transform, RedPointConst.CUSTOM_STICKER_SUIT_REWARD)
	manager.redPoint:unbindUIandKey(self.main2Btn_.transform, RedPointConst.CUSTOM_STICKER_CATEGORY)
	manager.redPoint:unbindUIandKey(self.sub1Btn_.transform, RedPointConst.CUSTOM_STICKER_ST)
	manager.redPoint:unbindUIandKey(self.sub2Btn_.transform, RedPointConst.CUSTOM_STICKER_BG)
	manager.redPoint:unbindUIandKey(self.sub3Btn_.transform, RedPointConst.CUSTOM_STICKER_FG)
end

function CustomStickerCollectView:Dispose()
	self:RemoveAllListeners()
	self.tabFilterPanel_:Dispose()
	self.suitList_:Dispose()
	self.stList_:Dispose()
	self.fgList_:Dispose()
	self.bgList_:Dispose()
	CustomStickerCollectView.super.Dispose(self)
end

return CustomStickerCollectView
