local CommanderBoxesPage = class("CommanderBoxesPage", import("...base.BaseSubView"))

function CommanderBoxesPage:getUIName()
	return "CommanderBoxesUI"
end

function CommanderBoxesPage:OnLoaded()
	self.boxCards = {}
	self.startBtn = self._tf:Find("frame/boxes/start_btn")
	self.finishBtn = self._tf:Find("frame/boxes/finish_btn")
	self.quicklyFinishAllBtn = self._tf:Find("frame/boxes/quick_all")
	self.settingsBtn = self._tf:Find("frame/boxes/setting_btn")
	self.closeBtn = self._tf:Find("frame/close_btn")
	self.boxesList = UIItemList.New(self._tf:Find("frame/boxes/mask/content"), self._tf:Find("frame/boxes/mask/content/frame"))
	self.scrollRect = self._tf:Find("frame/boxes/mask")
	self.traningCnt = self._tf:Find("frame/boxes/statistics/traning"):GetComponent(typeof(Text))
	self.waitCnt = self._tf:Find("frame/boxes/statistics/wait"):GetComponent(typeof(Text))
	self.itemCnt = self._tf:Find("frame/item/Text"):GetComponent(typeof(Text))

	setActive(self._tf:Find("frame/item"), not LOCK_CATTERY)

	self.mask = self._tf:Find("mask")

	setActive(self.mask, false)

	self.buildPoolPanel = CommanderBuildPoolPanel.New(self._tf, self.event, self.contextData)
	self.quicklyToolPage = CommanderQuicklyToolPage.New(self._tf, self.event)
	self.quicklyToolMsgbox = CommanderQuicklyFinishBoxMsgBoxPage.New(self._tf, self.event)
	self.lockFlagSettingPage = CommanderLockFlagSettingPage.New(self._tf, self.event, self.contextData)
	self.buildResultPage = GetCommanderResultPage.New(self._tf, self.event)

	setActive(self._tf:Find("frame"), true)

	return
end

