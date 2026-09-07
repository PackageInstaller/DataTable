local CryptolaliaDownloadMgr = class("CryptolaliaDownloadMgr")

CryptolaliaDownloadMgr.PROGRESS_FINISH = -99
CryptolaliaDownloadMgr.PROGRESS_ERROR = -100

function CryptolaliaDownloadMgr:Ctor()
	self.callbacks = {}
	self.mgr = pg.CipherGroupMgr.GetInstance()

	self.mgr:SetCallBack({
		progressCB = function(arg_2_0, arg_2_1)
			if self.callbacks[arg_2_0] then
				self.callbacks[arg_2_0](arg_2_0, arg_2_1)
			end

			return
		end,
		allFinishCB = function(arg_3_0, arg_3_1)
			warning("全部完成")

			return
		end,
		singleFinshCB = function(arg_4_0, arg_4_1, arg_4_2)
			if self.callbacks[arg_4_0] then
				self.callbacks[arg_4_0](arg_4_0, CryptolaliaDownloadMgr.PROGRESS_FINISH)

				self.callbacks[arg_4_0] = nil
			end

			return
		end,
		errorCB = function(arg_5_0)
			warning((string.format("出错文件:%s", arg_5_0)))

			if self.callbacks[arg_5_0] then
				self.callbacks[arg_5_0](arg_5_0, CryptolaliaDownloadMgr.PROGRESS_ERROR)

				self.callbacks[arg_5_0] = nil
			end

			return
		end
	})

	return
end

function CryptolaliaDownloadMgr:Request(arg_6_1, arg_6_2)
	self.callbacks[string.lower(arg_6_1[#arg_6_1])] = arg_6_2

	local var_6_0 = GroupHelper.GetGroupMgrByName("CIPHER")
	local var_6_1 = table.concat(arg_6_1, ",")

	if self.mgr:IsAnyFileInProgress() then
		self.mgr:AddFileList(arg_6_1)
	else
		self.mgr:StartWithFileList(arg_6_1)
	end

	return
end

function CryptolaliaDownloadMgr:ReConnection(arg_7_1, arg_7_2)
	if self:IsDownloadState(arg_7_1[#arg_7_1]) then
		self.callbacks[string.lower(arg_7_1[#arg_7_1])] = arg_7_2
	end

	return
end

function CryptolaliaDownloadMgr:IsDownloadState(arg_8_1)
	arg_8_1 = string.lower(arg_8_1)

	for iter_8_0 = self.mgr.curIndex, #self.mgr.downloadList do
		if self.mgr.downloadList[iter_8_0] == arg_8_1 then
			return true
		end
	end

	return false
end

function CryptolaliaDownloadMgr:Dispose()
	self.callbacks = {}

	self.mgr:SetCallBack({})

	return
end

return CryptolaliaDownloadMgr
