local GuildBossAssistantHeadItemView = class("GuildBossAssistantHeadItemView", ReduxView)

function GuildBossAssistantHeadItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildBossAssistantHeadItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossAssistantHeadItemView:InitUI()
	self:BindCfgUI()

	self.lockedController_ = ControllerUtil.GetController(self.headGo_.transform, "locked")
	self.campController_ = ControllerUtil.GetController(self.headGo_.transform, "camp")
	self.gradeController_ = ControllerUtil.GetController(self.headGo_.transform, "grade")
	self.sizeController_ = ControllerUtil.GetController(self.headGo_.transform, "size")
	self.hpController_ = ControllerUtil.GetController(self.headGo_.transform, "hp")
	self.selectedController_ = ControllerUtil.GetController(self.gameObject_.transform, "selected")
	self.positionController_ = ControllerUtil.GetController(self.gameObject_.transform, "position")
	self.loveCon_ = ControllerUtil.GetController(self.headGo_.transform, "love")

	ComponentBinder.GetInstance():BindCfgUI(self, self.headGo_)
end

function GuildBossAssistantHeadItemView:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if self.clickListener_ ~= nil then
			self.clickListener_()
		end
	end)
end

function GuildBossAssistantHeadItemView:AddEventListeners()
	return
end

function GuildBossAssistantHeadItemView:SetData(arg_7_1)
	self.data_ = arg_7_1
	self.heroCfg_ = HeroCfg[self.data_.assist_hero_id]

	self:UpdateView()
end

function GuildBossAssistantHeadItemView:SetTeamMark(arg_8_1, arg_8_2)
	SetActive(self.teamMark_, arg_8_1)

	if arg_8_1 then
		self.teamMarkText_.text = GetI18NText(arg_8_2)
	end
end

function GuildBossAssistantHeadItemView:GetHeroId()
	return self.data_.assist_hero_id
end

function GuildBossAssistantHeadItemView:GetOwnerId()
	return self.data_.member_id
end

function GuildBossAssistantHeadItemView:UpdateView()
	local var_11_0 = self.data_.assist_hero_skin

	if self.data_.assist_hero_skin == 0 then
		var_11_0 = self.data_.assist_hero_id
	end

	self.nickLabel_.text = GetI18NText(self.data_.nick)
	self.headIcon_.sprite = HeroTools.GetHeadSprite(var_11_0)

	self.headIcon_:SetNativeSize()
	self.campController_:SetSelectedState(self.heroCfg_.race)
	self.gradeController_:SetSelectedState(HeroStarCfg[self.data_.hero_rare].star)

	self.levelText_.text = self.data_.hero_level
	self.fightPowerLabel_.text = self.data_.fight_capacity

	self.positionController_:SetSelectedState(tostring(self.data_.member_post))
	self.loveCon_:SetSelectedState("off")

	if tostring(self.data_.member_post) == "1" then
		self.clubMemberLabel_.text = GetTips("CLUB_CHAIR_MAN")
	elseif tostring(self.data_.member_post) == "2" then
		self.clubMemberLabel_.text = GetTips("CLUB_VICE_CHAIR_MAN")
	elseif tostring(self.data_.member_post) == "3" then
		self.clubMemberLabel_.text = GetTips("CLUB_MEMBER")
	elseif tostring(self.data_.member_post) == "4" then
		self.clubMemberLabel_.text = GetTips("CLUB_NOVICIATE")
	end
end

function GuildBossAssistantHeadItemView:RegisterClickListener(arg_12_1)
	self.clickListener_ = arg_12_1
end

function GuildBossAssistantHeadItemView:SetSelected(arg_13_1)
	self.selectedController_:SetSelectedState(arg_13_1 and "true" or "false")
end

function GuildBossAssistantHeadItemView:OnEnter()
	self:AddEventListeners()
end

function GuildBossAssistantHeadItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildBossAssistantHeadItemView:OnMainHomeViewTop()
	return
end

function GuildBossAssistantHeadItemView:Dispose()
	self.data_ = nil
	self.clickListener_ = nil

	GuildBossAssistantHeadItemView.super.Dispose(self)
end

return GuildBossAssistantHeadItemView
