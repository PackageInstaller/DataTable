LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local AssetPendSettingBaseItem = class("AssetPendSettingBaseItem", LoopScrollViewBaseItem)

function AssetPendSettingBaseItem:Init()
	self:BindCfgUI()

	self.stateController_ = self.m_controller:GetController("state")
	self.sizeController_ = self.m_controller:GetController("size")
	self.cancelController_ = self.m_controller:GetController("cancelbtn")
	self.deleteSelectController_ = self.m_controller:GetController("batch")
end

function AssetPendSettingBaseItem:AddUIListener()
	self:AddBtnListener(self.m_download, nil, function()
		if manager.assetPend:IsDownloadingLanguage() then
			ShowTips(GetTips("ASSET_PEND_FORBID_DOWNLOAD_RES_PAK"))

			return
		end

		local var_3_0 = AssetPendInfoCfg[self.id_]
		local var_3_1, var_3_2 = manager.assetPend:CheckSpaceToDownload({
			AssetPendInfoCfg[self.id_].asset_id
		})

		if not var_3_1 then
			ShowMessageBox({
				content = LuaExchangeHelper.GetDescription(GetTips("ERROR_HOTUPDATE_INSUFFICIENT_MEMORY_SPACE"), {
					manager.assetPend:GetFormatSizeStr(var_3_2)
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

		manager.assetPend:StartDownload(AssetPendInfoCfg[self.id_].asset_id)
		OperationRecorder.RecordButtonTouch({
			button_name = "set_resource_download",
			asset_type = var_3_0.asset_type,
			asset_id_list = {
				var_3_0.id
			}
		})
	end)
	self:AddBtnListener(self.m_restoreBtn, nil, function()
		manager.assetPend:StartDownload(AssetPendInfoCfg[self.id_].asset_id)
	end)
	self:AddBtnListener(self.m_pauseBtn, nil, function()
		manager.assetPend:StopDownload(AssetPendInfoCfg[self.id_].asset_id)
	end)
	self:AddBtnListener(self.m_removeBtn, nil, function()
		manager.assetPend:CancelDownload(AssetPendInfoCfg[self.id_].asset_id)
	end)
	self:AddBtnListener(self.m_deleteSelectBtn, nil, function()
		if AssetPendTools.IsSelectDeletePackage(self.id_) then
			AssetPendData:RemoveDeletePackage(self.id_)
		else
			AssetPendData:AddDeletePackage(self.id_)
		end
	end)
end

function AssetPendSettingBaseItem:SetData(arg_11_1, arg_11_2)
	self.id_ = arg_11_1
	self.m_title.text = AssetPendInfoCfg[self.id_].asset_name
	self.m_des.text = AssetPendInfoCfg[self.id_].asset_desc
	self.m_size.text = manager.assetPend:GetFormatSizeStr(manager.assetPend:GetAssetPendSize(AssetPendInfoCfg[self.id_].asset_id))
	self.index_ = arg_11_2

	self:Show(true)
	self:RefreshUI()
end

function AssetPendSettingBaseItem:RefreshUI()
	local var_12_0 = manager.assetPend:GetAssetPendState(AssetPendInfoCfg[self.id_].asset_id)

	if AssetPendData:GetDeleteFlag() == false then
		self.deleteSelectController_:SetSelectedState("null")

		if AssetPendDownloadState.DOWNLOAD_SUCCESS == var_12_0 then
			self.stateController_:SetSelectedState("finish")
			self.sizeController_:SetSelectedState("state3")
			self.cancelController_:SetSelectedState("off")
		elseif AssetPendDownloadState.DOWNLOADING == var_12_0 then
			self.stateController_:SetSelectedState("downloading")
			self.sizeController_:SetSelectedState("state1")
			self.cancelController_:SetSelectedState("on")

			self.m_speed.text = manager.assetPend:GetSpeedStr()
			self.m_processLab.text = manager.assetPend:GetDownloadProcessStr()
			self.m_processFill2.text = string.format("%.1f%%", manager.assetPend:GetDownloadProcess() * 100)
		elseif AssetPendDownloadState.DOWNLOAD_PAUSE == var_12_0 then
			self.stateController_:SetSelectedState("downloaded")
			self.sizeController_:SetSelectedState("state2")
			self.cancelController_:SetSelectedState("on")

			local var_12_1, var_12_2 = manager.assetPend:GetAssetPendCacheProcess(AssetPendInfoCfg[self.id_].asset_id)

			self.m_processLab.text = var_12_2
			self.m_processFill.text = string.format("%.1f%%", var_12_1 * 100)
		elseif AssetPendDownloadState.DOWNLOAD_QUEUE == var_12_0 then
			self.stateController_:SetSelectedState("downloaded")
			self.sizeController_:SetSelectedState("state4")
			self.cancelController_:SetSelectedState("on")

			local var_12_3 = manager.assetPend:GetAssetPendExistSize(AssetPendInfoCfg[self.id_].asset_id)
			local var_12_4 = manager.assetPend:GetAssetPendSize(AssetPendInfoCfg[self.id_].asset_id)

			self.m_processLab.text = string.format("%s/%s", manager.assetPend:GetFormatSizeStr(var_12_3), manager.assetPend:GetFormatSizeStr(var_12_4))
			self.m_processFill.text = tonumber(tostring(var_12_4)) == 0 and "0%" or string.format("%.1f%%", tonumber(tostring(var_12_3)) / tonumber(tostring(var_12_4)) * 100)
		else
			self.stateController_:SetSelectedState("download")
			self.sizeController_:SetSelectedState("state3")
			self.cancelController_:SetSelectedState("off")
		end
	else
		self.stateController_:SetSelectedState("null")
		self.sizeController_:SetSelectedState("state3")
		self.cancelController_:SetSelectedState("off")

		if AssetPendDownloadState.DOWNLOAD_SUCCESS == var_12_0 then
			if AssetPendTools.IsSelectDeletePackage(self.id_) then
				self.deleteSelectController_:SetSelectedState("select")
			else
				self.deleteSelectController_:SetSelectedState("unselect")
			end
		else
			self.deleteSelectController_:SetSelectedState("lock")
		end
	end
end

return AssetPendSettingBaseItem
