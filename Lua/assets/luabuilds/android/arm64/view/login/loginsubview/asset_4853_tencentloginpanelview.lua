local TencentLoginPanelView = class("TencentLoginPanelView", import("...base.BaseSubView"))

function TencentLoginPanelView:getUIName()
	return "TencentLoginPanelView"
end

function TencentLoginPanelView:OnLoaded()
	return
end

function TencentLoginPanelView:SetShareData(arg_3_1)
	self.shareData = arg_3_1

	return
end

function TencentLoginPanelView:OnInit()
	self.tencentPanel = self._tf
	self.wxLoginBtn = self.tencentPanel:Find("wx_login")
	self.qqLoginBtn = self.tencentPanel:Find("qq_login")

	self:InitEvent()

	return
end

function TencentLoginPanelView:InitEvent()
	onButton(self, self.qqLoginBtn, function()
		pg.SdkMgr.GetInstance():LoginSdk(1)

		return
	end)
	onButton(self, self.wxLoginBtn, function()
		pg.SdkMgr.GetInstance():LoginSdk(2)

		return
	end)

	return
end

function TencentLoginPanelView:OnDestroy()
	return
end

return TencentLoginPanelView
