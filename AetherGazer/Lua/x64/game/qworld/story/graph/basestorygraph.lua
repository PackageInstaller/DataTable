local var_0_0 = class("BaseStoryGraph")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Identify(arg_2_0)
	return ""
end

function var_0_0.ConfigPath(arg_3_0)
	return ""
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.nextCallback = nil
	arg_4_0.blackboardObj = GameObject.Instantiate(Asset.Load(arg_4_0:ConfigPath()))

	if isNil(arg_4_0.blackboardObj) then
		Debug.LogError("错误,不存在的剧情蓝图路径: " .. arg_4_0:ConfigPath())
	end

	arg_4_0.blackboardObj.transform.position = Vector3.zero
	arg_4_0.blackboardObj.transform.rotation = Quaternion.identity
	arg_4_0.blackboardObj.transform.localScale = Vector3.one
	arg_4_0.blackboard = arg_4_0.blackboardObj:GetComponent(typeof(QWorld.Story.Runtime.QWStoryGraphBlackboard))

	if isNil(arg_4_0.blackboard) then
		Debug.LogError("故事是空的?")
	end

	if arg_4_0.blackboard.GraphIdentify ~= arg_4_0:Identify() then
		Debug.LogError("错误,剧情配置与剧情蓝图不匹配，配置Identify: " .. arg_4_0.blackboard.GraphIdentify .. " 蓝图Identify: " .. arg_4_0:Identify())
	end

	arg_4_0.updateIdentity = 1
	arg_4_0.updateDelegate = {}
	arg_4_0.delayIdentity = 1
	arg_4_0.delayDelegate = {}
	arg_4_0.delayDirty = {}
	arg_4_0.historyContent = {}
	arg_4_0.isChangeBGM = false
	arg_4_0.funcMap = {}
	arg_4_0.autoTaskList = {}
	arg_4_0.startTimer = Time.time
	arg_4_0.lastTimer = Time.time
	arg_4_0.timer = FrameTimer.New(function()
		local var_5_0 = Time.time - arg_4_0.lastTimer

		arg_4_0:Update(var_5_0)
	end, 1, -1)

	arg_4_0.timer:Start()

	arg_4_0.context = {
		auto = {
			isInAuto = false
		}
	}

	if GameToSDK.IsIOSPlatform() then
		arg_4_0.recoverStack = {
			birdsCull = true,
			walkingPeopleCull = QWorldLuaBridge.WalkingPeopleGlobleCull
		}
	else
		arg_4_0.recoverStack = {
			birdsCull = QWorldLuaBridge.BirdsGlobleCull,
			walkingPeopleCull = QWorldLuaBridge.WalkingPeopleGlobleCull
		}
	end
end

function var_0_0.Init(arg_6_0)
	arg_6_0:BuildContext()
	arg_6_0:InjectInterface()
end

function var_0_0.InjectInterface(arg_7_0)
	local var_7_0 = "game.qworld.story.graph.interface."

	import(var_7_0 .. "TalkInterface"):Inject(arg_7_0)
	import(var_7_0 .. "ActionInterface"):Inject(arg_7_0)
	import(var_7_0 .. "EventInterface"):Inject(arg_7_0)
	import(var_7_0 .. "ActorRoleInterface"):Inject(arg_7_0)
	import(var_7_0 .. "ThingInterface"):Inject(arg_7_0)
	import(var_7_0 .. "EffectInterface"):Inject(arg_7_0)
	import(var_7_0 .. "OutStoryInterface"):Inject(arg_7_0)
end

function var_0_0.Update(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.updateDelegate) do
		iter_8_1(arg_8_1)
	end

	arg_8_0.delayDirty = {}

	for iter_8_2, iter_8_3 in pairs(arg_8_0.delayDelegate) do
		if Time.time - iter_8_3.startTime >= iter_8_3.duration then
			iter_8_3.action()

			arg_8_0.delayDirty[iter_8_2] = true
		end
	end

	for iter_8_4, iter_8_5 in pairs(arg_8_0.delayDirty) do
		arg_8_0.delayDelegate[iter_8_4] = nil
	end

	arg_8_0:OnAuto(arg_8_1)
	arg_8_0:OnUpdate(arg_8_1)
