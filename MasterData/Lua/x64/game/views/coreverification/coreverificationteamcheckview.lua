local CoreVerificationTeamCheckView = class("CoreVerificationTeamCheckView", ReduxView)

function CoreVerificationTeamCheckView:UIName()
	return "Widget/System/Core_Verification/CoreVerificationTeamCheckUI"
end

function CoreVerificationTeamCheckView:UIParent()
	return manager.ui.uiPop.transform
end

function CoreVerificationTeamCheckView:Init()
	self:BindCfgUI()

	self.tabList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, CoreVerificationTeamInfoItem)

	self:AddUIListener()
end

function CoreVerificationTeamCheckView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function CoreVerificationTeamCheckView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.list[arg_7_1], arg_7_1)
end

function CoreVerificationTeamCheckView:OnEnter()
	self.list = self.params_.dataList or {}

	self.tabList_:StartScroll(#self.list)

	self.layerLabel_.text = GetTips("CORE_VERIFICATION_TAB_DES_2")
end

function CoreVerificationTeamCheckView:OnExit()
	return
end

function CoreVerificationTeamCheckView:Dispose()
	CoreVerificationTeamCheckView.super.Dispose(self)

	if self.tabList_ then
		self.tabList_:Dispose()

		self.tabList_ = nil
	end
end

return CoreVerificationTeamCheckView
