local DormIlluHeroDetailView = class("DormIlluHeroDetailView", ReduxView)

function DormIlluHeroDetailView:UIName()
	return "Widget/BackHouseUI/IdolDance/IdolDanceIllustrateHeroDetailsUI"
end

function DormIlluHeroDetailView:UIParent()
	return manager.ui.uiMain.transform
end

function DormIlluHeroDetailView:Init()
	self:InitUI()
end

function DormIlluHeroDetailView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function DormIlluHeroDetailView:OnBehind()
	manager.windowBar:HideBar()
end

function DormIlluHeroDetailView:OnEnter()
	if self.infoPage_ then
		self.infoPage_:OnEnter(self.params_.heroID, function(arg_7_0)
			self:PlayAction(arg_7_0)
		end)
	end

	self:ChangeHeroID(self.params_.heroID)

	self.heroIDList_ = self.params_.heroIDList
	self.doneAniList_ = {}

	for iter_6_0, iter_6_1 in ipairs(self.heroIDList_) do
		if iter_6_1 == self.heroID_ then
			self.enterIndex_ = iter_6_0
		end
	end

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:SetMainCamera("hero")
end

function DormIlluHeroDetailView:OnExit()
	manager.audio:StopEffect()

	if self.infoPage_ then
		self.infoPage_:OnExit()
	end

	if self.entityID_ and self.entityID_ ~= 0 then
		DormIllu.RemoveHero(self.entityID_)

		self.entityID_ = 0
	end

	self.heroID_ = 0
	self.archiveID_ = 0
	self.enterIndex_ = 0

	manager.ui:ResetMainCamera()
end

function DormIlluHeroDetailView:Dispose()
	if self.infoPage_ then
		self.infoPage_:Dispose()

		self.infoPage_ = nil
	end

	for iter_9_0 = 1, #self.roleTabs_ do
		self.roleTabs_[iter_9_0]:Dispose()
	end

	if self.entityID_ and self.entityID_ ~= 0 then
		DormIllu.RemoveHero(self.entityID_)

		self.entityID_ = 0
	end

	DormIlluHeroDetailView.super.Dispose(self)
end

function DormIlluHeroDetailView:InitUI()
	self:BindCfgUI()
	self:BindController()
	self:AddUIListener()

	self.infoPage_ = DormIlluHeroDetailInfoView.New(self.heroInfoSubView_)
	self.heroIDList_ = {}
	self.heroID_ = 0
	self.archiveID_ = 0
	self.roleIndex_ = 0
	self.roleTabs_ = {}
	self.roleIDList_ = {}
	self.enterIndex_ = 0
end

function DormIlluHeroDetailView:BindController()
	self.roleSwitchController_ = self.mainControllerEx_:GetController("roleSwitch")
end

