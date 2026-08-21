AssetPendCont = {
	ITEM = 2,
	CONTENT = 1
}
AssetPendDeleteState = {
	SELECTED_NOT_ALL == 2,
	SELECTED_ALL = 3,
	UNSELECTED = 1,
	UNVALID = 0
}

local var_0_0 = -5
local var_0_1 = 10
local var_0_2 = class("AssetPendSettingView", ReduxView)

function var_0_2.SetActive(arg_1_0, arg_1_1)
	if arg_1_1 then
		arg_1_0:OnShow()
	else
		arg_1_0:OnHide()
	end

	if arg_1_0.gameObject_ then
		AssetPendData:ClearDeletePackageList()
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_2.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.transform_ = arg_2_2.transform

	arg_2_0:Init()
	arg_2_0:AddUIListener()

	arg_2_0.deleteController_ = arg_2_0.controllerEx_:GetController("isDelete")
	arg_2_0.OnClickToggleHandler_ = handler(arg_2_0, arg_2_0.OnClickToggle)
	arg_2_0.OnClickContentHandler_ = handler(arg_2_0, arg_2_0.OnClickContent)
end

function var_0_2.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.toggleItemList_ = {}

	arg_3_0:InitToggleUI()

	local var_3_0 = arg_3_0.viewTrs_.rect.height
	local var_3_1 = arg_3_0.contTrs_:GetComponent("VerticalLayoutGroup").spacing

	arg_3_0.loopScrollView_ = LoopScrollView.New(arg_3_0, arg_3_0.scrollEx_, arg_3_0.contTrs_, arg_3_0.viewTrs_, var_3_0, var_3_1, nil, false)
	arg_3_0.itemPool1_ = {}
	arg_3_0.itemPool2_ = {}
	arg_3_0.itemPool3_ = {}
end

function var_0_2.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.deleteSingleAssetBtn_, nil, function()
		local var_5_0 = AssetPendDownLoadManager.instance:GetSingleAssetAndVoiceSize()
		local var_5_1 = GetI18NText(GetTips("ASSET_PEND_REMOVE_ASSET_FREE_SIZE"))

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(var_5_1, var_5_0),
			OkCallback = function()
				AssetPendDownLoadManager.instance:DeleteSingleAsset()
				AssetPendDownLoadManager.instance:DeleteSingleVoice()
				OperationRecorder.RecordButtonTouch({
					button_name = "set_resource_cache_delete"
				})
			end
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.deletePackageBtn_, nil, function()
		AssetPendData:SetDeleteFlag(true)
		arg_4_0.deleteController_:SetSelectedState("true")
	end)
	arg_4_0:AddBtnListener(arg_4_0.deleteCancelBtn_, nil, function()
		AssetPendData:SetDeleteFlag(false)
		AssetPendData:ClearDeletePackageList()
		arg_4_0.deleteController_:SetSelectedState("false")
	end)
	arg_4_0:AddBtnListener(arg_4_0.deleteSureBtn_, nil, function()
		local var_9_0 = AssetPendData:GetDeletePackageList()
		local var_9_1 = AssetPendData:GetDeleteLanguageList()

		if #var_9_0 <= 0 and #var_9_1 <= 0 then
			return
		end

		local var_9_2 = {}

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			local var_9_3 = AssetPendInfoCfg[iter_9_1]

			table.insert(var_9_2, var_9_3.asset_id)
		end

		local var_9_4 = manager.assetPend:GetRemoveAssetPendListSize(var_9_2, var_9_1)
		local var_9_5 = GetI18NText(GetTips("ASSET_PEND_REMOVE_PACKAGE_FREE_SIZE"))

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(var_9_5, #var_9_2 + #var_9_1, var_9_4),
			OkCallback = function()
				manager.assetPend:RemovePendList(var_9_2)

				for iter_10_0, iter_10_1 in ipairs(var_9_1) do
					VoicePackageManager.Instance:DeleteDownLoadPackage(iter_10_1)
					manager.assetPend:UpdateAssetPendSize()
					manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_DELETED, iter_10_1)
				end

				AssetPendData:ClearDeletePackageList()
				manager.assetPend:ClearLanguageExistSize()

				local var_10_0 = {}

				for iter_10_2, iter_10_3 in ipairs(var_9_2) do
					local var_10_1 = AssetPendInfoCfg[AssetPendInfoCfg.get_id_list_by_asset_id[iter_10_3][1]]

					if not var_10_0[var_10_1.asset_type] then
						var_10_0[var_10_1.asset_type] = {}
					end

					table.insert(var_10_0[var_10_1.asset_type], var_10_1.id)
				end

				for iter_10_4, iter_10_5 in pairs(var_10_0) do
					OperationRecorder.RecordButtonTouch({
						button_name = "set_resource_delete",
						asset_type = iter_10_4,
						asset_id_list = iter_10_5
					})
				end
			end
		})
	end)
