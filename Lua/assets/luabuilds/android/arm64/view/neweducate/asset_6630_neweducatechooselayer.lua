local NewEducateChooseLayer = class("NewEducateChooseLayer", import("view.newEducate.base.NewEducateBaseUI"))

NewEducateChooseLayer.TYPE = {
	ENTYR = 2,
	TAROT = 1
}

function NewEducateChooseLayer:getUIName()
	return "NewEducateChooseUI"
end

function NewEducateChooseLayer:preload(arg_2_1)
	seriesAsync({
		function(arg_3_0)
			local var_3_0 = getProxy(NewEducateProxy):GetCurChar()

			if #var_3_0:GetFSM():GetPriorityState():GetChoices() > 0 then
				arg_3_0()
			else
				pg.m02:sendNotification(GAME.NEW_EDUCATE_REQUEST_CHOICES, {
					id = var_3_0.id,
					callback = arg_3_0
				})
			end

			return
		end
	}, arg_2_1)

	return
end

function NewEducateChooseLayer:init()
	self.blockTF = self._tf:Find("block")

	setActive(self.blockTF, true)

	self.showPanel = self._tf:Find("show_panel")

	setText(self.showPanel:Find("title"), i18n("child2_choose_title"))

	self.tipBtn = self.showPanel:Find("tip")

	setText(self.showPanel:Find("refresh/Text"), i18n("child2_refresh_title"))

	self.refreshCntText = self.showPanel:Find("refresh/value"):GetComponent(typeof(Text))
	self.toggleTF = self.showPanel:Find("toggle")

	setText(self.toggleTF:Find("Text"), i18n("child2_show_detail_desc"))

	self.tarotTF = self.showPanel:Find("current/tarot")
	self.tarotCard = NewEducateTarotCard.New(self.tarotTF)
	self.emptyTarotTF = self.showPanel:Find("current/empty")

	setText(self.emptyTarotTF:Find("Text"), i18n("child2_tarot_empty"))

	self.tarotUIList = UIItemList.New(self.showPanel:Find("tarot_list"), self.showPanel:Find("tarot_list/tpl"))

	self.tarotUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			arg_5_2.name = arg_5_1 + 1
			self.cards[arg_5_1 + 1] = NewEducateTarotCard.New(arg_5_2)
		elseif arg_5_0 == UIItemList.EventUpdate then
			self:UpdateTarotChoice(arg_5_1, arg_5_2)
		end

		return
	end)

	self.entryUIList = UIItemList.New(self.showPanel:Find("entry_list"), self.showPanel:Find("entry_list/tpl"))

	self.entryUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			arg_6_2.name = arg_6_1 + 1
			self.cards[arg_6_1 + 1] = NewEducateEntryCard.New(arg_6_2)
		elseif arg_6_0 == UIItemList.EventUpdate then
			self:UpdateEntryChoice(arg_6_1, arg_6_2)
		end

		return
	end)

	self.giveupBtn = self.showPanel:Find("btns/giveup")

	setText(self.giveupBtn:Find("Text"), i18n("child2_choose_giveup"))

	self.hideBtn = self.showPanel:Find("btns/hide")

	setText(self.hideBtn:Find("Text"), i18n("child2_choose_hide"))

	self.hidePanel = self._tf:Find("hide_panel")
	self.showBtn = self.hidePanel:Find("show")

	setActive(self.showPanel, true)
	setActive(self.hidePanel, false)

	self.emptyIds = pg.gameset.child2_pool_exhausted_token.description

	return
end

function NewEducateChooseLayer:didEnter()
	onButton(self, self.tipBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.child2_choose_help.tip
		})

		return
	end, SFX_PANEL)
	onToggle(self, self.toggleTF, function(arg_9_0)
		NewEducateHelper.SetTarotDeatilDescData(arg_9_0)
		self:SwitchDescMode(arg_9_0)

		return
	end, SFX_PANEL)
	onButton(self, self.giveupBtn, function()
		self:emit(NewEducateChooseMediator.ON_GIVE_UP_CHOICE)

		return
	end, SFX_PANEL)
	onButton(self, self.hideBtn, function()
		self:UnOverlayPanel(self._tf)
		setActive(self.showPanel, false)
		setActive(self.hidePanel, true)

		return
	end, SFX_PANEL)
	onButton(self, self.showBtn, function()
		setActive(self.showPanel, true)
		setActive(self.hidePanel, false)
		self:BlurPanel(self._tf, {
			groupDelta = 3
		})

		return
	end, SFX_PANEL)

	self.config = pg.child2_benefit_list
	self.tarotRefreshCnt = pg.gameset.child2_tarot_refresh_limit.key_value
	self.entryRefreshCnt = pg.gameset.child2_effect_refresh_limit.key_value
	self.cards = {}

	self:UpdateView()
	triggerButton(self.showBtn)
	triggerToggle(self.toggleTF, NewEducateHelper.IsShowTarotDeatilDesc())
	NewEducateGuideSequence.CheckGuide(self.__cname)

	self.isMaked = false

	onDelayTick(function()
		setActive(self.blockTF, false)

		return
	end, tonumber(pg.gameset.child2_select_sleep_time.description))

	return
