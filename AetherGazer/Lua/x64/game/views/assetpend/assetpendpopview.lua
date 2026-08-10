local var_0_0 = class("AssetPendPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/AssetPend/AssetPendGameplayPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, AssetPendPopItem)
	arg_4_0.isDownloading_controller = arg_4_0.m_controller:GetController("isDownloading")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_closeBtn, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_GotoBtn, nil, function()
		JumpTools.GoToSystem("/setting", {
			toggleName = "AssetPend",
			setType = SettingConst.SETTING_TYPE.SYSTEM
		}, ViewConst.SYSTEM_ID.SETTING)
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.assetPend = arg_9_0.params_.assetPend
	arg_9_0.assetPendList = {
		arg_9_0.assetPend
	}

	arg_9_0.list:StartScroll(#arg_9_0.assetPendList)
	arg_9_0:RemoveTimer()

	if arg_9_0.timer_ == nil then
		arg_9_0.timer_ = Timer.New(function()
			local var_10_0 = arg_9_0.list:GetItemList()

			for iter_10_0, iter_10_1 in pairs(var_10_0) do
				iter_10_1:RefreshUI()
			end

			arg_9_0:RefreshCurAssetPend()
		end, 0.1, -1)
	end

	arg_9_0.timer_:Start()
	arg_9_0:RefreshCurAssetPend()
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
	arg_11_0:RemoveTimer()
end

function var_0_0.RefreshCurAssetPend(arg_12_0)
	local var_12_0 = false
	local var_12_1 = manager.assetPend:GetDownloadingKey()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.assetPendList) do
		if iter_12_1 == var_12_1 then
			var_12_0 = true

			break
		end
	end

	if manager.assetPend:GetIsDownloading() and not var_12_0 then
		arg_12_0.isDownloading_controller:SetSelectedIndex(1)

		local var_12_2 = manager.assetPend:GetDownloadingKey()
		local var_12_3 = AssetPendInfoCfg.get_id_list_by_asset_id[var_12_2][1]
		local var_12_4 = AssetPendInfoCfg[var_12_3]

		if var_12_4 then
			arg_12_0.m_curTitle.text = var_12_4.asset_name
		else
			arg_12_0.m_curTitle.text = var_12_2
		end

		arg_12_0.m_curProcessLab.text = manager.assetPend:GetDownloadProcessStr()

		local var_12_5 = manager.assetPend:GetDownloadProcess()

		arg_12_0.m_curProcessFill.text = string.format("%.1f", var_12_5 * 100) .. "%"
	else
		arg_12_0.isDownloading_controller:SetSelectedIndex(0)
	end
end

function var_0_0.RemoveTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.assetPendList[arg_14_1]
	local var_14_1 = AssetPendInfoCfg.get_id_list_by_asset_id[var_14_0][1]

	arg_14_2:SetData(var_14_1)
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.list:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
