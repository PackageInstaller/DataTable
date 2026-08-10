local var_0_0 = class("IdolTraineeTrainInfoPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.override1_ = arg_1_2
	arg_1_0.override2_ = arg_1_3
	arg_1_0.enableLockControl = false

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.curHeroID_ = 0
	arg_2_0.curContent_ = 0
	arg_2_0.propertyItemList_ = {}

	for iter_2_0 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
		arg_2_0.propertyItemList_[iter_2_0] = TrainInfoPropertyItem.New(arg_2_0["property" .. iter_2_0 .. "Go_"])
	end

	arg_2_0.skillItemList_ = {}

	for iter_2_1 = 1, 3 do
		arg_2_0.skillItemList_[iter_2_1] = TrainInfoSkillItem.New(arg_2_0["skill" .. iter_2_1 .. "Go_"])
	end

	arg_2_0.heroAllProperty_ = 0
	arg_2_0.styleUIList = IdolStyleTagItemList.New(arg_2_0.gameObject_)
	arg_2_0.contentController_ = arg_2_0.mainControllerEx_:GetController("content")
	arg_2_0.flashBarController_ = arg_2_0.mainControllerEx_:GetController("flashBar")
	arg_2_0.lockController = arg_2_0.mainControllerEx_:GetController("lock")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.propertyBtn_, nil, function()
		if arg_3_0.override1_ then
			arg_3_0.override1_()

			return
		end

		arg_3_0:ChangeContent(1)
	end)
	arg_3_0:AddBtnListener(arg_3_0.skillBtn_, nil, function()
		if arg_3_0.override2_ then
			arg_3_0.override2_()

			return
		end

		arg_3_0:ChangeContent(2)
	end)
	arg_3_0:AddBtnListener(arg_3_0.lockBtn_, nil, function()
		local var_6_0, var_6_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_3_0.curHeroID_)

		if var_6_0 then
			BackHomeAction.SetLockBackHomeHero(arg_3_0.curHeroID_, DormConst.LOCK_HERO_FOR_FEATURE.NONE)
		else
			if not HeroTools.GetHeroIsUnlock(arg_3_0.curHeroID_) then
				return
			end

			ShowMessageBox({
				content = GetTips("IDOL_DANCE_HERO_LOCK_CONFIRM"),
				OkCallback = function()
					BackHomeAction.SetLockBackHomeHero(arg_3_0.curHeroID_, DormConst.LOCK_HERO_FOR_FEATURE.LOCK_FOR_IDOL_TRAINING)
				end
			})
		end
	end)
end

function var_0_0.RegisterEvents(arg_8_0)
	arg_8_0:RegistEventListener(DORM_LOCK_HERO_FOR_FEATURE, function(arg_9_0)
		if arg_9_0 == arg_8_0.curHeroID_ then
			arg_8_0:RefreshUI(arg_8_0.template)
		end
	end)
end

function var_0_0.EnableLockControl(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.enableLockControl ~= arg_10_1 then
		arg_10_0.enableLockControl = arg_10_1

		if arg_10_2 then
			arg_10_0:RefreshUI(arg_10_0.template)
		end
	end
end

function var_0_0.GetDisplayLockState(arg_11_0)
	if arg_11_0.enableLockControl then
		local var_11_0 = arg_11_0.curHeroID_
		local var_11_1, var_11_2 = BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(var_11_0)

		if var_11_1 then
			return "lock"
		elseif HeroTools.GetHeroIsUnlock(arg_11_0.curHeroID_) then
			return "unlock"
		end
	end

	return "hide"
end

function var_0_0.IndexStyleItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.styleData_[arg_12_1])
end

function var_0_0.RefreshUI(arg_13_0, arg_13_1)
	arg_13_0.curContent_ = nil

	if arg_13_1 and arg_13_1.heroID == 0 then
		-- block empty
	else
		arg_13_0.template = arg_13_1
		arg_13_0.curHeroID_ = arg_13_1.heroID
		arg_13_0.heroAllProperty_ = 0

		for iter_13_0, iter_13_1 in ipairs(arg_13_0.template.propertyData) do
			arg_13_0.heroAllProperty_ = arg_13_0.heroAllProperty_ + iter_13_1
		end

		if HeroCfg[arg_13_0.curHeroID_] then
			arg_13_0.name_.text = HeroCfg[arg_13_0.curHeroID_].suffix
			arg_13_0.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(arg_13_0.curHeroID_)
		elseif IdolPveNpcCfg[arg_13_0.curHeroID_] then
			arg_13_0.name_.text = IdolPveNpcCfg[arg_13_0.curHeroID_].name

			local var_13_0 = IdolPveNpcCfg[arg_13_0.curHeroID_].race

			arg_13_0.raceIcon_.sprite = HeroTools.GetRaceIcon(var_13_0)
		end

		if BackHomeHeroCfg[arg_13_0.curHeroID_] then
			arg_13_0.styleData_ = BackHomeHeroCfg[arg_13_0.curHeroID_].idol_style

			arg_13_0:UpdateStyleTag()
		end

		arg_13_0.heroIcon_.sprite = arg_13_1.heroIcon

		arg_13_0.lockController:SetSelectedState(arg_13_0:GetDisplayLockState())
		arg_13_0:ChangeContent(2)
		arg_13_0:ChangeContent(1)
	end
