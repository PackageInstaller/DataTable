local var_0_0 = {}

var_0_0.DormGroupName = "DORM"
var_0_0.DormMgr = nil

function var_0_0.GetDormMgr()
	if not var_0_0.DormMgr then
		local var_1_0 = var_0_0

		BundleWizard = var_1_10001

		local var_1_1 = var_1_10001.Inst

		var_1_0.DormMgr = var_1.GetGroupMgr(var_1_1, var_0_0.DormGroupName)
	end

	return var_0_0.DormMgr
end

var_0_0.NotifyDormDownloadStart = "DormGroupConst.NotifyDormDownloadStart"
var_0_0.NotifyDormDownloadProgress = "DormGroupConst.NotifyDormDownloadProgress"
var_0_0.NotifyDormDownloadFinish = "DormGroupConst.NotifyDormDownloadFinish"

function var_0_0.VerifyDormFileName(arg_2_0)
	GroupHelper = var_1_10001

	return var_1_10001.VerifyFile(var_0_0.DormGroupName, arg_2_0)
end

function var_0_0.CalcDormListSize(arg_3_0)
	GroupHelper = var_1_10001

	local var_3_0 = var_1_10001.CreateArrByLuaFileList(var_0_0.DormGroupName, arg_3_0)

	GroupHelper = var_2

	local var_3_1 = var_2.CalcSizeWithFileArr(var_0_0.DormGroupName, var_3_0)

	HashUtil = var_3

	local var_3_2 = var_3.BytesToString(var_3_1)

	return var_3_1, var_3_2
end

function var_0_0.IsDormNeedCheck()
	Application = var_1_10000

	if var_1_10000.isEditor then
		return false
	end

	GroupHelper = var_0

	if var_0.IsGroupVerLastest(var_0_0.DormGroupName) then
		return false
	end

	GroupHelper = var_0

	if not var_0.IsGroupWaitToUpdate(var_0_0.DormGroupName) then
		return false
	end

	return true
end

function var_0_0.DormDownload(arg_5_0)
	local var_5_0 = {}
	local var_5_1

	if var_0_0.IsDormNeedCheck() then
		var_5_1 = arg_5_0.isShowBox
		pg = var_1_10003

		local var_5_2 = var_1_10003.FileDownloadMgr.GetInstance()
		local var_5_3 = var_3.IsNeedRemind(var_5_2)

		IsUsingWifi = var_5_2

		local var_5_4 = var_5_2()
		local var_5_5 = var_5_1 and var_5_3

		if #arg_5_0.fileList > 0 then
			local var_5_6

			if var_5_5 then
				local var_5_7

				var_5_6, var_5_7 = var_0_0.CalcDormListSize(var_6)

				if 0 < var_5_6 then
					table = var_9

					var_9.insert(var_5_0, function(arg_6_0)
						pg = var_2_10001

						local var_6_0 = var_2_10001.MsgboxMgr.GetInstance()
						local var_6_1 = var_1.ShowMsgBox
						local var_6_2 = {
							modal = true,
							locked = true,
							hideToggle = true
						}

						MSGBOX_TYPE_FILE_DOWNLOAD = var_2_10004
						var_6_2.type = var_2_10004
						string = var_2_10004

						local var_6_3 = var_2_10004.format

						i18n = var_2_10005
						var_6_2.content = var_6_3(var_2_10005("file_down_msgbox", var_5_7))
						var_6_2.onYes = arg_6_0
						var_6_2.onNo = arg_5_0.onNo
						var_6_2.onClose = arg_5_0.onClose

						var_6_1(var_6_0, var_6_2)

						return
					end)
				end
			end

			table = var_5_6

			var_5_6.insert(var_5_0, function(arg_7_0)
				var_0_0.DormDownloadLock = {
					curSize = 0,
					totalSize = 1,
					roomId = arg_5_0.roomId
				}

				local var_7_0 = {
					groupName = var_0_0.DormGroupName,
					fileNameList = var_0
				}
				local var_7_1 = {
					dataList = {
						var_7_0
					},
					onFinish = arg_7_0
				}

				var_0_0.ExtraDownload(var_7_1)

				return
			end)

			table = var_7

			var_7.insert(var_5_0, function(arg_8_0, arg_8_1)
				local var_8_0 = var_0_0.DormDownloadLock.roomId
				local var_8_1 = var_0_0

				var_8_1.DormDownloadLock = nil
				pg = var_8_1

				local var_8_2 = var_8_1.m02

				var_3.sendNotification(var_8_2, var_0_0.NotifyDormDownloadFinish, var_8_0)
				arg_8_0(arg_8_1)

				return
			end)
		end
	end

	seriesAsync = var_5_1

	var_5_1(var_5_0, arg_5_0.finishFunc)

	return
end

