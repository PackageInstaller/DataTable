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
local AssetPendSettingView = class("AssetPendSettingView", ReduxView)

function AssetPendSettingView:SetActive(arg_1_1)
	if arg_1_1 then
		self:OnShow()
	else
		self:OnHide()
	end

	if self.gameObject_ then
		AssetPendData:ClearDeletePackageList()
		SetActive(self.gameObject_, arg_1_1)
	end
end

function AssetPendSettingView:OnCtor(arg_2_1, arg_2_2, arg_2_3)
	self.gameObject_ = arg_2_2
	self.transform_ = arg_2_2.transform

	self:Init()
	self:AddUIListener()

	self.deleteController_ = self.controllerEx_:GetController("isDelete")
	self.OnClickToggleHandler_ = handler(self, self.OnClickToggle)
	self.OnClickContentHandler_ = handler(self, self.OnClickContent)
end

function AssetPendSettingView:Init()
	self:BindCfgUI()

	self.toggleItemList_ = {}

	self:InitToggleUI()

	self.loopScrollView_ = LoopScrollView.New(self, self.scrollEx_, self.contTrs_, self.viewTrs_, self.viewTrs_.rect.height, self.contTrs_:GetComponent("VerticalLayoutGroup").spacing, nil, false)
	self.itemPool1_ = {}
	self.itemPool2_ = {}
	self.itemPool3_ = {}
end

