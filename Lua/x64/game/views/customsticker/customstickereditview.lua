local var_0_0 = class("CustomStickerEditView", ReduxView)

local function var_0_1(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = math.sqrt(arg_1_0 * arg_1_0 + arg_1_1 * arg_1_1)

	if var_1_0 > 1e-05 then
		arg_1_0 = arg_1_0 / var_1_0
		arg_1_1 = arg_1_1 / var_1_0
	else
		arg_1_0, arg_1_1 = 0, 0
	end

	local var_1_1 = math.sqrt(arg_1_2 * arg_1_2 + arg_1_3 * arg_1_3)

	if var_1_1 > 1e-05 then
		arg_1_2 = arg_1_2 / var_1_1
		arg_1_3 = arg_1_3 / var_1_1
	else
		arg_1_2, arg_1_3 = 0, 0
	end

	local var_1_2 = arg_1_0 * arg_1_2 + arg_1_1 * arg_1_3

	if var_1_2 < -1 then
		var_1_2 = -1
	elseif var_1_2 > 1 then
		var_1_2 = 1
	end

	return math.acos(var_1_2) * 57.29578
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/UserInfor/sticker_new/StickerEditUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.MaxScaleNum = GameSetting.sticker_scaling.value[2]
	arg_5_0.MinScaleNum = GameSetting.sticker_scaling.value[1]
	arg_5_0.MaxStickerNum = GameSetting.sticker_display_num_max.value[1]
	arg_5_0.curPageNum_ = 1
	arg_5_0.maxPageNum_ = 1
	arg_5_0.curTab_ = 1
	arg_5_0.curDynamicFg_ = nil
	arg_5_0.curDynamicBg_ = nil
	arg_5_0.curDynamicTopBg_ = nil
	arg_5_0.coordinateX_ = 0
	arg_5_0.coordinateY_ = 0
	arg_5_0.selecting_ = false
	arg_5_0.selectingIdx_ = 0
	arg_5_0.stickerItemPool_ = {}
	arg_5_0.poolTailPoint_ = 0
	arg_5_0.deleteNum_ = 0
	arg_5_0.beginDragPos_ = nil
	arg_5_0.beginStickerPos_ = {}
	arg_5_0.rotateVector_ = {}
	arg_5_0.beginStickerAngleZ_ = nil
	arg_5_0.beginStickerScale_ = nil
	arg_5_0.beginStickerSize_ = {}
	arg_5_0.tabFilterPanel_ = CustomStickerFilterPanel.New(arg_5_0.filterPanelGo_)
	arg_5_0.tabFilterData_ = {}
	arg_5_0.allOriStickerData_ = {
		{},
		{}
	}
	arg_5_0.filterMap_ = {}
	arg_5_0.filterState_ = false
	arg_5_0.stTabList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexTabItem), arg_5_0.stUIList_, CustomStickerListItem)
	arg_5_0.fgTabList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexTabItem), arg_5_0.fgUIList_, CustomStickerListItem)
	arg_5_0.tabController_ = arg_5_0.mainControllerEx_:GetController("tab")
	arg_5_0.favoriteController_ = arg_5_0.mainControllerEx_:GetController("favorite")
	arg_5_0.colorController_ = arg_5_0.filterController_:GetController("color")
	arg_5_0.useBtnController_ = arg_5_0.mainControllerEx_:GetController("useBtn")

	arg_5_0:AdaptScene()
end

