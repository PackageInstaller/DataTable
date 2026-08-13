local var_0_0 = {}
local var_0_1 = ys
local var_0_2 = {}
local var_0_3 = pg
local var_0_4 = {}

pg = cs
setmetatable = var_0_10001
var_0._weak = var_0_10001({}, {
	__mode = "k"
})

local var_0_5 = 1
local var_0_6 = PLATFORM_CH
local var_0_7 = 2
local var_0_8 = PLATFORM_JP
local var_0_9 = 3
local var_0_10 = PLATFORM_KR
local var_0_11 = 4
local var_0_12 = PLATFORM_US
local var_0_13 = 5

PLATFORM_CH = PLATFORM_CHT
UnityEngine = PLATFORM_CODE

local var_0_14 = var_0.Application.isEditor

require = IsUnityEditor

var_0("Include")

require = var_0

var_0("tolua.reflection")

tolua = var_0

var_0.loadassembly("Assembly-CSharp")

tolua = var_0

var_0.loadassembly("UnityEngine.UI")

tolua = var_0

var_0.loadassembly("Live2D.Cubism")

tolua = var_0

var_0.loadassembly("spine-unity")

math = var_0

local var_0_15 = var_0.randomseed

os = var_1

var_0_15(var_1.time())

NetConst = var_0_15

local var_0_16 = var_0_15.GatewayState

originalPrint = CSharpVersion

local var_0_17 = "C# Ver... "

CSharpVersion = var_2

var_0(var_0_17 .. var_2)

LuaHelper = var_0

local var_0_18 = var_0.GetPlatformInt()
local var_0_19 = PLATFORM
local var_0_20 = 99

IsUnityEditor = SDK_EXIT_CODE

local var_0_21

if not var_0_21 then
	function var_0_21()
		return
	end

	var_0_21 = assert
end

QualitySettings = var_0_21
var_0_21.vSyncCount = 0
QualitySettings = var_0_21
ReflectionHelp = var_1

local var_0_22 = var_1.RefGetField

typeof = var_2
var_0_21.skinWeights = var_0_22(var_2("UnityEngine.SkinWeights"), "Unlimited", nil)
tf = var_0_21
GameObject = var_1

local var_0_23 = var_0_21(var_1.Find("EventSystem"))
local var_0_24 = var_0.GetComponent

typeof = var_2
EventSystem = var_3

local var_0_25 = var_0_24(var_0_23, var_2(var_3))

var_0_25.sendNavigationEvents = false
IsUnityEditor = var_0_25

if var_0_25 then
	function var_0_25()
		require = var_1_10000

		local var_2_0 = var_1_10000("LuaDebugjit")("localhost", 7003)

		Timer = breakInfoFun

		local var_2_1 = var_0.New

		breakInfoFun = var_1

		local var_2_2 = var_2_1(var_1, 0.5, -1, 1)

		time = time

		var_0:Start()

		print = var_0

		var_0("luaIdeDebugFunc")

		return
	end

	var_0_25 = luaIdeDebugFunc
end

PLATFORM_CODE = var_0_25
PLATFORM_CH = var_0_26