function var_0_0.ExtraDownload(arg_9_0)
	local var_9_0 = arg_9_0.onFinish
	local var_9_1 = arg_9_0.dataList[1].groupName

	if #var_2.fileNameList > 0 then
		GroupHelper = var_4

		local var_9_2

		if not var_4.CreateArrByLuaFileList(var_9_1, var_2.fileNameList) then
			var_9_2 = nil
		end

		if not var_9_2 or var_9_2.Length == 0 then
			var_9_0()

			return
		end

		local function var_9_3(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
			tonumber = var_2_10006
			tostring = var_2_10007

			local var_10_0 = var_2_10006(var_2_10007(arg_10_3))

			tonumber = var_7
			tostring = var_8

			local var_10_1 = var_7(var_8(arg_10_4))

			if var_0_0.DormDownloadLock.curSize ~= var_10_0 then
				var_0_0.DormDownloadLock.curSize = var_10_0

				local var_10_2 = var_0_0.DormDownloadLock

				var_10_2.totalSize = var_10_1
				pg = var_10_2

				local var_10_3 = var_10_2.m02

				var_8.sendNotification(var_10_3, var_0_0.NotifyDormDownloadProgress)
			end

			return
		end

		local function var_9_4(arg_11_0, arg_11_1, arg_11_2)
			return
		end

		local function var_9_5(arg_12_0, arg_12_1)
			pg = var_2_10002

			local var_12_0 = var_2_10002.m02
			local var_12_1 = var_2.sendNotification

			GAME = var_2_10004

			local var_12_2 = var_2_10004.APARTMENT_TRACK

			Dorm3dTrackCommand = var_2_10005

			var_12_1(var_12_0, var_12_2, var_2_10005.BuildDataDownload(var_0_0.DormDownloadLock.roomId, arg_12_0 and 1 or 2))

			if arg_12_0 then
				var_9_0(true)
			else
				local function var_12_3()
					var_0_0.ExtraDownload(arg_9_0)

					return
				end

				local function var_12_4()
					var_9_0()

					return
				end

				pg = var_12_2

				local var_12_5 = var_12_2.MsgboxMgr.GetInstance()
				local var_12_6 = var_4.ShowMsgBox
				local var_12_7 = {
					modal = true,
					locked = true
				}

				i18n = var_7
				var_12_7.content = var_7("file_down_mgr_error", "", "")
				var_12_7.onYes = var_12_3
				var_12_7.onNo = var_12_4
				var_12_7.onClose = var_12_4

				var_12_6(var_12_5, var_12_7)
			end

			return
		end

		pg = var_1_10008

		local var_9_6 = var_1_10008.m02

		var_8.sendNotification(var_9_6, var_0_0.NotifyDormDownloadStart)

		BundleWizardUpdater = var_8

		local var_9_7 = var_8.Inst
		local var_9_8 = var_8.GetFileList(var_9_7, var_2.groupName, var_2.fileNameList)

		BundleWizardUpdater = var_9_7

		local var_9_9 = var_9_7.Inst
		local var_9_10 = var_9.CreateListInfo(var_9_9, var_2.groupName, var_9_8, var_9_4, var_9_5, var_9_3)

		BundleWizardUpdater = var_9_9

		local var_9_11 = var_9_9.Inst

		var_10.StartUpdate(var_9_11, var_9_10)

		return
	end
end

function var_0_0.IsDownloading()
	GroupHelper = var_1_10000

	local var_15_0 = var_1_10000.GetGroupMgrByName(var_0_0.DormGroupName)
	local var_15_1

	if not var_0_0.DormDownloadLock then
		GroupHelper = var_15_1
		var_15_1 = var_15_1.GetGroupMgrByName(var_0_0.DormGroupName).state
		DownloadState = var_2
		var_15_1 = var_15_1 == var_2.Updating
	end

	return var_15_1
end

function var_0_0.GetDownloadList()
	local var_16_0 = {}

	GroupHelper = var_1_10001

	if var_1_10001.GetGroupMgrByName(var_0_0.DormGroupName).toUpdate then
		local var_16_1 = var_1.toUpdate.Count

		for iter_16_0 = 0, var_16_1 - 1 do
			local var_16_2 = var_1.toUpdate[iter_16_0][0]
			local var_16_3 = var_7[1]
			local var_16_4 = var_7[2]

			table = var_1_10011

			var_1_10011.insert(var_16_0, var_16_2)
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
		ipairs = var_0
		pg = var_1_10001

		for iter_17_0, iter_17_1 in var_0(var_1_10001.dorm3d_rooms.all) do
			pg = var_1_10005

			if var_1_10005.dorm3d_rooms[iter_17_1].is_common == 1 then
				-- block empty
			else
				string = var_6

				local var_17_0 = var_6.lower(var_1_10005.resource_name)

				var_1_10007 = var_0_2
				var_1_10007[var_17_0] = true
			end
		end
	end

	local var_17_1 = {}

	ipairs = var_1_10001
	DormGroupConst = var_1_10002

	for iter_17_2, iter_17_3 in var_1_10001(var_1_10002.GetDownloadList()) do
		local var_17_2 = "common"

		pairs = var_1_10007

		for iter_17_4, iter_17_5 in var_1_10007(var_0_1) do
			string = var_1_10012

			local var_17_3

			var_1_10012, var_17_3 = var_1_10012.find(iter_17_3, iter_17_5)

			if var_17_3 then
				string = var_14

				local var_17_4 = var_14.split

				string = var_1_10015

				local var_17_5 = var_17_4(var_1_10015.sub(iter_17_3, var_17_3 + 1), "/")[1]

				if var_0_2[var_17_5] then
					var_17_2 = iter_17_4 .. "_" .. var_17_5
				end

				break
			end
		end

		if not var_17_1[var_17_2] then
			var_1_10007 = {}
		end

		var_17_1[var_17_2] = var_1_10007
		table = var_1_10007

		var_1_10007.insert(var_17_1[var_17_2], iter_17_3)
	end

	return var_17_1
end

function var_0_0.GetFilePathList(arg_18_0)
	Application = var_1_10001

	local var_18_0 = (var_1_10001.persistentDataPath .. "/AssetBundles/") .. arg_18_0
	local var_18_1

	if not var_18_1:match("/$") then
		var_18_1 = var_18_1 .. "/"
	end

	originalPrint = var_3

	local var_18_2 = "fullCacheDirPath"

	tostring = var_5

	var_3(var_18_2, var_5(var_18_1))

	originalPrint = var_3

	local var_18_3 = "shortDirPath:"

	tostring = var_5

	var_3(var_18_3, var_5(arg_18_0))

	originalPrint = var_3

	local var_18_4 = "fullDirPath"

	tostring = var_5

	var_3(var_18_4, var_5(var_18_0))

	local var_18_5 = {}

	System = var_18_4

	local var_18_6 = var_18_4.IO.Directory

	ReflectionHelp = var_5

	local var_18_7 = var_5.RefGetField

	typeof = var_6

	local var_18_8 = var_18_7(var_6("System.IO.SearchOption"), "AllDirectories", nil)

	originalPrint = var_6

	local var_18_9 = "fullDirPath Exist:"

	tostring = var_8

	var_6(var_18_9, var_8(var_18_6.Exists(var_18_0)))

	local var_18_11

	if var_18_6.Exists(var_18_0) then
		local var_18_10 = var_18_6.GetFiles(var_18_0, "*", var_18_8)

		var_18_11 = var_18_11.ToTable(var_18_10)
		ipairs = var_18_10

		for iter_18_0, iter_18_1 in var_18_10(var_18_11) do
			iter_18_1 = iter_18_1:gsub("\\", "/")
			string = var_12

			local var_18_12 = var_12.sub(iter_18_1, #var_18_1 + 1)

			table = var_13

			var_13.insert(var_18_5, var_18_12)
		end
	end

	originalPrint = var_18_11

	local var_18_13 = "filePathList first:"

	tostring = var_8

	var_18_11(var_18_13, var_8(var_18_5[1]))

	originalPrint = var_18_11

	local var_18_14 = "filePathList last:"

	tostring = var_8

	var_18_11(var_18_14, var_8(var_18_5[#var_18_5]))

	return var_18_5
end

function var_0_0.DelDir(arg_19_0)
	local var_19_0 = #var_0_0.GetFilePathList(arg_19_0)

	if 0 < var_19_0 then
		System = var_3

		local var_19_1 = var_3.Array.CreateInstance

		typeof = var_1_10004
		System = var_1_10005

		local var_19_2 = var_19_1(var_1_10004(var_1_10005.String), var_19_0)

		for iter_19_0 = 0, var_19_0 - 1 do
			var_19_2[iter_19_0] = var_1[iter_19_0 + 1]
		end

		HotfixHelper = var_4

		var_4.DeleteFileByShortPathArr(var_0_0.DormGroupName, var_19_2)
	end

	return
end

function var_0_0.GetDelRoomSize(arg_20_0, arg_20_1)
	local var_20_0 = 0

	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(arg_20_1) do
		local var_20_1 = var_0_1[iter_20_1] .. arg_20_0
		local var_20_2 = var_0_0.GetFilePathList(var_20_1)
		local var_20_3 = var_0_0.GetDormMgr()

		var_20_0 = var_20_0 + var_10.GetCacheFileSize(var_20_3, var_20_2)
	end

	HashUtil = var_3

	return var_3.BytesToString(var_20_0)
end

function var_0_0.DelRoom(arg_21_0, arg_21_1)
	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_1) do
		var_0_0.DelDir(var_0_1[iter_21_1] .. arg_21_0)
	end

	return
end

return var_0_0