function var_0_0.AdaptScene(arg_6_0)
	local var_6_0 = manager.ui:GetCanvasSize()

	arg_6_0.coordinateX_ = var_6_0.x
	arg_6_0.coordinateY_ = var_6_0.y

	arg_6_0.adaptMaskTrs_:SetSizeDeltaEx(arg_6_0.coordinateX_, arg_6_0.coordinateY_)
	arg_6_0.adaptPaperTrs_:SetSizeDeltaEx(arg_6_0.coordinateX_ * 0.6 + 200, arg_6_0.coordinateY_ * 0.6 + 200)
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.stBtn_, nil, function()
		if arg_7_0.curTab_ ~= 1 then
			arg_7_0:RefreshTab(1)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.fgBtn_, nil, function()
		if arg_7_0.curTab_ ~= 2 then
			arg_7_0:RefreshTab(2)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.filterBtn_, nil, function()
		arg_7_0.tabFilterPanel_:OpenPanel()
	end)
	arg_7_0:AddBtnListener(arg_7_0.prePageBtn_, nil, function()
		if arg_7_0.curPageNum_ > 1 then
			arg_7_0.curPageNum_ = arg_7_0.curPageNum_ - 1

			arg_7_0:UpdateView()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.nextPageBtn_, nil, function()
		if arg_7_0.curPageNum_ < arg_7_0.maxPageNum_ then
			arg_7_0.curPageNum_ = arg_7_0.curPageNum_ + 1

			arg_7_0:UpdateView()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.favoriteBtn_, nil, function()
		if PlayerData:GetStickerShowID() ~= arg_7_0.bgData_[arg_7_0.curPageNum_] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("STICKER_EXHIBITION_CONFIRM"),
				OkCallback = function()
					PlayerAction.SyncStickerShowToServer(arg_7_0.bgData_[arg_7_0.curPageNum_])
					arg_7_0.favoriteController_:SetSelectedState("star")
				end,
				CancelCallback = function()
					return
				end
			})
		else
			ShowTips(GetTips("STICKER_EXHIBITION_ALREADY"))
		end
	end)
	arg_7_0.moveTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
		if arg_7_0.beginDragPos_ == nil then
			arg_7_0.beginDragPos_ = LuaHelper.ScreenToLocal(arg_7_0.stPanelTrs_, arg_16_1.position, manager.ui.uiCamera)
			arg_7_0.beginStickerPos_.x = arg_7_0.selecting_.rectTransform_:GetAnchoredPositionX(nil)
			arg_7_0.beginStickerPos_.y = arg_7_0.selecting_.rectTransform_:GetAnchoredPositionY(nil)
		end
	end))
	arg_7_0.moveTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_17_0, arg_17_1)
		if arg_7_0.beginDragPos_ ~= nil then
			local var_17_0 = LuaHelper.ScreenToLocal(arg_7_0.stPanelTrs_, arg_17_1.position, manager.ui.uiCamera)

			arg_7_0.movePanelTrs_:SetAnchoredPositionEx(math.min(math.max(var_17_0.x - arg_7_0.beginDragPos_.x + arg_7_0.beginStickerPos_.x, 0), arg_7_0.coordinateX_), math.min(math.max(var_17_0.y - arg_7_0.beginDragPos_.y + arg_7_0.beginStickerPos_.y, 0), arg_7_0.coordinateY_))
			arg_7_0.selecting_.rectTransform_:SetAnchoredPositionEx(math.min(math.max(var_17_0.x - arg_7_0.beginDragPos_.x + arg_7_0.beginStickerPos_.x, 0), arg_7_0.coordinateX_), math.min(math.max(var_17_0.y - arg_7_0.beginDragPos_.y + arg_7_0.beginStickerPos_.y, 0), arg_7_0.coordinateY_))
		end
	end))
	arg_7_0.moveTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_18_0, arg_18_1)
		if arg_7_0.beginDragPos_ ~= nil then
			if arg_7_0.selecting_ then
				arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].sticker[arg_7_0.selecting_.ID_].positionX = math.floor(arg_7_0.selecting_.rectTransform_:GetAnchoredPositionX(nil) / arg_7_0.coordinateX_ * 10000)
				arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].sticker[arg_7_0.selecting_.ID_].positionY = math.floor(arg_7_0.selecting_.rectTransform_:GetAnchoredPositionY(nil) / arg_7_0.coordinateY_ * 10000)
				arg_7_0.changePageID_[arg_7_0.bgData_[arg_7_0.curPageNum_]] = true
			end

			arg_7_0.beginDragPos_ = nil
		end
	end))
	arg_7_0.rotateTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		if arg_7_0.beginDragPos_ == nil then
			arg_7_0.beginDragPos_ = LuaHelper.ScreenToLocal(arg_7_0.stPanelTrs_, arg_19_1.position, manager.ui.uiCamera)
			arg_7_0.rotateVector_.x = arg_7_0.coordinateX_ / 2 - arg_7_0.selecting_.rectTransform_:GetAnchoredPositionX(nil)
			arg_7_0.rotateVector_.y = arg_7_0.coordinateY_ / 2 - arg_7_0.selecting_.rectTransform_:GetAnchoredPositionY(nil)
			arg_7_0.beginStickerPos_.x = arg_7_0.beginDragPos_.x + arg_7_0.rotateVector_.x
			arg_7_0.beginStickerPos_.y = arg_7_0.beginDragPos_.y + arg_7_0.rotateVector_.y
			arg_7_0.beginStickerAngleZ_ = arg_7_0.selecting_.rectTransform_:GetLocalEulerAngleZ()
			arg_7_0.beginStickerScale_ = arg_7_0.selecting_.rectTransform_:GetLocalScaleX()

			local var_19_0 = arg_7_0.selecting_.outlineRect_.sizeDelta * arg_7_0.selecting_.outlineRect_:GetLocalScaleX()

			arg_7_0.beginStickerSize_.x = var_19_0.x
			arg_7_0.beginStickerSize_.y = var_19_0.y
		end
	end))
	arg_7_0.rotateTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_20_0, arg_20_1)
		if arg_7_0.beginDragPos_ ~= nil then
			local var_20_0 = LuaHelper.ScreenToLocal(arg_7_0.stPanelTrs_, arg_20_1.position, manager.ui.uiCamera)
			local var_20_1 = var_20_0.x + arg_7_0.rotateVector_.x
			local var_20_2 = var_20_0.y + arg_7_0.rotateVector_.y
			local var_20_3 = var_0_1(arg_7_0.beginStickerPos_.x, arg_7_0.beginStickerPos_.y, var_20_1, var_20_2)

			if arg_7_0.beginStickerPos_.x * var_20_2 - arg_7_0.beginStickerPos_.y * var_20_1 > 0 then
				arg_7_0.selecting_.rectTransform_:SetLocalEulerAngleZ(arg_7_0.beginStickerAngleZ_ + var_20_3)
				arg_7_0.movePanelTrs_:SetLocalEulerAngleZ(arg_7_0.beginStickerAngleZ_ + var_20_3)
			else
				arg_7_0.selecting_.rectTransform_:SetLocalEulerAngleZ(arg_7_0.beginStickerAngleZ_ - var_20_3)
				arg_7_0.movePanelTrs_:SetLocalEulerAngleZ(arg_7_0.beginStickerAngleZ_ - var_20_3)
			end

			local var_20_4 = math.sqrt((var_20_1 * var_20_1 + var_20_2 * var_20_2) / (arg_7_0.beginStickerPos_.x * arg_7_0.beginStickerPos_.x + arg_7_0.beginStickerPos_.y * arg_7_0.beginStickerPos_.y))

			arg_7_0.selecting_.rectTransform_:SetLocalScaleVal(math.min(math.max(arg_7_0.beginStickerScale_ * var_20_4, arg_7_0.MinScaleNum), arg_7_0.MaxScaleNum))
			arg_7_0.movePanelTrs_:SetSizeDeltaEx(math.min(math.max(arg_7_0.beginStickerScale_ * var_20_4, arg_7_0.MinScaleNum), arg_7_0.MaxScaleNum) * arg_7_0.beginStickerSize_.x, math.min(math.max(arg_7_0.beginStickerScale_ * var_20_4, arg_7_0.MinScaleNum), arg_7_0.MaxScaleNum) * arg_7_0.beginStickerSize_.y)
		end
	end))
	arg_7_0.rotateTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_21_0, arg_21_1)
		if arg_7_0.beginDragPos_ ~= nil then
			if arg_7_0.selecting_ then
				arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].sticker[arg_7_0.selecting_.ID_].rotation = math.floor(arg_7_0.selecting_.rectTransform_:GetLocalEulerAngleZ() % 360 / 360 * 10000)
				arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].sticker[arg_7_0.selecting_.ID_].scale = math.floor(arg_7_0.selecting_.rectTransform_:GetLocalScaleX() / arg_7_0.MaxScaleNum * 10000)
				arg_7_0.changePageID_[arg_7_0.bgData_[arg_7_0.curPageNum_]] = true
			end

			arg_7_0.beginDragPos_ = nil
		end
	end))
	arg_7_0:AddBtnListener(arg_7_0.deleteBtn_, nil, function()
		if arg_7_0.selecting_ then
			SetActive(arg_7_0.selecting_.gameObject_, false)

			if arg_7_0.curTab_ == 1 then
				local var_22_0 = table.keyof(arg_7_0.tabFilterData_, arg_7_0.selecting_.ID_)

				if var_22_0 and var_22_0 > 0 then
					local var_22_1 = arg_7_0.stTabList_:GetItemByIndex(var_22_0)

					if var_22_1 then
						var_22_1:SetUse(false)
					end
				end
			end

			PlayerData:SetStickerPage(arg_7_0.selecting_.ID_, 0)

			arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].sticker[arg_7_0.selecting_.ID_] = nil

			local var_22_2 = {}

			for iter_22_0, iter_22_1 in ipairs(arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].hierarchy) do
				if iter_22_1 ~= arg_7_0.selecting_.ID_ then
					table.insert(var_22_2, iter_22_1)
				end
			end

			arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].hierarchy = var_22_2
			arg_7_0.changePageID_[arg_7_0.bgData_[arg_7_0.curPageNum_]] = true
			arg_7_0.deleteNum_ = arg_7_0.deleteNum_ + 1
			arg_7_0.stNumText_.text = arg_7_0.poolTailPoint_ - arg_7_0.deleteNum_ .. "/" .. arg_7_0.MaxStickerNum
			arg_7_0.selecting_ = nil
			arg_7_0.selectingIdx_ = 0

			SetActive(arg_7_0.movePanelTrs_.gameObject, false)
			SetActive(arg_7_0.cancelBtn_.gameObject, false)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, function()
		if arg_7_0.selecting_ then
			arg_7_0.selecting_ = nil
			arg_7_0.selectingIdx_ = 0

			SetActive(arg_7_0.movePanelTrs_.gameObject, false)
			SetActive(arg_7_0.cancelBtn_.gameObject, false)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.clearBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("STICKER_ONE_CLICK_CLEARING"),
			OkCallback = function()
				for iter_25_0, iter_25_1 in pairs(arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].sticker) do
					PlayerData:SetStickerPage(iter_25_0, 0)

					arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].sticker[iter_25_0] = nil
				end

				PlayerData:SetStickerFgPage(arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].foreground, 0)

				arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].foreground = 0
				arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].hierarchy = {}
				arg_7_0.changePageID_[arg_7_0.bgData_[arg_7_0.curPageNum_]] = true

				arg_7_0:UpdateView()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.onekeyUseBtn_, nil, function()
		local var_27_0 = arg_7_0.bgData_[arg_7_0.curPageNum_]
		local var_27_1 = arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]]
		local var_27_2 = StickerSuitCfg.get_id_list_by_page_id[var_27_0] and StickerSuitCfg.get_id_list_by_page_id[var_27_0][1]

		if not var_27_2 then
			return
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "userinfo_sticker_edit_onekey",
			other_data = string.format("{%d,%d}", var_27_0, var_27_2)
		})

		local var_27_3, var_27_4 = arg_7_0:GetStickerSuitCount(var_27_2)

		if var_27_3 <= 1 then
			ShowTips("STICKER_ONE_KEY_USE_LOCKED")

			return
		end

		local var_27_5 = StickerSuitCfg[var_27_2]
		local var_27_6 = {}
		local var_27_7 = {}
		local var_27_8 = var_27_1.foreground

		for iter_27_0, iter_27_1 in ipairs(var_27_5.sticker_temp) do
			local var_27_9 = iter_27_1[1]

			if PlayerData:GetSticker(var_27_9).lock then
				-- block empty
			else
				var_27_7[iter_27_1[5]] = var_27_9
				var_27_6[var_27_9] = {
					positionX = iter_27_1[2],
					positionY = iter_27_1[3],
					scale = iter_27_1[4],
					rotation = iter_27_1[6]
				}
			end
		end

		if var_27_5.foreground ~= 0 and PlayerData:GetStickerFg(var_27_5.foreground) ~= nil and not PlayerData:GetStickerFg(var_27_5.foreground).lock then
			var_27_8 = var_27_5.foreground
		end

		ShowMessageBox({
			content = GetTips("STICKER_ONE_KEY_USE_SURE"),
			OkCallback = function()
				local var_28_0 = PlayerData:GetStickerFg(var_27_8)

				if var_28_0 and var_28_0.page ~= 0 then
					arg_7_0.pageData_[var_28_0.page].foreground = 0
				end

				for iter_28_0, iter_28_1 in pairs(var_27_7) do
					local var_28_1 = PlayerData:GetSticker(iter_28_1)

					if var_28_1 and var_28_1.page ~= 0 then
						arg_7_0.pageData_[var_28_1.page].sticker[iter_28_1] = nil

						local var_28_2 = {}

						for iter_28_2, iter_28_3 in ipairs(arg_7_0.pageData_[var_28_1.page].hierarchy) do
							if iter_28_3 ~= iter_28_1 then
								table.insert(var_28_2, iter_28_3)
							end
						end

						arg_7_0.pageData_[var_28_1.page].hierarchy = var_28_2
					end
				end

				arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].foreground = var_27_8
				arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].hierarchy = var_27_7
				arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].sticker = var_27_6
				arg_7_0.changePageID_[arg_7_0.bgData_[arg_7_0.curPageNum_]] = true

				for iter_28_4, iter_28_5 in pairs(arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].sticker) do
					PlayerData:SetStickerPage(iter_28_4, var_27_0)
				end

				PlayerData:SetStickerFgPage(arg_7_0.pageData_[arg_7_0.bgData_[arg_7_0.curPageNum_]].foreground, var_27_0)
				arg_7_0:UpdateView()
			end
		})
	end)
