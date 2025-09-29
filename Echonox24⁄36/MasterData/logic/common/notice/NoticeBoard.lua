-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/notice/NoticeBoard.lua

module("logic.common.notice.NoticeBoard", package.seeall)

local NoticeBoard = {}
local json = require("cjson")
local clazz = "com.baitian.notice.NoticeBoardWrap"

function NoticeBoard.requestNoticeInfo(appCode, channelId, packageVersion, version, zoneId, osType)
	local param = {}

	param.appCode = appCode
	param.channelId = channelId
	param.packageVersion = packageVersion or -1
	param.version = version or "-1"
	param.zoneId = zoneId or "-1"
	param.osType = osType or "-1"

	NativeBridge.instance:invoke(clazz, "requestNoticeInfo", param)
end

function NoticeBoard.registerOnRequestNoticeInfoListener(callFunc, callFuncSelf)
	NativeBridge.instance:registerListener("noticeInfoV2", function(result)
		local content

		if result.value and result.value ~= "" then
			content = json.decode(result.value)
		end

		if callFuncSelf then
			callFunc(callFuncSelf, content, result.statusCode)
		else
			callFunc(content, result.statusCode)
		end
	end)
end

function NoticeBoard.openNoticeView(x, y, width, height, noticeBoardItemList)
	local param = {}

	param.x = x
	param.y = y
	param.width = width
	param.height = height
	param.noticeBoardItemList = json.encode(noticeBoardItemList)

	NativeBridge.instance:invoke(clazz, "openNoticeView", param)
end

function NoticeBoard.switchNotice(noticeBoardItemList)
	local param = {}

	param.noticeBoardItemList = json.encode(noticeBoardItemList)

	NativeBridge.instance:invoke(clazz, "switchNotice", param)
end

function NoticeBoard.closeNoticeView()
	NativeBridge.instance:invoke(clazz, "closeNoticeView")
end

function NoticeBoard.registerBtGameLink(callFunc)
	NativeBridge.instance:registerListener("noticeLink", function(result)
		local content = result.url

		callFunc(content)
	end)
end

function NoticeBoard.setServerUrl(serverUrl)
	local param = {}

	param.serverUrl = serverUrl

	NativeBridge.instance:invoke(clazz, "setServerUrl", param)
end

function NoticeBoard.setNoticeLoadingImage(imagePath)
	local param = {
		imagePath = imagePath
	}

	NativeBridge.instance:invoke(clazz, "setNoticeLoadingImage", param)
end

function NoticeBoard.setNoticeBackgroundColor(backgroundColor)
	local param = {}

	param.backgroundColor = backgroundColor

	NativeBridge.instance:invoke(clazz, "setNoticeBackgroundColor", param)
end

return NoticeBoard
