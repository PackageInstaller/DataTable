local WorldScene = class("WorldScene", import("..base.BaseUI"))

WorldScene.SceneOp = "WorldScene.SceneOp"
WorldScene.Listeners = {
	onAchievementAchieved = "OnAchievementAchieved",
	onUpdateSubmarineSupport = "OnUpdateSubmarineSupport",
	onSelectFleet = "OnSelectFleet",
	onUpdateEventTips = "OnUpdateEventTips",
	onFleetSelected = "OnFleetSelected",
	onModelSelectMap = "OnModelSelectMap",
	onClearMoveQueue = "ClearMoveQueue",
	onUpdateProgress = "OnUpdateProgress",
	onUpdateScale = "OnUpdateScale",
	onUpdateDaily = "OnUpdateDaily",
	onDisposeMap = "OnDisposeMap",
	onUpdateRound = "OnUpdateRound"
}
WorldScene.optionsPath = {
	"top/adapt/top_chapter/option",
	"top/adapt/top_stage/option"
}

function WorldScene:forceGC()
	return true
end

function WorldScene:getUIName()
	return "WorldUI"
end

function WorldScene:getBGM()
	local var_3_0 = {}

	if self:GetInMap() == false then
		-- block empty
	else
		local var_3_1 = nowWorld():GetActiveMap():GetBGM()

		var_3_1 = var_3_1 or ""

		table.insert(var_3_0, var_3_1)
	end

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if iter_3_1 ~= "" then
			return iter_3_1
		end
	end

	return WorldScene.super.getBGM(self)
end

function WorldScene:init()
	for iter_4_0, iter_4_1 in pairs(WorldScene.Listeners) do
		self[iter_4_0] = function(...)
			WorldScene[iter_4_1](self, ...)

			return
		end
	end

	self:bind(WorldScene.SceneOp, function(arg_6_0, ...)
		self:Op(...)

		return
	end)

	self.camera = pg.UIMgr.GetInstance().levelCamera:GetComponent(typeof(Camera))
	self.rtUIMain = pg.UIMgr.GetInstance().LevelMain

	setActive(self.rtUIMain, false)

	self.rtGrid = self.rtUIMain:Find("LevelGrid")

	setActive(self.rtGrid, true)

	self.rtDragLayer = self.rtGrid:Find("DragLayer")
	self.rtEnvBG = self._tf:Find("main/bg")
	self.rtTop = self._tf:Find("top")
	self.rtTopAtlas = self.rtTop:Find("adapt/top_chapter")

	setActive(self.rtTopAtlas, false)

	self.rtRightAtlas = self.rtTop:Find("adapt/right_chapter")

	setActive(self.rtRightAtlas, false)

	self.rtBottomAtlas = self.rtTop:Find("adapt/bottom_chapter")

	setActive(self.rtBottomAtlas, false)

	self.rtTransportAtlas = self.rtTop:Find("transport_chapter")

	setActive(self.rtTransportAtlas, false)

	self.rtTopMap = self.rtTop:Find("adapt/top_stage")

	setActive(self.rtTopMap, false)

	self.rtLeftMap = self.rtTop:Find("adapt/left_stage")

	setActive(self.rtLeftMap, false)

	self.rtRightMap = self.rtTop:Find("adapt/right_stage")

	setActive(self.rtRightMap, false)

	self.rtOutMap = self.rtTop:Find("effect_stage")

	setActive(self.rtOutMap, false)

	self.rtClickStop = self.rtTop:Find("stop_click")

	onButton(self, self.rtClickStop:Find("long_move"), function()
		if #self.moveQueue > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_fleet_stop"))
			self:ClearMoveQueue()
		end

		return
	end)
	onButton(self, self.rtClickStop:Find("auto_fight"), function()
		local var_8_0 = nowWorld()

		if var_8_0.isAutoFight then
			pg.TipsMgr.GetInstance():ShowTips(i18n("autofight_tip_bigworld_stop"))
			var_8_0:TriggerAutoFight(false)
		else
			assert(false, "stop clicker shouldn't active")
		end

		return
	end)
	setActive(self.rtClickStop, false)

	self.resAtlas = WorldResource.New()

	self.resAtlas:setParent(self.rtTopAtlas:Find("resources"), false)

	self.resMap = WorldResource.New()

	self.resMap:setParent(self.rtTopMap:Find("resources"), false)

	self.wsPool = WSPool.New()

	self.wsPool:Setup(self._tf:Find("resources"))

	self.wsAnim = WSAnim.New()

	self.wsAnim:Setup()

	self.wsTimer = WSTimer.New()

	self.wsTimer:Setup()

	self.wsDragProxy = WSDragProxy.New()
	self.wsDragProxy.transform = self.rtDragLayer
	self.wsDragProxy.wsTimer = self.wsTimer

	self.wsDragProxy:Setup({
		clickCall = function(arg_9_0, arg_9_1)
			if self.svScannerPanel:isShowing() then
				local var_9_0, var_9_1 = self:CheckScannerEnable(self:ScreenPos2MapPos(arg_9_1.position))

				if var_9_0 then
					self.svScannerPanel:ActionInvoke("DisplayWindow", var_9_0, var_9_1)
				else
					self.svScannerPanel:ActionInvoke("HideWindow")
				end
			else
				self:OnClickMap(self:ScreenPos2MapPos(arg_9_1.position))
			end

			return
		end,
		longPressCall = function()
			self:OnLongPressMap(self:ScreenPos2MapPos(Vector3(Input.mousePosition.x, Input.mousePosition.y)))

			return
		end
	})

	self.wsMapCamera = WSMapCamera.New()
	self.wsMapCamera.camera = self.camera

	self.wsMapCamera:Setup()
	self:InitSubView()
	self:AddWorldListener()

	self.moveQueue = {}
	self.achievedList = {}
	self.mapOps = {}
	self.wsCommands = {}

	WSCommand.Bind(self)
	self:OpOpen()

	return
end

function WorldScene:InitSubView()
	self.rtPanelList = self._tf:Find("panel_list")
	self.svOrderPanel = SVOrderPanel.New(self.rtPanelList, self.event, {
		wsPool = self.wsPool
	})
	self.svScannerPanel = SVScannerPanel.New(self.rtPanelList, self.event)

	self:bind(SVScannerPanel.ShowView, function(arg_12_0)
		self.wsMap:ShowScannerMap(true)
		setActive(self.wsMap.rtTop, false)
		self:HideMapUI()

		return
	end)
	self:bind(SVScannerPanel.HideView, function(arg_13_0)
		self.wsMap:ShowScannerMap(false)
		setActive(self.wsMap.rtTop, true)
		self:DisplayMapUI()

		return
	end)
	self:bind(SVScannerPanel.HideGoing, function(arg_14_0, arg_14_1, arg_14_2)
		self.wsMap:ShowScannerMap(false)
		setActive(self.wsMap.rtTop, true)
		self:DisplayMapUI()
		self:OnClickCell(arg_14_1, arg_14_2)

		return
	end)

	self.svRealmPanel = SVRealmPanel.New(self.rtPanelList, self.event)
	self.svAchievement = SVAchievement.New(self.rtPanelList, self.event)

	self:bind(SVAchievement.HideView, function(arg_15_0)
		table.remove(self.achievedList, 1)

		return (#self.achievedList > 0 and function()
			self:ShowSubView("Achievement", self.achievedList[1])

			return
		end or function()
			self:Op("OpInteractive")

			return
		end)()
	end)

	self.svDebugPanel = SVDebugPanel.New(self.rtPanelList, self.event)
	self.svFloatPanel = SVFloatPanel.New(self.rtTop, self.event)

	self:bind(SVFloatPanel.ReturnCall, function(arg_18_0, arg_18_1)
		self:Op("OpCall", function(arg_19_0)
			arg_19_0()

			local var_19_0 = nowWorld():GetActiveEntrance()

			if arg_18_1.id == var_19_0.id then
				self.wsAtlas:UpdateSelect()
				self.wsAtlas:UpdateSelect(arg_18_1)
			else
				self:ClickAtlas(var_19_0)
			end

			return
		end)

		return
	end)

	self.svPoisonPanel = SVPoisonPanel.New(self.rtPanelList, self.event)
	self.svGlobalBuff = SVGlobalBuff.New(self.rtPanelList, self.event)

	self:bind(SVGlobalBuff.HideView, function(arg_20_0, arg_20_1)
		return existCall(arg_20_1)
	end)

	self.svBossProgress = SVBossProgress.New(self.rtPanelList, self.event)

	self:bind(SVBossProgress.HideView, function(arg_21_0, arg_21_1)
		return existCall(arg_21_1)
	end)

	self.svSalvageResult = SVSalvageResult.New(self.rtPanelList, self.event)

	return
end

function WorldScene:didEnter()
	self:OverlayPanel(self.rtTop)

	self.warningSairen = not self.contextData.inSave

	if self.contextData.inWorld then
		self:Op("OpSetInMap", false, function()
			self.wsAtlas:UpdateSelect(nowWorld():GetActiveEntrance())

			return
		end)
	else
		self:Op("OpSetInMap", true)
	end

	return
end

function WorldScene:onBackPressed()
	if self.inCutIn then
		return
	elseif self.svDebugPanel:isShowing() then
		self:HideSubView("DebugPanel")
	elseif self.svAchievement:isShowing() then
		self:HideSubView("Achievement")
	elseif self.svGlobalBuff:isShowing() then
		self:HideSubView("GlobalBuff")
	elseif self.svBossProgress:isShowing() then
		self:HideSubView("BossProgress")
	elseif self.svOrderPanel:isShowing() then
		self:HideSubView("OrderPanel")
	elseif self.svScannerPanel:isShowing() then
		self:HideSubView("ScannerPanel")
	elseif self.svPoisonPanel:isShowing() then
		self:HideSubView("PoisonPanel")
	elseif self.svSalvageResult:isShowing() then
		self:HideSubView("SalvageResult")
	elseif self.wsMapLeft and isActive(self.wsMapLeft.toggleMask) then
		self.wsMapLeft:HideToggleMask()
	elseif self:GetInMap() then
		triggerButton(self.wsMapTop.btnBack)
	else
		triggerButton(self.rtTopAtlas:Find("back_button"))
	end

	return
end

function WorldScene:quickExitFunc()
	self:Op("OpCall", function(arg_26_0)
		arg_26_0()

		local var_26_0 = {}

		if nowWorld():CheckReset() then
			table.insert(var_26_0, function(arg_27_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("world_recycle_notice"),
					onYes = arg_27_0
				})

				return
			end)
		end

		seriesAsync(var_26_0, function()
			WorldScene.super.quickExitFunc(self)

			return
		end)

		return
	end)

	return