end

function var_0_0.ChangeContent(arg_14_0, arg_14_1)
	if arg_14_0.curContent_ == arg_14_1 then
		return
	end

	arg_14_0.curContent_ = arg_14_1

	if arg_14_1 == 1 then
		arg_14_0.contentController_:SetSelectedState("property")

		local var_14_0 = arg_14_0.template.propertyData
		local var_14_1 = arg_14_0.template.propertyMax

		for iter_14_0 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
			arg_14_0.propertyItemList_[iter_14_0]:SetData(var_14_0[iter_14_0], var_14_1[iter_14_0])
		end
	else
		arg_14_0.contentController_:SetSelectedState("skill")

		local var_14_2 = arg_14_0.template.skill

		for iter_14_1 = 1, #var_14_2 do
			arg_14_0.skillItemList_[iter_14_1]:SetData(var_14_2[iter_14_1], arg_14_0.heroAllProperty_)
			SetActive(arg_14_0.skillItemList_[iter_14_1].gameObject_, true)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.skillItemList_[iter_14_1].transform_)
		end

		for iter_14_2 = #var_14_2 + 1, #arg_14_0.skillItemList_ do
			SetActive(arg_14_0.skillItemList_[iter_14_2].gameObject_, false)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.skillRootTrs_)
	end
end

function var_0_0.SelectFlashBar(arg_15_0, arg_15_1)
	arg_15_0.flashBarController_:SetSelectedState(arg_15_1)

	if arg_15_1 == 0 then
		return
	end

	arg_15_0.previewTrs_:SetAnchoredPositionY(arg_15_0.propertyItemList_[arg_15_1].transform_.anchoredPosition.y - 284)

	local var_15_0 = DormData:GetHeroTemplateInfo(arg_15_0.template.heroID):GetFatigue()
	local var_15_1 = arg_15_0.template.propertyData[arg_15_1]
	local var_15_2 = arg_15_0.template.propertyMax[arg_15_1]
	local var_15_3 = 10

	for iter_15_0, iter_15_1 in ipairs(GameSetting.dorm_idol_hero_exercise_default_value.value) do
		if var_15_1 / var_15_2 * 100 >= iter_15_1[1] then
			var_15_3 = iter_15_1[2]
		end
	end

	local var_15_4 = 0

	for iter_15_2, iter_15_3 in ipairs(GameSetting.dorm_idol_hero_exercise_fatigue_addition.value) do
		if var_15_0 >= iter_15_3[1] then
			var_15_4 = iter_15_3[2]
		end
	end

	local var_15_5 = 0

	if IdolTraineeTools:CheckHeroRaceBuff(arg_15_0.template.heroID) then
		var_15_5 = GameSetting.dorm_idol_hero_exercise_camp_addition.value[1]
	end

	local var_15_6 = math.floor(var_15_3 * (100 + var_15_4 + var_15_5) / 10000 * GameSetting.dorm_idol_hero_exercise_random.value[1])
	local var_15_7 = math.floor(var_15_3 * (100 + var_15_4 + var_15_5) / 10000 * GameSetting.dorm_idol_hero_exercise_random.value[2])
	local var_15_8 = math.floor(var_15_2 - var_15_1)

	if var_15_7 < var_15_8 then
		arg_15_0.previewText_.text = "+" .. var_15_6 .. "~" .. var_15_7
	elseif var_15_6 < var_15_8 then
		arg_15_0.previewText_.text = "+" .. var_15_6 .. "~" .. var_15_8
	else
		arg_15_0.previewText_.text = "+" .. var_15_8
	end
end

function var_0_0.PlayAddAnim(arg_16_0, arg_16_1)
	arg_16_0.propertyItemList_[arg_16_1]:PlayAddAnim()
	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_unlock")
end

function var_0_0.UpdateStyleTag(arg_17_0)
	arg_17_0.styleUIList:SetData(arg_17_0.styleData_)
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.propertyItemList_) do
		iter_18_1:Dispose()
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0.skillItemList_) do
		iter_18_3:Dispose()
	end

	arg_18_0.styleUIList:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
