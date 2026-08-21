-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Helper\\GameConfig.lua

local GameConfig = {}
local SDKConst = require("SDK/SDKConst")
local ChannelID = SDKConst.ChannelID
local CHANNEL_CONFIG_LOCAL = {
	wanfutengxun = {
		[Const.REMOTE_CONFIG_HIDE_TMALL] = 1,
		[Const.REMOTE_CONFIG_HIDE_ACT_MALL] = 1,
		[Const.REMOTE_CONFIG_AGREEMENT] = 1,
		[Const.REMOTE_CONFIG_HIDE_SOCIAL_SHARE] = 1
	},
	bili = {
		[Const.REMOTE_CONFIG_HIDE_BLOG] = 1,
		[Const.REMOTE_CONFIG_HIDE_CONTACT] = 1
	},
	xiaomi = {
		[Const.REMOTE_CONFIG_HIDE_BLOG] = 1,
		[Const.REMOTE_CONFIG_HIDE_CONTACT] = 1
	},
	huawei = {
		[Const.REMOTE_CONFIG_HIDE_CONTACT] = 1
	},
	xxgame = {
		[Const.REMOTE_CONFIG_HIDE_CONTACT] = 1,
		[Const.REMOTE_CONFIG_HIDE_LOGIN_MOVIE] = 1
	}
}

function GameConfig.getChannelConfig(remoteKey)
	local remoteValue = RemoteConfig.getValue(remoteKey)

	if remoteValue ~= nil then
		return tonumber(remoteValue)
	else
		local subId = ChannelUtil.getSubChannelID()
		local subLocalConfig = CHANNEL_CONFIG_LOCAL[subId] or {}

		return subLocalConfig[remoteKey]
	end
end

return GameConfig
