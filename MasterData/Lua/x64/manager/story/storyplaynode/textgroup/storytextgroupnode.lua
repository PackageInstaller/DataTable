local StoryTextGroupNode = class("StoryTextGroupNode", require("manager/story/StoryPlayNode/StoryPlayBaseNode"))

function StoryTextGroupNode:OnCtor(arg_1_1)
	self:Reset()
end

function StoryTextGroupNode:Reset()
	self.groupID_ = -1
	self.groupItem_ = nil
end

function StoryTextGroupNode:OnSetConfig(arg_3_1)
	self.groupID_ = arg_3_1.groupID
end

function StoryTextGroupNode:OnPlay()
	if self.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP then
		self:DestoryGroup()

		return
	end

	if self.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP then
		self.storyPlayer_:ClearAllNode()

		return
	end

	self.groupItem_ = self:GetTextGroupItem()

	self.groupItem_:SetConfig(self.config_)

	if self.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP then
		self:UpdateDuration()
		self:UpdateDialogGo()
		self.groupItem_:UpdateTexGroupLayout()
		self.groupItem_:UpdateTextGroupBg()
		self.groupItem_:AddTextContent()
	elseif self.config_.TEXT_GROUP_NODE_TYPE == StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT then
		self:UpdateDuration()
		self.groupItem_:AddTextContent()
	end
end

function StoryTextGroupNode:OnUpdate(arg_5_1)
	if self.groupItem_ then
		self.groupItem_:OnUpdate(self:GetCurTime(), self:GetDuration())
	end
end

function StoryTextGroupNode:OnFinish()
	if self.groupItem_ then
		self.groupItem_:OnFinish()
	end
end

function StoryTextGroupNode:OnDispose()
	self:DestoryGroup()
end

function StoryTextGroupNode:DestoryGroup()
	self.storyPlayer_:DestoryTextGroup(self.groupID_)
	self:Reset()
end

function StoryTextGroupNode:GetTextGroupItem()
	return self.storyPlayer_:GetTextGroupItem(self.groupID_)
end

function StoryTextGroupNode:UpdateDuration()
	local var_10_0 = self:GetDuration()
	local var_10_1 = self.config_.charCount <= 0 and var_10_0 or var_10_0 * (utf8.len((self.storyPlayer_:FormatText(self.storyPlayer_:GetWordFromCfg(self.config_.contentID).content))) / self.config_.charCount)

	self:SetDuration(var_10_1)

	local var_10_2 = self:GetStartTime() + var_10_1

	if var_10_2 > self.storyPlayer_:GetDuration() then
		self.storyPlayer_:SetDuration(var_10_2)
	end
end

function StoryTextGroupNode:UpdateDialogGo()
	SetActive(self.storyPlayer_.dialog_, self.config_.displayDialog)

	if self.config_.displayDialog then
		SetActive(self.storyPlayer_.textGroupNextGo_, false)
	end
end

return StoryTextGroupNode
