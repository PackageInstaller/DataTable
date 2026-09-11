local BaseStoryGraph = class("BaseStoryGraph")

function BaseStoryGraph:Ctor()
	self:Init()
end

function BaseStoryGraph:Identify()
	return ""
end

function BaseStoryGraph:ConfigPath()
	return ""
end

function BaseStoryGraph:BuildContext()
	self.nextCallback = nil
	self.blackboardObj = GameObject.Instantiate(Asset.Load(self:ConfigPath()))

	if isNil(self.blackboardObj) then
		Debug.LogError("错误,不存在的剧情蓝图路径: " .. self:ConfigPath())
	end

	self.blackboardObj.transform.position = Vector3.zero
	self.blackboardObj.transform.rotation = Quaternion.identity
	self.blackboardObj.transform.localScale = Vector3.one
	self.blackboard = self.blackboardObj:GetComponent(typeof(QWorld.Story.Runtime.QWStoryGraphBlackboard))

	if isNil(self.blackboard) then
		Debug.LogError("故事是空的?")
	end

	if self.blackboard.GraphIdentify ~= self:Identify() then
		Debug.LogError("错误,剧情配置与剧情蓝图不匹配，配置Identify: " .. self.blackboard.GraphIdentify .. " 蓝图Identify: " .. self:Identify())
	end

	self.updateIdentity = 1
	self.updateDelegate = {}
	self.delayIdentity = 1
	self.delayDelegate = {}
	self.delayDirty = {}
	self.historyContent = {}
	self.isChangeBGM = false
	self.funcMap = {}
	self.autoTaskList = {}
	self.startTimer = Time.time
	self.lastTimer = Time.time
	self.timer = FrameTimer.New(function()
		self:Update(Time.time - self.lastTimer)
	end, 1, -1)

	self.timer:Start()

	self.context = {
		auto = {
			isInAuto = false
		}
	}
	self.recoverStack = GameToSDK.IsIOSPlatform() and {
		birdsCull = true,
		walkingPeopleCull = QWorldLuaBridge.WalkingPeopleGlobleCull
	} or {
		birdsCull = QWorldLuaBridge.BirdsGlobleCull,
		walkingPeopleCull = QWorldLuaBridge.WalkingPeopleGlobleCull
	}
end

function BaseStoryGraph:Init()
	self:BuildContext()
	self:InjectInterface()
end

function BaseStoryGraph:InjectInterface()
	import("game.qworld.story.graph.interface." .. "TalkInterface"):Inject(self)
	import("game.qworld.story.graph.interface." .. "ActionInterface"):Inject(self)
	import("game.qworld.story.graph.interface." .. "EventInterface"):Inject(self)
	import("game.qworld.story.graph.interface." .. "ActorRoleInterface"):Inject(self)
	import("game.qworld.story.graph.interface." .. "ThingInterface"):Inject(self)
	import("game.qworld.story.graph.interface." .. "EffectInterface"):Inject(self)
	import("game.qworld.story.graph.interface." .. "OutStoryInterface"):Inject(self)
end

function BaseStoryGraph:Update(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self.updateDelegate) do
		iter_8_1(arg_8_1)
	end

	self.delayDirty = {}

	for iter_8_2, iter_8_3 in pairs(self.delayDelegate) do
		if Time.time - iter_8_3.startTime >= iter_8_3.duration then
			iter_8_3.action()

			self.delayDirty[iter_8_2] = true
		end
	end

	for iter_8_4, iter_8_5 in pairs(self.delayDirty) do
		self.delayDelegate[iter_8_4] = nil
	end

	self:OnAuto(arg_8_1)
	self:OnUpdate(arg_8_1)
end

function BaseStoryGraph:OnUpdate(arg_9_1)
	return
end

function BaseStoryGraph:ChangeAutoPlayState(arg_10_1)
	self.context.auto.isInAuto = arg_10_1
end

function BaseStoryGraph:GetAutoPlayState()
	return self.context.auto.isInAuto
end

function BaseStoryGraph:OnAuto(arg_12_1)
	local var_12_0 = QWorldMgr:GetQWorldStoryMgr():GetTalkView()

	if not self.context.auto.isInAuto then
		return
	end

	local var_12_1 = false

	if self.autoTaskList[1] then
		local var_12_2 = true

		for iter_12_0, iter_12_1 in ipairs(self.autoTaskList) do
			if not iter_12_1.isComplete then
				var_12_2 = false

				break
			end
		end

		var_12_1 = var_12_2
	else
		var_12_1 = true
	end

	if var_12_1 and var_12_0:GetCanAutoNext() then
		self:Next()
		var_12_0:ClearCanAutoFlag()
	end
end

function BaseStoryGraph:OnAutoTaskComplete()
	self.isComplete = true
end

function BaseStoryGraph:AddAutoTask(arg_14_1)
	local var_14_0 = {
		isComplete = false,
		nodeType = arg_14_1
	}

	function var_14_0.Complete()
		BaseStoryGraph.OnAutoTaskComplete(var_14_0)
	end

	table.insert(self.autoTaskList, var_14_0)

	return var_14_0
