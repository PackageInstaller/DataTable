local var_0_0 = class("QWorldStoryChoiceItem", import("game.extend.ReduxView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.transform_.localScale = Vector3.one
	arg_1_0.transform_.localPosition = Vector3.zero

	arg_1_0:Init()
end

function var_0_0.BuildContext(arg_2_0)
	arg_2_0.context = {
		sdkStr = "",
		isHide = false
	}
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:BuildContext()
end

function var_0_0.InitUI(arg_4_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_4_0, arg_4_0.gameObject_)

	arg_4_0.btnState = arg_4_0.iconState_:GetController("type")

	arg_4_0:AddListener()
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.choiceBtn_, nil, function()
		if arg_5_0.context.funcChoiceCtx then
			if arg_5_0.context.funcChoiceCtx.type == QWorldConst.TagType.Quest then
				QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.TASK, arg_5_0.context.id, arg_5_0.context.sdkStr, arg_5_0:GetTalkTargetId())
			else
				QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.TAG_OPERATION, arg_5_0.context.id, arg_5_0.context.sdkStr, arg_5_0:GetTalkTargetId())
			end
		else
			QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.TALK_BRANCH, arg_5_0.context.id, arg_5_0.context.sdkStr, arg_5_0:GetTalkTargetId())
		end

		if arg_5_0.context.clickCallback then
			arg_5_0.context.clickCallback()
		elseif arg_5_0.context.funcClick then
			QWorldMgr:GetQWorldStoryMgr():StopStory()
			arg_5_0.context.funcClick()
		end
	end)
end

function var_0_0.GetTalkTargetId(arg_7_0)
	local var_7_0 = QWorldMgr:GetQWorldStoryMgr():GetTarget()

	if var_7_0 then
		return var_7_0.entityId
	else
		return 0
	end
end

function var_0_0.RenderView(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.btnState:SetSelectedState("normal")

	arg_8_0.context.id = arg_8_1

	local var_8_0 = SandplayStoryTalkCfg[tonumber(arg_8_1)]
	local var_8_1 = SandplayStoryTalkCfg[tonumber(arg_8_1)].option_icon

	if var_8_1 == "" then
		var_8_1 = "SandPlay_icon_00001"
	end

	arg_8_0.iconImg_.spriteSync = "TextureConfig/SandPlay/MiniIcon/" .. var_8_1
	arg_8_0.choiceTxt_.text = var_8_0.option_text
end

function var_0_0.RenderFuncChoice(arg_9_0, arg_9_1)
	local var_9_0, var_9_1, var_9_2 = arg_9_0:GetIcon(arg_9_1.type, arg_9_1.id)

	arg_9_0.context.funcChoiceCtx = arg_9_1
	arg_9_0.context.id = arg_9_1.id
	arg_9_0.iconImg_.spriteSync = var_9_0

	arg_9_0.btnState:SetSelectedState(var_9_1)

	arg_9_0.backBoardImg_.spriteSync = "TextureConfig/SandPlay/BaseBoard/" .. var_9_2
	arg_9_0.choiceTxt_.text = arg_9_1.title
	arg_9_0.context.funcClick = arg_9_1.action
end

function var_0_0.GetIcon(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = "TextureConfig/SandPlay/MiniIcon/"

	if arg_10_1 == QWorldConst.TagType.Quest then
		local var_10_1

		if arg_10_2 < 0 then
			var_10_1 = -arg_10_2
		else
			local var_10_2 = arg_10_2
			local var_10_3 = SandplayTaskCfg[var_10_2]

			var_10_1 = var_10_3 and var_10_3.main_task_id
		end

		local var_10_4 = SandplayTaskMainCfg[var_10_1]

		if QWorldQuestConst.QUEST_TASK_TYPE.MAIN == var_10_4.main_task_type then
			return var_10_0 .. "SandPlay_Questicon_Main", "questMain", ""
		elseif QWorldQuestConst.QUEST_TASK_TYPE.SIDE == var_10_4.main_task_type then
			return var_10_0 .. "SandPlay_Questicon_Side", "questSide", ""
		else
			return var_10_0 .. "SandPlay_Questicon_Explore", "quesExplore", ""
		end
	elseif SandplayTagCfg[arg_10_2].tag_behaviour == 1 then
		return var_10_0 .. SandplayTagCfg[arg_10_2].map_icon, "teleport", SandplayTagCfg[arg_10_2].baseboard
	else
		return var_10_0 .. SandplayTagCfg[arg_10_2].map_icon, "active", SandplayTagCfg[arg_10_2].baseboard
	end

	return "", "active", ""
end

function var_0_0.RegistCallback(arg_11_0, arg_11_1)
	arg_11_0.context.clickCallback = arg_11_1
end

function var_0_0.Reset(arg_12_0)
	arg_12_0.context.clickCallback = nil
	arg_12_0.context.funcClick = nil
	arg_12_0.context.sdkStr = ""
	arg_12_0.context.funcChoiceCtx = nil
end

function var_0_0.SetSdkChoice(arg_13_0, arg_13_1)
	arg_13_0.context.sdkStr = arg_13_1
end

function var_0_0.Hide(arg_14_0)
	if not arg_14_0.context.isHide then
		arg_14_0.gameObject_:SetActive(false)

		arg_14_0.context.isHide = true
	end
end

function var_0_0.Show(arg_15_0)
	if arg_15_0.context.isHide then
		arg_15_0.gameObject_:SetActive(true)

		arg_15_0.context.isHide = false
	end
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