end

function WorldScene:ExitWorld(arg_29_1, arg_29_2)
	local var_29_0 = {}

	if not arg_29_2 then
		table.insert(var_29_0, function(arg_30_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("world_exit_tip"),
				onYes = arg_30_0,
				onNo = function()
					return existCall(arg_29_1)
				end
			})

			return
		end)
	end

	if not arg_29_2 then
		if nowWorld():CheckReset() then
			table.insert(var_29_0, function(arg_32_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("world_recycle_notice"),
					onYes = arg_32_0,
					onNo = function()
						return existCall(arg_29_1)
					end
				})

				return
			end)
		end
	end

	table.insert(var_29_0, function(arg_34_0)
		if self:GetInMap() then
			self:EaseOutMapUI(arg_34_0)
		else
			self:EaseOutAtlasUI(arg_34_0)
		end

		return
	end)
	seriesAsync(var_29_0, function()
		existCall(arg_29_1)
		self:closeView()

		return
	end)

	return
end

function WorldScene:SaveState()
	self.contextData.inSave = true
	self.contextData.inWorld = self:GetInMap() == false
	self.contextData.inShop = false
	self.contextData.inPort = false

	return
end

function WorldScene:willExit()
	self:SaveState()
	self:RemoveWorldListener()
	self:UnOverlayPanel(self.rtTop, self._tf)
	self.svOrderPanel:Destroy()
	self.svScannerPanel:Destroy()
	self.svAchievement:Destroy()
	self.svRealmPanel:Destroy()
	self.svDebugPanel:Destroy()
	self.svFloatPanel:Destroy()
	self.svPoisonPanel:Destroy()
	self.svGlobalBuff:Destroy()
	self.svBossProgress:Destroy()
	self:DisposeAtlas()
	self:DisposeAtlasUI()
	self:DisposeMap()
	self:DisposeMapUI()
	self.wsPool:Dispose()

	self.wsPool = nil

	self.wsAnim:Dispose()

	self.wsAnim = nil

	self.wsTimer:Dispose()

	self.wsTimer = nil

	self.wsDragProxy:Dispose()

	self.wsDragProxy = nil

	self.wsMapCamera:Dispose()

	self.wsMapCamera = nil

	self.resAtlas:exit()

	self.resAtlas = nil

	self.resMap:exit()

	self.resMap = nil

	self:VerifyMapOp()
	self:OpDispose()
	WSCommand.Unbind(self)
	WBank:Recycle(WorldMapOp)

	return
end

function WorldScene:SetPlayer(arg_38_1)
	self.player = arg_38_1

	self.resAtlas:setPlayer(self.player)
	self.resMap:setPlayer(self.player)

	return
end

function WorldScene:AddWorldListener()
	local var_39_0 = nowWorld()

	var_39_0:AddListener(World.EventUpdateProgress, self.onUpdateProgress)
	var_39_0:GetTaskProxy():AddListener(WorldTaskProxy.EventUpdateDailyTaskIds, self.onUpdateDaily)

	return
end

function WorldScene:RemoveWorldListener()
	local var_40_0 = nowWorld()

	var_40_0:RemoveListener(World.EventUpdateProgress, self.onUpdateProgress)
	var_40_0:GetTaskProxy():RemoveListener(WorldTaskProxy.EventUpdateDailyTaskIds, self.onUpdateDaily)

	return
end

function WorldScene:SetInMap(arg_41_1, arg_41_2)
	if arg_41_1 then
		arg_41_2 = defaultValue(arg_41_2, function()
			self:Op("OpInteractive")

			return
		end)
	end

	if self.inMap == arg_41_1 then
		return existCall(arg_41_2)
	end

	local var_41_0 = {}
	local var_41_1 = {}

	self:StopAnim()

	if self.inMap then
		table.insert(var_41_0, function(arg_43_0)
			self:Op("OpSwitchOutMap", arg_43_0)

			return
		end)
	elseif self.inMap ~= nil then
		table.insert(var_41_0, function(arg_44_0)
			self:Op("OpSwitchOutWorld", arg_44_0)

			return
		end)
	end

	table.insert(var_41_0, function(arg_45_0)
		self:Op("OpCall", function(arg_46_0)
			parallelAsync(var_41_1, function()
				arg_46_0()

				return arg_45_0()
			end)

			return
		end)

		return
	end)
	table.insert(var_41_1, function(arg_48_0)
		self:DisplayEnv(arg_48_0)

		return
	end)

	if arg_41_1 then
		table.insert(var_41_1, function(arg_49_0)
			self:LoadMap(nowWorld():GetActiveMap(), arg_49_0)

			return
		end)
		table.insert(var_41_0, function(arg_50_0)
			self:Op("OpSwitchInMap", arg_50_0)

			return
		end)
	else
		table.insert(var_41_1, function(arg_51_0)
			self:LoadAtlas(arg_51_0)

			return
		end)
		table.insert(var_41_0, function(arg_52_0)
			self:Op("OpSwitchInWorld", arg_52_0)

			return
		end)
	end

	table.insert(var_41_0, function(arg_53_0)
		self:PlayBGM()
		arg_53_0()

		return
	end)

	self.inMap = arg_41_1

	seriesAsync(var_41_0, arg_41_2)

	return
end

function WorldScene:GetInMap()
	return self.inMap
end

function WorldScene:ShowSubView(arg_55_1, arg_55_2, arg_55_3)
	self["sv" .. arg_55_1]:Load()
	self["sv" .. arg_55_1]:ActionInvoke("Setup", unpack(arg_55_2 or {}))
	self["sv" .. arg_55_1]:ActionInvoke("Show", unpack(arg_55_3 or {}))

	return
end

function WorldScene:HideSubView(arg_56_1, ...)
	self["sv" .. arg_56_1]:ActionInvoke("Hide", ...)

	return
end

function WorldScene:DisplayAtlasUI()
	self:DisplayAtlasTop()
	self:DisplayAtlasRight()
	self:DisplayAtlasBottom()
	self:UpdateSystemOpen()

	return
end

function WorldScene:HideAtlasUI()
	self:HideAtlasTop()
	self:HideAtlasRight()
	self:HideAtlasBottom()

	return
end

function WorldScene:EaseInAtlasUI(arg_59_1)
	self:CancelAtlasUITween()
	parallelAsync({
		function(arg_60_0)
			setAnchoredPosition(self.rtTopAtlas, {
				y = self.rtTopAtlas.rect.height
			})
			self.wsTimer:AddTween(LeanTween.moveY(self.rtTopAtlas, 0, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeInSine):setOnComplete(System.Action(arg_60_0)).uniqueId)

			return
		end,
		function(arg_61_0)
			setAnchoredPosition(self.rtBottomAtlas, {
				y = -self.rtBottomAtlas.rect.height
			})
			self.wsTimer:AddTween(LeanTween.moveY(self.rtBottomAtlas, 0, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeInSine):setOnComplete(System.Action(arg_61_0)).uniqueId)

			return
		end,
		function(arg_62_0)
			setAnchoredPosition(self.rtRightAtlas, {
				x = self.rtRightAtlas.rect.width
			})
			self.wsTimer:AddTween(LeanTween.moveX(self.rtRightAtlas, 0, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeInSine):setOnComplete(System.Action(arg_62_0)).uniqueId)

			return
		end
	}, function()
		return existCall(arg_59_1)
	end)

	return
end

function WorldScene:EaseOutAtlasUI(arg_64_1)
	self:CancelAtlasUITween()
	parallelAsync({
		function(arg_65_0)
			setAnchoredPosition(self.rtTopAtlas, {
				y = 0
			})
			self.wsTimer:AddTween(LeanTween.moveY(self.rtTopAtlas, self.rtTopAtlas.rect.height, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(arg_65_0)).uniqueId)

			return
		end,
		function(arg_66_0)
			setAnchoredPosition(self.rtBottomAtlas, {
				y = 0
			})
			self.wsTimer:AddTween(LeanTween.moveY(self.rtBottomAtlas, -self.rtBottomAtlas.rect.height, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(arg_66_0)).uniqueId)

			return
		end,
		function(arg_67_0)
			setAnchoredPosition(self.rtRightAtlas, {
				x = 0
			})
			self.wsTimer:AddTween(LeanTween.moveX(self.rtRightAtlas, self.rtRightAtlas.rect.width, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(arg_67_0)).uniqueId)

			return
		end
	}, function()
		return existCall(arg_64_1)
	end)

	return
end

function WorldScene:CancelAtlasUITween()
	LeanTween.cancel(go(self.rtTransportAtlas))
	LeanTween.cancel(go(self.rtTopAtlas))
	LeanTween.cancel(go(self.rtBottomAtlas))
	LeanTween.cancel(go(self.rtRightAtlas))

	return
end

function WorldScene:DisposeAtlasUI()
	self:HideAtlasUI()
	self:DisposeAtlasTransport()
	self:DisposeAtlasTop()
	self:DisposeAtlasRight()
	self:DisposeAtlasBottom()

	return
end

function WorldScene:DisplayAtlas()
	self.wsAtlas:SwitchArea(nowWorld():GetActiveEntrance():GetAreaId())
	self.wsAtlas:UpdateActiveMark()
	self.wsAtlas:ShowOrHide(true)

	return
end

function WorldScene:HideAtlas()
	self.wsAtlas:UpdateSelect()
	self.wsAtlas:ShowOrHide(false)

	return
end

