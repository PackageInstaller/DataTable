local assets_downloader = class("assets_downloader")
local assets_download_event = require("controller.updatemodule.assets_download_event")
local var_0_3 = 10

function assets_downloader:ctor()
	self._downloader = nil
	self._pathToSave = nil
	self._curtask = nil

	self:genSavePath()
	self:initDownloader()
end

function assets_downloader:release()
	if self._downloader then
		self._downloader:release()

		self._downloader = nil
	end
end

function assets_downloader:initDownloader()
	self._downloader = cc.AssetsManager:new(self._pathToSave)

	self._downloader:retain()
	self._downloader:setDelegate(function(arg_4_0)
		self:onDownloadError(arg_4_0)
	end, cc.ASSETSMANAGER_PROTOCOL_ERROR)
	self._downloader:setDelegate(function(arg_5_0)
		self:onDownloadProgress(arg_5_0)
	end, cc.ASSETSMANAGER_PROTOCOL_PROGRESS)
	self._downloader:setDelegate(function()
		self:onDownloadSuccess()
	end, cc.ASSETSMANAGER_PROTOCOL_SUCCESS)
	self._downloader:setConnectionTimeout(3000)
end

function assets_downloader:genSavePath()
	local var_7_0 = cc.FileUtils:getInstance():getWritablePath()

	if GAME_STORAGE_FOLDER then
		var_7_0 = self:appendGameStorageFolder(var_7_0)
	end

	self._pathToSave = var_7_0

	print("PathToSave: ", self._pathToSave)
end

function assets_downloader:appendGameStorageFolder(arg_8_1)
	if not arg_8_1:find("/$") then
		arg_8_1 = arg_8_1 .. "/"
	end

	return arg_8_1 .. GAME_STORAGE_FOLDER .. "/"
end

function assets_downloader:start(arg_9_1, arg_9_2)
	if self._curtask then
		print("Another Task Executing Now")

		return false
	end

	self._curtask = {
		retrycount = 0,
		curpath = 1,
		version = arg_9_1,
		downloadpath = arg_9_2
	}

	self._downloader:genUpdateQuene({
		(self:dequeDownloadPath())
	})
	self._downloader:update()

	return true
end

function assets_downloader:dequeDownloadPath()
	if self._curtask.curpath + 1 > #self._curtask.downloadpath then
		self._curtask.curpath = 1
	end

	return self._curtask.downloadpath[self._curtask.curpath]
end

function assets_downloader:stop()
	self._curtask = nil
end

function assets_downloader:tryDownloadAgain()
	self._curtask.retrycount = self._curtask.retrycount + 1

	self._downloader:genUpdateQuene({
		(self:dequeDownloadPath())
	})
	self._downloader:update()
end

function assets_downloader:getRetryCount()
	if not self._curtask then
		return 0
	end

	return self._curtask.retrycount
end

local function var_0_4(arg_14_0, arg_14_1)
	local var_14_0

	var_14_0 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_14_0)
		arg_14_0()
	end, arg_14_1, false)

	return nil
end

function assets_downloader:onDownloadError(arg_16_1)
	if self:getRetryCount() < var_0_3 then
		var_0_4(function()
			self:tryDownloadAgain()
		end, 0.5)
	else
		assets_download_event:dispatch(assets_download_event.EVENTID.ASSETS_DOWNLOAD_EVENT_ERROR, arg_16_1)
	end
end

function assets_downloader:onDownloadProgress(arg_18_1)
	assets_download_event:dispatch(assets_download_event.EVENTID.ASSETS_DOWNLOAD_EVENT_PROCESS, arg_18_1)
end

function assets_downloader:onDownloadSuccess()
	if not self._curtask.version then
		assets_download_event:dispatch(assets_download_event.EVENTID.ASSETS_DOWNLOAD_EVENT_SUCCESS, self._curtask.version)

		return
	end

	package.loaded.config = nil

	require("config")

	package.loaded["data.recharge_data"] = nil

	require("data.recharge_data")
	print("Now Config Version: ", config.version)
	print("Now Task Version: ", self._curtask.version)

	if config.version ~= self._curtask.version then
		self:onDownloadError(cc.ASSETSMANAGER_NETWORK)
	else
		assets_download_event:dispatch(assets_download_event.EVENTID.ASSETS_DOWNLOAD_EVENT_SUCCESS, self._curtask.version)
	end
end

return assets_downloader
