local ActivityNoobSignView = class("ActivityNoobSignView", ReduxView)

function ActivityNoobSignView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetUIName(arg_1_2)), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.RefreshReward), self.scrollView_, ActivityNoobSignItem)
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
end

function ActivityNoobSignView:GetUIName(arg_2_1)
	if arg_2_1 == 1 then
		return "Widget/System/Activitynewbie/NewbieSignUI1_new"
	else
		return "Widget/System/Activitynewbie/NewbieSignUI2_new"
	end
end

function ActivityNoobSignView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil

	ActivityNoobSignView.super.Dispose(self)
end

function ActivityNoobSignView:AddListeners()
	return
end

function ActivityNoobSignView:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function ActivityNoobSignView:SetData(arg_6_1)
	self.pageIndex_ = arg_6_1

	if self.lockController_ ~= nil then
		self.lockController_:SetSelectedIndex(math.floor(ActivityNoobData:GetSignDay() / 7) + 1 < self.pageIndex_ and 1 or 0)
	end

	local var_6_0 = ActivityNewbieTools.GetSignCfg()

	self.rewardList_ = {}

	for iter_6_0 = (arg_6_1 - 1) * 7 + 1, (arg_6_1 - 1) * 7 + 1 + 7 - 1 do
		self.rewardList_[#self.rewardList_ + 1] = var_6_0[iter_6_0]
	end

	self.uiList_:StartScroll(#self.rewardList_)
end

function ActivityNoobSignView:RefreshReward(arg_7_1, arg_7_2)
	arg_7_2:RefreshUI(self.rewardList_[arg_7_1], self.pageIndex_, arg_7_1)
end

return ActivityNoobSignView
