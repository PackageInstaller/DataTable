local function var_0_0(arg_1_0, arg_1_1)
	if not arg_1_0.actionID then
		arg_1_0.actionID = QWorldLuaBridge.GetFuniturePerformAction(arg_1_0.entity)
	end

	if arg_1_0.actionID <= 0 then
		if arg_1_0.performCallback then
			arg_1_0.performCallback()

			arg_1_0.performCallback = nil
		end

		return
	end

	if QWorldLuaBridge.GetFunitureNeedForceBack(arg_1_0.entity) and not arg_1_1 then
		JumpTools.OpenPageByJump("/sandPlayPerformView")
		QWorldMgr:StartBlackFade(0.3, 0.3, 0.2, function()
			QWorldMgr:GetQWorldPerformMgr():StartPerform(arg_1_0, arg_1_0.actionID, function()
				if arg_1_0.performCallback then
					arg_1_0.performCallback()

					arg_1_0.performCallback = nil
				end
			end)
		end)
	else
		QWorldMgr:GetQWorldPerformMgr():StartPerform(arg_1_0, arg_1_0.actionID, function()
			if arg_1_0.performCallback then
				arg_1_0.performCallback()

				arg_1_0.performCallback = nil
			end
		end)
	end
end

local var_0_1 = "QWWorld/Effect/fx_pickup.prefab"
local var_0_2 = 0
local var_0_3

local function var_0_4(arg_5_0)
	if arg_5_0.dropEffectGo_ then
		Object.Destroy(arg_5_0.dropEffectGo_)

		arg_5_0.dropEffectGo_ = nil
		var_0_2 = var_0_2 - 1

		if var_0_2 <= 0 then
			Asset.Unload(var_0_1)

			var_0_3 = nil
		end
	end
end

local function var_0_5(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.entity:AddBubbleTag(QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.FURNITURE_INTERACT, arg_6_0:GetBubbleName(), arg_6_0:GetBubbleIcon())
	else
		arg_6_0.entity:RemoveBubbleTag(QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.FURNITURE_INTERACT)
	end
end

local function var_0_6(arg_7_0)
	if not var_0_3 then
		var_0_3 = Asset.Load(var_0_1)
	end

	var_0_2 = var_0_2 + 1

	local var_7_0 = GameObject.Instantiate(var_0_3, arg_7_0.entity.transform)

	var_7_0.transform.localPosition = Vector3.zero
	var_7_0.transform.localRotation = Quaternion.identity
	var_7_0.transform.localScale = Vector3.one
	arg_7_0.dropEffectGo_ = var_7_0
end

local function var_0_7(arg_8_0, arg_8_1)
	if arg_8_1 == 0 then
		return
	end

	QWorldMgr:GetQWorldStoryMgr():StartStory(arg_8_1, arg_8_0)
end

local function var_0_8(arg_9_0, arg_9_1)
	local var_9_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_9_0, arg_9_1, QWORLD_ENTITY_TYPE.FUNITURE)

	function var_9_0.entity.bubbleClick(arg_10_0)
		if QWorldQuestGraph:HasQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, var_9_0.entityId) then
			if QWorldMgr:GetQWorldQuestMgr():IsSendingQuestParamUpdateOrFinish() then
				print("任务正在等待进度更新返回, 跳过交互")
				ShowTips("FREQUENT_OPERATION_")

				return
			end

			QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.IN_TASK_BEHAVIOUR, var_9_0.configId or "", "", var_9_0.entityId)

			if QWorldLuaBridge.GetFuniturePerformAction(var_9_0.entity) > 0 then
				function var_9_0.performCallback()
					QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, var_9_0.entityId)
				end

				var_0_0(var_9_0)
			else
				QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, var_9_0.entityId)
			end

			return
		end

		if var_9_0.HudLogic(var_9_0, {
			showChar = true,
			func = function()
				if QWorldLuaBridge.GetFuniturePerformAction(var_9_0.entity) > 0 then
					QWorldMgr:GetQWorldPerformMgr():SetActivityPerformDirty()
					var_0_0(var_9_0, true)
				end
			end
		}) then
			return
		end

		local var_10_0 = var_9_0:GetDefaultTalk()

		if var_10_0 > 0 then
			QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.TALK, var_10_0, "", var_9_0.entityId)
			var_9_0:StartStory(var_10_0)

			return
		end

		if arg_10_0 == QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.FURNITURE_INTERACT then
			QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.FURNITURE_INTERACT, var_9_0.configId or "", "", var_9_0.entityId)
			var_0_0(var_9_0)
		end
	end

	var_9_0:ResetChangeBubble(var_0_5)

	var_9_0.OnRemoveEntity = var_0_4
	var_9_0.InitDropEffect = var_0_6
	var_9_0.StartStory = var_0_7

	return var_9_0
end

return QWorldPrefab.New("QWFurniture", var_0_8)
