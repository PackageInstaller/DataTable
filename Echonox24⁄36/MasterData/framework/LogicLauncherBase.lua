module("framework.LogicLauncherBase", package.seeall)

local var_0_0 = class("LogicLauncherBase")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.initFramework(arg_2_0, arg_2_1, arg_2_2)
	DispatcherManager.registDispatcher(DispatcherName)
	Scheduler.init()

	arg_2_1 = arg_2_1 or "logic.setting.setting_proto"
	arg_2_2 = arg_2_2 or 3

	arg_2_0:initSettingProto(arg_2_1, arg_2_2)
end

function var_0_0.initSettingProto(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = usingnow(arg_3_1)

	NetConnMgr.instance:init(var_3_0, arg_3_2)
end

function var_0_0.initFrameworkExt(arg_4_0)
	local var_4_0 = usingnow("logic.setting.setting_extension")

	ExtensionMgr.instance:init(var_4_0)

	local var_4_1 = goutil.find("MainCamera")

	if var_4_1 then
		local var_4_2 = CameraTarget.Get(var_4_1)
	end

	local var_4_3 = goutil.find("UICamera")

	if var_4_3 then
		local var_4_4 = CameraTarget.Get(var_4_3)
	end

	ConfigMgr.instance:init("logic.config.t_")

	local var_4_5 = usingnow("logic.setting.setting_view")

	ViewSetting.instance:init(var_4_5)
	SequenceLoader.instance:init()
	arg_4_0:initViewMgr()
	NavWayPoint.initPool()
end

function var_0_0.initViewMgr(arg_5_0)
	ViewMgr.instance:init(ViewMgrDefaultImpl)
end

function var_0_0.buildBasicExtensions(arg_6_0, arg_6_1)
	ExtensionMgr.instance:buildExtensions(arg_6_1)
end

function var_0_0.buildAdditionalExtensions(arg_7_0)
	ExtensionMgr.instance:buildAllExtensions()
end

function var_0_0.loadMainManifest(arg_8_0)
	forcePrint("LogicLauncherBase loadMainManifest")
	rescache:LoadMainManifest("main_manifest", arg_8_0.onManifestLoaded, arg_8_0)
end

function var_0_0.onManifestLoaded(arg_9_0)
	forcePrint("LogicLauncherBase onManifestLoaded")
	arg_9_0:initFramework()
	arg_9_0:initFrameworkExt()
end

function var_0_0.start(arg_10_0)
	arg_10_0:onManifestLoaded()
end

function var_0_0.destory(arg_11_0)
	return
end

return var_0_0
