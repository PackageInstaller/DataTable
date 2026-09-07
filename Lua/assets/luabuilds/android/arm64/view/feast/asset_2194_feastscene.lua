local FeastScene = class("FeastScene", import("view.base.BaseUI"))

FeastScene.PAGE_INVITATION = 1
FeastScene.ON_TASK_UPDATE = "FeastScene:ON_TASK_UPDATE"
FeastScene.ON_ACT_UPDATE = "FeastScene:ON_ACT_UPDATE"
FeastScene.ON_SKIP_GIVE_GIFT = "FeastScene:ON_SKIP_GIVE_GIFT"
FeastScene.ON_BACK_FEAST = "FeastScene:ON_BACK_FEAST"
FeastScene.ON_MAKE_TICKET = "FeastScene:ON_MAKE_TICKET"
FeastScene.ON_GOT_TICKET = "FeastScene:ON_GOT_TICKET"
FeastScene.ON_GOT_GIFT = "FeastScene:ON_GOT_GIFT"
FeastScene.GO_INTERACTION = "FeastScene:GO_INTERACTION"
FeastScene.GO_INVITATION = "FeastScene:GO_INVITATION"

function FeastScene:getUIName()
	return "FeastUI"
end

function FeastScene:forceGC()
	return true
end

function FeastScene:PlayBGM()
	pg.CriMgr.GetInstance():StopBGM()

	return
end

function FeastScene:init()
	self.mainCG = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.backBtn = self._tf:Find("main/return")
	self.invitationBtn = self._tf:Find("btns/invitation")
	self.invitationBtnTip = self.invitationBtn:Find("tip")
	self.taskBtn = self._tf:Find("btns/task")
	self.taskBtnTip = self.taskBtn:Find("tip")
	self.invitationPage = FeastInvitationPage.New(self._tf, self.event)
	self.taskPage = FeastTaskPage.New(self._tf, self.event)
	self.helpBtn = self._tf:Find("main/help")
	self.homeBtn = self._tf:Find("main/home")
	self.buffUIlist = UIItemList.New(self._tf:Find("main/buffs"), self._tf:Find("main/buffs/tpl"))

	setText(self.invitationBtn:Find("Text"), i18n("feast_invitation_btn_label"))
	setText(self.taskBtn:Find("Text"), i18n("feast_task_btn_label"))

	return
end

function FeastScene:didEnter()
	self:BlockEvents()
	self:SetUpCourtYard()

	return
end

function FeastScene:OnCourtYardLoaded()
	self:UnBlockEvents()
	onButton(self, self.backBtn, function()
		self:emit(FeastScene.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self.invitationBtn, function()
		self.invitationPage:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(self, self.taskBtn, function()
		self.taskPage:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.feast_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.homeBtn, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	self:bind(FeastScene.ON_TASK_UPDATE, function()
		self:UpdateTips()

		return
	end)
	self:bind(FeastScene.ON_ACT_UPDATE, function()
		self:UpdateTips()

		return
	end)
	self:bind(FeastScene.ON_GOT_GIFT, function()
		self:UpdateTips()

		return
	end)
	self:bind(FeastScene.ON_GOT_TICKET, function()
		self:UpdateTips()

		return
	end)
	self:bind(FeastScene.GO_INTERACTION, function()
		if self.taskPage and self.taskPage:GetLoaded() and self.taskPage:isShowing() then
			self.taskPage:Hide()
		end

		return
	end)
	self:bind(FeastScene.GO_INVITATION, function()
		if self.taskPage and self.taskPage:GetLoaded() and self.taskPage:isShowing() then
			self.taskPage:Hide()
		end

		self.invitationPage:ExecuteAction("Show")

		return
	end)
	self:bind(FeastScene.ON_ACT_UPDATE, function()
		self:UpdateBuffs()

		return
	end)
	self:bind(FeastScene.ON_BACK_FEAST, function()
		if self.invitationPage and self.invitationPage:GetLoaded() and self.invitationPage:isShowing() then
			self.invitationPage:Hide()
		end

		return
	end)
	self:PlayEnterStory()
	self:UpdateTips()
	self:UpdateBuffs()

	if self.contextData.page and self.contextData.page == FeastScene.PAGE_INVITATION then
		triggerButton(self.invitationBtn)
	end

	return
end

function FeastScene:UpdateBuffs()
	local var_20_0 = getProxy(FeastProxy):GetBuffList()

	self.buffUIlist:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = var_20_0[arg_21_1 + 1]

			onButton(self, arg_21_2, function()
				self:emit(BaseUI.ON_DROP, {
					type = DROP_TYPE_BUFF,
					id = var_21_0.id
				})

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.buffUIlist:align(#var_20_0)

	return
end

function FeastScene:PlayEnterStory()
	local var_23_0 = getProxy(ActivityProxy)
	local var_23_1 = var_23_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST):getConfig("config_client")[6]

	if var_23_0 and var_23_1 ~= "" then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(var_23_1) then
			pg.NewStoryMgr.GetInstance():Play(var_23_1)
		end
	end

	return
end

function FeastScene:UpdateTips()
	setActive(self.invitationBtnTip, getProxy(FeastProxy):ShouldTipInvitation())
	setActive(self.taskBtnTip, getProxy(FeastProxy):ShouldTipTask())

	return
end

function FeastScene:SetUpCourtYard()
	self.contextData.mode = CourtYardConst.SYSTEM_FEAST

	self:emit(FeastMediator.SET_UP, 1)

	return
end

function FeastScene:BlockEvents()
	self.mainCG.blocksRaycasts = false

	return
end

function FeastScene:UnBlockEvents()
	self.mainCG.blocksRaycasts = true

	return
end

function FeastScene:onBackPressed()
	if self.invitationPage and self.invitationPage:GetLoaded() and self.invitationPage:isShowing() then
		self.invitationPage:onBackPressed()

		return
	end

	if self.taskPage and self.taskPage:GetLoaded() and self.taskPage:isShowing() then
		self.taskPage:Hide()

		return
	end

	self:emit(FeastScene.ON_BACK_PRESSED)

	return
end

function FeastScene:willExit()
	if self.invitationPage then
		self.invitationPage:Destroy()

		self.invitationPage = nil
	end

	if self.taskPage then
		self.taskPage:Destroy()

		self.taskPage = nil
	end

	return
end

return FeastScene
