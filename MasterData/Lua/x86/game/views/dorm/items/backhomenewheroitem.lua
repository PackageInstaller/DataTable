local BackHomeNewHeroItem = class("BackHomeNewHeroItem", ReduxView)

function BackHomeNewHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function BackHomeNewHeroItem:InitUI()
	self:BindCfgUI()

	self.fatigueController = ControllerUtil.GetController(self.transform_, "fatigue")
	self.jobController = ControllerUtil.GetController(self.transform_, "state")
	self.curPositionController = ControllerUtil.GetController(self.transform_, "currentPosition")
end

function BackHomeNewHeroItem:RefreshUI(arg_3_1)
	if arg_3_1 and arg_3_1 > 0 then
		self.jobController:SetSelectedState("hero")

		if DormNpcTools:CheckIDIsNpc(arg_3_1) then
			self:RefreshNpcInfo(arg_3_1)
		else
			self:RefreshHeroInfo(arg_3_1)
		end
	elseif self.showJobState then
		self.jobController:SetSelectedState("vacancy")
	end
end

function BackHomeNewHeroItem:RefreshNpcInfo(arg_4_1)
	self.heroID = arg_4_1
	self.iconImg_.sprite = DormNpcTools:GetNpcHeadSprite(arg_4_1)

	if self.showFatigue then
		self.fatigueController:SetSelectedState("suff")
	else
		self.fatigueController:SetSelectedState("none")
	end

	if self.showState then
		self.state = BackHomeNpcData:GetNpcInfoById(arg_4_1):GetHeroState()

		if self.state == DormEnum.DormHeroState.InCanteenEntrust then
			self.jobController:SetSelectedState("busy")
		elseif self.state == DormEnum.DormHeroState.InCanteenJob then
			self.jobController:SetSelectedState("restaurant")
		elseif self.state == DormEnum.DormHeroState.InPublicDorm then
			self.jobController:SetSelectedState("hall")
		elseif self.state == DormEnum.DormHeroState.InPrivateDorm then
			self.curPositionController:SetSelectedState("dorm")
		elseif self.state == DormEnum.DormHeroState.OutDorm then
			self.curPositionController:SetSelectedState("dorm")
		elseif self.state == DormEnum.DormHeroState.InIdolTraineeCamp then
			self.jobController:SetSelectedState("train")
		end
	else
		self.curPositionController:SetSelectedState("no")
	end
end

function BackHomeNewHeroItem:RefreshHeroInfo(arg_5_1, arg_5_2)
	self.heroID = arg_5_1
	self.archiveID = DormData:GetHeroArchiveID(arg_5_1)
	self.iconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_5_1)

	local var_5_0 = DormData:GetHeroTemplateInfo(self.heroID)

	if self.showFatigue then
		local var_5_1 = var_5_0:GetFatigue()

		if var_5_0:GetFatigue() <= GameDisplayCfg.dorm_hero_fatigue_level.value[1] then
			self.fatigueController:SetSelectedState("low")
		elseif var_5_0:GetFatigue() > GameDisplayCfg.dorm_hero_fatigue_level.value[1] and var_5_0:GetFatigue() <= GameDisplayCfg.dorm_hero_fatigue_level.value[2] then
			self.fatigueController:SetSelectedState("middle")
		else
			self.fatigueController:SetSelectedState("suff")
		end
	else
		self.fatigueController:SetSelectedState("none")
	end

	if self.showState then
		self.state = var_5_0:GetHeroState()

		if self.state == DormEnum.DormHeroState.InCanteenEntrust then
			self.jobController:SetSelectedState("busy")
		elseif self.state == DormEnum.DormHeroState.InCanteenJob then
			self.jobController:SetSelectedState("restaurant")
		elseif self.state == DormEnum.DormHeroState.InPublicDorm then
			self.jobController:SetSelectedState("hall")
		elseif self.state == DormEnum.DormHeroState.InPrivateDorm then
			self.curPositionController:SetSelectedState("dorm")
		elseif self.state == DormEnum.DormHeroState.OutDorm then
			self.curPositionController:SetSelectedState("dorm")
		elseif self.state == DormEnum.DormHeroState.InIdolTraineeCamp then
			self.jobController:SetSelectedState("train")
		end
	else
		self.curPositionController:SetSelectedState("no")
	end
end

function BackHomeNewHeroItem:SetItemFunction(arg_6_1)
	if arg_6_1 then
		self.showState = arg_6_1.showState
		self.showFatigue = arg_6_1.showFatigue
		self.showJobState = arg_6_1.showJobState
	end
end

function BackHomeNewHeroItem:Dispose()
	self:RemoveAllListeners()
	BackHomeNewHeroItem.super.Dispose(self)
end

return BackHomeNewHeroItem