end

function var_0_0.OnUpdate(arg_9_0, arg_9_1)
	return
end

function var_0_0.ChangeAutoPlayState(arg_10_0, arg_10_1)
	arg_10_0.context.auto.isInAuto = arg_10_1
end

function var_0_0.GetAutoPlayState(arg_11_0)
	return arg_11_0.context.auto.isInAuto
end

function var_0_0.OnAuto(arg_12_0, arg_12_1)
	local var_12_0 = QWorldMgr:GetQWorldStoryMgr():GetTalkView()

	if not arg_12_0.context.auto.isInAuto then
		return
	end

	local var_12_1 = false

	if arg_12_0.autoTaskList[1] then
		local var_12_2 = true

		for iter_12_0, iter_12_1 in ipairs(arg_12_0.autoTaskList) do
			if not iter_12_1.isComplete then
				var_12_2 = false

				break
			end
		end

		var_12_1 = var_12_2
	else
		var_12_1 = true
	end

	local var_12_3 = var_12_0:GetCanAutoNext()

	if var_12_1 and var_12_3 then
		arg_12_0:Next()
		var_12_0:ClearCanAutoFlag()
	end
end

function var_0_0.OnAutoTaskComplete(arg_13_0)
	arg_13_0.isComplete = true
end

function var_0_0.AddAutoTask(arg_14_0, arg_14_1)
	local var_14_0 = {
		isComplete = false,
		nodeType = arg_14_1
	}

	function var_14_0.Complete()
		var_0_0.OnAutoTaskComplete(var_14_0)
	end

	table.insert(arg_14_0.autoTaskList, var_14_0)

	return var_14_0
end

function var_0_0.OnNext(arg_16_0, arg_16_1)
	if arg_16_0.context.immediateNextFlag ~= nil then
		local var_16_0 = arg_16_0.context.immediateNextFlag

		arg_16_0.context.immediateNextFlag = nil

		arg_16_1(var_16_0)
	else
		arg_16_0.nextCallback = arg_16_1
	end
end

function var_0_0.Next(arg_17_0, arg_17_1)
	if arg_17_0.nextCallback then
		arg_17_0.autoTaskList = {}

		arg_17_0.nextCallback(arg_17_1)
	end
end

function var_0_0.Skip(arg_18_0, arg_18_1)
	local var_18_0 = false

	if arg_18_1 and arg_18_1 ~= "" and arg_18_0.funcMap[arg_18_1] then
		var_18_0 = true

		arg_18_0:ClearOnNext()
		QWorldMgr:StartBlackFade(0.2, 0.3, 0.5, function()
			arg_18_0.funcMap[arg_18_1](arg_18_0)
		end)
	end

	if not var_18_0 then
		arg_18_0:EndStory()
	end
end

function var_0_0.ClearOnNext(arg_20_0)
	QWorldMgr:GetQWorldStoryMgr():GetTalkView():OnAllBtnClick()
	arg_20_0.blackboard:StopCameraShake()
	arg_20_0.blackboard:ClearOnNext()

	arg_20_0.updateIdentity = 1
	arg_20_0.updateDelegate = {}
	arg_20_0.nextCallback = nil
end

