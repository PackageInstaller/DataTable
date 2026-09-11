local IdolTraineeTrainView = class("IdolTraineeTrainView", ReduxView)

function IdolTraineeTrainView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeTrainView"
end

function IdolTraineeTrainView:UIParent()
	return manager.ui.uiMain.transform
end

function IdolTraineeTrainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTraineeTrainView:InitUI()
	self:BindCfgUI()

	self.infoPage_ = IdolTraineeTrainInfoPage.New(self.pageGo_)

	self.infoPage_:EnableLockControl(true)

	self.trainBtnItemList_ = {}

	for iter_4_0 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
		self.trainBtnItemList_[iter_4_0] = TrainBtnItem.New(self["train" .. iter_4_0 .. "Btn_"])

		self.trainBtnItemList_[iter_4_0]:RegisterClickFunc(handler(self, self.UpdataSelectBtnState))
	end

	self.skipShow_ = 0
	self.backToDormInfo = false
	self.heroList_ = {}
	self.curHeroID_ = 0
	self.curHeroIndex_ = 0
	self.heroUIList_ = LuaList.New(handler(self, self.IndexItem), self.heroUIList_, IdolTraineeHeadItem)
	self.trainAnimController_ = self.mainControllerEx_:GetController("trainAnimation")
	self.lockController_ = self.mainControllerEx_:GetController("lock")
	self.SkipTheShowController_ = self.mainControllerEx_:GetController("SkipTheShow")
	self.clearController_ = self.mainControllerEx_:GetController("clear")
end

function IdolTraineeTrainView:AddUIListener()
	self:AddBtnListener(self.skipBtn_, nil, function()
		manager.notify:Invoke(ON_FINISH_STORY)
	end)
	self:AddBtnListener(self.skipShowBtn_, nil, function()
		self.skipShow_ = self.skipShow_ == 1 and 0 or 1

		self.SkipTheShowController_:SetSelectedState(self.skipShow_ == 1 and "on" or "off")
		saveData("IdolTrainee", "skip_show", self.skipShow_)
	end)
	self:AddBtnListener(self.countInfoBtn_, nil, function()
		SetActive(self.countInfoGo_, true)
	end)
	self:AddBtnListener(self.countInfoCloseBtn_, nil, function()
		SetActive(self.countInfoGo_, false)
	end)
end

