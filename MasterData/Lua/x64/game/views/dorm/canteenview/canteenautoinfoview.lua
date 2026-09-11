local CanteenAutoInfoView = class("CanteenAutoInfoView", ReduxView)

function CanteenAutoInfoView:UIName()
	return "Widget/BackHouseUI/Dining/BackHomeCanteenBusinessDetailsUI"
end

function CanteenAutoInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function CanteenAutoInfoView:OnCtor()
	return
end

function CanteenAutoInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CanteenAutoInfoView:InitUI()
	self:BindCfgUI()
end

function CanteenAutoInfoView:OnEnter()
	self:RegisterEvent()
	self:RefreshView()
end

function CanteenAutoInfoView:OnExit()
	self.selHero = nil

	self:RemoveAllEventListener()

	if self.foodList then
		for iter_7_0, iter_7_1 in pairs(self.foodList) do
			iter_7_1:Dispose()
		end

		self.foodList = nil
	end

	if self.buffList then
		for iter_7_2, iter_7_3 in pairs(self.buffList) do
			iter_7_3:Dispose()
		end

		self.buffList = nil
	end
end

function CanteenAutoInfoView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function CanteenAutoInfoView:RegisterEvent()
	self:RegistEventListener(CANTEEN_SIGN_FOOD_INFO_CHANGE, function()
		self:RefreshSignFoodInfo()
	end)
	self:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		self:RefreshJobInfo()
	end)
end

function CanteenAutoInfoView:RefreshView()
	self:RefreshBuffInfo()
	self:RefreshSignFoodInfo()
	self:RefreshJobInfo()
end

function CanteenAutoInfoView:RefreshBuffInfo()
	self.skillList = {}

	for iter_14_0, iter_14_1 in ipairs(CanteenConst.AutoInfo) do
		if iter_14_1 == CanteenConst.HeroSkillType.FoodCostQucik or iter_14_1 == CanteenConst.HeroSkillType.FoodCostRise then
			for iter_14_2, iter_14_3 in pairs(DormEnum.FurnitureTypeNum) do
				if DormSkillData:GetSkillEffect(iter_14_1, nil, nil, iter_14_3) ~= 0 then
					table.insert(self.skillList, {
						skillType = iter_14_1,
						foodType = iter_14_3
					})
				end
			end
		elseif DormSkillData:GetSkillEffect(iter_14_1) > 0 then
			table.insert(self.skillList, {
				skillType = iter_14_1
			})
		end
	end

	if not self.buffList then
		self.buffList = {}

		if #self.skillList > 0 then
			for iter_14_4 = 1, #self.skillList do
				self.buffList[iter_14_4] = CanteenGainItem.New(self.buffitemGo_1, self.contentTrs_)
			end
		end
	end

	if self.buffList then
		for iter_14_5, iter_14_6 in pairs(self.buffList) do
			iter_14_6:RefreshUI(self.skillList[iter_14_5])
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.buffContentTrs)
end

function CanteenAutoInfoView:RefreshSignFoodInfo()
	self.signFoodList = {}
	self.signFoodList = CanteenFoodData:GetChooseFoodList()

	if not self.foodList then
		self.foodList = {}

		if #self.signFoodList > 0 then
			for iter_15_0 = 1, #self.signFoodList do
				self.foodList[iter_15_0] = CanteenSignFoodInfoItem.New(self.incomeitemGo_1, self.incomepanelTrs_)
			end
		end
	end

	if self.foodList then
		for iter_15_1, iter_15_2 in pairs(self.foodList) do
			iter_15_2:RefreshUI(self.signFoodList[iter_15_1])
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs)
end

function CanteenAutoInfoView:RefreshJobInfo()
	self.jobList = {}

	for iter_16_0, iter_16_1 in ipairs(DormEnum.RestaurantJobToClientMap) do
		table.insert(self.jobList, iter_16_0)
	end

	if not self.heroList then
		self.heroList = {}

		if #self.jobList > 0 then
			for iter_16_2 = 1, #self.jobList do
				self.heroList[iter_16_2] = CanteenJobInfoItem.New(self.heroitemGo_1, self.positionpanelTrs_)
			end
		end
	end

	if self.heroList then
		for iter_16_3, iter_16_4 in pairs(self.heroList) do
			iter_16_4:RefreshUI(self.jobList[iter_16_3])
		end
	end
end

function CanteenAutoInfoView:indexBuffList(arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(self.skillList[arg_17_1])
end

function CanteenAutoInfoView:indexSignFoodList(arg_18_1, arg_18_2)
	arg_18_2:RefreshUI(self.signFoodList[arg_18_1])
end

function CanteenAutoInfoView:indexJobList(arg_19_1, arg_19_2)
	arg_19_2:RefreshUI(self.skillList[arg_19_1])
end

function CanteenAutoInfoView:Dispose()
	if self.heroScroll then
		self.heroScroll:Dispose()

		self.heroScroll = nil
	end

	if self.buffList then
		for iter_20_0, iter_20_1 in pairs(self.buffList) do
			iter_20_1:Dispose()
		end
	end

	if self.heroList then
		for iter_20_2, iter_20_3 in pairs(self.heroList) do
			iter_20_3:Dispose()
		end
	end

	CanteenAutoInfoView.super.Dispose(self)
end

return CanteenAutoInfoView
