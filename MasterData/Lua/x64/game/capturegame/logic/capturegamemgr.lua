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
	CaptureGameStart = function(self, arg_2_1)
		self.runtimeContext = arg_2_1
		self.luaContext.isInFocus = false
		self.luaContext.prepareComplete = false
		self.luaContext.isFreeCapture = arg_2_1.isFreeCapture
		self.luaContext.mainStageId = arg_2_1.mainStageId
		self.luaContext.singleSkinId = arg_2_1.singleModeRoleId

		if not self:IsSingleMode() then
			self.luaSystem.placeHolderMgr = CapturePlaceHolderMgr.New()
		end

		CaptureGameSettingData:InitSetting()

		self.InGame = true
	end,
	CaptureGameStop = function(self)
		if not self:IsSingleMode() then
			self.luaSystem.placeHolderMgr:Dispose()

			self.luaSystem.placeHolderMgr = nil
		end

		self.runtimeContext = nil
		self.InGame = false
	end,
	StopMgr = function(arg_4_0)
		return
	end,
	ResetStartTime = function(self)
		self.luaContext.startTimeStamp = manager.time:GetServerTime()
	end,
	GetStartTime = function(self)
		return self.luaContext.startTimeStamp
	end,
	GetTimeDistance = function(self)
		return manager.time:GetServerTime() - self:GetStartTime()
	end,
	PreStartCaptureGame = function(self)
		if not self:IsFreeCapture() and not self:IsSingleMode() then
			self:GetPlaceHolderMgr():SortHolderWithCamera()
			self:GetCameraMgr():PreStartInit()
		end

		self.luaContext.prepareComplete = true

		self:ResetStartTime()
	end,
	IsInCaptureGame = function(self)
		return self.InGame
	end,
	IsSingleMode = function(self)
		return self.runtimeContext:CheckIsSingleMode()
	end,
	GetGameContext = function(self)
		return self.runtimeContext
	end,
	GetSectionId = function(self)
		return self.runtimeContext.stageId
	end,
	GetCurRoleId = function(self)
		if self:IsSingleMode() then
			local var_13_0 = CaptureGameMgr:GetEntityMgr():QueryRole(self.luaContext.singleSkinId)

			if var_13_0 then
				return var_13_0:GetId()
			end

			return -1
		else
			local var_13_1 = self:GetPlaceHolderMgr():GetCurrentSelect()

			if var_13_1 ~= -1 then
				return (self:GetPlaceHolderMgr():GetEntity(var_13_1):GetSkinEntityId())
			end

			return -1
		end
	end,
	IsFreeCapture = function(self)
		return self.luaContext.isFreeCapture
	end,
	HideAllNoNeed = function(self, arg_15_1)
		if not self:IsSingleMode() then
			self:GetPlaceHolderMgr():HideAll(arg_15_1)
		end
	end,
	GetCurSectionHeroList = function(self)
		return CaptureGameTools:GetCaptureHeroList(self.luaContext.mainStageId)
	end,
	GetCurUsingHeroList = function(self)
		local var_17_0 = {}

		if self:IsSingleMode() then
			table.insert(var_17_0, self.luaContext.singleSkinId)
		else
			var_17_0 = self:GetPlaceHolderMgr():GetAllUsingSkin()
		end

		return var_17_0
	end,
	GetCurUsingHeroPoseList = function(self)
		local var_18_0 = {}

		if self:IsSingleMode() then
			table.insert(var_18_0, CaptureGameMgr:GetEntityMgr():QueryRole(self.luaContext.singleSkinId):GetCurrentAnimation())
		else
			var_18_0 = self:GetPlaceHolderMgr():GetAllUsingSkinPose()
		end

		return var_18_0
	end,
	GetMainActivityId = function(self)
		return self.luaContext.mainStageId
	end,
	AlreadyPrepare = function(self)
		return self.luaContext.prepareComplete
	end,
	GetMultiVirtualCamera = function(self)
		return self.runtimeContext.multiCaptureCamera
	end,
	GetPlaceHolderMgr = function(self)
		return self.luaSystem.placeHolderMgr
	end,
	SwitchSkin = function(self, arg_23_1, arg_23_2)
		self:GetPlaceHolderMgr():SwitchSkin(arg_23_1, arg_23_2)
	end,
	StartEntityMgr = function(self)
		self.system.entityMgr = EntityMgr.New()

		self.system.entityMgr:Init()
		self.system.entityMgr:Start()
	end,
	StopEntityMgr = function(self)
		if self.system.entityMgr ~= nil then
			self.system.entityMgr:Stop()

			self.system.entityMgr = nil
		end
	end,
	GetEntityMgr = function(self)
		return self.system.entityMgr
	end,
	StartTaskMgr = function(self)
		self.system.taskMgr = CaptureTaskMgr.New()

		self.system.taskMgr:Start()
	end,
	StopTaskMgr = function(self)
		if self.system.taskMgr ~= nil then
			self.system.taskMgr:Stop()

			self.system.taskMgr = nil
		end
	end,
	ExecuteTaskMgr = function(self)
		if self.system.taskMgr then
			self.system.taskMgr:ExecuteTask()
		end
	end,
	GetTaskMgr = function(self)
		return self.system.taskMgr
	end,
	StartCameraMgr = function(self, arg_31_1)
		self.system.cameraMgr = CaptureCameraMgr.New()

		self.system.cameraMgr:SetController(arg_31_1)
		self.system.cameraMgr:Start()
	end,
	StopCameraMgr = function(self)
		if self.system.cameraMgr ~= nil then
			self.system.cameraMgr:Stop()

			self.system.cameraMgr = nil
		end
	end,
	GetCameraMgr = function(self)
		return self.system.cameraMgr
	end,
	OpenSettingPanel = function(self, arg_34_1)
		if arg_34_1 == self.luaContext.isInFocus then
			return
		end

		if arg_34_1 then
			self.system.cameraMgr:PauseMainCamera(true)

			if not self:IsSingleMode() then
				self.luaSystem.placeHolderMgr:FocusCurrentSelect(true)
			end

			manager.notify:Invoke(CAPTURE_GAME_OPEN_SETTING_PANEL)
			JumpTools.OpenPageByJump("captureSettingView")
		else
			self.system.cameraMgr:PauseMainCamera(false)

			if not self:IsSingleMode() then
				self.luaSystem.placeHolderMgr:FocusCurrentSelect(false)
			end

			manager.notify:Invoke(CAPTURE_GAME_CLOSE_SETTING_PANEL)
		end

		self.luaContext.isInFocus = arg_34_1
	end
}