function WorldScene:ClickAtlas(arg_73_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

	local var_73_0 = arg_73_1:GetAreaId()

	if not nowWorld():CheckAreaUnlock(var_73_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("area_lock"))

		return
	end

	if self.wsAtlas.nowArea then
		self.wsAtlas:UpdateSelect()

		if self.wsAtlas.selectEntrance ~= arg_73_1 then
			self.wsAtlas:UpdateSelect(arg_73_1)
		end
	else
		self:EnterToModelMap(var_73_0)
	end

	return
end

function WorldScene:LoadAtlas(arg_74_1)
	local var_74_0 = {}

	if not self.wsAtlas then
		table.insert(var_74_0, function(arg_75_0)
			self.wsAtlas = self:NewAtlas()

			self.wsAtlas:LoadScene(function()
				self.wsAtlas:AddListener(WSAtlasWorld.EventUpdateselectEntrance, self.onModelSelectMap)
				self.wsAtlas:UpdateAtlas(nowWorld():GetAtlas())

				return arg_75_0()
			end)

			return
		end)
	end

	seriesAsync(var_74_0, arg_74_1)

	return
end

function WorldScene:NewAtlas()
	local var_77_0 = WSAtlasWorld.New()

	var_77_0.wsTimer = self.wsTimer

	function var_77_0.onClickColor(arg_78_0, arg_78_1)
		if self.wsAtlas:CheckIsTweening() then
			return
		end

		self:Op("OpCall", function(arg_79_0)
			arg_79_0()
			self:ClickAtlas(arg_78_0)

			return
		end)

		return
	end

	var_77_0:Setup()

	return var_77_0
end

function WorldScene:DisposeAtlas()
	if self.wsAtlas then
		self:HideAtlas()
		self.wsAtlas:RemoveListener(WSAtlasWorld.EventUpdateselectEntrance, self.onModelSelectMap)
		self.wsAtlas:Dispose()

		self.wsAtlas = nil
	end

	return
end

function WorldScene:DisplayAtlasTop()
	self.wsAtlasTop = self.wsAtlasTop or self:NewAtlasTop(self.rtTopAtlas)

	setActive(self.rtTopAtlas, true)
	setActive(self.rtTopAtlas:Find("print/title_world"), true)
	setActive(self.rtTopAtlas:Find("print/title_view"), false)
	setActive(self.rtTopAtlas:Find("sairen_warning"), self.warningSairen and #nowWorld():GetAtlas().sairenEntranceList > 0)

	self.warningSairen = false

	return
end

function WorldScene:HideAtlasTop()
	setActive(self.rtTopAtlas, false)

	return
end

function WorldScene:NewAtlasTop(arg_83_1)
	onButton(self, arg_83_1:Find("back_button"), function()
		self:Op("OpCall", function(arg_85_0)
			arg_85_0()
			self:BackToMap()

			return
		end)

		return
	end, SFX_CANCEL)

	return {
		transform = arg_83_1
	}
end

function WorldScene:DisposeAtlasTop()
	self.wsAtlasTop = nil

	return
end

function WorldScene:DisplayAtlasRight()
	self.wsAtlasRight = self.wsAtlasRight or self:NewAtlasRight(self.rtRightAtlas)

	self.wsAtlasRight:SetOverSize(self.rtTop:Find("adapt").offsetMax.x)
	setActive(self.rtRightAtlas, true)

	return
end

function WorldScene:HideAtlasRight()
	setActive(self.rtRightAtlas, false)

	return
end

function WorldScene:NewAtlasRight(arg_89_1, arg_89_2)
	local var_89_0 = WSAtlasRight.New()

	var_89_0.transform = arg_89_1

	var_89_0:Setup()
	onButton(self, var_89_0.btnSettings, function()
		self:Op("OpOpenScene", SCENE.SETTINGS, {
			scroll = "world_settings",
			page = NewSettingsScene.PAGE_OPTION
		})

		return
	end, SFX_PANEL)
	onButton(self, var_89_0.btnSwitch, function()
		self:Op("OpOpenLayer", Context.New({
			mediator = WorldSwitchPlanningMediator,
			viewComponent = WorldSwitchPlanningLayer
		}))

		return
	end, SFX_CONFIRM)

	return var_89_0
end

function WorldScene:DisposeAtlasRight()
	if self.wsAtlasRight then
		self.wsAtlasRight:Dispose()

		self.wsAtlasRight = nil
	end

	return
end

function WorldScene:DisplayAtlasBottom()
	self.wsAtlasBottom = self.wsAtlasBottom or self:NewAtlasBottom(self.rtBottomAtlas)

	self.wsAtlasBottom:SetOverSize(self.rtTop:Find("adapt").offsetMax.x)
	self.wsAtlasBottom:UpdateScale(1)
	setActive(self.rtBottomAtlas, true)
	setActive(self.wsAtlasBottom.btnDailyTask:Find("tip"), nowWorld():GetTaskProxy():canAcceptDailyTask())

	return
end

function WorldScene:HideAtlasBottom()
	setActive(self.rtBottomAtlas, false)

	return
end

function WorldScene:NewAtlasBottom(arg_95_1)
	local var_95_0 = WSAtlasBottom.New()

	var_95_0.transform = arg_95_1
	var_95_0.wsTimer = self.wsTimer

	var_95_0:Setup()

	if CAMERA_MOVE_OPEN then
		var_95_0:AddListener(WSAtlasBottom.EventUpdateScale, self.onUpdateScale)
	end

	onButton(self, var_95_0.btnOverview, function()
		if self.wsAtlas:CheckIsTweening() then
			return
		end

		self:Op("OpCall", function(arg_97_0)
			self.wsAtlas:LoadModel(function()
				arg_97_0()
				self:ReturnToModelArea()

				return
			end)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, var_95_0.btnBoss, function()
		if nowWorld():GetBossProxy():IsOpen() then
			self:Op("OpOpenScene", SCENE.WORLDBOSS)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)
	onButton(self, var_95_0.btnShop, function()
		self:Op("OpOpenLayer", Context.New({
			mediator = WorldShopMediator,
			viewComponent = WorldShopLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, var_95_0.btnCollection, function()
		self:Op("OpOpenScene", SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_RECORD
		})

		return
	end, SFX_PANEL)
	onButton(self, var_95_0.btnDailyTask, function()
		local var_102_0 = nowWorld()

		if var_102_0:IsSystemOpen(WorldConst.SystemDailyTask) then
			var_102_0:GetTaskProxy():checkDailyTask(function()
				self:Op("OpOpenLayer", Context.New({
					mediator = WorldDailyTaskMediator,
					viewComponent = WorldDailyTaskLayer
				}))

				return
			end)
		else
			pg.TipsMgr.GetInstance(i18n("world_daily_task_lock"))
		end

		return
	end, SFX_PANEL)

	return var_95_0
end

function WorldScene:DisposeAtlasBottom()
	if self.wsAtlasBottom then
		self.wsAtlasBottom:Dispose()

		self.wsAtlasBottom = nil
	end

	return
end

function WorldScene:DisplayAtlasTransport()
	self.wsAtlasTransport = self.wsAtlasTransport or self:NewAtlasTransport(self.rtTransportAtlas)

	setActive(self.rtTransportAtlas, true)

	return
end

function WorldScene:HideAtlasTransport()
	setActive(self.rtTransportAtlas, false)

	return
end

function WorldScene:NewAtlasTransport(arg_107_1)
	local var_107_0 = {
		transform = arg_107_1,
		btnBack = arg_107_1:Find("adapt/btn_back")
	}

	onButton(self, var_107_0.btnBack, function()
		assert(self.inTransportMode, "this isn't transport mode atlas")
		self:BackToMap()

		return
	end, SFX_CANCEL)

	return var_107_0
end

function WorldScene:DisposeAtlasTransport()
	self.wsAtlasTransport = nil

	return
end

function WorldScene:DisplayMapUI()
	self:DisplayMapTop()
	self:DisplayMapLeft()
	self:DisplayMapRight()
	self:DisplayMapOut()
	self:UpdateSystemOpen()

	return
end

function WorldScene:HideMapUI()
	self:HideMapTop()
	self:HideMapLeft()
	self:HideMapRight()
	self:HideMapOut()

	return
end

function WorldScene:UpdateMapUI()
	local var_112_0 = nowWorld()
	local var_112_1 = var_112_0:GetActiveEntrance()
	local var_112_2 = var_112_0:GetActiveMap()

	self.wsMapTop:Update(var_112_1, var_112_2)
	self.wsMapLeft:UpdateMap(var_112_2)
	self.wsMapRight:Update(var_112_1, var_112_2)
	self.wsMapOut:UpdateMap(var_112_2)

	return
end

function WorldScene:EaseInMapUI(arg_113_1)
	self:CancelMapUITween()
	parallelAsync({
		function(arg_114_0)
			setAnchoredPosition(self.rtTopMap, {
				y = self.rtTopMap.rect.height
			})
			self.wsTimer:AddTween(LeanTween.moveY(self.rtTopMap, 0, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeInSine):setOnComplete(System.Action(arg_114_0)).uniqueId)

			return
		end,
		function(arg_115_0)
			setAnchoredPosition(self.rtLeftMap, {
				x = -self.rtLeftMap.rect.width
			})
			self.wsTimer:AddTween(LeanTween.moveX(self.rtLeftMap, 0, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeInSine):setOnComplete(System.Action(arg_115_0)).uniqueId)

			return
		end,
		function(arg_116_0)
			setAnchoredPosition(self.rtRightMap, {
				x = self.rtRightMap.rect.width
			})
			self.wsTimer:AddTween(LeanTween.moveX(self.rtRightMap, 0, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeInSine):setOnComplete(System.Action(arg_116_0)).uniqueId)

			return
		end
	}, function()
		return existCall(arg_113_1)
	end)

	return
end

function WorldScene:EaseOutMapUI(arg_118_1)
	self:CancelMapUITween()
	parallelAsync({
		function(arg_119_0)
			setAnchoredPosition(self.rtTopMap, {
				y = 0
			})
			self.wsTimer:AddTween(LeanTween.moveY(self.rtTopMap, self.rtTopMap.rect.height, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(arg_119_0)).uniqueId)

			return
		end,
		function(arg_120_0)
			setAnchoredPosition(self.rtLeftMap, {
				x = 0
			})
			self.wsTimer:AddTween(LeanTween.moveX(self.rtLeftMap, -self.rtLeftMap.rect.width, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(arg_120_0)).uniqueId)

			return
		end,
		function(arg_121_0)
			setAnchoredPosition(self.rtRightMap, {
				x = 0
			})
			self.wsTimer:AddTween(LeanTween.moveX(self.rtRightMap, self.rtRightMap.rect.width, WorldConst.UIEaseFasterDuration):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(arg_121_0)).uniqueId)

			return
		end
	}, function()
		return existCall(arg_118_1)
	end)

	return
end

function WorldScene:CancelMapUITween()
	LeanTween.cancel(go(self.rtTopMap))
	LeanTween.cancel(go(self.rtLeftMap))
	LeanTween.cancel(go(self.rtRightMap))

	return
end

function WorldScene:DisposeMapUI()
	self:DisposeMapTop()
	self:DisposeMapLeft()
	self:DisposeMapRight()
	self:DisposeMapOut()

	return
end

function WorldScene:DisplayMap()
	setActive(self.rtUIMain, true)

	return
end

function WorldScene:HideMap()
	setActive(self.rtUIMain, false)

	return
end

function WorldScene:ShowMargin(arg_127_1)
	if self.wsMap then
		self.wsMap:UpdateTransportDisplay(arg_127_1)
	end

	return
end

function WorldScene:LoadMap(arg_128_1, arg_128_2)
	assert(arg_128_1, "target map not exist.")

	local var_128_0 = {}

	if not arg_128_1:IsValid() then
		table.insert(var_128_0, function(arg_129_0)
			self:emit(WorldMediator.OnMapReq, arg_128_1.id, arg_129_0)

			return
		end)
	end

	seriesAsync(var_128_0, function()
		if self.wsMap then
			return existCall(arg_128_2)
		else
			arg_128_1:AddListener(WorldMap.EventUpdateActive, self.onDisposeMap)
			arg_128_1:AddListener(WorldMap.EventUpdateMoveSpeed, self.onClearMoveQueue)

			self.wsMap = self:NewMap(arg_128_1)

			self.wsMap:Load(function()
				self.wsMap.transform:SetParent(self.rtDragLayer, false)
				setActive(self.wsMap.transform, true)
				self:InitMap()

				return existCall(arg_128_2)
			end)
		end

		return
	end)

	return
end

function WorldScene:InitMap()
	for iter_132_0, iter_132_1 in ipairs(self.wsMap.wsMapFleets) do
		onButton(self, iter_132_1.rtRetreat, function()
			self:Op("OpReqRetreat", iter_132_1.fleet)

			return
		end, SFX_PANEL)
		iter_132_1:AddListener(WSMapFleet.EventUpdateSelected, self.onFleetSelected)
	end

	self.wsMap:AddListener(WSMap.EventUpdateEventTips, self.onUpdateEventTips)

	local var_132_0 = nowWorld()

	var_132_0:AddListener(World.EventUpdateSubmarineSupport, self.onUpdateSubmarineSupport)
	var_132_0:AddListener(World.EventAchieved, self.onAchievementAchieved)
	self.wsDragProxy:UpdateMap(self.wsMap.map)
	self.wsDragProxy:Focus(self.wsMap:GetFleet().transform.position)
	self.wsMapCamera:UpdateMap(self.wsMap.map)
	self:OnUpdateSubmarineSupport()

	return
end

function WorldScene:NewMap(arg_134_1)
	local var_134_0 = WSMap.New()

	var_134_0.wsPool = self.wsPool
	var_134_0.wsTimer = self.wsTimer

	var_134_0:Setup(arg_134_1)

	self.rtGrid.localEulerAngles = Vector3(arg_134_1.theme.angle, 0, 0)

	return var_134_0
end

function WorldScene:DisposeMap()
	if self.wsMap then
		self.wsTimer:ClearInMapTimers()
		self.wsTimer:ClearInMapTweens()
		self:HideMap()

		local var_135_0 = nowWorld()

		var_135_0:RemoveListener(World.EventUpdateSubmarineSupport, self.onUpdateSubmarineSupport)
		var_135_0:RemoveListener(World.EventAchieved, self.onAchievementAchieved)
		self.wsMap.map:RemoveListener(WorldMap.EventUpdateActive, self.onDisposeMap)
		self.wsMap.map:RemoveListener(WorldMap.EventUpdateMoveSpeed, self.onClearMoveQueue)
		self.wsMap:Dispose()

		self.wsMap = nil
	end

	return
end

function WorldScene:OnDisposeMap(arg_136_1, arg_136_2)
	if (arg_136_1 == WorldMap.EventUpdateActive or nil) and not arg_136_2.active then
		self:DisposeMap()
	end

	return
end

function WorldScene:DisplayMapTop()
	self.wsMapTop = self.wsMapTop or self:NewMapTop(self.rtTopMap)

	setActive(self.rtTopMap, true)

	return
end

function WorldScene:HideMapTop()
	setActive(self.rtTopMap, false)

	return
end

function WorldScene:NewMapTop(arg_139_1)
	local var_139_0 = WSMapTop.New()

	var_139_0.transform = arg_139_1

	var_139_0:Setup()

	function var_139_0.cmdSkillFunc(arg_140_0)
		self:emit(WorldMediator.OnOpenLayer, Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				isWorld = true,
				skill = arg_140_0
			}
		}))

		return
	end

	function var_139_0.poisonFunc(arg_141_0)
		self:ShowSubView("PoisonPanel", {
			arg_141_0
		})

		return
	end

	onButton(self, var_139_0.btnBack, function()
		self:Op("OpCall", function(arg_143_0)
			self:ExitWorld(arg_143_0)

			return
		end)

		return
	end, SFX_CANCEL)

	return var_139_0
end

function WorldScene:DisposeMapTop()
	if self.wsMapTop then
		self:HideMapTop()
		self.wsMapTop:Dispose()

		self.wsMapTop = nil
	end

	return
end

function WorldScene:DisplayMapLeft()
	self.wsMapLeft = self.wsMapLeft or self:NewMapLeft(self.rtLeftMap)

	setActive(self.rtLeftMap, true)

	return
end

function WorldScene:HideMapLeft()
	setActive(self.rtLeftMap, false)

	return
end

function WorldScene:NewMapLeft(arg_147_1)
	local var_147_0 = WSMapLeft.New()

	var_147_0.transform = arg_147_1

	var_147_0:Setup()

	function var_147_0.onAgonyClick()
		local var_148_0 = {
			mediator = WorldInventoryMediator,
			viewComponent = WorldInventoryLayer
		}
		local var_148_1 = {}

		var_148_1.currentFleetIndex = nowWorld():GetActiveMap().findex
		var_148_0.data = var_148_1

		self:Op("OpOpenLayer", Context.New(var_148_0))

		return
	end

	function var_147_0:onLongPress()
		self:Op("OpOpenScene", SCENE.SHIPINFO, {
			shipId = self.id,
			shipVOs = nowWorld():GetFleet(self.fleetId):GetShipVOs(true)
		})

		return
	end

	function var_147_0.onClickSalvage(arg_150_0)
		self:Op("OpCall", function(arg_151_0)
			arg_151_0()
			self:ShowSubView("SalvageResult", {
				arg_150_0
			})

			return
		end)

		return
	end

	var_147_0:AddListener(WSMapLeft.EventSelectFleet, self.onSelectFleet)

	return var_147_0
end

function WorldScene:DisposeMapLeft()
	if self.wsMapLeft then
		self:HideMapLeft()
		self.wsMapLeft:RemoveListener(WSMapLeft.EventSelectFleet, self.onSelectFleet)
		self.wsMapLeft:Dispose()

		self.wsMapLeft = nil
	end

	return
end

function WorldScene:DisplayMapRight()
	self.wsMapRight = self.wsMapRight or self:NewMapRight(self.rtRightMap)

	setActive(self.rtRightMap, true)
	self:UpdateAutoFightDisplay()
	self:UpdateAutoSwitchDisplay()

	return
end

function WorldScene:HideMapRight()
	setActive(self.rtRightMap, false)

	return
end

function WorldScene:HideMapRightCompass()
	return
end

function WorldScene:HideMapRightMemo()
	return
end

function WorldScene:NewMapRight(arg_157_1)
	local var_157_0 = WSMapRight.New()

	var_157_0.transform = arg_157_1
	var_157_0.wsPool = self.wsPool
	var_157_0.wsTimer = self.wsTimer

	var_157_0:Setup()
	var_157_0:OnUpdateInfoBtnTip()
	var_157_0:OnUpdateHelpBtnTip()
	onButton(self, var_157_0.btnOrder, function()
		self:Op("OpShowOrderPanel")

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.btnScan, function()
		self:Op("OpShowScannerPanel")

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.btnDefeat, function()
		var_157_0:OnUpdateHelpBtnTip(true)
		self:Op("OpOpenLayer", Context.New({
			mediator = WorldHelpMediator,
			viewComponent = WorldHelpLayer,
			data = {
				titleId = 4,
				pageId = 5
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.btnDetail, function()
		local var_161_0 = {
			mediator = WorldDetailMediator,
			viewComponent = WorldDetailLayer
		}
		local var_161_1 = {}

		var_161_1.fleetId = nowWorld():GetActiveMap():GetFleet().id
		var_161_0.data = var_161_1

		self:Op("OpOpenLayer", Context.New(var_161_0))

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.btnInformation, function()
		local var_162_0 = {
			mediator = WorldInformationMediator,
			viewComponent = WorldInformationLayer
		}
		local var_162_1 = {}

		var_162_1.fleetId = nowWorld():GetActiveMap():GetFleet().id
		var_162_0.data = var_162_1

		self:Op("OpOpenLayer", Context.New(var_162_0))

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.btnInventory, function()
		local var_163_0 = {
			mediator = WorldInventoryMediator,
			viewComponent = WorldInventoryLayer
		}
		local var_163_1 = {}

		var_163_1.currentFleetIndex = nowWorld():GetActiveMap().findex
		var_163_0.data = var_163_1

		self:Op("OpOpenLayer", Context.New(var_163_0))

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.btnTransport, function()
		self:OnClickTransport()

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.btnPort, function()
		local var_165_0 = nowWorld()
		local var_165_1 = var_165_0:GetActiveMap()
		local var_165_2 = var_165_1:GetFleet()

		if var_165_1:GetCell(var_165_2.row, var_165_2.column).ExistEnemy(var_165_0) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_port_inbattle"))

			return
		end

		self:Op("OpReqEnterPort")

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.btnExit, function()
		local var_166_0 = nowWorld():GetActiveMap()
		local var_166_1 = {}

		if var_166_0:CheckFleetSalvage(true) then
			table.insert(var_166_1, function(arg_167_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("world_catsearch_leavemap"),
					onYes = arg_167_0
				})

				return
			end)
		end

		seriesAsync(var_166_1, function()
			self:Op("OpReqJumpOut", var_166_0.gid)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.btnHelp, function()
		var_157_0:OnUpdateHelpBtnTip(true)
		self:Op("OpOpenLayer", Context.New({
			mediator = WorldHelpMediator,
			viewComponent = WorldHelpLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.toggleAutoFight:Find("off"), function()
		self:Op("OpCall", function(arg_171_0)
			arg_171_0()

			local var_171_0 = {}

			if PlayerPrefs.GetInt("first_auto_fight_mark", 0) == 0 then
				table.insert(var_171_0, function(arg_172_0)
					PlayerPrefs.SetInt("first_auto_fight_mark", 1)
					self:Op("OpOpenLayer", Context.New({
						mediator = WorldHelpMediator,
						viewComponent = WorldHelpLayer,
						data = {
							titleId = 2,
							pageId = 8
						},
						onRemoved = arg_172_0
					}))

					return
				end)
			end

			local var_171_1 = nowWorld()

			if var_171_1:IsSystemOpen(WorldConst.SystemOrderSubmarine) and PlayerPrefs.GetInt("world_sub_auto_call", 0) == 1 then
				if var_171_1:GetActiveMap():GetConfig("instruction_available")[1] == 1 and var_171_1:CanCallSubmarineSupport() and not var_171_1:IsSubmarineSupporting() then
					local var_171_2 = var_171_1:CalcOrderCost(WorldConst.OpReqSub)

					if var_171_2 <= PlayerPrefs.GetInt("world_sub_call_line", 0) and var_171_2 <= var_171_1.staminaMgr:GetTotalStamina() then
						if var_171_2 > 0 then
							table.insert(var_171_0, function(arg_173_0)
								pg.MsgboxMgr.GetInstance():ShowMsgBox({
									content = i18n("world_instruction_submarine_2", setColorStr(var_171_2, COLOR_GREEN)),
									onYes = function()
										PlayerPrefs.SetInt("autoSubIsAcitve" .. AutoSubCommand.GetAutoSubMark(SYSTEM_WORLD), 1)
										self:Op("OpReqSub", arg_173_0)

										return
									end,
									onNo = arg_173_0
								})

								return
							end)
						else
							PlayerPrefs.SetInt("autoSubIsAcitve" .. AutoSubCommand.GetAutoSubMark(SYSTEM_WORLD), 1)
							table.insert(var_171_0, function(arg_175_0)
								self:Op("OpReqSub", arg_175_0)

								return
							end)
						end
					end
				end
			end

			seriesAsync(var_171_0, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("autofight_tip_bigworld_begin"))
				getProxy(MetaCharacterProxy):setMetaTacticsInfoOnStart()
				PlayerPrefs.SetInt("world_skip_precombat", 1)
				PlayerPrefs.SetInt("autoBotIsAcitve" .. AutoBotCommand.GetAutoBotMark(SYSTEM_WORLD), 1)
				var_171_1:TriggerAutoFight(true)
				self:Op("OpInteractive")

				return
			end)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.toggleAutoFight:Find("on"), function()
		self:Op("OpCall", function(arg_178_0)
			arg_178_0()
			nowWorld():TriggerAutoFight(false)
			self:Op("OpInteractive")

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.toggleAutoSwitch:Find("off"), function()
		self:Op("OpOpenLayer", Context.New({
			mediator = WorldSwitchPlanningMediator,
			viewComponent = WorldSwitchPlanningLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, var_157_0.toggleAutoSwitch:Find("on"), function()
		self:Op("OpCall", function(arg_181_0)
			arg_181_0()
			nowWorld():TriggerAutoFight(false)
			self:Op("OpInteractive")

			return
		end)

		return
	end, SFX_PANEL)

	return var_157_0
end

function WorldScene:DisposeMapRight()
	if self.wsMapRight then
		self:HideMapRight()
		self.wsMapRight:Dispose()

		self.wsMapRight = nil
	end

	return
end

function WorldScene:DisplayMapOut()
	self.wsMapOut = self.wsMapOut or self:NewMapOut(self.rtOutMap)

	setActive(self.rtOutMap, true)

	return
end

function WorldScene:HideMapOut()
	setActive(self.rtOutMap, false)

	return
end

function WorldScene:NewMapOut(arg_185_1)
	local var_185_0 = WSMapOut.New()

	var_185_0.transform = arg_185_1

	var_185_0:Setup()

	return var_185_0
end

function WorldScene:DisposeMapOut()
	if self.wsMapOut then
		self:HideMapOut()
		self.wsMapOut:Dispose()

		self.wsMapOut = nil
	end

	return
end

function WorldScene:OnUpdateProgress(arg_187_1, arg_187_2, arg_187_3, arg_187_4)
	self:UpdateSystemOpen()

	if self.wsMapRight then
		self.wsMapRight:OnUpdateHelpBtnTip()
	end

	return
end

function WorldScene:OnUpdateScale(arg_188_1, arg_188_2, arg_188_3)
	if self.wsAtlas and not self.wsAtlasBottom:CheckIsTweening() then
		self.wsAtlas:UpdateScale(arg_188_3)
	end

	return
end

function WorldScene:OnModelSelectMap(arg_189_1, arg_189_2, arg_189_3, arg_189_4, arg_189_5)
	if arg_189_3 then
		self:ShowSubView("FloatPanel", {
			arg_189_3,
			arg_189_4,
			arg_189_5,
			arg_189_2
		})
	else
		self:HideSubView("FloatPanel")
	end

	return
end

function WorldScene:OnUpdateSubmarineSupport(arg_190_1)
	self.wsMap:UpdateSubmarineSupport()

	if self.wsMapLeft then
		self.wsMapLeft:OnUpdateSubmarineSupport()
	end

	return
end

function WorldScene:OnUpdateDaily()
	if self.wsAtlasBottom then
		setActive(self.wsAtlasBottom.btnDailyTask:Find("tip"), nowWorld():GetTaskProxy():canAcceptDailyTask())
	end

	return
end

function WorldScene:OnFleetSelected(arg_192_1, arg_192_2)
	if arg_192_2.selected then
		self.wsDragProxy:Focus(arg_192_2.transform.position, nil, LeanTweenType.easeInOutSine)
	end

	return
end

function WorldScene:OnSelectFleet(arg_193_1, arg_193_2, arg_193_3)
	if arg_193_3 == nowWorld():GetActiveMap():GetFleet() then
		self:Op("OpMoveCamera", 0, 0.1)
	else
		self:Op("OpReqSwitchFleet", arg_193_3)
	end

	return
end

function WorldScene:OnClickCell(arg_194_1, arg_194_2)
	local var_194_0 = nowWorld()
	local var_194_1 = var_194_0:GetActiveMap()
	local var_194_2 = var_194_1:GetFleet()
	local var_194_3 = var_194_1:GetCell(arg_194_1, arg_194_2)
	local var_194_4 = var_194_1:FindFleet(var_194_0.row, var_194_3.column)

	if var_194_4 and var_194_4 ~= var_194_2 then
		self:Op("OpReqSwitchFleet", var_194_4)
	elseif var_194_1:CheckInteractive() then
		self:Op("OpInteractive", true)
	elseif var_194_1:IsSign(arg_194_1, arg_194_2) and ManhattonDist({
		row = var_194_2.row,
		column = var_194_2.column
	}, {
		row = var_194_3.row,
		column = var_194_3.column
	}) <= 1 then
		self:Op("OpTriggerSign", var_194_2, var_194_3:GetEventAttachment(), function()
			self:Op("OpInteractive")

			return
		end)
	elseif var_194_1:CanLongMove(var_194_2) then
		self:Op("OpLongMoveFleet", var_194_2, var_194_3.row, var_194_3.column)
	else
		self:Op("OpReqMoveFleet", var_194_2, var_194_3.row, var_194_3.column)
	end

	return
end

function WorldScene:OnClickTransport()
	if self.svScannerPanel:isShowing() then
		return
	end

	self:Op("OpCall", function(arg_197_0)
		arg_197_0()
		self:QueryTransport(function()
			self:EnterTransportWorld()

			return
		end)

		return
	end)

	return
end

function WorldScene:QueryTransport(arg_199_1)
	local var_199_0 = nowWorld()
	local var_199_1 = var_199_0:GetActiveMap()
	local var_199_2 = {}

	if not var_199_0:IsSystemOpen(WorldConst.SystemOutMap) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("word_systemClose"))

		return
	end

	if var_199_1:CheckAttachmentTransport() == "story" then
		local var_199_3 = pg.gameset.world_transfer_eventstory.description[1]

		table.insert(var_199_2, function(arg_200_0)
			self:OpRaw("OpStory", var_199_3, true, true, false, function(arg_201_0)
				if arg_201_0 == 1 then
					arg_200_0()
				end

				return
			end)

			return
		end)
	end

	if var_199_0:IsSubmarineSupporting() then
		if var_199_1:GetSubmarineFleet():GetAmmo() > 0 then
			table.insert(var_199_2, function(arg_202_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("world_instruction_submarine_6"),
					onYes = arg_202_0
				})

				return
			end)
		end
	end

	if var_199_1:CheckFleetSalvage(true) then
		table.insert(var_199_2, function(arg_203_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("world_catsearch_leavemap"),
				onYes = arg_203_0
			})

			return
		end)
	end

	local var_199_4

	for iter_199_0, iter_199_1 in ipairs(var_199_1:GetNormalFleets()) do
		for iter_199_2, iter_199_3 in ipairs(iter_199_1:GetCarries()) do
			if iter_199_3.config.out_story ~= "" then
				var_199_4 = iter_199_3.config.out_story
			end
		end
	end

	if var_199_4 then
		table.insert(var_199_2, function(arg_204_0)
			self:OpRaw("OpStory", var_199_4, true, true, false, function(arg_205_0)
				if arg_205_0 == 1 then
					arg_204_0()
				end

				return
			end)

			return
		end)
	end

	local var_199_5, var_199_6 = var_199_1:CkeckTransport()

	if not var_199_5 then
		table.insert(var_199_2, function(arg_206_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = var_199_6,
				onYes = arg_206_0
			})

			return
		end)
	end

	seriesAsync(var_199_2, function()
		return arg_199_1(var_199_5)
	end)

	return
end

function WorldScene:OnUpdateEventTips(arg_208_1, arg_208_2)
	if self.wsMapRight then
		self.wsMapRight:OnUpdateEventTips()
	end

	if self.wsMapTop then
		self.wsMapTop:OnUpdatePoison()
	end

	return
end

function WorldScene:OnClickMap(arg_209_1, arg_209_2)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

	if arg_209_1 < self.wsMap.map.top or self.wsMap.map.bottom < arg_209_1 or arg_209_2 < self.wsMap.map.left or self.wsMap.map.right < arg_209_2 then
		self:OnClickTransport()
	else
		self:OnClickCell(arg_209_1, arg_209_2)
	end

	return
end

function WorldScene:CheckScannerEnable(arg_210_1, arg_210_2)
	if nowWorld():IsSystemOpen(WorldConst.SystemScanner) then
		local var_210_0 = self.wsMap.map:GetCell(arg_210_1, arg_210_2)

		if var_210_0 and var_210_0:GetInFOV() and not var_210_0:InFog() then
			if var_210_0:GetScannerAttachment() then
				local var_210_3 = self.camera:WorldToScreenPoint(self.wsMap:GetCell(arg_210_1, arg_210_2).rtAttachments.position)

				return
			end
		end
	end

	return
end

function WorldScene:OnLongPressMap(arg_211_1, arg_211_2)
	if not self.svScannerPanel:isShowing() then
		local var_211_0, var_211_1 = self:CheckScannerEnable(arg_211_1, arg_211_2)

		if var_211_0 then
			self:Op("OpShowScannerPanel", var_211_0, var_211_1)
		end
	end

	return
end

function WorldScene:OnAchievementAchieved(arg_212_1, arg_212_2, arg_212_3, arg_212_4)
	if arg_212_3 then
		for iter_212_0, iter_212_1 in ipairs(arg_212_3) do
			pg.TipsMgr.GetInstance():ShowTips(iter_212_1)
		end
	end

	if arg_212_4 then
		local var_212_0 = nowWorld()

		if var_212_0.isAutoFight then
			var_212_0:AddAutoInfo("message", i18n("autofight_discovery", arg_212_4.config.target_desc))
		else
			table.insert(self.achievedList, {
				arg_212_4,
				self.wsMapRight.btnInformation.position
			})
		end
	end

	return
end

function WorldScene:DoAnim(arg_213_1, arg_213_2)
	if not self.wsAnim:GetAnim(arg_213_1) then
		self.wsAnim:SetAnim(arg_213_1, self:NewUIAnim(arg_213_1))
	end

	self.wsAnim:GetAnim(arg_213_1):Play(arg_213_2)

	return
end

function WorldScene:NewUIAnim(arg_214_1)
	local var_214_0 = UIAnim.New()

	var_214_0:Setup(arg_214_1)
	var_214_0:AddListener(UIAnim.EventLoaded, function()
		var_214_0.transform:SetParent(self.rtTop, false)

		return
	end)
	var_214_0:Load()

	return var_214_0
end

function WorldScene:DoStrikeAnim(arg_216_1, arg_216_2, arg_216_3)
	if not self.wsAnim:GetAnim(arg_216_1) then
		self.wsAnim:SetAnim(arg_216_1, self:NewStrikeAnim(arg_216_1, arg_216_2))
	else
		self.wsAnim:GetAnim(arg_216_1):ReloadShip(arg_216_2)
	end

	self.wsAnim:GetAnim(arg_216_1):Play(arg_216_3)

	return
end

function WorldScene:NewStrikeAnim(arg_217_1, arg_217_2)
	local var_217_0 = UIStrikeAnim.New()

	var_217_0:Setup(arg_217_1, arg_217_2)
	var_217_0:AddListener(UIStrikeAnim.EventLoaded, function()
		var_217_0.transform:SetParent(self.rtTop, false)

		return
	end)
	var_217_0:Load()

	return var_217_0
end

function WorldScene:StopAnim()
	self.wsAnim:Stop()

	return
end

function WorldScene:UpdateSystemOpen()
	local var_220_0 = nowWorld()

	if self:GetInMap() then
		self.wsMapLeft.onAgonyClickEnabled = var_220_0:IsSystemOpen(WorldConst.SystemInventory)

		setActive(self.wsMapRight.btnInventory, var_220_0:IsSystemOpen(WorldConst.SystemInventory))
		setActive(self.wsMapRight.btnTransport, var_220_0:IsSystemOpen(WorldConst.SystemOutMap))
		setActive(self.wsMapRight.btnDetail, var_220_0:IsSystemOpen(WorldConst.SystemFleetDetail))
		setActive(self.wsMapRight.rtCompassPanel, var_220_0:IsSystemOpen(WorldConst.SystemCompass))
		setActive(self.wsMapRight.toggleAutoFight, var_220_0:GetActiveMap():CanAutoFight())
		setActive(self.wsMapRight.toggleAutoSwitch, var_220_0:IsSystemOpen(WorldConst.SystemAutoSwitch))
	else
		setActive(self.wsAtlasBottom.btnBoss, var_220_0:IsSystemOpen(WorldConst.SystemWorldBoss))

		local var_220_1 = var_220_0:GetBossProxy()
		local var_220_2 = var_220_0:GetBossProxy()
		local var_220_3 = WorldBossConst.CanUnlockCurrBoss()
		local var_220_4 = not var_220_2:ExistSelfBoss() and not var_220_3

		setActive(self.wsAtlasBottom.btnBoss:Find("tip"), var_220_1:NeedTip() or var_220_3 or WorldBossConst.AnyArchivesBossCanGetAward())
		setActive(self.wsAtlasBottom.btnBoss:Find("sel"), not var_220_4)

		local var_220_5 = self.rtTopAtlas:Find("reset_coutdown")

		onButton(self, var_220_5, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("world_reset_tip")
			})

			return
		end, SFX_PANEL)

		local var_220_6 = var_220_0:IsSystemOpen(WorldConst.SystemResetCountDown) and var_220_0:CheckResetProgress()

		setActive(var_220_5, var_220_6)

		if var_220_6 then
			local var_220_7 = math.floor(var_220_0:GetResetWaitingTime() / 0)

			if var_220_7 > 0 then
				setText(var_220_5:Find("Text"), i18n("world_reset_1", string.format("  %d  ", var_220_7)))
			elseif var_220_7 == 0 then
				setText(var_220_5:Find("Text"), i18n("world_reset_2", string.format("  %d  ", 0)))
			elseif var_220_7 < 0 then
				setText(var_220_5:Find("Text"), i18n("world_reset_3"))
			end
		end

		setActive(self.wsAtlasBottom.btnShop, var_220_0:IsSystemOpen(WorldConst.SystemResetShop))
		setActive(self.wsAtlasBottom.btnDailyTask:Find("mask"), not var_220_0:IsSystemOpen(WorldConst.SystemDailyTask))
		setActive(self.wsAtlasRight.btnSwitch, var_220_0:IsSystemOpen(WorldConst.SystemAutoSwitch))
	end

	setActive(self.resAtlas._tf, var_220_0:IsSystemOpen(WorldConst.SystemResource))
	setActive(self.resMap._tf, var_220_0:IsSystemOpen(WorldConst.SystemResource))

	return
end

function WorldScene:EnterToModelMap(arg_222_1)
	local var_222_0 = {}

	table.insert(var_222_0, function(arg_223_0)
		setActive(self.rtTopAtlas:Find("print/title_world"), true)
		setActive(self.rtTopAtlas:Find("print/title_view"), false)
		self.wsAtlasBottom:UpdateScale(1, true, arg_223_0)

		return
	end)
	table.insert(var_222_0, function(arg_224_0)
		self.wsAtlas:SwitchArea(arg_222_1, true, arg_224_0)

		return
	end)
	parallelAsync(var_222_0, function()
		local var_225_0 = nowWorld():GetAtlas():GetActiveEntrance()

		if arg_222_1 == var_225_0:GetAreaId() then
			self.wsAtlas:UpdateSelect(var_225_0)
		end

		return
	end)

	return
end

function WorldScene:ReturnToModelArea()
	self.wsAtlas:UpdateSelect()

	local var_226_0 = {}

	table.insert(var_226_0, function(arg_227_0)
		setActive(self.rtTopAtlas:Find("print/title_world"), false)
		setActive(self.rtTopAtlas:Find("print/title_view"), true)
		self.wsAtlasBottom:UpdateScale(0, true, arg_227_0)

		return
	end)
	table.insert(var_226_0, function(arg_228_0)
		self.wsAtlas:SwitchArea(nil, true, arg_228_0)

		return
	end)
	parallelAsync(var_226_0, function()
		return
	end)

	return
end

function WorldScene:EnterTransportWorld(arg_230_1)
	local var_230_0 = nowWorld()

	arg_230_1 = arg_230_1 or {
		entrance = var_230_0:GetActiveEntrance()
	}

	local var_230_1 = {}

	if self:GetInMap() then
		table.insert(var_230_1, function(arg_231_0)
			self:Op("OpSetInMap", false, arg_231_0)

			return
		end)
	elseif not self.wsAtlas.nowArea then
		table.insert(var_230_1, function(arg_232_0)
			self.wsAtlas:SwitchArea(arg_230_1.entrance:GetAreaId(), false, arg_232_0)

			return
		end)
	end

	seriesAsync(var_230_1, function()
		self.wsAtlas:UpdateSelect()
		self.wsAtlas:UpdateSelect(arg_230_1.entrance, arg_230_1.mapId, arg_230_1.mapTypes)
		self.wsAtlas:DisplayTransport(self.contextData.displayTransDic or {}, function()
			self.contextData.displayTransDic = Clone(var_230_0:GetAtlas().transportDic)

			return
		end)

		return
	end)

	return
end

function WorldScene:BackToMap()
	if self.wsAtlas:CheckIsTweening() then
		return
	end

	self:Op("OpSetInMap", true)

	return
end

function WorldScene:DisplayEnv(arg_236_1)
	local var_236_0 = checkExist(nowWorld():GetActiveMap(), {
		"config"
	}, {
		"map_bg"
	}, {
		1
	}) or "model_bg"
	local var_236_1 = {}

	if self.rtEnvBG:GetComponent(typeof(Image)).sprite.name ~= var_236_0 then
		table.insert(var_236_1, function(arg_237_0)
			GetSpriteFromAtlasAsync("world/map/" .. var_236_0, var_236_0, function(arg_238_0)
				setImageSprite(self.rtEnvBG, arg_238_0)

				return arg_237_0()
			end)

			return
		end)
	end

	seriesAsync(var_236_1, arg_236_1)

	return
end

function WorldScene:ScreenPos2MapPos(arg_239_1)
	local var_239_0 = self.camera:ScreenPointToRay(arg_239_1)
	local var_239_1, var_239_2 = Plane.New(self.wsMap.rtQuads.forward, -Vector3.Dot(self.wsMap.rtQuads.position, self.wsMap.rtQuads.forward)):Raycast(var_239_0)

	if var_239_1 then
		local var_239_3 = self.wsMap.rtQuads:InverseTransformPoint((var_239_0:GetPoint(var_239_2)))

		return self.wsMap.map.theme:Y2Row(var_239_3.y), (self.wsMap.map.theme:X2Column(var_239_3.x))
	end

	return
end

function WorldScene:BuildCutInAnim(arg_240_1, arg_240_2)
	self.tfAnim = self.rtPanelList:Find(arg_240_1 .. "(Clone)")

	local var_240_0 = {}

	if not self.tfAnim then
		table.insert(var_240_0, function(arg_241_0)
			PoolMgr.GetInstance():GetUI(arg_240_1, true, function(arg_242_0)
				arg_242_0:SetActive(false)

				self.tfAnim = tf(arg_242_0)

				self.tfAnim:SetParent(self.rtPanelList, false)

				return arg_241_0()
			end)

			return
		end)
	end

	table.insert(var_240_0, function(arg_243_0)
		self.inCutIn = true

		self.tfAnim:GetComponent("DftAniEvent"):SetEndEvent(function(arg_244_0)
			if not IsNil(self.tfAnim) then
				self.inCutIn = false

				self:UnOverlayPanel(self.tfAnim, self.rtPanelList)
				setActive(self.tfAnim, false)

				return arg_243_0()
			end

			return
		end)
		self:OverlayPanel(self.tfAnim)
		setActive(self.tfAnim, true)

		return
	end)
	seriesAsync(var_240_0, function()
		return existCall(arg_240_2)
	end)

	return
end

function WorldScene:PlaySound(arg_246_1, arg_246_2)
	if self.cueName then
		pg.CriMgr.GetInstance():StopSE_V3()

		self.cueName = nil
	end

	pg.CriMgr.GetInstance():PlaySE_V3(arg_246_1, function()
		self.cueName = nil

		return
	end)

	return existCall(arg_246_2)
end

function WorldScene:ChangeTopRaycasts(arg_248_1)
	GetOrAddComponent(self.rtTop, typeof(CanvasGroup)).blocksRaycasts = tobool(arg_248_1)

	return
end

function WorldScene:DoTopBlock(arg_249_1)
	self:ChangeTopRaycasts(false)

	return function(...)
		self:ChangeTopRaycasts(true)

		return existCall(arg_249_1, ...)
	end
end

function WorldScene:SetMoveQueue(arg_251_1)
	self:ReContinueMoveQueue()

	self.moveQueue = arg_251_1

	return
end

function WorldScene:ClearMoveQueue()
	self:DisplayMoveStopClick(false)

	self.moveQueueInteractive = true

	if #self.moveQueue > 0 then
		self.moveQueue = {}
	end

	self:ShowFleetMoveTurn(false)

	return
end

function WorldScene:DoQueueMove(arg_253_1)
	assert(#self.moveQueue > 0, "without move queue")
	self:DisplayMoveStopClick(true)

	local var_253_0 = nowWorld():GetActiveMap()
	local var_253_1 = _.detect(self.moveQueue, function(arg_254_0)
		return arg_254_0.stay
	end)

	if #self.moveQueue == 1 and var_253_0:IsSign(var_253_1.row, var_253_1.column) then
		self:ClearMoveQueue()
		self:Op("OpTriggerSign", arg_253_1, var_253_0:GetCell(var_253_1.row, var_253_1.column):GetEventAttachment(), function()
			self:Op("OpInteractive")

			return
		end)
	else
		self:ReContinueMoveQueue()
		self:ShowFleetMoveTurn(true)
		self:Op("OpReqMoveFleet", arg_253_1, var_253_1.row, var_253_1.column)
	end

	return
end

function WorldScene:CheckMoveQueue(arg_256_1)
	if #self.moveQueue < #arg_256_1 or #arg_256_1 == 0 then
		self:ClearMoveQueue()
	elseif self.moveQueue[#arg_256_1].row ~= arg_256_1[#arg_256_1].row or self.moveQueue[#arg_256_1].column ~= arg_256_1[#arg_256_1].column then
		self:ClearMoveQueue()
	else
		for iter_256_0 = 1, #arg_256_1 do
			table.remove(self.moveQueue, 1)
		end

		if #self.moveQueue == 0 then
			self:ResetLostMoveQueueCount()

			self.moveQueueInteractive = true
		end
	end

	return
end

function WorldScene:InteractiveMoveQueue()
	if self.moveQueueInteractive then
		self:ClearMoveQueue()
	else
		self:DisplayMoveStopClick(false)

		self.moveQueueInteractive = true
	end

	return
end

function WorldScene:ReContinueMoveQueue()
	self.moveQueueInteractive = false

	return
end

function WorldScene:CheckLostMoveQueueCount()
	self.lostMoveQueueCount = defaultValue(self.lostMoveQueueCount, 0) + 1

	return self.lostMoveQueueCount > WorldConst.AutoFightLoopCountLimit
end

function WorldScene:ResetLostMoveQueueCount(arg_260_1)
	if arg_260_1 then
		self.inLoopAutoFight = true
	end

	self.lostMoveQueueCount = 0

	return
end

function WorldScene:DisplayMoveStopClick(arg_261_1)
	setActive(self.rtClickStop, arg_261_1)

	if arg_261_1 then
		local var_261_0 = nowWorld().isAutoFight

		setActive(self.rtClickStop:Find("long_move"), not var_261_0)
		setActive(self.rtClickStop:Find("auto_fight"), var_261_0)
	end

	return
end

function WorldScene:ShowFleetMoveTurn(arg_262_1)
	if self.wsMap then
		if arg_262_1 then
			self.wsMap:GetFleet():PlusMoveTurn()
		else
			self.wsMap:GetFleet():ClearMoveTurn()
		end
	end

	return
end

function WorldScene:GetAllPessingAward(arg_263_1)
	local var_263_0 = nowWorld()
	local var_263_1 = var_263_0:GetAtlas()
	local var_263_2 = {}

	for iter_263_0, iter_263_1 in pairs(var_263_0.pressingAwardDic) do
		if iter_263_1.flag then
			var_263_0:FlagMapPressingAward(iter_263_0)
			var_263_1:MarkMapTransport(iter_263_0)

			if #pg.world_event_complete[iter_263_1.id].event_reward_slgbuff > 0 then
				var_263_2[pg.world_event_complete[iter_263_1.id].event_reward_slgbuff[1]] = defaultValue(var_263_2[pg.world_event_complete[iter_263_1.id].event_reward_slgbuff[1]], 0) + pg.world_event_complete[iter_263_1.id].event_reward_slgbuff[2]
			end
		end
	end

	local var_263_3 = var_263_0:GetActiveMap()

	if not var_263_3.visionFlag and var_263_0:IsMapVisioned(var_263_3.id) then
		var_263_3:UpdateVisionFlag(true)
	end

	if self.wsAtlas then
		self.wsAtlas:OnUpdatePressingAward()
	end

	local var_263_4 = {}

	for iter_263_2, iter_263_3 in pairs(var_263_2) do
		table.insert(var_263_4, function(arg_264_0)
			local var_264_0 = {
				id = iter_263_2,
				floor = iter_263_3
			}

			var_264_0.before = var_263_0:GetGlobalBuff(iter_263_2):GetFloor()

			self:ShowSubView("GlobalBuff", {
				var_264_0,
				arg_264_0
			})

			return
		end)
		table.insert(var_263_4, function(arg_265_0)
			var_263_0:AddGlobalBuff(iter_263_2, iter_263_3)
			arg_265_0()

			return
		end)
	end

	seriesAsync(var_263_4, function()
		return existCall(arg_263_1)
	end)

	return
end

function WorldScene:CheckGuideSLG(arg_267_1, arg_267_2)
	local var_267_0 = nowWorld()
	local var_267_1 = {}

	table.insert(var_267_1, {
		"WorldG007",
		function()
			local var_268_0 = arg_267_1:GetPort()

			if var_268_0 and not var_268_0:IsTempPort() then
				local var_268_1 = arg_267_1:GetFleet()

				return not arg_267_1:GetCell(var_268_1.row, var_268_1.column):ExistEnemy()
			end

			return
		end
	})
	table.insert(var_267_1, {
		"WorldG111",
		function()
			return arg_267_1:canExit()
		end
	})
	table.insert(var_267_1, {
		"WorldG112",
		function()
			local var_270_0 = var_267_0:GetActiveEntrance()

			return var_270_0.becomeSairen and var_270_0:GetSairenMapId() == arg_267_1.id
		end
	})
	table.insert(var_267_1, {
		"WorldG124",
		function()
			return var_267_0:IsSystemOpen(WorldConst.SystemOrderSubmarine) and arg_267_1:GetConfig("instruction_available")[1] ~= 0 and var_267_0:CanCallSubmarineSupport()
		end
	})
	table.insert(var_267_1, {
		"WorldG162",
		function()
			return _.any(arg_267_1:GetNormalFleets(), function(arg_273_0)
				return _.any(arg_273_0:GetShips(true), function(arg_274_0)
					return arg_274_0:IsBroken()
				end)
			end)
		end
	})
	table.insert(var_267_1, {
		"WorldG163",
		function()
			return underscore.any(var_267_0:GetTaskProxy():getDoingTaskVOs(), function(arg_276_0)
				return not arg_276_0:IsAutoSubmit() and arg_276_0:isFinished()
			end)
		end
	})
	table.insert(var_267_1, {
		"WorldG164",
		function()
			return arg_267_1:CheckFleetSalvage(true)
		end
	})
	table.insert(var_267_1, {
		"WorldG181",
		function()
			return var_267_0:GetInventoryProxy():GetItemCount(102) > 0
		end
	})
	table.insert(var_267_1, {
		"WorldG191",
		function()
			local var_279_0 = WorldBossConst.CanUnlockCurrBoss()

			var_279_0 = var_279_0 and nowWorld():IsSystemOpen(WorldConst.SystemWorldBoss)

			return var_279_0
		end
	})

	local var_267_2 = _.filter(arg_267_1:FindAttachments(WorldMapAttachment.TypeEvent), function(arg_280_0)
		return arg_280_0:IsAlive()
	end)

	for iter_267_0, iter_267_1 in ipairs(pg.gameset.world_guide_event.description) do
		table.insert(var_267_1, {
			iter_267_1[2],
			function()
				return _.any(var_267_2, function(arg_282_0)
					return arg_282_0.id == iter_267_1[1]
				end)
			end
		})
	end

	local var_267_3 = pg.NewStoryMgr.GetInstance()

	for iter_267_2, iter_267_3 in ipairs(var_267_1) do
		if not var_267_3:IsPlayed(iter_267_3[1]) and iter_267_3[2]() then
			WorldGuider.GetInstance():PlayGuide(iter_267_3[1])

			return true
		end
	end

	return false
end

function WorldScene:CheckEventForMsg(arg_283_1)
	local var_283_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(self.player.level, "EventMediator")

	var_283_0 = var_283_0 and getProxy(EventProxy).eventForMsg

	return var_283_0
end

function WorldScene:OpenPortLayer(arg_284_1)
	self:Op("OpOpenLayer", Context.New({
		mediator = WorldPortMediator,
		viewComponent = WorldPortLayer,
		data = arg_284_1
	}))

	return
end

function WorldScene:ShowTransportMarkOverview(arg_285_1, arg_285_2)
	if nowWorld():GetActiveMap():CheckFleetSalvage(true) then
		self:Op("OpShowMarkOverview", arg_285_1, function()
			pg.NewStoryMgr.GetInstance():Play(pg.gameset.world_catsearch_special.description[1], arg_285_2, true)

			return
		end)
	else
		self:Op("OpShowMarkOverview", arg_285_1, arg_285_2)
	end

	return
end

function WorldScene:UpdateAutoFightDisplay()
	self:ClearMoveQueue()

	local var_287_0 = nowWorld().isAutoFight

	if self.wsMapRight then
		setActive(self.wsMapRight.toggleAutoFight:Find("off"), not var_287_0)
		setActive(self.wsMapRight.toggleAutoFight:Find("on"), var_287_0)
		setActive(self.wsMapRight.toggleSkipPrecombat, not var_287_0)
		triggerToggle(self.wsMapRight.toggleSkipPrecombat, PlayerPrefs.GetInt("world_skip_precombat", 0) == 1)
	end

	return
end

function WorldScene:UpdateAutoSwitchDisplay()
	local var_288_0 = nowWorld().isAutoSwitch

	if self.wsMapRight then
		setActive(self.wsMapRight.toggleAutoSwitch:Find("off"), not var_288_0)
		setActive(self.wsMapRight.toggleAutoSwitch:Find("on"), var_288_0)
	end

	return
end

function WorldScene:GuideShowScannerEvent(arg_289_1)
	assert(self.svScannerPanel:isShowing(), "scanner mode is closed")

	local var_289_0 = self.wsMap.map:FindAttachments(WorldMapAttachment.TypeEvent, arg_289_1)

	assert(#var_289_0 == 1, "event number error: " .. #var_289_0)

	local var_289_1, var_289_2 = self:CheckScannerEnable(var_289_0[1].row, var_289_0[1].column)

	assert(var_289_1, "without scanner attachment")
	self.svScannerPanel:ActionInvoke("DisplayWindow", var_289_1, var_289_2)

	return
end

function WorldScene:DisplayAwards(arg_290_1, arg_290_2, arg_290_3)
	local var_290_0 = {}
	local var_290_1 = {}

	for iter_290_0, iter_290_1 in ipairs(arg_290_1) do
		if iter_290_1.type == DROP_TYPE_WORLD_COLLECTION then
			table.insert(var_290_1, iter_290_1)
		else
			table.insert(var_290_0, iter_290_1)
		end
	end

	seriesAsync({
		function(arg_291_0)
			if #var_290_0 == 0 then
				return arg_291_0()
			end

			arg_290_2.items = var_290_0
			arg_290_2.removeFunc = arg_291_0

			self:emit(BaseUI.ON_WORLD_ACHIEVE, arg_290_2)

			return
		end,
		function(arg_292_0)
			local var_292_0 = var_290_1[1]

			if not var_290_1[1] then
				arg_292_0()

				return
			end

			assert(WorldCollectionProxy.GetCollectionType(var_292_0.id) == WorldCollectionProxy.WorldCollectionType.FILE, string.format("collection drop type error#%d", var_292_0.id))
			self:emit(WorldMediator.OnOpenLayer, Context.New({
				mediator = WorldMediaCollectionFilePreviewMediator,
				viewComponent = WorldMediaCollectionFilePreviewLayer,
				data = {
					collectionId = var_292_0.id
				},
				onRemoved = arg_292_0
			}))

			return
		end
	}, arg_290_3)

	return
end

function WorldScene:DisplayPhaseAction(arg_293_1)
	local var_293_0 = {}

	while #arg_293_1 > 0 do
		local var_293_1 = nowWorld()
		local var_293_2 = table.remove(arg_293_1, 1)

		table.insert(var_293_0, function(arg_294_0)
			if var_293_2.anim then
				self:BuildCutInAnim(var_293_2.anim, arg_294_0)
			elseif var_293_2.story then
				if var_293_1.isAutoFight then
					arg_294_0()
				else
					pg.NewStoryMgr.GetInstance():Play(var_293_2.story, arg_294_0, true)
				end
			elseif var_293_2.drops then
				if var_293_1.isAutoFight then
					var_293_1:AddAutoInfo("drops", var_293_2.drops)
					arg_294_0()
				else
					self:DisplayAwards(var_293_2.drops, {}, arg_294_0)
				end
			end

			return
		end)
	end

	seriesAsync(var_293_0, function()
		self:Op("OpInteractive")

		return
	end)

	return
end

function WorldScene:StartAutoSwitch()
	local var_296_0 = nowWorld()
	local var_296_1 = var_296_0:GetActiveEntrance()
	local var_296_2 = var_296_0:GetActiveMap()

	if PlayerPrefs.GetInt("auto_switch_mode", 0) == WorldSwitchPlanningLayer.MODE_SAFE and PlayerPrefs.GetString("auto_switch_difficult_safe", "only") == "only" and World.ReplacementMapType(var_296_1, var_296_2) ~= "complete_chapter" then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_automode_start_tip3"))

		return
	elseif PlayerPrefs.GetInt("auto_switch_mode", 0) == WorldSwitchPlanningLayer.MODE_TREASURE and not var_296_0:GetGobalFlag("treasure_flag") then
		pg.TipsMgr.GetInstance():ShowTips("without auto switch flag")

		return
	end

	self:QueryTransport(function(arg_297_0)
		if not arg_297_0 then
			if PlayerPrefs.GetInt("auto_switch_mode", 0) == WorldSwitchPlanningLayer.MODE_TREASURE and World.ReplacementMapType(var_296_1, var_296_2) == "teasure_chapter" then
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_automode_start_tip5"))
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_automode_start_tip4"))
			end
		else
			getProxy(MetaCharacterProxy):setMetaTacticsInfoOnStart()
			PlayerPrefs.SetInt("world_skip_precombat", 1)
			PlayerPrefs.SetInt("autoBotIsAcitve" .. AutoBotCommand.GetAutoBotMark(SYSTEM_WORLD), 1)
			self:Op("OpAutoSwitchMap")
		end

		return
	end)

	return
end

function WorldScene:MoveAndOpenLayer(arg_298_1)
	local var_298_0 = {}

	table.insert(var_298_0, function(arg_299_0)
		self:Op("OpSetInMap", arg_298_1.inMap, arg_299_0)

		return
	end)
	seriesAsync(var_298_0, function()
		self:Op("OpOpenLayer", arg_298_1.context)

		return
	end)

	return
end

function WorldScene:GetDepth()
	return #self.wsCommands
end

function WorldScene:GetCommand(arg_302_1)
	return self.wsCommands[arg_302_1 or self:GetDepth()]
end

function WorldScene:Op(arg_303_1, ...)
	self:GetCommand():Op(arg_303_1, ...)

	return
end

function WorldScene:OpRaw(arg_304_1, ...)
	self:GetCommand():OpRaw(arg_304_1, ...)

	return
end

function WorldScene:OpOpen()
	local var_305_0 = self:GetDepth()

	WorldConst.Print("open operation stack: " .. var_305_0 + 1)
	table.insert(self.wsCommands, WSCommand.New(var_305_0 + 1))

	return
end

function WorldScene:OpClose()
	local var_306_0 = self:GetDepth()

	assert(var_306_0 > 0)
	WorldConst.Print("close operation stack: " .. var_306_0)
	self.wsCommands[var_306_0]:Dispose()
	table.remove(self.wsCommands, var_306_0)

	return
end

function WorldScene:OpClear()
	for iter_307_0, iter_307_1 in ipairs(self.wsCommands) do
		iter_307_1:OpClear()
	end

	return
end

function WorldScene:OpDispose()
	for iter_308_0, iter_308_1 in ipairs(self.wsCommands) do
		iter_308_1:Dispose()
	end

	self.wsCommands = nil

	return
end

function WorldScene:NewMapOp(arg_309_1)
	local var_309_0 = WBank:Fetch(WorldMapOp)

	var_309_0.depth = self:GetDepth()

	for iter_309_0, iter_309_1 in pairs(arg_309_1) do
		var_309_0[iter_309_0] = iter_309_1
	end

	return var_309_0
end

function WorldScene:RegistMapOp(arg_310_1)
	assert(arg_310_1, "mapOp can not be nil.")
	assert(not table.contains(self.mapOps, arg_310_1), "repeated registered mapOp.")
	table.insert(self.mapOps, arg_310_1)
	arg_310_1:AddCallbackWhenApplied(function()
		for iter_311_0 = #self.mapOps, 1, -1 do
			if self.mapOps[iter_311_0] == arg_310_1 then
				table.remove(self.mapOps, iter_311_0)
			end
		end

		return
	end)

	return
end

function WorldScene:VerifyMapOp()
	for iter_312_0 = #self.mapOps, 1, -1 do
		local var_312_0 = table.remove(self.mapOps, iter_312_0)

		if not var_312_0.applied then
			var_312_0:Apply()
		end
	end

	self:OpClear()

	return
end

function WorldScene:GetCompassGridPos(arg_313_1, arg_313_2, arg_313_3)
	WorldGuider.GetInstance():SetTempGridPos(self.wsMapRight.wsCompass:GetMarkPosition(arg_313_1, arg_313_2), arg_313_3)

	return
end

function WorldScene:GetEntranceTrackMark(arg_314_1, arg_314_2)
	WorldGuider.GetInstance():SetTempGridPos(self.wsMapRight.wsCompass:GetEntranceTrackMark(arg_314_1), arg_314_2)

	return
end

function WorldScene:GetSlgTilePos(arg_315_1, arg_315_2, arg_315_3)
	WorldGuider.GetInstance():SetTempGridPos2(self.wsMap:GetCell(arg_315_1, arg_315_2):GetWorldPos(), arg_315_3)

	return
end

function WorldScene:GetScannerPos(arg_316_1)
	WorldGuider.GetInstance():SetTempGridPos(self.svScannerPanel.rtPanel.transform:TransformPoint((Vector3.New(self.svScannerPanel.rtWindow.transform.localPosition.x + self.svScannerPanel.rtWindow.transform.rect.width * (0.5 - self.svScannerPanel.rtWindow.transform.pivot.x), self.svScannerPanel.rtWindow.transform.localPosition.y + self.svScannerPanel.rtWindow.transform.rect.height * (0.5 - self.svScannerPanel.rtWindow.transform.pivot.y), 0))), arg_316_1)

	return
end

function WorldScene:GuideSelectModelMap(arg_317_1)
	assert(self.wsAtlas, "didn't enter the world map mode")
	self:ClickAtlas((nowWorld():GetEntrance(arg_317_1)))

	return
end

return WorldScene
