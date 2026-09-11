local GuildBossRankItem = class("GuildBossRankItem", ReduxView)

function GuildBossRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildBossRankItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossRankItem:InitUI()
	self:BindCfgUI()

	self.heroCountController_ = self.conExCollection_:GetController("heroCount")
	self.rankController_ = self.conExCollection_:GetController("rank")
	self.positionController_ = self.posExCon_:GetController("position")
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function GuildBossRankItem:SetData(arg_4_1, arg_4_2)
	self.index_ = arg_4_1
	self.data_ = arg_4_2

	self:UpdateView()
end

function GuildBossRankItem:UpdateView()
	self.userID_ = self.data_.id
	self.nickText_.text = GetI18NText(self.data_.nick)
	self.rankText_.text = tostring(self.index_)
	self.scoreText_.text = self.data_.score

	self.commonPortrait_:RenderHead(self.data_.icon)
	self.commonPortrait_:RenderFrame(self.data_.icon_frame)
	self.positionController_:SetSelectedState(tostring(self.data_.member_post))

	local var_5_0 = math.min(#self.data_.hero_type_info, 3)

	self.heroCountController_:SetSelectedIndex(var_5_0)

	for iter_5_0 = 1, var_5_0 do
		self["heroImg_" .. iter_5_0].sprite = getSpriteViaConfig("HeroLittleIcon", (self.data_.hero_type_info[iter_5_0].skin_id == 0 or nil) and self.data_.hero_type_info[iter_5_0].hero_id)
	end

	if self.index_ <= 3 then
		self.rankController_:SetSelectedState(self.index_)
	else
		self.rankController_:SetSelectedState(0)
	end
end

function GuildBossRankItem:AddUIListener()
	return
end

function GuildBossRankItem:AddEventListeners()
	return
end

function GuildBossRankItem:OnEnter()
	self:AddEventListeners()
end

function GuildBossRankItem:OnExit()
	self:RemoveAllEventListener()
end

function GuildBossRankItem:OnMainHomeViewTop()
	return
end

function GuildBossRankItem:Dispose()
	self.commonPortrait_:Dispose()
	GuildBossRankItem.super.Dispose(self)
end

return GuildBossRankItem
