pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.CipherGroupMgr = var_0_10001("CipherGroupMgr")
pg = var_0

local var_0_1 = var_0.CipherGroupMgr

var_0_1.GroupName = "CIPHER"

function var_0_1.Ctor(arg_1_0)
	GroupHelper = var_1_10001
	arg_1_0.group = var_1_10001.GetGroupMgrByName(var_0_1.GroupName)
	arg_1_0.downloadList = {}
	arg_1_0.finishCount = 0
	arg_1_0.curIndex = 0

	return
end

function var_0_1.GetCurFilePath(arg_2_0)
	return arg_2_0.downloadList[arg_2_0.curIndex]
end

function var_0_1.GetCurFileState(arg_3_0)
	local var_3_0 = arg_3_0:GetCurFilePath()
	local var_3_1 = arg_3_0.group

	return var_2.CheckF(var_3_1, var_3_0)
end

function var_0_1.GetValidFileList(arg_4_0, arg_4_1)
	local var_4_0 = {}

	GroupHelper = var_1_10003

	if var_1_10003.IsGroupWaitToUpdate(var_0_1.GroupName) then
		ipairs = var_3

		for iter_4_0, iter_4_1 in var_3(arg_4_1) do
			string = var_1_10008
			iter_4_1 = var_1_10008.lower(iter_4_1)
			GroupHelper = var_1_10008
			var_1_10008 = var_1_10008.VerifyFile(var_0_1.GroupName, iter_4_1)
			warning = var_1_10009

			local var_4_1 = iter_4_1
			local var_4_2 = " "

			tostring = var_1_10013

			var_1_10009(var_4_1 .. var_4_2 .. var_1_10013(var_1_10008))

			if var_1_10008 then
				table = var_1_10009

				var_1_10009.insert(var_4_0, iter_4_1)
			end
		end
	end

	return var_4_0
end

function var_0_1.StartWithFileList(arg_5_0, arg_5_1)
	if #arg_5_0:GetValidFileList(arg_5_1) > 0 then
		arg_5_0:Clear()

		arg_5_0.downloadList = var_2
		arg_5_0.curIndex = 1

		arg_5_0:updateWithIndex(1)
		arg_5_0:createUpdateTimer()
	end

	return
end

function var_0_1.AddFileList(arg_6_0, arg_6_1)
	if #arg_6_0:GetValidFileList(arg_6_1) > 0 then
		ipairs = var_3

		for iter_6_0, iter_6_1 in var_3(var_2) do
			table = var_1_10008

			var_1_10008.insert(arg_6_0.downloadList, iter_6_1)
		end
	end

	return
end

function var_0_1.SetCallBack(arg_7_0, arg_7_1)
	arg_7_0.progressCB = arg_7_1.progressCB
	arg_7_0.allFinishCB = arg_7_1.allFinishCB
	arg_7_0.singleFinshCB = arg_7_1.singleFinshCB
	arg_7_0.errorCB = arg_7_1.errorCB

	return
end

function var_0_1.IsAnyFileInProgress(arg_8_0)
	return arg_8_0.curIndex > 0 and arg_8_0.curIndex <= #arg_8_0.downloadList
end

function var_0_1.DelFile(arg_9_0, arg_9_1)
	local var_9_0 = #arg_9_1

	System = var_1_10003

	local var_9_1 = var_1_10003.Array.CreateInstance

	typeof = var_1_10005
	System = var_1_10007

	local var_9_2 = var_9_1(var_1_10005(var_1_10007.String), var_9_0)

	for iter_9_0 = 0, var_9_0 - 1 do
		var_9_2[iter_9_0] = arg_9_1[iter_9_0 + 1]
	end

	HotfixHelper = var_4

	var_4.DeleteFileByShortPathArr(var_0_1.GroupName, var_9_2)

	return
end

