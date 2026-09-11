LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local AssetPendSettingContentItem = class("AssetPendSettingContentItem", LoopScrollViewBaseItem)

function AssetPendSettingContentItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.downLoadStateController_ = self.controllerEx_:GetController("state")
	self.expandController_ = self.controllerEx_:GetController("btnarrow")
	self.deleteSelectController_ = self.controllerEx_:GetController("batch")
end

function AssetPendSettingContentItem:AddListeners()
	self:AddBtnListener(self.expandBtn_, nil, function()
		manager.notify:Invoke(ASSET_PEND_CLICK_CONTENT, self.id_)
	end)
	self:AddBtnListener(self.downLoadAllBtn_, nil, function()
		if manager.assetPend:IsDownloadingLanguage() then
			ShowTips(GetTips("ASSET_PEND_FORBID_DOWNLOAD_RES_PAK"))

			return
		end

		local var_4_0 = AssetPendTools.GetUndownloadContentPendList(self.id_)

		if #var_4_0 > 0 then
			local var_4_1 = {}

			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				table.insert(var_4_1, AssetPendInfoCfg[iter_4_1].asset_id)
			end

			local var_4_2, var_4_3 = manager.assetPend:CheckSpaceToDownload(var_4_1)

			if not var_4_2 then
				ShowMessageBox({
					content = LuaExchangeHelper.GetDescription(GetTips("ERROR_HOTUPDATE_INSUFFICIENT_MEMORY_SPACE"), {
						manager.assetPend:GetFormatSizeStr(var_4_3)
					}),
					OkCallback = function()
						return
					end,
					CancelCallback = function()
						return
					end,
					MaskCallback = function()
						return
					end
				})

				return
			end

			manager.assetPend:DownloadPendList(var_4_1)
		end

		self:RefreshUI()

		if #var_4_0 > 0 then
			OperationRecorder.RecordButtonTouch({
				button_name = "set_resource_download",
				asset_type = self.id_,
				asset_id_list = var_4_0
			})
		end
	end)
	self:AddBtnListener(self.deleteSelectBtn_, nil, function()
		local var_8_0 = AssetPendTools.GetDeleteContentState(self.id_)

		if var_8_0 ~= AssetPendDeleteState.UNSELECTED then
			if var_8_0 == AssetPendDeleteState.SELECTED_NOT_ALL then
				for iter_8_0, iter_8_1 in ipairs((AssetPendTools.GetDownloadContentPendList(self.id_))) do
					if not manager.assetPend:IsPermanentAssetPend(AssetPendInfoCfg[iter_8_1].asset_id) then
						AssetPendData:AddDeletePackage(iter_8_1)
					end
				end
			elseif var_8_0 == AssetPendDeleteState.SELECTED_ALL then
				for iter_8_2, iter_8_3 in ipairs((AssetPendTools.GetDownloadContentPendList(self.id_))) do
					if not manager.assetPend:IsPermanentAssetPend(AssetPendInfoCfg[iter_8_3].asset_id) then
						AssetPendData:RemoveDeletePackage(iter_8_3)
					end
				end
			end
		end
	end)
end

function AssetPendSettingContentItem:SetData(arg_9_1, arg_9_2)
	self.index_ = arg_9_2
	self.id_ = arg_9_1
	self.titleText_.text = AssetPendTypeCfg[self.id_].title
	self.descText_.text = AssetPendTypeCfg[self.id_].desc

	self:Show(true)
	self:RefreshUI()
end

function AssetPendSettingContentItem:RefreshUI()
	if AssetPendData:GetExpandContent(self.id_) then
		self.expandController_:SetSelectedState("up")
	else
		self.expandController_:SetSelectedState("down")
	end

	if AssetPendData:GetDeleteFlag() == false then
		self.deleteSelectController_:SetSelectedState("off")

		if AssetPendTools.IsContentDownloadAll(self.id_) then
			-- block empty
		end
	else
		local var_10_0 = AssetPendTools.GetDeleteContentState(self.id_)

		if var_10_0 == AssetPendDeleteState.UNVALID then
			self.deleteSelectController_:SetSelectedState("off")
		elseif var_10_0 == AssetPendDeleteState.UNSELECTED then
			self.deleteSelectController_:SetSelectedState("unselect")
		elseif var_10_0 == AssetPendDeleteState.SELECTED_ALL then
			self.deleteSelectController_:SetSelectedState("all")
		elseif var_10_0 == AssetPendDeleteState.SELECTED_NOT_ALL then
			self.deleteSelectController_:SetSelectedState("Part")
		end
	end

	self.downLoadStateController_:SetSelectedState("off")
end

function AssetPendSettingContentItem:Dispose()
	AssetPendSettingContentItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return AssetPendSettingContentItem