function AssetPendSettingView:AddUIListener()
	self:AddBtnListener(self.deleteSingleAssetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetI18NText(GetTips("ASSET_PEND_REMOVE_ASSET_FREE_SIZE")), (AssetPendDownLoadManager.instance:GetSingleAssetAndVoiceSize())),
			OkCallback = function()
				AssetPendDownLoadManager.instance:DeleteSingleAsset()
				AssetPendDownLoadManager.instance:DeleteSingleVoice()
				OperationRecorder.RecordButtonTouch({
					button_name = "set_resource_cache_delete"
				})
			end
		})
	end)
	self:AddBtnListener(self.deletePackageBtn_, nil, function()
		AssetPendData:SetDeleteFlag(true)
		self.deleteController_:SetSelectedState("true")
	end)
	self:AddBtnListener(self.deleteCancelBtn_, nil, function()
		AssetPendData:SetDeleteFlag(false)
		AssetPendData:ClearDeletePackageList()
		self.deleteController_:SetSelectedState("false")
	end)
	self:AddBtnListener(self.deleteSureBtn_, nil, function()
		local var_9_0 = AssetPendData:GetDeletePackageList()
		local var_9_1 = AssetPendData:GetDeleteLanguageList()

		if #var_9_0 <= 0 and #var_9_1 <= 0 then
			return
		end

		local var_9_2 = {}

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			table.insert(var_9_2, AssetPendInfoCfg[iter_9_1].asset_id)
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetI18NText(GetTips("ASSET_PEND_REMOVE_PACKAGE_FREE_SIZE")), #var_9_2 + #var_9_1, (manager.assetPend:GetRemoveAssetPendListSize(var_9_2, var_9_1))),
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
					var_10_0[AssetPendInfoCfg[AssetPendInfoCfg.get_id_list_by_asset_id[iter_10_3][1]].asset_type] = var_10_0[AssetPendInfoCfg[AssetPendInfoCfg.get_id_list_by_asset_id[iter_10_3][1]].asset_type] or {}

					table.insert(var_10_0[AssetPendInfoCfg[AssetPendInfoCfg.get_id_list_by_asset_id[iter_10_3][1]].asset_type], AssetPendInfoCfg[AssetPendInfoCfg.get_id_list_by_asset_id[iter_10_3][1]].id)
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

function AssetPendSettingView:OnShow()
	manager.notify:RegistListener(ASSET_PEND_CLICK_TOGGLE, self.OnClickToggleHandler_)
	manager.notify:RegistListener(ASSET_PEND_CLICK_CONTENT, self.OnClickContentHandler_)
	AssetPendData:ClearExpandContent()
	self:OnClickToggle(1)
	self.deleteController_:SetSelectedState("false")
	self:RemoveTimer()

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if AssetPendData:GetDeleteFlag() == true then
				local var_12_0 = AssetPendData:GetDeletePackageList()
				local var_12_1 = AssetPendData:GetDeleteLanguageList()
				local var_12_2 = GetI18NText(GetTips("ASSET_PEND_REMOVE_PACKAGE_FREE_SIZE_TIPS"))

				if #var_12_0 <= 0 and #var_12_1 <= 0 then
					self.tipsText_.text = string.format(var_12_2, 0, "0.00KB")
				else
					local var_12_3 = {}

					for iter_12_0, iter_12_1 in ipairs(var_12_0) do
						table.insert(var_12_3, AssetPendInfoCfg[iter_12_1].asset_id)
					end

					self.tipsText_.text = string.format(var_12_2, #var_12_3 + #var_12_1, (AssetPendData:GetRemoveAssetPendListSize(var_12_3, var_12_1)))
				end
			end

			self:RefreshItemList()
		end, 0.1, -1)
	end

	self.timer_:Start()
end

function AssetPendSettingView:RemoveTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AssetPendSettingView:OnHide()
	self:RemoveTimer()
	manager.notify:RemoveListener(ASSET_PEND_CLICK_TOGGLE, self.OnClickToggleHandler_)
	manager.notify:RemoveListener(ASSET_PEND_CLICK_CONTENT, self.OnClickContentHandler_)
	AssetPendData:SetDeleteFlag(false)

	self.lastToggleID_ = nil
end

function AssetPendSettingView:OnExit()
	self:OnHide()
end

function AssetPendSettingView:OnAssetPendDownloadEnd(arg_16_1, arg_16_2)
	return
end

function AssetPendSettingView:DeleteTestBtn()
	return
end

function AssetPendSettingView:InitToggleUI()
	for iter_18_0, iter_18_1 in ipairs(AssetPendToggleCfg.all) do
		self.toggleItemList_[iter_18_0] = AssetPendToggleItem.New(self.toggleItem_, self.toggleParentGo_, iter_18_1)
	end

	self.toggleItemList_[#self.toggleItemList_ + 1] = AssetPendVoiceToggleItem.New(self.toggleItem_, self.toggleParentGo_, var_0_0)
end

function AssetPendSettingView:OnClickToggle(arg_19_1)
	if self.lastToggleID_ == arg_19_1 then
		return
	end

	self.lastToggleID_ = arg_19_1

	for iter_19_0, iter_19_1 in ipairs(self.toggleItemList_) do
		iter_19_1:RefreshSelectState(arg_19_1)
	end

	self:RefreshContent()
end

function AssetPendSettingView:GoToLanguageManage()
	self:OnClickToggle(var_0_0)
end

function AssetPendSettingView:RefreshContent()
	self.loopScrollView_:NavigateIndex(1)
end

function AssetPendSettingView:OnClickContent(arg_22_1)
	AssetPendData:SetExpandContent(arg_22_1)
	self.loopScrollView_:RefreshScrollView(true, true)
end

function AssetPendSettingView:Dispose()
	for iter_23_0, iter_23_1 in ipairs(self.itemPool1_) do
		iter_23_1.itemView:Dispose()
	end

	self.itemPool1_ = nil

	for iter_23_2, iter_23_3 in ipairs(self.itemPool2_) do
		iter_23_3.itemView:Dispose()
	end

	self.itemPool2_ = nil

	for iter_23_4, iter_23_5 in ipairs(self.itemPool3_) do
		iter_23_5.itemView:Dispose()
	end

	self.itemPool3_ = nil

	self.loopScrollView_:Dispose()

	self.loopScrollView_ = nil

	for iter_23_6, iter_23_7 in ipairs(self.toggleItemList_) do
		iter_23_7:Dispose()
	end

	self.toggleItemList_ = nil

	AssetPendSettingView.super.Dispose(self)
end

function AssetPendSettingView:LsRemoveItem(arg_24_1)
	arg_24_1.itemView:Show(false)

	arg_24_1.isFree = true
end

function AssetPendSettingView:RefreshItemList()
	for iter_25_0, iter_25_1 in ipairs(self.itemPool1_) do
		if iter_25_1.isFree == false then
			iter_25_1.itemView:RefreshUI()
		end
	end

	for iter_25_2, iter_25_3 in ipairs(self.itemPool2_) do
		if iter_25_3.isFree == false then
			iter_25_3.itemView:RefreshUI()
		end
	end

	for iter_25_4, iter_25_5 in ipairs(self.itemPool3_) do
		if iter_25_5.isFree == false then
			iter_25_5.itemView:RefreshUI()
		end
	end
end

function AssetPendSettingView:GetFreeItem(arg_26_1, arg_26_2)
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

function AssetPendSettingView:LsAddItem(arg_27_1, arg_27_2)
	local var_27_0

	if arg_27_1.type == AssetPendCont.ITEM then
		var_27_0 = self:GetFreeItem(self.itemPool1_, function()
			return AssetPendSettingItem.New(self.itemGo_, self.contTrs_.gameObject)
		end)
	elseif arg_27_1.type == AssetPendCont.CONTENT then
		var_27_0 = self:GetFreeItem(self.itemPool2_, function()
			return AssetPendSettingContentItem.New(self.contentItemGo_, self.contTrs_.gameObject)
		end)
	elseif arg_27_1.type == var_0_1 then
		var_27_0 = self:GetFreeItem(self.itemPool3_, function()
			return AssetPendLanguageItem.New(self.itemGo_, self.contTrs_.gameObject)
		end)
	end

	var_27_0.itemView:SetData(arg_27_1.id, arg_27_2)

	return var_27_0
end

function AssetPendSettingView:LsGetItemData()
	local var_31_0 = {}

	if self.lastToggleID_ == var_0_0 then
		for iter_31_0, iter_31_1 in ipairs(AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list) do
			table.insert(var_31_0, {
				type = var_0_1,
				id = iter_31_1
			})
		end

		return var_31_0
	end

	for iter_31_2, iter_31_3 in ipairs(AssetPendToggleCfg[self.lastToggleID_].type_list) do
		table.insert(var_31_0, {
			type = AssetPendCont.CONTENT,
			id = iter_31_3
		})

		if AssetPendData:GetExpandContent(iter_31_3) then
			for iter_31_4, iter_31_5 in ipairs(AssetPendInfoCfg.get_id_list_by_asset_type[iter_31_3] or {}) do
				if not manager.assetPend:IsPermanentAssetPend(AssetPendInfoCfg[iter_31_5].asset_id) then
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

function AssetPendSettingView:LsUpdateItem(arg_32_1, arg_32_2, arg_32_3)
	arg_32_1.itemView:SetData(arg_32_2, arg_32_3)
end

return AssetPendSettingView
