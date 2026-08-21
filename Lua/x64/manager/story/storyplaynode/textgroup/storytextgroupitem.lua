local var_0_0 = class("StoryTextGroupItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.storyPlayer_ = arg_1_2
	arg_1_0.groupID_ = -1
	arg_1_0.textItemList_ = {}
	arg_1_0.curTextItem_ = nil

	ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_0.gameObject_)
end

function var_0_0.SetConfig(arg_2_0, arg_2_1)
	arg_2_0.config_ = arg_2_1
	arg_2_0.groupID_ = arg_2_1.groupID

	if arg_2_0.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP then
		arg_2_0.enableGlobalTextPropertyChange_ = arg_2_0.config_.enableTextPropertyChange
		arg_2_0.globalTextComProperty_ = arg_2_0.config_.textComProperty
		arg_2_0.enableGlobalEffect_ = arg_2_0.config_.enableEffect
		arg_2_0.globalEffectData_ = arg_2_0.config_.effectData
	elseif arg_2_0.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT then
		if arg_2_0.enableGlobalTextPropertyChange_ and not arg_2_0.config_.enableTextPropertyChange then
			arg_2_0.config_.enableTextPropertyChange = true
			arg_2_0.config_.textComProperty = arg_2_0.globalTextComProperty_
		end

		if arg_2_0.enableGlobalEffect_ and not arg_2_0.config_.enableEffect then
			arg_2_0.config_.enableEffect = true
			arg_2_0.config_.effectData = arg_2_0.globalEffectData_
		end
	end
end

function var_0_0.OnUpdate(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.curTextItem_ then
		arg_3_0.curTextItem_:OnUpdate(arg_3_1, arg_3_2)
	end
end

function var_0_0.OnFinish(arg_4_0)
	if arg_4_0.curTextItem_ then
		arg_4_0.curTextItem_:OnFinish()
	end
end

function var_0_0.UpdateTexGroupLayout(arg_5_0)
	if not arg_5_0.config_.enableLayoutChange then
		return
	end

	arg_5_0.textItemContainerTrans_.offsetMin = arg_5_0.config_.layoutData.offsetMin
	arg_5_0.textItemContainerTrans_.offsetMax = arg_5_0.config_.layoutData.offsetMax

	local var_5_0 = arg_5_0.layoutGroup_.padding

	var_5_0.left = arg_5_0.config_.layoutData.leftPadding
	var_5_0.right = arg_5_0.config_.layoutData.rightPadding
	var_5_0.top = arg_5_0.config_.layoutData.topPadding
	var_5_0.bottom = arg_5_0.config_.layoutData.bottomPadding
	arg_5_0.layoutGroup_.spacing = arg_5_0.config_.layoutData.paragraphSpacing
	arg_5_0.layoutGroup_.childAlignment = arg_5_0.config_.layoutData.paragraphAlignment
end

function var_0_0.UpdateTextGroupBg(arg_6_0)
	if not arg_6_0.config_.enableBgChange then
		return
	end

	if arg_6_0.config_.bgData.bgActionType == StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.NONE then
		return
	end

	if arg_6_0.config_.bgData.bgActionType == StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE then
		SetActive(arg_6_0.bgGo_, true)
	elseif arg_6_0.config_.bgData.bgActionType == StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.DISABLE then
		SetActive(arg_6_0.bgGo_, false)
	elseif arg_6_0.config_.bgData.bgActionType == StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.CHANGE then
		SetActive(arg_6_0.bgGo_, true)

		arg_6_0.bgImg_.color = arg_6_0.config_.bgData.bgColor
	end
end

function var_0_0.AddTextContent(arg_7_0)
	arg_7_0.curTextItem_ = arg_7_0:GetTextItem()

	arg_7_0.curTextItem_:SetActive(true)
	arg_7_0.curTextItem_:SetConfig(arg_7_0.config_)
	arg_7_0.curTextItem_:UpdateTextProperty()
	arg_7_0.curTextItem_:UpdateContent()
end

function var_0_0.GetTextItem(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.textItemList_) do
		if iter_8_1:GetContentID() == arg_8_0.config_.contentID then
			return iter_8_1
		end
	end

	local var_8_0 = Object.Instantiate(arg_8_0.textItemTemplateGo_, arg_8_0.textItemContainerTrans_)

	var_8_0.name = arg_8_0.config_.contentID

	local var_8_1 = StoryTextItem.New(var_8_0, arg_8_0.storyPlayer_)

	arg_8_0.textItemList_[#arg_8_0.textItemList_ + 1] = var_8_1

	return var_8_1
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.textItemList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.curTextItem_ = nil

	Object.Destroy(arg_10_0.gameObject_)

	arg_10_0.gameObject_ = nil
	arg_10_0.storyPlayer_ = nil
end

return var_0_0
