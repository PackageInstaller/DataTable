local RegressionNewView = class("RegressionNewView", (import("game.views.regression.RegressionView")))

function RegressionNewView:UIName()
	return "Widget/System/ReturnTwo/RT2stBackflowNavigationUI"
end

function RegressionNewView:Init()
	self:InitUI()
	self:AddUIListener()

	self.pageClass = {
		RegressionSignNewPage,
		RegressionTaskNewPage,
		RegressionCapsuleToysPage,
		RegressionSupplyPage,
		RegressionBPTaskPage,
		RegressionNewPage_2_0
	}
	self.needEnterAnim_ = {
		[2] = true,
		[5] = true
	}
	self.needExitAnim_ = {
		true,
		nil,
		true,
		true,
		nil,
		true
	}
	self.playAnimTypeConst_ = {
		EXIT = 2,
		ENTER = 1
	}
	self.animConst_ = {
		[1] = "Fx_adron_cx",
		[2] = "Fx_adron_xs"
	}
	self.animation_ = self.animPanelGo_:GetComponent("Animation")
	self.lastPlayType_ = -1
end

function RegressionNewView:AddUIListener()
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_4_0)
		self:ShopRefresh()
	end)
	self:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_5_0)
		if self.curPage then
			self.curPage:SetData()
		end
	end)
	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_6_0, arg_6_1)
		self:ShopRefresh()
	end)
end

function RegressionNewView:OnTop()
	self.curPage:UpdateBar()
end

function RegressionNewView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if self.params_.selectIndex then
		self.tree:SelectGroup(self.params_.selectIndex)

		self.params_.selectIndex = nil
		self.params_.Inited = true
	elseif self.params_.isBack == true then
		self.selectIndex = -1
		self.selectItemIndex = -1

		if self.params_.lastItemIndex > 0 then
			self.tree:SelectItem(self.params_.lastIndex, self.params_.lastItemIndex)
		else
			self.tree:SelectGroup(self.params_.lastIndex)
		end
	elseif not self.params_.Inited then
		self.params_.Inited = true
		self.selectIndex = -1
		self.selectItemIndex = -1

		self.tree:SelectGroup(1)
	end

	manager.redPoint:bindUIandKey(self.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:bindUIandKey(self.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:bindUIandKey(self.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:bindUIandKey(self.tree:GetGroupRedPointContainerById(4), RedPointConst.REGRESSION_SUPPLY_FREE)
	manager.redPoint:bindUIandKey(self.tree:GetGroupRedPointContainerById(5), RedPointConst.REGRESSION_BP)
	self:RefreshTime()

	self.timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer:Start()
end

function RegressionNewView:OnExit()
	manager.windowBar:HideBar()

	self.params_.lastIndex = self.selectIndex
	self.params_.lastItemIndex = self.selectItemIndex

	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:unbindUIandKey(self.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:unbindUIandKey(self.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:unbindUIandKey(self.tree:GetGroupRedPointContainerById(4), RedPointConst.REGRESSION_SUPPLY_FREE)
	manager.redPoint:unbindUIandKey(self.tree:GetGroupRedPointContainerById(5), RedPointConst.REGRESSION_BP)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.curPage and self.curPage.OnExit then
		self.curPage:OnExit()
		self.curPage:SetActive(false)
	end

	self.lastPlayType_ = -1
end

function RegressionNewView:OnGroupSelect(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_1 == self.selectIndex then
		return
	end

	self:SetSelectPage(arg_11_1, nil)
end

function RegressionNewView:OnItemSelect(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self.selectItemIndex = arg_12_1

	self.curPage:SetData(arg_12_2)
end

function RegressionNewView:SetSelectPage(arg_13_1, arg_13_2)
	self.selectIndex = arg_13_1
	self.selectItemIndex = -1

	if self.curPage then
		self.curPage:SetActive(false)
	end

	self.pages[arg_13_1] = self.pages[arg_13_1] or self.pageClass[arg_13_1].New(self.m_content)
	self.curPage = self.pages[arg_13_1]

	if self.params_.isBack == true then
		if self.curPage.SetIsBack then
			self.curPage:SetIsBack(self.params_.isBack)
		end

		self.params_.isBack = false
	end

	self.curPage:SetData(arg_13_2)
	self.curPage:SetActive(true)
	self.curPage:UpdateBar()
	self:PlayAnim(self.params_.isBack)
end

function RegressionNewView:PlayAnim(arg_14_1)
	local var_14_0 = false
	local var_14_1 = -1

	if self.params_.isEnter == true then
		if self.needExitAnim_[self.selectIndex] == true then
			var_14_0 = false
			var_14_1 = self.playAnimTypeConst_.EXIT
		elseif self.needEnterAnim_[self.selectIndex] == true then
			var_14_0 = true
			var_14_1 = self.playAnimTypeConst_.ENTER
			self.params_.isEnter = false
		end
	elseif self.needEnterAnim_[self.selectIndex] == true and self.lastPlayType_ ~= self.playAnimTypeConst_.ENTER then
		var_14_1 = self.playAnimTypeConst_.ENTER
		var_14_0 = true
	elseif self.needExitAnim_[self.selectIndex] == true and self.lastPlayType_ ~= self.playAnimTypeConst_.EXIT then
		var_14_1 = self.playAnimTypeConst_.EXIT

		if not arg_14_1 then
			var_14_0 = true
		end
	end

	SetActive(self.animPanelGo_, var_14_0)

	if var_14_0 == true and var_14_1 ~= -1 then
		self.lastPlayType_ = var_14_1

		self.animation_:Play(self.animConst_[var_14_1])
	end
end

return RegressionNewView
