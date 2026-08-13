class = var_0_10000

local var_0_0 = var_0_10000("SkinShopDownloadRequest")

var_0_0.Live2DGroupName = "L2D"

function var_0_0.CalcListSize(arg_1_0)
	GroupHelper = var_1_10001

	local var_1_0 = var_1_10001.CreateArrByLuaFileList(var_0_0.Live2DGroupName, arg_1_0)

	GroupHelper = var_1_10002

	local var_1_1 = var_1_10002.CalcSizeWithFileArr(var_0_0.Live2DGroupName, var_1_0)

	HashUtil = var_3

	local var_1_2 = var_3.BytesToString(var_1_1)

	return var_1_1, var_1_2
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
		local function var_3_2()
			local var_4_0 = arg_3_0

			var_0.Download(var_4_0)

			return
		end

		local function var_3_3()
			local var_5_0 = arg_3_0

			var_0.success(var_5_0)

			return
		end

		pg = var_1_10007

		local var_3_4 = var_1_10007.MsgboxMgr.GetInstance()
		local var_3_5 = var_7.ShowMsgBox
		local var_3_6 = {
			modal = true,
			locked = true
		}

		MSGBOX_TYPE_NORMAL = var_1_10011
		var_3_6.type = var_1_10011
		string = var_1_10011

		local var_3_7 = var_1_10011.format

		i18n = var_1_10013
		var_3_6.content = var_3_7(var_1_10013("group_download_tip", var_3_1))
		var_3_6.onYes = var_3_2
		var_3_6.onNo = var_3_3
		var_3_6.onClose = var_3_3

		var_3_5(var_3_4, var_3_6)
	else
		arg_3_0:success()
	end

	return
end

function var_0_0.Download(arg_6_0)
	BundleWizardUpdateInfo = var_1_10001

	local var_6_0 = var_1_10001.New()

	var_1.AddGroup(var_6_0, var_0_0.Live2DGroupName, arg_6_0.fileList)

	var_1.infoName = arg_6_0.filePath
	BundleWizardUpdater = var_2

	local var_6_1 = var_2.Inst
	local var_6_2 = var_2.GetFileList(var_6_1, var_1).Count

	if 0 < var_6_2 then
		local function var_6_3(arg_7_0, arg_7_1)
			if arg_7_0 then
				local var_7_0 = arg_6_0

				var_2.success(var_7_0)
			else
				local var_7_1 = arg_6_0

				var_2.error(var_7_1, arg_6_0.filePath, "")
			end

			return
		end

		BundleWizardUpdater = var_4

		local var_6_4 = var_4.Inst

		var_4.StartUpdate(var_6_4, var_1, nil, var_6_3, nil)
	else
		arg_6_0:success()
	end

	return
end

function var_0_0.success(arg_8_0)
	if arg_8_0.onSuccess then
		local var_8_0 = arg_8_0.onSuccess

		checkABExist = var_1_10003

		var_8_0(var_1_10003(arg_8_0.filePath))
	end

	return
end

function var_0_0.error(arg_9_0, arg_9_1, arg_9_2)
	local function var_9_0()
		local var_10_0 = arg_9_0

		var_0.Download(var_10_0)

		return
	end

	local function var_9_1()
		local var_11_0 = arg_9_0

		var_0.success(var_11_0)

		return
	end

	pg = var_1_10005

	local var_9_2 = var_1_10005.MsgboxMgr.GetInstance()
	local var_9_3 = var_5.ShowMsgBox
	local var_9_4 = {
		modal = true,
		locked = true
	}

	i18n = var_1_10009
	var_9_4.content = var_1_10009("file_down_mgr_error", arg_9_1, arg_9_2)
	var_9_4.onYes = var_9_0
	var_9_4.onNo = var_9_1
	var_9_4.onClose = var_9_1

	var_9_3(var_9_2, var_9_4)

	return
end

function var_0_0.Refresh(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	BundleWizard = var_1_10004

	local var_12_0 = var_1_10004.Inst
	local var_12_1 = var_4.GetGroupMgr(var_12_0, "L2D").state

	DownloadState = var_12_0

	if var_12_1 ~= var_12_0.None then
		DownloadState = var_6

		if var_12_1 == var_6.CheckFailure then
			var_4:CheckD()
		end

		local var_12_2 = false
		local var_12_3 = false
		local var_12_4 = var_4:CheckF(arg_12_2)

		DownloadState = var_1_10009

		if var_12_4 == var_1_10009.None then
			-- block empty
		else
			DownloadState = var_9

			if var_12_4 == var_9.Checking then
				-- block empty
			else
				DownloadState = var_9

				if var_12_4 == var_9.CheckToUpdate and arg_12_1 then
					VersionMgr = var_9

					local var_12_5 = var_9.Inst

					var_9.RequestUIForUpdateF(var_12_5, "L2D", arg_12_2, true)
				else
					DownloadState = var_9

					if var_12_4 == var_9.CheckToUpdate then
						isActive = var_9

						if not var_9(arg_12_0.downloadui) then
							var_12_3 = true

							goto label_12_0
						end
					end

					DownloadState = var_9

					if var_12_4 == var_9.CheckOver then
						-- block empty
					else
						DownloadState = var_9

						if var_12_4 == var_9.CheckFailure then
							var_12_3 = true
						else
							DownloadState = var_9

							if var_12_4 == var_9.Updating then
								-- block empty
							else
								DownloadState = var_9

								if var_12_4 == var_9.UpdateFailure then
									var_12_3 = true
								else
									DownloadState = var_9

									if var_12_4 == var_9.UpdateSuccess then
										var_12_3 = true
										checkABExist = var_9
										var_12_2 = var_9(arg_12_2)
									end
								end
							end
						end
					end
				end
			end
		end

		::label_12_0::

		if arg_12_0.live2dTimer then
			local var_12_6 = arg_12_0.live2dTimer

			var_9.Stop(var_12_6)

			arg_12_0.live2dTimer = nil
		end

		DownloadState = var_9

		if var_12_4 ~= var_9.CheckToUpdate then
			DownloadState = var_9

			if var_12_4 ~= var_9.UpdateFailure then
				DownloadState = var_9

				if var_12_4 == var_9.Updating then
					Timer = var_9
					arg_12_0.live2dTimer = var_9.New(function()
						local var_13_0 = arg_12_0

						var_0.Refresh(var_13_0, false, arg_12_2, arg_12_3)

						return
					end, 0.5, 1)

					local var_12_7 = arg_12_0.live2dTimer

					var_9.Start(var_12_7)
				end

				if var_12_3 then
					arg_12_3(var_12_2)
				end

				return
			end
		end
	end
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.live2dTimer then
		local var_14_0 = arg_14_0.live2dTimer

		var_1.Stop(var_14_0)

		arg_14_0.live2dTimer = nil
	end

	return
end

return var_0_0
