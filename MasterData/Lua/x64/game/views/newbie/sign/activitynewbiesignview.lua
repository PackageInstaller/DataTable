local ActivityNewbieSignView = class("ActivityNewbieSignView", ReduxView)

function ActivityNewbieSignView:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Activitynewbie/NewbieSignUI"), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.RefreshReward), self.scrollView_, ActivityNewbieSignItem)

	self.uiList_:StartScroll(#ActivityNewbieTools.GetSignCfg(), 1)
end

function ActivityNewbieSignView:SetData()
	local var_2_0 = ActivityNewbieData:GetSignDay()
	local var_2_1 = 0

	if var_2_0 - 2 > 0 then
		var_2_1 = var_2_0 - 2
	end

	if manager.time:GetTodayFreshTime() > ActivityNewbieData:GetSignTimestamp() then
		var_2_1 = var_2_1 + 1
	end

	self.uiList_:StartScroll(#ActivityNewbieTools.GetSignCfg(), var_2_1)
end

function ActivityNewbieSignView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil

	ActivityNewbieSignView.super.Dispose(self)
end

function ActivityNewbieSignView:AddListeners()
	return
end

function ActivityNewbieSignView:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function ActivityNewbieSignView:RefreshReward(arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(ActivityNewbieTools.GetSignCfg()[arg_6_1])
end

return ActivityNewbieSignView
