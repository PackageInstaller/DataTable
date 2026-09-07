local SlideExtraSystem = class("SlideExtraSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

SlideExtraSystem.SHOW_INTERACTION = "SlideExtraSystem.SHOW_INTERACTION"
SlideExtraSystem.HIDE_INTERACTION = "SlideExtraSystem.HIDE_INTERACTION"
SlideExtraSystem.SHOW_PERFORMANCE = "SlideExtraSystem.SHOW_PERFORMANCE"
SlideExtraSystem.HIDE_PERFORMANCE = "SlideExtraSystem.HIDE_PERFORMANCE"

function SlideExtraSystem:OnInit()
	self:RegisterNodeCanvas()
	self:InitScene()
	self:InitData()
	self:InitSlide()
	self:Emit(Dorm3dRoomMediator.ADD_EXTRA_SYSTEM_FURNITURE_SLIDE)

	self.pickTimer = Timer.New(function()
		self:OnPick()

		return
	end, SlideConst.TIMER_INTERVAL, -1)

	self.pickTimer:Start()
	self:OnPick()

	return
end

function SlideExtraSystem:OnUpdate(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self.ladyDic) do
		iter_3_1:OnUpdate()
	end

	return
end

function SlideExtraSystem:OnDispose()
	if self.pickTimer then
		self.pickTimer:Stop()

		self.pickTimer = nil
	end

	for iter_4_0, iter_4_1 in pairs(self.ladyDic) do
		self:RemoveLadySlide(iter_4_0)
	end

	self:Func("ChangePlayerPosition")

	if self.slideTreeOwner then
		self.slideTreeOwner.enabled = false
	end

	if self.performanceTreeOwner then
		self.performanceTreeOwner.enabled = false
	end

	pg.NodeCanvasMgr.GetInstance():UnregisterFunc("Slide.ShowInteraction")
	pg.NodeCanvasMgr.GetInstance():UnregisterFunc("Slide.HideInteraction")
	pg.NodeCanvasMgr.GetInstance():UnregisterFunc("Slide.ShowPerformance")
	pg.NodeCanvasMgr.GetInstance():UnregisterFunc("Slide.HidePerformance")
	self:Emit(Dorm3dRoomMediator.REMOVE_EXTRA_SYSTEM, FurnitureSlideExtraMediator)

	return
end

function SlideExtraSystem:OnHandleNotification(arg_5_1, arg_5_2)
	if arg_5_1 == ApartmentProxy.UPDATE_SLIDE_INVITE_LIST then
		self:UpdateSlideInviteList(arg_5_2.addIds, arg_5_2.removeIds)
	elseif arg_5_1 == Dorm3dRoomMediator.REFRESH_FURNITURE_AND_SLOTS_DONE then
		self:InitSlide()
	end

	return
end

function SlideExtraSystem.GetInterests()
	return {
		ApartmentProxy.UPDATE_SLIDE_INVITE_LIST,
		Dorm3dRoomMediator.REFRESH_FURNITURE_AND_SLOTS_DONE
	}
end

function SlideExtraSystem:IsOpen()
	return self:GetConfigID() == SlideConst.ROOM_ID and self:IsFurnitureSetIn(SlideConst.FURNITURE_ID)
end

function SlideExtraSystem:RegisterNodeCanvas()
	pg.NodeCanvasMgr.GetInstance():RegisterFunc("Slide.ShowInteraction", function()
		pg.m02:sendNotification(SlideExtraSystem.SHOW_INTERACTION)

		return
	end)
	pg.NodeCanvasMgr.GetInstance():RegisterFunc("Slide.HideInteraction", function()
		pg.m02:sendNotification(SlideExtraSystem.HIDE_INTERACTION)

		return
	end)
	pg.NodeCanvasMgr.GetInstance():RegisterFunc("Slide.ShowPerformance", function()
		pg.m02:sendNotification(SlideExtraSystem.SHOW_PERFORMANCE)

		return
	end)
	pg.NodeCanvasMgr.GetInstance():RegisterFunc("Slide.HidePerformance", function()
		pg.m02:sendNotification(SlideExtraSystem.HIDE_PERFORMANCE)

		return
	end)

	return
end

function SlideExtraSystem:InitScene()
	self.sceneSlideConfigs = GameObject.Find("SlideConfigs").transform
	self.movePointsRoot = self.sceneSlideConfigs:Find("MovePoints")
	self.defaultPointsRoot = self.sceneSlideConfigs:Find("DefaultPoints")

	return
end

function SlideExtraSystem:InitSlide()
	warning("SystemInitSlide")

	if not self:Get("doneFirstSlotFresh") or self.slideInited then
		return
	end

	self.slideInited = true
	self.slideGo = self:GetSceneItem("FurnitureSlots/140101/Slide(Clone)")

	assert(self.slideGo, "Furniture Slide not found in scene")
	warning("InitSlide Done")

	self.slideTreeOwner = GetOrAddComponent(self.slideGo, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

	self.slideTreeOwner.graph.blackboard:AddVariable("_player", go(self:Get("player")))

	self.slideTreeOwner.enabled = true
	self.performanceTreeOwner = GetOrAddComponent(self.slideGo:Find("performance_interact_point"), typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

	self.performanceTreeOwner.graph.blackboard:AddVariable("_player", go(self:Get("player")))

	self.performanceTreeOwner.enabled = true

	return
end

function SlideExtraSystem:InitData()
	self.commandConfigDic = {}
	self.defaultPoints = {}

	_.each(pg.dorm3d_minigame_slide.all, function(arg_16_0)
		self.commandConfigDic[arg_16_0] = {}

		_.each(pg.dorm3d_minigame_slide[arg_16_0].slide_command, function(arg_17_0)
			table.insert(self.commandConfigDic[arg_16_0], SlideCommand.New(arg_17_0, self.movePointsRoot))

			return
		end)

		self.defaultPoints[arg_16_0] = self.defaultPointsRoot:Find(pg.dorm3d_minigame_slide[arg_16_0].slide_zone)

		return
	end)

	self.inviteList = getProxy(ApartmentProxy):GetSlideInviteList()
	self.randomList = Clone(self.inviteList)
	self.ladyDic = {}

	_.each(self.inviteList, function(arg_18_0)
		self:AddLadySlide(arg_18_0)

		return
	end)

	return
end

function SlideExtraSystem:AddLadySlide(arg_19_1)
	self.ladyDic[arg_19_1] = LadySlide.New(arg_19_1, self:Get("ladyDict")[arg_19_1], self.commandConfigDic[arg_19_1], self.defaultPoints[arg_19_1], function(arg_20_0)
		self:PlayVFX(arg_20_0)

		return
	end)

	self.ladyDic[arg_19_1]:Reset()

	return
end

function SlideExtraSystem:RemoveLadySlide(arg_21_1)
	if self.ladyDic[arg_21_1] then
		self:Func("ChangeCharacterPosition", self.ladyDic[arg_21_1].ladyEnv)
		self.ladyDic[arg_21_1].ladyEnv:PlaySingleAction(SlideConst.IDLE_ANIM)
		self.ladyDic[arg_21_1]:Dispose()

		self.ladyDic[arg_21_1] = nil
	end

	return
end

function SlideExtraSystem:OnPick()
	if #self.inviteList == 0 then
		return
	end

	self.currentGroupId = self:RandomPick()

	if self.ladyDic[self.currentGroupId].ladyEnv:GetBlackboardValue("inWatchMode") then
		if #self.inviteList > 1 then
			self:OnPick()
		end

		return
	end

	self.ladyDic[self.currentGroupId]:StartMove()

	return
end

function SlideExtraSystem:RandomPick()
	if not self.randomList or #self.randomList == 0 then
		self.randomList = Clone(self.inviteList)
	end

	local var_23_0 = math.random(1, #self.randomList)

	table.remove(self.randomList, var_23_0)

	return self.randomList[var_23_0]
end

function SlideExtraSystem:TestMove()
	for iter_24_0, iter_24_1 in pairs(self.ladyDic) do
		iter_24_1:EndMove()
		iter_24_1:StartMove()

		self.currentGroupId = iter_24_1.id

		return
	end

	return
end

function SlideExtraSystem:UpdateSlideInviteList(arg_25_1, arg_25_2)
	if table.contains(arg_25_2, self.currentGroupId) then
		self.ladyDic[self.currentGroupId]:EndMove()
	end

	_.each(arg_25_2, function(arg_26_0)
		self:RemoveLadySlide(arg_26_0)
		table.removebyvalue(self.inviteList, arg_26_0)
		table.removebyvalue(self.randomList, arg_26_0)

		return
	end)
	_.each(arg_25_1, function(arg_27_0)
		if not table.contains(self.inviteList, arg_27_0) then
			table.insert(self.inviteList, arg_27_0)
			self:AddLadySlide(arg_27_0)
		end

		if not table.contains(self.randomList, arg_27_0) then
			table.insert(self.randomList, arg_27_0)
		end

		return
	end)

	return
end

function SlideExtraSystem:PlayVFX(arg_28_1)
	local var_28_0 = self.sceneSlideConfigs:Find("vfx/" .. arg_28_1)

	setActive(var_28_0, false)
	onNextTick(function()
		setActive(var_28_0, true)

		return
	end)

	return
end

return SlideExtraSystem