end

function var_0_0.IndexTabItem(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = ProfileDecorateItemCfg[arg_29_0.tabFilterData_[arg_29_1]]
	local var_29_1 = false
	local var_29_2 = arg_29_0.curTab_ == 1 and PlayerData:GetSticker(arg_29_0.tabFilterData_[arg_29_1]) or PlayerData:GetStickerFg(arg_29_0.tabFilterData_[arg_29_1])
	local var_29_3 = var_29_2.page == arg_29_0.bgData_[arg_29_0.curPageNum_]
	local var_29_4 = false
	local var_29_5 = false
	local var_29_6 = false
	local var_29_7 = table.keyof(arg_29_0.bgData_, var_29_2.page) or 0

	arg_29_2:SetData(var_29_0, var_29_1, var_29_3, var_29_4, var_29_5, var_29_6, function()
		if arg_29_0.curTab_ == 1 and arg_29_0.poolTailPoint_ - arg_29_0.deleteNum_ >= arg_29_0.MaxStickerNum then
			ShowTips("STICKER_PAGE_LIMIT_COUNT")

			return
		end

		if var_29_2.page == 0 then
			arg_29_2:SetUse(true, arg_29_0.curPageNum_)

			if arg_29_0.curTab_ == 1 then
				var_29_2.page = arg_29_0.bgData_[arg_29_0.curPageNum_]

				PlayerData:SetStickerPage(arg_29_2.ID_, arg_29_0.bgData_[arg_29_0.curPageNum_])

				arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].sticker[arg_29_2.ID_] = {
					positionY = 5000,
					rotation = 0,
					positionX = 5000,
					scale = 10000 / arg_29_0.MaxScaleNum
				}

				table.insert(arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].hierarchy, arg_29_2.ID_)

				arg_29_0.changePageID_[arg_29_0.bgData_[arg_29_0.curPageNum_]] = true
				arg_29_0.poolTailPoint_ = arg_29_0.poolTailPoint_ + 1
				arg_29_0.stNumText_.text = arg_29_0.poolTailPoint_ - arg_29_0.deleteNum_ .. "/" .. arg_29_0.MaxStickerNum

				local var_30_0 = arg_29_0.poolTailPoint_

				if var_30_0 > #arg_29_0.stickerItemPool_ then
					local var_30_1 = Object.Instantiate(arg_29_0.stMoveGo_, arg_29_0.stPanelTrs_)

					arg_29_0.stickerItemPool_[var_30_0] = CustomStickerMoveItem.New(var_30_1)
				end

				SetActive(arg_29_0.stickerItemPool_[var_30_0].gameObject_, true)
				arg_29_0.stickerItemPool_[var_30_0].rectTransform_:SetAnchoredPositionEx(arg_29_0.coordinateX_ / 2, arg_29_0.coordinateY_ / 2)
				arg_29_0.stickerItemPool_[var_30_0].rectTransform_:SetLocalEulerAngleZ(0)
				arg_29_0.stickerItemPool_[var_30_0].rectTransform_:SetLocalScaleVal(1)
				arg_29_0.stickerItemPool_[var_30_0]:SetData(var_29_0, function()
					if arg_29_0.selectingIdx_ ~= var_30_0 then
						arg_29_0.selectingIdx_ = var_30_0
						arg_29_0.selecting_ = arg_29_0.stickerItemPool_[var_30_0]

						arg_29_0.selecting_.rectTransform_:SetAsLastSibling()

						local var_31_0 = {}

						for iter_31_0, iter_31_1 in ipairs(arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].hierarchy) do
							if iter_31_1 ~= arg_29_0.selecting_.ID_ then
								table.insert(var_31_0, iter_31_1)
							end
						end

						table.insert(var_31_0, arg_29_0.selecting_.ID_)

						arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].hierarchy = var_31_0
						arg_29_0.changePageID_[arg_29_0.bgData_[arg_29_0.curPageNum_]] = true

						arg_29_0.movePanelTrs_:SetAnchoredPosition(arg_29_0.selecting_.rectTransform_.anchoredPosition)
						arg_29_0.movePanelTrs_:SetSizeDelta(arg_29_0.selecting_.outlineRect_.sizeDelta * arg_29_0.selecting_.outlineRect_:GetLocalScaleX() * arg_29_0.selecting_.rectTransform_:GetLocalScaleX())
						arg_29_0.movePanelTrs_:SetLocalEulerAngleZ(arg_29_0.selecting_.rectTransform_:GetLocalEulerAngleZ())
						SetActive(arg_29_0.movePanelTrs_.gameObject, true)
						SetActive(arg_29_0.cancelBtn_.gameObject, true)
					end
				end)

				arg_29_0.selectingIdx_ = var_30_0
				arg_29_0.selecting_ = arg_29_0.stickerItemPool_[var_30_0]

				arg_29_0.selecting_.rectTransform_:SetAsLastSibling()
				arg_29_0.movePanelTrs_:SetAnchoredPosition(arg_29_0.selecting_.rectTransform_.anchoredPosition)
				arg_29_0.movePanelTrs_:SetSizeDelta(arg_29_0.selecting_.outlineRect_.sizeDelta * arg_29_0.selecting_.outlineRect_:GetLocalScaleX() * arg_29_0.selecting_.rectTransform_:GetLocalScaleX())
				arg_29_0.movePanelTrs_:SetLocalEulerAngleZ(arg_29_0.selecting_.rectTransform_:GetLocalEulerAngleZ())
				SetActive(arg_29_0.movePanelTrs_.gameObject, true)
				SetActive(arg_29_0.cancelBtn_.gameObject, true)
			elseif arg_29_0.curTab_ == 2 then
				var_29_2.page = arg_29_0.bgData_[arg_29_0.curPageNum_]

				PlayerData:SetStickerFgPage(arg_29_2.ID_, arg_29_0.bgData_[arg_29_0.curPageNum_])

				arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].foreground = arg_29_2.ID_
				arg_29_0.changePageID_[arg_29_0.bgData_[arg_29_0.curPageNum_]] = true

				arg_29_0:DestroyDynamicFg()

				if var_29_0.type == 1 then
					arg_29_0.fgStaticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_l/Stickerfg_l_" .. var_29_0.resource
					arg_29_0.fgStaticImg_.enabled = true
				elseif var_29_0.type == 2 then
					arg_29_0.curDynamicFg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Foreground/Foregrounditem_" .. var_29_0.resource), arg_29_0.fgDynamicTrs_)
					arg_29_0.fgStaticImg_.enabled = false
				end
			end
		elseif var_29_2.page ~= arg_29_0.bgData_[arg_29_0.curPageNum_] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("STICKER_SWITCH_PAGES"),
				OkCallback = function()
					arg_29_2:SetUse(true, arg_29_0.curPageNum_)

					if arg_29_0.curTab_ == 1 then
						arg_29_0.pageData_[var_29_2.page].sticker[arg_29_2.ID_] = nil

						local var_32_0 = {}

						for iter_32_0, iter_32_1 in ipairs(arg_29_0.pageData_[var_29_2.page].hierarchy) do
							if iter_32_1 ~= arg_29_2.ID_ then
								table.insert(var_32_0, iter_32_1)
							end
						end

						arg_29_0.pageData_[var_29_2.page].hierarchy = var_32_0
						arg_29_0.changePageID_[var_29_2.page] = true
						var_29_2.page = arg_29_0.bgData_[arg_29_0.curPageNum_]

						PlayerData:SetStickerPage(arg_29_2.ID_, arg_29_0.bgData_[arg_29_0.curPageNum_])

						arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].sticker[arg_29_2.ID_] = {
							positionY = 5000,
							rotation = 0,
							positionX = 5000,
							scale = 10000 / arg_29_0.MaxScaleNum
						}

						table.insert(arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].hierarchy, arg_29_2.ID_)

						arg_29_0.changePageID_[arg_29_0.bgData_[arg_29_0.curPageNum_]] = true
						arg_29_0.poolTailPoint_ = arg_29_0.poolTailPoint_ + 1
						arg_29_0.stNumText_.text = arg_29_0.poolTailPoint_ - arg_29_0.deleteNum_ .. "/" .. arg_29_0.MaxStickerNum

						local var_32_1 = arg_29_0.poolTailPoint_

						if var_32_1 > #arg_29_0.stickerItemPool_ then
							local var_32_2 = Object.Instantiate(arg_29_0.stMoveGo_, arg_29_0.stPanelTrs_)

							arg_29_0.stickerItemPool_[var_32_1] = CustomStickerMoveItem.New(var_32_2)
						end

						SetActive(arg_29_0.stickerItemPool_[var_32_1].gameObject_, true)
						arg_29_0.stickerItemPool_[var_32_1].rectTransform_:SetAnchoredPositionEx(arg_29_0.coordinateX_ / 2, arg_29_0.coordinateY_ / 2)
						arg_29_0.stickerItemPool_[var_32_1].rectTransform_:SetLocalEulerAngleZ(0)
						arg_29_0.stickerItemPool_[var_32_1].rectTransform_:SetLocalScaleVal(1)
						arg_29_0.stickerItemPool_[var_32_1]:SetData(var_29_0, function()
							if arg_29_0.selectingIdx_ ~= var_32_1 then
								arg_29_0.selectingIdx_ = var_32_1
								arg_29_0.selecting_ = arg_29_0.stickerItemPool_[var_32_1]

								arg_29_0.selecting_.rectTransform_:SetAsLastSibling()

								local var_33_0 = {}

								for iter_33_0, iter_33_1 in ipairs(arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].hierarchy) do
									if iter_33_1 ~= arg_29_0.selecting_.ID_ then
										table.insert(var_33_0, iter_33_1)
									end
								end

								table.insert(var_33_0, arg_29_0.selecting_.ID_)

								arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].hierarchy = var_33_0
								arg_29_0.changePageID_[arg_29_0.bgData_[arg_29_0.curPageNum_]] = true

								arg_29_0.movePanelTrs_:SetAnchoredPosition(arg_29_0.selecting_.rectTransform_.anchoredPosition)
								arg_29_0.movePanelTrs_:SetSizeDelta(arg_29_0.selecting_.outlineRect_.sizeDelta * arg_29_0.selecting_.outlineRect_:GetLocalScaleX() * arg_29_0.selecting_.rectTransform_:GetLocalScaleX())
								arg_29_0.movePanelTrs_:SetLocalEulerAngleZ(arg_29_0.selecting_.rectTransform_:GetLocalEulerAngleZ())
								SetActive(arg_29_0.movePanelTrs_.gameObject, true)
								SetActive(arg_29_0.cancelBtn_.gameObject, true)
							end
						end)

						arg_29_0.selectingIdx_ = var_32_1
						arg_29_0.selecting_ = arg_29_0.stickerItemPool_[var_32_1]

						arg_29_0.selecting_.rectTransform_:SetAsLastSibling()
						arg_29_0.movePanelTrs_:SetAnchoredPosition(arg_29_0.selecting_.rectTransform_.anchoredPosition)
						arg_29_0.movePanelTrs_:SetSizeDelta(arg_29_0.selecting_.outlineRect_.sizeDelta * arg_29_0.selecting_.outlineRect_:GetLocalScaleX() * arg_29_0.selecting_.rectTransform_:GetLocalScaleX())
						arg_29_0.movePanelTrs_:SetLocalEulerAngleZ(arg_29_0.selecting_.rectTransform_:GetLocalEulerAngleZ())
						SetActive(arg_29_0.movePanelTrs_.gameObject, true)
						SetActive(arg_29_0.cancelBtn_.gameObject, true)
					elseif arg_29_0.curTab_ == 2 then
						arg_29_0.pageData_[var_29_2.page].foreground = 0
						arg_29_0.changePageID_[var_29_2.page] = true
						var_29_2.page = arg_29_0.bgData_[arg_29_0.curPageNum_]

						PlayerData:SetStickerFgPage(arg_29_2.ID_, arg_29_0.bgData_[arg_29_0.curPageNum_])

						arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].foreground = arg_29_2.ID_
						arg_29_0.changePageID_[arg_29_0.bgData_[arg_29_0.curPageNum_]] = true

						arg_29_0:DestroyDynamicFg()

						if var_29_0.type == 1 then
							arg_29_0.fgStaticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_l/Stickerfg_l_" .. var_29_0.resource
							arg_29_0.fgStaticImg_.enabled = true
						elseif var_29_0.type == 2 then
							arg_29_0.curDynamicFg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Foreground/Foregrounditem_" .. var_29_0.resource), arg_29_0.fgDynamicTrs_)
							arg_29_0.fgStaticImg_.enabled = false
						end
					end
				end,
				CancelCallback = function()
					return
				end
			})
		elseif arg_29_0.curTab_ == 1 then
			local var_30_2

			for iter_30_0, iter_30_1 in ipairs(arg_29_0.stickerItemPool_) do
				if iter_30_1.ID_ == var_29_0.id and iter_30_1.gameObject_.activeSelf then
					var_30_2 = iter_30_0
				end
			end

			if not var_30_2 then
				return
			end

			arg_29_0.selectingIdx_ = var_30_2
			arg_29_0.selecting_ = arg_29_0.stickerItemPool_[var_30_2]

			arg_29_0.selecting_.rectTransform_:SetAsLastSibling()

			local var_30_3 = {}

			for iter_30_2, iter_30_3 in ipairs(arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].hierarchy) do
				if iter_30_3 ~= arg_29_0.selecting_.ID_ then
					table.insert(var_30_3, iter_30_3)
				end
			end

			table.insert(var_30_3, arg_29_0.selecting_.ID_)

			arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].hierarchy = var_30_3

			arg_29_0.movePanelTrs_:SetAnchoredPosition(arg_29_0.selecting_.rectTransform_.anchoredPosition)
			arg_29_0.movePanelTrs_:SetSizeDelta(arg_29_0.selecting_.outlineRect_.sizeDelta * arg_29_0.selecting_.outlineRect_:GetLocalScaleX() * arg_29_0.selecting_.rectTransform_:GetLocalScaleX())
			arg_29_0.movePanelTrs_:SetLocalEulerAngleZ(arg_29_0.selecting_.rectTransform_:GetLocalEulerAngleZ())
			SetActive(arg_29_0.movePanelTrs_.gameObject, true)
			SetActive(arg_29_0.cancelBtn_.gameObject, true)
		elseif arg_29_0.curTab_ == 2 then
			arg_29_2:SetUse(false)

			var_29_2.page = 0

			PlayerData:SetStickerFgPage(arg_29_2.ID_, 0)

			arg_29_0.pageData_[arg_29_0.bgData_[arg_29_0.curPageNum_]].foreground = 0
			arg_29_0.changePageID_[arg_29_0.bgData_[arg_29_0.curPageNum_]] = true

			arg_29_0:DestroyDynamicFg()

			arg_29_0.fgStaticImg_.enabled = false
		end
	end, nil, var_29_7)
