local var_0_0 = class("HellaMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/HellaUI/HellaMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
	arg_3_0:InitSubmoduleButton()
end

function var_0_0.InitSubmoduleButton(arg_4_0)
	arg_4_0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(arg_4_0.butterflyGo_, ActivityConst.HELLA_STORY_STAGE),
		ActivitySubmoduleItem.New(arg_4_0.passGo_, ActivityConst.HELLA_BOSS_CHALLENGE),
		ActivitySubmoduleItem.New(arg_4_0.talentGo_, ActivityConst.HELLA_TALENT_TREE),
		ActivitySubmoduleItem.New(arg_4_0.tombGo_, ActivityConst.HELLA_CHESS),
		ActivitySkinTrialSubmoduleItem.New(arg_4_0.skinTrialGo_, ActivityConst.HELLA_SKIN_TRIAL_STAGE),
		ActivitySubmoduleItem.New(arg_4_0.disasterGo_, ActivityConst.HELLA_SLAYER),
		ActivitySubmoduleItem.New(arg_4_0.missGo_, ActivityConst.HELLA_PARKOUR),
		ActivitySubmoduleItem.New(arg_4_0.campGo_, ActivityConst.HELLA_TOWER_DEFENCE),
		ActivityHeroTrialItem.New(arg_4_0.tryGo_, ActivityConst.HELLA_HERO_TRIAL_STAGE)
	}
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = ActivityTools.GetReprintActivityID(ActivityConst.HELLA_ACTIVITY)
	local var_5_1 = ActivityData:GetActivityData(var_5_0)
	local var_5_2 = var_5_1.startTime
	local var_5_3 = var_5_1.stopTime

	arg_5_0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_5_2, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_5_3, "!%Y.%m.%d %H:%M"))
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_6_0:RefreshUI()

	local var_6_0 = getData("activity_movie", "hella_" .. arg_6_0.params_.activityID) ~= nil

	SetActive(arg_6_0.movie1Go_, not var_6_0)
	SetActive(arg_6_0.movie2Go_, var_6_0)

	if var_6_0 then
		arg_6_0.mainDirector_.time = 4
	else
		arg_6_0.mainDirector_.time = 0
	end

	arg_6_0.mainDirector_:Play()
	saveData("activity_movie", "hella_" .. arg_6_0.params_.activityID, 1)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.submoduleBtnList_) do
		iter_6_1:OnEnter()
	end
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()

	for iter_7_0, iter_7_1 in pairs(arg_7_0.submoduleBtnList_) do
		iter_7_1:OnExit()
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.submoduleBtnList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.submoduleBtnList_ = nil
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.shopBtn_, nil, function()
		local var_10_0 = ActivityTools.GetReprintActivityID(ActivityConst.HELLA_ACTIVITY)
		local var_10_1 = ActivityShopCfg[var_10_0].shop_id

		JumpTools.GoToSystem("/shop", {
			shopId = var_10_1,
			showShops = {
				var_10_1
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_9_0:AddBtnListener(arg_9_0.btn_warchessBtn_, nil, function()
		JumpTools.GoToSystem("/warChessStage", {
			firstChapter = 4040301,
			chapterClientID = 404
		}, ViewConst.SYSTEM_ID.WARCHESS)
	end)
end

return var_0_0
