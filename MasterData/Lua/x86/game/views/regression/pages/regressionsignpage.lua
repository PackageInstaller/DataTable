local RegressionSignPage = class("RegressionSignPage", ReduxView)

function RegressionSignPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("UI/ReturnUI/RegressionSignUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionSignPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionSignPage:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, RegressionSignItem)
end

function RegressionSignPage:AddUIListener()
	return
end

function RegressionSignPage:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function RegressionSignPage:SetData(arg_6_1)
	self.index = RegressionData:GetSignIndex()

	local var_6_0 = RegressionData:GetRegressionVersion()

	if RegressionCfg[var_6_0] then
		self.rewards = RegressionCfg[var_6_0].sign_reward or {}
	end

	self.list:StartScroll(#self.rewards)
end

function RegressionSignPage:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, self.rewards[arg_7_1])
	arg_7_2:RegistCallBack(handler(self, self.OnItemClick))
end

function RegressionSignPage:OnItemClick(arg_8_1)
	RegressionAction.QuerySign(arg_8_1)
end

function RegressionSignPage:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	RegressionSignPage.super.Dispose(self)
end

function RegressionSignPage:RefreshTime()
	if self.indx ~= RegressionData:GetSignIndex() then
		for iter_10_0, iter_10_1 in ipairs((self.list:GetItemList())) do
			iter_10_1:Refresh()
		end
	end
end

function RegressionSignPage:OnRegressionSign()
	for iter_11_0, iter_11_1 in ipairs((self.list:GetItemList())) do
		iter_11_1:Refresh()
	end
end

return RegressionSignPage
