local var_0_0 = class("IdolTraineeTrainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeTrainView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.infoPage_ = IdolTraineeTrainInfoPage.New(arg_4_0.pageGo_)

	arg_4_0.infoPage_:EnableLockControl(true)

	arg_4_0.trainBtnItemList_ = {}

	for iter_4_0 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
		arg_4_0.trainBtnItemList_[iter_4_0] = TrainBtnItem.New(arg_4_0["train" .. iter_4_0 .. "Btn_"])

		arg_4_0.trainBtnItemList_[iter_4_0]:RegisterClickFunc(handler(arg_4_0, arg_4_0.UpdataSelectBtnState))
	end

	arg_4_0.skipShow_ = 0
	arg_4_0.backToDormInfo = false
	arg_4_0.heroList_ = {}
	arg_4_0.curHeroID_ = 0
	arg_4_0.curHeroIndex_ = 0
	arg_4_0.heroUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.heroUIList_, IdolTraineeHeadItem)
	arg_4_0.trainAnimController_ = arg_4_0.mainControllerEx_:GetController("trainAnimation")
	arg_4_0.lockController_ = arg_4_0.mainControllerEx_:GetController("lock")
	arg_4_0.SkipTheShowController_ = arg_4_0.mainControllerEx_:GetController("SkipTheShow")
	arg_4_0.clearController_ = arg_4_0.mainControllerEx_:GetController("clear")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.skipBtn_, nil, function()
		manager.notify:Invoke(ON_FINISH_STORY)
	end)
	arg_5_0:AddBtnListener(arg_5_0.skipShowBtn_, nil, function()
		arg_5_0.skipShow_ = arg_5_0.skipShow_ == 1 and 0 or 1

		arg_5_0.SkipTheShowController_:SetSelectedState(arg_5_0.skipShow_ == 1 and "on" or "off")
		saveData("IdolTrainee", "skip_show", arg_5_0.skipShow_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.countInfoBtn_, nil, function()
		SetActive(arg_5_0.countInfoGo_, true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.countInfoCloseBtn_, nil, function()
		SetActive(arg_5_0.countInfoGo_, false)
	end)
end

function var_0_0.RegisterEvents(arg_10_0)
	arg_10_0:RegistEventListener(IDOL_TRAINEE_TRAIN_HERO_PROPERTY_CALLBACK, function(arg_11_0, arg_11_1, arg_11_2)
		arg_10_0:UpdateView(arg_10_0.curHeroID_, true)
		arg_10_0:RefreshTitle()

		if arg_10_0.skipShow_ == 1 then
			arg_10_0.infoPage_:PlayAddAnim(arg_11_1)

			return
		end

		manager.windowBar:HideBar()

		arg_10_0.trainAddIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.IdolDanceSkillIcon.path .. "IdolTrainee_icon_skill_00" .. arg_11_1)
		arg_10_0.trainAddName_.text = GetTips("IDOL_SKILL_ATTRIBUTE_" .. arg_11_1)
		arg_10_0.trainAddNum_.text = "+" .. arg_11_2

		arg_10_0.trainAnimController_:SetSelectedState("true")

		if DormTools.CheckMax(arg_10_0.curHeroID_) then
			arg_10_0.heroUIList_:StartScroll(#arg_10_0.heroList_)
			arg_10_0:RefreshTitle()
		end
	end)
	arg_10_0:RegistEventListener(ON_FINISH_STORY, function()
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			arg_10_0:Back()

			if arg_10_0.backToDormInfo then
				arg_10_0.backToDormInfo = false

				JumpTools.OpenPageByJump("/dormChooseRoomView", {
					openInfoPanel = true
				})
			end
		end)
		arg_10_0.trainAnimController_:SetSelectedState("false")

		if arg_10_0.curHeroIndex_ and arg_10_0.heroUIList_ then
			arg_10_0.heroUIList_:ScrollToIndex(arg_10_0.curHeroIndex_)
		end
	end)
	arg_10_0:RegistEventListener(DORM_LOCK_HERO_FOR_FEATURE, function(arg_14_0)
		arg_10_0:SortHeroList()
		arg_10_0.heroUIList_:StartScroll(#arg_10_0.heroList_)
		arg_10_0:UpdateView(arg_10_0.curHeroID_)
		arg_10_0:RefreshTitle()
	end)
end

function var_0_0.OnEnter(arg_15_0)
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", true)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_15_0.backToDormInfo = arg_15_0.params_.backToDormInfo or false

	arg_15_0:RegisterEvents()
	arg_15_0.infoPage_:RegisterEvents()

	arg_15_0.heroList_ = IdolTraineeData:GetIdolHeroList(true)

	arg_15_0:SortHeroList()

	arg_15_0.curHeroIndex_ = table.keyof(arg_15_0.heroList_, arg_15_0.params_.heroID) or 1

	arg_15_0:UpdateView(arg_15_0.heroList_[arg_15_0.curHeroIndex_])
	arg_15_0.heroUIList_:StartScroll(#arg_15_0.heroList_)
	arg_15_0.heroUIList_:ScrollToIndex(arg_15_0.curHeroIndex_)
	arg_15_0:RefreshTitle()

	arg_15_0.skipShow_ = getData("IdolTrainee", "skip_show") or 0

	arg_15_0.SkipTheShowController_:SetSelectedState(arg_15_0.skipShow_ == 1 and "on" or "off")
	manager.windowBar:RegistBackCallBack(function()
		arg_15_0:Back()

		if arg_15_0.backToDormInfo then
			arg_15_0.backToDormInfo = false

			JumpTools.OpenPageByJump("/dormChooseRoomView", {
				openInfoPanel = true
			})
		end
	end)
end

function var_0_0.SortHeroList(arg_17_0)
	DormTools.SortAttackHeroList(arg_17_0.heroList_)
end

function var_0_0.OnExit(arg_18_0)
	manager.windowBar:HideBar()
	SetActive(arg_18_0.countInfoGo_, false)
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
	arg_18_0.infoPage_:RemoveAllEventListener()
	arg_18_0:RemoveAllEventListener()
end

function var_0_0.IndexItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:SetData(arg_19_0.heroList_[arg_19_1], arg_19_0.curHeroID_, function()
		if arg_19_0.curHeroID_ ~= 0 and arg_19_0.curHeroIndex_ ~= 0 then
			local var_20_0 = arg_19_0.heroUIList_:GetItemByIndex(arg_19_0.curHeroIndex_)

			if var_20_0 then
				var_20_0:SelectOff()
			end
		end

		arg_19_0.curHeroIndex_ = arg_19_1

		arg_19_2:SelectOn()
		arg_19_0:UpdateView(arg_19_0.heroList_[arg_19_1])
	end)
end

function var_0_0.RefreshTitle(arg_21_0)
	local var_21_0 = IdolTraineeTools:GetCurTrainMaxTimes()
	local var_21_1 = IdolTraineeData:GetCurTrainTimes()

	arg_21_0.trainCountText_.text = var_21_0 - var_21_1 .. "/" .. var_21_0

	local var_21_2 = IdolTraineeData:GetCurBuffCamp()
	local var_21_3 = {}

	for iter_21_0, iter_21_1 in pairs(var_21_2) do
		table.insert(var_21_3, iter_21_0)
	end

	if var_21_3[1] then
		SetActive(arg_21_0.race1Img_.gameObject, true)

		arg_21_0.race1Img_.sprite = HeroTools.GetRaceIcon(var_21_3[1])
	else
		SetActive(arg_21_0.race1Img_.gameObject, false)
	end

	if var_21_3[2] then
		SetActive(arg_21_0.race2Img_.gameObject, true)

		arg_21_0.race2Img_.sprite = HeroTools.GetRaceIcon(var_21_3[2])
	else
		SetActive(arg_21_0.race2Img_.gameObject, false)
	end

	local var_21_4 = DormRoomTools:GetUnlockRoomNum()
	local var_21_5
	local var_21_6
	local var_21_7 = GameSetting.dorm_idol_hero_exercise_times_limit.value

	for iter_21_2, iter_21_3 in ipairs(var_21_7) do
		if var_21_4 < iter_21_3[1] then
			var_21_5, var_21_6 = iter_21_3[1], iter_21_3[2]

			break
		end
	end

	if not var_21_5 then
		arg_21_0.countInfoText_.text = GetTips("IDOL_TRAIN_COUNT_MAX_NUM_INFO")
	else
		local var_21_8 = var_21_4
		local var_21_9 = var_21_5

		arg_21_0.countInfoText_.text = string.format(GetTips("IDOL_TRAIN_COUNT_NUM_INFO"), var_21_9, var_21_6, var_21_8)
	end
end

function var_0_0.UpdateView(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.curHeroID_ = arg_22_1

	if not arg_22_2 then
		IdolTraineeCampBridge.SetTrainingCharacter(arg_22_0.curHeroID_)
	end

	local var_22_0 = IdolTraineeTools:GetHeroBattleInfoTemplate(arg_22_0.curHeroID_)

	arg_22_0.infoPage_:RefreshUI(var_22_0)

	if HeroTools.GetHeroIsUnlock(arg_22_1) then
		arg_22_0.lockController_:SetSelectedState("off")

		local var_22_1 = IdolTraineeData:GetIdolHeroData(arg_22_0.curHeroID_)
		local var_22_2 = IdolTraineeTools:GetHeroIdolMaxProperty(arg_22_0.curHeroID_)
		local var_22_3 = DormData:GetHeroTemplateInfo(arg_22_1)
		local var_22_4 = var_22_3:GetFatigue()
		local var_22_5 = IdolTraineeData:GetCurTrainTimes()
		local var_22_6 = IdolTraineeTools:GetCurTrainMaxTimes()
		local var_22_7 = var_22_4 >= GameSetting.dorm_idol_hero_exercise_cost.value[1]
		local var_22_8 = IdolTraineeTools:CheckHeroRaceBuff(arg_22_0.curHeroID_)
		local var_22_9 = var_22_6 <= var_22_5

		for iter_22_0 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
			local var_22_10 = var_22_1[iter_22_0] >= var_22_2[iter_22_0]

			arg_22_0.trainBtnItemList_[iter_22_0]:SetData(arg_22_0.curHeroID_, iter_22_0, var_22_10, var_22_7, var_22_8, var_22_9)
		end

		arg_22_0.maxFText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
		arg_22_0.curFText_.text = var_22_3:GetFatigue()
		arg_22_0.recFText_.text = string.format(GetTips("DORM_FATIGUE_PER_HOUR"), var_22_3:GetRecoverFatigueNum())
	else
		arg_22_0.lockController_:SetSelectedState("on")
	end

	if DormTools.CheckMax(arg_22_0.curHeroID_) then
		arg_22_0.clearController_:SetSelectedState("state1")
	else
		arg_22_0.clearController_:SetSelectedState("state0")
	end

	arg_22_0:UpdataSelectBtnState(0)
end

function var_0_0.UpdataSelectBtnState(arg_23_0, arg_23_1)
	arg_23_0.infoPage_:SelectFlashBar(arg_23_1)

	arg_23_0.selIndex = arg_23_1

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.trainBtnItemList_) do
		iter_23_1:RefreshBtnState(arg_23_0.selIndex)
	end
end

function var_0_0.OnIdolPvpStageUpdateFromServer(arg_24_0)
	arg_24_0:UpdateView(arg_24_0.curHeroID_)
	arg_24_0:RefreshTitle()
end

function var_0_0.Dispose(arg_25_0)
	if arg_25_0.heroUIList_ then
		arg_25_0.heroUIList_:Dispose()

		arg_25_0.heroUIList_ = nil
	end

	if arg_25_0.infoPage_ then
		arg_25_0.infoPage_:Dispose()

		arg_25_0.infoPage_ = nil
	end

	for iter_25_0, iter_25_1 in pairs(arg_25_0.trainBtnItemList_) do
		iter_25_1:Dispose()
	end

	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
