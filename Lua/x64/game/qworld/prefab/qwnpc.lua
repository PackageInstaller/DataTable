local function var_0_0(arg_1_0, arg_1_1)
	if arg_1_1 then
		arg_1_0.entity:AddBubbleTag(QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.NPC_INTERACT, arg_1_0:GetBubbleName(), arg_1_0:GetBubbleIcon())
	else
		arg_1_0.entity:RemoveBubbleTag(QWorldBubbleConst.BUBBLE_PRE_DEFINED_TAG.NPC_INTERACT)
	end
end

local function var_0_1(arg_2_0, arg_2_1)
	local var_2_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_2_0, arg_2_1, QWORLD_ENTITY_TYPE.NPC)

	function var_2_0.entity.bubbleClick(arg_3_0)
		if QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, var_2_0.entityId) then
			QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.IN_TASK_BEHAVIOUR, var_2_0.configId or "", "", var_2_0.entityId)

			return
		end

		if var_2_0.HudLogic(var_2_0) then
			return
		end

		local var_3_0 = var_2_0:GetDefaultTalk()

		if var_3_0 and var_3_0 ~= 0 then
			QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.TALK, var_3_0, "", var_2_0.entityId)
			var_2_0:StartStory(var_3_0)
		end
	end

	function var_2_0.StartStory(arg_4_0, arg_4_1)
		if arg_4_1 == 0 then
			return
		end

		QWorldMgr:GetQWorldStoryMgr():StartStory(arg_4_1, var_2_0, QWStoryConst.StoryType.StoryGraph)
	end

	function var_2_0.StartSeeker(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7, arg_5_8)
		if not arg_5_8 then
			QWorldLuaBridge.StartSeeker(var_2_0.entity, arg_5_1, arg_5_6, arg_5_7, arg_5_3, arg_5_4, arg_5_2, arg_5_5)
		else
			QWorldLuaBridge.StartSeeker(var_2_0.entity, arg_5_1, arg_5_6, arg_5_7, arg_5_3, arg_5_4, arg_5_2, arg_5_5, arg_5_8.enableInteraction, arg_5_8.mode)
		end
	end

	var_2_0:ResetChangeBubble(var_0_0)

	return var_2_0
end

return QWorldPrefab.New("QWNpc", var_0_1)
