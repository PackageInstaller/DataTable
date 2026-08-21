local var_0_0 = class("CustomStickerCollectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/sticker_new/StickerCollectUI"
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

	arg_4_0.mainPageNum_ = 1
	arg_4_0.subPageNum_ = 1
	arg_4_0.tabFilterPanel_ = CustomStickerFilterPanel.New(arg_4_0.filterPanelGo_)
	arg_4_0.tabFilterSuitMap_ = {}
	arg_4_0.filterGetState_ = 0
	arg_4_0.filterDescendState_ = true
	arg_4_0.filterMap_ = {}
	arg_4_0.filterState_ = false
	arg_4_0.rightListData_ = {}
	arg_4_0.suitList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexSuitItem), arg_4_0.suitUIList_, CustomStickerCollectSuitItem)
	arg_4_0.stList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexListItem), arg_4_0.stUIList_, CustomStickerListItem)
	arg_4_0.fgList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexListItem), arg_4_0.fgUIList_, CustomStickerListItem)
	arg_4_0.bgList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexListItem), arg_4_0.bgUIList_, CustomStickerListItem)
	arg_4_0.mainTabController_ = arg_4_0.mainControllerEx_:GetController("mainTab")
	arg_4_0.subTabController_ = arg_4_0.mainControllerEx_:GetController("subTab")
	arg_4_0.collectController_ = arg_4_0.mainControllerEx_:GetController("collect")
	arg_4_0.colorController_ = arg_4_0.filterController_:GetController("color")
	arg_4_0.sortController_ = arg_4_0.orderControllerEx_:GetController("sort")

	arg_4_0:InitDropdownData()
end

function var_0_0.InitDropdownData(arg_5_0)
	arg_5_0.filterDd_.options:Clear()
	arg_5_0.filterDd_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("ALL"), nil))
	arg_5_0.filterDd_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("ACQUIRED"), nil))
	arg_5_0.filterDd_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("NOTACQUIRED"), nil))
	arg_5_0.filterDd_:RefreshShownValue()
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.main1Btn_, nil, function()
		if arg_6_0.mainPageNum_ ~= 1 then
			PlayerData:ClearStickerCollectPageRedPoint(arg_6_0.subPageNum_)
			arg_6_0:RefreshMainPage(1)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.main2Btn_, nil, function()
		if arg_6_0.mainPageNum_ ~= 2 then
			PlayerData:ClearStickerCollectPageRedPoint(0)
			arg_6_0:RefreshMainPage(2)
		end
	end)

	for iter_6_0 = 1, 3 do
		arg_6_0:AddBtnListener(arg_6_0["sub" .. iter_6_0 .. "Btn_"], nil, function()
			if arg_6_0.subPageNum_ ~= iter_6_0 then
				PlayerData:ClearStickerCollectPageRedPoint(arg_6_0.subPageNum_)
				arg_6_0:RefreshSubPage(iter_6_0)
			end
		end)
	end

	arg_6_0:AddBtnListener(arg_6_0.filterBtn_, nil, function()
		arg_6_0.tabFilterPanel_:OpenPanel()
	end)
	arg_6_0:AddBtnListener(arg_6_0.orderBtn_, nil, function()
		if arg_6_0.filterDescendState_ then
			arg_6_0.filterDescendState_ = false

			arg_6_0.sortController_:SetSelectedState("up")
			arg_6_0:RefreshSubPage(arg_6_0.subPageNum_)
		else
			arg_6_0.filterDescendState_ = true

			arg_6_0.sortController_:SetSelectedState("down")
			arg_6_0:RefreshSubPage(arg_6_0.subPageNum_)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.tipsBtn_, nil, function()
		if arg_6_0.collectController_:GetSelectedState() == "close" then
			arg_6_0.collectController_:SetSelectedState("open")
		elseif arg_6_0.collectController_:GetSelectedState() == "open" then
			arg_6_0.collectController_:SetSelectedState("close")
		end
	end)
	arg_6_0:AddToggleListener(arg_6_0.filterDd_, function(arg_13_0)
		arg_6_0.filterGetState_ = arg_13_0

		arg_6_0:RefreshSubPage(arg_6_0.subPageNum_)
	end)