function CommanderBoxesPage:OnInit()
	self:RegisterEvent()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.startBtn, function()
		local var_6_0 = 0

		for iter_6_0, iter_6_1 in ipairs(self.boxes) do
			if iter_6_1:getState() == CommanderBox.STATE_EMPTY then
				var_6_0 = var_6_0 + 1
			end
		end

		if var_6_0 == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_build_solt_deficiency"))

			return
		end

		self.buildPoolPanel:ExecuteAction("Show", self.pools, var_6_0)

		return
	end, SFX_PANEL)
	onButton(self, self.finishBtn, function()
		if #self.boxes <= 0 then
			return
		end

		local var_7_0 = getProxy(PlayerProxy)

		if var_7_0:getRawData().commanderBagMax <= getProxy(CommanderProxy).getCommanderCnt(var_7_0) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_capcity_is_max"))

			if callback then
				callback()
			end

			return
		end

		scrollTo(self.scrollRect, nil, 1)
		self:emit(CommanderCatMediator.BATCH_GET, self.boxes)

		return
	end, SFX_PANEL)
	onButton(self, self.settingsBtn, function()
		self.lockFlagSettingPage:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	setActive(self.settingsBtn, false)
	onButton(self, self.quicklyFinishAllBtn, function()
		if getProxy(BagProxy):getItemCountById(Item.COMMANDER_QUICKLY_TOOL_ID) <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("cat_accelfrate_notenough"))

			return
		end

		local var_9_0, var_9_1, var_9_2, var_9_3 = getProxy(CommanderProxy):CalcQuickItemUsageCnt()

		if var_9_0 <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("noacceleration_tips"))

			return
		end

		self.contextData.msgBox:ExecuteAction("Show", {
			content = i18n("acceleration_tips_1", var_9_0, var_9_1),
			content1 = i18n("acceleration_tips_2", var_9_3[1], var_9_3[2], var_9_3[3]),
			onYes = function()
				self:emit(CommanderCatMediator.ONE_KEY, var_9_0, var_9_1, var_9_2)

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function CommanderBoxesPage:RegisterEvent()
	self:bind(CommanderCatScene.MSG_QUICKLY_FINISH_TOOL_ERROR, function(arg_12_0)
		pg.TipsMgr.GetInstance():ShowTips(i18n("comander_tool_cnt_is_reclac"))
		triggerButton(self.quicklyFinishAllBtn)

		return
	end)
	self:bind(CommanderCatScene.MSG_BUILD, function(arg_13_0)
		self:Flush()

		return
	end)
	self:bind(CommanderCatScene.MSG_BATCH_BUILD, function(arg_14_0, arg_14_1)
		print(#arg_14_1)

		if arg_14_1 and #arg_14_1 > 0 then
			self.buildResultPage:ExecuteAction("Show", arg_14_1)
		end

		return
	end)
	self:bind(CommanderCatScene.EVENT_QUICKLY_TOOL, function(arg_15_0, arg_15_1)
		self.quicklyToolPage:ExecuteAction("Show", arg_15_1, Item.COMMANDER_QUICKLY_TOOL_ID)

		return
	end)
	self:bind(CommanderCatScene.MSG_OPEN_BOX, function(arg_16_0, arg_16_1, arg_16_2)
		self:PlayAnimation(arg_16_1, arg_16_2)

		return
	end)

	return
end

function CommanderBoxesPage:Update()
	self:Show()
	self:Flush()

	return
end

function CommanderBoxesPage:Flush()
	self.boxes = getProxy(CommanderProxy):getBoxes()
	self.pools = getProxy(CommanderProxy):getPools()

	self:UpdateList()
	self:UpdateItem()
	self:updateCntLabel()

	return
end

function CommanderBoxesPage:UpdateList()
	local var_19_0 = _.map(self.boxes, function(arg_20_0)
		arg_20_0.state = arg_20_0:getState()

		return arg_20_0
	end)

	table.sort(var_19_0, function(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_1.state

		if arg_21_0.state == arg_21_1.state then
			return arg_21_0.index < arg_21_1.index
		else
			return var_21_0 < arg_21_0.state
		end

		return
	end)
	self.boxesList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = var_19_0[arg_22_1 + 1]
			local var_22_1 = self.boxCards[arg_22_1]

			if not self.boxCards[arg_22_1] then
				var_22_1 = CommanderBoxCard.New(self, arg_22_2)
				self.boxCards[arg_22_1] = var_22_1
			end

			local var_22_2 = arg_22_1 > 3 and var_22_0.state == CommanderBox.STATE_EMPTY

			if not (arg_22_1 > 3 and var_22_0.state == CommanderBox.STATE_EMPTY) then
				var_22_1:Update(var_22_0)
			else
				var_22_1:Clear()
			end

			setActive(arg_22_2, not var_22_2)
		end

		return
	end)
	self.boxesList:align(#var_19_0)

	return
end

function CommanderBoxesPage:updateCntLabel()
	local var_23_0 = 0
	local var_23_1 = 0

	_.each(self.boxes, function(arg_24_0)
		arg_24_0.state = arg_24_0:getState()

		if arg_24_0.state == CommanderBox.STATE_WAITING then
			var_23_1 = var_23_1 + 1
		elseif arg_24_0.state == CommanderBox.STATE_STARTING then
			var_23_0 = var_23_0 + 1
		end

		return
	end)

	self.traningCnt.text = 0 .. "/" .. CommanderProxy.MAX_WORK_COUNT
	self.waitCnt.text = 0 .. "/" .. CommanderProxy.MAX_SLOT - CommanderProxy.MAX_WORK_COUNT

	return
end

function CommanderBoxesPage:Show()
	self.activation = true

	setActive(self._go, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CommanderBoxesPage:Hide()
	self.activation = false

	setActive(self._go, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function CommanderBoxesPage:isShow()
	return self.activation
end

function CommanderBoxesPage:PlayAnimation(arg_28_1, arg_28_2)
	local var_28_0

	for iter_28_0, iter_28_1 in pairs(self.boxCards) do
		if iter_28_1.boxVO and iter_28_1.boxVO.id == arg_28_1 then
			var_28_0 = iter_28_1

			break
		end
	end

	if var_28_0 then
		var_28_0:playAnim(arg_28_2)
	else
		arg_28_2()
	end

	return
end

function CommanderBoxesPage:CanBack()
	if self.buildPoolPanel and self.buildPoolPanel:GetLoaded() and self.buildPoolPanel:isShowing() then
		self.buildPoolPanel:Hide()

		return false
	end

	if self.quicklyToolPage and self.quicklyToolPage:GetLoaded() and self.quicklyToolPage:isShowing() then
		self.quicklyToolPage:Hide()

		return false
	end

	if self.quicklyToolMsgbox and self.quicklyToolMsgbox:GetLoaded() and self.quicklyToolMsgbox:isShowing() then
		self.quicklyToolMsgbox:Hide()

		return false
	end

	if self.lockFlagSettingPage and self.lockFlagSettingPage:GetLoaded() and self.lockFlagSettingPage:isShowing() then
		self.lockFlagSettingPage:Hide()

		return false
	end

	if self.buildResultPage and self.buildResultPage:GetLoaded() and self.buildResultPage:isShowing() then
		self.buildResultPage:Hide()

		return false
	end

	return true
end

function CommanderBoxesPage:UpdateItem()
	self.itemCnt.text = getProxy(BagProxy):getItemCountById(Item.COMMANDER_QUICKLY_TOOL_ID)

	return
end

function CommanderBoxesPage:OnDestroy()
	self:Hide()

	for iter_31_0, iter_31_1 in pairs(self.boxCards or {}) do
		iter_31_1:Destroy()
	end

	self.boxCards = {}

	if self.quicklyToolMsgbox then
		self.quicklyToolMsgbox:Destroy()

		self.quicklyToolMsgbox = nil
	end

	if self.lockFlagSettingPage then
		self.lockFlagSettingPage:Destroy()

		self.lockFlagSettingPage = nil
	end

	if self.buildResultPage then
		self.buildResultPage:Destroy()

		self.buildResultPage = nil
	end

	return
end

return CommanderBoxesPage
