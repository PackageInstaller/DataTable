local QWorldStoryChoiceItem = class("QWorldStoryChoiceItem", import("game.extend.ReduxView"))

function QWorldStoryChoiceItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.transform_.localScale = Vector3.one
	self.transform_.localPosition = Vector3.zero

	self:Init()
end

function QWorldStoryChoiceItem:BuildContext()
	self.context = {
		sdkStr = "",
		isHide = false
	}
end

function QWorldStoryChoiceItem:Init()
	self:InitUI()
	self:BuildContext()
end

function QWorldStoryChoiceItem:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.btnState = self.iconState_:GetController("type")

	self:AddListener()
end

function QWorldStoryChoiceItem:AddListener()
	self:AddBtnListener(self.choiceBtn_, nil, function()
		if self.context.funcChoiceCtx then
			if self.context.funcChoiceCtx.type == QWorldConst.TagType.Quest then
				QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.TASK, self.context.id, self.context.sdkStr, self:GetTalkTargetId())
			else
				QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.TAG_OPERATION, self.context.id, self.context.sdkStr, self:GetTalkTargetId())
			end
		else
			QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.TALK_BRANCH, self.context.id, self.context.sdkStr, self:GetTalkTargetId())
		end

		if self.context.clickCallback then
			self.context.clickCallback()
		elseif self.context.funcClick then
			QWorldMgr:GetQWorldStoryMgr():StopStory()
			self.context.funcClick()
		end
	end)
end

function QWorldStoryChoiceItem:GetTalkTargetId()
	local var_7_0 = QWorldMgr:GetQWorldStoryMgr():GetTarget()

	if var_7_0 then
		return var_7_0.entityId
	else
		return 0
	end
end

function QWorldStoryChoiceItem:RenderView(arg_8_1, arg_8_2)
	self.btnState:SetSelectedState("normal")

	self.context.id = arg_8_1

	local var_8_0 = SandplayStoryTalkCfg[tonumber(arg_8_1)].option_icon

	if var_8_0 == "" then
		var_8_0 = "SandPlay_icon_00001"
	end

	self.iconImg_.spriteSync = "TextureConfig/SandPlay/MiniIcon/" .. var_8_0
	self.choiceTxt_.text = SandplayStoryTalkCfg[tonumber(arg_8_1)].option_text
end

function QWorldStoryChoiceItem:RenderFuncChoice(arg_9_1)
	local var_9_0, var_9_1, var_9_2 = self:GetIcon(arg_9_1.type, arg_9_1.id)

	self.context.funcChoiceCtx = arg_9_1
	self.context.id = arg_9_1.id
	self.iconImg_.spriteSync = var_9_0

	self.btnState:SetSelectedState(var_9_1)

	self.backBoardImg_.spriteSync = "TextureConfig/SandPlay/BaseBoard/" .. var_9_2
	self.choiceTxt_.text = arg_9_1.title
	self.context.funcClick = arg_9_1.action
end

function QWorldStoryChoiceItem:GetIcon(arg_10_1, arg_10_2)
	if arg_10_1 == QWorldConst.TagType.Quest then
		local var_10_1 = SandplayTaskMainCfg[arg_10_2 < 0 and -arg_10_2 or SandplayTaskCfg[arg_10_2] and SandplayTaskCfg[arg_10_2].main_task_id]

		if QWorldQuestConst.QUEST_TASK_TYPE.MAIN == SandplayTaskMainCfg[arg_10_2 < 0 and -arg_10_2 or SandplayTaskCfg[arg_10_2] and SandplayTaskCfg[arg_10_2].main_task_id].main_task_type then
			return "TextureConfig/SandPlay/MiniIcon/" .. "SandPlay_Questicon_Main", "questMain", ""
		elseif QWorldQuestConst.QUEST_TASK_TYPE.SIDE == var_10_1.main_task_type then
			return "TextureConfig/SandPlay/MiniIcon/" .. "SandPlay_Questicon_Side", "questSide", ""
		else
			return "TextureConfig/SandPlay/MiniIcon/" .. "SandPlay_Questicon_Explore", "quesExplore", ""
		end
	elseif SandplayTagCfg[arg_10_2].tag_behaviour == 1 then
		return "TextureConfig/SandPlay/MiniIcon/" .. SandplayTagCfg[arg_10_2].map_icon, "teleport", SandplayTagCfg[arg_10_2].baseboard
	else
		return "TextureConfig/SandPlay/MiniIcon/" .. SandplayTagCfg[arg_10_2].map_icon, "active", SandplayTagCfg[arg_10_2].baseboard
	end

	return "", "active", ""
end

function QWorldStoryChoiceItem:RegistCallback(arg_11_1)
	self.context.clickCallback = arg_11_1
end

function QWorldStoryChoiceItem:Reset()
	self.context.clickCallback = nil
	self.context.funcClick = nil
	self.context.sdkStr = ""
	self.context.funcChoiceCtx = nil
end

function QWorldStoryChoiceItem:SetSdkChoice(arg_13_1)
	self.context.sdkStr = arg_13_1
end

function QWorldStoryChoiceItem:Hide()
	if not self.context.isHide then
		self.gameObject_:SetActive(false)

		self.context.isHide = true
	end
end

function QWorldStoryChoiceItem:Show()
	if self.context.isHide then
		self.gameObject_:SetActive(true)

		self.context.isHide = false
	end
end

function QWorldStoryChoiceItem:Dispose()
	QWorldStoryChoiceItem.super.Dispose(self)
end

return QWorldStoryChoiceItem
