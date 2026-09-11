local CombineGameSelectFactorView = class("CombineGameSelectFactorView", ReduxView)

function CombineGameSelectFactorView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfGlossaryyUI"
end

function CombineGameSelectFactorView:UIParent()
	return manager.ui.uiPop.transform
end

function CombineGameSelectFactorView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGameSelectFactorView:InitUI()
	self:BindCfgUI()

	self.list1 = LuaList.New(handler(self, self.SetItem1), self.list1Go_, CombineGameFactorItem)
	self.list2 = LuaList.New(handler(self, self.SetItem2), self.list2Go_, CombineGameFactorItem)
end

function CombineGameSelectFactorView:SetItem1(arg_5_1, arg_5_2)
	self:SetItem(arg_5_1, arg_5_2, self.upList[arg_5_1])
end

function CombineGameSelectFactorView:SetItem2(arg_6_1, arg_6_2)
	self:SetItem(arg_6_1, arg_6_2, self.downList[arg_6_1])
end

function CombineGameSelectFactorView:SetItem(arg_7_1, arg_7_2, arg_7_3)
	arg_7_2:SetData(arg_7_1, arg_7_3, handler(self, self.ClickCallBack), self.selectFactorList[arg_7_3] or false)
end

function CombineGameSelectFactorView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		manager.notify:CallUpdateFunc(COMBINE_GAME_SELECT_FACTOR_SURE, self.selectFactorList)
		self:Back()
	end)
end

function CombineGameSelectFactorView:OnEnter()
	self.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(self.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	self.id = self.params_.id
	self.selectFactorList = clone(self.params_.selectFactorList or {})

	self:UpdateView()
end

function CombineGameSelectFactorView:ClickCallBack(arg_12_1, arg_12_2, arg_12_3)
	if self.selectFactorList[arg_12_2] then
		self.selectFactorList[arg_12_2] = nil
	else
		self.selectFactorList[arg_12_2] = true
	end

	arg_12_3:SetSelectedState(self.selectFactorList[arg_12_2] and "true" or "false")
	self:UpdateScore()
end

function CombineGameSelectFactorView:UpdateView()
	self.upList = {}
	self.downList = {}

	for iter_13_0, iter_13_1 in ipairs(ActivityCombineLevelCfg[self.id].select_entry) do
		if ActivityCombineFactorCfg[iter_13_1].score < 0 then
			table.insert(self.upList, iter_13_1)
		elseif ActivityCombineFactorCfg[iter_13_1].score > 0 then
			table.insert(self.downList, iter_13_1)
		end
	end

	self.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	self.upTitleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_FRONT")
	self.downTitleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_NEGATIVE")
	self.hardScoreTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DIFFICULTY_RATING_NOW")

	self.list1:StartScroll(#self.upList)
	self.list2:StartScroll(#self.downList)
	self:UpdateScore()
end

function CombineGameSelectFactorView:UpdateScore()
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = 0

	for iter_14_0, iter_14_1 in pairs(self.selectFactorList) do
		local var_14_3 = ActivityCombineFactorCfg[iter_14_0]

		if ActivityCombineFactorCfg[iter_14_0].score < 0 then
			var_14_1 = var_14_1 + 1
		elseif var_14_3.score > 0 then
			var_14_2 = var_14_2 + 1
		end

		var_14_0 = var_14_0 + var_14_3.score
	end

	self.upTxt_.text = var_14_1 .. "/" .. #self.upList
	self.downTxt_.text = var_14_2 .. "/" .. #self.downList
	self.scoreTxt_.text = var_14_0
end

function CombineGameSelectFactorView:OnExit()
	self.selectFactorList = {}

	manager.windowBar:HideBar()
end

function CombineGameSelectFactorView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CombineGameSelectFactorView:Dispose()
	if self.list1 then
		self.list1:Dispose()

		self.list1 = nil
	end

	if self.list2 then
		self.list2:Dispose()

		self.list2 = nil
	end

	CombineGameSelectFactorView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameSelectFactorView
