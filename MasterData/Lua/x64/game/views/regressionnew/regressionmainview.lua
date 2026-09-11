local RegressionGiftPopView = class("RegressionGiftPopView", ReduxView)

function RegressionGiftPopView:UIName()
	return "Widget/System/ReturnThree/RT3rd_MainViewUI"
end

function RegressionGiftPopView:UIParent()
	return manager.ui.uiMain.transform
end

function RegressionGiftPopView:Init()
	self.pageClass = {
		{
			RegressionSignView,
			RegressionTaskView,
			RegressionTaskView,
			RegressionTaskView,
			RegressionTaskView
		},
		{
			RegressionDrawView,
			RegressionDiscountView,
			RegressionResRetrieveView,
			RegressionShopGiftView
		}
	}
	self.selectPageID = -1

	self:InitUI()
	self:AddUIListener()
end

function RegressionGiftPopView:InitUI()
	self:BindCfgUI()

	self.tree = LuaTree.New(self.m_uitree)

	self.tree:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))

	self.pages = {}
	self.selectPageIndex = -1
	self.isHideDrawToggle = false
	self.onSubmitTaskHandle_ = handler(self, self.OnTaskSubmitResponse)
end

function RegressionGiftPopView:OnGroupSelect(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:SetSelectPage(arg_5_1, nil)
end

function RegressionGiftPopView:OnItemSelect(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if self.selectPageID == arg_6_2 then
		return
	end

	self.selectPageID = arg_6_2

	if self.curPage then
		self.curPage:SetActive(false)
	end

	self.pages[self.pageClass[self.selectPageIndex][arg_6_1]] = self.pages[self.pageClass[self.selectPageIndex][arg_6_1]] or self.pageClass[self.selectPageIndex][arg_6_1].New(self.m_content)
	self.curPage = self.pages[self.pageClass[self.selectPageIndex][arg_6_1]]

	self.curPage:SetData(arg_6_2)
	self:OnTop()
	self.curPage:SetActive(true)
end

function RegressionGiftPopView:SetSelectPage(arg_7_1, arg_7_2)
	if arg_7_1 == self.selectPageIndex then
		return
	end

	self.selectPageID = -1
	self.selectPageIndex = arg_7_1
end

function RegressionGiftPopView:OnRegressionSign()
	if self.curPage and self.curPage.OnRegressionSign then
		self.curPage:OnRegressionSign(true)
	end
end

function RegressionGiftPopView:OnShopBuyResult(arg_9_1, arg_9_2, arg_9_3)
	if self.curPage and self.curPage.OnRegressionShopUpdate then
		RegressionActionNew.CheckShopRedPoint()
		self.curPage:OnRegressionShopUpdate()
	end
end

function RegressionGiftPopView:OnRegressionFindRes()
	if self.curPage and self.curPage.OnRegressionFindRes then
		self.curPage:OnRegressionFindRes()
	end
end

function RegressionGiftPopView:OnTaskListChange()
	if self.curPage and self.curPage.OnTaskListChange then
		self.curPage:OnTaskListChange()
	end
end

function RegressionGiftPopView:OnTaskSubmitResponse()
	if self.curPage and self.curPage.OnTaskSubmitResponse then
		self.curPage:OnTaskSubmitResponse()
	end
end

function RegressionGiftPopView:RefreshTime()
	local var_13_0 = RegressionDataNew:GetRegressionEndTime()

	if var_13_0 - manager.time:GetServerTime() <= 0 then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	self.countDownTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_13_0))

	if self.curPage and self.curPage.RefreshTime then
		self.curPage:RefreshTime(var_13_0)
	end
end

function RegressionGiftPopView:AddUIListener()
	return
end

function RegressionGiftPopView:OnTop()
	if self.curPage and self.curPage.UpdateBar then
		self.curPage:UpdateBar()
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function RegressionGiftPopView:UpdateDrawToggleShow()
	if self.isHideDrawToggle then
		return
	end

	local var_16_0 = self.tree:GetItemGameObjectById(2, 1)

	if var_16_0 and not RegressionDataNew:CheckIsOpenRuturnPool() then
		var_16_0.transform:SetAsLastSibling()

		self.isHideDrawToggle = true
	end
