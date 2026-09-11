require("game/qworld/bubble/QWorldBubbleLuaBridge")
require("game/qworld/story/QWorldStoryLuaBridge")
require("game/qworld/prefabScript/QWorldEntityLuaBridge")

function LaunchQWorld(arg_1_0, arg_1_1)
	DestroyLua()
	QWorldData:SetIsBackQWorld(arg_1_0)

	local var_1_0 = "1031001"

	if arg_1_0 then
		var_1_0 = QWorldMgr:GetMapId()
	elseif arg_1_1 then
		QWorldData:SetCurActivityId(arg_1_1)

		var_1_0 = tostring(QWorldMgr:GetMapId())
	end

	QWorldLuaBridge.EntraceLauncher(var_1_0, QWorldMgr:GetMapHeroId() or 9070)
end

function PostEnterQWorld()
	manager.audio:AddCue("effect", "ui_sandplay", false)
	manager.uiInit()
	gameContext:SetSystemLayer("battle")
	manager.windowBar:SetWhereTag("qworld")
	QWorldMgr:EnterQWorld()
end

function OnQWorldLoaded()
	QWorldMgr:OnQWorldLoaded()
	QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.ENTER, -1, "", -1)
end

function PostExitQWorld()
	QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.EXIT, -1, "", -1)
	QWorldMgr:DisposeQueue()
	DestroyLua()
	manager.windowBar:ClearWhereTag()
	QWorldMgr:PostExitQWorld()
	QWorldMgr:ExitQWorld()
	manager.audio:RemoveCue("ui_sandplay")
	QWorldData:SetCurSceneName(nil)
end

function GetQworldStoryContent(arg_5_0)
	return QWorldStoryWordCfg[arg_5_0] or nil
end

function QWorldUIShowWithBlank()
	gameContext:Go("/springPreheatBlank")
	QWorldUIShow()
end

function QWorldUIShow()
	gameContext:Go("/springPreheatBlank/qworldMainHome")
end

function QWorldUIHide()
	gameContext:Go("/springPreheatBlank")
end

function ForceStopAllPerformTask()
	QWorldMgr:GetQWorldPerformMgr():ForceStopAllTask()
end

function GetQWorldSceneName(arg_10_0)
	QWorldData:SetCurMapId(tonumber(arg_10_0))

	local var_10_0 = SandplaySettingCfg[string.format("scene_after_task_%s", arg_10_0)]

	if var_10_0 then
		if QWorldQuestTool.IsMainQuestFinish(var_10_0.value[2]) then
			return var_10_0.value[1]
		end
	end
end

function PlayQWorldBgm()
	QWorldMgr:GetQWorldSoundMgr():InitMapSound(QWorldData:GetCurMapId())
end

function PostEnterQWorldScene(arg_12_0)
	if QWorldData:GetCurSceneName() ~= arg_12_0 then
		QWorldData:SetCurSceneName(arg_12_0)
		print(string.format("进入场景%s", arg_12_0))
		manager.notify:Invoke(QWORLD_RESTART)
		PlayQWorldBgm()

		if arg_12_0 == "X510a" then
			QWorldMgr:GetQWorldEntityMgr():RebuildEntity(QWORLD_ENTITY_TYPE.FUNITURE)
		end
	end
end

function QWorldTeleport(arg_13_0, arg_13_1)
	QWorldMgr:StartBlackFade(1, 1, 1, function()
		manager.notify:Invoke(QWORLD_TELEPORT, arg_13_0)
		QWorldLuaBridge.Teleport(arg_13_0, true)
	end, function()
		if arg_13_1 then
			arg_13_1()
		end
	end)
end

function QWorldTeleportToNearest(arg_16_0)
	QWorldMgr:StartBlackFade(1, 1, 1, function()
		QWorldLuaBridge.TeleportToNearest(arg_16_0)
	end)
end

function QWorldTeleportWithoutBlackFade(arg_18_0)
	manager.notify:Invoke(QWORLD_TELEPORT, arg_18_0)
	QWorldLuaBridge.Teleport(arg_18_0)
end

function GM_QWorldJumpStory()
	QWorldMgr:GetQWorldStoryMgr():StopStory()
end

function CancelTrack(arg_20_0)
	local var_20_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_20_0)

	if var_20_0.thingCfg and var_20_0.thingCfg.hud and SandplayTagCfg[var_20_0.thingCfg.hud] and not table.indexof(QWorldQuestTool.GetCurQuestTrackingEntityIdList(), arg_20_0) then
		QWorldMgr:GetQWorldEntityMgr():CancelTrack(arg_20_0)
		ShowTips("SANDPLAY_REACH_TARGET")
	end
end

function SendGM(arg_21_0)
	arg_21_0 = "$ " .. arg_21_0

	print(arg_21_0)
	manager.net:SendWithLoadingNew(27100, {
		content = arg_21_0
	}, 27101, function(arg_22_0, arg_22_1)
		print("Send Msg Return:", arg_22_0.result)
		ShowTips(arg_22_0.result)
	end)
end

function GM_ChangeScene(arg_23_0)
	QWorldLuaBridge.Restart(arg_23_0)
end

function GM_FinishCurSubQuest()
	local var_24_0 = QWorldQuestTool.GetMainQuestTrackingId()

	if var_24_0 == -1 then
		ShowTips("当前没有追踪的任务")

		return
	end

	for iter_24_0, iter_24_1 in ipairs((QWorldQuestTool.GetVisibleQuestIdList(var_24_0, true))) do
		SendGM(string.format("xt rw pass %s", iter_24_1))
	end
end

function GM_AddQuest(arg_25_0, arg_25_1)
	if arg_25_1 then
		SendGM(string.format("xt zrw add %s", arg_25_0))
	else
		SendGM(string.format("xt rw add %s", arg_25_0))
	end
end

function GM_FinishQuest(arg_26_0, arg_26_1)
	if arg_26_1 then
		SendGM(string.format("xt zrw pass %s", arg_26_0))
	else
		SendGM(string.format("xt rw pass %s", arg_26_0))
	end
end

function GM_GetTaskData(arg_27_0)
	local var_27_0 = {}
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(SandplayTaskCfg.all) do
		if SandplayTaskMainCfg[SandplayTaskCfg[iter_27_1].main_task_id] then
			if SandplayTaskMainCfg[SandplayTaskCfg[iter_27_1].main_task_id].activity_id == arg_27_0 then
				table.insert(var_27_0, {
					[0] = SandplayTaskCfg[iter_27_1].task_target,
					iter_27_1
				})
			end
		else
			Debug.LogError(string.format("任务%s没有对应的主线任务", iter_27_1))
		end
	end

	for iter_27_2, iter_27_3 in ipairs(SandplayTaskMainCfg.all) do
		if SandplayTaskMainCfg[iter_27_3].activity_id == arg_27_0 then
			table.insert(var_27_1, {
				[0] = SandplayTaskMainCfg[iter_27_3].title,
				iter_27_3
			})
		end
	end

	return var_27_0, var_27_1
end

function QWorldChangeInteractionMode(arg_28_0)
	manager.notify:Invoke(QWORLD_INTERACTION_CHANGE, arg_28_0)
end

function QWorldChangeInteractionModeImeediate(arg_29_0)
	QWorldLuaBridge.ChangeInteractionMode(arg_29_0)
end
