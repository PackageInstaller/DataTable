module("bootstrap.config.BootstrapGameConfigMgr", package.seeall)

local var_0_0 = "zoneid_players_key"
local var_0_1 = {}
local var_0_2 = require("bootstrap.config.BootstrapGameConfig")

var_0_1.GameConfigJsonData = nil
var_0_1.isReview = false
var_0_1.isUseBackupHotupdateInfo = false
var_0_1.zoneId = 0
var_0_1.tryLoginTimes = 0
var_0_1.isUseBackup = false
GameConfigUrlType = {
	backupHttpLoginUrl = "backupHttpLoginUrl",
	fileServerUrl = "fileServerUrl",
	hotUpdateAppCode = "hotUpdateAppCode",
	backupHotUpdateInfoUrl = "backupHotUpdateInfoUrl",
	noticeUrl = "noticeUrl",
	reviewHttpLoginUrl = "reviewHttpLoginUrl",
	httpLoginUrl = "httpLoginUrl",
	feedbackUrl = "feedbackUrl",
	hotUpdateInfoUrl = "hotUpdateInfoUrl"
}

function var_0_1._onReset()
	var_0_1.tryLoginTimes = 0
	var_0_1.isUseBackup = false
end

function var_0_1._onGetServerListError()
	var_0_1.tryLoginTimes = var_0_1.tryLoginTimes + 1

	if var_0_1.tryLoginTimes >= 3 then
		var_0_1.tryLoginTimes = 0
		var_0_1.isUseBackup = not var_0_1.isUseBackup
	end
end

function var_0_1.reqGameConfig()
	BootstrapViewLogic.instance:showUITipByState(BootstrapConstdef.EBootstrapState.GetGameConfig)

	local var_3_0 = CSGameUtils.GetGameConfigUrlType()
	local var_3_1 = Astral.GameConstParser.Instance.gameConfigAreaName
	local var_3_2 = var_0_2.urlInfo[var_3_1]
	local var_3_3 = tonumber(tostring(var_3_0))
	local var_3_4 = var_3_2[var_3_3]

	if not var_3_4 then
		var_3_4 = var_3_2.default

		printError("当前地区", var_3_1, "没有服务器", var_3_3, "的配置，切换到默认配置")
	end

	var_0_1._onHttpGetGameConfigFinish(true, var_3_4)
end

function var_0_1.switchGameConfig(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0 or 0
	local var_4_1 = arg_4_1 or Astral.GameConstParser.Instance.gameConfigAreaName
	local var_4_2 = var_0_2.urlInfo[var_4_1]
	local var_4_3 = var_4_2[var_4_0]

	if not var_4_3 then
		var_4_3 = var_4_2.default

		printError("当前地区", var_4_1, "没有服务器", var_4_0, "的配置，切换到默认配置")
	end

	var_0_1._onHttpGetGameConfigFinish(true, var_4_3)
end

function var_0_1._onHttpGetGameConfigFinish(arg_5_0, arg_5_1)
	if arg_5_0 and arg_5_1 then
		var_0_1.GameConfigJsonData = arg_5_1

		forcePrint("游戏全部配置json", arg_5_1)
		BootstrapViewLogic.instance:showUITipByState(BootstrapConstdef.EBootstrapState.GetGameConfigSuccess)
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartReqGameConfigSuccess)
	else
		BootstrapViewLogic.instance:showUITipByState(BootstrapConstdef.EBootstrapState.GetGameConfigError)
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartReqGameConfigFail, {
			reason = tostring(arg_5_1)
		})
		printError("获取全部游戏配置失败", arg_5_1)
	end
end

function var_0_1.getIsUseBackup()
	return var_0_1.isUseBackup
end

function var_0_1.getIsReview()
	return var_0_1.isReview
end

function var_0_1.setIsReview(arg_8_0)
	var_0_1.isReview = arg_8_0
end

function var_0_1.getIsUseBackupHotupdateInfo()
	return var_0_1.isUseBackupHotupdateInfo
end

function var_0_1.setIsUseBackupHotupdateInfo(arg_10_0)
	var_0_1.isUseBackupHotupdateInfo = arg_10_0
end

function var_0_1.getZoneId()
	local var_11_0 = var_0_1.zoneId or 0

	if var_11_0 == 0 then
		var_11_0 = Astral.LocalStorage.Instance:GetInt(var_0_0, 0)
	end

	return var_11_0
end

function var_0_1.setZoneId(arg_12_0)
	var_0_1.zoneId = arg_12_0

	Astral.LocalStorage.Instance:SetInt(var_0_0, var_0_1.zoneId)
end

