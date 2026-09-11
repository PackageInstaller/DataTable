local CanteenEntrustAwardItem = class("CanteenEntrustAwardItem", ReduxView)

function CanteenEntrustAwardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CanteenEntrustAwardItem:Init()
	self:InitUI()
end

function CanteenEntrustAwardItem:InitUI()
	self:BindCfgUI()

	self.awardItemListScroll_ = LuaList.New(handler(self, self.indexAwardItem), self.awarduilistUilist_, DormDispatchAwardItem)
	self.extraController = ControllerUtil.GetController(self.transform_, "extra")
end

function CanteenEntrustAwardItem:RefreshUI(arg_4_1)
	self.id = arg_4_1.id
	self.titletextText_.text = GetI18NText(BackHomeCanteenTaskCfg[arg_4_1.id].name) .. GetTips("CANTEEN_TASK_FINISH")
	self.itemList = {}

	if arg_4_1.extra_reward == 1 then
		self.extraController:SetSelectedState("true")

		self.rewardText_.text = GetTips("DORM_CANTEEN_BIG_WIN")
	else
		self.extraController:SetSelectedState("false")

		self.rewardText_.text = GetTips("DORM_CANTEEN_WIN")
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.award) do
		table.insert(self.itemList, iter_4_1)
	end

	self.awardItemListScroll_:StartScroll(#self.itemList)
end

function CanteenEntrustAwardItem:indexAwardItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.itemList[arg_5_1])
end

function CanteenEntrustAwardItem:RegistCallBack(arg_6_1)
	self.changeListFun = arg_6_1
end

function CanteenEntrustAwardItem:Dispose()
	self:RemoveAllListeners()

	if self.awardItemListScroll_ then
		self.awardItemListScroll_:Dispose()
	end

	CanteenEntrustAwardItem.super.Dispose(self)
end

return CanteenEntrustAwardItem
