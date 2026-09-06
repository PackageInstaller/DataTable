-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/LogicLauncherBase.lua

module("framework.LogicLauncherBase", package.seeall)

local LogicLauncherBase = class("LogicLauncherBase")

function LogicLauncherBase:ctor()
	return
end

function LogicLauncherBase:initFramework(settingProtoPath, throughput)
	GlobalDispatcher.init()
	Scheduler.init()

	settingProtoPath = settingProtoPath or "logic.setting.setting_proto"
	throughput = throughput or 3

	local settingProto = usingnow(settingProtoPath)

	NetConnMgr.instance:init(settingProto, throughput)
end

function LogicLauncherBase:initFrameworkExt()
	local settingExtension = usingnow("logic.setting.setting_extension")

	ExtensionMgr.instance:init(settingExtension)

	local mainCameraGO = goutil.find("MainCamera")

	if mainCameraGO then
		local mainCameraTarget = CameraTarget.Get(mainCameraGO)

		CameraTargetMgr.instance:addTarget(mainCameraTarget)
	end

	local uiCameraGO = goutil.find("UICamera")

	if uiCameraGO then
		local uiCameraTarget = CameraTarget.Get(uiCameraGO)

		CameraTargetMgr.instance:addTarget(uiCameraTarget)
	end

	ConfigMgr.instance:init("logicconfig.config.t_")

	local settingView = usingnow("logic.setting.setting_view")

	ViewSetting.instance:init(settingView)
	ViewMgr.instance:init()
	NavWayPoint.initPool()
end

function LogicLauncherBase:buildBasicExtensions(extIds)
	ExtensionMgr.instance:buildExtensions(extIds)
end

function LogicLauncherBase:buildAdditionalExtensions()
	ExtensionMgr.instance:buildAllExtensions()
end

function LogicLauncherBase:loadMainManifest()
	forcePrint(LogTag.BOOTSTRAP, "LogicLauncherBase loadMainManifest")
	rescache:LoadMainManifest("main_manifest", self.onManifestLoaded, self)
end

function LogicLauncherBase:onManifestLoaded()
	forcePrint(LogTag.BOOTSTRAP, "LogicLauncherBase onManifestLoaded")
	self:initFramework()
	self:initFrameworkExt()
end

function LogicLauncherBase:start()
	if rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		self:onManifestLoaded()
	elseif rescache.resLoadMode == Framework.ResourceLoadMode.AssetBundle then
		self:loadMainManifest()
	else
		self:loadMainManifest()
	end
end

return LogicLauncherBase
