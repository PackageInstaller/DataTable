local var_0_0 = {}

;({}).DormGroupName = "DORM"
;({}).DormMgr = nil
;({}).GetDormMgr = function()
	var_0_0.DormMgr = var_0_0.DormMgr or BundleWizard.Inst:GetGroupMgr(var_0_0.DormGroupName)

	return var_0_0.DormMgr
end
;({}).NotifyDormDownloadStart = "DormGroupConst.NotifyDormDownloadStart"
;({}).NotifyDormDownloadProgress = "DormGroupConst.NotifyDormDownloadProgress"
;({}).NotifyDormDownloadFinish = "DormGroupConst.NotifyDormDownloadFinish"
;({}).VerifyDormFileName = function(arg_2_0)
	return GroupHelper.VerifyFile(var_0_0.DormGroupName, arg_2_0)
end
;({}).CalcDormListSize = function(arg_3_0)
	local var_3_0 = GroupHelper.CalcSizeWithFileArr(var_0_0.DormGroupName, (GroupHelper.CreateArrByLuaFileList(var_0_0.DormGroupName, arg_3_0)))

	return var_3_0, (HashUtil.BytesToString(var_3_0))
end
;({}).IsDormNeedCheck = function()
	if Application.isEditor then
		return false
	end

	if GroupHelper.IsGroupVerLastest(var_0_0.DormGroupName) then
		return false
	end

	if not GroupHelper.IsGroupWaitToUpdate(var_0_0.DormGroupName) then
		return false
	end

	return true
end
;({}).DormDownload = function(arg_5_0)
	if var_0_0.IsDormNeedCheck() then
		local var_5_0 = IsUsingWifi()
		local var_5_1 = arg_5_0.isShowBox and pg.FileDownloadMgr.GetInstance():IsNeedRemind()
		local var_5_2 = arg_5_0.fileList

		if #arg_5_0.fileList > 0 then
			if var_5_1 then
				local var_5_3, var_5_4 = var_0_0.CalcDormListSize(var_5_2)

				if var_5_3 > 0 then
					table.insert({}, function(arg_6_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							modal = true,
							locked = true,
							hideToggle = true,
							type = MSGBOX_TYPE_FILE_DOWNLOAD,
							content = string.format(i18n("file_down_msgbox", var_5_4)),
							onYes = arg_6_0,
							onNo = arg_5_0.onNo,
							onClose = arg_5_0.onClose
						})

						return
					end)
				end
			end

			table.insert({}, function(arg_7_0)
				var_0_0.DormDownloadLock = {
					curSize = 0,
					totalSize = 1,
					roomId = arg_5_0.roomId
				}

				var_0_0.ExtraDownload({
					dataList = {
						{
							groupName = var_0_0.DormGroupName,
							fileNameList = var_5_2
						}
					},
					onFinish = arg_7_0
				})

				return
			end)
			table.insert({}, function(arg_8_0, arg_8_1)
				var_0_0.DormDownloadLock = nil

				pg.m02:sendNotification(var_0_0.NotifyDormDownloadFinish, var_0_0.DormDownloadLock.roomId)
				arg_8_0(arg_8_1)

				return
			end)
		end
	end

	seriesAsync({}, arg_5_0.finishFunc)

	return
end
;({}).ExtraDownload = function(arg_9_0)
	local var_9_0 = arg_9_0.onFinish
	local var_9_1 = arg_9_0.dataList[1]
	local var_9_2 = #arg_9_0.dataList[1].fileNameList > 0 and GroupHelper.CreateArrByLuaFileList(arg_9_0.dataList[1].groupName, var_9_1.fileNameList) or nil

	if not var_9_2 or var_9_2.Length == 0 then
		arg_9_0.onFinish()

		return
	end

	local function var_9_3(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
		local var_10_0 = tonumber(tostring(arg_10_3))

		if var_0_0.DormDownloadLock.curSize ~= var_10_0 then
			var_0_0.DormDownloadLock.curSize = var_10_0
			var_0_0.DormDownloadLock.totalSize = tonumber(tostring(arg_10_4))

			pg.m02:sendNotification(var_0_0.NotifyDormDownloadProgress)
		end

		return
	end

	pg.m02:sendNotification(var_0_0.NotifyDormDownloadStart)
	BundleWizardUpdater.Inst:StartUpdate((BundleWizardUpdater.Inst:CreateListInfo(var_9_1.groupName, BundleWizardUpdater.Inst:GetFileList(var_9_1.groupName, var_9_1.fileNameList), function(arg_11_0, arg_11_1, arg_11_2)
		return
	end, function(arg_12_0, arg_12_1)
		pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataDownload(var_0_0.DormDownloadLock.roomId, arg_12_0 and 1 or 2))

		local var_12_0

		if arg_12_0 then
			var_9_0(true)

			goto label_12_0

			var_12_0 = {
				modal = true,
				locked = true,
				content = i18n("file_down_mgr_error", "", "")
			}
		end

		function var_12_0.onYes()
			var_0_0.ExtraDownload(arg_9_0)

			return
		end

		function var_12_0.onNo()
			var_9_0()

			return
		end

		function var_12_0.onClose()
			var_9_0()

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox(var_12_0)

		::label_12_0::

		return
	end, var_9_3)))

	return
