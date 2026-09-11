local AssetPendPopView = class("AssetPendPopView", ReduxView)

function AssetPendPopView:UIName()
	return "Widget/System/Setting/AssetPend/AssetPendGameplayPopUI"
end

function AssetPendPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AssetPendPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AssetPendPopView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, AssetPendPopItem)
	self.isDownloading_controller = self.m_controller:GetController("isDownloading")
end

function AssetPendPopView:AddUIListener()
	self:AddBtnListener(self.m_closeBtn, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.m_GotoBtn, nil, function()
		JumpTools.GoToSystem("/setting", {
			toggleName = "AssetPend",
			setType = SettingConst.SETTING_TYPE.SYSTEM
		}, ViewConst.SYSTEM_ID.SETTING)
	end)
end

function AssetPendPopView:OnTop()
	manager.windowBar:SwitchBar({})
end

function AssetPendPopView:OnEnter()
	self.assetPend = self.params_.assetPend
	self.assetPendList = {
		self.assetPend
	}

	self.list:StartScroll(#self.assetPendList)
	self:RemoveTimer()

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			for iter_10_0, iter_10_1 in pairs((self.list:GetItemList())) do
				iter_10_1:RefreshUI()
			end

			self:RefreshCurAssetPend()
		end, 0.1, -1)
	end

	self.timer_:Start()
	self:RefreshCurAssetPend()
end

function AssetPendPopView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveTimer()
end

function AssetPendPopView:RefreshCurAssetPend()
	local var_12_0 = false
	local var_12_1 = manager.assetPend:GetDownloadingKey()

	for iter_12_0, iter_12_1 in ipairs(self.assetPendList) do
		if iter_12_1 == var_12_1 then
			var_12_0 = true

			break
		end
	end

	if manager.assetPend:GetIsDownloading() and not var_12_0 then
		self.isDownloading_controller:SetSelectedIndex(1)

		local var_12_2 = manager.assetPend:GetDownloadingKey()

		self.m_curTitle.text = AssetPendInfoCfg[AssetPendInfoCfg.get_id_list_by_asset_id[var_12_2][1]] and AssetPendInfoCfg[AssetPendInfoCfg.get_id_list_by_asset_id[var_12_2][1]].asset_name or var_12_2
		self.m_curProcessLab.text = manager.assetPend:GetDownloadProcessStr()
		self.m_curProcessFill.text = string.format("%.1f", manager.assetPend:GetDownloadProcess() * 100) .. "%"
	else
		self.isDownloading_controller:SetSelectedIndex(0)
	end
end

function AssetPendPopView:RemoveTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AssetPendPopView:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(AssetPendInfoCfg.get_id_list_by_asset_id[self.assetPendList[arg_14_1]][1])
end

function AssetPendPopView:Dispose()
	self.list:Dispose()
	AssetPendPopView.super.Dispose(self)
end

return AssetPendPopView
