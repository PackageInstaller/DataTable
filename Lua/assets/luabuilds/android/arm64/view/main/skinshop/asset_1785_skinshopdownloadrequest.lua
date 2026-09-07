local SkinShopDownloadRequest = class("SkinShopDownloadRequest")

SkinShopDownloadRequest.Live2DGroupName = "L2D"

function SkinShopDownloadRequest:CalcListSize()
	local var_1_0 = GroupHelper.CalcSizeWithFileArr(SkinShopDownloadRequest.Live2DGroupName, (GroupHelper.CreateArrByLuaFileList(SkinShopDownloadRequest.Live2DGroupName, self)))

	return var_1_0, (HashUtil.BytesToString(var_1_0))
end

function SkinShopDownloadRequest:Ctor()
	return
end

function SkinShopDownloadRequest:Start(arg_3_1, arg_3_2)
	self.filePath = arg_3_1
	self.fileList = {
		arg_3_1
	}
	self.onSuccess = arg_3_2

	local var_3_0, var_3_1 = SkinShopDownloadRequest.CalcListSize({
		arg_3_1
	})

	if var_3_0 > 0 then
		local function var_3_2()
			self:success()

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			locked = true,
			type = MSGBOX_TYPE_NORMAL,
			content = string.format(i18n("group_download_tip", var_3_1)),
			onYes = function()
				self:Download()

				return
			end,
			onNo = var_3_2,
			onClose = var_3_2
		})
	else
		self:success()
	end

	return
end

function SkinShopDownloadRequest:Download()
	local var_6_0 = BundleWizardUpdateInfo.New()

	var_6_0:AddGroup(SkinShopDownloadRequest.Live2DGroupName, self.fileList)

	var_6_0.infoName = self.filePath

	if BundleWizardUpdater.Inst:GetFileList(var_6_0).Count > 0 then
		BundleWizardUpdater.Inst:StartUpdate(var_6_0, nil, function(arg_7_0, arg_7_1)
			if arg_7_0 then
				self:success()
			else
				self:error(self.filePath, "")
			end

			return
		end, nil)
	else
		self:success()
	end

	return
end

function SkinShopDownloadRequest:success()
	if self.onSuccess then
		self.onSuccess(checkABExist(self.filePath))
	end

	return
end

function SkinShopDownloadRequest:error(arg_9_1, arg_9_2)
	local function var_9_0()
		self:success()

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		locked = true,
		content = i18n("file_down_mgr_error", arg_9_1, arg_9_2),
		onYes = function()
			self:Download()

			return
		end,
		onNo = var_9_0,
		onClose = var_9_0
	})

	return
end

function SkinShopDownloadRequest:Refresh(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = BundleWizard.Inst:GetGroupMgr("L2D")

	if var_12_0.state == DownloadState.None or var_12_0.state == DownloadState.CheckFailure then
		var_12_0:CheckD()
	end

	local var_12_1 = false
	local var_12_2 = false
	local var_12_3 = var_12_0:CheckF(arg_12_2)

	if var_12_3 == DownloadState.None then
		-- block empty
	elseif var_12_3 == DownloadState.Checking then
		-- block empty
	elseif var_12_3 == DownloadState.CheckToUpdate and arg_12_1 then
		VersionMgr.Inst:RequestUIForUpdateF("L2D", arg_12_2, true)
	elseif var_12_3 == DownloadState.CheckToUpdate and not isActive(self.downloadui) then
		var_12_2 = true
	elseif var_12_3 == DownloadState.CheckOver then
		-- block empty
	elseif var_12_3 == DownloadState.CheckFailure then
		var_12_2 = true
	elseif var_12_3 == DownloadState.Updating then
		-- block empty
	elseif var_12_3 == DownloadState.UpdateFailure then
		var_12_2 = true
	elseif var_12_3 == DownloadState.UpdateSuccess then
		var_12_2 = true
		var_12_1 = checkABExist(arg_12_2)
	end

	if self.live2dTimer then
		self.live2dTimer:Stop()

		self.live2dTimer = nil
	end

	if var_12_3 == DownloadState.CheckToUpdate or var_12_3 == DownloadState.UpdateFailure or var_12_3 == DownloadState.Updating then
		self.live2dTimer = Timer.New(function()
			self:Refresh(false, arg_12_2, arg_12_3)

			return
		end, 0.5, 1)

		self.live2dTimer:Start()
	end

	if var_12_2 then
		arg_12_3(var_12_1)
	end

	return
end

function SkinShopDownloadRequest:Dispose()
	if self.live2dTimer then
		self.live2dTimer:Stop()

		self.live2dTimer = nil
	end

	return
end

return SkinShopDownloadRequest
