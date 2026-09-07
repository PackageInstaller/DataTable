local BaseTotalRewardPanel = class("BaseTotalRewardPanel", import("view.base.BaseUI"))

function BaseTotalRewardPanel:getUIName()
	return "BaseTotalRewardPanel"
end

function BaseTotalRewardPanel:init()
	self.window = self._tf:Find("Window")
	self.boxView = self.window:Find("Layout/Box/ScrollView")
	self.emptyTip = self.window:Find("Layout/Box/EmptyTip")

	setText(self.emptyTip, i18n("autofight_rewards_none"))
	setText(self.window:Find("Fixed/top/bg/obtain/title"), self.contextData.title)
	setText(self.window:Find("Fixed/top/bg/obtain/title/title_en"), self.contextData.subTitle)
	setText(self.window:Find("Fixed/ButtonGO/pic"), i18n("autofight_onceagain"))
	setText(self.window:Find("Fixed/ButtonExit/pic"), i18n("autofight_leave"))

	return
end

function BaseTotalRewardPanel:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:UpdateView()

	return
end

function BaseTotalRewardPanel:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function BaseTotalRewardPanel:UpdateView()
	local var_5_0 = self.contextData

	onButton(self, self._tf:Find("BG"), function()
		existCall(var_5_0.onClose)
		self:closeView()

		return
	end)

	return
end

function BaseTotalRewardPanel:HandleShowMsgBox(arg_7_1)
	pg.MsgboxMgr.GetInstance():ShowMsgBox(arg_7_1)

	return
end

return BaseTotalRewardPanel