function var_0_0.Start(arg_21_0)
	local var_21_0

	if QWorldMgr:GetQWorldStoryMgr():GetTarget() ~= nil then
		var_21_0 = QWorldMgr:GetQWorldStoryMgr():GetTarget().entity
	end

	local var_21_1 = tonumber(arg_21_0:Identify())

	if var_21_1 and SandplayStoryCfg[var_21_1] and SandplayStoryCfg[var_21_1].story_type == 2 then
		QWorldMgr:EnableCamera(QWorldCameraFlag.Story)
	end

	local var_21_2 = true

	if SandplayStoryCfg[var_21_1].story_orientation == 1 then
		var_21_2 = false
	end

	arg_21_0.blackboard:PreStart(var_21_0, SandplayStoryCfg[var_21_1].story_type, var_21_2)

	if isNil(arg_21_0.blackboard) then
		return
	end

	local var_21_3 = QWorldMgr:GetQWorldStoryMgr():GetTalkView()

	var_21_3:Show()
	var_21_3:ChangeAutoState(false)
	arg_21_0:StartStory()
end

function var_0_0.StartStory(arg_22_0)
	return
end

function var_0_0.EndStory(arg_23_0)
	QWorldMgr:GetQWorldStoryMgr():StopStory()
end

function var_0_0.RecoverEnv(arg_24_0)
	if not GameToSDK.IsIOSPlatform() then
		QWorldLuaBridge.BirdsGlobleCull = arg_24_0.recoverStack.birdsCull
	end

	QWorldLuaBridge.WalkingPeopleGlobleCull = arg_24_0.recoverStack.walkingPeopleCull
end

function var_0_0.OnStopStory(arg_25_0)
	arg_25_0:RecoverEnv()
	QWorldMgr:GetQWorldStoryMgr():GetTalkView():SetCanShow(true)

	if arg_25_0.isChangeBGM then
		local var_25_0 = QWorldMgr:GetQWorldSoundMgr().curSound

		if var_25_0 then
			manager.audio:PlayBGM(var_25_0.cueSheet, var_25_0.cueName, var_25_0.cueName)
		end
	end

	arg_25_0:DisposeEvent()
	arg_25_0:DisposeEffect()
	arg_25_0.blackboard:PreStop()
	arg_25_0:Dispose()
end

function var_0_0.PreContinueStop(arg_26_0)
	arg_26_0:DisposeEvent()
	arg_26_0:DisposeEffect()
	arg_26_0:Dispose()
end

function var_0_0.SetImmediateNextFlag(arg_27_0, arg_27_1)
	if arg_27_0.nextCallback then
		arg_27_0:Next(arg_27_1)
	else
		arg_27_0.context.immediateNextFlag = arg_27_1
	end
end

function var_0_0.RegisterUpdateAction(arg_28_0, arg_28_1)
	arg_28_0.updateIdentity = arg_28_0.updateIdentity + 1
	arg_28_0.updateDelegate[arg_28_0.updateIdentity] = arg_28_1

	return arg_28_0.updateIdentity
end

function var_0_0.RemoveUpdateAction(arg_29_0, arg_29_1)
	arg_29_0.updateDelegate[arg_29_1] = nil
end

function var_0_0.RegisterDelayAction(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.delayIdentity = arg_30_0.delayIdentity + 1
	arg_30_0.delayDelegate[arg_30_0.delayIdentity] = {
		startTime = Time.time,
		action = arg_30_1,
		duration = arg_30_2
	}

	return arg_30_0.delayIdentity
end

function var_0_0.RemoveDelayAction(arg_31_0, arg_31_1)
	arg_31_0.delayDelegate[arg_31_1] = nil
end

function var_0_0.RegisterTalkFunction(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.funcMap[arg_32_1] = arg_32_2
end

function var_0_0.RememberHistory(arg_33_0, arg_33_1)
	table.insert(arg_33_0.historyContent, arg_33_1)
end

function var_0_0.GetHistory(arg_34_0)
	return arg_34_0.historyContent
end

function var_0_0.Dispose(arg_35_0)
	if arg_35_0.timer then
		arg_35_0.timer:Stop()

		arg_35_0.timer = nil
	end

	arg_35_0.blackboard:Dispose()

	arg_35_0.blackboard = nil

	GameObject.Destroy(arg_35_0.blackboardObj)
	Asset.Unload(arg_35_0:ConfigPath())
end

return var_0_0
