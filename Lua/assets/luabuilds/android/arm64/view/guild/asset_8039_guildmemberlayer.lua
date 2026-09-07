local GuildMemberLayer = class("GuildMemberLayer", import("..base.BaseUI"))

function GuildMemberLayer:setGuildVO(arg_1_1)
	self.guildVO = arg_1_1

	self:setMemberVOs(arg_1_1:getSortMember())

	return
end

function GuildMemberLayer:setMemberVOs(arg_2_1)
	self.memberVOs = arg_2_1

	return
end

function GuildMemberLayer:setPlayerVO(arg_3_1)
	self.playerVO = arg_3_1

	return
end

function GuildMemberLayer:SetRanks(arg_4_1)
	self.ranks = arg_4_1

	return
end

function GuildMemberLayer:getUIName()
	return "GuildMemberUI"
end

function GuildMemberLayer:init()
	self.buttonsPanel = self._tf:Find("buttons_panel")
	self.toggleGroup = self._tf:Find("buttons_panel"):GetComponent(typeof(ToggleGroup))
	self.chatPanel = self._tf:Find("chat")

	setActive(self.chatPanel, false)
	setActive(self.buttonsPanel, false)

	self.btns = {
		self._tf:Find("buttons_panel/info_btn"),
		self._tf:Find("buttons_panel/duty_btn"),
		self._tf:Find("buttons_panel/fire_btn"),
		self._tf:Find("buttons_panel/impeach_btn")
	}
	self.helpBtn = self._tf:Find("help")
	self.pages = {
		GuildMemberInfoPage.New(self._tf, self.event),
		GuildAppiontPage.New(self._tf, self.event),
		GuildFirePage.New(self._tf, self.event),
		GuildImpeachPage.New(self._tf, self.event)
	}
	self.contextData.rankPage = GuildRankPage.New(self._tf, self.event)
	self.listPage = GuildMemberListPage.New(self._tf, self.event, self.contextData)

	function self.listPage.OnClickMember(arg_7_0)
		self:LoadPainting(arg_7_0)

		return
	end

	self.buttonPos = self.buttonsPanel.localPosition

	return
end

function GuildMemberLayer:didEnter()
	local function var_8_0()
		if self.page then
			setActive(self.btns[table.indexof(self.pages, self.page)]:Find("sel"), false)
		end

		return
	end

	for iter_8_0, iter_8_1 in ipairs(self.btns) do
		onButton(self, iter_8_1, function()
			if iter_8_0 == 2 and self.memberVO:IsRecruit() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_trainee_duty_change_tip"))

				return
			end

			if self.page and not self.page:GetLoaded() then
				return
			end

			local var_10_0 = self.pages[iter_8_0]

			pg.UIMgr.GetInstance():LoadingOn()
			var_10_0:ExecuteAction("Show", self.guildVO, self.playerVO, self.memberVO, function()
				if self.page then
					self.page:Hide()
				end

				var_8_0()
				setActive(iter_8_1:Find("sel"), true)

				self.page = var_10_0

				pg.UIMgr.GetInstance():LoadingOff()

				return
			end)

			return
		end, SFX_PANEL)
		self.pages[iter_8_0]:SetCallBack(function(arg_12_0)
			self.buttonsPanel.localPosition = arg_12_0

			setParent(self.buttonsPanel, pg.UIMgr.GetInstance().OverlayMain)

			return
		end, function()
			var_8_0()
			setParent(self.buttonsPanel, self._tf)

			self.buttonsPanel.localPosition = self.buttonPos

			return
		end)
	end

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.guild_member_tip.tip
		})

		return
	end, SFX_PANEL)
	self.listPage:ExecuteAction("SetUp", self.guildVO, self.memberVOs, self.ranks)

	return
end

function GuildMemberLayer:LoadPainting(arg_15_1)
	self.memberVO = arg_15_1

	local var_15_0 = arg_15_1.duty
	local var_15_1 = self.guildVO:getDutyByMemberId(self.playerVO.id)

	setActive(self.buttonsPanel, true)

	local var_15_2 = arg_15_1:GetManifesto()

	if HXSet.isHxPropose() then
		var_15_2 = ""
	end

	if not var_15_2 or var_15_2 == "" then
		setActive(self.chatPanel, false)
	else
		setActive(self.chatPanel, true)
		setText(self.chatPanel:Find("Text"), var_15_2)
	end

	if HXSet.isHxPropose() then
		pg.GuildPaintingMgr.GetInstance():Update(self.guildVO:GetOfficePainting(), Vector3(-643, -160, 0))
	else
		pg.GuildPaintingMgr.GetInstance():Update(Ship.New({
			configId = arg_15_1.icon,
			skin_id = arg_15_1.skinId
		}):getPainting(), Vector3(-484, 0, 0), true)
	end

	setActive(self.btns[4], var_15_1 == GuildConst.DUTY_DEPUTY_COMMANDER and var_15_0 == GuildConst.DUTY_COMMANDER and arg_15_1:isLongOffLine())

	local var_15_4 = (var_15_1 == GuildConst.DUTY_DEPUTY_COMMANDER or var_15_1 == GuildConst.DUTY_COMMANDER) and var_15_1 < var_15_0

	setButtonEnabled(self.btns[2], (var_15_1 == GuildConst.DUTY_DEPUTY_COMMANDER or var_15_1 == GuildConst.DUTY_COMMANDER) and var_15_1 < var_15_0)
	setGray(self.btns[2], not var_15_4, true)

	local var_15_5 = (var_15_1 == GuildConst.DUTY_DEPUTY_COMMANDER or var_15_1 == GuildConst.DUTY_COMMANDER) and var_15_1 < var_15_0

	setButtonEnabled(self.btns[3], (var_15_1 == GuildConst.DUTY_DEPUTY_COMMANDER or var_15_1 == GuildConst.DUTY_COMMANDER) and var_15_1 < var_15_0)
	setGray(self.btns[3], not var_15_5, true)

	return
end

function GuildMemberLayer:RefreshMembers()
	if self.listPage:GetLoaded() then
		self.listPage:Flush(self.guildVO, self.memberVOs, self.ranks)
	end

	return
end

function GuildMemberLayer:ActiveDefaultMenmber()
	if self.listPage:GetLoaded() then
		self.listPage:TriggerFirstCard()
	end

	return
end

function GuildMemberLayer:UpdateRankList(arg_18_1, arg_18_2)
	self.ranks[arg_18_1] = arg_18_2

	if self.contextData.rankPage and self.contextData.rankPage:GetLoaded() then
		self.contextData.rankPage:ExecuteAction("OnUpdateRankList", arg_18_1, arg_18_2)
	end

	return
end

function GuildMemberLayer:ShowInfoPanel(arg_19_1)
	self.pages[1]:ExecuteAction("Flush", arg_19_1)

	return
end

function GuildMemberLayer:onBackPressed()
	for iter_20_0, iter_20_1 in ipairs(self.pages) do
		if iter_20_1:GetLoaded() and iter_20_1:isShowing() then
			iter_20_1:Hide()

			return
		end
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	self:emit(GuildMemberLayer.ON_BACK)

	return
end

function GuildMemberLayer:willExit()
	self.contextData.rankPage:Destroy()

	self.listPage.OnClickMember = nil

	self.listPage:Destroy()

	for iter_21_0, iter_21_1 in ipairs(self.pages) do
		iter_21_1:Destroy()
	end

	if isActive(pg.MsgboxMgr.GetInstance()._go) then
		triggerButton(pg.MsgboxMgr.GetInstance()._closeBtn)
	end

	return
end

return GuildMemberLayer
