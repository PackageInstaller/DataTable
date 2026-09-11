local ActivityNoobView = class("ActivityNoobView", ReduxView)

function ActivityNoobView:UIName()
	return "Widget/System/Activitynewbie/ActivityNewbieUI_new"
end

function ActivityNoobView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityNoobView:Init()
	self.pageClass_ = {
		ActivityNoobSignView,
		ActivityNoobTaskView,
		ActivityNoobUpgradeView,
		ActivityNoobDailyView,
		ActivityNoobFirstRechargeView,
		NoobMonthlyCardRechargeView,
		ActivityNoobBpRechargeView
	}

	self:InitUI()
	self:AddUIListener()
end

function ActivityNoobView:InitUI()
	self:BindCfgUI()

	self.tree_ = LuaTree.New(self.uiTreeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))

	self.pages_ = {}
	self.selectIndex_ = -1
	self.selectItemIndex_ = -1
	self.signCompleteGoList_ = {}

	for iter_4_0 = 1, 2 do
		self.signCompleteGoList_[iter_4_0] = self.tree_:GetItemGameObjectById(1, iter_4_0).transform:Find("get").gameObject
	end

	self.rechargeGroupGoList_ = {}
	self.rechargeGroupGoList_[1] = self.tree_:GetGroupGameObjectById(5)
	self.rechargeGroupGoList_[2] = self.tree_:GetGroupGameObjectById(6)
	self.rechargeGroupGoList_[3] = self.tree_:GetGroupGameObjectById(7)
end

function ActivityNoobView:AddUIListener()
	return
end

function ActivityNoobView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityNoobView:OnEnter(arg_7_1)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshSignGroup()
	self:RefreshRecharge()

	if self.params_.selectIndex then
		self.tree_:SelectGroup(self.params_.selectIndex)

		self.params_.selectIndex = nil
		self.params_.Inited = true
	elseif arg_7_1.isBack == true then
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

		self.tree_:SelectGroup(self.defaultGroupIndex_)
	end

	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(1), RedPointConst.NEWBIE_SIGN)
	manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(1, 1), RedPointConst.NEWBIE_SIGN .. "_1")
	manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(1, 2), RedPointConst.NEWBIE_SIGN .. "_2")
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(2), RedPointConst.NEWBIE_TASK)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(3), RedPointConst.NEWBIE_UPGRADE)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(4), RedPointConst.NEWBIE_DAILY_TASK)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(5), RedPointConst.NOOB_FIRST_RECHARGE)
	manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(5, 1), RedPointConst.NOOB_FIRST_RECHARGE_1)
	manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(5, 2), RedPointConst.NOOB_FIRST_RECHARGE_2)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_MONTHLY_RECHARGE)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_BP_RECHARGE)
end

function ActivityNoobView:OnExit()
	manager.windowBar:HideBar()

	if self.curPage_ then
		self.curPage_:SetActive(false)
	end

	self.params_.lastIndex = self.selectIndex_
	self.params_.lastItemIndex = self.selectItemIndex_

	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(1), RedPointConst.NEWBIE_SIGN)
	manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(1, 1), RedPointConst.NEWBIE_SIGN .. "_1")
	manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(1, 2), RedPointConst.NEWBIE_SIGN .. "_2")
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(2), RedPointConst.NEWBIE_TASK)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(3), RedPointConst.NEWBIE_UPGRADE)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(4), RedPointConst.NEWBIE_DAILY_TASK)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(5), RedPointConst.NOOB_FIRST_RECHARGE)
	manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(5, 1), RedPointConst.NOOB_FIRST_RECHARGE_1)
	manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(5, 2), RedPointConst.NOOB_FIRST_RECHARGE_2)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_MONTHLY_RECHARGE)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_BP_RECHARGE)
end

function ActivityNoobView:OnGroupSelect(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_1 == self.selectIndex_ then
		return
	end

	self:SetSelectPage(arg_9_1)
end

function ActivityNoobView:OnItemSelect(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if self.selectItemIndex_ == arg_10_1 then
		return
	end

	self.selectItemIndex_ = arg_10_1

	self.curPage_:SetData(arg_10_1)
end

function ActivityNoobView:SetSelectPage(arg_11_1)
	self.selectIndex_ = arg_11_1
	self.selectItemIndex_ = -1

	if self.curPage_ then
		self.curPage_:SetActive(false)
	end

	self.pages_[arg_11_1] = self.pages_[arg_11_1] or self.pageClass_[arg_11_1].New(self.contentTrans_, 0)
	self.curPage_ = self.pages_[arg_11_1]

	self.curPage_:SetActive(true)

	if self.params_.isBack == true and self.curPage_.SetIsBack then
		self.curPage_:SetIsBack(self.params_.isBack)

		self.params_.isBack = false
	end

	self.curPage_:SetData()
end

function ActivityNoobView:Dispose()
	self.params_.Inited = nil

	if self.curPage_ then
		self.curPage_:SetActive(false)

		self.curPage_ = nil
	end

	self.tree_:Dispose()

	for iter_12_0, iter_12_1 in pairs(self.pages_) do
		iter_12_1:Dispose()
	end

	self.pages_ = nil
	self.rechargeGroupGoList_ = nil

	ActivityNoobView.super.Dispose(self)
end

function ActivityNoobView:OnNoobSign()
	self:RefreshSignGroup()
end

function ActivityNoobView:RefreshSignGroup()
	local var_14_0 = ActivityNoobData:GetSignDay()
	local var_14_1 = math.floor(var_14_0 / 7)

	var_14_1 = var_14_1 <= 1 and var_14_1 or 1
	self.tree_:GetData().groupDatas[0].defaultIndex = var_14_1

	for iter_14_0 = 1, #self.signCompleteGoList_ do
		SetActive(self.signCompleteGoList_[iter_14_0], var_14_0 >= iter_14_0 * 7)
	end

	self.defaultGroupIndex_ = var_14_0 >= 14 and 2 or 1
end

function ActivityNoobView:RefreshRecharge()
	for iter_15_0 = 1, 3 do
		SetActive(self.rechargeGroupGoList_[iter_15_0], ActivityNewbieTools.GetRechargeIsOpen(iter_15_0))
	end

	local var_15_0 = ActivityNoobData:GetFirstRechargeStatus()

	if var_15_0 and var_15_0.firstGearStatus == 2 then
		self.tree_:GetData().groupDatas[4].defaultIndex = 1
	end
end

return ActivityNoobView
