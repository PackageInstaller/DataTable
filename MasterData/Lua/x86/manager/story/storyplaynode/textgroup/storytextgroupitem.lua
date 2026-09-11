local StoryTextGroupItem = class("StoryTextGroupItem")

function StoryTextGroupItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.storyPlayer_ = arg_1_2
	self.groupID_ = -1
	self.textItemList_ = {}
	self.curTextItem_ = nil

	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)
end

function StoryTextGroupItem:SetConfig(arg_2_1)
	self.config_ = arg_2_1
	self.groupID_ = arg_2_1.groupID

	if self.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP then
		self.enableGlobalTextPropertyChange_ = self.config_.enableTextPropertyChange
		self.globalTextComProperty_ = self.config_.textComProperty
		self.enableGlobalEffect_ = self.config_.enableEffect
		self.globalEffectData_ = self.config_.effectData
	elseif self.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT then
		if self.enableGlobalTextPropertyChange_ and not self.config_.enableTextPropertyChange then
			self.config_.enableTextPropertyChange = true
			self.config_.textComProperty = self.globalTextComProperty_
		end

		if self.enableGlobalEffect_ and not self.config_.enableEffect then
			self.config_.enableEffect = true
			self.config_.effectData = self.globalEffectData_
		end
	end
end

function StoryTextGroupItem:OnUpdate(arg_3_1, arg_3_2)
	if self.curTextItem_ then
		self.curTextItem_:OnUpdate(arg_3_1, arg_3_2)
	end
end

function StoryTextGroupItem:OnFinish()
	if self.curTextItem_ then
		self.curTextItem_:OnFinish()
	end
end

function StoryTextGroupItem:UpdateTexGroupLayout()
	if not self.config_.enableLayoutChange then
		return
	end

	self.textItemContainerTrans_.offsetMin = self.config_.layoutData.offsetMin
	self.textItemContainerTrans_.offsetMax = self.config_.layoutData.offsetMax
	self.layoutGroup_.padding.left = self.config_.layoutData.leftPadding
	self.layoutGroup_.padding.right = self.config_.layoutData.rightPadding
	self.layoutGroup_.padding.top = self.config_.layoutData.topPadding
	self.layoutGroup_.padding.bottom = self.config_.layoutData.bottomPadding
	self.layoutGroup_.spacing = self.config_.layoutData.paragraphSpacing
	self.layoutGroup_.childAlignment = self.config_.layoutData.paragraphAlignment
end

function StoryTextGroupItem:UpdateTextGroupBg()
	if not self.config_.enableBgChange then
		return
	end

	if self.config_.bgData.bgActionType == StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.NONE then
		return
	end

	if self.config_.bgData.bgActionType == StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE then
		SetActive(self.bgGo_, true)
	elseif self.config_.bgData.bgActionType == StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.DISABLE then
		SetActive(self.bgGo_, false)
	elseif self.config_.bgData.bgActionType == StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.CHANGE then
		SetActive(self.bgGo_, true)

		self.bgImg_.color = self.config_.bgData.bgColor
	end
end

function StoryTextGroupItem:AddTextContent()
	self.curTextItem_ = self:GetTextItem()

	self.curTextItem_:SetActive(true)
	self.curTextItem_:SetConfig(self.config_)
	self.curTextItem_:UpdateTextProperty()
	self.curTextItem_:UpdateContent()
end

function StoryTextGroupItem:GetTextItem()
	for iter_8_0, iter_8_1 in ipairs(self.textItemList_) do
		if iter_8_1:GetContentID() == self.config_.contentID then
			return iter_8_1
		end
	end

	local var_8_0 = Object.Instantiate(self.textItemTemplateGo_, self.textItemContainerTrans_)

	var_8_0.name = self.config_.contentID

	local var_8_1 = StoryTextItem.New(var_8_0, self.storyPlayer_)

	self.textItemList_[#self.textItemList_ + 1] = var_8_1

	return var_8_1
end

function StoryTextGroupItem:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function StoryTextGroupItem:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.textItemList_) do
		iter_10_1:Dispose()
	end

	self.curTextItem_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.storyPlayer_ = nil
end

return StoryTextGroupItem
