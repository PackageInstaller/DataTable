local var_0_0 = class("SkinShopDownloadRequest")

var_0_0.Live2DGroupName = "L2D"

function var_0_0.CalcListSize(arg_1_0)
	local var_1_0 = GroupHelper.CalcSizeWithFileArr(var_0_0.Live2DGroupName, (GroupHelper.CreateArrByLuaFileList(var_0_0.Live2DGroupName, arg_1_0)))

	return var_1_0, (HashUtil.BytesToString(var_1_0))
end

function var_0_0.Ctor(arg_2_0)
	return
end

function var_0_0.Start(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.filePath = arg_3_1
	arg_3_0.fileList = {
		arg_3_1
	}
	arg_3_0.onSuccess = arg_3_2

	local var_3_0, var_3_1 = var_0_0.CalcListSize({
		arg_3_1
	})

	if var_3_0 > 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			locked = true,
			type = MSGBOX_TYPE_NORMAL,
			content = string.format(i18n("group_download_tip", var_3_1)),
			onYes = function()
				arg_3_0:Download()

				return
			end,
			onNo = function()
				arg_3_0:success()

				return
			end,
			onClose = function()
				arg_3_0:success()

				return
			end
		})
	else
		arg_3_0:success()
	end

	return
end

function var_0_0.Download(arg_6_0)
	local var_6_0 = BundleWizardUpdateInfo.New()

	var_6_0:AddGroup(var_0_0.Live2DGroupName, arg_6_0.fileList)

	var_6_0.infoName = arg_6_0.filePath

	if BundleWizardUpdater.Inst:GetFileList(var_6_0).Count > 0 then
		BundleWizardUpdater.Inst:StartUpdate(var_6_0, nil, function(arg_7_0, arg_7_1)
			if arg_7_0 then
				arg_6_0:success()
			else
				arg_6_0:error(arg_6_0.filePath, "")
			end

			return
		end, nil)
	else
		arg_6_0:success()
	end

	return
end

function var_0_0.success(arg_8_0)
	if arg_8_0.onSuccess then
		arg_8_0.onSuccess(checkABExist(arg_8_0.filePath))
	end

	return
end

function var_0_0.error(arg_9_0, arg_9_1, arg_9_2)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		locked = true,
		content = i18n("file_down_mgr_error", arg_9_1, arg_9_2),
		onYes = function()
			arg_9_0:Download()

			return
		end,
		onNo = function()
			arg_9_0:success()

			return
		end,
		onClose = function()
			arg_9_0:success()

			return
		end
	})

	return
end

function var_0_0.Refresh(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
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
	elseif var_12_3 == DownloadState.CheckToUpdate and not isActive(arg_12_0.downloadui) then
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

	if arg_12_0.live2dTimer then
		arg_12_0.live2dTimer:Stop()

		arg_12_0.live2dTimer = nil
	end

	if var_12_3 == DownloadState.CheckToUpdate or var_12_3 == DownloadState.UpdateFailure or var_12_3 == DownloadState.Updating then
		arg_12_0.live2dTimer = Timer.New(function()
			arg_12_0:Refresh(false, arg_12_2, arg_12_3)

			return
		end, 0.5, 1)

		arg_12_0.live2dTimer:Start()
	end

	if var_12_2 then
		arg_12_3(var_12_1)
	end

	return
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.live2dTimer then
		arg_14_0.live2dTimer:Stop()

		arg_14_0.live2dTimer = nil
	end

	return
end

return var_0_0
