module("bootstrap.BootstrapConstdef", package.seeall)

local var_0_0 = _M

var_0_0.ENetworkInfo = {
	G2 = "2G",
	G4 = "4G",
	WIFI = "WIFI",
	G3 = "3G"
}
var_0_0.EBootstrapEventId = {
	EStartHotUpdate = "4",
	EHotupdateCheckSuccess = "3",
	EStartReqGameConfigFail = "30",
	EGuideStep = "35",
	EHotUpdateDownloadProgress80 = "19",
	ERequestRemoteVersionFail = "10",
	EStartHotUpdateUnzipSuccess = "27",
	EStartHotUpdateIp = "24",
	EStartHotUpdateIpFail = "25",
	ERequestRemoteVersionSuccess = "12",
	EExecSDKInitSuccess = "1",
	EHotUpdateDownloadProgress10 = "16",
	EHotUpdateDownloadProgress25 = "17",
	EStartHotUpdateUnzip = "26",
	EDiskSpaceInsufficient = "33",
	EHotUpdateDownloadProgress50 = "18",
	ENeedHotUpdate = "9",
	EExecSDKInitFail = "31",
	EHotUpdateComplete = "7",
	EStartReqGameConfigSuccess = "29",
	EExecSDKInitFailAndRetry = "32",
	EHotupdateCheckFail = "2",
	EHotUpdateDownloadProgress100 = "5",
	EStartShowLoginView = "6",
	EStartRequestRemoteVersionIp = "22",
	EViewSensorsTrack = "34",
	EHotUpdateDownloadProgress1 = "15",
	EStartReqGameConfig = "28"
}

function var_0_0.getHotUpdateDownloadTimeStr(arg_1_0)
	if arg_1_0 >= 0 and arg_1_0 <= 5 then
		return "[0-5)"
	elseif arg_1_0 > 5 and arg_1_0 <= 20 then
		return "[5-20)"
	elseif arg_1_0 > 20 and arg_1_0 <= 60 then
		return "[20-60)"
	elseif arg_1_0 > 60 and arg_1_0 <= 120 then
		return "[60-120)"
	elseif arg_1_0 > 120 and arg_1_0 <= 180 then
		return "[120-180)"
	elseif arg_1_0 > 180 and arg_1_0 <= 300 then
		return "[180-300)"
	elseif arg_1_0 > 300 and arg_1_0 <= 600 then
		return "[300-600)"
	elseif arg_1_0 > 600 and arg_1_0 <= 1800 then
		return "[600-1800)"
	elseif arg_1_0 > 1800 then
		return "[1800+)"
	end
end

return var_0_0
