local var_0_0 = class("CanteenAutoInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dining/BackHomeCanteenBusinessDetailsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RegisterEvent()
	arg_6_0:RefreshView()
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0.selHero = nil

	arg_7_0:RemoveAllEventListener()

	if arg_7_0.foodList then
		for iter_7_0, iter_7_1 in pairs(arg_7_0.foodList) do
			iter_7_1:Dispose()
		end

		arg_7_0.foodList = nil
	end

	if arg_7_0.buffList then
		for iter_7_2, iter_7_3 in pairs(arg_7_0.buffList) do
			iter_7_3:Dispose()
		end

		arg_7_0.buffList = nil
	end
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.RegisterEvent(arg_10_0)
	arg_10_0:RegistEventListener(CANTEEN_SIGN_FOOD_INFO_CHANGE, function()
		arg_10_0:RefreshSignFoodInfo()
	end)
	arg_10_0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		arg_10_0:RefreshJobInfo()
	end)
end

function var_0_0.RefreshView(arg_13_0)
	arg_13_0:RefreshBuffInfo()
	arg_13_0:RefreshSignFoodInfo()
	arg_13_0:RefreshJobInfo()
end

function var_0_0.RefreshBuffInfo(arg_14_0)
	local var_14_0 = CanteenConst.AutoInfo

	arg_14_0.skillList = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1 == CanteenConst.HeroSkillType.FoodCostQucik or iter_14_1 == CanteenConst.HeroSkillType.FoodCostRise then
			for iter_14_2, iter_14_3 in pairs(DormEnum.FurnitureTypeNum) do
				if DormSkillData:GetSkillEffect(iter_14_1, nil, nil, iter_14_3) ~= 0 then
					local var_14_1 = {
						skillType = iter_14_1,
						foodType = iter_14_3
					}

					table.insert(arg_14_0.skillList, var_14_1)
				end
			end
		elseif DormSkillData:GetSkillEffect(iter_14_1) > 0 then
			local var_14_2 = {
				skillType = iter_14_1
			}

			table.insert(arg_14_0.skillList, var_14_2)
		end
	end

	if not arg_14_0.buffList then
		arg_14_0.buffList = {}

		local var_14_3 = #arg_14_0.skillList

		if var_14_3 > 0 then
			for iter_14_4 = 1, var_14_3 do
				arg_14_0.buffList[iter_14_4] = CanteenGainItem.New(arg_14_0.buffitemGo_1, arg_14_0.contentTrs_)
			end
		end
	end

	if arg_14_0.buffList then
		for iter_14_5, iter_14_6 in pairs(arg_14_0.buffList) do
			iter_14_6:RefreshUI(arg_14_0.skillList[iter_14_5])
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.buffContentTrs)
end

function var_0_0.RefreshSignFoodInfo(arg_15_0)
	arg_15_0.signFoodList = {}
	arg_15_0.signFoodList = CanteenFoodData:GetChooseFoodList()

	if not arg_15_0.foodList then
		arg_15_0.foodList = {}

		local var_15_0 = #arg_15_0.signFoodList

		if var_15_0 > 0 then
			for iter_15_0 = 1, var_15_0 do
				arg_15_0.foodList[iter_15_0] = CanteenSignFoodInfoItem.New(arg_15_0.incomeitemGo_1, arg_15_0.incomepanelTrs_)
			end
		end
	end

	if arg_15_0.foodList then
		for iter_15_1, iter_15_2 in pairs(arg_15_0.foodList) do
			iter_15_2:RefreshUI(arg_15_0.signFoodList[iter_15_1])
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_0.contentTrs)
end

function var_0_0.RefreshJobInfo(arg_16_0)
	arg_16_0.jobList = {}

	for iter_16_0, iter_16_1 in ipairs(DormEnum.RestaurantJobToClientMap) do
		table.insert(arg_16_0.jobList, iter_16_0)
	end

	if not arg_16_0.heroList then
		arg_16_0.heroList = {}

		local var_16_0 = #arg_16_0.jobList

		if var_16_0 > 0 then
			for iter_16_2 = 1, var_16_0 do
				arg_16_0.heroList[iter_16_2] = CanteenJobInfoItem.New(arg_16_0.heroitemGo_1, arg_16_0.positionpanelTrs_)
			end
		end
	end

	if arg_16_0.heroList then
		for iter_16_3, iter_16_4 in pairs(arg_16_0.heroList) do
			iter_16_4:RefreshUI(arg_16_0.jobList[iter_16_3])
		end
	end
end

function var_0_0.indexBuffList(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(arg_17_0.skillList[arg_17_1])
end

function var_0_0.indexSignFoodList(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2:RefreshUI(arg_18_0.signFoodList[arg_18_1])
end

function var_0_0.indexJobList(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:RefreshUI(arg_19_0.skillList[arg_19_1])
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.heroScroll then
		arg_20_0.heroScroll:Dispose()

		arg_20_0.heroScroll = nil
	end

	if arg_20_0.buffList then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.buffList) do
			iter_20_1:Dispose()
		end
	end

	if arg_20_0.heroList then
		for iter_20_2, iter_20_3 in pairs(arg_20_0.heroList) do
			iter_20_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
