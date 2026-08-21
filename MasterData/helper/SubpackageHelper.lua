-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Helper\\SubpackageHelper.lua

local Hero_11203_01 = require("ClientData.BehaviorData.Hero_11203_01")
local SyncThreadTool = Framework.Tools.Threading.SyncThreadTool
local SubpackageUtils = Framework.Download.SubpackageUtils
local LuaToolkit = Framework.Tools.LuaToolkit
local VersionUtils = require("System/VersionUtils")
local ResSubpackage = require("ClientData/ResSubpackage")
local SubpackageHelper = {}
local self = SubpackageHelper

self.POLL_INTERVAL = 2
self.POLL_INTERVAL_ESSENTIAL = 0.1
self.REFRESH_TIME = 1
self.MD5_THREAD_NAME = "MD5"
self.debugBackgroundDownload = nil

function SubpackageHelper.init()
	if not self._timerSpeedCheck then
		self._timerSpeedCheck = Timer.New(self._onSpeedCheck, self.POLL_INTERVAL, -1)
	end

	if not self._timerEssential then
		self._timerEssential = Timer.New(self._onEssentialCheck, self.POLL_INTERVAL_ESSENTIAL, -1)
	end

	self._curThread = 3
	self._doneRefreshTime = -1
	self._totalRefreshTime = -1

	if VersionUtils.hasAbilitySubpackageV3() then
		self._nonNewbieJob = SubpackageUtils.GetJob(Framework.Download.DownloadConst.kGroupNonNewbie)
	end
end

function SubpackageHelper.onGameStart()
	self.init()
end

function SubpackageHelper.ensureLocalResMoreThan(minimalMB, callback)
	if not VersionUtils.hasAbilitySubpackageV2() then
		return false
	end

	local already = LuaToolkit.GetPkgResSizeMB() + SubpackageUtils.GetSizeSameMB() + SubpackageUtils.GetSizeDoneMB()
	local toDownload

	if minimalMB ~= nil then
		toDownload = math.min(minimalMB - already, SubpackageHelper.getSizeLeft())
	else
		toDownload = SubpackageHelper.getSizeLeft()
	end

	if toDownload > 30 then
		self._downloadEssentialCallback = callback

		self._startEssential(toDownload)

		return true
	else
		if toDownload > 0 then
			SubpackageUtils.ResumeBackground()
		end

		return false
	end
end

function SubpackageHelper.onEnterChapter(chapter)
	local isNewbie = chapter and chapter <= 3

	SubpackageHelper.setNewbieResMode(isNewbie)
end

function SubpackageHelper.tryDownloadRemaining(chapter, callback)
	if VersionUtils.hasAbilitySubpackageV3() and self._nonNewbieJob == nil then
		return false
	end

	local handled = false

	if chapter and chapter <= 3 then
		if self.debugBackgroundDownload == false then
			-- block empty
		elseif VersionUtils.hasAbilitySubpackageV3() then
			self._setJobActive(true)
		else
			SubpackageUtils.ResumeBackground()
		end

		self._timerSpeedCheck:Restart()
	elseif VersionUtils.hasAbilitySubpackageV3() then
		handled = SubpackageHelper._showNonNewbieDownload(callback)
	else
		local DeviceHelper = require("Helper/DeviceHelper")

		if DeviceHelper.isWindows() then
			handled = SubpackageHelper.ensureLocalResMoreThan(nil, callback)
		else
			SubpackageUtils.DownloadForeground()
		end
	end

	return handled
end

function SubpackageHelper.setConcurrent(thread)
	if VersionUtils.hasAbilitySubpackageV3() then
		if self._nonNewbieJob then
			self._nonNewbieJob:SetMaxConcurrent(thread)
		end
	else
		SubpackageUtils.SetConcurrentBackground(thread)
	end
end

function SubpackageHelper.getSizeDone()
	if VersionUtils.hasAbilitySubpackageV3() then
		return self._nonNewbieJob ~= nil and self._nonNewbieJob.sizeDoneMB or 0
	else
		return SubpackageUtils.GetSizeDoneMB()
	end
end

