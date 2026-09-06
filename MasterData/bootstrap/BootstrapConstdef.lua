-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/bootstrap/BootstrapConstdef.lua

module("bootstrap.BootstrapConstdef", package.seeall)

local BootstrapConstdef = _M

BootstrapConstdef.ENetworkInfo = {
	G2 = "2G",
	G4 = "4G",
	WIFI = "WIFI",
	G3 = "3G"
}
BootstrapConstdef.EBootstrapEventId = {
	EHotUpdateFail = "500273",
	EHotUpdateDownloadProgress10 = "500277",
	EStartReqGameConfigFail = "30",
	EExecSDKInitSuccess = "1",
	ENeedHotUpdate = "9",
	ERequestRemoteVersionFail = "500287",
	ERequestRemoteVersionSuccess = "500286",
	EStartRequestRemoteVersionIp = "22",
	EHotUpdateDownloadProgress75 = "500281",
	EExecSDKInitFailAndRetry = "32",
	EHotupdateCheckSuccess = "500272",
	EStartHotUpdate = "500274",
	EHotUpdateDownloadProgress25 = "17",
	ECPSDKInitSuccess = "500760",
	EDiskSpaceInsufficient = "33",
	ERequestRemoteVersionMainfestSuccess = "500780",
	ECSherpInitComplete = "500249",
	ECPNeedHotUpdate = "501860",
	EHotUpdateComplete = "500283",
	ECPStartHotUpdateUnzipSuccess = "500748",
	EHotUpdateDownloadProgress5 = "500276",
	EHotUpdateDownloadProgress20 = "500278",
	ERequestRemoteVersionMainfestFail = "500762",
	ECPCreateAnimEnd = "500746",
	EHotUpdateDownloadProgress100 = "500282",
	EGuideStep = "35",
	EHotUpdateDownloadProgress80 = "19",
	EExecSDKInitFail = "31",
	EStartHotUpdateUnzipSuccess = "27",
	ECPJumpUpdateUrl = "501862",
	EStartHotUpdateIp = "24",
	EHotUpdateDownloadProgress30 = "500279",
	EStartHotUpdateIpFail = "25",
	EStartHotUpdateUnzip = "26",
	ECPStartHotUpdateUnzipFail = "501861",
	EHotUpdateDownloadProgress50 = "500280",
	ECPStartHotUpdateUnzip = "500747",
	EStartReqGameConfigSuccess = "29",
	ECPCreateAnimStart = "500745",
	EStartShowLoginView = "6",
	EHotupdateCheckFail = "2",
	EViewSensorsTrack = "34",
	EHotUpdateDownloadProgress1 = "500275",
	EStartReqGameConfig = "28",
	ECSharpInitStart = "500785"
}
BootstrapConstdef.EBootstrapEventId.ELoginCommonId = "501087"
BootstrapConstdef.ELoginCommonIdName = "LoadingActions"
BootstrapConstdef.EBootstrapEventId.EReqResListCommonId = "501165"
BootstrapConstdef.EBootstrapEventId.EResListSuccCommonId = "501166"
BootstrapConstdef.EBootstrapEventId.EReqManifestListCommonId = "501167"
BootstrapConstdef.EBootstrapEventId.EManifestListSuccCommonId = "501168"
BootstrapConstdef.EBootstrapEventId.EBeginDownloadCommonId = "501169"
BootstrapConstdef.EBootstrapEventId.EGroupFailCommonId = "501170"
BootstrapConstdef.EBootstrapEventId.EAllDownloadSuccCommonId = "501171"

function BootstrapConstdef.getHotUpdateDownloadTimeStr(timeSec)
	if timeSec >= 0 and timeSec <= 5 then
		return "[0-5)"
	elseif timeSec > 5 and timeSec <= 20 then
		return "[5-20)"
	elseif timeSec > 20 and timeSec <= 60 then
		return "[20-60)"
	elseif timeSec > 60 and timeSec <= 120 then
		return "[60-120)"
	elseif timeSec > 120 and timeSec <= 180 then
		return "[120-180)"
	elseif timeSec > 180 and timeSec <= 300 then
		return "[180-300)"
	elseif timeSec > 300 and timeSec <= 600 then
		return "[300-600)"
	elseif timeSec > 600 and timeSec <= 1800 then
		return "[600-1800)"
	elseif timeSec > 1800 then
		return "[1800+)"
	end
end

return BootstrapConstdef
