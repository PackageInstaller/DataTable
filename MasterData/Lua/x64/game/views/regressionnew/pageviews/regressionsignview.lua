local RegressionSignView = class("RegressionSignView", ReduxView)

function RegressionSignView:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnThree/RT3rd_SignUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionSignView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionSignView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, RegressionSignItem)
	self.descText_.text = GetTips("NEW_REGRESSION_SIGN_DESC")
end

function RegressionSignView:AddUIListener()
	return
end

function RegressionSignView:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function RegressionSignView:SetData()
	self.index = RegressionDataNew:GetSignIndex()

	local var_6_0 = RegressionDataNew:GetRegressionSystemID()

	if ReturnCfg[var_6_0] then
		self.rewards = ReturnCfg[var_6_0].sign_id or {}
	end

	self.list:StartScroll(#self.rewards)

	if not getData("Regression", "First" .. RedPointConst.NEW_REGRESSION_SIGN .. RegressionDataNew:GetRegressionEndTime()) then
		saveData("Regression", "First" .. RedPointConst.NEW_REGRESSION_SIGN .. RegressionDataNew:GetRegressionEndTime(), true)
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_SIGN_FIRST, 0)
	end
end

function RegressionSignView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, self.rewards[arg_7_1])
	arg_7_2:RegistCallBack(handler(self, self.OnItemClick))
end

function RegressionSignView:OnItemClick(arg_8_1)
	RegressionActionNew.QuerySign(arg_8_1)
end

function RegressionSignView:RefreshTime(arg_9_1)
	if self.index ~= RegressionData:GetSignIndex() then
		for iter_9_0, iter_9_1 in ipairs((self.list:GetItemList())) do
			iter_9_1:Refresh()
		end
	end

	self.countDownTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(arg_9_1))
end

function RegressionSignView:OnRegressionSign()
	for iter_10_0, iter_10_1 in ipairs((self.list:GetItemList())) do
		iter_10_1:Refresh()
	end
end

function RegressionSignView:SetActive(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function RegressionSignView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	RegressionSignView.super.Dispose(self)
end

return RegressionSignView
