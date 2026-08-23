local SplitDownloadData = class("SplitDownloadData")

function SplitDownloadData:ctor()
	self._receivedList = {}
end

function SplitDownloadData:isShowDownloadListPop()
	local var_2_0 = true

	for iter_2_0, iter_2_1 in ipairs(g.core.common.PackageRes:getResMainGroupList() or {}) do
		if not iter_2_1:isFinishAll() then
			var_2_0 = false

			break
		end
	end

	return g.core.common.PackageRes:isPackageEnable() and not var_2_0
end

function SplitDownloadData:isAllReceived()
	local var_3_0 = true

	for iter_3_0 = 1, g.core.config.split_download_reward_info.getLength() do
		if not self:isReceivedAwardById(g.core.config.split_download_reward_info.indexOf(iter_3_0).id) then
			var_3_0 = false

			break
		end
	end

	return var_3_0
end

function SplitDownloadData:isReceivedAwardById(arg_4_1)
	local var_4_0 = false

	for iter_4_0, iter_4_1 in ipairs(self._receivedList) do
		if iter_4_1 == arg_4_1 then
			var_4_0 = true

			break
		end
	end

	return var_4_0
end

function SplitDownloadData:onS2CFlushRedPoint(arg_5_1)
	self._receivedList = arg_5_1.ids or {}
end

function SplitDownloadData:onS2CSplitDownloadAward(arg_6_1)
	self._receivedList[#self._receivedList + 1] = arg_6_1.id
end

return SplitDownloadData
