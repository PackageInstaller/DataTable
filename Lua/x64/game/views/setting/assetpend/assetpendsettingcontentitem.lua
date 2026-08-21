LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local var_0_0 = class("AssetPendSettingContentItem", LoopScrollViewBaseItem)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.downLoadStateController_ = arg_1_0.controllerEx_:GetController("state")
	arg_1_0.expandController_ = arg_1_0.controllerEx_:GetController("btnarrow")
	arg_1_0.deleteSelectController_ = arg_1_0.controllerEx_:GetController("batch")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.expandBtn_, nil, function()
		manager.notify:Invoke(ASSET_PEND_CLICK_CONTENT, arg_2_0.id_)
	end)
	arg_2_0:AddBtnListener(arg_2_0.downLoadAllBtn_, nil, function()
		if manager.assetPend:IsDownloadingLanguage() then
			ShowTips(GetTips("ASSET_PEND_FORBID_DOWNLOAD_RES_PAK"))

			return
		end

		local var_4_0 = AssetPendTools.GetUndownloadContentPendList(arg_2_0.id_)

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

		arg_2_0:RefreshUI()

		if #var_4_0 > 0 then
			OperationRecorder.RecordButtonTouch({
				button_name = "set_resource_download",
				asset_type = arg_2_0.id_,
				asset_id_list = var_4_0
			})
		end
	end)
	arg_2_0:AddBtnListener(arg_2_0.deleteSelectBtn_, nil, function()
		local var_8_0 = arg_2_0.id_
		local var_8_1 = AssetPendTools.GetDeleteContentState(var_8_0)

		if var_8_1 == AssetPendDeleteState.UNSELECTED or var_8_1 == AssetPendDeleteState.SELECTED_NOT_ALL then
			local var_8_2 = AssetPendTools.GetDownloadContentPendList(var_8_0)

			for iter_8_0, iter_8_1 in ipairs(var_8_2) do
				local var_8_3 = AssetPendInfoCfg[iter_8_1]

				if not manager.assetPend:IsPermanentAssetPend(var_8_3.asset_id) then
					AssetPendData:AddDeletePackage(iter_8_1)
				end
			end
		elseif var_8_1 == AssetPendDeleteState.SELECTED_ALL then
			local var_8_4 = AssetPendTools.GetDownloadContentPendList(var_8_0)

			for iter_8_2, iter_8_3 in ipairs(var_8_4) do
				local var_8_5 = AssetPendInfoCfg[iter_8_3]

				if not manager.assetPend:IsPermanentAssetPend(var_8_5.asset_id) then
					AssetPendData:RemoveDeletePackage(iter_8_3)
				end
			end
		end
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.index_ = arg_9_2
	arg_9_0.id_ = arg_9_1

	local var_9_0 = AssetPendTypeCfg[arg_9_0.id_]

	arg_9_0.titleText_.text = var_9_0.title
	arg_9_0.descText_.text = var_9_0.desc

	arg_9_0:Show(true)
	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = arg_10_0.id_

	if AssetPendData:GetExpandContent(var_10_0) then
		arg_10_0.expandController_:SetSelectedState("up")
	else
		arg_10_0.expandController_:SetSelectedState("down")
	end

	if AssetPendData:GetDeleteFlag() == false then
		arg_10_0.deleteSelectController_:SetSelectedState("off")

		if AssetPendTools.IsContentDownloadAll(var_10_0) then
			-- block empty
		end
	else
		local var_10_1 = AssetPendTools.GetDeleteContentState(var_10_0)

		if var_10_1 == AssetPendDeleteState.UNVALID then
			arg_10_0.deleteSelectController_:SetSelectedState("off")
		elseif var_10_1 == AssetPendDeleteState.UNSELECTED then
			arg_10_0.deleteSelectController_:SetSelectedState("unselect")
		elseif var_10_1 == AssetPendDeleteState.SELECTED_ALL then
			arg_10_0.deleteSelectController_:SetSelectedState("all")
		elseif var_10_1 == AssetPendDeleteState.SELECTED_NOT_ALL then
			arg_10_0.deleteSelectController_:SetSelectedState("Part")
		end
	end

	arg_10_0.downLoadStateController_:SetSelectedState("off")
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)

	arg_11_0.gameObject_ = nil
	arg_11_0.transform_ = nil
end

return var_0_0
