local CustomStickerEditView = class("CustomStickerEditView", ReduxView)

local function var_0_1(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = math.sqrt(arg_1_0 * arg_1_0 + arg_1_1 * arg_1_1)

	if var_1_0 > 1e-05 then
		arg_1_0 = arg_1_0 / var_1_0
		arg_1_1 = arg_1_1 / var_1_0
	else
		arg_1_1 = 0
		arg_1_0 = 0
	end

	local var_1_1 = math.sqrt(arg_1_2 * arg_1_2 + arg_1_3 * arg_1_3)

	if var_1_1 > 1e-05 then
		arg_1_2 = arg_1_2 / var_1_1
		arg_1_3 = arg_1_3 / var_1_1
	else
		arg_1_3 = 0
		arg_1_2 = 0
	end

	local var_1_2 = arg_1_0 * arg_1_2 + arg_1_1 * arg_1_3

	if arg_1_0 * arg_1_2 + arg_1_1 * arg_1_3 < -1 then
		var_1_2 = -1
	elseif var_1_2 > 1 then
		var_1_2 = 1
	end

	return math.acos(var_1_2) * 57.29578
end

function CustomStickerEditView:UIName()
	return "Widget/System/UserInfor/sticker_new/StickerEditUI"
end

function CustomStickerEditView:UIParent()
	return manager.ui.uiMain.transform
end

function CustomStickerEditView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CustomStickerEditView:InitUI()
	self:BindCfgUI()

	self.MaxScaleNum = GameSetting.sticker_scaling.value[2]
	self.MinScaleNum = GameSetting.sticker_scaling.value[1]
	self.MaxStickerNum = GameSetting.sticker_display_num_max.value[1]
	self.curPageNum_ = 1
	self.maxPageNum_ = 1
	self.curTab_ = 1
	self.curDynamicFg_ = nil
	self.curDynamicBg_ = nil
	self.curDynamicTopBg_ = nil
	self.coordinateX_ = 0
	self.coordinateY_ = 0
	self.selecting_ = false
	self.selectingIdx_ = 0
	self.stickerItemPool_ = {}
	self.poolTailPoint_ = 0
	self.deleteNum_ = 0
	self.beginDragPos_ = nil
	self.beginStickerPos_ = {}
	self.rotateVector_ = {}
	self.beginStickerAngleZ_ = nil
	self.beginStickerScale_ = nil
	self.beginStickerSize_ = {}
	self.tabFilterPanel_ = CustomStickerFilterPanel.New(self.filterPanelGo_)
	self.tabFilterData_ = {}
	self.allOriStickerData_ = {
		{},
		{}
	}
	self.filterMap_ = {}
	self.filterState_ = false
	self.stTabList_ = LuaList.New(handler(self, self.IndexTabItem), self.stUIList_, CustomStickerListItem)
	self.fgTabList_ = LuaList.New(handler(self, self.IndexTabItem), self.fgUIList_, CustomStickerListItem)
	self.tabController_ = self.mainControllerEx_:GetController("tab")
	self.favoriteController_ = self.mainControllerEx_:GetController("favorite")
	self.colorController_ = self.filterController_:GetController("color")
	self.useBtnController_ = self.mainControllerEx_:GetController("useBtn")

	self:AdaptScene()
end

function CustomStickerEditView:AdaptScene()
	local var_6_0 = manager.ui:GetCanvasSize()

	self.coordinateX_ = var_6_0.x
	self.coordinateY_ = var_6_0.y

	self.adaptMaskTrs_:SetSizeDeltaEx(self.coordinateX_, self.coordinateY_)
	self.adaptPaperTrs_:SetSizeDeltaEx(self.coordinateX_ * 0.6 + 200, self.coordinateY_ * 0.6 + 200)
end

function CustomStickerEditView:AddUIListeners()
	self:AddBtnListener(self.stBtn_, nil, function()
		if self.curTab_ ~= 1 then
			self:RefreshTab(1)
		end
	end)
	self:AddBtnListener(self.fgBtn_, nil, function()
		if self.curTab_ ~= 2 then
			self:RefreshTab(2)
		end
	end)
	self:AddBtnListener(self.filterBtn_, nil, function()
		self.tabFilterPanel_:OpenPanel()
	end)
	self:AddBtnListener(self.prePageBtn_, nil, function()
		if self.curPageNum_ > 1 then
			self.curPageNum_ = self.curPageNum_ - 1

			self:UpdateView()
		end
	end)
	self:AddBtnListener(self.nextPageBtn_, nil, function()
		if self.curPageNum_ < self.maxPageNum_ then
			self.curPageNum_ = self.curPageNum_ + 1

			self:UpdateView()
		end
	end)
	self:AddBtnListener(self.favoriteBtn_, nil, function()
		if PlayerData:GetStickerShowID() ~= self.bgData_[self.curPageNum_] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("STICKER_EXHIBITION_CONFIRM"),
				OkCallback = function()
					PlayerAction.SyncStickerShowToServer(self.bgData_[self.curPageNum_])
					self.favoriteController_:SetSelectedState("star")
				end,
				CancelCallback = function()
					return
				end
			})
		else
			ShowTips(GetTips("STICKER_EXHIBITION_ALREADY"))
		end
	end)
	self.moveTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
		if self.beginDragPos_ == nil then
			self.beginDragPos_ = LuaHelper.ScreenToLocal(self.stPanelTrs_, arg_16_1.position, manager.ui.uiCamera)
			self.beginStickerPos_.x = self.selecting_.rectTransform_:GetAnchoredPositionX(nil)
			self.beginStickerPos_.y = self.selecting_.rectTransform_:GetAnchoredPositionY(nil)
		end
	end))
	self.moveTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_17_0, arg_17_1)
		if self.beginDragPos_ ~= nil then
			local var_17_0 = LuaHelper.ScreenToLocal(self.stPanelTrs_, arg_17_1.position, manager.ui.uiCamera)

			self.movePanelTrs_:SetAnchoredPositionEx(math.min(math.max(var_17_0.x - self.beginDragPos_.x + self.beginStickerPos_.x, 0), self.coordinateX_), math.min(math.max(var_17_0.y - self.beginDragPos_.y + self.beginStickerPos_.y, 0), self.coordinateY_))
			self.selecting_.rectTransform_:SetAnchoredPositionEx(math.min(math.max(var_17_0.x - self.beginDragPos_.x + self.beginStickerPos_.x, 0), self.coordinateX_), math.min(math.max(var_17_0.y - self.beginDragPos_.y + self.beginStickerPos_.y, 0), self.coordinateY_))
		end
	end))
	self.moveTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_18_0, arg_18_1)
		if self.beginDragPos_ ~= nil then
			if self.selecting_ then
				self.pageData_[self.bgData_[self.curPageNum_]].sticker[self.selecting_.ID_].positionX = math.floor(self.selecting_.rectTransform_:GetAnchoredPositionX(nil) / self.coordinateX_ * 10000)
				self.pageData_[self.bgData_[self.curPageNum_]].sticker[self.selecting_.ID_].positionY = math.floor(self.selecting_.rectTransform_:GetAnchoredPositionY(nil) / self.coordinateY_ * 10000)
				self.changePageID_[self.bgData_[self.curPageNum_]] = true
			end

			self.beginDragPos_ = nil
		end
	end))
	self.rotateTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		if self.beginDragPos_ == nil then
			self.beginDragPos_ = LuaHelper.ScreenToLocal(self.stPanelTrs_, arg_19_1.position, manager.ui.uiCamera)
			self.rotateVector_.x = self.coordinateX_ / 2 - self.selecting_.rectTransform_:GetAnchoredPositionX(nil)
			self.rotateVector_.y = self.coordinateY_ / 2 - self.selecting_.rectTransform_:GetAnchoredPositionY(nil)
			self.beginStickerPos_.x = self.beginDragPos_.x + self.rotateVector_.x
			self.beginStickerPos_.y = self.beginDragPos_.y + self.rotateVector_.y
			self.beginStickerAngleZ_ = self.selecting_.rectTransform_:GetLocalEulerAngleZ()
			self.beginStickerScale_ = self.selecting_.rectTransform_:GetLocalScaleX()

			local var_19_0 = self.selecting_.outlineRect_.sizeDelta * self.selecting_.outlineRect_:GetLocalScaleX()

			self.beginStickerSize_.x = var_19_0.x
			self.beginStickerSize_.y = var_19_0.y
		end
	end))
	self.rotateTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_20_0, arg_20_1)
		if self.beginDragPos_ ~= nil then
			local var_20_0 = LuaHelper.ScreenToLocal(self.stPanelTrs_, arg_20_1.position, manager.ui.uiCamera)
			local var_20_1 = var_20_0.x + self.rotateVector_.x
			local var_20_2 = var_20_0.y + self.rotateVector_.y
			local var_20_3 = var_0_1(self.beginStickerPos_.x, self.beginStickerPos_.y, var_20_0.x + self.rotateVector_.x, var_20_0.y + self.rotateVector_.y)

			if self.beginStickerPos_.x * (var_20_0.y + self.rotateVector_.y) - self.beginStickerPos_.y * (var_20_0.x + self.rotateVector_.x) > 0 then
				self.selecting_.rectTransform_:SetLocalEulerAngleZ(self.beginStickerAngleZ_ + var_20_3)
				self.movePanelTrs_:SetLocalEulerAngleZ(self.beginStickerAngleZ_ + var_20_3)
			else
				self.selecting_.rectTransform_:SetLocalEulerAngleZ(self.beginStickerAngleZ_ - var_20_3)
				self.movePanelTrs_:SetLocalEulerAngleZ(self.beginStickerAngleZ_ - var_20_3)
			end

			local var_20_4 = math.sqrt((var_20_1 * var_20_1 + var_20_2 * var_20_2) / (self.beginStickerPos_.x * self.beginStickerPos_.x + self.beginStickerPos_.y * self.beginStickerPos_.y))

			self.selecting_.rectTransform_:SetLocalScaleVal(math.min(math.max(self.beginStickerScale_ * var_20_4, self.MinScaleNum), self.MaxScaleNum))
			self.movePanelTrs_:SetSizeDeltaEx(math.min(math.max(self.beginStickerScale_ * var_20_4, self.MinScaleNum), self.MaxScaleNum) * self.beginStickerSize_.x, math.min(math.max(self.beginStickerScale_ * var_20_4, self.MinScaleNum), self.MaxScaleNum) * self.beginStickerSize_.y)
		end
	end))
	self.rotateTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_21_0, arg_21_1)
		if self.beginDragPos_ ~= nil then
			if self.selecting_ then
				self.pageData_[self.bgData_[self.curPageNum_]].sticker[self.selecting_.ID_].rotation = math.floor(self.selecting_.rectTransform_:GetLocalEulerAngleZ() % 360 / 360 * 10000)
				self.pageData_[self.bgData_[self.curPageNum_]].sticker[self.selecting_.ID_].scale = math.floor(self.selecting_.rectTransform_:GetLocalScaleX() / self.MaxScaleNum * 10000)
				self.changePageID_[self.bgData_[self.curPageNum_]] = true
			end

			self.beginDragPos_ = nil
		end
	end))
	self:AddBtnListener(self.deleteBtn_, nil, function()
		if self.selecting_ then
			SetActive(self.selecting_.gameObject_, false)

			if self.curTab_ == 1 then
				local var_22_0 = table.keyof(self.tabFilterData_, self.selecting_.ID_)

				if var_22_0 and var_22_0 > 0 then
					local var_22_1 = self.stTabList_:GetItemByIndex(var_22_0)

					if var_22_1 then
						var_22_1:SetUse(false)
					end
				end
			end

			PlayerData:SetStickerPage(self.selecting_.ID_, 0)

			self.pageData_[self.bgData_[self.curPageNum_]].sticker[self.selecting_.ID_] = nil

			local var_22_2 = {}

			for iter_22_0, iter_22_1 in ipairs(self.pageData_[self.bgData_[self.curPageNum_]].hierarchy) do
				if iter_22_1 ~= self.selecting_.ID_ then
					table.insert(var_22_2, iter_22_1)
				end
			end

			self.pageData_[self.bgData_[self.curPageNum_]].hierarchy = var_22_2
			self.changePageID_[self.bgData_[self.curPageNum_]] = true
			self.deleteNum_ = self.deleteNum_ + 1
			self.stNumText_.text = self.poolTailPoint_ - self.deleteNum_ .. "/" .. self.MaxStickerNum
			self.selecting_ = nil
			self.selectingIdx_ = 0

			SetActive(self.movePanelTrs_.gameObject, false)
			SetActive(self.cancelBtn_.gameObject, false)
		end
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		if self.selecting_ then
			self.selecting_ = nil
			self.selectingIdx_ = 0

			SetActive(self.movePanelTrs_.gameObject, false)
			SetActive(self.cancelBtn_.gameObject, false)
		end
	end)
	self:AddBtnListener(self.clearBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("STICKER_ONE_CLICK_CLEARING"),
			OkCallback = function()
				for iter_25_0, iter_25_1 in pairs(self.pageData_[self.bgData_[self.curPageNum_]].sticker) do
					PlayerData:SetStickerPage(iter_25_0, 0)

					self.pageData_[self.bgData_[self.curPageNum_]].sticker[iter_25_0] = nil
				end

				PlayerData:SetStickerFgPage(self.pageData_[self.bgData_[self.curPageNum_]].foreground, 0)

				self.pageData_[self.bgData_[self.curPageNum_]].foreground = 0
				self.pageData_[self.bgData_[self.curPageNum_]].hierarchy = {}
				self.changePageID_[self.bgData_[self.curPageNum_]] = true

				self:UpdateView()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.onekeyUseBtn_, nil, function()
		local var_27_0 = self.bgData_[self.curPageNum_]
		local var_27_1 = StickerSuitCfg.get_id_list_by_page_id[self.bgData_[self.curPageNum_]] and StickerSuitCfg.get_id_list_by_page_id[self.bgData_[self.curPageNum_]][1]

		if not var_27_1 then
			return
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "userinfo_sticker_edit_onekey",
			other_data = string.format("{%d,%d}", self.bgData_[self.curPageNum_], var_27_1)
		})

		local var_27_2, var_27_3 = self:GetStickerSuitCount(var_27_1)

		if var_27_2 <= 1 then
			ShowTips("STICKER_ONE_KEY_USE_LOCKED")

			return
		end

		local var_27_4 = StickerSuitCfg[var_27_1]
		local var_27_5 = {}
		local var_27_6 = {}
		local var_27_7 = self.pageData_[self.bgData_[self.curPageNum_]].foreground

		for iter_27_0, iter_27_1 in ipairs(StickerSuitCfg[var_27_1].sticker_temp) do
			if PlayerData:GetSticker(iter_27_1[1]).lock then
				-- block empty
			else
				var_27_6[iter_27_1[5]] = iter_27_1[1]
				var_27_5[iter_27_1[1]] = {
					positionX = iter_27_1[2],
					positionY = iter_27_1[3],
					scale = iter_27_1[4],
					rotation = iter_27_1[6]
				}
			end
		end

		if var_27_4.foreground ~= 0 and PlayerData:GetStickerFg(var_27_4.foreground) ~= nil and not PlayerData:GetStickerFg(var_27_4.foreground).lock then
			var_27_7 = var_27_4.foreground
		end

		ShowMessageBox({
			content = GetTips("STICKER_ONE_KEY_USE_SURE"),
			OkCallback = function()
				local var_28_0 = PlayerData:GetStickerFg(var_27_7)

				if var_28_0 and var_28_0.page ~= 0 then
					self.pageData_[var_28_0.page].foreground = 0
				end

				for iter_28_0, iter_28_1 in pairs(var_27_6) do
					local var_28_1 = PlayerData:GetSticker(iter_28_1)

					if var_28_1 and var_28_1.page ~= 0 then
						self.pageData_[var_28_1.page].sticker[iter_28_1] = nil

						local var_28_2 = {}

						for iter_28_2, iter_28_3 in ipairs(self.pageData_[var_28_1.page].hierarchy) do
							if iter_28_3 ~= iter_28_1 then
								table.insert(var_28_2, iter_28_3)
							end
						end

						self.pageData_[var_28_1.page].hierarchy = var_28_2
					end
				end

				self.pageData_[self.bgData_[self.curPageNum_]].foreground = var_27_7
				self.pageData_[self.bgData_[self.curPageNum_]].hierarchy = var_27_6
				self.pageData_[self.bgData_[self.curPageNum_]].sticker = var_27_5
				self.changePageID_[self.bgData_[self.curPageNum_]] = true

				for iter_28_4, iter_28_5 in pairs(self.pageData_[self.bgData_[self.curPageNum_]].sticker) do
					PlayerData:SetStickerPage(iter_28_4, var_27_0)
				end

				PlayerData:SetStickerFgPage(self.pageData_[self.bgData_[self.curPageNum_]].foreground, var_27_0)
				self:UpdateView()
			end
		})
	end)