end

function RegressionGiftPopView:OnEnter()
	self:OnTaskListChange()
	self:EnterSelecet()
	self:UpdateDrawToggleShow()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:RefreshTime()

	self.timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer:Start()
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskHandle_)
	self:BindRedKey()
end

function RegressionGiftPopView:BindRedKey()
	manager.redPoint:bindUIandKey(self.tree:GetGroupRedPointContainerById(1), RedPointConst.NEW_REGRESSION_TASK)
	manager.redPoint:bindUIandKey(self.tree:GetGroupRedPointContainerById(2), RedPointConst.NEW_REGRESSION_PRIVILEGE)
	manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(1, 1), RedPointConst.NEW_REGRESSION_SIGN)
	manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(1, 211), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT))
	manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(1, 207), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_DRAW))
	manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(1, 209), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_TILI))

	if self.isHideDrawToggle then
		manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 1), RedPointConst.NEW_REGRESSION_GIFT_NET_TAG)
		manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 2), RedPointConst.NEW_REGRESSION_RES_FIND)
		manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 3), RedPointConst.NEW_REGRESSION_SHOP)
		manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 4), RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
	else
		manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 1), RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
		manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 2), RedPointConst.NEW_REGRESSION_GIFT_NET_TAG)
		manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 3), RedPointConst.NEW_REGRESSION_RES_FIND)
		manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 4), RedPointConst.NEW_REGRESSION_SHOP)
	end
end

function RegressionGiftPopView:UnBindRedKey()
	manager.redPoint:unbindUIandKey(self.tree:GetGroupRedPointContainerById(1), RedPointConst.NEW_REGRESSION_TASK)
	manager.redPoint:unbindUIandKey(self.tree:GetGroupRedPointContainerById(2), RedPointConst.NEW_REGRESSION_PRIVILEGE)
	manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(1, 1), RedPointConst.NEW_REGRESSION_SIGN)
	manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(1, 211), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT))
	manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(1, 207), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_DRAW))
	manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(1, 209), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_TILI))

	if self.isHideDrawToggle then
		manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 1), RedPointConst.NEW_REGRESSION_GIFT_NET_TAG)
		manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 2), RedPointConst.NEW_REGRESSION_RES_FIND)
		manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 3), RedPointConst.NEW_REGRESSION_SHOP)
		manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 4), RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
	else
		manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 1), RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
		manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 2), RedPointConst.NEW_REGRESSION_GIFT_NET_TAG)
		manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 3), RedPointConst.NEW_REGRESSION_RES_FIND)
		manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 4), RedPointConst.NEW_REGRESSION_SHOP)
	end
end

function RegressionGiftPopView:EnterSelecet()
	if self.params_.selectPageIndex then
		self.tree:SelectGroup(self.params_.selectPageIndex)

		self.params_.selectPageIndex = nil
		self.params_.Inited = true
	elseif not self.params_.Inited then
		self.params_.Inited = true

		self.tree:SelectGroup(1)
	elseif self.curPage then
		if self.curPage.Refresh then
			self.curPage:Refresh()
		end
	elseif self.params_.disposePageIndex and self.params_.disposePageID then
		self.tree:SelectItem(self.params_.disposePageIndex, self.params_.disposePageID)
	end
end

function RegressionGiftPopView:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskHandle_)
	manager.windowBar:HideBar()

	self.selectPageIndex = -1

	self:RemoveAllEventListener()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.curPage and self.curPage.GetSelectParams then
		self.params_.disposePageIndex, self.params_.disposePageID = self.curPage:GetSelectParams()
	end

	for iter_22_0, iter_22_1 in pairs(self.pages) do
		if iter_22_1 and iter_22_1.OnExit then
			iter_22_1:OnExit()
		end
	end

	self:UnBindRedKey()
end

function RegressionGiftPopView:Dispose()
	for iter_23_0, iter_23_1 in pairs(self.pages) do
		if iter_23_1 then
			iter_23_1:Dispose()
		end
	end

	self.params_.Inited = false

	self.tree:Dispose()
	RegressionGiftPopView.super.Dispose(self)
end

return RegressionGiftPopView
