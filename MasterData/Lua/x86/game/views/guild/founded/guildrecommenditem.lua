local GuildRecommendItem = class("GuildRecommendItem", ReduxView)

function GuildRecommendItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.recommendClickHandler_ = handler(self, self.ClickRecommendItem)

	manager.notify:RegistListener(GUILD_RECOMMEND_CLICK, self.recommendClickHandler_)

	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function GuildRecommendItem:Dispose()
	GuildRecommendItem.super.Dispose(self)
	manager.notify:RemoveListener(GUILD_RECOMMEND_CLICK, self.recommendClickHandler_)

	self.recommendClickHandler_ = nil
end

function GuildRecommendItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		manager.notify:Invoke(GUILD_RECOMMEND_CLICK, self.index_)
	end)
end

function GuildRecommendItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.index_ = arg_5_1
	self.textName_.text = GetI18NText(arg_5_2.name)
	self.textLv_.text = arg_5_2.level
	self.textMember_.text = string.format("%s/%s", GetI18NText(arg_5_2.member), GetI18NText(arg_5_2.maxMemberCnt))
	self.textContribute_.text = GetI18NText(arg_5_2.contribute)
	self.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[arg_5_2.icon].icon_bg)

	SetActive(self.goFreeTag_, arg_5_2.isFree)
	self:RefreshSelect(arg_5_3)

	if arg_5_2.isFree then
		self.controller_:SetSelectedState("0")
	else
		self.controller_:SetSelectedState("1")
	end
end

function GuildRecommendItem:ClickRecommendItem(arg_6_1)
	self:RefreshSelect(self.index_ == arg_6_1)
end

function GuildRecommendItem:RefreshSelect(arg_7_1)
	if arg_7_1 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

return GuildRecommendItem