end

function var_0_0.IndexSuitItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_0.rightListData_[arg_14_1])
end

function var_0_0.IndexListItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = ProfileDecorateItemCfg[arg_15_0.rightListData_[arg_15_1]]
	local var_15_1 = false
	local var_15_2 = false
	local var_15_3 = true
	local var_15_4 = false
	local var_15_5

	if arg_15_0.subPageNum_ == 1 then
		var_15_4 = PlayerData:GetSticker(arg_15_0.rightListData_[arg_15_1]).lock

		function var_15_5()
			JumpTools.OpenPageByJump("customStickerCollectPop", {
				stickerID = var_15_0.id
			})
		end
	elseif arg_15_0.subPageNum_ == 2 then
		var_15_4 = PlayerData:GetStickerBg(arg_15_0.rightListData_[arg_15_1]).lock

		function var_15_5()
			JumpTools.OpenPageByJump("customStickerCollectPop", {
				stickerID = var_15_0.id
			})
		end
	elseif arg_15_0.subPageNum_ == 3 then
		var_15_4 = PlayerData:GetStickerFg(arg_15_0.rightListData_[arg_15_1]).lock

		function var_15_5()
			JumpTools.OpenPageByJump("customStickerCollectPop", {
				stickerID = var_15_0.id
			})
		end
	end

	local var_15_6 = false

	arg_15_2:SetData(var_15_0, var_15_1, var_15_2, var_15_3, var_15_4, var_15_6, var_15_5, true)
end

