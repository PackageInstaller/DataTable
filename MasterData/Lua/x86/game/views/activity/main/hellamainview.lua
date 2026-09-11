local HellaMainView = class("HellaMainView", ReduxView)

function HellaMainView:UIName()
	return "UI/VersionUI/HellaUI/HellaMainUI"
end

function HellaMainView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaMainView:Init()
	self:BindCfgUI()
	self:AddListeners()
	self:InitSubmoduleButton()
end

function HellaMainView:InitSubmoduleButton()
	self.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(self.butterflyGo_, ActivityConst.HELLA_STORY_STAGE),
		ActivitySubmoduleItem.New(self.passGo_, ActivityConst.HELLA_BOSS_CHALLENGE),
		ActivitySubmoduleItem.New(self.talentGo_, ActivityConst.HELLA_TALENT_TREE),
		ActivitySubmoduleItem.New(self.tombGo_, ActivityConst.HELLA_CHESS),
		ActivitySkinTrialSubmoduleItem.New(self.skinTrialGo_, ActivityConst.HELLA_SKIN_TRIAL_STAGE),
		ActivitySubmoduleItem.New(self.disasterGo_, ActivityConst.HELLA_SLAYER),
		ActivitySubmoduleItem.New(self.missGo_, ActivityConst.HELLA_PARKOUR),
		ActivitySubmoduleItem.New(self.campGo_, ActivityConst.HELLA_TOWER_DEFENCE),
		ActivityHeroTrialItem.New(self.tryGo_, ActivityConst.HELLA_HERO_TRIAL_STAGE)
	}
end

function HellaMainView:RefreshUI()
	local var_5_0 = ActivityData:GetActivityData((ActivityTools.GetReprintActivityID(ActivityConst.HELLA_ACTIVITY)))

	self.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_5_0.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_5_0.stopTime, "!%Y.%m.%d %H:%M"))
end

function HellaMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()

	local var_6_0 = getData("activity_movie", "hella_" .. self.params_.activityID) ~= nil

	SetActive(self.movie1Go_, not var_6_0)
	SetActive(self.movie2Go_, var_6_0)

	self.mainDirector_.time = var_6_0 and 4 or 0

	self.mainDirector_:Play()
	saveData("activity_movie", "hella_" .. self.params_.activityID, 1)

	for iter_6_0, iter_6_1 in pairs(self.submoduleBtnList_) do
		iter_6_1:OnEnter()
	end
end

function HellaMainView:OnExit()
	manager.windowBar:HideBar()

	for iter_7_0, iter_7_1 in pairs(self.submoduleBtnList_) do
		iter_7_1:OnExit()
	end
end

function HellaMainView:Dispose()
	HellaMainView.super.Dispose(self)

	for iter_8_0, iter_8_1 in pairs(self.submoduleBtnList_) do
		iter_8_1:Dispose()
	end

	self.submoduleBtnList_ = nil
end

function HellaMainView:AddListeners()
	self:AddBtnListener(self.shopBtn_, nil, function()
		local var_10_0 = ActivityShopCfg[ActivityTools.GetReprintActivityID(ActivityConst.HELLA_ACTIVITY)].shop_id

		JumpTools.GoToSystem("/shop", {
			shopId = var_10_0,
			showShops = {
				var_10_0
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.btn_warchessBtn_, nil, function()
		JumpTools.GoToSystem("/warChessStage", {
			firstChapter = 4040301,
			chapterClientID = 404
		}, ViewConst.SYSTEM_ID.WARCHESS)
	end)
end

return HellaMainView
