local FriendRequestPage = class("FriendRequestPage", import("...base.BaseSubView"))

function FriendRequestPage:getUIName()
	return "FriendRequestUI"
end

function FriendRequestPage:OnLoaded()
	self.requestPanel = self._tf:Find("request_panel")
	self.requestTopTF = self._tf:Find("request_view_top")
	self.refuseAllBtn = self.requestTopTF:Find("refuse_all_btn")
	self.informPanel = self._tf:Find("inform_panel")
	self.toggleTpl = self.informPanel:Find("frame/window/main/Toggle")
	self.buttonTpl = self.informPanel:Find("frame/window/main/button")
	self.toggleContainer = self.informPanel:Find("frame/window/main/toggles")
	self.confirmBtn = self.informPanel:Find("frame/window/buttons/confirm_btn")
	self.cancelBtn = self.informPanel:Find("frame/window/buttons/cancel_btn")
	self.backBtn = self.informPanel:Find("frame/window/top/btnBack")
	self.nameTF = self.informPanel:Find("frame/window/name"):GetComponent(typeof(Text))

	setActive(self.informPanel, false)

	return
end

function FriendRequestPage:OnInit()
	self.refuseMsgBox = FriendRefusePage.New(self._tf, self.event)

	onButton(self, self.refuseAllBtn, function()
		self:emit(FriendMediator.REFUSE_ALL_REQUEST)

		return
	end, SFX_PANEL)
	self:InitInform()

	return
end

function FriendRequestPage:UpdateData(arg_5_1)
	self.requestVOs = arg_5_1.requestVOs or {}

	if not self.isInit then
		self.isInit = true

		self:isInitRequestPage()
	else
		self:sortRequest()
	end

	return
end

function FriendRequestPage:isInitRequestPage()
	self.requestItems = {}
	self.requestRect = self.requestPanel:Find("mask/view"):GetComponent("LScrollRect")

	function self.requestRect.onInitItem(arg_7_0)
		self:onInitItem(arg_7_0)

		return
	end

	function self.requestRect.onUpdateItem(arg_8_0, arg_8_1)
		self:onUpdateItem(arg_8_0, arg_8_1)

		return
	end

	self:sortRequest()

	return
end

function FriendRequestPage:sortRequest()
	self.requestRect:SetTotalCount(#self.requestVOs, -1)

	return
end

function FriendRequestPage:onInitItem(arg_10_1)
	local var_10_0 = FriendRequestCard.New(arg_10_1)

	onButton(self, var_10_0.acceptBtn, function()
		if var_10_0.friendVO then
			self:emit(FriendMediator.ACCEPT_REQUEST, var_10_0.friendVO.id)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_10_0.refuseBtn, function()
		if var_10_0.friendVO then
			self.refuseMsgBox:ExecuteAction("Show", i18n("refuse_friend"), i18n("refuse_and_add_into_bl"), function(arg_13_0)
				self:emit(FriendMediator.REFUSE_REQUEST, var_10_0.friendVO, arg_13_0)

				return
			end)
		end

		return
	end)
	onButton(self, var_10_0.resumeBtn, function()
		self:emit(FriendMediator.OPEN_RESUME, var_10_0.friendVO.id)

		return
	end, SFX_PANEL)

	self.requestItems[arg_10_1] = var_10_0

	return
end

function FriendRequestPage:onUpdateItem(arg_15_1, arg_15_2)
	local var_15_0 = self.requestItems[arg_15_2]

	if not self.requestItems[arg_15_2] then
		self:onInitItem(arg_15_2)

		var_15_0 = self.requestItems[arg_15_2]
	end

	local var_15_1 = self.requestVOs[arg_15_1 + 1]

	var_15_0:update(self.requestVOs[arg_15_1 + 1].player, self.requestVOs[arg_15_1 + 1].timestamp, self.requestVOs[arg_15_1 + 1].content)
	onButton(self, var_15_0.reportBtn, function()
		if var_15_0.friendVO then
			self:openInfromPanel(var_15_0.friendVO, var_15_1.content)
		end

		return
	end)

	return
end

function FriendRequestPage:openInfromPanel(arg_17_1, arg_17_2)
	setActive(self.informPanel, true)
	self:UpdateInform(arg_17_1, arg_17_2)

	return
end

function FriendRequestPage:closeInfromPanel()
	setActive(self.informPanel, false)

	return
end

function FriendRequestPage:InitInform()
	for iter_19_0, iter_19_1 in ipairs((require("ShareCfg.informCfg"))) do
		local var_19_0 = cloneTplTo(self.toggleTpl, self.toggleContainer)

		var_19_0:Find("Label"):GetComponent("Text").text = iter_19_1.content

		onToggle(self, var_19_0, function(arg_20_0)
			if arg_20_0 then
				self.informInfo = iter_19_1.content
			end

			return
		end)
	end

	onButton(self, self.cancelBtn, function()
		self:closeInfromPanel()

		return
	end)
	onButton(self, self.backBtn, function()
		self:closeInfromPanel()

		return
	end)

	return
end

function FriendRequestPage:UpdateInform(arg_23_1, arg_23_2)
	self.nameTF.text = i18n("inform_player", arg_23_1.name)

	onButton(self, self.confirmBtn, function()
		if not self.informInfo then
			pg.TipsMgr.GetInstance():ShowTips(i18n("inform_select_type"))

			return
		end

		self:emit(FriendMediator.INFORM, arg_23_1.id, self.informInfo, arg_23_2)

		return
	end)

	return
end

function FriendRequestPage:OnDestroy()
	for iter_25_0, iter_25_1 in pairs(self.requestItems or {}) do
		iter_25_1:dispose()
	end

	self.refuseMsgBox:Destroy()

	return
end

return FriendRequestPage