function var_0_1.DelFile_Old(arg_10_0, arg_10_1)
	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_1) do
		PathMgr = var_1_10007
		var_1_10007 = var_1_10007.getAssetBundle(iter_10_1)
		warning = var_1_10008

		var_1_10008("full file path:" .. var_1_10007)

		PathMgr = var_1_10008

		if var_1_10008.FileExists(var_1_10007) then
			System = var_1_10008

			var_1_10008.IO.File.Delete(var_1_10007)

			warning = var_1_10008

			var_1_10008("del file path:" .. var_1_10007)
		end
	end

	local var_10_0 = arg_10_0.group

	var_2.ClearStreamWriter(var_10_0)

	local function var_10_1(arg_11_0)
		local var_11_0 = false

		ipairs = var_2_10002

		for iter_11_0, iter_11_1 in var_2_10002(arg_10_1) do
			string = var_2_10007

			if var_2_10007.sub(arg_11_0, 1, #iter_11_1) == iter_11_1 then
				var_11_0 = true

				break
			end
		end

		return var_11_0
	end

	local var_10_2 = {}
	local var_10_3 = arg_10_0.group.cachedHashPath

	warning = iter_10_0

	iter_10_0("hash path:" .. var_10_3)

	PathMgr = iter_10_0

	if iter_10_0.FileExists(var_10_3) then
		PathMgr = var_5

		local var_10_4 = var_5.ReadAllLines(var_10_3)

		iter_10_1 = #var_5.ToTable(var_10_4)

		local var_10_5 = {}

		ipairs = var_8

		for iter_10_2, iter_10_3 in var_8(var_5) do
			if not var_10_1(iter_10_3) then
				warning = var_1_10013

				var_1_10013("add origin hash:" .. iter_10_3)

				table = var_1_10013

				var_1_10013.insert(var_10_5, iter_10_3)
			else
				warning = var_1_10013

				var_1_10013("find del hash:" .. iter_10_3)

				var_1_10013 = iter_10_3
				System = var_1_10014
				var_1_10014 = var_1_10014.Array.CreateInstance
				typeof = var_16
				System = var_1_10018
				var_1_10014 = var_1_10014(var_16(var_1_10018.String), 3)
				string = var_1_10015
				var_1_10015 = var_1_10015.split(var_1_10013, ",")

				for iter_10_4 = 1, 3 do
					local var_10_6 = var_1_10015[iter_10_4]

					warning = var_1_10021

					var_1_10021("add info:" .. var_10_6)

					var_1_10014[iter_10_4 - 1] = var_10_6
				end

				table = var_16

				var_16.insert(var_10_2, var_1_10014)
			end
		end

		local var_10_7 = #var_10_5

		warning = var_9

		var_9("new hash count:" .. var_10_7)

		if var_10_7 < iter_10_1 then
			GroupHelper = var_9

			local var_10_8

			if var_9.IsGroupVerLastest(var_0_1.GroupName) then
				Application = var_10_8
				var_10_8 = var_10_8.persistentDataPath .. "/" .. arg_10_0.group.localVersionFile
				System = var_10

				var_10.IO.File.WriteAllText(var_10_8, "0.0.1")

				warning = var_10

				var_10("ver write:" .. var_10_8)
			end

			System = var_10_8

			local var_10_9 = var_10_8.Array.CreateInstance

			typeof = iter_10_2
			System = var_1_10013

			local var_10_10 = var_10_9(iter_10_2(var_1_10013.String), var_10_7)

			ipairs = var_10

			for iter_10_5, iter_10_6 in var_10(var_10_5) do
				var_10_10[iter_10_5 - 1] = iter_10_6
			end

			System = var_10

			var_10.IO.File.WriteAllLines(var_10_3, var_10_10)

			warning = var_10

			var_10("hash write:" .. var_10_3)
		end
	end

	if arg_10_0.group.toUpdate then
		ipairs = var_5

		for iter_10_7, iter_10_8 in var_5(var_10_2) do
			local var_10_11 = iter_10_8[0]

			warning = iter_10_2

			iter_10_2("re add info:" .. var_10_11)

			local var_10_12 = arg_10_0.group.toUpdate

			iter_10_2.Add(var_10_12, iter_10_8)

			local var_10_13 = arg_10_0.group

			iter_10_2 = iter_10_2.UpdateFileDownloadStates

			local var_10_14 = var_10_11

			DownloadState = var_1_10015

			iter_10_2(var_10_13, var_10_14, var_1_10015.CheckToUpdate)
		end

		local var_10_15 = arg_10_0.group.state

		DownloadState = iter_10_1

		if var_10_15 == iter_10_1.UpdateSuccess then
			local var_10_16 = arg_10_0.group

			DownloadState = iter_10_1
			var_10_16.state = iter_10_1.CheckToUpdate
		end
	else
		local var_10_17 = arg_10_0.group

		DownloadState = iter_10_1
		var_10_17.state = iter_10_1.None

		local var_10_18 = arg_10_0.group

		var_5.CheckD(var_10_18)
	end

	return
end

function var_0_1.Clear(arg_12_0)
	arg_12_0:clearTimer()

	arg_12_0.downloadList = {}
	arg_12_0.finishCount = 0
	arg_12_0.curIndex = 0

	return
end

function var_0_1.isCipherExist(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.group
	local var_13_1 = var_2.CheckF(var_13_0, arg_13_1)

	DownloadState = var_1_10003

	local var_13_2

	if var_13_1 ~= var_1_10003.None then
		DownloadState = var_3

		if var_13_1 ~= var_3.UpdateSuccess then
			var_13_2 = false

			goto label_13_0
		end
	end

	var_13_2 = true

	::label_13_0::

	PathMgr = var_13_0

	local var_13_3 = var_13_0.getAssetBundle(arg_13_1)

	PathMgr = var_5

	local var_13_4 = var_5.FileExists(var_13_3)

	return var_13_2 and var_13_4
end

function var_0_1.Repair(arg_14_0)
	local var_14_0 = {}

	i18n = var_1_10002
	var_14_0.text = var_1_10002("msgbox_repair")

	function var_14_0.onCallback()
		PathMgr = var_2_10000

		local var_15_0 = var_2_10000.FileExists

		Application = var_2_10002

		if var_15_0(var_2_10002.persistentDataPath .. "/hashes-cipher.csv") then
			local var_15_1 = arg_14_0.group

			var_0.StartVerifyForLua(var_15_1)
		else
			pg = var_0

			local var_15_2 = var_0.TipsMgr.GetInstance()
			local var_15_3 = var_0.ShowTips

			i18n = var_3

			var_15_3(var_15_2, var_3("word_no_cache"))
		end

		return
	end

	pg = var_2

	local var_14_1 = var_2.MsgboxMgr.GetInstance()
	local var_14_2 = var_2.ShowMsgBox
	local var_14_3 = {
		hideYes = true
	}

	i18n = var_1_10006
	var_14_3.content = var_1_10006("resource_verify_warn")
	var_14_3.custom = {
		var_14_0
	}

	var_14_2(var_14_1, var_14_3)

	return
end

function var_0_1.clearTimer(arg_16_0)
	if arg_16_0.frameTimer then
		local var_16_0 = arg_16_0.frameTimer

		var_1.Stop(var_16_0)

		arg_16_0.frameTimer = nil
	end

	return
end

function var_0_1.updateWithIndex(arg_17_0, arg_17_1)
	if arg_17_1 > #arg_17_0.downloadList then
		if arg_17_0.allFinishCB then
			arg_17_0.allFinishCB()
		end

		arg_17_0:Clear()

		return
	end

	local var_17_0 = arg_17_0:GetCurFilePath()
	local var_17_1 = arg_17_0.group

	var_3.UpdateF(var_17_1, var_17_0)

	return
end

function var_0_1.onUpdateD(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetCurFilePath(var_18_0)
	local var_18_2 = arg_18_0.group
	local var_18_3 = var_2.CheckF(var_18_2, var_18_1)

	DownloadState = var_18_0

	if var_18_3 == var_18_0.UpdateSuccess then
		arg_18_0.finishCount = arg_18_0.finishCount + 1

		if arg_18_0.singleFinshCB then
			arg_18_0.singleFinshCB(var_18_1, arg_18_0.finishCount, #arg_18_0.downloadList)
		end

		arg_18_0.curIndex = arg_18_0.curIndex + 1

		arg_18_0:updateWithIndex(arg_18_0.curIndex)
	else
		DownloadState = var_3

		if var_18_3 == var_3.UpdateFailure then
			if arg_18_0.errorCB then
				arg_18_0.errorCB(var_18_1)
			end

			arg_18_0:clearTimer()
		else
			DownloadState = var_3

			if var_18_3 == var_3.Updating and arg_18_0.progressCB then
				local var_18_4 = arg_18_0.progressCB
				local var_18_5 = var_18_1
				local var_18_6 = arg_18_0.group

				var_18_4(var_18_5, var_6.GetWebReqProgress(var_18_6))
			end
		end
	end

	return
end

function var_0_1.createUpdateTimer(arg_19_0)
	FrameTimer = var_1_10001
	arg_19_0.frameTimer = var_1_10001.New(function()
		local var_20_0 = arg_19_0

		var_0.onUpdateD(var_20_0)

		return
	end, 1, -1)

	local var_19_0 = arg_19_0.frameTimer

	var_1.Start(var_19_0)

	return
end

return
