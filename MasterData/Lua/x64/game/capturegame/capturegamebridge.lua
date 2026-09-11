return {
	CaptureGameStart = function(arg_1_0)
		CaptureGameMgr:CaptureGameStart(arg_1_0)
	end,
	CaptureGameStop = function()
		CaptureGameMgr:CaptureGameStop()
	end,
	PreStartCaptureGame = function()
		LuaForUtil.UpdateCameraSetting()
		manager.uiInit()
		gameContext:Go("/captureGameMain")
		CaptureGameMgr:PreStartCaptureGame()
	end,
	LeaveCaptureGame = function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end,
	EntityLogicStop = function()
		CaptureGameMgr:StopEntityMgr()
	end,
	EntityLogicStart = function()
		CaptureGameMgr:StartEntityMgr()
	end,
	InstNewRole = function(arg_7_0)
		return (CaptureGameMgr:GetEntityMgr():MakeNewEntity(CaptureGameConst.EntityType.Role, {
			roleId = arg_7_0
		}))
	end,
	InstNewPlaceHolder = function()
		return (CaptureGameMgr:GetEntityMgr():MakeNewEntity(CaptureGameConst.EntityType.PlaceHolder, {}))
	end,
	InstNewDecorator = function(arg_9_0, arg_9_1)
		return (CaptureGameMgr:GetEntityMgr():MakeNewEntity(CaptureGameConst.EntityType.Decorator, {
			prefabName = arg_9_0,
			tag = arg_9_1
		}))
	end,
	TaskLogicStart = function()
		CaptureGameMgr:StartTaskMgr()
	end,
	TaskLogicStop = function()
		CaptureGameMgr:StopTaskMgr()
	end,
	TaskLogicExecute = function()
		CaptureGameMgr:ExecuteTaskMgr()
	end,
	StartCameraMgr = function(arg_13_0)
		CaptureGameMgr:StartCameraMgr(arg_13_0)
	end,
	StopCameraMgr = function(arg_14_0)
		CaptureGameMgr:StopCameraMgr()
	end,
	CameraFovChangedEvent = function()
		manager.notify:Invoke(CAPTURE_GAME_CAMERA_FOV_CHANGED)
	end
}
