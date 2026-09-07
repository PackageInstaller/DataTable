local LinerReasoningPage = class("LinerReasoningPage", import("view.base.BaseSubView"))

function LinerReasoningPage:getUIName()
	return "LinerReasoningPage"
end

function LinerReasoningPage:OnLoaded()
	self.titleTF = self._tf:Find("clues/title")

	setText(self.titleTF, i18n("liner_event_reasoning_title"))

	self.eventNameTF = self._tf:Find("clues/name")
	self.cluesTF = self._tf:Find("clues/content")
	self.optionsTF = self._tf:Find("options")

	self._tf:Find("clues/reasoning_title"):GetComponent(typeof(Image)):SetNativeSize()

	return
end

function LinerReasoningPage:OnInit()
	onButton(self, self._tf:Find("mask"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.cluesUIList = UIItemList.New(self.cluesTF, self.cluesTF:Find("tpl"))

	self.cluesUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setText(arg_5_2:Find("index/Text"), self.clues[arg_5_1 + 1]:GetTitle())
			setText(arg_5_2:Find("Text"), self.clues[arg_5_1 + 1]:GetReasoningDesc())
		end

		return
	end)

	self.optionsUIList = UIItemList.New(self.optionsTF, self.optionsTF:Find("tpl"))

	self.optionsUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = arg_6_1 + 1

			setText(arg_6_2:Find("Text"), self.options[arg_6_1 + 1])
			onButton(self, arg_6_2, function()
				self:emit(LinerLogBookMediator.GET_EVENT_AWARD, self.actId, self.groupIdx, var_6_0, self.eventGroup:GetDrop())
				self:Hide()

				return
			end, SFX_CONFIRM)
		end

		return
	end)

	return
end

function LinerReasoningPage:ShowOptions(arg_8_1, arg_8_2)
	self.actId = arg_8_1
	self.groupIdx = arg_8_2
	self.eventGroup = LinerEventGroup.New(pg.activity_template[self.actId].config_data[3][self.groupIdx])

	setText(self.eventNameTF, self.eventGroup:GetTitle())

	self.clues = self.eventGroup:GetEventList()
	self.options = self.eventGroup:GetConclusions()

	self.cluesUIList:align(#self.clues)
	self:Show()

	local var_8_0 = {}

	for iter_8_0 = 1, #self.options do
		table.insert(var_8_0, function(arg_9_0)
			self:managedTween(LeanTween.delayedCall, function()
				self.optionsUIList:align(iter_8_0)
				arg_9_0()

				return
			end, 0.066, nil)

			return
		end)
	end

	seriesAsync(var_8_0, function()
		return
	end)

	return
end

function LinerReasoningPage:OnDestroy()
	return
end

return LinerReasoningPage
