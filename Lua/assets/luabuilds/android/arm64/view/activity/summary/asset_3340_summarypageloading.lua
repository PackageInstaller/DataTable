local SummaryPageLoading = class("SummaryPageLoading", import(".SummaryPage"))
local var_0_1 = 0.05

function SummaryPageLoading:OnInit()
	self.textContainer = findTF(self._go, "texts")
	self.textTFs = {}

	eachChild(self.textContainer, function(arg_2_0)
		setActive(arg_2_0, false)
		table.insert(self.textTFs, 1, arg_2_0)

		return
	end)

	self.timers = {}

	setActive(self._go, false)

	return
end

function SummaryPageLoading:Show(arg_3_1)
	self.inAniming = true

	setActive(self._tf, true)

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self.textTFs) do
		table.insert(var_3_0, function(arg_4_0)
			self.timers[iter_3_0] = Timer.New(function()
				if self.timers[iter_3_0] then
					self.timers[iter_3_0]:Stop()

					self.timers[iter_3_0] = nil
				end

				setActive(iter_3_1, true)
				iter_3_1:GetComponent(typeof(Typewriter)):setSpeed(0.015)
				arg_4_0()

				return
			end, var_0_1 * iter_3_0, 1)

			self.timers[iter_3_0]:Start()

			return
		end)
	end

	table.insert(var_3_0, function(arg_6_0)
		local var_6_0 = self.textContainer:GetComponent(typeof(CanvasGroup))

		LeanTween.value(go(self.textContainer), 1, 0, 0.5):setOnUpdate(System.Action_float(function(arg_7_0)
			var_6_0.alpha = arg_7_0

			return
		end)):setOnComplete(System.Action(arg_6_0)):setDelay(0.6)

		return
	end)
	seriesAsync(var_3_0, function()
		self.inAniming = nil

		arg_3_1()

		return
	end)

	return
end

function SummaryPageLoading:Hide(arg_9_1)
	self:Clear()
	setActive(self._tf, false)
	arg_9_1()

	return
end

function SummaryPageLoading:inAnim()
	return self.inAniming
end

function SummaryPageLoading:Clear()
	for iter_11_0, iter_11_1 in pairs(self.timers) do
		iter_11_1:Stop()
	end

	self.timers = {}

	return
end

return SummaryPageLoading
