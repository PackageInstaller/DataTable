LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local var_0_0 = class("AssetPendSettingBaseItem", LoopScrollViewBaseItem)

function var_0_0.Init(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.stateController_ = arg_1_0.m_controller:GetController("state")
	arg_1_0.sizeController_ = arg_1_0.m_controller:GetController("size")
	arg_1_0.cancelController_ = arg_1_0.m_controller:GetController("cancelbtn")
	arg_1_0.deleteSelectController_ = arg_1_0.m_controller:GetController("batch")
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_download, nil, function()
		if manager.assetPend:IsDownloadingLanguage() then
			ShowTips(GetTips("ASSET_PEND_FORBID_DOWNLOAD_RES_PAK"))

			return
		end

		local var_3_0 = AssetPendInfoCfg[arg_2_0.id_]
		local var_3_1 = var_3_0.asset_id
		local var_3_2, var_3_3 = manager.assetPend:CheckSpaceToDownload({
			var_3_1
		})

		if not var_3_2 then
			ShowMessageBox({
				content = LuaExchangeHelper.GetDescription(GetTips("ERROR_HOTUPDATE_INSUFFICIENT_MEMORY_SPACE"), {
					manager.assetPend:GetFormatSizeStr(var_3_3)
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

		manager.assetPend:StartDownload(var_3_1)
		OperationRecorder.RecordButtonTouch({
			button_name = "set_resource_download",
			asset_type = var_3_0.asset_type,
			asset_id_list = {
				var_3_0.id
			}
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_restoreBtn, nil, function()
		local var_7_0 = AssetPendInfoCfg[arg_2_0.id_].asset_id

		manager.assetPend:StartDownload(var_7_0)
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_pauseBtn, nil, function()
		local var_8_0 = AssetPendInfoCfg[arg_2_0.id_].asset_id

		manager.assetPend:StopDownload(var_8_0)
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_removeBtn, nil, function()
		local var_9_0 = AssetPendInfoCfg[arg_2_0.id_].asset_id

		manager.assetPend:CancelDownload(var_9_0)
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_deleteSelectBtn, nil, function()
		local var_10_0 = arg_2_0.id_

		if AssetPendTools.IsSelectDeletePackage(var_10_0) then
			AssetPendData:RemoveDeletePackage(var_10_0)
		else
			AssetPendData:AddDeletePackage(var_10_0)
		end
	end)
end

function var_0_0.SetData(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.id_ = arg_11_1

	local var_11_0 = AssetPendInfoCfg[arg_11_0.id_]

	arg_11_0.m_title.text = var_11_0.asset_name
	arg_11_0.m_des.text = var_11_0.asset_desc
	arg_11_0.m_size.text = manager.assetPend:GetFormatSizeStr(manager.assetPend:GetAssetPendSize(var_11_0.asset_id))
	arg_11_0.index_ = arg_11_2

	arg_11_0:Show(true)
	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = AssetPendInfoCfg[arg_12_0.id_].asset_id
	local var_12_1 = manager.assetPend:GetAssetPendState(var_12_0)

	if AssetPendData:GetDeleteFlag() == false then
		arg_12_0.deleteSelectController_:SetSelectedState("null")

		if AssetPendDownloadState.DOWNLOAD_SUCCESS == var_12_1 then
			arg_12_0.stateController_:SetSelectedState("finish")
			arg_12_0.sizeController_:SetSelectedState("state3")
			arg_12_0.cancelController_:SetSelectedState("off")
		elseif AssetPendDownloadState.DOWNLOADING == var_12_1 then
			arg_12_0.stateController_:SetSelectedState("downloading")
			arg_12_0.sizeController_:SetSelectedState("state1")
			arg_12_0.cancelController_:SetSelectedState("on")

			arg_12_0.m_speed.text = manager.assetPend:GetSpeedStr()
			arg_12_0.m_processLab.text = manager.assetPend:GetDownloadProcessStr()

			local var_12_2 = manager.assetPend:GetDownloadProcess()

			arg_12_0.m_processFill2.text = string.format("%.1f%%", var_12_2 * 100)
		elseif AssetPendDownloadState.DOWNLOAD_PAUSE == var_12_1 then
			arg_12_0.stateController_:SetSelectedState("downloaded")
			arg_12_0.sizeController_:SetSelectedState("state2")
			arg_12_0.cancelController_:SetSelectedState("on")

			local var_12_3, var_12_4 = manager.assetPend:GetAssetPendCacheProcess(var_12_0)

			arg_12_0.m_processLab.text = var_12_4
			arg_12_0.m_processFill.text = string.format("%.1f%%", var_12_3 * 100)
		elseif AssetPendDownloadState.DOWNLOAD_QUEUE == var_12_1 then
			arg_12_0.stateController_:SetSelectedState("downloaded")
			arg_12_0.sizeController_:SetSelectedState("state4")
			arg_12_0.cancelController_:SetSelectedState("on")

			local var_12_5 = manager.assetPend:GetAssetPendExistSize(var_12_0)
			local var_12_6 = manager.assetPend:GetAssetPendSize(var_12_0)

			arg_12_0.m_processLab.text = string.format("%s/%s", manager.assetPend:GetFormatSizeStr(var_12_5), manager.assetPend:GetFormatSizeStr(var_12_6))

			if tonumber(tostring(var_12_6)) == 0 then
				arg_12_0.m_processFill.text = "0%"
			else
				arg_12_0.m_processFill.text = string.format("%.1f%%", tonumber(tostring(var_12_5)) / tonumber(tostring(var_12_6)) * 100)
			end
		else
			arg_12_0.stateController_:SetSelectedState("download")
			arg_12_0.sizeController_:SetSelectedState("state3")
			arg_12_0.cancelController_:SetSelectedState("off")
		end
	else
		arg_12_0.stateController_:SetSelectedState("null")
		arg_12_0.sizeController_:SetSelectedState("state3")
		arg_12_0.cancelController_:SetSelectedState("off")

		if AssetPendDownloadState.DOWNLOAD_SUCCESS == var_12_1 then
			if AssetPendTools.IsSelectDeletePackage(arg_12_0.id_) then
				arg_12_0.deleteSelectController_:SetSelectedState("select")
			else
				arg_12_0.deleteSelectController_:SetSelectedState("unselect")
			end
		else
			arg_12_0.deleteSelectController_:SetSelectedState("lock")
		end
	end
end

return var_0_0
