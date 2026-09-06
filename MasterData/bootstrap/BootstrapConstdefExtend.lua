-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/bootstrap/BootstrapConstdefExtend.lua

module("bootstrap.BootstrapConstdefExtend", package.seeall)

BootstrapConstdef.EBootstrapState = {
	LocalDownloadManifestSuccess = 27,
	HotUpdateComplete = 12,
	LocalManifestSaveSuccess = 30,
	NeedToStartHotUpdate = 13,
	LoadUIPrefabSuccess = 3,
	UnzipProgress = 10,
	HotUpdateDownloadProgress = 9,
	SDKInitFail = 23,
	StartUnzipNotify = 15,
	NeedPackageUpdate = 14,
	GetGameConfigError = 5,
	LoadUIPrefabError = 2,
	LoadUIPrefab = 1,
	UnzipFail = 22,
	GetGameConfigSuccess = 6,
	LocalVersionCodeSuccess = 26,
	HotUpdateDownloadFail = 21,
	DiskSpaceInsufficient = 25,
	NeedFilesDownloadSuccess = 32,
	ResDownloadError = 35,
	RequestRemoteVersionSuccess = 17,
	OnlineResUpdateComplete = 33,
	RequestRemoteProjectManifestFail = 20,
	GetGameConfig = 4,
	BussLuaBundlesDone = 8,
	Boot = 0,
	HotUpdateDownloadBeginning = 24,
	RequestRemoteVersionFail = 19,
	RequestRemoteProjectManifestSuccess = 18,
	UnzipSuccess = 11,
	HotManifestFileSuccess = 28,
	DeleteAllHotManifestSuccess = 31,
	ReadManifestFileError = 34,
	StartHotUpdate = 7,
	RequestDownloadManifestSuccess = 29,
	HotUpdateAllDownloadSuccess = 16
}
BootstrapConstdef.NetWorkCloseed = "Cannot connect to destination host"
BootstrapConstdef.CurBootstrapState = BootstrapConstdef.EBootstrapState.Boot

return BootstrapConstdefExtend
