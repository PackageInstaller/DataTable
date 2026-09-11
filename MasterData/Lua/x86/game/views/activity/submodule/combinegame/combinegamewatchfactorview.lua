local CombineGameWatchFactorView = class("CombineGameWatchFactorView", ReduxView)

function CombineGameWatchFactorView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfGlossaryUI"
end

function CombineGameWatchFactorView:UIParent()
	return manager.ui.uiPop.transform
end

function CombineGameWatchFactorView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGameWatchFactorView:InitUI()
	self:BindCfgUI()

	self.list1 = LuaList.New(handler(self, self.SetItem1), self.list1Go_, CombineGameFactorItem)
	self.list2 = LuaList.New(handler(self, self.SetItem2), self.list2Go_, CombineGameFactorItem)
end

function CombineGameWatchFactorView:SetItem1(arg_5_1, arg_5_2)
	self:SetItem(arg_5_1, arg_5_2, self.upList[arg_5_1])
end

function CombineGameWatchFactorView:SetItem2(arg_6_1, arg_6_2)
	self:SetItem(arg_6_1, arg_6_2, self.downList[arg_6_1])
end

function CombineGameWatchFactorView:SetItem(arg_7_1, arg_7_2, arg_7_3)
	arg_7_2:SetData(arg_7_1, arg_7_3)
end

function CombineGameWatchFactorView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function CombineGameWatchFactorView:OnEnter()
	self.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(self.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	self.id = self.params_.id
	self.factorList = self.params_.factorList

	self:UpdateView()
end

function CombineGameWatchFactorView:UpdateView()
	self.upList = {}
	self.downList = {}

	self[self.factorList == nil and "UpdateLevelView" or "UpdateFactorView"](self)

	self.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	self.upTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_FRONT")
	self.downTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_NEGATIVE")

	self.list1:StartScroll(#self.upList)
	self.list2:StartScroll(#self.downList)
end

function CombineGameWatchFactorView:UpdateLevelView()
	for iter_12_0, iter_12_1 in ipairs(ActivityCombineLevelCfg[self.id][CombineGameConst.TypeConst.ENDLESS == ActivityCombineLevelCfg[self.id].type and "select_entry" or "default_entry"]) do
		if ActivityCombineFactorCfg[iter_12_1].score < 0 then
			table.insert(self.upList, iter_12_1)
		elseif ActivityCombineFactorCfg[iter_12_1].score > 0 then
			table.insert(self.downList, iter_12_1)
		end
	end
end

function CombineGameWatchFactorView:UpdateFactorView()
	for iter_13_0, iter_13_1 in pairs(self.factorList) do
		if ActivityCombineFactorCfg[iter_13_0].score < 0 then
			table.insert(self.upList, iter_13_0)
		elseif ActivityCombineFactorCfg[iter_13_0].score > 0 then
			table.insert(self.downList, iter_13_0)
		end
	end
end

function CombineGameWatchFactorView:OnExit()
	self.params_.id = nil
	self.params_.factorList = nil

	manager.windowBar:HideBar()
end

function CombineGameWatchFactorView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CombineGameWatchFactorView:Dispose()
	if self.list1 then
		self.list1:Dispose()

		self.list1 = nil
	end

	if self.list2 then
		self.list2:Dispose()

		self.list2 = nil
	end

	CombineGameWatchFactorView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameWatchFactorView
