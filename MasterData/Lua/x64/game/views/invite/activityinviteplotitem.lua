local ActivityInvitePlotItem = class("ActivityInvitePlotItem", ReduxView)

function ActivityInvitePlotItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function ActivityInvitePlotItem:Init()
	self:InitUI()
end

function ActivityInvitePlotItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.gameObject_.transform, "state")
end

function ActivityInvitePlotItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.data = arg_4_1
	self.index = arg_4_2
	self.cfg = arg_4_3
	self.curIndex = arg_4_4

	self:UpdateView()
end

function ActivityInvitePlotItem:UpdateView()
	self.contentTxt_.text = GetI18NText(self:GetWordCfg(self.data.id).content)

	self.stateController:SetSelectedState(self.data.role == 0 and "1" or "2")
	SetActive(self.headGo_, self.data.role == 1)

	if self.curIndex == self.index then
		self.animator_:Play("ContenuUI_talkicon", 0, 0)
	end

	if self.data.role == 0 then
		self.myTxt_.text = GetI18NText(PlayerData:GetPlayerInfo().nick)
	elseif self.data.role == 1 then
		self.roleTxt_.text = GetI18NText(HeroCfg[self.data.heroId].suffix)
		self.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.cfg.hero_image_route)
	elseif self.data.role == 2 then
		self.roleTxt_.text = GetTips("ACTIVITY_INVITE_NPC1")
	elseif self.data.role == 3 then
		self.roleTxt_.text = GetTips("ACTIVITY_INVITE_NPC2")
	end
end

function ActivityInvitePlotItem:GetWordCfg(arg_6_1)
	if StoryWordCfg[arg_6_1] then
		return StoryWordCfg[arg_6_1]
	elseif StoryWordCfg2[arg_6_1] then
		return StoryWordCfg2[arg_6_1]
	else
		return StoryWordCfg3[arg_6_1]
	end
end

function ActivityInvitePlotItem:OnEnter()
	return
end

function ActivityInvitePlotItem:OnExit()
	return
end

function ActivityInvitePlotItem:Dispose()
	ActivityInvitePlotItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return ActivityInvitePlotItem