function SubpackageHelper.getSizeTotal()
	if VersionUtils.hasAbilitySubpackageV3() then
		return self._nonNewbieJob ~= nil and self._nonNewbieJob.sizeTotalMB or 0
	else
		return SubpackageUtils.GetSizeTotalMB()
	end
end

function SubpackageHelper.getSizeLeft()
	if VersionUtils.hasAbilitySubpackageV3() then
		return self._nonNewbieJob ~= nil and self._nonNewbieJob.sizeLeftMB or 0
	else
		return SubpackageUtils.GetSizeLeftMB()
	end
end

function SubpackageHelper.setNewbieResMode(isNewbie)
	UnityEngine.PlayerPrefs.SetInt("OnlyNewbieRes", isNewbie and 1 or 0)
end

function SubpackageHelper._showNonNewbieDownload(callback)
	local toDownload = self._nonNewbieJob.sizeLeftMB

	if toDownload > 30 then
		self._downloadEssentialCallback = callback

		self._startEssential(toDownload)

		return true
	else
		if toDownload > 0 then
			self._setJobActive(true)
		end

		return false
	end
end

function SubpackageHelper._startEssential(toDownloadMB)
	if VersionUtils.hasAbilitySubpackageV3() then
		self._setJobActive(true)
		UIManager.getUI("patch", true):setProgressVisible(true)
		self._timerEssential:Restart()
		self._onEssentialCheck()
		self.setConcurrent(5)
	else
		SubpackageUtils.ResumeBackground()

		self._essentialToDownload = math.min(toDownloadMB, SubpackageUtils.GetSizeLeftMB())
		self._essentialBaseSize = SubpackageUtils.GetSizeDoneMB()

		UIManager.getUI("patch", true):setProgressVisible(true)
		self._timerEssential:Restart()
		self._onEssentialCheck()
		SubpackageUtils.SetConcurrentBackground(5)
	end
end

function SubpackageHelper._stopEssential()
	UIManager.delUI("patch")
	self._timerEssential:Stop()

	if VersionUtils.hasAbilitySubpackageV3() then
		-- block empty
	else
		SubpackageUtils.SetConcurrentBackground(2)
	end
end

function SubpackageHelper._onEssentialCheck()
	local doneMB, totalMB

	if VersionUtils.hasAbilitySubpackageV3() then
		doneMB = self._nonNewbieJob.sizeDoneMB
		totalMB = self._nonNewbieJob.sizeTotalMB
	else
		doneMB = SubpackageUtils.GetSizeDoneMB() - self._essentialBaseSize
		totalMB = self._essentialToDownload
	end

	local progress

	if totalMB > 0 then
		progress = doneMB / totalMB
	else
		progress = 1
	end

	if progress > 1 then
		progress = 1
	end

	if progress <= 1 then
		local ui = UIManager.getUI("patch", true)

		ui:setProgressValue(progress)
		ui:setInfoText(string.format("%.2fM/%.2fM", doneMB, totalMB))
	end

	if progress > 0.99999 then
		self:_stopEssential()

		if self._downloadEssentialCallback then
			self._downloadEssentialCallback()
		end
	end
end

function SubpackageHelper._setJobActive(active)
	if active then
		self._nonNewbieJob:Start()
	else
		self._nonNewbieJob:Stop()
	end
end

function SubpackageHelper._onSpeedCheck()
	local lastDone = self._sizeDone
	local curDone = self.getSizeDone()

	if lastDone then
		local speed = (curDone - lastDone) / self.POLL_INTERVAL

		self._changeThreadBySpeed(speed)

		self._speed = speed
	end

	self._sizeDone = curDone
	self._doneRefreshTime = os.time()
end

function SubpackageHelper._changeThreadBySpeed(speed)
	local newThread = self._curThread

	if speed > 3 then
		newThread = math.max(1, self._curThread - 1)
	elseif speed < 0.3 then
		newThread = math.min(3, self._curThread + 1)
	end

	if newThread ~= self._curThread then
		self.setConcurrent(newThread)

		self._curThread = newThread
	end

	if speed == 0 and self.getSizeLeft() == 0 then
		self._timerSpeedCheck:Stop()
	end
end

