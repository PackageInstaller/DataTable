local OtherworldTerminalLayer = class("OtherworldTerminalLayer", import("view.base.BaseUI"))

OtherworldTerminalLayer.PAGE_PERSONAL = 1
OtherworldTerminalLayer.PAGE_ADVENTURE = 2
OtherworldTerminalLayer.PAGE_GUARDIAN = 3

local var_0_1 = OtherworldTerminalLayer.PAGE_PERSONAL

function OtherworldTerminalLayer:getUIName()
	return "OtherworldTerminalUI"
end

function OtherworldTerminalLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function OtherworldTerminalLayer:initData()
	return
end

function OtherworldTerminalLayer:findUI()
	self.windowTF = self._tf:Find("window")
	self.togglesTF = self.windowTF:Find("toggles")
	self.adventureTipTF = self.togglesTF:Find("2/tip")

	setText(self.togglesTF:Find(OtherworldTerminalLayer.PAGE_PERSONAL .. "/Text"), i18n("terminal_personal_title"))
	setText(self.togglesTF:Find(OtherworldTerminalLayer.PAGE_ADVENTURE .. "/Text"), i18n("terminal_adventure_title"))
	setText(self.togglesTF:Find(OtherworldTerminalLayer.PAGE_GUARDIAN .. "/Text"), i18n("terminal_guardian_title"))

	local var_4_0 = self.windowTF:Find("pages")
	local var_4_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.OTHER_WORLD_TERMINAL_EVENT_ID)

	self.personalPage = var_4_1 and not var_4_1:isEnd() and TerminalPersonalPage.New(var_4_0, self, {
		upgrade = self.contextData.upgrade
	}) or nil
	self.adventurePage = TerminalAdventurePage.New(var_4_0, self)
	self.guardianPage = TerminalGuardianPage.New(var_4_0, self)
	self.pages = {
		[OtherworldTerminalLayer.PAGE_PERSONAL] = self.personalPage,
		[OtherworldTerminalLayer.PAGE_ADVENTURE] = self.adventurePage,
		[OtherworldTerminalLayer.PAGE_GUARDIAN] = self.guardianPage
	}

	return
end

function OtherworldTerminalLayer:addListener()
	onButton(self, self.windowTF:Find("close_btn"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("mask"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self.windowTF:Find("help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.otherworld_terminal_help.tip
		})

		return
	end, SFX_CANCEL)
	eachChild(self.togglesTF, function(arg_9_0)
		onToggle(self, arg_9_0, function(arg_10_0)
			if arg_10_0 then
				local var_10_0 = tonumber(arg_9_0.name)

				if self.curPageIdx and self.curPageIdx == var_10_0 then
					return
				end

				if var_10_0 == OtherworldTerminalLayer.PAGE_PERSONAL and not self.personalPage then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self.curPageIdx = var_10_0

				self:SwitchPage()
			end

			return
		end)

		return
	end)

	return
end

function OtherworldTerminalLayer:didEnter()
	local var_11_0 = self.contextData.page or var_0_1

	if var_11_0 == OtherworldTerminalLayer.PAGE_PERSONAL and not self.personalPage then
		var_11_0 = OtherworldTerminalLayer.PAGE_ADVENTURE
	end

	triggerToggle(self.togglesTF:Find(tostring(var_11_0)), true)
	self:UpdateAdventureTip()

	return
end

function OtherworldTerminalLayer:SwitchPage()
	for iter_12_0, iter_12_1 in pairs(self.pages) do
		if iter_12_0 == self.curPageIdx then
			iter_12_1:ExecuteAction("Show")

			self.curPage = iter_12_1
		else
			iter_12_1:ExecuteAction("Hide")
		end
	end

	return
end

function OtherworldTerminalLayer:UpdateAdventurePtAct(arg_13_1)
	self.pages[OtherworldTerminalLayer.PAGE_ADVENTURE]:ExecuteAction("UpdatePt", arg_13_1)

	return
end

function OtherworldTerminalLayer:UpdateAdventureTip()
	setActive(self.adventureTipTF, (TerminalAdventurePage.IsTip()))

	return
end

function OtherworldTerminalLayer:UpdateAdventureTaskAct(arg_15_1)
	self.pages[OtherworldTerminalLayer.PAGE_ADVENTURE]:ExecuteAction("UpdateTask", arg_15_1)

	return
end

function OtherworldTerminalLayer:UpdateGuardianAct(arg_16_1)
	self.pages[OtherworldTerminalLayer.PAGE_GUARDIAN]:ExecuteAction("UpdateView", arg_16_1)

	return
end

function OtherworldTerminalLayer:willExit()
	for iter_17_0, iter_17_1 in pairs(self.pages) do
		iter_17_1:Destroy()

		iter_17_1 = nil
	end

	if self.contextData.onExit then
		self.contextData.onExit()

		self.contextData.onExit = nil
	end

	return
end

return OtherworldTerminalLayer
