local CombineGameDailyView = class("CombineGameDailyView", ReduxView)

function CombineGameDailyView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiakfDailyUI"
end

function CombineGameDailyView:UIParent()
	return manager.ui.uiMain.transform
end

function CombineGameDailyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGameDailyView:InitUI()
	self:BindCfgUI()

	self.getController = ControllerUtil.GetController(self.gameObject_.transform, "get")
	self.selectController = ControllerUtil.GetController(self.roleGo_.transform, "stage")
	self.list = LuaList.New(handler(self, self.SetRewardItem), self.listGo_, CommonItem)
end

function CombineGameDailyView:SetRewardItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshData({
		id = self.cfg.reward_list[arg_5_1][1],
		number = self.cfg.reward_list[arg_5_1][2]
	})
	arg_5_2:RegistCallBack(function(arg_6_0)
		ShowPopItem(POP_ITEM, {
			arg_6_0.id,
			arg_6_0.number
		})
	end)
end

function CombineGameDailyView:AddUIListener()
	self:AddBtnListener(self.factorBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameWatchFactorView", {
			id = self.id
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		manager.redPoint:setTip(string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(self.activityId), self.activityId), 0)
		CombineGameFactory:StartGame(self.id, nil, self.selectHero)
	end)
	self:AddBtnListener(self.roleBtn_, nil, function()
		JumpTools.GoToSystem("/CombineGameRoleView", {
			lv = 999
		})
	end)
	self:AddBtnListener(self.hero1Btn_, nil, function()
		self.selectHero = 1

		self.selectController:SetSelectedState(CombineGameData:CheckHeroLock(self.activityId, self.heroList[2]) and "stage1" or "stage3")
	end)
	self:AddBtnListener(self.hero2Btn_, nil, function()
		if CombineGameData:CheckHeroLock(self.activityId, self.heroList[2]) == false then
			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime() + (ActivityCombineHeroCfg[self.cfg.can_use_hero[2]].unlock_condition[1][2] - self.id + 2) * 86400)))

			return
		end

		self.selectHero = 2

		self.selectController:SetSelectedState("stage2")
	end)
end

function CombineGameDailyView:OnEnter()
	self.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(self.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	self.id = CombineGameData:GetDataByPara("nowDay")
	self.selectHero = getData("CombineGame", "daily" .. self.id) or 1

	self:UpdateView()
	self:BindRedPoint()
end

function CombineGameDailyView:UpdateView()
	self.cfg = ActivityCombineLevelCfg[self.id]
	self.activityId = CombineGameData:GetDataByPara("activityId")
	self.descTxt_.text = GetTips(self.cfg.description)
	self.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_2")
	self.dailyDescTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_CONTENT_2")
	self.startTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_BEGIN")
	self.factorTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	self.selectFactorList = self.cfg.default_entry
	self.heroList = self.cfg.can_use_hero

	local var_14_0 = CombineGameData:GetDataByPara("stageDataTable")[self.id]
	local var_14_1 = ActivityCombineHeroCfg[self.heroList[1]]
	local var_14_2 = ActivityCombineHeroCfg[self.heroList[2]]

	if self.selectHero == 2 then
		self.selectController:SetSelectedState("stage2")
	else
		self.selectController:SetSelectedState(CombineGameData:CheckHeroLock(self.activityId, self.heroList[2]) and "stage1" or "stage3")
	end

	self.getController:SetSelectedState(var_14_0 == true and "true" or "false")
	self.list:StartScroll(#self.cfg.reward_list)

	for iter_14_0 = 1, 3 do
		SetActive(self["upGo" .. iter_14_0 .. "_"], false)
		SetActive(self["downGo" .. iter_14_0 .. "_"], false)
	end

	for iter_14_1, iter_14_2 in ipairs(self.selectFactorList) do
		local var_14_3, var_14_4

		if ActivityCombineFactorCfg[iter_14_2].score < 0 then
			if 1 <= 3 then
				SetActive(self["upGo" .. 1 .. "_"], true)

				self["upImg" .. 1 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. ActivityCombineFactorCfg[iter_14_2].icon)
				var_14_3 = 1 + 1
			else
				var_14_4 = 0 + 1
			end
		elseif ActivityCombineFactorCfg[iter_14_2].score > 0 then
			local var_14_5

			if 1 <= 3 then
				SetActive(self["downGo" .. 1 .. "_"], true)

				self["downImg" .. 1 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. ActivityCombineFactorCfg[iter_14_2].icon)
				var_14_5 = 1 + 1
			else
				-- block empty
			end
		end
	end

	self.hero1Image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. var_14_1.icon)
	self.hero2Image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. var_14_2.icon)
end

function CombineGameDailyView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.startBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(self.activityId), self.activityId), {
		x = 150,
		y = 35
	})
end

function CombineGameDailyView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.startBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(self.activityId), self.activityId))
end

function CombineGameDailyView:OnCombineGameRefresh()
	self.id = CombineGameData:GetDataByPara("nowDay")

	self:UpdateView()
end

function CombineGameDailyView:OnExit()
	saveData("CombineGame", "daily" .. self.id, self.selectHero)
	self:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function CombineGameDailyView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CombineGameDailyView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	CombineGameDailyView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameDailyView
