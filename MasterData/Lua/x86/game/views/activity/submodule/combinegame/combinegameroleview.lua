local CombineGameRoleView = class("CombineGameRoleView", ReduxView)

function CombineGameRoleView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfRoleUI"
end

function CombineGameRoleView:UIParent()
	return manager.ui.uiPop.transform
end

function CombineGameRoleView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGameRoleView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, CombineGameRoleItem)
	self.selectController = ControllerUtil.GetController(self.gameObject_.transform, "select")
	self.roleController = ControllerUtil.GetController(self.gameObject_.transform, "role")
	self.stageController = ControllerUtil.GetController(self.roleGo_.transform, "stage")
	self.lockController = ControllerUtil.GetController(self.gameObject_.transform, "lock")
end

function CombineGameRoleView:SetItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self:UpdateShowTable()[arg_5_1], self.lv, self.selectModel)
end

function CombineGameRoleView:AddUIListener()
	self:AddBtnListener(self.skillBtn_, nil, function()
		self.selectModel = 1

		self:UpdateView()
	end)
	self:AddBtnListener(self.inbornBtn_, nil, function()
		self.selectModel = 2

		self:UpdateView()
	end)
	self:AddBtnListener(self.role1Btn_, nil, function()
		self.roleId = ActivityCombineHeroCfg.all[1]
		self.selectModel = 1

		self.stageController:SetSelectedState(CombineGameData:CheckHeroLock(self.activityId, ActivityCombineHeroCfg.all[2]) and "stage1" or "stage3")
		self:UpdateView()
	end)
	self:AddBtnListener(self.role2Btn_, nil, function()
		self.roleId = ActivityCombineHeroCfg.all[2]
		self.selectModel = 1

		self.stageController:SetSelectedState(CombineGameData:CheckHeroLock(self.activityId, ActivityCombineHeroCfg.all[2]) and "stage2" or "stage4")
		self:UpdateView()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function CombineGameRoleView:OnEnter()
	self.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(self.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	self.lv = self.params_.lv
	self.roleId = self.params_.roleId
	self.selectModel = 1

	SetActive(self.selectGo_, true)
	self:UpdateView()
	self.stageController:SetSelectedState(CombineGameData:CheckHeroLock(self.activityId, ActivityCombineHeroCfg.all[2]) and "stage1" or "stage3")
end

function CombineGameRoleView:UpdateView()
	if self.roleId == nil then
		self.roleId = ActivityCombineHeroCfg.all[1]
	end

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	local var_13_0 = ActivityCombineHeroCfg[self.roleId]
	local var_13_1 = ActivityCombineHeroCfg[ActivityCombineHeroCfg.all[2]]

	self.activityId = CombineGameData:GetDataByPara("activityId")
	self.nowDay = CombineGameData:GetDataByPara("nowDay")

	self.selectController:SetSelectedState(self.selectModel == 1 and "skill" or "inborn")
	self.roleController:SetSelectedState(self.lv ~= 999 and "hide" or "show")

	self.nameTxt_.text = GetI18NText(var_13_0.name)
	self.descTxt_.text = GetI18NText(var_13_0.description)
	self.skillTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_HERO_SKILL")
	self.inbornTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_HERO_FACTOR")

	if self.lv == 999 then
		self.lvTxt_.text = #var_13_0.level_unlock or self.lv
	end

	self.role1Img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[ActivityCombineHeroCfg.all[1]].icon)
	self.role2Img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[ActivityCombineHeroCfg.all[2]].icon)

	TimeTools.StartAfterSeconds(0.01, function()
		self.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[self.roleId].image)
	end, {})
	SetActive(self.lvGo_, self.lv ~= 999)

	self.lockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime() + (var_13_1.unlock_condition[1][2] - self.nowDay + 2) * 86400))
	self.timer_ = Timer.New(function()
		self.lockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime() + (var_13_1.unlock_condition[1][2] - self.nowDay + 2) * 86400))
	end, 1, -1)

	self.timer_:Start()
	self.lockController:SetSelectedState((CombineGameData:CheckHeroLock(self.activityId, ActivityCombineHeroCfg.all[2]) or self.roleId == ActivityCombineHeroCfg.all[1] or self.lv ~= 999) and "false" or "true")
	self.list:StartScroll(#self:UpdateShowTable())
end

function CombineGameRoleView:UpdateShowTable()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(ActivityCombineHeroCfg[self.roleId].level_unlock) do
		if self.selectModel == 1 and ActivityCombineFactorCfg[iter_16_1].effect_type == 1 then
			table.insert(var_16_0, {
				id = iter_16_1,
				lv = iter_16_0
			})
		elseif self.selectModel == 2 and ActivityCombineFactorCfg[iter_16_1].effect_type ~= 1 then
			table.insert(var_16_0, {
				id = iter_16_1,
				lv = iter_16_0
			})
		end
	end

	return var_16_0
end

function CombineGameRoleView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.windowBar:HideBar()
end

function CombineGameRoleView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CombineGameRoleView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	CombineGameRoleView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameRoleView
