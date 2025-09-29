-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/model/MainSettingModel.lua

module("logic.extensions.mainui.model.MainSettingModel", package.seeall)

local M = class("MainSettingModel", BaseModel)
local LocalStorage = Astral.LocalStorage.Instance
local kOriginalOffsetWidthKey = "main_setting_original_offset_width"
local kMaxWidth = 52

function M:getAdaptationOffsetWidth()
	local offsetWidth = self:getBestOffsetSize()

	return LocalStorage:GetFloat(kOriginalOffsetWidthKey, offsetWidth)
end

function M:saveAdaptationOffsetWidth(width)
	LocalStorage:SetFloat(kOriginalOffsetWidthKey, width)
	GlobalDispatcher:dispatchEvent(EventType.SCREEN_ADAPTER_UPDATE)
end

function M:getBestOffsetSize()
	local offsetWidth = Mathf.Clamp(AdaptationUtils.GetBestOffsetSize(), 0, kMaxWidth)

	return offsetWidth
end

function M:getMaxAdaptationOffsetWidth()
	return kMaxWidth
end

M.instance = M.New()

return M
