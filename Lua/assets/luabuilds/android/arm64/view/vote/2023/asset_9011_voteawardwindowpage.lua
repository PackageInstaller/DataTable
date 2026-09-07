local VoteAwardWindowPage = class("VoteAwardWindowPage", import("view.base.BaseSubView"))

function VoteAwardWindowPage:getUIName()
	return "VoteAwardWindowUI"
end

function VoteAwardWindowPage:OnLoaded()
	self.currToggle = self._tf:Find("frame/toggle/curr")
	self.accToggle = self._tf:Find("frame/toggle/acc")
	self.ptWindow = VoteAwardPtWindow.New(self._tf, self)
	self.closeBtn = self._tf:Find("frame/close")

	setText(self._tf:Find("frame/title/Text"), i18n("vote_lable_window_title"))
	setText(self._tf:Find("frame/panel/list/tpl/award1/mask/Text"), i18n("vote_lable_rearch"))
	setText(self._tf:Find("frame/panel/list/tpl/award/mask/Text"), i18n("vote_lable_rearch"))

	return
end

function VoteAwardWindowPage:OnInit()
	onToggle(self, self.currToggle, function(arg_4_0)
		if arg_4_0 and self.currPtData then
			self.ptWindow:Show({
				type = VoteAwardPtWindow.TYPE_CURR,
				dropList = self.currPtData.dropList,
				targets = self.currPtData.targets,
				level = self.currPtData.level,
				count = self.currPtData.count
			})
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.accToggle, function(arg_5_0)
		if arg_5_0 and self.accPtData then
			self.ptWindow:Show({
				type = VoteAwardPtWindow.TYPE_ACC,
				dropList = self.accPtData.dropList,
				targets = self.accPtData.targets,
				level = self.accPtData.level,
				count = self.accPtData.count
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function VoteAwardWindowPage:Show()
	VoteAwardWindowPage.super.Show(self)

	self.currPtData = self:GenCurrPtData()
	self.accPtData = self:GenAccPtData()

	local var_8_0 = self.currPtData ~= nil and #self.currPtData.targets > 0

	setActive(self.currToggle, self.currPtData ~= nil and #self.currPtData.targets > 0)

	if var_8_0 then
		triggerToggle(self.currToggle, true)
	else
		triggerToggle(self.accToggle, true)
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function VoteAwardWindowPage:Hide()
	VoteAwardWindowPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function VoteAwardWindowPage:GenCurrPtData()
	local var_10_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VOTE)

	if var_10_0 and not var_10_0:isEnd() then
		local var_10_1 = pg.activity_vote[var_10_0:getConfig("config_id")]
		local var_10_2 = {}
		local var_10_3 = {}

		for iter_10_0, iter_10_1 in ipairs(var_10_1.period_reward) do
			table.insert(var_10_3, iter_10_1[1])
		end

		for iter_10_2, iter_10_3 in ipairs(var_10_1.period_reward_display) do
			table.insert(var_10_2, iter_10_3)
		end

		local var_10_4 = 0

		for iter_10_4, iter_10_5 in pairs(var_10_3) do
			if iter_10_5 <= var_10_0.data2 then
				var_10_4 = iter_10_4
			end
		end

		return {
			type = VoteAwardPtWindow.TYPE_CURR,
			dropList = var_10_2,
			targets = var_10_3,
			level = var_10_4,
			count = var_10_0.data2
		}
	end

	return
end

function VoteAwardWindowPage:GenAccPtData()
	local var_11_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	return (var_11_1 and not var_11_1:isEnd() or nil) and ActivityPtData.New((getProxy(ActivityProxy):getActivityById(var_11_1:getConfig("config_client")[1])))
end

function VoteAwardWindowPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	if self.ptWindow then
		self.ptWindow = nil
	end

	return
end

return VoteAwardWindowPage