end

function CustomStickerEditView:IndexTabItem(arg_29_1, arg_29_2)
	local var_29_0 = ProfileDecorateItemCfg[self.tabFilterData_[arg_29_1]]
	local var_29_1 = false
	local var_29_2

	if self.curTab_ == 1 then
		var_29_2 = PlayerData:GetSticker(self.tabFilterData_[arg_29_1])

		local var_29_3
		local var_29_4

		if not var_29_2 then
			var_29_2 = PlayerData:GetStickerFg(self.tabFilterData_[arg_29_1])
			var_29_3 = false
			var_29_4 = table.keyof(self.bgData_, var_29_2.page) or 0
		end
	end

	arg_29_2:SetData(var_29_0, var_29_1, var_29_2.page == self.bgData_[self.curPageNum_], var_29_3, false, false, function()
		if self.curTab_ == 1 and self.poolTailPoint_ - self.deleteNum_ >= self.MaxStickerNum then
			ShowTips("STICKER_PAGE_LIMIT_COUNT")

			return
		end

		if var_29_2.page == 0 then
			arg_29_2:SetUse(true, self.curPageNum_)

			if self.curTab_ == 1 then
				var_29_2.page = self.bgData_[self.curPageNum_]

				PlayerData:SetStickerPage(arg_29_2.ID_, self.bgData_[self.curPageNum_])

				self.pageData_[self.bgData_[self.curPageNum_]].sticker[arg_29_2.ID_] = {
					positionY = 5000,
					rotation = 0,
					positionX = 5000,
					scale = 10000 / self.MaxScaleNum
				}

				table.insert(self.pageData_[self.bgData_[self.curPageNum_]].hierarchy, arg_29_2.ID_)

				self.changePageID_[self.bgData_[self.curPageNum_]] = true
				self.poolTailPoint_ = self.poolTailPoint_ + 1
				self.stNumText_.text = self.poolTailPoint_ - self.deleteNum_ .. "/" .. self.MaxStickerNum

				local var_30_0 = self.poolTailPoint_

				if self.poolTailPoint_ > #self.stickerItemPool_ then
					self.stickerItemPool_[self.poolTailPoint_] = CustomStickerMoveItem.New((Object.Instantiate(self.stMoveGo_, self.stPanelTrs_)))
				end

				SetActive(self.stickerItemPool_[self.poolTailPoint_].gameObject_, true)
				self.stickerItemPool_[self.poolTailPoint_].rectTransform_:SetAnchoredPositionEx(self.coordinateX_ / 2, self.coordinateY_ / 2)
				self.stickerItemPool_[self.poolTailPoint_].rectTransform_:SetLocalEulerAngleZ(0)
				self.stickerItemPool_[self.poolTailPoint_].rectTransform_:SetLocalScaleVal(1)
				self.stickerItemPool_[self.poolTailPoint_]:SetData(var_29_0, function()
					if self.selectingIdx_ ~= var_30_0 then
						self.selectingIdx_ = var_30_0
						self.selecting_ = self.stickerItemPool_[var_30_0]

						self.selecting_.rectTransform_:SetAsLastSibling()

						local var_31_0 = {}

						for iter_31_0, iter_31_1 in ipairs(self.pageData_[self.bgData_[self.curPageNum_]].hierarchy) do
							if iter_31_1 ~= self.selecting_.ID_ then
								table.insert(var_31_0, iter_31_1)
							end
						end

						table.insert(var_31_0, self.selecting_.ID_)

						self.pageData_[self.bgData_[self.curPageNum_]].hierarchy = var_31_0
						self.changePageID_[self.bgData_[self.curPageNum_]] = true

						self.movePanelTrs_:SetAnchoredPosition(self.selecting_.rectTransform_.anchoredPosition)
						self.movePanelTrs_:SetSizeDelta(self.selecting_.outlineRect_.sizeDelta * self.selecting_.outlineRect_:GetLocalScaleX() * self.selecting_.rectTransform_:GetLocalScaleX())
						self.movePanelTrs_:SetLocalEulerAngleZ(self.selecting_.rectTransform_:GetLocalEulerAngleZ())
						SetActive(self.movePanelTrs_.gameObject, true)
						SetActive(self.cancelBtn_.gameObject, true)
					end
				end)

				self.selectingIdx_ = self.poolTailPoint_
				self.selecting_ = self.stickerItemPool_[self.poolTailPoint_]

				self.selecting_.rectTransform_:SetAsLastSibling()
				self.movePanelTrs_:SetAnchoredPosition(self.selecting_.rectTransform_.anchoredPosition)
				self.movePanelTrs_:SetSizeDelta(self.selecting_.outlineRect_.sizeDelta * self.selecting_.outlineRect_:GetLocalScaleX() * self.selecting_.rectTransform_:GetLocalScaleX())
				self.movePanelTrs_:SetLocalEulerAngleZ(self.selecting_.rectTransform_:GetLocalEulerAngleZ())
				SetActive(self.movePanelTrs_.gameObject, true)
				SetActive(self.cancelBtn_.gameObject, true)
			elseif self.curTab_ == 2 then
				var_29_2.page = self.bgData_[self.curPageNum_]

				PlayerData:SetStickerFgPage(arg_29_2.ID_, self.bgData_[self.curPageNum_])

				self.pageData_[self.bgData_[self.curPageNum_]].foreground = arg_29_2.ID_
				self.changePageID_[self.bgData_[self.curPageNum_]] = true

				self:DestroyDynamicFg()

				if var_29_0.type == 1 then
					self.fgStaticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_l/Stickerfg_l_" .. var_29_0.resource
					self.fgStaticImg_.enabled = true
				elseif var_29_0.type == 2 then
					self.curDynamicFg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Foreground/Foregrounditem_" .. var_29_0.resource), self.fgDynamicTrs_)
					self.fgStaticImg_.enabled = false
				end
			end
		elseif var_29_2.page ~= self.bgData_[self.curPageNum_] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("STICKER_SWITCH_PAGES"),
				OkCallback = function()
					arg_29_2:SetUse(true, self.curPageNum_)

					if self.curTab_ == 1 then
						self.pageData_[var_29_2.page].sticker[arg_29_2.ID_] = nil

						local var_32_0 = {}

						for iter_32_0, iter_32_1 in ipairs(self.pageData_[var_29_2.page].hierarchy) do
							if iter_32_1 ~= arg_29_2.ID_ then
								table.insert(var_32_0, iter_32_1)
							end
						end

						self.pageData_[var_29_2.page].hierarchy = var_32_0
						self.changePageID_[var_29_2.page] = true
						var_29_2.page = self.bgData_[self.curPageNum_]

						PlayerData:SetStickerPage(arg_29_2.ID_, self.bgData_[self.curPageNum_])

						self.pageData_[self.bgData_[self.curPageNum_]].sticker[arg_29_2.ID_] = {
							positionY = 5000,
							rotation = 0,
							positionX = 5000,
							scale = 10000 / self.MaxScaleNum
						}

						table.insert(self.pageData_[self.bgData_[self.curPageNum_]].hierarchy, arg_29_2.ID_)

						self.changePageID_[self.bgData_[self.curPageNum_]] = true
						self.poolTailPoint_ = self.poolTailPoint_ + 1
						self.stNumText_.text = self.poolTailPoint_ - self.deleteNum_ .. "/" .. self.MaxStickerNum

						local var_32_1 = self.poolTailPoint_

						if self.poolTailPoint_ > #self.stickerItemPool_ then
							self.stickerItemPool_[self.poolTailPoint_] = CustomStickerMoveItem.New((Object.Instantiate(self.stMoveGo_, self.stPanelTrs_)))
						end

						SetActive(self.stickerItemPool_[self.poolTailPoint_].gameObject_, true)
						self.stickerItemPool_[self.poolTailPoint_].rectTransform_:SetAnchoredPositionEx(self.coordinateX_ / 2, self.coordinateY_ / 2)
						self.stickerItemPool_[self.poolTailPoint_].rectTransform_:SetLocalEulerAngleZ(0)
						self.stickerItemPool_[self.poolTailPoint_].rectTransform_:SetLocalScaleVal(1)
						self.stickerItemPool_[self.poolTailPoint_]:SetData(var_29_0, function()
							if self.selectingIdx_ ~= var_32_1 then
								self.selectingIdx_ = var_32_1
								self.selecting_ = self.stickerItemPool_[var_32_1]

								self.selecting_.rectTransform_:SetAsLastSibling()

								local var_33_0 = {}

								for iter_33_0, iter_33_1 in ipairs(self.pageData_[self.bgData_[self.curPageNum_]].hierarchy) do
									if iter_33_1 ~= self.selecting_.ID_ then
										table.insert(var_33_0, iter_33_1)
									end
								end

								table.insert(var_33_0, self.selecting_.ID_)

								self.pageData_[self.bgData_[self.curPageNum_]].hierarchy = var_33_0
								self.changePageID_[self.bgData_[self.curPageNum_]] = true

								self.movePanelTrs_:SetAnchoredPosition(self.selecting_.rectTransform_.anchoredPosition)
								self.movePanelTrs_:SetSizeDelta(self.selecting_.outlineRect_.sizeDelta * self.selecting_.outlineRect_:GetLocalScaleX() * self.selecting_.rectTransform_:GetLocalScaleX())
								self.movePanelTrs_:SetLocalEulerAngleZ(self.selecting_.rectTransform_:GetLocalEulerAngleZ())
								SetActive(self.movePanelTrs_.gameObject, true)
								SetActive(self.cancelBtn_.gameObject, true)
							end
						end)

						self.selectingIdx_ = self.poolTailPoint_
						self.selecting_ = self.stickerItemPool_[self.poolTailPoint_]

						self.selecting_.rectTransform_:SetAsLastSibling()
						self.movePanelTrs_:SetAnchoredPosition(self.selecting_.rectTransform_.anchoredPosition)
						self.movePanelTrs_:SetSizeDelta(self.selecting_.outlineRect_.sizeDelta * self.selecting_.outlineRect_:GetLocalScaleX() * self.selecting_.rectTransform_:GetLocalScaleX())
						self.movePanelTrs_:SetLocalEulerAngleZ(self.selecting_.rectTransform_:GetLocalEulerAngleZ())
						SetActive(self.movePanelTrs_.gameObject, true)
						SetActive(self.cancelBtn_.gameObject, true)
					elseif self.curTab_ == 2 then
						self.pageData_[var_29_2.page].foreground = 0
						self.changePageID_[var_29_2.page] = true
						var_29_2.page = self.bgData_[self.curPageNum_]

						PlayerData:SetStickerFgPage(arg_29_2.ID_, self.bgData_[self.curPageNum_])

						self.pageData_[self.bgData_[self.curPageNum_]].foreground = arg_29_2.ID_
						self.changePageID_[self.bgData_[self.curPageNum_]] = true

						self:DestroyDynamicFg()

						if var_29_0.type == 1 then
							self.fgStaticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_l/Stickerfg_l_" .. var_29_0.resource
							self.fgStaticImg_.enabled = true
						elseif var_29_0.type == 2 then
							self.curDynamicFg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Foreground/Foregrounditem_" .. var_29_0.resource), self.fgDynamicTrs_)
							self.fgStaticImg_.enabled = false
						end
					end
				end,
				CancelCallback = function()
					return
				end
			})
		elseif self.curTab_ == 1 then
			local var_30_1

			for iter_30_0, iter_30_1 in ipairs(self.stickerItemPool_) do
				if iter_30_1.ID_ == var_29_0.id and iter_30_1.gameObject_.activeSelf then
					var_30_1 = iter_30_0
				end
			end

			if not var_30_1 then
				return
			end

			self.selectingIdx_ = var_30_1
			self.selecting_ = self.stickerItemPool_[var_30_1]

			self.selecting_.rectTransform_:SetAsLastSibling()

			local var_30_2 = {}

			for iter_30_2, iter_30_3 in ipairs(self.pageData_[self.bgData_[self.curPageNum_]].hierarchy) do
				if iter_30_3 ~= self.selecting_.ID_ then
					table.insert(var_30_2, iter_30_3)
				end
			end

			table.insert(var_30_2, self.selecting_.ID_)

			self.pageData_[self.bgData_[self.curPageNum_]].hierarchy = var_30_2

			self.movePanelTrs_:SetAnchoredPosition(self.selecting_.rectTransform_.anchoredPosition)
			self.movePanelTrs_:SetSizeDelta(self.selecting_.outlineRect_.sizeDelta * self.selecting_.outlineRect_:GetLocalScaleX() * self.selecting_.rectTransform_:GetLocalScaleX())
			self.movePanelTrs_:SetLocalEulerAngleZ(self.selecting_.rectTransform_:GetLocalEulerAngleZ())
			SetActive(self.movePanelTrs_.gameObject, true)
			SetActive(self.cancelBtn_.gameObject, true)
		elseif self.curTab_ == 2 then
			arg_29_2:SetUse(false)

			var_29_2.page = 0

			PlayerData:SetStickerFgPage(arg_29_2.ID_, 0)

			self.pageData_[self.bgData_[self.curPageNum_]].foreground = 0
			self.changePageID_[self.bgData_[self.curPageNum_]] = true

			self:DestroyDynamicFg()

			self.fgStaticImg_.enabled = false
		end
	end, nil, var_29_4)