end

function var_0_2.OnShow(arg_11_0)
	manager.notify:RegistListener(ASSET_PEND_CLICK_TOGGLE, arg_11_0.OnClickToggleHandler_)
	manager.notify:RegistListener(ASSET_PEND_CLICK_CONTENT, arg_11_0.OnClickContentHandler_)
	AssetPendData:ClearExpandContent()
	arg_11_0:OnClickToggle(1)
	arg_11_0.deleteController_:SetSelectedState("false")
	arg_11_0:RemoveTimer()

	if arg_11_0.timer_ == nil then
		arg_11_0.timer_ = Timer.New(function()
			if AssetPendData:GetDeleteFlag() == true then
				local var_12_0 = AssetPendData:GetDeletePackageList()
				local var_12_1 = AssetPendData:GetDeleteLanguageList()
				local var_12_2 = GetI18NText(GetTips("ASSET_PEND_REMOVE_PACKAGE_FREE_SIZE_TIPS"))

				if #var_12_0 <= 0 and #var_12_1 <= 0 then
					arg_11_0.tipsText_.text = string.format(var_12_2, 0, "0.00KB")
				else
					local var_12_3 = {}

					for iter_12_0, iter_12_1 in ipairs(var_12_0) do
						local var_12_4 = AssetPendInfoCfg[iter_12_1]

						table.insert(var_12_3, var_12_4.asset_id)
					end

					local var_12_5 = AssetPendData:GetRemoveAssetPendListSize(var_12_3, var_12_1)

					arg_11_0.tipsText_.text = string.format(var_12_2, #var_12_3 + #var_12_1, var_12_5)
				end
			end

			arg_11_0:RefreshItemList()
		end, 0.1, -1)
	end

	arg_11_0.timer_:Start()
end

function var_0_2.RemoveTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

function var_0_2.OnHide(arg_14_0)
	arg_14_0:RemoveTimer()
	manager.notify:RemoveListener(ASSET_PEND_CLICK_TOGGLE, arg_14_0.OnClickToggleHandler_)
	manager.notify:RemoveListener(ASSET_PEND_CLICK_CONTENT, arg_14_0.OnClickContentHandler_)
	AssetPendData:SetDeleteFlag(false)

	arg_14_0.lastToggleID_ = nil
end

function var_0_2.OnExit(arg_15_0)
	arg_15_0:OnHide()
end

function var_0_2.OnAssetPendDownloadEnd(arg_16_0, arg_16_1, arg_16_2)
	return
end

function var_0_2.DeleteTestBtn(arg_17_0)
	return
end

function var_0_2.InitToggleUI(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(AssetPendToggleCfg.all) do
		arg_18_0.toggleItemList_[iter_18_0] = AssetPendToggleItem.New(arg_18_0.toggleItem_, arg_18_0.toggleParentGo_, iter_18_1)
	end

	arg_18_0.toggleItemList_[#arg_18_0.toggleItemList_ + 1] = AssetPendVoiceToggleItem.New(arg_18_0.toggleItem_, arg_18_0.toggleParentGo_, var_0_0)
end

function var_0_2.OnClickToggle(arg_19_0, arg_19_1)
	if arg_19_0.lastToggleID_ == arg_19_1 then
		return
	end

	arg_19_0.lastToggleID_ = arg_19_1

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.toggleItemList_) do
		iter_19_1:RefreshSelectState(arg_19_1)
	end

	arg_19_0:RefreshContent()
end

function var_0_2.GoToLanguageManage(arg_20_0)
	arg_20_0:OnClickToggle(var_0_0)
end

function var_0_2.RefreshContent(arg_21_0)
	arg_21_0.loopScrollView_:NavigateIndex(1)
end

function var_0_2.OnClickContent(arg_22_0, arg_22_1)
	AssetPendData:SetExpandContent(arg_22_1)
	arg_22_0.loopScrollView_:RefreshScrollView(true, true)
end

function var_0_2.Dispose(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.itemPool1_) do
		iter_23_1.itemView:Dispose()
	end

	arg_23_0.itemPool1_ = nil

	for iter_23_2, iter_23_3 in ipairs(arg_23_0.itemPool2_) do
		iter_23_3.itemView:Dispose()
	end

	arg_23_0.itemPool2_ = nil

	for iter_23_4, iter_23_5 in ipairs(arg_23_0.itemPool3_) do
		iter_23_5.itemView:Dispose()
	end

	arg_23_0.itemPool3_ = nil

	arg_23_0.loopScrollView_:Dispose()

	arg_23_0.loopScrollView_ = nil

	for iter_23_6, iter_23_7 in ipairs(arg_23_0.toggleItemList_) do
		iter_23_7:Dispose()
	end

	arg_23_0.toggleItemList_ = nil

	var_0_2.super.Dispose(arg_23_0)
end

function var_0_2.LsRemoveItem(arg_24_0, arg_24_1)
	arg_24_1.itemView:Show(false)

	arg_24_1.isFree = true
end

function var_0_2.RefreshItemList(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.itemPool1_) do
		if iter_25_1.isFree == false then
			iter_25_1.itemView:RefreshUI()
		end
	end

	for iter_25_2, iter_25_3 in ipairs(arg_25_0.itemPool2_) do
		if iter_25_3.isFree == false then
			iter_25_3.itemView:RefreshUI()
		end
	end

	for iter_25_4, iter_25_5 in ipairs(arg_25_0.itemPool3_) do
		if iter_25_5.isFree == false then
			iter_25_5.itemView:RefreshUI()
		end
	end
end

function var_0_2.GetFreeItem(arg_26_0, arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in pairs(arg_26_1) do
		if iter_26_1.isFree == true then
			iter_26_1.isFree = false

			return iter_26_1
		end
	end

	local var_26_0 = {
		isFree = false,
		itemView = arg_26_2()
	}

	table.insert(arg_26_1, var_26_0)

	return var_26_0
end

function var_0_2.LsAddItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0

	if arg_27_1.type == AssetPendCont.ITEM then
		var_27_0 = arg_27_0:GetFreeItem(arg_27_0.itemPool1_, function()
			return AssetPendSettingItem.New(arg_27_0.itemGo_, arg_27_0.contTrs_.gameObject)
		end)
	elseif arg_27_1.type == AssetPendCont.CONTENT then
		var_27_0 = arg_27_0:GetFreeItem(arg_27_0.itemPool2_, function()
			return AssetPendSettingContentItem.New(arg_27_0.contentItemGo_, arg_27_0.contTrs_.gameObject)
		end)
	elseif arg_27_1.type == var_0_1 then
		var_27_0 = arg_27_0:GetFreeItem(arg_27_0.itemPool3_, function()
			return AssetPendLanguageItem.New(arg_27_0.itemGo_, arg_27_0.contTrs_.gameObject)
		end)
	end

	var_27_0.itemView:SetData(arg_27_1.id, arg_27_2)

	return var_27_0
end

function var_0_2.LsGetItemData(arg_31_0)
	local var_31_0 = {}

	if arg_31_0.lastToggleID_ == var_0_0 then
		local var_31_1 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

		for iter_31_0, iter_31_1 in ipairs(var_31_1.voice_list) do
			table.insert(var_31_0, {
				type = var_0_1,
				id = iter_31_1
			})
		end

		return var_31_0
	end

	local var_31_2 = AssetPendToggleCfg[arg_31_0.lastToggleID_]

	for iter_31_2, iter_31_3 in ipairs(var_31_2.type_list) do
		table.insert(var_31_0, {
			type = AssetPendCont.CONTENT,
			id = iter_31_3
		})

		if AssetPendData:GetExpandContent(iter_31_3) then
			for iter_31_4, iter_31_5 in ipairs(AssetPendInfoCfg.get_id_list_by_asset_type[iter_31_3] or {}) do
				local var_31_3 = AssetPendInfoCfg[iter_31_5]

				if not manager.assetPend:IsPermanentAssetPend(var_31_3.asset_id) then
					table.insert(var_31_0, {
						type = AssetPendCont.ITEM,
						id = iter_31_5
					})
				end
			end
		end
	end

	return var_31_0
end

function var_0_2.LsUpdateItem(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_1.itemView:SetData(arg_32_2, arg_32_3)
end

return var_0_2
