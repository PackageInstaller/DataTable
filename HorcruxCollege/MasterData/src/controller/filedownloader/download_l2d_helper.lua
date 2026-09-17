local var_0_0 = {}

var_0_0._haveinited = false
var_0_0._working = false
var_0_0._download_queue = require("controller.filedownloader.queues.auto_download_queue").new()

function var_0_0:canDownload()
	if not self._downloading then
		return false
	end

	if not self._haveinited then
		return false
	end

	return self._download_queue:count() > 0
end

function var_0_0:dequeueFromQueueEnd()
	return self._download_queue:remove()
end

function var_0_0:init()
	if self._haveinited then
		return
	end

	local file_check_manager = require("controller.filedownloader.file_check_manager")

	for iter_3_0, iter_3_1 in pairs((file_check_manager:getAllL2dConfList())) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			if file_check_manager:checkFileNeedDownload(iter_3_3) then
				self._download_queue:add(file_check_manager:getFileDownloadInfo(iter_3_3))
			end
		end
	end

	self._haveinited = true
end

function var_0_0:needDownload()
	if not self._haveinited then
		self:init()
	end

	return self._download_queue:count() > 0
end

function var_0_0:isDownloading()
	return self._downloading
end

function var_0_0.startDownload(arg_6_0)
	arg_6_0._downloading = true
end

function var_0_0.stopDownload(arg_7_0)
	arg_7_0._downloading = false
end

function var_0_0:getNeedDownloadCount()
	return self._download_queue:count()
end

function var_0_0:getTotalSize()
	return self._download_queue:getTotalSize()
end

function var_0_0:getDownloadedSize()
	return self._download_queue:getDownloadedSize()
end

function var_0_0:onFileDownloadComplete(arg_11_1)
	self._download_queue:onFileDownloadComplete(arg_11_1)
end

return var_0_0
