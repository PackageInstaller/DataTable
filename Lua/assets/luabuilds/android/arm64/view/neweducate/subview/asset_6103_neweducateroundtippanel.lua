local NewEducateRoundTipPanel = class("NewEducateRoundTipPanel", import("view.base.BaseSubView"))

NewEducateRoundTipPanel.SHOW_TIME = 5

function NewEducateRoundTipPanel:getUIName()
	return "NewEducateRoundTipPanel"
end

function NewEducateRoundTipPanel:OnLoaded()
	self.rootTF = self._tf:Find("root")
	self.assessWindow = self.rootTF:Find("assess")

	setActive(self.assessWindow, false)

	self.assessTF = self.assessWindow:Find("content/assess/Text")
	self.targetTF = self.assessWindow:Find("content/target/Text")
	self.roundWindow = self.rootTF:Find("round")

	setActive(self.roundWindow, false)

	self.roundTF = self.roundWindow:Find("calendar/week/Text")
	self.roundAnim = self.roundWindow:GetComponent(typeof(Animation))
	self.roundAnimEvent = self.roundWindow:GetComponent(typeof(DftAniEvent))

	return
end

function NewEducateRoundTipPanel:OnInit()
	onButton(self, self.assessWindow, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function NewEducateRoundTipPanel:Show(arg_5_1)
	NewEducateRoundTipPanel.super.Show(self)

	self.callback = arg_5_1

	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})

	local var_5_0 = self.contextData.char:GetRoundData()
	local var_5_1 = var_5_0.round
	local var_5_2 = 0
	local var_5_3 = 0

	if var_5_0:IsEndless() then
		local var_5_4, var_5_5, var_5_6 = var_5_0:GetEndlessProgressInfos()

		var_5_3 = var_5_6
	else
		var_5_1, var_5_2, var_5_3 = var_5_0:GetProgressInfo()
	end

	setText(self.assessTF, i18n("child2_assess_tip", var_5_2))
	setText(self.targetTF, i18n("child2_assess_tip_target", var_5_3))

	local var_5_7 = var_5_0:IsTemp()

	setText(self.roundTF, i18n("child2_cur_round", var_5_7 and var_5_1 or var_5_1 - 1))
	seriesAsync({
		function(arg_6_0)
			self.roundAnimEvent:SetEndEvent(function()
				self.roundAnimEvent:SetEndEvent(nil)
				setActive(self.roundWindow, false)
				arg_6_0()

				return
			end)
			self.roundAnimEvent:SetTriggerEvent(function()
				self.roundAnimEvent:SetTriggerEvent(nil)
				setText(self.roundTF, var_5_7 and i18n("child2_cur_round_temp") or i18n("child2_cur_round", var_5_1))

				return
			end)
			setActive(self.roundWindow, true)

			return
		end,
		function(arg_9_0)
			if var_5_0:IsShowAssessTip() then
				setActive(self.assessWindow, true)
				onDelayTick(function()
					if not self._tf or not self:isShowing() then
						return
					end

					setActive(self.assessWindow, false)
					arg_9_0()

					return
				end, NewEducateRoundTipPanel.SHOW_TIME)
			else
				arg_9_0()
			end

			return
		end
	}, function()
		self:Hide()

		return
	end)

	return
end

function NewEducateRoundTipPanel:Hide()
	self:UnOverlayPanel(self._tf)
	existCall(self.callback)

	self.callback = nil

	NewEducateRoundTipPanel.super.Hide(self)

	return
end

function NewEducateRoundTipPanel:OnDestroy()
	return
end

return NewEducateRoundTipPanel
