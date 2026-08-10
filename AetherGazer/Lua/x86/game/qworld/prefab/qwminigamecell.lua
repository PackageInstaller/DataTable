local function var_0_0(arg_1_0, arg_1_1)
	arg_1_0.localData.isStart = false

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.localData.cell_uniqueId_list) do
		QWorldMgr:GetQWorldEntityMgr():GetEnt(iter_1_1):PushEvent(arg_1_1 and "cell_game_success" or "cell_game_fail")
	end

	QWorldChangeInteractionModeImeediate(QWorldInteractionMode.FULL)

	if arg_1_1 then
		manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_game_maze_finish", "")
	else
		manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_game_maze_lose", "")
	end

	QWorldMgr:ExitCustomCamera(arg_1_0.entity:GetMiniGameCamera())

	for iter_1_2, iter_1_3 in pairs(arg_1_0.children) do
		iter_1_2:Remove()
	end

	arg_1_0.localData.cell_uniqueId_list = {}
	arg_1_0.localData.cell_uniqueId_process = {}
	arg_1_0.localData.last_cell_uniqueId = nil

	arg_1_0.entity:SetBuild(arg_1_0.config.startLoopEffect)
	arg_1_0:ChangeInteractive(true)
	manager.notify:RemoveListener(QWORLD_TELEPORT, arg_1_0.teleportCallBack)
	manager.notify:RemoveListener(QWORLD_RESTART, arg_1_0.teleportCallBack)

	local var_1_0 = manager.time:GetServerTime() - (arg_1_0.localData.startTime or 0)

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = QWorldMgr:GetActivityId(),
		stage_id = QWorldMgr:GetMapId(),
		result = arg_1_1 and 1 or 2,
		task_id = arg_1_0.entityId,
		use_seconds = var_1_0 or 0
	})
	QWorldMgr:GetQWorldQuestMgr():OnMiniGameChangeState(arg_1_0.entityId, arg_1_1)
end

local function var_0_1(arg_2_0, arg_2_1)
	if not arg_2_0.localData.isStart then
		return
	end

	local var_2_0 = table.indexof(arg_2_0.localData.cell_uniqueId_process, arg_2_1.cell_uniqueId)

	if var_2_0 then
		QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_2_1.cell_uniqueId):PushEvent("cell_correct")
		table.remove(arg_2_0.localData.cell_uniqueId_process, var_2_0)
	else
		var_0_0(arg_2_0, false)

		return
	end

	if #arg_2_0.localData.cell_uniqueId_process == 0 then
		var_0_0(arg_2_0, true)
	else
		if arg_2_0.localData.last_cell_uniqueId then
			QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_2_0.localData.last_cell_uniqueId):PushEvent("cell_correct_level")
		else
			arg_2_0.entity:SetBuild(arg_2_0.config.collectNormalEffect)
		end

		arg_2_0.localData.last_cell_uniqueId = arg_2_1.cell_uniqueId

		manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_game_maze_normal", "")
	end
end

local function var_0_2(arg_3_0)
	if arg_3_0.localData.isStart == true then
		return
	end

	manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_game_maze_start", "")
	QWorldLuaBridge.StopControl(true)

	local var_3_0

	var_3_0 = Timer.New(function()
		QWorldLuaBridge.StopControl(false)
		var_3_0:Stop()

		var_3_0 = nil
	end, 1, 1)

	var_3_0:Start()

	arg_3_0.localData.isStart = true
	arg_3_0.localData.cell_uniqueId_list = {}
	arg_3_0.localData.cell_uniqueId_process = {}
	arg_3_0.localData.last_cell_uniqueId = nil

	arg_3_0.entity:SetBuild(arg_3_0.config.collectDirEffect)
	arg_3_0:ChangeInteractive(false)
	QWorldMgr:EnableCamera(QWorldCameraFlag.CustomCamera, arg_3_0.entity:GetMiniGameCamera(), QWorldCameraLayer.MiniGame)
	QWorldChangeInteractionModeImeediate(QWorldInteractionMode.ONLY_CONTROL_WALK)

	local var_3_1 = QWorldLuaBridge.GetMapEntityData(arg_3_0.entityId)
	local var_3_2 = var_3_1.entity_child_list.Count

	for iter_3_0 = 0, var_3_2 - 1 do
		local var_3_3 = var_3_1.entity_child_list[iter_3_0]
		local var_3_4 = QWorldLuaBridge.GetMapEntityData(var_3_3)
		local var_3_5 = var_3_4.script_name
		local var_3_6 = arg_3_0:SpawnChild(var_3_5, var_3_3, var_3_4.configId)

		if var_3_5 == "QWMiniGameCellUnit" then
			table.insert(arg_3_0.localData.cell_uniqueId_list, var_3_6.uniqueId)
			table.insert(arg_3_0.localData.cell_uniqueId_process, var_3_6.uniqueId)
			arg_3_0:ListenForEvent("cell_state", function(arg_5_0, arg_5_1)
				var_0_1(arg_3_0, arg_5_1)
			end, var_3_6)
		end
	end

	arg_3_0.localData.startTime = manager.time:GetServerTime()

	manager.notify:RegistListener(QWORLD_TELEPORT, arg_3_0.teleportCallBack)
	manager.notify:RegistListener(QWORLD_RESTART, arg_3_0.teleportCallBack)
end

local function var_0_3(arg_6_0, arg_6_1)
	if arg_6_1 and arg_6_0.localData.isStart then
		var_0_0(arg_6_0, false)
	end
end

local function var_0_4(arg_7_0)
	var_0_0(arg_7_0, false)
end

local function var_0_5(arg_8_0)
	manager.notify:RemoveListener(QWORLD_TELEPORT, arg_8_0.teleportCallBack)
	manager.notify:RemoveListener(QWORLD_RESTART, arg_8_0.teleportCallBack)
end

local function var_0_6(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.entity:AddBubbleTag(QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.MINI_GAME_CELL, arg_9_0:GetBubbleName(), arg_9_0:GetBubbleIcon())
	else
		arg_9_0.entity:RemoveBubbleTag(QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.MINI_GAME_CELL)
	end
end

local function var_0_7(arg_10_0, arg_10_1)
	local var_10_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_10_0, arg_10_1, QWORLD_ENTITY_TYPE.DEFAULT)

	var_10_0.config = QWorldLuaBridge.GetMapEntityData(var_10_0.entityId)

	var_10_0.entity:SetBuild(var_10_0.config.startLoopEffect)
	var_10_0.entity:SetCheckBubbbleRange(1)
	var_10_0.entity:AddComponent("QWBoxTriggerArea")

	var_10_0.OnQWBoxTriggerArea = var_0_3

	function var_10_0.entity.bubbleClick(arg_11_0)
		if arg_11_0 == QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.MINI_GAME_CELL then
			QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.FIND_ROUTE, arg_10_1, "", var_10_0.entityId)
			var_0_2(var_10_0)
		end
	end

	var_10_0:ResetChangeBubble(var_0_6)

	function var_10_0.teleportCallBack()
		var_0_4(var_10_0)
	end

	var_10_0.OnRemoveEntity = var_0_5

	return var_10_0
end

return QWorldPrefab.New("QWMiniGameCell", var_0_7)