function DormIlluHeroDetailView:AddUIListener()
	self:AddBtnListener(self.leftBtn_, nil, function()
		local var_13_0 = 0

		if self.enterIndex_ == 1 then
			var_13_0 = self.heroIDList_[#self.heroIDList_]
			self.enterIndex_ = #self.heroIDList_
		else
			var_13_0 = self.heroIDList_[self.enterIndex_ - 1]
			self.enterIndex_ = self.enterIndex_ - 1
		end

		self:ChangeHeroID(var_13_0)
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		local var_14_0 = 0

		if self.enterIndex_ == #self.heroIDList_ then
			var_14_0 = self.heroIDList_[1]
			self.enterIndex_ = 1
		else
			var_14_0 = self.heroIDList_[self.enterIndex_ + 1]
			self.enterIndex_ = self.enterIndex_ + 1
		end

		self:ChangeHeroID(var_14_0)
	end)
	self:AddDragListener(self.backGo_, function()
		local var_15_0 = Dorm.DormEntityManager.GetTransform(self.entityID_)

		self.startRot_ = var_15_0 and var_15_0.localEulerAngles or Vector3.zero
		self.lastRotateY_ = nil
		self.lastDeltaX_ = 0
	end, function(arg_16_0, arg_16_1)
		local var_16_0 = Dorm.DormEntityManager.GetTransform(self.entityID_)

		if var_16_0 then
			local var_16_1 = self.lastRotateY_ or var_16_0.localEulerAngles.y
			local var_16_2 = var_16_1 + (arg_16_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_16_1

			if var_16_1 + (arg_16_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_16_1 < -HeroConst.MAX_RORATE_ANGLE then
				var_16_2 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_16_1 + (arg_16_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_16_1 > HeroConst.MAX_RORATE_ANGLE then
				var_16_2 = HeroConst.MAX_RORATE_ANGLE
			end

			self.lastRotateY_ = var_16_1 + var_16_2
			self.lastDeltaX_ = arg_16_0
			var_16_0.localRotation = Quaternion.RotateTowards(var_16_0.localRotation, Quaternion.Euler(self.startRot_.x, var_16_1 + var_16_2, self.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function DormIlluHeroDetailView:PlayAction(arg_17_1)
	manager.audio:StopEffect()

	if self.entityID_ then
		Dorm.DormEntityManager.StopAllCmd(self.entityID_)

		if arg_17_1 and arg_17_1 ~= -1 then
			Dorm.DormEntityManager.SendInteractToEntityCMD(self.entityID_, self.entityID_, arg_17_1, false)
		end
	end
end

function DormIlluHeroDetailView:ChangeHeroID(arg_18_1)
	if self.heroID_ == arg_18_1 then
		return
	end

	manager.audio:StopEffect()

	self.doneAniList_ = {}
	self.heroID_ = arg_18_1
	self.archiveID_ = DormData:GetHeroArchiveID(arg_18_1)

	self:UpdateView()
end

function DormIlluHeroDetailView:UpdateView()
	self:UpdateRoleSwitchView()

	if self.entityID_ and self.entityID_ ~= 0 then
		DormIllu.RemoveHero(self.entityID_)

		self.entityID_ = 0
	end

	self.entityID_ = DormIllu.GetHero(self.heroID_)

	Dorm.DormEntityManager.PutEntityAt(self.entityID_, Vector3.New(500.37, 1.29, 3.36))
	self.infoPage_:UpdateView(self.heroID_, self.entityID_)
end

function DormIlluHeroDetailView:UpdateRoleSwitchView()
	self.roleIDList_ = {}

	for iter_20_0, iter_20_1 in ipairs(HeroRecordCfg[self.archiveID_].hero_id) do
		if HeroCfg[iter_20_1].private ~= 1 and not HeroTools.GetIsHide(iter_20_1) then
			table.insert(self.roleIDList_, iter_20_1)
		end
	end

	for iter_20_2 = 1, #self.roleTabs_ do
		self.roleTabs_[iter_20_2]:Hide()
		self.roleTabs_[iter_20_2]:SetSelectState(false)
	end

	for iter_20_3 = 1, #self.roleIDList_ do
		self.roleTabs_[iter_20_3] = self.roleTabs_[iter_20_3] or DormRoleTabItem.New(Object.Instantiate(self.heroItemGo_, self.heroTabTrs_), function()
			self:OnClickRoleTab(iter_20_3)
		end)

		self.roleTabs_[iter_20_3]:Show(self.roleIDList_[iter_20_3])

		if self.roleIDList_[iter_20_3] == self.heroID_ then
			self.roleTabs_[iter_20_3]:SetSelectState(true)

			self.roleIndex_ = iter_20_3
		end
	end
end

function DormIlluHeroDetailView:OnClickRoleTab(arg_22_1)
	if arg_22_1 == self.roleIndex_ then
		return
	end

	if self.roleTabs_[self.roleIndex_] then
		self.roleTabs_[self.roleIndex_]:SetSelectState(false)
	end

	self.roleTabs_[arg_22_1]:SetSelectState(true)

	self.roleIndex_ = arg_22_1

	self:ChangeHeroID(self.roleIDList_[arg_22_1])
	self:UpdateView()
end

return DormIlluHeroDetailView
