local IdolTraineeTrainInfoPage = class("IdolTraineeTrainInfoPage", ReduxView)

function IdolTraineeTrainInfoPage:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.override1_ = arg_1_2
	self.override2_ = arg_1_3
	self.enableLockControl = false

	self:InitUI()
end

function IdolTraineeTrainInfoPage:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.curHeroID_ = 0
	self.curContent_ = 0
	self.propertyItemList_ = {}

	for iter_2_0 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
		self.propertyItemList_[iter_2_0] = TrainInfoPropertyItem.New(self["property" .. iter_2_0 .. "Go_"])
	end

	self.skillItemList_ = {}

	for iter_2_1 = 1, 3 do
		self.skillItemList_[iter_2_1] = TrainInfoSkillItem.New(self["skill" .. iter_2_1 .. "Go_"])
	end

	self.heroAllProperty_ = 0
	self.styleUIList = IdolStyleTagItemList.New(self.gameObject_)
	self.contentController_ = self.mainControllerEx_:GetController("content")
	self.flashBarController_ = self.mainControllerEx_:GetController("flashBar")
	self.lockController = self.mainControllerEx_:GetController("lock")
end

function IdolTraineeTrainInfoPage:AddUIListener()
	self:AddBtnListener(self.propertyBtn_, nil, function()
		if self.override1_ then
			self.override1_()

			return
		end

		self:ChangeContent(1)
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
		if self.override2_ then
			self.override2_()

			return
		end

		self:ChangeContent(2)
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		local var_6_0, var_6_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(self.curHeroID_)

		if var_6_0 then
			BackHomeAction.SetLockBackHomeHero(self.curHeroID_, DormConst.LOCK_HERO_FOR_FEATURE.NONE)
		else
			if not HeroTools.GetHeroIsUnlock(self.curHeroID_) then
				return
			end

			ShowMessageBox({
				content = GetTips("IDOL_DANCE_HERO_LOCK_CONFIRM"),
				OkCallback = function()
					BackHomeAction.SetLockBackHomeHero(self.curHeroID_, DormConst.LOCK_HERO_FOR_FEATURE.LOCK_FOR_IDOL_TRAINING)
				end
			})
		end
	end)
end

function IdolTraineeTrainInfoPage:RegisterEvents()
	self:RegistEventListener(DORM_LOCK_HERO_FOR_FEATURE, function(arg_9_0)
		if arg_9_0 == self.curHeroID_ then
			self:RefreshUI(self.template)
		end
	end)
end

function IdolTraineeTrainInfoPage:EnableLockControl(arg_10_1, arg_10_2)
	if self.enableLockControl ~= arg_10_1 then
		self.enableLockControl = arg_10_1

		if arg_10_2 then
			self:RefreshUI(self.template)
		end
	end
end

function IdolTraineeTrainInfoPage:GetDisplayLockState()
	if self.enableLockControl then
		local var_11_0, var_11_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(self.curHeroID_)

		if var_11_0 then
			return "lock"
		elseif HeroTools.GetHeroIsUnlock(self.curHeroID_) then
			return "unlock"
		end
	end

	return "hide"
end

function IdolTraineeTrainInfoPage:IndexStyleItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.styleData_[arg_12_1])
end

function IdolTraineeTrainInfoPage:RefreshUI(arg_13_1)
	self.curContent_ = nil

	if arg_13_1 and arg_13_1.heroID == 0 then
		-- block empty
	else
		self.template = arg_13_1
		self.curHeroID_ = arg_13_1.heroID
		self.heroAllProperty_ = 0

		for iter_13_0, iter_13_1 in ipairs(self.template.propertyData) do
			self.heroAllProperty_ = self.heroAllProperty_ + iter_13_1
		end

		if HeroCfg[self.curHeroID_] then
			self.name_.text = HeroCfg[self.curHeroID_].suffix
			self.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(self.curHeroID_)
		elseif IdolPveNpcCfg[self.curHeroID_] then
			self.name_.text = IdolPveNpcCfg[self.curHeroID_].name
			self.raceIcon_.sprite = HeroTools.GetRaceIcon(IdolPveNpcCfg[self.curHeroID_].race)
		end

		if BackHomeHeroCfg[self.curHeroID_] then
			self.styleData_ = BackHomeHeroCfg[self.curHeroID_].idol_style

			self:UpdateStyleTag()
		end

		self.heroIcon_.sprite = arg_13_1.heroIcon

		self.lockController:SetSelectedState(self:GetDisplayLockState())
		self:ChangeContent(2)
		self:ChangeContent(1)
	end