end

function CustomStickerEditView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.filterMap_ = {}
	self.filterState_ = false

	self.colorController_:SetSelectedState("normal")
	self.tabFilterPanel_:SetData(StickerSuitCfg.all, function(arg_36_0, arg_36_1)
		self.filterMap_ = arg_36_0
		self.filterState_ = not arg_36_1

		self.colorController_:SetSelectedState(self.filterState_ and "orange" or "normal")
		self:RefreshTab(self.curTab_)
	end)

	self.bgData_ = PlayerData:GetStickerBgList()

	local var_35_0 = GameSetting.sticker_background_default.value[1]

	table.sort(self.bgData_, function(arg_37_0, arg_37_1)
		if arg_37_0 == var_35_0 then
			return true
		end

		if arg_37_1 == var_35_0 then
			return false
		end

		return arg_37_0 < arg_37_1
	end)

	self.pageData_ = PlayerData:GetStickerEditData()
	self.allOriStickerData_[1] = PlayerData:GetStickerList()

	table.sort(self.allOriStickerData_[1], function(arg_38_0, arg_38_1)
		local var_38_0 = PlayerData:GetSticker(arg_38_0)
		local var_38_1 = PlayerData:GetSticker(arg_38_1)

		if var_38_0.page == 0 and var_38_1.page == 0 or var_38_0.page ~= 0 and var_38_1.page ~= 0 then
			return arg_38_1 < arg_38_0
		end

		return var_38_0.page < var_38_1.page
	end)

	self.allOriStickerData_[2] = PlayerData:GetStickerFgList()

	table.sort(self.allOriStickerData_[2], function(arg_39_0, arg_39_1)
		local var_39_0 = PlayerData:GetStickerFg(arg_39_0)
		local var_39_1 = PlayerData:GetStickerFg(arg_39_1)

		if var_39_0.page == 0 and var_39_1.page == 0 or var_39_0.page ~= 0 and var_39_1.page ~= 0 then
			return arg_39_1 < arg_39_0
		end

		return var_39_0.page < var_39_1.page
	end)

	self.changePageID_ = {}
	self.maxPageNum_ = #self.bgData_
	self.curPageNum_ = getData("PlayerCustomStickerTriggered", "LastEditStickerPageNum") or 1
	self.curTab_ = 1

	self:UpdateView()