end
;({}).IsDownloading = function()
	local var_15_0 = GroupHelper.GetGroupMgrByName(var_0_0.DormGroupName)

	return var_0_0.DormDownloadLock or GroupHelper.GetGroupMgrByName(var_0_0.DormGroupName).state == DownloadState.Updating
end
;({}).GetDownloadList = function()
	local var_16_0 = GroupHelper.GetGroupMgrByName(var_0_0.DormGroupName)

	if var_16_0.toUpdate then
		for iter_16_0 = 0, var_16_0.toUpdate.Count - 1 do
			table.insert({}, var_16_0.toUpdate[iter_16_0][0])
		end
	end

	return {}
end

local var_0_1 = {
	room = "dorm3d/scenesres/scenes/",
	apartment = "dorm3d/character/"
}
local var_0_2

;({}).GetDownloadResourceDic = function()
	if not var_0_2 then
		var_0_2 = {}

		for iter_17_0, iter_17_1 in ipairs(pg.dorm3d_rooms.all) do
			if pg.dorm3d_rooms[iter_17_1].is_common == 1 then
				-- block empty
			else
				var_0_2[string.lower(pg.dorm3d_rooms[iter_17_1].resource_name)] = true
			end
		end
	end

	local var_17_0 = {}

	for iter_17_2, iter_17_3 in ipairs(DormGroupConst.GetDownloadList()) do
		local var_17_1 = "common"

		for iter_17_4, iter_17_5 in pairs(var_0_1) do
			local var_17_2, var_17_3 = string.find(iter_17_3, iter_17_5)

			if var_17_3 then
				local var_17_4 = string.split(string.sub(iter_17_3, var_17_3 + 1), "/")[1]

				if var_0_2[var_17_4] then
					var_17_1 = iter_17_4 .. "_" .. var_17_4
				end

				break
			end
		end

		var_17_0[var_17_1] = var_17_0[var_17_1] or {}

		table.insert(var_17_0[var_17_1], iter_17_3)
	end

	return var_17_0
end
;({}).GetFilePathList = function(arg_18_0)
	local var_18_0 = Application.persistentDataPath .. "/AssetBundles/"

	if not (Application.persistentDataPath .. "/AssetBundles/"):match("/$") then
		var_18_0 = var_18_0 .. "/"
	end

	originalPrint("fullCacheDirPath", tostring(var_18_0))
	originalPrint("shortDirPath:", tostring(arg_18_0))
	originalPrint("fullDirPath", tostring((Application.persistentDataPath .. "/AssetBundles/") .. arg_18_0))
	originalPrint("fullDirPath Exist:", tostring(System.IO.Directory.Exists((Application.persistentDataPath .. "/AssetBundles/") .. arg_18_0)))

	if System.IO.Directory.Exists((Application.persistentDataPath .. "/AssetBundles/") .. arg_18_0) then
		for iter_18_0, iter_18_1 in ipairs((System.IO.Directory.GetFiles((Application.persistentDataPath .. "/AssetBundles/") .. arg_18_0, "*", (ReflectionHelp.RefGetField(typeof("System.IO.SearchOption"), "AllDirectories", nil))):ToTable())) do
			iter_18_1 = iter_18_1:gsub("\\", "/")

			table.insert({}, (string.sub(iter_18_1, #var_18_0 + 1)))
		end
	end

	originalPrint("filePathList first:", tostring(({})[1]))
	originalPrint("filePathList last:", tostring(({})[#{}]))

	return {}
end
;({}).DelDir = function(arg_19_0)
	local var_19_0 = var_0_0.GetFilePathList(arg_19_0)

	if #var_19_0 > 0 then
		local var_19_1 = System.Array.CreateInstance(typeof(System.String), #var_19_0)

		for iter_19_0 = 0, #var_19_0 - 1 do
			var_19_1[iter_19_0] = var_19_0[iter_19_0 + 1]
		end

		HotfixHelper.DeleteFileByShortPathArr(var_0_0.DormGroupName, var_19_1)
	end

	return
end
;({}).GetDelRoomSize = function(arg_20_0, arg_20_1)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		local var_20_1 = var_0_0.GetDormMgr()

		var_20_0 = var_20_0 + var_20_1:GetCacheFileSize((var_0_0.GetFilePathList(var_0_1[iter_20_1] .. arg_20_0)))
	end

	return HashUtil.BytesToString(var_20_0)
end
;({}).DelRoom = function(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		var_0_0.DelDir(var_0_1[iter_21_1] .. arg_21_0)
	end

	return
end

return {}
