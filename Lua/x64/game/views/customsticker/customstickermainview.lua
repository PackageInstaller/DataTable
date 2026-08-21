local var_0_0 = class("CustomStickerMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/sticker_new/StickerMainUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.MaxScaleNum = GameSetting.sticker_scaling.value[2]
	arg_4_0.curPageNum_ = 1
	arg_4_0.maxPageNum_ = 1
	arg_4_0.stickerTrsPool_ = {}
	arg_4_0.bgEditing_ = false
	arg_4_0.curDynamicFg_ = nil
	arg_4_0.curDynamicBg_ = nil
	arg_4_0.curDynamicTopBg_ = nil
	arg_4_0.pageData_ = {}
	arg_4_0.bgData_ = {}
	arg_4_0.bgList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.bgUIList_, CustomStickerListItem)
	arg_4_0.snapPanel_ = CustomStickerSnapPanel.New(arg_4_0.snapGo_)
	arg_4_0.sharePanel_ = CustomStickerSharePanel.New(arg_4_0.shareGo_, function()
		arg_4_0:RefreshBar()
	end)
	arg_4_0.editBgController_ = arg_4_0.mainControllerEx_:GetController("editBg")
	arg_4_0.favoriteController_ = arg_4_0.mainControllerEx_:GetController("favorite")
	arg_4_0.foreignController_ = arg_4_0.mainControllerEx_:GetController("foreign")
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.changeBgBtn_, nil, function()
		if not arg_6_0.bgEditing_ then
			arg_6_0.bgEditing_ = true

			arg_6_0.editBgController_:SetSelectedState("true")
			arg_6_0.bgList_:StartScroll(#arg_6_0.bgData_)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgRetBtn_, nil, function()
		if arg_6_0.bgEditing_ then
			arg_6_0.bgEditing_ = false

			arg_6_0.editBgController_:SetSelectedState("false")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.prePageBtn_, nil, function()
		if arg_6_0.curPageNum_ > 1 then
			arg_6_0.curPageNum_ = arg_6_0.curPageNum_ - 1

			arg_6_0:UpdateView()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.nextPageBtn_, nil, function()
		if arg_6_0.curPageNum_ < arg_6_0.maxPageNum_ then
			arg_6_0.curPageNum_ = arg_6_0.curPageNum_ + 1

			arg_6_0:UpdateView()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.bookletBtn_, nil, function()
		JumpTools.OpenPageByJump("/customStickerCollect")
	end)
	arg_6_0:AddBtnListener(arg_6_0.editBtn_, nil, function()
		JumpTools.OpenPageByJump("/customStickerEdit", {
			page = arg_6_0.curPageNum_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.favoriteBtn_, nil, function()
		if PlayerData:GetStickerShowID() ~= arg_6_0.bgData_[arg_6_0.curPageNum_] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("STICKER_EXHIBITION_CONFIRM"),
				OkCallback = function()
					PlayerAction.SyncStickerShowToServer(arg_6_0.bgData_[arg_6_0.curPageNum_])
					arg_6_0.favoriteController_:SetSelectedState("star")
				end,
				CancelCallback = function()
					return
				end
			})
		else
			ShowTips(GetTips("STICKER_EXHIBITION_ALREADY"))
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.shareBtn_, nil, function()
		arg_6_0.foreignController_:SetSelectedState("true")
		manager.windowBar:HideBar()
		arg_6_0.snapPanel_:Snap(function()
			arg_6_0.foreignController_:SetSelectedState("false")
			arg_6_0.sharePanel_:OnSnape()
		end)
	end)
end

function var_0_0.IndexItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = ProfileDecorateItemCfg[arg_18_0.bgData_[arg_18_1]]
	local var_18_1 = arg_18_0.curPageNum_ == arg_18_1
	local var_18_2 = PlayerData:GetStickerShowID() == arg_18_0.bgData_[arg_18_1]
	local var_18_3 = true
	local var_18_4 = false
	local var_18_5 = false

	arg_18_2:SetData(var_18_0, var_18_1, var_18_2, var_18_3, var_18_4, var_18_5, function()
		local var_19_0 = arg_18_0.bgList_:GetItemByIndex(arg_18_0.curPageNum_)

		if var_19_0 then
			var_19_0:Select(false)
		end

		arg_18_2:Select(true)

		arg_18_0.curPageNum_ = arg_18_1

		arg_18_0:UpdateView()
	end)
end