function var_0_0.OnEnter(arg_19_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_19_0.filterMap_ = {}
	arg_19_0.filterState_ = false

	arg_19_0.colorController_:SetSelectedState("normal")
	arg_19_0.tabFilterPanel_:SetData(StickerSuitCfg.all, function(arg_20_0, arg_20_1)
		arg_19_0.filterMap_ = arg_20_0
		arg_19_0.filterState_ = not arg_20_1

		arg_19_0.colorController_:SetSelectedState(arg_19_0.filterState_ and "orange" or "normal")
		arg_19_0:RefreshSubPage(arg_19_0.subPageNum_)
	end)
	arg_19_0:RefreshMainPage(1)
	arg_19_0:RefreshCollectTips()
	manager.redPoint:bindUIandKey(arg_19_0.main1Btn_.transform, RedPointConst.CUSTOM_STICKER_SUIT_REWARD)
	manager.redPoint:bindUIandKey(arg_19_0.main2Btn_.transform, RedPointConst.CUSTOM_STICKER_CATEGORY)
	manager.redPoint:bindUIandKey(arg_19_0.sub1Btn_.transform, RedPointConst.CUSTOM_STICKER_ST)
	manager.redPoint:bindUIandKey(arg_19_0.sub2Btn_.transform, RedPointConst.CUSTOM_STICKER_BG)
	manager.redPoint:bindUIandKey(arg_19_0.sub3Btn_.transform, RedPointConst.CUSTOM_STICKER_FG)
end

function var_0_0.RefreshCollectTips(arg_21_0)
	local var_21_0 = #PlayerData:GetStickerList(true)
	local var_21_1 = #PlayerData:GetStickerList()
	local var_21_2 = #PlayerData:GetStickerBgList(true)
	local var_21_3 = #PlayerData:GetStickerBgList()
	local var_21_4 = #PlayerData:GetStickerFgList(true)
	local var_21_5 = #PlayerData:GetStickerFgList()

	arg_21_0.stNumText_.text = var_21_1 .. "/" .. var_21_0
	arg_21_0.bgNumText_.text = var_21_3 .. "/" .. var_21_2
	arg_21_0.fgNumText_.text = var_21_5 .. "/" .. var_21_4
	arg_21_0.percentText_.text = math.floor((var_21_1 + var_21_3 + var_21_5) / (var_21_0 + var_21_2 + var_21_4) * 100) .. "%"
	arg_21_0.progressText_.text = var_21_1 + var_21_3 + var_21_5 .. "/" .. var_21_0 + var_21_2 + var_21_4
end

function var_0_0.RefreshMainPage(arg_22_0, arg_22_1)
	arg_22_0.mainPageNum_ = arg_22_1

	arg_22_0.mainTabController_:SetSelectedState(tostring(arg_22_1))

	if arg_22_1 == 1 then
		arg_22_0.rightListData_ = StickerSuitCfg.all

		table.sort(arg_22_0.rightListData_, function(arg_23_0, arg_23_1)
			return arg_23_1 < arg_23_0
		end)
		arg_22_0.suitList_:StartScroll(#arg_22_0.rightListData_)
	elseif arg_22_1 == 2 then
		arg_22_0:RefreshSubPage(1)
	end
end

function var_0_0.RefreshSubPage(arg_24_0, arg_24_1)
	arg_24_0.subPageNum_ = arg_24_1

	arg_24_0.subTabController_:SetSelectedState(tostring(arg_24_1))

	if arg_24_1 == 1 then
		arg_24_0.rightListData_ = {}

		local var_24_0 = {}

		if arg_24_0.filterGetState_ == 0 then
			var_24_0 = PlayerData:GetStickerList(true)
		elseif arg_24_0.filterGetState_ == 1 then
			var_24_0 = PlayerData:GetStickerList()
		elseif arg_24_0.filterGetState_ == 2 then
			var_24_0 = PlayerData:GetStickerList(false, true)
		end

		if arg_24_0.filterState_ then
			for iter_24_0, iter_24_1 in pairs(var_24_0) do
				local var_24_1 = PlayerData:GetSticker(iter_24_1)

				if arg_24_0.filterMap_[var_24_1.suit] then
					table.insert(arg_24_0.rightListData_, iter_24_1)
				end
			end
		else
			arg_24_0.rightListData_ = var_24_0
		end

		if arg_24_0.filterDescendState_ then
			table.sort(arg_24_0.rightListData_, function(arg_25_0, arg_25_1)
				local var_25_0 = PlayerData:GetSticker(arg_25_0)
				local var_25_1 = PlayerData:GetSticker(arg_25_1)

				if var_25_0.lock == var_25_1.lock then
					return arg_25_1 < arg_25_0
				end

				return var_25_1.lock
			end)
		else
			table.sort(arg_24_0.rightListData_, function(arg_26_0, arg_26_1)
				local var_26_0 = PlayerData:GetSticker(arg_26_0)
				local var_26_1 = PlayerData:GetSticker(arg_26_1)

				if var_26_0.lock == var_26_1.lock then
					return arg_26_0 < arg_26_1
				end

				return var_26_1.lock
			end)
		end

		arg_24_0.stList_:StartScroll(#arg_24_0.rightListData_)
	elseif arg_24_1 == 2 then
		arg_24_0.rightListData_ = {}

		local var_24_2 = {}

		if arg_24_0.filterGetState_ == 0 then
			var_24_2 = PlayerData:GetStickerBgList(true)
		elseif arg_24_0.filterGetState_ == 1 then
			var_24_2 = PlayerData:GetStickerBgList()
		elseif arg_24_0.filterGetState_ == 2 then
			var_24_2 = PlayerData:GetStickerBgList(false, true)
		end

		if arg_24_0.filterState_ then
			for iter_24_2, iter_24_3 in pairs(var_24_2) do
				local var_24_3 = PlayerData:GetStickerBg(iter_24_3)

				if arg_24_0.filterMap_[var_24_3.suit] then
					table.insert(arg_24_0.rightListData_, iter_24_3)
				end
			end
		else
			arg_24_0.rightListData_ = var_24_2
		end

		local var_24_4 = GameSetting.sticker_background_default.value[1]

		if arg_24_0.filterDescendState_ then
			table.sort(arg_24_0.rightListData_, function(arg_27_0, arg_27_1)
				local var_27_0 = PlayerData:GetStickerBg(arg_27_0)
				local var_27_1 = PlayerData:GetStickerBg(arg_27_1)

				if var_27_0.lock == var_27_1.lock then
					if arg_27_0 == var_24_4 then
						return false
					end

					if arg_27_1 == var_24_4 then
						return true
					end

					return arg_27_1 < arg_27_0
				end

				return var_27_1.lock
			end)
		else
			table.sort(arg_24_0.rightListData_, function(arg_28_0, arg_28_1)
				local var_28_0 = PlayerData:GetStickerBg(arg_28_0)
				local var_28_1 = PlayerData:GetStickerBg(arg_28_1)

				if var_28_0.lock == var_28_1.lock then
					if arg_28_0 == var_24_4 then
						return true
					end

					if arg_28_1 == var_24_4 then
						return false
					end

					return arg_28_0 < arg_28_1
				end

				return var_28_1.lock
			end)
		end

		arg_24_0.bgList_:StartScroll(#arg_24_0.rightListData_)
	elseif arg_24_1 == 3 then
		arg_24_0.rightListData_ = {}

		local var_24_5 = {}

		if arg_24_0.filterGetState_ == 0 then
			var_24_5 = PlayerData:GetStickerFgList(true)
		elseif arg_24_0.filterGetState_ == 1 then
			var_24_5 = PlayerData:GetStickerFgList()
		elseif arg_24_0.filterGetState_ == 2 then
			var_24_5 = PlayerData:GetStickerFgList(false, true)
		end

		if arg_24_0.filterState_ then
			for iter_24_4, iter_24_5 in pairs(var_24_5) do
				local var_24_6 = PlayerData:GetStickerFg(iter_24_5)

				if arg_24_0.filterMap_[var_24_6.suit] then
					table.insert(arg_24_0.rightListData_, iter_24_5)
				end
			end
		else
			arg_24_0.rightListData_ = var_24_5
		end

		if arg_24_0.filterDescendState_ then
			table.sort(arg_24_0.rightListData_, function(arg_29_0, arg_29_1)
				local var_29_0 = PlayerData:GetStickerFg(arg_29_0)
				local var_29_1 = PlayerData:GetStickerFg(arg_29_1)

				if var_29_0.lock == var_29_1.lock then
					return arg_29_1 < arg_29_0
				end

				return var_29_1.lock
			end)
		else
			table.sort(arg_24_0.rightListData_, function(arg_30_0, arg_30_1)
				local var_30_0 = PlayerData:GetStickerFg(arg_30_0)
				local var_30_1 = PlayerData:GetStickerFg(arg_30_1)

				if var_30_0.lock == var_30_1.lock then
					return arg_30_0 < arg_30_1
				end

				return var_30_1.lock
			end)
		end

		arg_24_0.fgList_:StartScroll(#arg_24_0.rightListData_)
	end
end

function var_0_0.OnTop(arg_31_0)
	return
end

function var_0_0.OnExit(arg_32_0)
	manager.windowBar:HideBar()
	arg_32_0.collectController_:SetSelectedState("close")

	arg_32_0.filterDd_.value = 0
	arg_32_0.filterDescendState_ = true

	arg_32_0.sortController_:SetSelectedState("down")
	manager.redPoint:unbindUIandKey(arg_32_0.main1Btn_.transform, RedPointConst.CUSTOM_STICKER_SUIT_REWARD)
	manager.redPoint:unbindUIandKey(arg_32_0.main2Btn_.transform, RedPointConst.CUSTOM_STICKER_CATEGORY)
	manager.redPoint:unbindUIandKey(arg_32_0.sub1Btn_.transform, RedPointConst.CUSTOM_STICKER_ST)
	manager.redPoint:unbindUIandKey(arg_32_0.sub2Btn_.transform, RedPointConst.CUSTOM_STICKER_BG)
	manager.redPoint:unbindUIandKey(arg_32_0.sub3Btn_.transform, RedPointConst.CUSTOM_STICKER_FG)
end

function var_0_0.Dispose(arg_33_0)
	arg_33_0:RemoveAllListeners()
	arg_33_0.tabFilterPanel_:Dispose()
	arg_33_0.suitList_:Dispose()
	arg_33_0.stList_:Dispose()
	arg_33_0.fgList_:Dispose()
	arg_33_0.bgList_:Dispose()
	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