end

function BaseStoryGraph:OnNext(arg_16_1)
	if self.context.immediateNextFlag ~= nil then
		self.context.immediateNextFlag = nil

		arg_16_1(self.context.immediateNextFlag)
	else
		self.nextCallback = arg_16_1
	end
end

function BaseStoryGraph:Next(arg_17_1)
	if self.nextCallback then
		self.autoTaskList = {}

		self.nextCallback(arg_17_1)
	end
end

function BaseStoryGraph:Skip(arg_18_1)
	local var_18_0 = false

	if arg_18_1 and arg_18_1 ~= "" and self.funcMap[arg_18_1] then
		var_18_0 = true

		self:ClearOnNext()
		QWorldMgr:StartBlackFade(0.2, 0.3, 0.5, function()
			self.funcMap[arg_18_1](self)
		end)
	end

	if not var_18_0 then
		self:EndStory()
	end
end

function BaseStoryGraph:ClearOnNext()
	QWorldMgr:GetQWorldStoryMgr():GetTalkView():OnAllBtnClick()
	self.blackboard:StopCameraShake()
	self.blackboard:ClearOnNext()

	self.updateIdentity = 1
	self.updateDelegate = {}
	self.nextCallback = nil
end

function BaseStoryGraph:Start()
	local var_21_0

	if QWorldMgr:GetQWorldStoryMgr():GetTarget() ~= nil then
		var_21_0 = QWorldMgr:GetQWorldStoryMgr():GetTarget().entity
	end

	local var_21_1 = tonumber(self:Identify())

	if var_21_1 and SandplayStoryCfg[var_21_1] and SandplayStoryCfg[var_21_1].story_type == 2 then
		QWorldMgr:EnableCamera(QWorldCameraFlag.Story)
	end

	self.blackboard:PreStart(var_21_0, SandplayStoryCfg[var_21_1].story_type, SandplayStoryCfg[var_21_1].story_orientation ~= 1)

	if isNil(self.blackboard) then
		return
	end

	local var_21_2 = QWorldMgr:GetQWorldStoryMgr():GetTalkView()

	var_21_2:Show()
	var_21_2:ChangeAutoState(false)
	self:StartStory()
end

function BaseStoryGraph:StartStory()
	return
end

function BaseStoryGraph:EndStory()
	QWorldMgr:GetQWorldStoryMgr():StopStory()
end

function BaseStoryGraph:RecoverEnv()
	if not GameToSDK.IsIOSPlatform() then
		QWorldLuaBridge.BirdsGlobleCull = self.recoverStack.birdsCull
	end

	QWorldLuaBridge.WalkingPeopleGlobleCull = self.recoverStack.walkingPeopleCull
end

function BaseStoryGraph:OnStopStory()
	self:RecoverEnv()
	QWorldMgr:GetQWorldStoryMgr():GetTalkView():SetCanShow(true)

	if self.isChangeBGM then
		local var_25_0 = QWorldMgr:GetQWorldSoundMgr().curSound

		if var_25_0 then
			manager.audio:PlayBGM(var_25_0.cueSheet, var_25_0.cueName, var_25_0.cueName)
		end
	end

	self:DisposeEvent()
	self:DisposeEffect()
	self.blackboard:PreStop()
	self:Dispose()
end

function BaseStoryGraph:PreContinueStop()
	self:DisposeEvent()
	self:DisposeEffect()
	self:Dispose()
end

function BaseStoryGraph:SetImmediateNextFlag(arg_27_1)
	if self.nextCallback then
		self:Next(arg_27_1)
	else
		self.context.immediateNextFlag = arg_27_1
	end
end

function BaseStoryGraph:RegisterUpdateAction(arg_28_1)
	self.updateIdentity = self.updateIdentity + 1
	self.updateDelegate[self.updateIdentity] = arg_28_1

	return self.updateIdentity
end

function BaseStoryGraph:RemoveUpdateAction(arg_29_1)
	self.updateDelegate[arg_29_1] = nil
end

function BaseStoryGraph:RegisterDelayAction(arg_30_1, arg_30_2)
	self.delayIdentity = self.delayIdentity + 1
	self.delayDelegate[self.delayIdentity] = {
		startTime = Time.time,
		action = arg_30_1,
		duration = arg_30_2
	}

	return self.delayIdentity
end

function BaseStoryGraph:RemoveDelayAction(arg_31_1)
	self.delayDelegate[arg_31_1] = nil
end

function BaseStoryGraph:RegisterTalkFunction(arg_32_1, arg_32_2)
	self.funcMap[arg_32_1] = arg_32_2
end

function BaseStoryGraph:RememberHistory(arg_33_1)
	table.insert(self.historyContent, arg_33_1)
end

function BaseStoryGraph:GetHistory()
	return self.historyContent
end

function BaseStoryGraph:Dispose()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.blackboard:Dispose()

	self.blackboard = nil

	GameObject.Destroy(self.blackboardObj)
	Asset.Unload(self:ConfigPath())
end

return BaseStoryGraph
