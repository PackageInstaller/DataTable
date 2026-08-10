return {
	Init = function(arg_1_0)
		arg_1_0.system = {}
		arg_1_0.luaSystem = {}
		arg_1_0.runtimeContext = nil
		arg_1_0.luaContext = {
			singleSkinId = -1,
			mainStageId = -1,
			isInFocus = false,
			isFreeCapture = false,
			prepareComplete = false
		}
		arg_1_0.InGame = false
	end,
	CaptureGameStart = function(arg_2_0, arg_2_1)
		arg_2_0.runtimeContext = arg_2_1
		arg_2_0.luaContext.isInFocus = false
		arg_2_0.luaContext.prepareComplete = false
		arg_2_0.luaContext.isFreeCapture = arg_2_1.isFreeCapture
		arg_2_0.luaContext.mainStageId = arg_2_1.mainStageId
		arg_2_0.luaContext.singleSkinId = arg_2_1.singleModeRoleId

		if not arg_2_0:IsSingleMode() then
			arg_2_0.luaSystem.placeHolderMgr = CapturePlaceHolderMgr.New()
		end

		CaptureGameSettingData:InitSetting()

		arg_2_0.InGame = true
	end,
	CaptureGameStop = function(arg_3_0)
		if not arg_3_0:IsSingleMode() then
			arg_3_0.luaSystem.placeHolderMgr:Dispose()

			arg_3_0.luaSystem.placeHolderMgr = nil
		end

		arg_3_0.runtimeContext = nil
		arg_3_0.InGame = false
	end,
	StopMgr = function(arg_4_0)
		return
	end,
	ResetStartTime = function(arg_5_0)
		arg_5_0.luaContext.startTimeStamp = manager.time:GetServerTime()
	end,
	GetStartTime = function(arg_6_0)
		return arg_6_0.luaContext.startTimeStamp
	end,
	GetTimeDistance = function(arg_7_0)
		return manager.time:GetServerTime() - arg_7_0:GetStartTime()
	end,
	PreStartCaptureGame = function(arg_8_0)
		if not arg_8_0:IsFreeCapture() and not arg_8_0:IsSingleMode() then
			arg_8_0:GetPlaceHolderMgr():SortHolderWithCamera()
			arg_8_0:GetCameraMgr():PreStartInit()
		end

		arg_8_0.luaContext.prepareComplete = true

		arg_8_0:ResetStartTime()
	end,
	IsInCaptureGame = function(arg_9_0)
		return arg_9_0.InGame
	end,
	IsSingleMode = function(arg_10_0)
		return arg_10_0.runtimeContext:CheckIsSingleMode()
	end,
	GetGameContext = function(arg_11_0)
		return arg_11_0.runtimeContext
	end,
	GetSectionId = function(arg_12_0)
		return arg_12_0.runtimeContext.stageId
	end,
	GetCurRoleId = function(arg_13_0)
		if arg_13_0:IsSingleMode() then
			local var_13_0 = arg_13_0.luaContext.singleSkinId
			local var_13_1 = CaptureGameMgr:GetEntityMgr():QueryRole(var_13_0)

			if var_13_1 then
				return var_13_1:GetId()
			end

			return -1
		else
			local var_13_2 = arg_13_0:GetPlaceHolderMgr():GetCurrentSelect()

			if var_13_2 ~= -1 then
				return (arg_13_0:GetPlaceHolderMgr():GetEntity(var_13_2):GetSkinEntityId())
			end

			return -1
		end
	end,
	IsFreeCapture = function(arg_14_0)
		return arg_14_0.luaContext.isFreeCapture
	end,
	HideAllNoNeed = function(arg_15_0, arg_15_1)
		if not arg_15_0:IsSingleMode() then
			arg_15_0:GetPlaceHolderMgr():HideAll(arg_15_1)
		end
	end,
	GetCurSectionHeroList = function(arg_16_0)
		return CaptureGameTools:GetCaptureHeroList(arg_16_0.luaContext.mainStageId)
	end,
	GetCurUsingHeroList = function(arg_17_0)
		local var_17_0 = {}

		if arg_17_0:IsSingleMode() then
			table.insert(var_17_0, arg_17_0.luaContext.singleSkinId)
		else
			var_17_0 = arg_17_0:GetPlaceHolderMgr():GetAllUsingSkin()
		end

		return var_17_0
	end,
	GetCurUsingHeroPoseList = function(arg_18_0)
		local var_18_0 = {}

		if arg_18_0:IsSingleMode() then
			local var_18_1 = CaptureGameMgr:GetEntityMgr():QueryRole(arg_18_0.luaContext.singleSkinId)

			table.insert(var_18_0, var_18_1:GetCurrentAnimation())
		else
			var_18_0 = arg_18_0:GetPlaceHolderMgr():GetAllUsingSkinPose()
		end

		return var_18_0
	end,
	GetMainActivityId = function(arg_19_0)
		return arg_19_0.luaContext.mainStageId
	end,
	AlreadyPrepare = function(arg_20_0)
		return arg_20_0.luaContext.prepareComplete
	end,
	GetMultiVirtualCamera = function(arg_21_0)
		return arg_21_0.runtimeContext.multiCaptureCamera
	end,
	GetPlaceHolderMgr = function(arg_22_0)
		return arg_22_0.luaSystem.placeHolderMgr
	end,
	SwitchSkin = function(arg_23_0, arg_23_1, arg_23_2)
		arg_23_0:GetPlaceHolderMgr():SwitchSkin(arg_23_1, arg_23_2)
	end,
	StartEntityMgr = function(arg_24_0)
		arg_24_0.system.entityMgr = EntityMgr.New()

		arg_24_0.system.entityMgr:Init()
		arg_24_0.system.entityMgr:Start()
	end,
	StopEntityMgr = function(arg_25_0)
		if arg_25_0.system.entityMgr ~= nil then
			arg_25_0.system.entityMgr:Stop()

			arg_25_0.system.entityMgr = nil
		end
	end,
	GetEntityMgr = function(arg_26_0)
		return arg_26_0.system.entityMgr
	end,
	StartTaskMgr = function(arg_27_0)
		arg_27_0.system.taskMgr = CaptureTaskMgr.New()

		arg_27_0.system.taskMgr:Start()
	end,
	StopTaskMgr = function(arg_28_0)
		if arg_28_0.system.taskMgr ~= nil then
			arg_28_0.system.taskMgr:Stop()

			arg_28_0.system.taskMgr = nil
		end
	end,
	ExecuteTaskMgr = function(arg_29_0)
		if arg_29_0.system.taskMgr then
			arg_29_0.system.taskMgr:ExecuteTask()
		end
	end,
	GetTaskMgr = function(arg_30_0)
		return arg_30_0.system.taskMgr
	end,
	StartCameraMgr = function(arg_31_0, arg_31_1)
		arg_31_0.system.cameraMgr = CaptureCameraMgr.New()

		arg_31_0.system.cameraMgr:SetController(arg_31_1)
		arg_31_0.system.cameraMgr:Start()
	end,
	StopCameraMgr = function(arg_32_0)
		if arg_32_0.system.cameraMgr ~= nil then
			arg_32_0.system.cameraMgr:Stop()

			arg_32_0.system.cameraMgr = nil
		end
	end,
	GetCameraMgr = function(arg_33_0)
		return arg_33_0.system.cameraMgr
	end,
	OpenSettingPanel = function(arg_34_0, arg_34_1)
		if arg_34_1 == arg_34_0.luaContext.isInFocus then
			return
		end

		if arg_34_1 then
			arg_34_0.system.cameraMgr:PauseMainCamera(true)

			if not arg_34_0:IsSingleMode() then
				arg_34_0.luaSystem.placeHolderMgr:FocusCurrentSelect(true)
			end

			manager.notify:Invoke(CAPTURE_GAME_OPEN_SETTING_PANEL)
			JumpTools.OpenPageByJump("captureSettingView")
		else
			arg_34_0.system.cameraMgr:PauseMainCamera(false)

			if not arg_34_0:IsSingleMode() then
				arg_34_0.luaSystem.placeHolderMgr:FocusCurrentSelect(false)
			end

			manager.notify:Invoke(CAPTURE_GAME_CLOSE_SETTING_PANEL)
		end

		arg_34_0.luaContext.isInFocus = arg_34_1
	end
}
