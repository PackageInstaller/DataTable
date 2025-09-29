-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/textformatter/impl/LastLogoutTimeFormatterImpl.lua

module("logic.common.textformatter.impl.LastLogoutTimeFormatterImpl", package.seeall)

local LastLogoutTimeFormatterImpl = class("LastLogoutTimeFormatterImpl", ITextDataFormatter)

function LastLogoutTimeFormatterImpl:format(timeSeconds)
	if timeSeconds < 60 then
		return string.format(lang("tip_friend_status_seconds"), timeSeconds)
	elseif timeSeconds < 3600 then
		return string.format(lang("tip_friend_status_mins"), math.floor(timeSeconds / 60))
	elseif timeSeconds < 86400 then
		return string.format(lang("tip_friend_status_hours"), math.floor(timeSeconds / 3600))
	else
		return string.format(lang("tip_friend_status_days"), math.floor(timeSeconds / 86400))
	end
end

return LastLogoutTimeFormatterImpl