end

function var_0_0.OnEnter(arg_35_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_35_0.filterMap_ = {}
	arg_35_0.filterState_ = false

	arg_35_0.colorController_:SetSelectedState("normal")
	arg_35_0.tabFilterPanel_:SetData(StickerSuitCfg.all, function(arg_36_0, arg_36_1)
		arg_35_0.filterMap_ = arg_36_0
		arg_35_0.filterState_ = not arg_36_1

		arg_35_0.colorController_:SetSelectedState(arg_35_0.filterState_ and "orange" or "normal")
		arg_35_0:RefreshTab(arg_35_0.curTab_)
	end)

	arg_35_0.bgData_ = PlayerData:GetStickerBgList()

	local var_35_0 = GameSetting.sticker_background_default.value[1]

	table.sort(arg_35_0.bgData_, function(arg_37_0, arg_37_1)
		if arg_37_0 == var_35_0 then
			return true
		end

		if arg_37_1 == var_35_0 then
			return false
		end

		return arg_37_0 < arg_37_1
	end)

	arg_35_0.pageData_ = PlayerData:GetStickerEditData()
	arg_35_0.allOriStickerData_[1] = PlayerData:GetStickerList()

	table.sort(arg_35_0.allOriStickerData_[1], function(arg_38_0, arg_38_1)
		local var_38_0 = PlayerData:GetSticker(arg_38_0)
		local var_38_1 = PlayerData:GetSticker(arg_38_1)

		if var_38_0.page == 0 and var_38_1.page == 0 or var_38_0.page ~= 0 and var_38_1.page ~= 0 then
			return arg_38_1 < arg_38_0
		end

		return var_38_0.page < var_38_1.page
	end)

	arg_35_0.allOriStickerData_[2] = PlayerData:GetStickerFgList()

	table.sort(arg_35_0.allOriStickerData_[2], function(arg_39_0, arg_39_1)
		local var_39_0 = PlayerData:GetStickerFg(arg_39_0)
		local var_39_1 = PlayerData:GetStickerFg(arg_39_1)

		if var_39_0.page == 0 and var_39_1.page == 0 or var_39_0.page ~= 0 and var_39_1.page ~= 0 then
			return arg_39_1 < arg_39_0
		end

		return var_39_0.page < var_39_1.page
	end)

	arg_35_0.changePageID_ = {}
	arg_35_0.maxPageNum_ = #arg_35_0.bgData_
	arg_35_0.curPageNum_ = getData("PlayerCustomStickerTriggered", "LastEditStickerPageNum") or 1
	arg_35_0.curTab_ = 1

	arg_35_0:UpdateView()
end

function var_0_0.RefreshTab(arg_40_0, arg_40_1)
	arg_40_0.curTab_ = arg_40_1

	if arg_40_1 == 1 then
		arg_40_0.tabFilterData_ = {}

		local var_40_0 = arg_40_0.allOriStickerData_[1]

		if arg_40_0.filterState_ then
			for iter_40_0, iter_40_1 in ipairs(var_40_0) do
				local var_40_1 = PlayerData:GetSticker(iter_40_1)

				if arg_40_0.filterMap_[var_40_1.suit] then
					table.insert(arg_40_0.tabFilterData_, iter_40_1)
				end
			end
		else
			arg_40_0.tabFilterData_ = var_40_0
		end

		arg_40_0.tabController_:SetSelectedState("sticker")
		arg_40_0.stTabList_:StartScroll(#arg_40_0.tabFilterData_)
	else
		arg_40_0.tabFilterData_ = {}

		local var_40_2 = arg_40_0.allOriStickerData_[2]

		if arg_40_0.filterState_ then
			for iter_40_2, iter_40_3 in ipairs(var_40_2) do
				local var_40_3 = PlayerData:GetStickerFg(iter_40_3)

				if arg_40_0.filterMap_[var_40_3.suit] then
					table.insert(arg_40_0.tabFilterData_, iter_40_3)
				end
			end
		else
			arg_40_0.tabFilterData_ = var_40_2
		end

		arg_40_0.tabController_:SetSelectedState("foreground")
		arg_40_0.fgTabList_:StartScroll(#arg_40_0.tabFilterData_)
	end
end

function var_0_0.UpdateView(arg_41_0)
	SetActive(arg_41_0.prePageBtn_.gameObject, arg_41_0.curPageNum_ > 1)
	SetActive(arg_41_0.nextPageBtn_.gameObject, arg_41_0.curPageNum_ < arg_41_0.maxPageNum_)
	arg_41_0:RefreshTab(arg_41_0.curTab_)

	arg_41_0.bgNameText_.text = ItemTools.getItemName(arg_41_0.bgData_[arg_41_0.curPageNum_])
	arg_41_0.pageNumText_.text = arg_41_0.curPageNum_ .. "/" .. arg_41_0.maxPageNum_

	if arg_41_0.selecting_ then
		arg_41_0.selecting_ = nil
		arg_41_0.selectingIdx_ = 0

		SetActive(arg_41_0.movePanelTrs_.gameObject, false)
		SetActive(arg_41_0.cancelBtn_.gameObject, false)
	end

	if PlayerData:GetStickerShowID() == arg_41_0.bgData_[arg_41_0.curPageNum_] then
		arg_41_0.favoriteController_:SetSelectedState("star")
	else
		arg_41_0.favoriteController_:SetSelectedState("none")
	end

	local var_41_0 = arg_41_0.pageData_[arg_41_0.bgData_[arg_41_0.curPageNum_]]

	arg_41_0:DestroyDynamicBg()

	arg_41_0.bgStaticImg_.enabled = false

	if var_41_0 then
		local var_41_1 = ProfileDecorateItemCfg[arg_41_0.bgData_[arg_41_0.curPageNum_]]

		if var_41_1 then
			if var_41_1.type == 1 then
				arg_41_0.bgStaticImg_.spriteAsync = "TextureConfig/Sticker/Background_l/Stickerbg_l_" .. var_41_1.resource
				arg_41_0.bgStaticImg_.enabled = true
			elseif var_41_1.type == 2 then
				arg_41_0.curDynamicBg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Bg/Bgitem_" .. var_41_1.resource), arg_41_0.bgDynamicTrs_)
				arg_41_0.bgStaticImg_.enabled = false
				arg_41_0.curDynamicTopBg_ = arg_41_0.curDynamicBg_.transform:Find("TopPart")

				if arg_41_0.curDynamicTopBg_ then
					arg_41_0.curDynamicTopBg_:SetParent(arg_41_0.TopBgTrs_)

					arg_41_0.curDynamicTopBg_ = arg_41_0.curDynamicTopBg_.gameObject
				end
			end
		end
	end

	arg_41_0:DestroyDynamicFg()

	arg_41_0.fgStaticImg_.enabled = false

	if var_41_0.foreground ~= 0 then
		local var_41_2 = ProfileDecorateItemCfg[var_41_0.foreground]

		if var_41_2 then
			if var_41_2.type == 1 then
				arg_41_0.fgStaticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_l/Stickerfg_l_" .. var_41_2.resource
				arg_41_0.fgStaticImg_.enabled = true
			elseif var_41_2.type == 2 then
				arg_41_0.curDynamicFg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Foreground/Foregrounditem_" .. var_41_2.resource), arg_41_0.fgDynamicTrs_)
				arg_41_0.fgStaticImg_.enabled = false
			end
		end
	end

	local var_41_3 = 1

	for iter_41_0, iter_41_1 in pairs(var_41_0.hierarchy) do
		local var_41_4 = ProfileDecorateItemCfg[iter_41_1]
		local var_41_5 = var_41_0.sticker[iter_41_1]

		if var_41_4 then
			if not arg_41_0.stickerItemPool_[var_41_3] then
				local var_41_6 = Object.Instantiate(arg_41_0.stMoveGo_, arg_41_0.stPanelTrs_)

				arg_41_0.stickerItemPool_[var_41_3] = CustomStickerMoveItem.New(var_41_6)
			end

			SetActive(arg_41_0.stickerItemPool_[var_41_3].gameObject_, true)

			local var_41_7 = var_41_3

			arg_41_0.stickerItemPool_[var_41_3]:SetData(var_41_4, function()
				if arg_41_0.selectingIdx_ ~= var_41_7 then
					arg_41_0.selectingIdx_ = var_41_7
					arg_41_0.selecting_ = arg_41_0.stickerItemPool_[var_41_7]

					arg_41_0.selecting_.rectTransform_:SetAsLastSibling()

					local var_42_0 = {}

					for iter_42_0, iter_42_1 in ipairs(arg_41_0.pageData_[arg_41_0.bgData_[arg_41_0.curPageNum_]].hierarchy) do
						if iter_42_1 ~= arg_41_0.selecting_.ID_ then
							table.insert(var_42_0, iter_42_1)
						end
					end

					table.insert(var_42_0, arg_41_0.selecting_.ID_)

					arg_41_0.pageData_[arg_41_0.bgData_[arg_41_0.curPageNum_]].hierarchy = var_42_0
					arg_41_0.changePageID_[arg_41_0.bgData_[arg_41_0.curPageNum_]] = true

					arg_41_0.movePanelTrs_:SetAnchoredPosition(arg_41_0.selecting_.rectTransform_.anchoredPosition)
					arg_41_0.movePanelTrs_:SetSizeDelta(arg_41_0.selecting_.outlineRect_.sizeDelta * arg_41_0.selecting_.outlineRect_:GetLocalScaleX() * arg_41_0.selecting_.rectTransform_:GetLocalScaleX())
					arg_41_0.movePanelTrs_:SetLocalEulerAngleZ(arg_41_0.selecting_.rectTransform_:GetLocalEulerAngleZ())
					SetActive(arg_41_0.movePanelTrs_.gameObject, true)
					SetActive(arg_41_0.cancelBtn_.gameObject, true)
				end
			end)

			local var_41_8 = var_41_5.positionX / 10000 * arg_41_0.coordinateX_
			local var_41_9 = var_41_5.positionY / 10000 * arg_41_0.coordinateY_
			local var_41_10 = var_41_5.rotation / 10000 * 360
			local var_41_11 = var_41_5.scale / 10000 * arg_41_0.MaxScaleNum

			arg_41_0.stickerItemPool_[var_41_3].rectTransform_:SetAnchoredPositionEx(var_41_8, var_41_9)
			arg_41_0.stickerItemPool_[var_41_3].rectTransform_:SetLocalEulerAngleZ(var_41_10)
			arg_41_0.stickerItemPool_[var_41_3].rectTransform_:SetLocalScaleVal(var_41_11)
			arg_41_0.stickerItemPool_[var_41_3].rectTransform_:SetAsLastSibling()

			var_41_3 = var_41_3 + 1
		end
	end

	arg_41_0.poolTailPoint_ = var_41_3 - 1
	arg_41_0.deleteNum_ = 0
	arg_41_0.stNumText_.text = arg_41_0.poolTailPoint_ - arg_41_0.deleteNum_ .. "/" .. arg_41_0.MaxStickerNum

	while var_41_3 <= #arg_41_0.stickerItemPool_ do
		if arg_41_0.stickerItemPool_[var_41_3] then
			SetActive(arg_41_0.stickerItemPool_[var_41_3].gameObject_, false)
		end

		var_41_3 = var_41_3 + 1
	end

	local var_41_12 = arg_41_0.bgData_[arg_41_0.curPageNum_]
	local var_41_13 = StickerSuitCfg.get_id_list_by_page_id[var_41_12] and StickerSuitCfg.get_id_list_by_page_id[var_41_12][1]
	local var_41_14, var_41_15 = arg_41_0:GetStickerSuitCount(var_41_13)

	if var_41_13 then
		arg_41_0.onekeyUseText_.text = string.format("%d/%d", var_41_14, var_41_15)

		arg_41_0.useBtnController_:SetSelectedIndex(0)
	else
		arg_41_0.useBtnController_:SetSelectedIndex(2)
	end
end

function var_0_0.GetStickerSuitCount(arg_43_0, arg_43_1)
	local var_43_0 = StickerSuitCfg[arg_43_1]

	if not var_43_0 then
		return 0, 0
	end

	local var_43_1 = 0
	local var_43_2 = #var_43_0.content

	for iter_43_0, iter_43_1 in ipairs(var_43_0.content) do
		local var_43_3 = ProfileDecorateItemCfg[iter_43_1]

		if var_43_3.item_type == 4 then
			if not PlayerData:GetStickerBg(iter_43_1).lock then
				var_43_1 = var_43_1 + 1
			end
		elseif var_43_3.item_type == 5 then
			if not PlayerData:GetSticker(iter_43_1).lock then
				var_43_1 = var_43_1 + 1
			end
		elseif var_43_3.item_type == 6 and not PlayerData:GetStickerFg(iter_43_1).lock then
			var_43_1 = var_43_1 + 1
		end
	end

	return var_43_1, var_43_2
end

function var_0_0.OnTop(arg_44_0)
	return
end

function var_0_0.DestroyDynamicFg(arg_45_0)
	if arg_45_0.curDynamicFg_ then
		Object.Destroy(arg_45_0.curDynamicFg_)

		arg_45_0.curDynamicFg_ = nil
	end
end

function var_0_0.DestroyDynamicBg(arg_46_0)
	if arg_46_0.curDynamicBg_ then
		Object.Destroy(arg_46_0.curDynamicBg_)

		arg_46_0.curDynamicBg_ = nil
	end

	if arg_46_0.curDynamicTopBg_ then
		Object.Destroy(arg_46_0.curDynamicTopBg_)

		arg_46_0.curDynamicTopBg_ = nil
	end
end

function var_0_0.OnExit(arg_47_0)
	manager.windowBar:HideBar()
	saveData("PlayerCustomStickerTriggered", "LastEditStickerPageNum", arg_47_0.curPageNum_)

	if arg_47_0.selecting_ then
		arg_47_0.selecting_ = nil
		arg_47_0.selectingIdx_ = 0

		SetActive(arg_47_0.movePanelTrs_.gameObject, false)
		SetActive(arg_47_0.cancelBtn_.gameObject, false)
	end

	PlayerAction.SyncStickerPageUpdateToServer(arg_47_0.pageData_, arg_47_0.changePageID_)
end

function var_0_0.Dispose(arg_48_0)
	arg_48_0:RemoveAllListeners()
	arg_48_0:DestroyDynamicFg()
	arg_48_0:DestroyDynamicBg()
	arg_48_0.tabFilterPanel_:Dispose()
	arg_48_0.stTabList_:Dispose()
	arg_48_0.fgTabList_:Dispose()

	for iter_48_0 = 1, #arg_48_0.stickerItemPool_ do
		if arg_48_0.stickerItemPool_[iter_48_0] then
			arg_48_0.stickerItemPool_[iter_48_0]:Dispose()

			arg_48_0.stickerItemPool_[iter_48_0] = nil
		end
	end

	var_0_0.super.Dispose(arg_48_0)
end

function ExportCustomStickerEditTempConfig()
	local var_49_0 = gameContext:GetOpenPageHandler("customStickerEdit")

	if var_49_0 then
		var_49_0:ExportSuitTempConfig()
	else
		error("Plz Open CustomStickerEditView First")
	end
end

function var_0_0.ExportSuitTempConfig(arg_50_0)
	local var_50_0 = arg_50_0.pageData_[arg_50_0.bgData_[arg_50_0.curPageNum_]]

	if var_50_0 == nil then
		error("can not find CustomStickerEditView Config")

		return
	end

	local var_50_1 = {}

	for iter_50_0, iter_50_1 in ipairs(var_50_0.hierarchy) do
		table.insert(var_50_1, {
			sticker_id = iter_50_1,
			location_x = var_50_0.sticker[iter_50_1].positionX,
			location_y = var_50_0.sticker[iter_50_1].positionY,
			scale = var_50_0.sticker[iter_50_1].scale,
			layer = iter_50_0,
			rotate = var_50_0.sticker[iter_50_1].rotation
		})
	end

	local var_50_2 = ""

	for iter_50_2, iter_50_3 in ipairs(var_50_1) do
		if iter_50_2 ~= 1 then
			var_50_2 = var_50_2 .. ","
		end

		var_50_2 = var_50_2 .. string.format("[%d,%d,%d,%d,%d,%d]", iter_50_3.sticker_id, iter_50_3.location_x, iter_50_3.location_y, iter_50_3.scale, iter_50_3.layer, iter_50_3.rotate)
	end

	local var_50_3 = string.format("[%s]", var_50_2)

	print("前景Id : " .. var_50_0.foreground)
	print("贴纸配置 : " .. var_50_3)

	return var_50_1
end

return var_0_0
