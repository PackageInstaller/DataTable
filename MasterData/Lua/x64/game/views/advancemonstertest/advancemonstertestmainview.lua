local AdvanceMonsterTestMainView = class("AdvanceMonsterTestMainView", ReduxView)
local var_0_1 = {
	LOOKBACK = 0,
	CURRENT = 1
}

function AdvanceMonsterTestMainView:UIName()
	return "Widget/System/BossTestUI/BossTestMainUI"
end

function AdvanceMonsterTestMainView:UIParent()
	return manager.ui.uiMain.transform
end

function AdvanceMonsterTestMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdvanceMonsterTestMainView:InitUI()
	self:BindCfgUI()

	self.stageList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, AdvanceMonsterTestMainViewItem)
	self.lookBackStageList_ = LuaList.New(handler(self, self.IndexItem), self.lookbacklistGo_, AdvanceMonsterTestMainViewItem)
	self.btnController_ = self.btnControllerEx_:GetController("btnStatus")
	self.curType_ = 1
	self.lastType_ = nil
	self.lastScrollPos_ = nil
	self.lastLookBackScrollPos_ = nil
end

function AdvanceMonsterTestMainView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.stageIDList_[arg_5_1])
end

function AdvanceMonsterTestMainView:AddUIListener()
	self:AddBtnListener(self.curBtn_, nil, function()
		if self.curType_ == 1 then
			return
		else
			self.curType_ = 1

			self:RefreshUI()
		end
	end)
	self:AddBtnListener(self.beforeBtn_, nil, function()
		if self.curType_ == 0 then
			return
		else
			self.curType_ = 0

			self:RefreshUI()
		end
	end)
end

function AdvanceMonsterTestMainView:OnEnter()
	local var_9_0 = AdvanceMonsterTestData:GetCurStageID()

	if var_9_0 > 0 then
		self.curType_ = ActivityAdvanceMonsterTestCfg[var_9_0].type
	end

	AdvanceMonsterTestData:SetCurStageID(-1)
	self:RefreshUI()

	if self.curType_ == self.lastType_ then
		if self.curType_ == var_0_1.CURRENT then
			self.stageList_:SetScrolledPosition(self.lastScrollPos_)
		else
			self.lookBackStageList_:SetScrolledPosition(self.lastLookBackScrollPos_)
		end
	else
		self.lastType_ = nil
		self.lastScrollPos_ = nil
		self.lastLookBackScrollPos_ = nil
	end

	if getData("monsterTest", "monsterTest") ~= "1" and #self.page > 0 then
		saveData("monsterTest", "monsterTest", "1")
		TimeTools.StartAfterSeconds(0.1, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = self.page
			})
		end, {})
	end
end

function AdvanceMonsterTestMainView:GetSortStageIDList()
	table.sort(ActivityAdvanceMonsterTestCfg.get_id_list_by_type[self.curType_], function(arg_12_0, arg_12_1)
		if ActivityAdvanceMonsterTestCfg[arg_12_0].order ~= ActivityAdvanceMonsterTestCfg[arg_12_1].order then
			return ActivityAdvanceMonsterTestCfg[arg_12_0].order < ActivityAdvanceMonsterTestCfg[arg_12_1].order
		end

		return arg_12_0 < arg_12_1
	end)

	return ActivityAdvanceMonsterTestCfg.get_id_list_by_type[self.curType_]
end

function AdvanceMonsterTestMainView:RefreshUI()
	if self.curType_ == var_0_1.CURRENT then
		self.btnController_:SetSelectedState("cur")
	elseif self.curType_ == var_0_1.LOOKBACK then
		self.btnController_:SetSelectedState("history")
	end

	self.stageIDList_ = self:GetSortStageIDList()

	if self.curType_ == var_0_1.CURRENT then
		if self.stageIDList_ then
			self.stageList_:StartScroll(#self.stageIDList_)
		else
			self.stageList_:StartScroll(0)
		end
	elseif self.stageIDList_ then
		self.lookBackStageList_:StartScroll(#self.stageIDList_)
	else
		self.lookBackStageList_:StartScroll(0)
	end

	self.page = {}

	for iter_13_0, iter_13_1 in ipairs(self.stageIDList_) do
		if ActivityAdvanceMonsterTestCfg[iter_13_1].level_describe ~= "" then
			table.insert(self.page, ActivityAdvanceMonsterTestCfg[iter_13_1].level_describe[1])
		end
	end

	self:OnTop()
end

function AdvanceMonsterTestMainView:OnTop()
	if #self.page > 0 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = self.page
		})
	end)
end

function AdvanceMonsterTestMainView:OnExit()
	manager.windowBar:HideBar()

	self.lastType_ = self.curType_
	self.lastScrollPos_ = self.stageList_:GetScrolledPosition()
	self.lastLookBackScrollPos_ = self.lookBackStageList_:GetScrolledPosition()
end

function AdvanceMonsterTestMainView:Dispose()
	AdvanceMonsterTestMainView.super.Dispose(self)

	if self.stageList_ then
		self.stageList_:Dispose()

		self.stageList_ = nil
	end

	if self.lookBackStageList_ then
		self.lookBackStageList_:Dispose()

		self.lookBackStageList_ = nil
	end
end

return AdvanceMonsterTestMainView