if var_0_25 == var_0_26 then
	CSharpVersion = var_0_25

	if not (var_0_25 < 48) then
		PLATFORM_CODE = var_0_25
		PLATFORM_CHT = var_0_26

		local var_0_26

		if var_0_25 == var_0_26 then
			PLATFORM = var_0_25

			if var_0_25 == 8 then
				pg = var_0_25
				var_0_26 = var_0_25.SdkMgr.GetInstance()

				var_0_25.InitSDK(var_0_26)
			end
		end

		PLATFORM_CODE = var_0_25
		PLATFORM_CH = var_0_26

		if var_0_25 == var_0_26 then
			BilibiliSdkMgr = var_0_25
			var_0_25.checkSimulator = false
		end

		pg = var_0_25

		local var_0_27 = var_0_25.TimeMgr.GetInstance()

		var_0.Init(var_0_27)

		pg = var_0

		local var_0_28 = var_0.TimeMgr.GetInstance()
		local var_0_29 = var_0._SetServerTime_

		VersionMgr = var_2

		local var_0_30 = var_2.Inst.timestamp

		VersionMgr = var_3

		local var_0_31 = var_3.Inst.monday0oclockTimestamp

		VersionMgr = var_4

		var_0_29(var_0_28, var_0_30, var_0_31, var_4.Inst.realStartUpTimeWhenSetServerTime)

		pg = var_0_29

		local var_0_32 = var_0_29.PushNotificationMgr.GetInstance()

		var_0.Init(var_0_32)

		local function var_0_33(arg_3_0)
			originalPrint = var_1_10001

			local var_3_0 = "OnApplicationPause: "

			tostring = var_1_10003

			var_1_10001(var_3_0 .. var_1_10003(arg_3_0))

			pg = var_1_10001

			if not var_1_10001.m02 then
				return
			end

			local var_3_2

			if arg_3_0 then
				pg = var_3_2

				local var_3_1 = var_3_2.m02

				var_3_2 = var_3_2.sendNotification
				GAME = var_3

				var_3_2(var_3_1, var_3.PAUSE_BATTLE)

				pg = var_3_2

				local var_3_3 = var_3_2.PushNotificationMgr.GetInstance()

				var_3_2.PushAll(var_3_3)
			else
				pg = var_3_2

				local var_3_4 = var_3_2.SdkMgr.GetInstance()

				var_3_2.BindCPU(var_3_4)
			end

			pg = var_3_2

			local var_3_5 = var_3_2.SdkMgr.GetInstance()

			var_1.OnAppPauseForSDK(var_3_5, arg_3_0)

			pg = var_1

			local var_3_6 = var_1.m02
			local var_3_7 = var_1.sendNotification

			GAME = var_3

			var_3_7(var_3_6, var_3.ON_APPLICATION_PAUSE, arg_3_0)

			return
		end

		local var_0_34 = OnApplicationPause

		local function var_0_35()
			originalPrint = var_1_10000

			var_1_10000("OnApplicationExit")

			pg = var_1_10000

			if var_1_10000.GameTrackerMgr then
				pg = var_0

				local var_4_0 = var_0.GameTrackerMgr.GetInstance()

				var_0.Synchronization(var_4_0)
			end

			pg = var_0

			local var_4_1 = var_0.FileDownloadMgr.GetInstance()

			if var_0.IsRunning(var_4_1) then
				return
			end

			pg = var_0

			local var_4_2 = var_0.NewStoryMgr.GetInstance()

			if var_0.IsRunning(var_4_2) then
				pg = var_0

				local var_4_3 = var_0.NewStoryMgr.GetInstance()

				var_0.ForEscPress(var_4_3)

				return
			end

			pg = var_0

			local var_4_4 = var_0.NewGuideMgr.GetInstance()

			if var_0.IsBusy(var_4_4) then
				return
			end

			pg = var_0

			local var_4_5 = var_0.PerformMgr.GetInstance()

			if var_0.IsRunning(var_4_5) then
				return
			end

			ys = var_0

			if var_0.Battle.BattleState.GetInstance() and var_0:GetState() == var_0.BATTLE_STATE_FIGHT and not var_0:IsPause() then
				pg = var_4_5

				local var_4_6 = var_4_5.m02

				var_4_5 = var_4_5.sendNotification
				GAME = var_1_10003

				var_4_5(var_4_6, var_1_10003.PAUSE_BATTLE)

				return
			end

			pg = var_4_5

			if not var_4_5.UIMgr.GetInstance()._loadPanel or var_1:LoadingRetainCount() ~= 0 then
				return
			end

			pg = var_2

			local var_4_7 = var_2.SceneAnimMgr.GetInstance()

			if var_2.IsPlaying(var_4_7) then
				return
			end

			pg = var_3

			local var_4_8

			if var_3.MsgboxMgr.GetInstance() then
				::label_4_0::

				var_1_10005 = var_3
				var_4_8 = var_3.getMsgBoxOb(var_1_10005)
			end

			pg = var_1_10005

			if var_1_10005.NewStoryMgr.GetInstance() and var_5:IsRunning() then
				if var_4_8 and var_4_8.activeSelf then
					pg = var_1_10006

					local var_4_9 = var_1_10006.CriMgr.GetInstance()

					var_1_10006 = var_1_10006.PlaySoundEffect_V3
					SFX_CANCEL = var_1_10008

					var_1_10006(var_4_9, var_1_10008)

					triggerButton = var_1_10006

					var_1_10006(var_3._closeBtn)
				end

				return
			end

			pg = var_1_10006

			if not var_1_10006.m02 then
				return
			end

			local var_4_10 = var_6
			local var_4_11 = var_6.retrieveProxy

			ContextProxy = var_1_10009

			if not var_4_11(var_4_10, var_1_10009.__cname) then
				return
			end

			local var_4_12 = var_7

			if not var_7.getCurrentContext(var_4_12) then
				return
			end

			pg = var_4_12

			if var_4_12.ShareMgr.GetInstance().go then
				isActive = var_10

				if var_10(var_9.go) then
					pg = var_10

					local var_4_13 = var_10.CriMgr.GetInstance()
					local var_4_14 = var_10.PlaySoundEffect_V3

					SFX_CANCEL = var_1_10012

					var_4_14(var_4_13, var_1_10012)

					triggerButton = var_4_14

					local var_4_15 = var_9.panel

					var_4_14(var_11.Find(var_4_15, "main/top/btnBack"))

					return
				end
			end

			local var_4_16 = var_8:retriveLastChild()

			if not var_6:retrieveMediator(var_4_16.mediator.__cname) or not var_10.viewComponent then
				return
			end

			local var_4_17 = var_10.viewComponent._tf.parent
			local var_4_18 = var_11._tf
			local var_4_19 = var_13.GetSiblingIndex(var_4_18)
			local var_4_20 = -1
			local var_4_21

			if var_4_8 and var_4_8.activeSelf then
				var_4_21 = var_4_8.transform.parent

				local var_4_22 = var_4_8.transform

				var_4_20 = var_1_10016.GetSiblingIndex(var_4_22)
			end

			pg = var_1_10016

			local var_4_23 = var_1_10016.playerResUI

			if var_16.checkBackPressed(var_4_23) then
				return
			end

			if var_4_17 == var_4_21 and var_4_20 < var_4_19 then
				var_4_23 = var_11

				var_11.onBackPressed(var_4_23)

				return
			end

			local var_4_24

			if var_4_8 and var_4_8.activeSelf then
				pg = var_4_24
				var_4_23 = var_4_24.CriMgr.GetInstance()
				var_4_24 = var_4_24.PlaySoundEffect_V3
				SFX_CANCEL = var_1_10018

				var_4_24(var_4_23, var_1_10018)

				triggerButton = var_4_24

				var_4_24(var_3._closeBtn)

				return
			end

			checkExist = var_4_24
			pg = var_4_23

			if var_4_24(var_4_23.NewStyleMsgboxMgr.GetInstance(), {
				"_tf"
			}) then
				isActive = var_17

				if var_17(var_16) then
					pg = var_17

					local var_4_25 = var_17.NewStyleMsgboxMgr.GetInstance()

					var_17.Hide(var_4_25)

					return
				end
			end

			nowWorld = var_17

			if var_17() then
				local var_4_26 = var_17.staminaMgr

				if var_18.IsShowing(var_4_26) then
					local var_4_27 = var_17.staminaMgr

					var_18.Hide(var_4_27)

					return
				end
			end

			var_11:onBackPressed()

			return
		end

		local var_0_36 = OnApplicationExit

		local function var_0_37()
			return
		end

		local var_0_38 = OnReceiveMemoryWarning

		local function var_0_39()
			IsNil = var_1_10000
			pg = var_1_10001

			if not var_1_10000(var_1_10001.MsgboxMgr.GetInstance()._go) then
				pg = var_0

				local var_6_0 = var_0.MsgboxMgr.GetInstance()
				local var_6_1 = var_0.ShowMsgBox
				local var_6_2 = {}

				i18n = var_1_10003
				var_6_2.content = var_1_10003("confirm_app_exit")

				function var_6_2.onYes()
					Application = var_2_10000

					var_2_10000.Quit()

					return
				end

				var_6_1(var_6_0, var_6_2)
			end

			return
		end

		local var_0_40 = PressBack

		local function var_0_41(arg_8_0)
			pg = var_1_10001

			local var_8_0 = var_1_10001.ShaderMgr.GetInstance()

			var_1.Init(var_8_0, arg_8_0)

			return
		end

		local function var_0_42(arg_9_0)
			require = var_1_10001

			var_1_10001("HybridCLRConst")

			Application = var_1_10001

			local var_9_0 = var_1_10001.streamingAssetsPath .. "/AssetBundles/hybridclr/patch/"

			HybridCLRConst = var_2

			local var_9_1 = var_2.PatchDllList

			Sandystar = var_1_10003

			var_1_10003.HybridCLRTool.HybridCLRHelper.LoadPatchDLL(var_9_0, var_9_1)

			Application = var_3

			local var_9_2 = var_3.persistentDataPath .. "/AssetBundles/hybridclr/hotfix/"

			HybridCLRConst = var_4

			local var_9_3 = var_4.HotfixDllList

			Sandystar = var_5

			var_5.HybridCLRTool.HybridCLRHelper.LoadHotfixDLL(var_9_2, var_9_3)

			Sandystar = var_5

			var_5.HybridCLRTool.HybridCLRHelper.SetFinishCallback(function()
				BLHX = var_2_10000

				local var_10_0 = var_2_10000.Rendering.GraphicsInterface

				GraphicSettingConst = GraphicsInterface

				var_0.ClearPlayerPrefs()

				GraphicSettingConst = var_0

				var_0.InitDefautQuality()
				arg_9_0()

				return
			end)

			return
		end

		local function var_0_43(arg_11_0)
			parallelAsync = var_1_10001

			var_1_10001({
				function(arg_12_0)
					pg = var_2_10001

					local var_12_0 = var_2_10001.LayerWeightMgr.GetInstance()

					var_1.Init(var_12_0, arg_12_0)

					return
				end,
				function(arg_13_0)
					pg = var_2_10001

					local var_13_0 = var_2_10001.UIMgr.GetInstance()

					var_1.Init(var_13_0, arg_13_0)

					return
				end,
				function(arg_14_0)
					pg = var_2_10001

					local var_14_0 = var_2_10001.CriMgr.GetInstance()

					var_1.Init(var_14_0, arg_14_0)

					return
				end
			}, arg_11_0)

			return
		end

		local function var_0_44(arg_15_0)
			parallelAsync = var_1_10001

			var_1_10001({
				function(arg_16_0)
					pg = var_2_10001

					local var_16_0 = var_2_10001.FontMgr.GetInstance()

					var_1.Init(var_16_0, arg_16_0)

					return
				end,
				function(arg_17_0)
					pg = var_2_10001

					local var_17_0 = var_2_10001.PoolMgr.GetInstance()

					var_1.Init(var_17_0, arg_17_0)

					return
				end,
				function(arg_18_0)
					pg = var_2_10001

					local var_18_0 = var_2_10001.TipsMgr.GetInstance()

					var_1.Init(var_18_0, arg_18_0)

					return
				end,
				function(arg_19_0)
					pg = var_2_10001

					local var_19_0 = var_2_10001.MsgboxMgr.GetInstance()

					var_1.Init(var_19_0, arg_19_0)

					return
				end,
				function(arg_20_0)
					pg = var_2_10001

					local var_20_0 = var_2_10001.NewStyleMsgboxMgr.GetInstance()

					var_1.Init(var_20_0, arg_20_0)

					return
				end,
				function(arg_21_0)
					pg = var_2_10001

					local var_21_0 = var_2_10001.SystemOpenMgr.GetInstance()

					var_1.Init(var_21_0, arg_21_0)

					return
				end,
				function(arg_22_0)
					pg = var_2_10001

					local var_22_0 = var_2_10001.SystemGuideMgr.GetInstance()

					var_1.Init(var_22_0, arg_22_0)

					return
				end,
				function(arg_23_0)
					pg = var_2_10001

					local var_23_0 = var_2_10001.NewGuideMgr.GetInstance()

					var_1.Init(var_23_0, arg_23_0)

					return
				end,
				function(arg_24_0)
					pg = var_2_10001

					local var_24_0 = var_2_10001.ToastMgr.GetInstance()

					var_1.Init(var_24_0, arg_24_0)

					return
				end,
				function(arg_25_0)
					pg = var_2_10001

					local var_25_0 = var_2_10001.WorldToastMgr.GetInstance()

					var_1.Init(var_25_0, arg_25_0)

					return
				end,
				function(arg_26_0)
					pg = var_2_10001

					local var_26_0 = var_2_10001.SecondaryPWDMgr.GetInstance()

					var_1.Init(var_26_0, arg_26_0)

					return
				end,
				function(arg_27_0)
					pg = var_2_10001

					local var_27_0 = var_2_10001.ShipFlagMgr.GetInstance()

					var_1.Init(var_27_0, arg_27_0)

					return
				end,
				function(arg_28_0)
					pg = var_2_10001

					local var_28_0 = var_2_10001.NewStoryMgr.GetInstance()

					var_1.Init(var_28_0, arg_28_0)

					return
				end,
				function(arg_29_0)
					pg = var_2_10001

					local var_29_0 = var_2_10001.EasyRedDotMgr.GetInstance()

					var_1.Init(var_29_0, arg_29_0)

					return
				end,
				function(arg_30_0)
					pg = var_2_10001

					local var_30_0 = var_2_10001.UserAgreementMgr.GetInstance()

					var_1.Init(var_30_0, arg_30_0)

					return
				end,
				function(arg_31_0)
					pg = var_2_10001

					local var_31_0 = var_2_10001.BrightnessMgr.GetInstance()

					var_1.Init(var_31_0, arg_31_0)

					return
				end,
				function(arg_32_0)
					pg = var_2_10001

					local var_32_0 = var_2_10001.ConfigTablePreloadMgr.GetInstance()

					var_1.Init(var_32_0, arg_32_0)

					return
				end,
				function(arg_33_0)
					pg = var_2_10001

					local var_33_0 = var_2_10001.CameraFixMgr.GetInstance()

					var_1.Init(var_33_0, arg_33_0)

					return
				end,
				function(arg_34_0)
					pg = var_2_10001

					local var_34_0 = var_2_10001.BgmMgr.GetInstance()

					var_1.Init(var_34_0, arg_34_0)

					return
				end,
				function(arg_35_0)
					pg = var_2_10001

					local var_35_0 = var_2_10001.SettingsGroupMgr.GetInstance()

					var_1.Init(var_35_0)

					pg = var_1

					local var_35_1 = var_1.FileDownloadMgr.GetInstance()

					var_1.Init(var_35_1, arg_35_0)

					return
				end,
				function(arg_36_0)
					pg = var_2_10001

					local var_36_0 = var_2_10001.RepairResMgr.GetInstance()

					var_1.Init(var_36_0, arg_36_0)

					return
				end,
				function(arg_37_0)
					pg = var_2_10001

					local var_37_0 = var_2_10001.NodeCanvasMgr.GetInstance()

					var_1.Init(var_37_0, arg_37_0)

					return
				end,
				function(arg_38_0)
					pg = var_2_10001

					local var_38_0 = var_2_10001.SceneAnimMgr.GetInstance()

					var_1.Init(var_38_0, arg_38_0)

					return
				end,
				function(arg_39_0)
					pg = var_2_10001

					local var_39_0 = var_2_10001.PerformMgr.GetInstance()

					var_1.Init(var_39_0, arg_39_0)

					return
				end,
				function(arg_40_0)
					pg = var_2_10001

					local var_40_0 = var_2_10001.ClickEffectMgr.GetInstance()

					var_1.Init(var_40_0, arg_40_0)

					return
				end,
				function(arg_41_0)
					pg = var_2_10001

					local var_41_0 = var_2_10001.CameraRTMgr.GetInstance()

					var_1.Init(var_41_0, arg_41_0)

					return
				end,
				function(arg_42_0)
					pg = var_2_10001

					local var_42_0 = var_2_10001.GameTrackerMgr.GetInstance()

					var_1.Init(var_42_0, arg_42_0)

					return
				end,
				function(arg_43_0)
					pg = var_2_10001

					local var_43_0 = var_2_10001.GMTMgr.GetInstance()

					var_1.Init(var_43_0, arg_43_0)

					return
				end,
				function(arg_44_0)
					pg = var_2_10001

					local var_44_0 = var_2_10001.ChangeSkinMgr.GetInstance()

					var_1.Init(var_44_0, arg_44_0)

					return
				end,
				function(arg_45_0)
					LOCK_ISLAND_DISPLAY = var_2_10001

					if var_2_10001 then
						arg_45_0()
					else
						pg = var_2_10001

						local var_45_0 = var_2_10001.IslandVisitorNotificationMgr.GetInstance()

						var_1.Init(var_45_0, arg_45_0)
					end

					return
				end
			}, arg_15_0)

			return
		end

		os = var_4

		local var_0_45 = var_4.clock()

		seriesAsync = var_0_10005

		var_0_10005({
			var_0_41,
			var_0_42,
			var_0_43,
			var_0_44
		}, function(arg_46_0)
			pg = var_1_10001

			local var_46_0 = var_1_10001.SdkMgr.GetInstance()

			var_1.QueryWithProduct(var_46_0)

			print = var_1

			local var_46_1 = "loading cost: "

			os = var_1_10003

			var_1(var_46_1 .. var_1_10003.clock() - var_0_45)

			VersionMgr = var_1

			local var_46_2 = var_1.Inst

			var_1.DestroyUI(var_46_2)

			GameObject = var_1

			local var_46_3 = var_1.Find("OverlayCamera/Overlay/UIMain/ServerChoosePanel")

			IsNil = var_2

			if not var_2(var_46_3) then
				Object = var_2

				var_2.Destroy(var_46_3)
			end

			Screen = var_2
			SleepTimeout = var_3
			var_2.sleepTimeout = var_3.SystemSetting
			pg = var_2

			local var_46_4 = var_2.UIMgr.GetInstance()

			var_2.displayLoadingBG(var_46_4, true)

			if arg_46_0 then
				pg = var_2

				local var_46_5 = var_2.UIMgr.GetInstance()

				var_2.Loading(var_46_5, arg_46_0)

				error = var_2

				var_2(arg_46_0)

				return
			end

			pg = var_2

			local var_46_6 = var_2.SdkMgr.GetInstance()

			var_2.BindCPU(var_46_6)

			pg = var_2
			pm = var_46_6
			var_2.m02 = var_46_6.Facade.getInstance("m02")
			pg = var_2

			local var_46_7 = var_2.m02
			local var_46_8 = var_2.registerCommand

			GAME = var_4

			local var_46_9 = var_4.STARTUP

			StartupCommand = var_1_10005

			var_46_8(var_46_7, var_46_9, var_1_10005)

			pg = var_46_8

			local var_46_10 = var_46_8.m02
			local var_46_11 = var_2.sendNotification

			GAME = var_46_9

			var_46_11(var_46_10, var_46_9.STARTUP)

			pg = var_46_11
			PlayerResUI = var_46_10
			var_46_11.playerResUI = var_46_10.New()
			pg = var_46_11

			local var_46_12 = var_46_11.SdkMgr.GetInstance()

			var_2.GoSDkLoginScene(var_46_12)

			pg = var_2

			local var_46_13 = var_2.UIMgr.GetInstance()

			var_2.AddDebugButton(var_46_13, "Device Info", function()
				originalPrint = var_2_10000

				local var_47_0 = "+++++++++++graphicsDeviceVendorID:"

				SystemInfo = var_2_10002

				var_2_10000(var_47_0 .. var_2_10002.graphicsDeviceVendorID)

				DevicePerformanceUtil = var_2_10000

				var_2_10000.GetDevicePerformanceLevel()

				originalPrint = var_0

				local var_47_1 = "CPU核心:"

				SystemInfo = var_2

				var_0(var_47_1 .. var_2.processorCount)

				originalPrint = var_0

				local var_47_2 = "显存:"

				SystemInfo = var_2

				var_0(var_47_2 .. var_2.graphicsMemorySize)

				originalPrint = var_0

				local var_47_3 = "内存:"

				SystemInfo = var_2

				var_0(var_47_3 .. var_2.systemMemorySize)

				originalPrint = var_0

				local var_47_4 = "主频:"

				SystemInfo = var_2

				var_0(var_47_4 .. var_2.processorFrequency)

				originalPrint = var_0

				var_0("+++++++++++")

				return
			end)

			return
		end)

		return
	end
end