end

function NewEducateChooseLayer:IsPoolEmpty()
	return underscore.any(self.emptyIds, function(arg_15_0)
		return table.contains(self.choices, arg_15_0)
	end)
end

function NewEducateChooseLayer:UpdateView()
	self.tarotId = self.contextData.char:GetTarotId()
	self.state = self.contextData.char:GetFSM():GetPriorityState()
	self.choices = self.state:GetChoices()
	self.usedCnts = self.state:GetUsedCnts()

	self:UpdateRefreshCnt()

	if self.config[self.choices[1]].type == NewEducateBuff.TYPE.TAROT then
		self.type = NewEducateChooseLayer.TYPE.TAROT or NewEducateChooseLayer.TYPE.ENTYR
	end

	self:UpdateTarotPanel()
	self:UpdateGiveUpBtn()
	self:UpdateChoices()
	setActive(self.hideBtn, self.tarotId)

	return
end

function NewEducateChooseLayer:UpdateRefreshCnt()
	self.refreshCnt = self.contextData.char:GetResByType(NewEducateChar.RES_TYPE.REFRESH_CHOICE)
	self.refreshCntText.text = self.refreshCnt

	return
end

function NewEducateChooseLayer:UpdateTarotPanel()
	setActive(self.emptyTarotTF, not self.tarotId)
	setActive(self.tarotTF, self.tarotId)

	if self.tarotId then
		self.tarotCard:Update(self.tarotId, NewEducateTarotCard.TYPE.CURRENT)
	end

	return
end

function NewEducateChooseLayer:UpdateGiveUpBtn()
	setActive(self.giveupBtn, self.tarotId)

	if self.tarotId then
		local var_19_0 = self.contextData.char:getConfig(self.state:IsFromShop() and "shop_disclaim_refund" or "event_disclaim_refund")

		setText(self.giveupBtn:Find("res/Text"), "+" .. ((self.type == NewEducateChooseLayer.TYPE.TAROT or nil) and (var_19_0[2] or var_19_0[2]))[3])
	end

	return
end

function NewEducateChooseLayer:UpdateChoices()
	setActive(self.tarotUIList.container, self.type == NewEducateChooseLayer.TYPE.TAROT)
	setActive(self.entryUIList.container, self.type == NewEducateChooseLayer.TYPE.ENTYR)
	;((self.type == NewEducateChooseLayer.TYPE.TAROT or nil) and (self.tarotUIList or self.entryUIList)):align(#self.choices)

	return
end

function NewEducateChooseLayer:UpdateTarotChoice(arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1 + 1

	self.cards[arg_21_1 + 1]:Update(self.choices[arg_21_1 + 1])
	onButton(self, arg_21_2, function()
		seriesAsync({
			function(arg_23_0)
				if self.tarotId then
					self:emit(NewEducateChooseLayer.ON_BOX, {
						content = i18n("child2_replace_sure_tip"),
						onYes = arg_23_0
					})
				else
					arg_23_0()
				end

				return
			end
		}, function()
			self:emit(NewEducateChooseMediator.ON_MAKE_CHOICE, var_21_0)

			return
		end)

		return
	end, SFX_PANEL)
	self:UpdateRefreshBtn(arg_21_1 + 1, arg_21_2:Find("refresh_blue"), arg_21_2:Find("refresh_grey"))

	return
end

function NewEducateChooseLayer:UpdateEntryChoice(arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1 + 1

	self.cards[arg_25_1 + 1]:Update(self.choices[arg_25_1 + 1])
	onButton(self, arg_25_2, function()
		if self.isMaked then
			return
		end

		self:emit(NewEducateChooseMediator.ON_MAKE_CHOICE, var_25_0)

		self.isMaked = true

		return
	end, SFX_PANEL)
	self:UpdateRefreshBtn(arg_25_1 + 1, arg_25_2:Find("refresh_blue"), arg_25_2:Find("refresh_grey"))

	return
end

function NewEducateChooseLayer:UpdateRefreshBtn(arg_27_1, arg_27_2, arg_27_3)
	local var_27_1 = ((self.type == NewEducateChooseLayer.TYPE.TAROT or nil) and (self.tarotRefreshCnt or self.entryRefreshCnt)) - self.usedCnts[arg_27_1]
	local var_27_2 = self.refreshCnt > 0 and var_27_1 > 0
	local var_27_3 = self:IsPoolEmpty()

	setText(arg_27_2:Find("Text"), math.min(((self.type == NewEducateChooseLayer.TYPE.TAROT or nil) and (self.tarotRefreshCnt or self.entryRefreshCnt)) - self.usedCnts[arg_27_1], self.refreshCnt))
	setText(arg_27_3:Find("Text"), math.min(var_27_1, self.refreshCnt))
	setActive(arg_27_2, var_27_2 and not var_27_3)
	setActive(arg_27_3, not var_27_2 or var_27_3)
	onButton(self, arg_27_2, function()
		if not var_27_2 then
			return
		end

		self:emit(NewEducateChooseMediator.ON_REFRESH_CHOICE, arg_27_1)

		return
	end, SFX_PANEL)
	onButton(self, arg_27_3, function()
		if not var_27_3 then
			return
		end

		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_pool_exhausted"))

		return
	end, SFX_PANEL)

	return
end

function NewEducateChooseLayer:GetUIList()
	return (self.type == NewEducateChooseLayer.TYPE.TAROT or nil) and (self.tarotUIList or self.entryUIList)
end

function NewEducateChooseLayer:SwitchDescMode(arg_31_1)
	if self.tarotId then
		self.tarotCard:UpdateDescMode(arg_31_1)
	end

	self:GetUIList():eachActive(function(arg_32_0, arg_32_1)
		self.cards[arg_32_0 + 1]:UpdateDescMode(arg_31_1)

		return
	end)

	return
end

function NewEducateChooseLayer:UpdateDataAfterRefresh()
	self.state = self.contextData.char:GetFSM():GetPriorityState()
	self.choices = self.state:GetChoices()
	self.usedCnts = self.state:GetUsedCnts()

	self:UpdateRefreshCnt()
	self:GetUIList():eachActive(function(arg_34_0, arg_34_1)
		self:UpdateRefreshBtn(arg_34_0 + 1, arg_34_1:Find("refresh_blue"), arg_34_1:Find("refresh_grey"))

		return
	end)

	return
end

function NewEducateChooseLayer:OnRefreshDone(arg_35_1)
	self:UpdateDataAfterRefresh()
	eachChild(self:GetUIList().container, function(arg_36_0)
		if tonumber(arg_36_0.name) == arg_35_1.idx then
			local var_36_0 = arg_36_0:GetComponent(typeof(DftAniEvent))

			var_36_0:SetTriggerEvent(function()
				var_36_0:SetTriggerEvent(nil)
				self.cards[arg_35_1.idx]:Update(arg_35_1.newId)
				self.cards[arg_35_1.idx]:UpdateDescMode(self.toggleTF:GetComponent(typeof(Toggle)).isOn)

				return
			end)
			arg_36_0:GetComponent(typeof(Animation)):Play(self.type == NewEducateChooseLayer.TYPE.TAROT and "Anim_Neweducate_talent_tpl_change" or "Anim_Neweducate_tentry_tpl_change1")
		end

		return
	end)

	return
end

function NewEducateChooseLayer:OnMakeChoiceDone(arg_38_1)
	local var_38_0 = self.type == NewEducateChooseLayer.TYPE.TAROT and "Anim_Neweducate_talent_tpl_out" or "Anim_Neweducate_entry_tpl_out1"

	eachChild(self:GetUIList().container, function(arg_39_0)
		if tonumber(arg_39_0.name) ~= arg_38_1.idx then
			arg_39_0:GetComponent(typeof(Animation)):Play(var_38_0)
		end

		return
	end)
	seriesAsync({
		function(arg_40_0)
			onDelayTick(arg_40_0, 0.15)

			return
		end,
		function(arg_41_0)
			if #arg_38_1.drops > 0 then
				self:emit(NewEducateChooseLayer.ON_DROP, {
					items = arg_38_1.drops,
					removeFunc = function()
						arg_41_0()

						return
					end
				})
			else
				arg_41_0()
			end

			return
		end
	}, function()
		self:closeView()

		return
	end)

	return
end

function NewEducateChooseLayer:OnGiveUpDone(arg_44_1)
	seriesAsync({
		function(arg_45_0)
			if #arg_44_1.drops > 0 then
				self:emit(NewEducateChooseLayer.ON_DROP, {
					items = arg_44_1.drops,
					removeFunc = function()
						arg_45_0()

						return
					end
				})
			else
				arg_45_0()
			end

			return
		end
	}, function()
		self:closeView()

		return
	end)

	return
end

function NewEducateChooseLayer:onBackPressed()
	return
end

function NewEducateChooseLayer:willExit()
	for iter_49_0, iter_49_1 in ipairs(self.cards) do
		iter_49_1:Dispose()
	end

	self.cards = {}

	self.tarotCard:Dispose()
	self:UnOverlayPanel(self._tf)
	existCall(self.contextData.onExit)

	return
end

return NewEducateChooseLayer
