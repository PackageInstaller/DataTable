local RegressionView = class("RegressionView", ReduxView)

function RegressionView:UIName()
	return "UI/ReturnUI/RegressionUI"
end

function RegressionView:UIParent()
	return manager.ui.uiMain.transform
end

function RegressionView:Init()
	self.pageClass = {
		RegressionSignPage,
		RegressionTaskPage,
		RegressionShopPage,
		RegressionNewPage
	}

	self:InitUI()
	self:AddUIListener()
end

function RegressionView:InitUI()
	self:BindCfgUI()

	self.tree = LuaTree.New(self.m_uitree)

	self.tree:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))

	self.pages = {}
	self.selectIndex = -1
end

function RegressionView:AddUIListener()
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_6_0)
		self:ShopRefresh()
	end)
	self:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_7_0)
		if self.curPage then
			self.curPage:SetData()
		end
	end)
	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_8_0, arg_8_1)
		self:ShopRefresh()
	end)
	self:AddBtnListener(self.m_questionBtn, nil, function()
		JumpTools.OpenPageByJump("survey", {
			type = OperationConst.SURVEY_TYPE.REGRESSION
		})
	end)
end

function RegressionView:OnTop()
	if self.selectIndex == 3 and self.curPage and self.curPage.UpdateBarByShopId then
		self.curPage:UpdateBarByShopId()

		return
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RegressionView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if self.params_.selectIndex then
		self.tree:SelectGroup(self.params_.selectIndex)

		self.params_.selectIndex = nil
		self.params_.Inited = true
	elseif not self.params_.Inited then
		self.params_.Inited = true

		self.tree:SelectGroup(1)
	elseif self.curPage and self.curPage.Refresh then
		self.curPage:Refresh()
	end

	local var_11_0 = OperationData:GetOperationOpenList()

	manager.redPoint:bindUIandKey(self.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:bindUIandKey(self.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:bindUIandKey(self.m_questionBtn.transform, RedPointConst.REGRESSION_SURVEY)
	self:RefreshTime()

	self.timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer:Start()
end

function RegressionView:OnExit()
	manager.windowBar:HideBar()

	self.selectIndex = -1

	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:unbindUIandKey(self.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:unbindUIandKey(self.m_questionBtn.transform, RedPointConst.REGRESSION_SURVEY)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function RegressionView:OnGroupSelect(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:SetSelectPage(arg_14_1, nil)
end

function RegressionView:OnItemSelect(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self.curPage:SetData(arg_15_2)
end

function RegressionView:SetSelectPage(arg_16_1, arg_16_2)
	if arg_16_1 == self.selectIndex then
		return
	end

	self.selectIndex = arg_16_1

	if self.curPage then
		self.curPage:SetActive(false)
	end

	self.pages[arg_16_1] = self.pages[arg_16_1] or self.pageClass[arg_16_1].New(self.m_content)
	self.curPage = self.pages[arg_16_1]

	self.curPage:SetData(arg_16_2)
	self.curPage:SetActive(true)

	if arg_16_1 ~= 3 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function RegressionView:RefreshTime()
	self.m_timerLab.text = manager.time:GetLostTimeStrWith2Unit(RegressionData:GetRegressionLoginTime() + 86400 * GameSetting.return_duration_time.value[1])

	if self.curPage and self.curPage.RefreshTime then
		self.curPage:RefreshTime()
	end
end

function RegressionView:Dispose()
	self.params_.Inited = nil

	if self.curPage then
		self.curPage:SetActive(false)

		self.curPage = nil
	end

	self.tree:Dispose()

	for iter_18_0, iter_18_1 in pairs(self.pages) do
		iter_18_1:Dispose()
	end

	self.pages = {}

	RegressionView.super.Dispose(self)
end

function RegressionView:OnTaskListChange()
	if self.curPage and self.curPage.OnTaskListChange then
		self.curPage:OnTaskListChange()
	end
end

function RegressionView:ShopRefresh()
	if self.curPage and self.curPage.RefreshList then
		self.curPage:RefreshList(true)
	end
end

function RegressionView:OnRegressionSign()
	if self.curPage and self.curPage.OnRegressionSign then
		self.curPage:OnRegressionSign(true)
	end
end

function RegressionView:OnShopBuyResult()
	self:ShopRefresh()
end

return RegressionView