function IdolTraineeTrainView:RegisterEvents()
	self:RegistEventListener(IDOL_TRAINEE_TRAIN_HERO_PROPERTY_CALLBACK, function(arg_11_0, arg_11_1, arg_11_2)
		self:UpdateView(self.curHeroID_, true)
		self:RefreshTitle()

		if self.skipShow_ == 1 then
			self.infoPage_:PlayAddAnim(arg_11_1)

			return
		end

		manager.windowBar:HideBar()

		self.trainAddIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.IdolDanceSkillIcon.path .. "IdolTrainee_icon_skill_00" .. arg_11_1)
		self.trainAddName_.text = GetTips("IDOL_SKILL_ATTRIBUTE_" .. arg_11_1)
		self.trainAddNum_.text = "+" .. arg_11_2

		self.trainAnimController_:SetSelectedState("true")

		if DormTools.CheckMax(self.curHeroID_) then
			self.heroUIList_:StartScroll(#self.heroList_)
			self:RefreshTitle()
		end
	end)
	self:RegistEventListener(ON_FINISH_STORY, function()
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			self:Back()

			if self.backToDormInfo then
				self.backToDormInfo = false

				JumpTools.OpenPageByJump("/dormChooseRoomView", {
					openInfoPanel = true
				})
			end
		end)
		self.trainAnimController_:SetSelectedState("false")

		if self.curHeroIndex_ and self.heroUIList_ then
			self.heroUIList_:ScrollToIndex(self.curHeroIndex_)
		end
	end)
	self:RegistEventListener(DORM_LOCK_HERO_FOR_FEATURE, function(arg_14_0)
		self:SortHeroList()
		self.heroUIList_:StartScroll(#self.heroList_)
		self:UpdateView(self.curHeroID_)
		self:RefreshTitle()
	end)
end

function IdolTraineeTrainView:OnEnter()
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", true)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.backToDormInfo = self.params_.backToDormInfo or false

	self:RegisterEvents()
	self.infoPage_:RegisterEvents()

	self.heroList_ = IdolTraineeData:GetIdolHeroList(true)

	self:SortHeroList()

	self.curHeroIndex_ = table.keyof(self.heroList_, self.params_.heroID) or 1

	self:UpdateView(self.heroList_[self.curHeroIndex_])
	self.heroUIList_:StartScroll(#self.heroList_)
	self.heroUIList_:ScrollToIndex(self.curHeroIndex_)
	self:RefreshTitle()

	self.skipShow_ = getData("IdolTrainee", "skip_show") or 0

	self.SkipTheShowController_:SetSelectedState(self.skipShow_ == 1 and "on" or "off")
	manager.windowBar:RegistBackCallBack(function()
		self:Back()

		if self.backToDormInfo then
			self.backToDormInfo = false

			JumpTools.OpenPageByJump("/dormChooseRoomView", {
				openInfoPanel = true
			})
		end
	end)
end

function IdolTraineeTrainView:SortHeroList()
	DormTools.SortAttackHeroList(self.heroList_)
end

function IdolTraineeTrainView:OnExit()
	manager.windowBar:HideBar()
	SetActive(self.countInfoGo_, false)
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
	self.infoPage_:RemoveAllEventListener()
	self:RemoveAllEventListener()
end

function IdolTraineeTrainView:IndexItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(self.heroList_[arg_19_1], self.curHeroID_, function()
		if self.curHeroID_ ~= 0 and self.curHeroIndex_ ~= 0 then
			local var_20_0 = self.heroUIList_:GetItemByIndex(self.curHeroIndex_)

			if var_20_0 then
				var_20_0:SelectOff()
			end
		end

		self.curHeroIndex_ = arg_19_1

		arg_19_2:SelectOn()
		self:UpdateView(self.heroList_[arg_19_1])
	end)
end

function IdolTraineeTrainView:RefreshTitle()
	local var_21_0 = IdolTraineeTools:GetCurTrainMaxTimes()

	self.trainCountText_.text = var_21_0 - IdolTraineeData:GetCurTrainTimes() .. "/" .. var_21_0

	local var_21_1 = {}

	for iter_21_0, iter_21_1 in pairs((IdolTraineeData:GetCurBuffCamp())) do
		table.insert(var_21_1, iter_21_0)
	end

	if var_21_1[1] then
		SetActive(self.race1Img_.gameObject, true)

		self.race1Img_.sprite = HeroTools.GetRaceIcon(var_21_1[1])
	else
		SetActive(self.race1Img_.gameObject, false)
	end

	if var_21_1[2] then
		SetActive(self.race2Img_.gameObject, true)

		self.race2Img_.sprite = HeroTools.GetRaceIcon(var_21_1[2])
	else
		SetActive(self.race2Img_.gameObject, false)
	end

	local var_21_2 = DormRoomTools:GetUnlockRoomNum()
	local var_21_3
	local var_21_4

	for iter_21_2, iter_21_3 in ipairs(GameSetting.dorm_idol_hero_exercise_times_limit.value) do
		if var_21_2 < iter_21_3[1] then
			var_21_4 = iter_21_3[2]
			var_21_3 = iter_21_3[1]

			break
		end
	end

	self.countInfoText_.text = not var_21_3 and GetTips("IDOL_TRAIN_COUNT_MAX_NUM_INFO") or string.format(GetTips("IDOL_TRAIN_COUNT_NUM_INFO"), var_21_3, var_21_4, var_21_2)
end

function IdolTraineeTrainView:UpdateView(arg_22_1, arg_22_2)
	self.curHeroID_ = arg_22_1

	if not arg_22_2 then
		IdolTraineeCampBridge.SetTrainingCharacter(self.curHeroID_)
	end

	self.infoPage_:RefreshUI((IdolTraineeTools:GetHeroBattleInfoTemplate(self.curHeroID_)))

	if HeroTools.GetHeroIsUnlock(arg_22_1) then
		self.lockController_:SetSelectedState("off")

		local var_22_0 = IdolTraineeData:GetIdolHeroData(self.curHeroID_)
		local var_22_1 = IdolTraineeTools:GetHeroIdolMaxProperty(self.curHeroID_)
		local var_22_2 = DormData:GetHeroTemplateInfo(arg_22_1)
		local var_22_3 = var_22_2:GetFatigue() >= GameSetting.dorm_idol_hero_exercise_cost.value[1]
		local var_22_4 = IdolTraineeTools:CheckHeroRaceBuff(self.curHeroID_)
		local var_22_5 = IdolTraineeTools:GetCurTrainMaxTimes() <= IdolTraineeData:GetCurTrainTimes()

		for iter_22_0 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
			self.trainBtnItemList_[iter_22_0]:SetData(self.curHeroID_, iter_22_0, var_22_0[iter_22_0] >= var_22_1[iter_22_0], var_22_3, var_22_4, var_22_5)
		end

		self.maxFText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
		self.curFText_.text = var_22_2:GetFatigue()
		self.recFText_.text = string.format(GetTips("DORM_FATIGUE_PER_HOUR"), var_22_2:GetRecoverFatigueNum())
	else
		self.lockController_:SetSelectedState("on")
	end

	if DormTools.CheckMax(self.curHeroID_) then
		self.clearController_:SetSelectedState("state1")
	else
		self.clearController_:SetSelectedState("state0")
	end

	self:UpdataSelectBtnState(0)
end

function IdolTraineeTrainView:UpdataSelectBtnState(arg_23_1)
	self.infoPage_:SelectFlashBar(arg_23_1)

	self.selIndex = arg_23_1

	for iter_23_0, iter_23_1 in ipairs(self.trainBtnItemList_) do
		iter_23_1:RefreshBtnState(self.selIndex)
	end
end

function IdolTraineeTrainView:OnIdolPvpStageUpdateFromServer()
	self:UpdateView(self.curHeroID_)
	self:RefreshTitle()
end

function IdolTraineeTrainView:Dispose()
	if self.heroUIList_ then
		self.heroUIList_:Dispose()

		self.heroUIList_ = nil
	end

	if self.infoPage_ then
		self.infoPage_:Dispose()

		self.infoPage_ = nil
	end

	for iter_25_0, iter_25_1 in pairs(self.trainBtnItemList_) do
		iter_25_1:Dispose()
	end

	IdolTraineeTrainView.super.Dispose(self)
end

return IdolTraineeTrainView
