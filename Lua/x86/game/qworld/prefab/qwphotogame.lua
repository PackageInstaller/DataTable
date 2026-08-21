local function var_0_0(arg_1_0)
	JumpTools.OpenPageByJump("/sandPlayTakePhotoView", {
		configID = arg_1_0.configId
	})
end

local function var_0_1(arg_2_0)
	arg_2_0:Remove()
	QWorldMgr:ExitCustomCamera(arg_2_0.entity:GetMiniGameCamera())
	QWorldMgr:CullDynamic(false)
	QWorldLuaBridge.HidePlayer(false)

	if arg_2_0.localData.isTake == false then
		return
	end

	arg_2_0.localData.isTake = false

	local var_2_0 = QWorldData:GetCachedPosition()
	local var_2_1 = {
		var_2_0[1],
		",",
		var_2_0[2],
		",",
		var_2_0[3]
	}

	SDKTools.SendMessageToSDK("activity_sandplay_act", {
		type = 12,
		activity_id = QWorldMgr:GetActivityId(),
		stage_id = QWorldMgr:GetMapId(),
		location_id = table.concat(var_2_1),
		params_select = SandplayThingCfg[arg_2_0.configId].hud
	})
	manager.notify:RemoveListener(QWORLD_TAKE_PHOTO, arg_2_0.takePhotoCallBack)
	manager.notify:RemoveListener(QWORLD_TAKE_PHOTO_SNAP, arg_2_0.snapCallBack)

	local var_2_2 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_2_0.entity.entityId)

	if var_2_2 then
		var_2_2:RemoveMiniMapEntity(QWorldEntityMiniMapTag.Thing, SandplayThingCfg[arg_2_0.configId].label[1])
	end

	QWorldMgr:GetQWorldQuestMgr():OnMiniGameChangeState(arg_2_0.entityId, true)
end

local function var_0_2(arg_3_0)
	QWorldMgr:CullDynamic(true, nil, {
		QWorldAgentLayer.NPC
	})
	QWorldLuaBridge.HidePlayer(true)
	manager.notify:RegistListener(QWORLD_TAKE_PHOTO, arg_3_0.takePhotoCallBack)
	manager.notify:RegistListener(QWORLD_TAKE_PHOTO_SNAP, arg_3_0.snapCallBack)

	if arg_3_0.localData.isTake == true then
		return
	end

	arg_3_0.localData.isTake = true

	arg_3_0:ChangeInteractive(false)
	JumpTools.OpenPageByJump("/sandPlayTakingPhotoView")
	QWorldMgr:StartBlackFade(0.3, 0.3, 0.2, function()
		QWorldMgr:EnableCamera(QWorldCameraFlag.CustomCamera, arg_3_0.entity:GetMiniGameCamera(), QWorldCameraLayer.MiniGame)
		FrameTimer.New(function()
			local var_5_0 = manager.ui.mainCamera.transform.position - arg_3_0:GetPosition()
			local var_5_1 = Quaternion.LookRotation(var_5_0).eulerAngles
			local var_5_2 = Quaternion.Euler(0, var_5_1.y, 0)

			QWorldLuaBridge.TeleportToCachePos(arg_3_0:GetPosition(), var_5_2, false, true)
		end, 1, 1):Start()
	end)
end

local function var_0_3(arg_6_0)
	manager.notify:RemoveListener(QWORLD_TAKE_PHOTO, arg_6_0.takePhotoCallBack)
	manager.notify:RemoveListener(QWORLD_TAKE_PHOTO_SNAP, arg_6_0.snapCallBack)
end

local function var_0_4(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.entity:AddBubbleTag(QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.PHOTO_GAME, arg_7_0:GetBubbleName(), arg_7_0:GetBubbleIcon())
	else
		arg_7_0.entity:RemoveBubbleTag(QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.PHOTO_GAME)
	end
end

local function var_0_5(arg_8_0, arg_8_1)
	local var_8_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_8_0, arg_8_1, QWORLD_ENTITY_TYPE.DEFAULT)

	var_8_0.localData.isTake = false

	function var_8_0.CreateMiniMapEntity()
		local var_9_0 = QWorldEntityMiniMap.New(var_8_0)

		var_9_0:SetMiniType(1)

		return var_9_0
	end

	function var_8_0.entity.bubbleClick(arg_10_0)
		if arg_10_0 == QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.PHOTO_GAME then
			var_0_2(var_8_0)
		end
	end

	var_8_0:ResetChangeBubble(var_0_4)

	function var_8_0.takePhotoCallBack()
		var_0_1(var_8_0)
	end

	function var_8_0.snapCallBack()
		var_0_0(var_8_0)
	end

	var_8_0.OnRemoveEntity = var_0_3

	return var_8_0
end

return QWorldPrefab.New("QWPhotoGame", var_0_5)
