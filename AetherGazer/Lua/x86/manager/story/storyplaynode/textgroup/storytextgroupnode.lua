local var_0_0 = class("StoryTextGroupNode", require("manager/story/StoryPlayNode/StoryPlayBaseNode"))

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0:Reset()
end

function var_0_0.Reset(arg_2_0)
	arg_2_0.groupID_ = -1
	arg_2_0.groupItem_ = nil
end

function var_0_0.OnSetConfig(arg_3_0, arg_3_1)
	arg_3_0.groupID_ = arg_3_1.groupID
end

function var_0_0.OnPlay(arg_4_0)
	if arg_4_0.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP then
		arg_4_0:DestoryGroup()

		return
	end

	if arg_4_0.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP then
		arg_4_0.storyPlayer_:ClearAllNode()

		return
	end

	arg_4_0.groupItem_ = arg_4_0:GetTextGroupItem()

	arg_4_0.groupItem_:SetConfig(arg_4_0.config_)

	if arg_4_0.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP then
		arg_4_0:UpdateDuration()
		arg_4_0:UpdateDialogGo()
		arg_4_0.groupItem_:UpdateTexGroupLayout()
		arg_4_0.groupItem_:UpdateTextGroupBg()
		arg_4_0.groupItem_:AddTextContent()
	elseif arg_4_0.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT then
		arg_4_0:UpdateDuration()
		arg_4_0.groupItem_:AddTextContent()
	end
end

function var_0_0.OnUpdate(arg_5_0, arg_5_1)
	if arg_5_0.groupItem_ then
		arg_5_0.groupItem_:OnUpdate(arg_5_0:GetCurTime(), arg_5_0:GetDuration())
	end
end

function var_0_0.OnFinish(arg_6_0)
	if arg_6_0.groupItem_ then
		arg_6_0.groupItem_:OnFinish()
	end
end

function var_0_0.OnDispose(arg_7_0)
	arg_7_0:DestoryGroup()
end

function var_0_0.DestoryGroup(arg_8_0)
	arg_8_0.storyPlayer_:DestoryTextGroup(arg_8_0.groupID_)
	arg_8_0:Reset()
end

function var_0_0.GetTextGroupItem(arg_9_0)
	return arg_9_0.storyPlayer_:GetTextGroupItem(arg_9_0.groupID_)
end

function var_0_0.UpdateDuration(arg_10_0)
	local var_10_0 = arg_10_0.storyPlayer_:GetWordFromCfg(arg_10_0.config_.contentID)
	local var_10_1 = arg_10_0.storyPlayer_:FormatText(var_10_0.content)
	local var_10_2 = arg_10_0:GetDuration()
	local var_10_3 = arg_10_0.config_.charCount <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_1) / arg_10_0.config_.charCount)

	arg_10_0:SetDuration(var_10_3)

	local var_10_4 = arg_10_0:GetStartTime() + var_10_3

	if var_10_4 > arg_10_0.storyPlayer_:GetDuration() then
		arg_10_0.storyPlayer_:SetDuration(var_10_4)
	end
end

function var_0_0.UpdateDialogGo(arg_11_0)
	SetActive(arg_11_0.storyPlayer_.dialog_, arg_11_0.config_.displayDialog)

	if arg_11_0.config_.displayDialog then
		SetActive(arg_11_0.storyPlayer_.textGroupNextGo_, false)
	end
end

return var_0_0