end

function IdolTraineeTrainInfoPage:ChangeContent(arg_14_1)
	if self.curContent_ == arg_14_1 then
		return
	end

	self.curContent_ = arg_14_1

	if arg_14_1 == 1 then
		self.contentController_:SetSelectedState("property")

		for iter_14_0 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
			self.propertyItemList_[iter_14_0]:SetData(self.template.propertyData[iter_14_0], self.template.propertyMax[iter_14_0])
		end
	else
		self.contentController_:SetSelectedState("skill")

		for iter_14_1 = 1, #self.template.skill do
			self.skillItemList_[iter_14_1]:SetData(self.template.skill[iter_14_1], self.heroAllProperty_)
			SetActive(self.skillItemList_[iter_14_1].gameObject_, true)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.skillItemList_[iter_14_1].transform_)
		end

		for iter_14_2 = #self.template.skill + 1, #self.skillItemList_ do
			SetActive(self.skillItemList_[iter_14_2].gameObject_, false)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.skillRootTrs_)
	end
end

function IdolTraineeTrainInfoPage:SelectFlashBar(arg_15_1)
	self.flashBarController_:SetSelectedState(arg_15_1)

	if arg_15_1 == 0 then
		return
	end

	self.previewTrs_:SetAnchoredPositionY(self.propertyItemList_[arg_15_1].transform_.anchoredPosition.y - 284)

	local var_15_0 = DormData:GetHeroTemplateInfo(self.template.heroID):GetFatigue()
	local var_15_1 = 10

	for iter_15_0, iter_15_1 in ipairs(GameSetting.dorm_idol_hero_exercise_default_value.value) do
		if self.template.propertyData[arg_15_1] / self.template.propertyMax[arg_15_1] * 100 >= iter_15_1[1] then
			var_15_1 = iter_15_1[2]
		end
	end

	local var_15_2 = 0

	for iter_15_2, iter_15_3 in ipairs(GameSetting.dorm_idol_hero_exercise_fatigue_addition.value) do
		if var_15_0 >= iter_15_3[1] then
			var_15_2 = iter_15_3[2]
		end
	end

	local var_15_3 = 0

	if IdolTraineeTools:CheckHeroRaceBuff(self.template.heroID) then
		var_15_3 = GameSetting.dorm_idol_hero_exercise_camp_addition.value[1]
	end

	local var_15_4 = math.floor(var_15_1 * (100 + var_15_2 + var_15_3) / 10000 * GameSetting.dorm_idol_hero_exercise_random.value[1])
	local var_15_5 = math.floor(var_15_1 * (100 + var_15_2 + var_15_3) / 10000 * GameSetting.dorm_idol_hero_exercise_random.value[2])
	local var_15_6 = math.floor(self.template.propertyMax[arg_15_1] - self.template.propertyData[arg_15_1])

	self.previewText_.text = var_15_5 < var_15_6 and "+" .. var_15_4 .. "~" .. var_15_5 or var_15_4 < var_15_6 and "+" .. var_15_4 .. "~" .. var_15_6 or "+" .. var_15_6
end

function IdolTraineeTrainInfoPage:PlayAddAnim(arg_16_1)
	self.propertyItemList_[arg_16_1]:PlayAddAnim()
	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_unlock")
end

function IdolTraineeTrainInfoPage:UpdateStyleTag()
	self.styleUIList:SetData(self.styleData_)
end

function IdolTraineeTrainInfoPage:Dispose()
	for iter_18_0, iter_18_1 in pairs(self.propertyItemList_) do
		iter_18_1:Dispose()
	end

	for iter_18_2, iter_18_3 in pairs(self.skillItemList_) do
		iter_18_3:Dispose()
	end

	self.styleUIList:Dispose()
	IdolTraineeTrainInfoPage.super.Dispose(self)
end

return IdolTraineeTrainInfoPage
