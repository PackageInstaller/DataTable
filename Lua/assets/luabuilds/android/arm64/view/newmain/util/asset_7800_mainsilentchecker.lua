local MainSilentChecker = class("MainSilentChecker", import("view.base.BaseEventLogic"))

function MainSilentChecker:Ctor(arg_1_1)
	MainSilentChecker.super.Ctor(self, arg_1_1)

	self._silentRunFlag = true

	return
end

function MainSilentChecker:SetUp()
	self:Clear()

	self.inactivityTimeout = SettingsMainScenePanel.GetEnterFlagShipTime()
	self.lastActivityTime = Time.time
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	self.isFoldState = false

	self:bind(NewMainScene.FOLD, function(arg_3_0, arg_3_1)
		self.isFoldState = arg_3_1

		return
	end)

	return
end

function MainSilentChecker:Update()
	if IsUnityEditor then
		if Input.anyKeyDown then
			self.lastActivityTime = Time.time
		end
	elseif Input.touchCount > 0 then
		self.lastActivityTime = Time.time
	end

	if Time.time - self.lastActivityTime > self.inactivityTimeout then
		self:EnterState()
	end

	return
end

function MainSilentChecker:EnterState()
	if self:AnyOverlayShowing() then
		self.lastActivityTime = Time.time

		return
	end

	if self._silentRunFlag then
		self:Clear()
		self:emit(NewMainScene.ENTER_SILENT_VIEW)
	end

	return
end

function MainSilentChecker:AnyOverlayShowing()
	local var_6_0 = getProxy(ContextProxy)
	local var_6_1 = pg.NewStoryMgr.GetInstance().IsRunning(var_6_0)

	if not var_6_1 then
		var_6_1 = pg.NewGuideMgr.GetInstance():IsBusy()

		if not var_6_1 then
			var_6_1 = isActive(pg.MsgboxMgr.GetInstance()._tf)

			if not var_6_1 then
				var_6_1 = var_6_0:getCurrentContext():hasChild()
				var_6_1 = var_6_1 or pg.LayerWeightMgr.GetInstance().uiOrigin.childCount > 0 or self.isFoldState
			end
		end
	end

	return var_6_1
end

function MainSilentChecker:Clear()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)

		self.handle = nil
	end

	self:disposeEvent()

	self.isFoldState = false

	return
end

function MainSilentChecker:Disable()
	self:Clear()

	return
end

function MainSilentChecker:SetSilentRun(arg_9_1)
	self._silentRunFlag = arg_9_1

	return
end

function MainSilentChecker:Dispose()
	self:Disable()

	return
end

return MainSilentChecker
