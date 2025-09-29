-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/LoadingOptimizeUtil.lua

module("logic.common.util.LoadingOptimizeUtil", package.seeall)

local M = class("LoadingOptimizeUtil")
local defaultPriority, defaultTimeSlice, defaultBufferSize
local optimalPriority = UnityEngine.ThreadPriority.High
local optimalTimeSlice = 32
local optimalBufferSize = 64
local Application = UnityEngine.Application
local QualitySettings = UnityEngine.QualitySettings

function M.enableOptimize()
	defaultPriority = Application.backgroundLoadingPriority
	defaultTimeSlice = QualitySettings.asyncUploadTimeSlice
	defaultBufferSize = QualitySettings.asyncUploadBufferSize
	Application.backgroundLoadingPriority = optimalPriority
	QualitySettings.asyncUploadTimeSlice = optimalTimeSlice
	QualitySettings.asyncUploadBufferSize = optimalBufferSize
end

function M.disableOptimize()
	if defaultPriority then
		Application.backgroundLoadingPriority = defaultPriority
	end

	if defaultTimeSlice then
		QualitySettings.asyncUploadTimeSlice = defaultTimeSlice
	end

	if defaultBufferSize then
		QualitySettings.asyncUploadBufferSize = defaultBufferSize
	end
end

function M.enableLoadingPriority()
	defaultPriority = Application.backgroundLoadingPriority
	Application.backgroundLoadingPriority = optimalPriority
end

function M.disableLoadingPriority()
	if defaultPriority then
		Application.backgroundLoadingPriority = defaultPriority
	end
end

function M.enableAsyncUpload()
	defaultTimeSlice = QualitySettings.asyncUploadTimeSlice
	defaultBufferSize = QualitySettings.asyncUploadBufferSize
	QualitySettings.asyncUploadTimeSlice = optimalTimeSlice
	QualitySettings.asyncUploadBufferSize = optimalBufferSize
end

function M.disableAsyncUpload()
	if defaultTimeSlice then
		QualitySettings.asyncUploadTimeSlice = defaultTimeSlice
	end

	if defaultBufferSize then
		QualitySettings.asyncUploadBufferSize = defaultBufferSize
	end
end

return M
