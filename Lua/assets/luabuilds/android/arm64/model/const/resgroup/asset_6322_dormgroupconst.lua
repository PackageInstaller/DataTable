local var_0_0 = {}

var_0_0.DormGroupName = "DORM"
var_0_0.DormMgr = nil

function var_0_0.GetDormMgr()
	var_0_0.DormMgr = var_0_0.DormMgr or BundleWizard.Inst:GetGroupMgr(var_0_0.DormGroupName)

	return var_0_0.DormMgr
end

var_0_0.NotifyDormDownloadStart = "DormGroupConst.NotifyDormDownloadStart"
var_0_0.NotifyDormDownloadProgress = "DormGroupConst.NotifyDormDownloadProgress"
var_0_0.NotifyDormDownloadFinish = "DormGroupConst.NotifyDormDownloadFinish"

function var_0_0.VerifyDormFileName(arg_2_0)
	return GroupHelper.VerifyFile(var_0_0.DormGroupName, arg_2_0)
end

function var_0_0.CalcDormListSize(arg_3_0)
	local var_3_0 = GroupHelper.CalcSizeWithFileArr(var_0_0.DormGroupName, (GroupHelper.CreateArrByLuaFileList(var_0_0.DormGroupName, arg_3_0)))

	return var_3_0, (HashUtil.BytesToString(var_3_0))
end

function var_0_0.IsDormNeedCheck()
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

function var_0_0:DormDownload()
	local var_5_0 = {}

	if var_0_0.IsDormNeedCheck() then
		local var_5_1 = IsUsingWifi()
		local var_5_2 = self.fileList

		if #self.fileList > 0 then
			if self.isShowBox and pg.FileDownloadMgr.GetInstance():IsNeedRemind() then
				local var_5_3, var_5_4 = var_0_0.CalcDormListSize(var_5_2)

				if var_5_3 > 0 then
					table.insert(var_5_0, function(arg_6_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							modal = true,
							locked = true,
							hideToggle = true,
							type = MSGBOX_TYPE_FILE_DOWNLOAD,
							content = string.format(i18n("file_down_msgbox", var_5_4)),
							onYes = arg_6_0,
							onNo = self.onNo,
							onClose = self.onClose
						})

						return
					end)
				end
			end

			table.insert(var_5_0, function(arg_7_0)
				var_0_0.DormDownloadLock = {
					curSize = 0,
					totalSize = 1,
					roomId = self.roomId
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
			table.insert(var_5_0, function(arg_8_0, arg_8_1)
				var_0_0.DormDownloadLock = nil

				pg.m02:sendNotification(var_0_0.NotifyDormDownloadFinish, var_0_0.DormDownloadLock.roomId)
				arg_8_0(arg_8_1)

				return
			end)
		end
	end

	seriesAsync(var_5_0, self.finishFunc)

	return
end

function var_0_0:ExtraDownload()
	local var_9_0 = self.onFinish
	local var_9_1 = self.dataList[1]
	local var_9_2 = #self.dataList[1].fileNameList > 0 and GroupHelper.CreateArrByLuaFileList(self.dataList[1].groupName, var_9_1.fileNameList) or nil

	if not var_9_2 or var_9_2.Length == 0 then
		self.onFinish()

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

		if arg_12_0 then
			var_9_0(true)
		else
			local function var_12_0()
				var_9_0()

				return
			end

			local var_12_1 = {
				modal = true,
				locked = true,
				content = i18n("file_down_mgr_error", "", "")
			}

			function var_12_1.onYes()
				var_0_0.ExtraDownload(self)

				return
			end

			var_12_1.onNo = var_12_0
			var_12_1.onClose = var_12_0

			pg.MsgboxMgr.GetInstance():ShowMsgBox(var_12_1)
		end

		return
	end, var_9_3)))

	return
end

function var_0_0.IsDownloading()
	local var_15_0 = GroupHelper.GetGroupMgrByName(var_0_0.DormGroupName)

	return var_0_0.DormDownloadLock or GroupHelper.GetGroupMgrByName(var_0_0.DormGroupName).state == DownloadState.Updating
end

function var_0_0.GetDownloadList()
	local var_16_0 = {}
	local var_16_1 = GroupHelper.GetGroupMgrByName(var_0_0.DormGroupName)

	if var_16_1.toUpdate then
		for iter_16_0 = 0, var_16_1.toUpdate.Count - 1 do
			table.insert(var_16_0, var_16_1.toUpdate[iter_16_0][0])
		end
	end

	return var_16_0
end

local var_0_1 = {
	room = "dorm3d/scenesres/scenes/",
	apartment = "dorm3d/character/"
}
local var_0_2

function var_0_0.GetDownloadResourceDic()
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

function var_0_0.GetFilePathList(arg_18_0)
	local var_18_0 = Application.persistentDataPath .. "/AssetBundles/"

	if not (Application.persistentDataPath .. "/AssetBundles/"):match("/$") then
		var_18_0 = var_18_0 .. "/"
	end

	originalPrint("fullCacheDirPath", tostring(var_18_0))
	originalPrint("shortDirPath:", tostring(arg_18_0))
	originalPrint("fullDirPath", tostring((Application.persistentDataPath .. "/AssetBundles/") .. arg_18_0))

	local var_18_1 = {}

	originalPrint("fullDirPath Exist:", tostring(System.IO.Directory.Exists((Application.persistentDataPath .. "/AssetBundles/") .. arg_18_0)))

	if System.IO.Directory.Exists((Application.persistentDataPath .. "/AssetBundles/") .. arg_18_0) then
		for iter_18_0, iter_18_1 in ipairs((System.IO.Directory.GetFiles((Application.persistentDataPath .. "/AssetBundles/") .. arg_18_0, "*", (ReflectionHelp.RefGetField(typeof("System.IO.SearchOption"), "AllDirectories", nil))):ToTable())) do
			iter_18_1 = iter_18_1:gsub("\\", "/")

			table.insert(var_18_1, (string.sub(iter_18_1, #var_18_0 + 1)))
		end
	end

	originalPrint("filePathList first:", tostring(var_18_1[1]))
	originalPrint("filePathList last:", tostring(var_18_1[#var_18_1]))

	return var_18_1
end

function var_0_0.DelDir(arg_19_0)
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

function var_0_0.GetDelRoomSize(arg_20_0, arg_20_1)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		var_20_0 = var_20_0 + var_0_0.GetDormMgr():GetCacheFileSize((var_0_0.GetFilePathList(var_0_1[iter_20_1] .. arg_20_0)))
	end

	return HashUtil.BytesToString(var_20_0)
end

function var_0_0.DelRoom(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		var_0_0.DelDir(var_0_1[iter_21_1] .. arg_21_0)
	end

	return
end

return var_0_0
