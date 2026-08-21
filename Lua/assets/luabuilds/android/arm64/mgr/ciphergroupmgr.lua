pg = pg or {}
pg.CipherGroupMgr = singletonClass("CipherGroupMgr")

local var_0_0 = pg.CipherGroupMgr

pg.CipherGroupMgr.GroupName = "CIPHER"

function pg.CipherGroupMgr.Ctor(arg_1_0)
	arg_1_0.group = GroupHelper.GetGroupMgrByName(var_0_0.GroupName)
	arg_1_0.downloadList = {}
	arg_1_0.finishCount = 0
	arg_1_0.curIndex = 0

	return
end

function pg.CipherGroupMgr.GetCurFilePath(arg_2_0)
	return arg_2_0.downloadList[arg_2_0.curIndex]
end

function pg.CipherGroupMgr.GetCurFileState(arg_3_0)
	return arg_3_0.group:CheckF((arg_3_0:GetCurFilePath()))
end

function pg.CipherGroupMgr.GetValidFileList(arg_4_0, arg_4_1)
	if GroupHelper.IsGroupWaitToUpdate(var_0_0.GroupName) then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			iter_4_1 = string.lower(iter_4_1)

			local var_4_0 = GroupHelper.VerifyFile(var_0_0.GroupName, iter_4_1)

			warning(iter_4_1 .. " " .. tostring(var_4_0))

			if var_4_0 then
				table.insert({}, iter_4_1)
			end
		end
	end

	return {}
end

