-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/bootstrap/BootstrapPjaqGameConfigMgr.lua

module("bootstrap.BootstrapPjaqGameConfigMgr", package.seeall)

local BootstrapPjaqGameConfigMgr = {}

BootstrapPjaqGameConfigMgr.GameConfigJsonData = nil
BootstrapPjaqGameConfigMgr.isReview = false

function BootstrapPjaqGameConfigMgr.reqGameConfig()
	BootstrapLauncher.instance:showUITipByState(BootstrapConstdef.EBootstrapState.GetGameConfig)
	BootstrapPjaqGameConfigMgr.handleReviewGameConfig()
	BootstrapLauncher.instance:onHttpGetGameConfigFinish()
end

function BootstrapPjaqGameConfigMgr.handleReviewGameConfig()
	local allConfigUrl = not BootstrapPjaqGameConfigMgr.isReview and CSGameUtil.GetGetGameConfigUrl() or CSGameUtil.GetReviewGameConfigUrl()

	forcePrint(LogTag.BOOTSTRAP, "游戏全部配置json", allConfigUrl)

	local jsonlib = require("cjson")

	BootstrapPjaqGameConfigMgr.GameConfigJsonData = jsonlib.decode(allConfigUrl)
	BootstrapPjaqGameConfigMgr.ReverseWebUrls = not BootstrapPjaqGameConfigMgr.isReview and CSGameUtil.GetWebLoginCheckReserveUrls() or CSGameUtil.GeReviewtWebLoginCheckReserveUrls()

	BootstrapPjaqGameConfigMgr._handleReverseWebUrls()
end

function BootstrapPjaqGameConfigMgr._handleReverseWebUrls()
	local reverseWebUrls = BootstrapPjaqGameConfigMgr.ReverseWebUrls

	if reverseWebUrls then
		for i = 0, reverseWebUrls.Length - 1 do
			local url = reverseWebUrls[i]

			if not string.find(url, "http://") and not string.find(url, "https://") then
				url = "http://" .. url
			end

			reverseWebUrls[i] = url
		end
	end
end

function BootstrapPjaqGameConfigMgr.getHttpLoginUrl(reverseIndex)
	if BootstrapPjaqGameConfigMgr.GameConfigJsonData then
		if not reverseIndex or reverseIndex == 0 then
			return BootstrapPjaqGameConfigMgr.GameConfigJsonData.httpLoginUrl
		end

		local reverseWebUrls = BootstrapPjaqGameConfigMgr.ReverseWebUrls

		if not reverseWebUrls then
			return
		end

		if reverseWebUrls and reverseIndex and reverseIndex > 0 then
			if reverseIndex > reverseWebUrls.Length then
				return
			end

			local url = reverseWebUrls[reverseIndex - 1]

			if not string.nilorempty(url) then
				return url
			end
		end

		return BootstrapPjaqGameConfigMgr.GameConfigJsonData.httpLoginUrl
	end
end

function BootstrapPjaqGameConfigMgr.getReqServerListUrl(reverseIndex)
	return BootstrapPjaqGameConfigMgr.getHttpLoginUrl(reverseIndex) .. "loadzone.jsp"
end

function BootstrapPjaqGameConfigMgr.getReqSessoinIdUrl()
	return BootstrapPjaqGameConfigMgr.getHttpLoginUrl() .. "account/login"
end

function BootstrapPjaqGameConfigMgr.getWebLoginUrl(reverseIndex)
	return BootstrapPjaqGameConfigMgr.getHttpLoginUrl(reverseIndex)
end

function BootstrapPjaqGameConfigMgr.getHotUpdateInfoUrl()
	if BootstrapPjaqGameConfigMgr.GameConfigJsonData then
		return BootstrapPjaqGameConfigMgr.GameConfigJsonData.hotUpdateInfoUrl
	end
end

function BootstrapPjaqGameConfigMgr.getNoticeUrl_notice_text()
	if BootstrapPjaqGameConfigMgr.GameConfigJsonData then
		return BootstrapPjaqGameConfigMgr.GameConfigJsonData.noticeUrl .. "t_notice_text.lua"
	end
end

function BootstrapPjaqGameConfigMgr.getNoticeUrl_notice_image()
	if BootstrapPjaqGameConfigMgr.GameConfigJsonData then
		return BootstrapPjaqGameConfigMgr.GameConfigJsonData.noticeUrl .. "t_notice_image.lua"
	end
end

return BootstrapPjaqGameConfigMgr
