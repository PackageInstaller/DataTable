local NewServerSignPage = class("NewServerSignPage", ReduxView)

function NewServerSignPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/NewServer/NewServerSigninUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function NewServerSignPage:Init()
	self:InitUI()
end

function NewServerSignPage:InitUI()
	self:BindCfgUI()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, NewServerSignItem)
end

function NewServerSignPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function NewServerSignPage:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function NewServerSignPage:SetData(arg_6_1)
	self.activityID_ = arg_6_1
	self.index_ = NewServerData:GetSignIndex()

	if NewServerCfg[self.activityID_] then
		self.rewards_ = NewServerCfg[self.activityID_].sign_reward or {}
	end

	self.itemList_:StartScroll(#self.rewards_)
end

function NewServerSignPage:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, self.rewards_[arg_7_1])
	arg_7_2:RegistCallBack(handler(self, self.OnItemClick))
end

function NewServerSignPage:OnItemClick(arg_8_1)
	if not ActivityTools.ActivityOpenCheck(self.activityID_) then
		return
	end

	NewServerAction.QuerySign(arg_8_1)
end

function NewServerSignPage:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	NewServerSignPage.super.Dispose(self)
end

function NewServerSignPage:RefreshTime()
	if self.index_ ~= NewServerData:GetSignIndex() then
		for iter_10_0, iter_10_1 in ipairs((self.itemList_:GetItemList())) do
			iter_10_1:Refresh()
		end
	end
end

function NewServerSignPage:OnNewServerSign(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs((self.itemList_:GetItemList())) do
		if iter_11_1.index_ == arg_11_1 then
			iter_11_1:OnSign()
		end
	end
end

return NewServerSignPage