function pg.CipherGroupMgr.StartWithFileList(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GetValidFileList(arg_5_1)

	if #var_5_0 > 0 then
		arg_5_0:Clear()

		arg_5_0.downloadList = var_5_0
		arg_5_0.curIndex = 1

		arg_5_0:updateWithIndex(1)
		arg_5_0:createUpdateTimer()
	end

	return
end

function pg.CipherGroupMgr.AddFileList(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetValidFileList(arg_6_1)

	if #var_6_0 > 0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			table.insert(arg_6_0.downloadList, iter_6_1)
		end
	end

	return
end

function pg.CipherGroupMgr.SetCallBack(arg_7_0, arg_7_1)
	arg_7_0.progressCB = arg_7_1.progressCB
	arg_7_0.allFinishCB = arg_7_1.allFinishCB
	arg_7_0.singleFinshCB = arg_7_1.singleFinshCB
	arg_7_0.errorCB = arg_7_1.errorCB

	return
end

function pg.CipherGroupMgr.IsAnyFileInProgress(arg_8_0)
	return arg_8_0.curIndex > 0 and arg_8_0.curIndex <= #arg_8_0.downloadList
end

function pg.CipherGroupMgr.DelFile(arg_9_0, arg_9_1)
	local var_9_0 = System.Array.CreateInstance(typeof(System.String), #arg_9_1)

	for iter_9_0 = 0, #arg_9_1 - 1 do
		var_9_0[iter_9_0] = arg_9_1[iter_9_0 + 1]
	end

	HotfixHelper.DeleteFileByShortPathArr(var_0_0.GroupName, var_9_0)

	return
end

function pg.CipherGroupMgr.DelFile_Old(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_0 = PathMgr.getAssetBundle(iter_10_1)

		warning("full file path:" .. var_10_0)

		if PathMgr.FileExists(var_10_0) then
			System.IO.File.Delete(var_10_0)
			warning("del file path:" .. var_10_0)
		end
	end

	arg_10_0.group:ClearStreamWriter()
	warning("hash path:" .. arg_10_0.group.cachedHashPath)

	if PathMgr.FileExists(arg_10_0.group.cachedHashPath) then
		local var_10_1 = PathMgr.ReadAllLines(arg_10_0.group.cachedHashPath):ToTable()

		for iter_10_2, iter_10_3 in ipairs(var_10_1) do
			if not (function(arg_11_0)
				local var_11_0 = false

				for iter_11_0, iter_11_1 in ipairs(arg_10_1) do
					if string.sub(arg_11_0, 1, #iter_11_1) == iter_11_1 then
						var_11_0 = true

						break
					end
				end

				return var_11_0
			end)(iter_10_3) then
				warning("add origin hash:" .. iter_10_3)
				table.insert({}, iter_10_3)
			else
				warning("find del hash:" .. iter_10_3)

				local var_10_2 = System.Array.CreateInstance(typeof(System.String), 3)
				local var_10_3 = string.split(iter_10_3, ",")

				for iter_10_4 = 1, 3 do
					warning("add info:" .. var_10_3[iter_10_4])

					var_10_2[iter_10_4 - 1] = var_10_3[iter_10_4]
				end

				table.insert({}, var_10_2)
			end
		end

		warning("new hash count:" .. #{})

		if #{} < #var_10_1 then
			if GroupHelper.IsGroupVerLastest(var_0_0.GroupName) then
				System.IO.File.WriteAllText(Application.persistentDataPath .. "/" .. arg_10_0.group.localVersionFile, "0.0.1")
				warning("ver write:" .. Application.persistentDataPath .. "/" .. arg_10_0.group.localVersionFile)
			end

			local var_10_4 = System.Array.CreateInstance(typeof(System.String), #{})

			for iter_10_5, iter_10_6 in ipairs({}) do
				var_10_4[iter_10_5 - 1] = iter_10_6
			end

			System.IO.File.WriteAllLines(arg_10_0.group.cachedHashPath, var_10_4)
			warning("hash write:" .. arg_10_0.group.cachedHashPath)
		end
	end

	if arg_10_0.group.toUpdate then
		for iter_10_7, iter_10_8 in ipairs({}) do
			warning("re add info:" .. iter_10_8[0])
			arg_10_0.group.toUpdate:Add(iter_10_8)
			arg_10_0.group:UpdateFileDownloadStates(iter_10_8[0], DownloadState.CheckToUpdate)
		end

		if arg_10_0.group.state == DownloadState.UpdateSuccess then
			arg_10_0.group.state = DownloadState.CheckToUpdate
		end
	else
		arg_10_0.group.state = DownloadState.None

		arg_10_0.group:CheckD()
	end

	return
end

function pg.CipherGroupMgr.Clear(arg_12_0)
	arg_12_0:clearTimer()

	arg_12_0.downloadList = {}
	arg_12_0.finishCount = 0
	arg_12_0.curIndex = 0

	return
end

function pg.CipherGroupMgr.isCipherExist(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.group:CheckF(arg_13_1)

	return (var_13_0 == DownloadState.None or var_13_0 == DownloadState.UpdateSuccess) and PathMgr.FileExists((PathMgr.getAssetBundle(arg_13_1)))
end

function pg.CipherGroupMgr.Repair(arg_14_0)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		hideYes = true,
		content = i18n("resource_verify_warn"),
		custom = {
			{
				text = i18n("msgbox_repair"),
				onCallback = function()
					if PathMgr.FileExists(Application.persistentDataPath .. "/hashes-cipher.csv") then
						arg_14_0.group:StartVerifyForLua()
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("word_no_cache"))
					end

					return
				end
			}
		}
	})

	return
end

function pg.CipherGroupMgr.clearTimer(arg_16_0)
	if arg_16_0.frameTimer then
		arg_16_0.frameTimer:Stop()

		arg_16_0.frameTimer = nil
	end

	return
end

function pg.CipherGroupMgr.updateWithIndex(arg_17_0, arg_17_1)
	if arg_17_1 > #arg_17_0.downloadList then
		if arg_17_0.allFinishCB then
			arg_17_0.allFinishCB()
		end

		arg_17_0:Clear()

		return
	end

	arg_17_0.group:UpdateF((arg_17_0:GetCurFilePath()))

	return
end

function pg.CipherGroupMgr.onUpdateD(arg_18_0)
	local var_18_0 = arg_18_0:GetCurFilePath()
	local var_18_1 = arg_18_0.group:CheckF(var_18_0)

	if var_18_1 == DownloadState.UpdateSuccess then
		arg_18_0.finishCount = arg_18_0.finishCount + 1

		if arg_18_0.singleFinshCB then
			arg_18_0.singleFinshCB(var_18_0, arg_18_0.finishCount, #arg_18_0.downloadList)
		end

		arg_18_0.curIndex = arg_18_0.curIndex + 1

		arg_18_0:updateWithIndex(arg_18_0.curIndex)
	elseif var_18_1 == DownloadState.UpdateFailure then
		if arg_18_0.errorCB then
			arg_18_0.errorCB(var_18_0)
		end

		arg_18_0:clearTimer()
	elseif var_18_1 == DownloadState.Updating and arg_18_0.progressCB then
		arg_18_0.progressCB(var_18_0, arg_18_0.group:GetWebReqProgress())
	end

	return
end

function pg.CipherGroupMgr.createUpdateTimer(arg_19_0)
	arg_19_0.frameTimer = FrameTimer.New(function()
		arg_19_0:onUpdateD()

		return
	end, 1, -1)

	arg_19_0.frameTimer:Start()

	return
end

return
