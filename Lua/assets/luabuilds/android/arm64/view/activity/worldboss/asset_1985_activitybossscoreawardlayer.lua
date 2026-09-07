local ActivityBossScoreAwardLayer = class("ActivityBossScoreAwardLayer", import("view.base.BaseUI"))

function ActivityBossScoreAwardLayer:getUIName()
	return "ActivitybonusWindow_nonPt"
end

function ActivityBossScoreAwardLayer:init()
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.uiItemList = UIItemList.New(self._tf:Find("window/panel/list"), self._tf:Find("window/panel/list/item"))

	self.uiItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_3_1, arg_3_2)
		end

		return
	end)

	self.currentTxt = self._tf:Find("window/pt/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("window/top/bg/infomation"), i18n("world_expedition_reward_display"))
	setText(self._tf:Find("window/pt/title"), i18n("activityboss_sp_window_best_score"))
	setText(self._tf:Find("window/panel/list/item/target/title"), i18n("activityboss_sp_score_target"))

	return
end

function ActivityBossScoreAwardLayer:didEnter()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	self:Flush()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ActivityBossScoreAwardLayer:Flush(arg_7_1)
	self.awards = self.contextData.awards
	self.targets = self.contextData.targets
	self.score = self.contextData.score

	self.uiItemList:align(#self.awards)

	self.currentTxt.text = self.score

	return
end

function ActivityBossScoreAwardLayer:UpdateItem(arg_8_1, arg_8_2)
	local var_8_0 = self.targets[arg_8_1 + 1]
	local var_8_1 = arg_8_2:Find("award")
	local var_8_2 = {
		type = self.awards[arg_8_1 + 1][1],
		id = self.awards[arg_8_1 + 1][2],
		count = self.awards[arg_8_1 + 1][3]
	}

	updateDrop(var_8_1, var_8_2)
	onButton(self, var_8_1, function()
		self:emit(BaseUI.ON_DROP, var_8_2)

		return
	end, SFX_PANEL)
	setActive(arg_8_2:Find("award/mask"), var_8_0 <= self.score)
	setText(arg_8_2:Find("target/Text"), var_8_0)
	setText(arg_8_2:Find("title/Text"), "PHASE  " .. arg_8_1 + 1)

	return
end

function ActivityBossScoreAwardLayer:Hide()
	self:closeView()

	return
end

function ActivityBossScoreAwardLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ActivityBossScoreAwardLayer