function var_0_1.getHotUpdateAppCode()
	return var_0_1.GameConfigJsonData and var_0_1.getDefaultConfig(GameConfigUrlType.hotUpdateAppCode)
end

function var_0_1.getFeedbackUrl()
	return var_0_1.GameConfigJsonData and var_0_1.getDefaultConfig(GameConfigUrlType.feedbackUrl)
end

function var_0_1.getFileServerUrl()
	return var_0_1.GameConfigJsonData and var_0_1.getDefaultConfig(GameConfigUrlType.fileServerUrl)
end

function var_0_1.getCurDefaultConfig()
	if not var_0_1.CurDefaultConfig then
		local var_16_0 = Astral.GameConstParser.Instance.gameConfigAreaName

		var_0_1.CurDefaultConfig = var_0_2.urlInfo[var_16_0].default
	end

	return var_0_1.CurDefaultConfig
end

function var_0_1.getDefaultConfig(arg_17_0)
	if var_0_1.GameConfigJsonData then
		return var_0_1.GameConfigJsonData[arg_17_0] or var_0_1.getCurDefaultConfig()[arg_17_0]
	end
end

function var_0_1.getHttpLoginUrl()
	if var_0_1.GameConfigJsonData then
		local var_18_0 = var_0_1.getDefaultConfig(GameConfigUrlType.httpLoginUrl)

		if var_0_1.getIsReview() and var_0_1.getDefaultConfig(GameConfigUrlType.reviewHttpLoginUrl) then
			var_18_0 = var_0_1.getDefaultConfig(GameConfigUrlType.reviewHttpLoginUrl)
		end

		if not var_0_1.getIsReview() and var_0_1.getIsUseBackup() and var_0_1.getDefaultConfig(GameConfigUrlType.backupHttpLoginUrl) then
			var_18_0 = var_0_1.getDefaultConfig(GameConfigUrlType.backupHttpLoginUrl)
		end

		return var_18_0
	end
end

function var_0_1.getReqServerListUrl()
	return var_0_1.getHttpLoginUrl() .. "loadzone.jsp"
end

function var_0_1.getReqSessoinIdUrl()
	return var_0_1.getHttpLoginUrl() .. "login0.jsp"
end

function var_0_1.getWebLoginUrl()
	return var_0_1.getHttpLoginUrl() .. "login.jsp"
end

function var_0_1.getTranslateUrl()
	return var_0_1.getHttpLoginUrl() .. "translate.jsp"
end

function var_0_1.getHotUpdateInfoUrl(arg_23_0)
	arg_23_0 = arg_23_0 or var_0_1.requestRemoteCount or 1

	if var_0_1.GameConfigJsonData then
		var_0_1.requestRemoteCount = arg_23_0

		local var_23_0 = var_0_1.getDefaultConfig(GameConfigUrlType.backupHotUpdateInfoUrl) ~= nil
		local var_23_1 = arg_23_0 > BootstrapConst.kHotUpdateRequestRemoteResetCount and var_23_0

		var_0_1.setIsUseBackupHotupdateInfo(var_23_1)

		if Astral.OSDef.isEditor then
			local var_23_2 = BootstrapConst.HOTUPDATE_SERVER_URLS

			if Astral.LocalStorage.Instance:GetInt(BootstrapConst.kOpenPcHotdate, 0) == 1 then
				local var_23_3 = Astral.LocalStorage.Instance:GetInt(BootstrapConst.kDomainType, 1)

				if var_23_2[var_23_3] then
					return var_23_2[var_23_3]
				else
					return var_23_1 and var_0_1.getDefaultConfig(GameConfigUrlType.backupHotUpdateInfoUrl) or var_0_1.getDefaultConfig(GameConfigUrlType.hotUpdateInfoUrl)
				end
			end
		end

		return var_23_1 and var_0_1.getDefaultConfig(GameConfigUrlType.backupHotUpdateInfoUrl) or var_0_1.getDefaultConfig(GameConfigUrlType.hotUpdateInfoUrl)
	end
end

function var_0_1.getNoticeUrl()
	if var_0_1.GameConfigJsonData then
		return var_0_1.getDefaultConfig(GameConfigUrlType.noticeUrl)
	end
end

function var_0_1.getNoticeUrl_notice_text()
	if var_0_1.GameConfigJsonData then
		return var_0_1.getDefaultConfig(GameConfigUrlType.noticeUrl) .. "t_notice_text.lua"
	end
end

function var_0_1.getNoticeUrl_notice_image()
	if var_0_1.GameConfigJsonData then
		return var_0_1.getDefaultConfig(GameConfigUrlType.noticeUrl) .. "t_notice_image.lua"
	end
end

return var_0_1