function SubpackageHelper.checkDownloadFileByPath(path)
	if VersionUtils.hasAbilitySubpackageV3() then
		local jobName = path
		local fileReg = string.lower(path)
		local subJob = SubpackageUtils.CreateJob(jobName, 1, false, fileReg, nil)
		local sizeLeft = tonumber(tostring(subJob.sizeLeft))

		if not sizeLeft or sizeLeft <= 0 then
			return true, subJob
		else
			return false, subJob
		end
	else
		return true, nil
	end
end

function SubpackageHelper.checkDownloadFileByMultiPath(jobName, files)
	if not files or #files <= 0 then
		return true, nil
	end

	if VersionUtils.hasAbilitySubpackageV3() then
		local filesRegStr = "(" .. files[1]

		for idx = 2, #files do
			filesRegStr = filesRegStr .. "|" .. files[idx]
		end

		filesRegStr = string.lower(filesRegStr .. ")")

		local subJob = SubpackageUtils.CreateJob(jobName, 1, false, filesRegStr, nil)
		local sizeLeft = tonumber(tostring(subJob.sizeLeft))

		if not sizeLeft or sizeLeft <= 0 then
			return true, subJob
		else
			return false, subJob
		end
	else
		return true, nil
	end
end

function SubpackageHelper.checkDownloadFileByID(id)
	if VersionUtils.hasAbilitySubpackageV3() then
		local files = ResSubpackage[id]

		if files then
			local filesRegStr = "(" .. files[1]

			for idx = 2, #files do
				filesRegStr = filesRegStr .. "|" .. files[idx]
			end

			filesRegStr = string.lower(filesRegStr .. ")")

			local jobName = "job" .. id
			local subJob = SubpackageUtils.CreateJob(jobName, 1, false, filesRegStr, nil)
			local sizeLeft = tonumber(tostring(subJob.sizeLeft))

			if not sizeLeft or sizeLeft <= 0 then
				return true, subJob
			else
				return false, subJob
			end
		end
	end

	return true, nil
end

function SubpackageHelper.tryDownloadJob(job, successCallback, cancelCallback, desc)
	local totalMB = tonumber(tostring(job.sizeTotalMB))

	if totalMB > 5 then
		local downloadWindow = UIManager.getUI("subpackageDownloadDlg", true)

		if downloadWindow then
			local info = {
				job = job,
				cancelCallback = Functor(self.cancelDownloadJob, cancelCallback),
				confirmCallback = Functor(self.startDownloadJob, job, successCallback),
				desc = desc
			}

			downloadWindow:setData(info)

			return
		end
	end

	self.startDownloadJob(job, successCallback)
end

function SubpackageHelper.startDownloadJob(job, successCallback)
	self.subJobTimer = Timer.New(Functor(self._onSubJobCheck, job, successCallback), self.POLL_INTERVAL_ESSENTIAL, -1)

	job:Start()
	self.subJobTimer:Start()
end

function SubpackageHelper.stopDownloadJob()
	if self.subJobTimer then
		self.subJobTimer:Stop()
	end
end

function SubpackageHelper.cancelDownloadJob(cancelCallback)
	if cancelCallback then
		cancelCallback()
	end

	self.stopDownloadJob()
end

function SubpackageHelper._onSubJobCheck(job, successCallback)
	local doneMB, totalMB

	if VersionUtils.hasAbilitySubpackageV3() then
		doneMB = job.sizeDoneMB
		totalMB = job.sizeTotalMB

		local progress

		if totalMB > 0 then
			progress = doneMB / totalMB
		else
			progress = 1
		end

		if progress > 1 then
			progress = 1
		end

		local downloadWindow = UIManager.tryGetUI("subpackageDownloadDlg")

		if downloadWindow then
			downloadWindow:updateProgress(doneMB, totalMB, progress)
		end

		if progress > 0.99999 then
			self.stopDownloadJob()

			if downloadWindow then
				downloadWindow:setVisible(false)
			end

			if successCallback then
				successCallback()
			end
		end
	else
		self.stopDownloadJob()

		if successCallback then
			successCallback()
		end
	end
end

return SubpackageHelper
