local SimBusinessClientInfoView = class("SimBusinessClientInfoView", ReduxView)

function SimBusinessClientInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SimBusinessClientInfoView:Init()
	self:InitUI()

	self.heroScroll = LuaList.New(handler(self, self.indexItem), self.uilistGo_, SimBusinessGuestInfoItem)
	self.clientInfoPage = SimBusinessClientPage.New(self.clientGo)
end

function SimBusinessClientInfoView:InitUI()
	self:BindCfgUI()
end

function SimBusinessClientInfoView:OnEnter()
	self.clientList = SimBusinessGuestCfg.all
	self.selectID = self.selectID or self.clientList[1]

	self.heroScroll:StartScroll(#self.clientList)
	self.clientInfoPage:RefreshView(self.selectID)
end

function SimBusinessClientInfoView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshData({
		id = self.clientList[arg_5_1]
	}, arg_5_1, self.selectID == self.clientList[arg_5_1], false)
	arg_5_2:RegisterClickFunc(handler(self, self.clickClient))
end

function SimBusinessClientInfoView:OnTop()
	return
end

function SimBusinessClientInfoView:OnExit()
	return
end

function SimBusinessClientInfoView:clickClient(arg_8_1)
	self.selectID = arg_8_1.guestID

	self.heroScroll:Refresh()
	self.clientInfoPage:RefreshView(self.selectID)
end

function SimBusinessClientInfoView:OnEventRefreshView()
	return
end

function SimBusinessClientInfoView:Dispose()
	self.heroScroll:Dispose()
	self.clientInfoPage:Dispose()
	SimBusinessClientInfoView.super.Dispose(self)
end

function SimBusinessClientInfoView:RegisterEvents()
	return
end

return SimBusinessClientInfoView