end

function CustomStickerEditView:RefreshTab(arg_40_1)
	self.curTab_ = arg_40_1

	if arg_40_1 == 1 then
		self.tabFilterData_ = {}

		if self.filterState_ then
			for iter_40_0, iter_40_1 in ipairs(self.allOriStickerData_[1]) do
				if self.filterMap_[PlayerData:GetSticker(iter_40_1).suit] then
					table.insert(self.tabFilterData_, iter_40_1)
				end
			end
		else
			self.tabFilterData_ = self.allOriStickerData_[1]
		end

		self.tabController_:SetSelectedState("sticker")
		self.stTabList_:StartScroll(#self.tabFilterData_)
	else
		self.tabFilterData_ = {}

		if self.filterState_ then
			for iter_40_2, iter_40_3 in ipairs(self.allOriStickerData_[2]) do
				if self.filterMap_[PlayerData:GetStickerFg(iter_40_3).suit] then
					table.insert(self.tabFilterData_, iter_40_3)
				end
			end
		else
			self.tabFilterData_ = self.allOriStickerData_[2]
		end

		self.tabController_:SetSelectedState("foreground")
		self.fgTabList_:StartScroll(#self.tabFilterData_)
	end
end

function CustomStickerEditView:UpdateView()
	SetActive(self.prePageBtn_.gameObject, self.curPageNum_ > 1)
	SetActive(self.nextPageBtn_.gameObject, self.curPageNum_ < self.maxPageNum_)
	self:RefreshTab(self.curTab_)

	self.bgNameText_.text = ItemTools.getItemName(self.bgData_[self.curPageNum_])
	self.pageNumText_.text = self.curPageNum_ .. "/" .. self.maxPageNum_

	if self.selecting_ then
		self.selecting_ = nil
		self.selectingIdx_ = 0

		SetActive(self.movePanelTrs_.gameObject, false)
		SetActive(self.cancelBtn_.gameObject, false)
	end

	if PlayerData:GetStickerShowID() == self.bgData_[self.curPageNum_] then
		self.favoriteController_:SetSelectedState("star")
	else
		self.favoriteController_:SetSelectedState("none")
	end

	local var_41_0 = self.pageData_[self.bgData_[self.curPageNum_]]

	self:DestroyDynamicBg()

	self.bgStaticImg_.enabled = false

	if var_41_0 then
		if ProfileDecorateItemCfg[self.bgData_[self.curPageNum_]] then
			if ProfileDecorateItemCfg[self.bgData_[self.curPageNum_]].type == 1 then
				self.bgStaticImg_.spriteAsync = "TextureConfig/Sticker/Background_l/Stickerbg_l_" .. ProfileDecorateItemCfg[self.bgData_[self.curPageNum_]].resource
				self.bgStaticImg_.enabled = true
			elseif ProfileDecorateItemCfg[self.bgData_[self.curPageNum_]].type == 2 then
				self.curDynamicBg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Bg/Bgitem_" .. ProfileDecorateItemCfg[self.bgData_[self.curPageNum_]].resource), self.bgDynamicTrs_)
				self.bgStaticImg_.enabled = false
				self.curDynamicTopBg_ = self.curDynamicBg_.transform:Find("TopPart")

				if self.curDynamicTopBg_ then
					self.curDynamicTopBg_:SetParent(self.TopBgTrs_)

					self.curDynamicTopBg_ = self.curDynamicTopBg_.gameObject
				end
			end
		end
	end

	self:DestroyDynamicFg()

	self.fgStaticImg_.enabled = false

	if var_41_0.foreground ~= 0 then
		if ProfileDecorateItemCfg[var_41_0.foreground] then
			if ProfileDecorateItemCfg[var_41_0.foreground].type == 1 then
				self.fgStaticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_l/Stickerfg_l_" .. ProfileDecorateItemCfg[var_41_0.foreground].resource
				self.fgStaticImg_.enabled = true
			elseif ProfileDecorateItemCfg[var_41_0.foreground].type == 2 then
				self.curDynamicFg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Foreground/Foregrounditem_" .. ProfileDecorateItemCfg[var_41_0.foreground].resource), self.fgDynamicTrs_)
				self.fgStaticImg_.enabled = false
			end
		end
	end

	local var_41_1 = 1

	for iter_41_0, iter_41_1 in pairs(var_41_0.hierarchy) do
		if ProfileDecorateItemCfg[iter_41_1] then
			self.stickerItemPool_[var_41_1] = self.stickerItemPool_[var_41_1] or CustomStickerMoveItem.New((Object.Instantiate(self.stMoveGo_, self.stPanelTrs_)))

			SetActive(self.stickerItemPool_[var_41_1].gameObject_, true)

			local var_41_2 = var_41_1

			self.stickerItemPool_[var_41_1]:SetData(ProfileDecorateItemCfg[iter_41_1], function()
				if self.selectingIdx_ ~= var_41_2 then
					self.selectingIdx_ = var_41_2
					self.selecting_ = self.stickerItemPool_[var_41_2]

					self.selecting_.rectTransform_:SetAsLastSibling()

					local var_42_0 = {}

					for iter_42_0, iter_42_1 in ipairs(self.pageData_[self.bgData_[self.curPageNum_]].hierarchy) do
						if iter_42_1 ~= self.selecting_.ID_ then
							table.insert(var_42_0, iter_42_1)
						end
					end

					table.insert(var_42_0, self.selecting_.ID_)

					self.pageData_[self.bgData_[self.curPageNum_]].hierarchy = var_42_0
					self.changePageID_[self.bgData_[self.curPageNum_]] = true

					self.movePanelTrs_:SetAnchoredPosition(self.selecting_.rectTransform_.anchoredPosition)
					self.movePanelTrs_:SetSizeDelta(self.selecting_.outlineRect_.sizeDelta * self.selecting_.outlineRect_:GetLocalScaleX() * self.selecting_.rectTransform_:GetLocalScaleX())
					self.movePanelTrs_:SetLocalEulerAngleZ(self.selecting_.rectTransform_:GetLocalEulerAngleZ())
					SetActive(self.movePanelTrs_.gameObject, true)
					SetActive(self.cancelBtn_.gameObject, true)
				end
			end)
			self.stickerItemPool_[var_41_1].rectTransform_:SetAnchoredPositionEx(var_41_0.sticker[iter_41_1].positionX / 10000 * self.coordinateX_, var_41_0.sticker[iter_41_1].positionY / 10000 * self.coordinateY_)
			self.stickerItemPool_[var_41_1].rectTransform_:SetLocalEulerAngleZ(var_41_0.sticker[iter_41_1].rotation / 10000 * 360)
			self.stickerItemPool_[var_41_1].rectTransform_:SetLocalScaleVal(var_41_0.sticker[iter_41_1].scale / 10000 * self.MaxScaleNum)
			self.stickerItemPool_[var_41_1].rectTransform_:SetAsLastSibling()

			var_41_1 = var_41_1 + 1
		end
	end

	self.poolTailPoint_ = var_41_1 - 1
	self.deleteNum_ = 0
	self.stNumText_.text = self.poolTailPoint_ - self.deleteNum_ .. "/" .. self.MaxStickerNum

	while var_41_1 <= #self.stickerItemPool_ do
		if self.stickerItemPool_[var_41_1] then
			SetActive(self.stickerItemPool_[var_41_1].gameObject_, false)
		end

		var_41_1 = var_41_1 + 1
	end

	local var_41_3 = StickerSuitCfg.get_id_list_by_page_id[self.bgData_[self.curPageNum_]] and StickerSuitCfg.get_id_list_by_page_id[self.bgData_[self.curPageNum_]][1]
	local var_41_4, var_41_5 = self:GetStickerSuitCount(var_41_3)

	if var_41_3 then
		self.onekeyUseText_.text = string.format("%d/%d", var_41_4, var_41_5)

		self.useBtnController_:SetSelectedIndex(0)
	else
		self.useBtnController_:SetSelectedIndex(2)
	end
end

function CustomStickerEditView:GetStickerSuitCount(arg_43_1)
	if not StickerSuitCfg[arg_43_1] then
		return 0, 0
	end

	local var_43_0 = 0

	for iter_43_0, iter_43_1 in ipairs(StickerSuitCfg[arg_43_1].content) do
		if ProfileDecorateItemCfg[iter_43_1].item_type == 4 then
			if not PlayerData:GetStickerBg(iter_43_1).lock then
				var_43_0 = var_43_0 + 1
			end
		elseif ProfileDecorateItemCfg[iter_43_1].item_type == 5 then
			if not PlayerData:GetSticker(iter_43_1).lock then
				var_43_0 = var_43_0 + 1
			end
		elseif ProfileDecorateItemCfg[iter_43_1].item_type == 6 and not PlayerData:GetStickerFg(iter_43_1).lock then
			var_43_0 = var_43_0 + 1
		end
	end

	return var_43_0, #StickerSuitCfg[arg_43_1].content
end

function CustomStickerEditView:OnTop()
	return
end

function CustomStickerEditView:DestroyDynamicFg()
	if self.curDynamicFg_ then
		Object.Destroy(self.curDynamicFg_)

		self.curDynamicFg_ = nil
	end
end

function CustomStickerEditView:DestroyDynamicBg()
	if self.curDynamicBg_ then
		Object.Destroy(self.curDynamicBg_)

		self.curDynamicBg_ = nil
	end

	if self.curDynamicTopBg_ then
		Object.Destroy(self.curDynamicTopBg_)

		self.curDynamicTopBg_ = nil
	end
end

function CustomStickerEditView:OnExit()
	manager.windowBar:HideBar()
	saveData("PlayerCustomStickerTriggered", "LastEditStickerPageNum", self.curPageNum_)

	if self.selecting_ then
		self.selecting_ = nil
		self.selectingIdx_ = 0

		SetActive(self.movePanelTrs_.gameObject, false)
		SetActive(self.cancelBtn_.gameObject, false)
	end

	PlayerAction.SyncStickerPageUpdateToServer(self.pageData_, self.changePageID_)
end

function CustomStickerEditView:Dispose()
	self:RemoveAllListeners()
	self:DestroyDynamicFg()
	self:DestroyDynamicBg()
	self.tabFilterPanel_:Dispose()
	self.stTabList_:Dispose()
	self.fgTabList_:Dispose()

	for iter_48_0 = 1, #self.stickerItemPool_ do
		if self.stickerItemPool_[iter_48_0] then
			self.stickerItemPool_[iter_48_0]:Dispose()

			self.stickerItemPool_[iter_48_0] = nil
		end
	end

	CustomStickerEditView.super.Dispose(self)
end

function ExportCustomStickerEditTempConfig()
	local var_49_0 = gameContext:GetOpenPageHandler("customStickerEdit")

	if var_49_0 then
		var_49_0:ExportSuitTempConfig()
	else
		error("Plz Open CustomStickerEditView First")
	end
end

function CustomStickerEditView:ExportSuitTempConfig()
	if self.pageData_[self.bgData_[self.curPageNum_]] == nil then
		error("can not find CustomStickerEditView Config")

		return
	end

	local var_50_0 = {}

	for iter_50_0, iter_50_1 in ipairs(self.pageData_[self.bgData_[self.curPageNum_]].hierarchy) do
		table.insert(var_50_0, {
			sticker_id = iter_50_1,
			location_x = self.pageData_[self.bgData_[self.curPageNum_]].sticker[iter_50_1].positionX,
			location_y = self.pageData_[self.bgData_[self.curPageNum_]].sticker[iter_50_1].positionY,
			scale = self.pageData_[self.bgData_[self.curPageNum_]].sticker[iter_50_1].scale,
			layer = iter_50_0,
			rotate = self.pageData_[self.bgData_[self.curPageNum_]].sticker[iter_50_1].rotation
		})
	end

	local var_50_1 = ""

	for iter_50_2, iter_50_3 in ipairs(var_50_0) do
		if iter_50_2 ~= 1 then
			var_50_1 = var_50_1 .. ","
		end

		var_50_1 = var_50_1 .. string.format("[%d,%d,%d,%d,%d,%d]", iter_50_3.sticker_id, iter_50_3.location_x, iter_50_3.location_y, iter_50_3.scale, iter_50_3.layer, iter_50_3.rotate)
	end

	print("前景Id : " .. self.pageData_[self.bgData_[self.curPageNum_]].foreground)
	print("贴纸配置 : " .. string.format("[%s]", var_50_1))

	return var_50_0
end

return CustomStickerEditView
