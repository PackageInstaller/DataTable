local ActivityNewbieView = class("ActivityNewbieView", ReduxView)

function ActivityNewbieView:UIName()
	return "Widget/System/Activitynewbie/ActivityNewbieUI"
end

function ActivityNewbieView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityNewbieView:Init()
	self.pageClass_ = {
		ActivityNewbieSignView,
		ActivityNewbieTaskView,
		ActivityNewbieUpgradeView,
		ActivityNewbieDailyView,
		ActivityNoobFirstRechargeView,
		NoobMonthlyCardRechargeView,
		ActivityNoobBpRechargeView
	}

	self:InitUI()
end

function ActivityNewbieView:InitUI()
	self:BindCfgUI()

	self.tree_ = LuaTree.New(self.uiTreeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))

	self.pages_ = {}
	self.selectIndex_ = -1
	self.selectItemIndex_ = -1
	self.rechargeGroupGoList_ = {}
	self.rechargeGroupGoList_[1] = self.tree_:GetGroupGameObjectById(5)
	self.rechargeGroupGoList_[2] = self.tree_:GetGroupGameObjectById(6)
	self.rechargeGroupGoList_[3] = self.tree_:GetGroupGameObjectById(7)
end

function ActivityNewbieView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshRecharge()

	if self.params_.selectIndex then
		self.tree_:SelectGroup(self.params_.selectIndex)

		self.params_.selectIndex = nil
		self.params_.Inited = true
	elseif self.params_.isBack == true then
		self.selectIndex_ = -1
		self.selectItemIndex_ = -1

		if self.params_.lastItemIndex > 0 then
			self.tree_:SelectItem(self.params_.lastIndex, self.params_.lastItemIndex)
		else
			self.tree_:SelectGroup(self.params_.lastIndex)
		end
	elseif not self.params_.Inited then
		self.params_.Inited = true
		self.selectIndex_ = -1
		self.selectItemIndex_ = -1

		self.tree_:SelectGroup(1)
	end

	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(1), RedPointConst.NEWBIE_SIGN)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(2), RedPointConst.NEWBIE_TASK)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(3), RedPointConst.NEWBIE_UPGRADE)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(4), RedPointConst.NEWBIE_DAILY_TASK)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(5), RedPointConst.NOOB_FIRST_RECHARGE)
	manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(5, 1), RedPointConst.NOOB_FIRST_RECHARGE_1)
	manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(5, 2), RedPointConst.NOOB_FIRST_RECHARGE_2)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_MONTHLY_RECHARGE)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_BP_RECHARGE)
end

function ActivityNewbieView:OnExit()
	manager.windowBar:HideBar()

	if self.curPage_ then
		self.curPage_:SetActive(false)
	end

	self.params_.lastIndex = self.selectIndex_
	self.params_.lastItemIndex = self.selectItemIndex_

	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(1), RedPointConst.NEWBIE_SIGN)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(2), RedPointConst.NEWBIE_TASK)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(3), RedPointConst.NEWBIE_UPGRADE)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(4), RedPointConst.NEWBIE_DAILY_TASK)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(5), RedPointConst.NOOB_FIRST_RECHARGE)
	manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(5, 1), RedPointConst.NOOB_FIRST_RECHARGE_1)
	manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(5, 2), RedPointConst.NOOB_FIRST_RECHARGE_2)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_MONTHLY_RECHARGE)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_BP_RECHARGE)
end

function ActivityNewbieView:OnGroupSelect(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_1 == self.selectIndex_ then
		return
	end

	self:SetSelectPage(arg_7_1)
end

function ActivityNewbieView:OnItemSelect(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if self.selectItemIndex_ == arg_8_1 then
		return
	end

	self.selectItemIndex_ = arg_8_1

	self.curPage_:SetData(arg_8_1)
end

function ActivityNewbieView:SetSelectPage(arg_9_1)
	self.selectIndex_ = arg_9_1
	self.selectItemIndex_ = -1

	if self.curPage_ then
		self.curPage_:SetActive(false)
	end

	self.pages_[arg_9_1] = self.pages_[arg_9_1] or self.pageClass_[arg_9_1].New(self.contentTrans_, 2)
	self.curPage_ = self.pages_[arg_9_1]

	self.curPage_:SetActive(true)

	if self.params_.isBack == true and self.curPage_.SetIsBack then
		self.curPage_:SetIsBack(self.params_.isBack)

		self.params_.isBack = false
	end

	self.curPage_:SetData()
end

function ActivityNewbieView:Dispose()
	self.params_.Inited = nil

	if self.curPage_ then
		self.curPage_:SetActive(false)

		self.curPage_ = nil
	end

	self.tree_:Dispose()

	for iter_10_0, iter_10_1 in pairs(self.pages_) do
		iter_10_1:Dispose()
	end

	self.pages_ = nil
	self.rechargeGroupGoList_ = nil

	ActivityNewbieView.super.Dispose(self)
end

function ActivityNewbieView:RefreshRecharge()
	for iter_11_0 = 1, 3 do
		SetActive(self.rechargeGroupGoList_[iter_11_0], ActivityNewbieTools.GetRechargeIsOpen(iter_11_0))
	end

	local var_11_0 = ActivityNewbieTools.GetFirstRechargeStatus()

	if var_11_0 and var_11_0.firstGearStatus == 2 then
		self.tree_:GetData().groupDatas[4].defaultIndex = 1
	end
end

return ActivityNewbieView