function var_0_0.RefreshBar(arg_20_0)
	if arg_20_0.params_.foreign then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})

		return
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_20_0.bgEditing_ then
			arg_20_0.bgEditing_ = false

			arg_20_0.editBgController_:SetSelectedState("false")
		else
			JumpTools.Back()
		end
	end)

	local var_20_0 = GameSetting.custom_sticker_info_describe.value

	if #var_20_0 > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "/gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = var_20_0
			}
		})
	end
end

function var_0_0.OnEnter(arg_22_0)
	SetActive(arg_22_0.shareBtn_.gameObject, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
	arg_22_0:RefreshBar()

	if arg_22_0.params_.foreign then
		arg_22_0.bgData_ = {}
		arg_22_0.pageData_ = arg_22_0.params_.foreign

		for iter_22_0, iter_22_1 in pairs(arg_22_0.pageData_) do
			arg_22_0.bgData_[1] = iter_22_0

			break
		end

		if not arg_22_0.bgData_[1] then
			arg_22_0.bgData_[1] = GameSetting.sticker_background_default.value[1]
			arg_22_0.pageData_[arg_22_0.bgData_[1]] = {
				foreground = 0,
				sticker = {},
				hierarchy = {}
			}
		end

		arg_22_0.maxPageNum_ = 1
		arg_22_0.curPageNum_ = 1

		arg_22_0.foreignController_:SetSelectedState("true")
	else
		arg_22_0.bgData_ = PlayerData:GetStickerBgList()

		local var_22_0 = GameSetting.sticker_background_default.value[1]

		table.sort(arg_22_0.bgData_, function(arg_23_0, arg_23_1)
			if arg_23_0 == var_22_0 then
				return true
			end

			if arg_23_1 == var_22_0 then
				return false
			end

			return arg_23_0 < arg_23_1
		end)

		arg_22_0.pageData_ = PlayerData:GetStickerEditData()
		arg_22_0.maxPageNum_ = #arg_22_0.bgData_
		arg_22_0.curPageNum_ = getData("PlayerCustomStickerTriggered", "LastEditStickerPageNum") or 1
		arg_22_0.curPageNum_ = math.min(arg_22_0.maxPageNum_, arg_22_0.curPageNum_)

		arg_22_0.foreignController_:SetSelectedState("false")
	end

	arg_22_0:UpdateView()
	arg_22_0.sharePanel_:OnEnter()
	manager.redPoint:bindUIandKey(arg_22_0.bookletBtn_.transform, RedPointConst.CUSTOM_STICKER_ROOT)
end

function var_0_0.UpdateView(arg_24_0)
	SetActive(arg_24_0.prePageBtn_.gameObject, arg_24_0.curPageNum_ > 1)
	SetActive(arg_24_0.nextPageBtn_.gameObject, arg_24_0.curPageNum_ < arg_24_0.maxPageNum_)

	arg_24_0.bgNameText_.text = ItemTools.getItemName(arg_24_0.bgData_[arg_24_0.curPageNum_])
	arg_24_0.pageNumText_.text = arg_24_0.curPageNum_ .. "/" .. arg_24_0.maxPageNum_

	if PlayerData:GetStickerShowID() == arg_24_0.bgData_[arg_24_0.curPageNum_] then
		arg_24_0.favoriteController_:SetSelectedState("star")
	else
		arg_24_0.favoriteController_:SetSelectedState("none")
	end

	local var_24_0 = manager.ui:GetCanvasSize()
	local var_24_1 = arg_24_0.pageData_[arg_24_0.bgData_[arg_24_0.curPageNum_]]

	arg_24_0:DestroyDynamicGo()

	arg_24_0.bgStaticImg_.enabled = false

	if var_24_1 then
		local var_24_2 = ProfileDecorateItemCfg[arg_24_0.bgData_[arg_24_0.curPageNum_]]

		if var_24_2 then
			if var_24_2.type == 1 then
				arg_24_0.bgStaticImg_.spriteAsync = "TextureConfig/Sticker/Background_l/Stickerbg_l_" .. var_24_2.resource
				arg_24_0.bgStaticImg_.enabled = true
			elseif var_24_2.type == 2 then
				arg_24_0.curDynamicBg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Bg/Bgitem_" .. var_24_2.resource), arg_24_0.bgDynamicTrs_)
				arg_24_0.bgStaticImg_.enabled = false
				arg_24_0.curDynamicTopBg_ = arg_24_0.curDynamicBg_.transform:Find("TopPart")

				if arg_24_0.curDynamicTopBg_ then
					arg_24_0.curDynamicTopBg_:SetParent(arg_24_0.topBgTrs_)

					arg_24_0.curDynamicTopBg_ = arg_24_0.curDynamicTopBg_.gameObject
				end
			end
		end
	end

	arg_24_0.fgStaticImg_.enabled = false

	if var_24_1.foreground ~= 0 then
		local var_24_3 = ProfileDecorateItemCfg[var_24_1.foreground]

		if var_24_3 then
			if var_24_3.type == 1 then
				arg_24_0.fgStaticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_l/Stickerfg_l_" .. var_24_3.resource
				arg_24_0.fgStaticImg_.enabled = true
			elseif var_24_3.type == 2 then
				arg_24_0.curDynamicFg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Foreground/Foregrounditem_" .. var_24_3.resource), arg_24_0.fgDynamicTrs_)
				arg_24_0.fgStaticImg_.enabled = false
			end
		end
	end

	local var_24_4 = 1

	for iter_24_0, iter_24_1 in pairs(var_24_1.hierarchy) do
		local var_24_5 = ProfileDecorateItemCfg[iter_24_1]
		local var_24_6 = var_24_1.sticker[iter_24_1]

		if var_24_5 then
			if not arg_24_0.stickerTrsPool_[var_24_4] then
				local var_24_7 = Object.Instantiate(arg_24_0.stMoveGo_, arg_24_0.customPanelTrs_)

				arg_24_0.stickerTrsPool_[var_24_4] = CustomStickerMoveItem.New(var_24_7)
			end

			SetActive(arg_24_0.stickerTrsPool_[var_24_4].gameObject_, true)
			arg_24_0.stickerTrsPool_[var_24_4]:SetData(var_24_5)

			local var_24_8 = var_24_6.positionX / 10000 * var_24_0.x
			local var_24_9 = var_24_6.positionY / 10000 * var_24_0.y
			local var_24_10 = var_24_6.rotation / 10000 * 360
			local var_24_11 = var_24_6.scale / 10000 * arg_24_0.MaxScaleNum

			arg_24_0.stickerTrsPool_[var_24_4].rectTransform_:SetAnchoredPositionEx(var_24_8, var_24_9)
			arg_24_0.stickerTrsPool_[var_24_4].rectTransform_:SetLocalEulerAngleZ(var_24_10)
			arg_24_0.stickerTrsPool_[var_24_4].rectTransform_:SetLocalScaleVal(var_24_11)
			arg_24_0.stickerTrsPool_[var_24_4].rectTransform_:SetAsLastSibling()

			var_24_4 = var_24_4 + 1
		end
	end

	while var_24_4 <= #arg_24_0.stickerTrsPool_ do
		if arg_24_0.stickerTrsPool_[var_24_4] then
			SetActive(arg_24_0.stickerTrsPool_[var_24_4].gameObject_, false)
		end

		var_24_4 = var_24_4 + 1
	end
end

function var_0_0.DestroyDynamicGo(arg_25_0)
	if arg_25_0.curDynamicFg_ then
		Object.Destroy(arg_25_0.curDynamicFg_)

		arg_25_0.curDynamicFg_ = nil
	end

	if arg_25_0.curDynamicBg_ then
		Object.Destroy(arg_25_0.curDynamicBg_)

		arg_25_0.curDynamicBg_ = nil
	end

	if arg_25_0.curDynamicTopBg_ then
		Object.Destroy(arg_25_0.curDynamicTopBg_)

		arg_25_0.curDynamicTopBg_ = nil
	end
end

function var_0_0.OnExit(arg_26_0)
	manager.windowBar:HideBar()
	saveData("PlayerCustomStickerTriggered", "LastEditStickerPageNum", arg_26_0.curPageNum_)
	arg_26_0.sharePanel_:OnExit()
	manager.redPoint:unbindUIandKey(arg_26_0.bookletBtn_.transform, RedPointConst.CUSTOM_STICKER_ROOT)
end

function var_0_0.Dispose(arg_27_0)
	arg_27_0:RemoveAllListeners()
	arg_27_0:DestroyDynamicGo()

	if arg_27_0.bgList_ then
		arg_27_0.bgList_:Dispose()

		arg_27_0.bgList_ = nil
	end

	if arg_27_0.snapPanel_ then
		arg_27_0.snapPanel_:Dispose()

		arg_27_0.snapPanel_ = nil
	end

	if arg_27_0.sharePanel_ then
		arg_27_0.sharePanel_:Dispose()

		arg_27_0.sharePanel_ = nil
	end

	for iter_27_0 = 1, #arg_27_0.stickerTrsPool_ do
		if arg_27_0.stickerTrsPool_[iter_27_0] then
			arg_27_0.stickerTrsPool_[iter_27_0]:Dispose()

			arg_27_0.stickerTrsPool_[iter_27_0] = nil
		end
	end

	var_0_0.super.Dispose(arg_27_0)
end

return var_0_0
