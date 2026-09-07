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

function pg.CipherGroupMgr:GetCurFilePath()
	return self.downloadList[self.curIndex]
end

function pg.CipherGroupMgr:GetCurFileState()
	return self.group:CheckF((self:GetCurFilePath()))
end

function pg.CipherGroupMgr.GetValidFileList(arg_4_0, arg_4_1)
	local var_4_0 = {}

	if GroupHelper.IsGroupWaitToUpdate(var_0_0.GroupName) then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			iter_4_1 = string.lower(iter_4_1)

			local var_4_1 = GroupHelper.VerifyFile(var_0_0.GroupName, iter_4_1)

			warning(iter_4_1 .. " " .. tostring(var_4_1))

			if var_4_1 then
				table.insert(var_4_0, iter_4_1)
			end
		end
	end

	return var_4_0
end

function pg.CipherGroupMgr:StartWithFileList(arg_5_1)
	local var_5_0 = self:GetValidFileList(arg_5_1)

	if #var_5_0 > 0 then
		self:Clear()

		self.downloadList = var_5_0
		self.curIndex = 1

		self:updateWithIndex(1)
		self:createUpdateTimer()
	end

	return
end

function pg.CipherGroupMgr:AddFileList(arg_6_1)
	local var_6_0 = self:GetValidFileList(arg_6_1)

	if #var_6_0 > 0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			table.insert(self.downloadList, iter_6_1)
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

function pg.CipherGroupMgr:IsAnyFileInProgress()
	return self.curIndex > 0 and self.curIndex <= #self.downloadList
end

function pg.CipherGroupMgr.DelFile(arg_9_0, arg_9_1)
	local var_9_0 = System.Array.CreateInstance(typeof(System.String), #arg_9_1)

	for iter_9_0 = 0, #arg_9_1 - 1 do
		var_9_0[iter_9_0] = arg_9_1[iter_9_0 + 1]
	end

	HotfixHelper.DeleteFileByShortPathArr(var_0_0.GroupName, var_9_0)

	return
end

function pg.CipherGroupMgr:DelFile_Old(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_0 = PathMgr.getAssetBundle(iter_10_1)

		warning("full file path:" .. var_10_0)

		if PathMgr.FileExists(var_10_0) then
			System.IO.File.Delete(var_10_0)
			warning("del file path:" .. var_10_0)
		end
	end

	self.group:ClearStreamWriter()

	local function var_10_1(arg_11_0)
		local var_11_0 = false

		for iter_11_0, iter_11_1 in ipairs(arg_10_1) do
			if string.sub(arg_11_0, 1, #iter_11_1) == iter_11_1 then
				var_11_0 = true

				break
			end
		end

		return var_11_0
	end

	local var_10_2 = {}

	warning("hash path:" .. self.group.cachedHashPath)

	if PathMgr.FileExists(self.group.cachedHashPath) then
		local var_10_3 = PathMgr.ReadAllLines(self.group.cachedHashPath):ToTable()
		local var_10_4 = {}

		for iter_10_2, iter_10_3 in ipairs(var_10_3) do
			if not var_10_1(iter_10_3) then
				warning("add origin hash:" .. iter_10_3)
				table.insert(var_10_4, iter_10_3)
			else
				warning("find del hash:" .. iter_10_3)

				local var_10_5 = System.Array.CreateInstance(typeof(System.String), 3)
				local var_10_6 = string.split(iter_10_3, ",")

				for iter_10_4 = 1, 3 do
					warning("add info:" .. var_10_6[iter_10_4])

					var_10_5[iter_10_4 - 1] = var_10_6[iter_10_4]
				end

				table.insert(var_10_2, var_10_5)
			end
		end

		warning("new hash count:" .. #var_10_4)

		if #var_10_4 < #var_10_3 then
			if GroupHelper.IsGroupVerLastest(var_0_0.GroupName) then
				System.IO.File.WriteAllText(Application.persistentDataPath .. "/" .. self.group.localVersionFile, "0.0.1")
				warning("ver write:" .. Application.persistentDataPath .. "/" .. self.group.localVersionFile)
			end

			local var_10_7 = System.Array.CreateInstance(typeof(System.String), #var_10_4)

			for iter_10_5, iter_10_6 in ipairs(var_10_4) do
				var_10_7[iter_10_5 - 1] = iter_10_6
			end

			System.IO.File.WriteAllLines(self.group.cachedHashPath, var_10_7)
			warning("hash write:" .. self.group.cachedHashPath)
		end
	end

	if self.group.toUpdate then
		for iter_10_7, iter_10_8 in ipairs(var_10_2) do
			warning("re add info:" .. iter_10_8[0])
			self.group.toUpdate:Add(iter_10_8)
			self.group:UpdateFileDownloadStates(iter_10_8[0], DownloadState.CheckToUpdate)
		end

		if self.group.state == DownloadState.UpdateSuccess then
			self.group.state = DownloadState.CheckToUpdate
		end
	else
		self.group.state = DownloadState.None

		self.group:CheckD()
	end

	return
end

function pg.CipherGroupMgr:Clear()
	self:clearTimer()

	self.downloadList = {}
	self.finishCount = 0
	self.curIndex = 0

	return
end

function pg.CipherGroupMgr:isCipherExist(arg_13_1)
	local var_13_0 = self.group:CheckF(arg_13_1)

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

function pg.CipherGroupMgr:clearTimer()
	if self.frameTimer then
		self.frameTimer:Stop()

		self.frameTimer = nil
	end

	return
end

function pg.CipherGroupMgr:updateWithIndex(arg_17_1)
	if arg_17_1 > #self.downloadList then
		if self.allFinishCB then
			self.allFinishCB()
		end

		self:Clear()

		return
	end

	self.group:UpdateF((self:GetCurFilePath()))

	return
end

function pg.CipherGroupMgr:onUpdateD()
	local var_18_0 = self:GetCurFilePath()
	local var_18_1 = self.group:CheckF(var_18_0)

	if var_18_1 == DownloadState.UpdateSuccess then
		self.finishCount = self.finishCount + 1

		if self.singleFinshCB then
			self.singleFinshCB(var_18_0, self.finishCount, #self.downloadList)
		end

		self.curIndex = self.curIndex + 1

		self:updateWithIndex(self.curIndex)
	elseif var_18_1 == DownloadState.UpdateFailure then
		if self.errorCB then
			self.errorCB(var_18_0)
		end

		self:clearTimer()
	elseif var_18_1 == DownloadState.Updating and self.progressCB then
		self.progressCB(var_18_0, self.group:GetWebReqProgress())
	end

	return
end

function pg.CipherGroupMgr:createUpdateTimer()
	self.frameTimer = FrameTimer.New(function()
		self:onUpdateD()

		return
	end, 1, -1)

	self.frameTimer:Start()

	return
end

return
