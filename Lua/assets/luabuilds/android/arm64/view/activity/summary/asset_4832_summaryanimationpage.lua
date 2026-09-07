local SummaryAnimationPage = class("SummaryAnimationPage", import(".SummaryPage"))

function SummaryAnimationPage:OnInit()
	assert(false, "must be overwrite")

	return
end

function SummaryAnimationPage:Show(arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or self._tf

	setActive(self._tf, true)

	self.inAniming = true

	arg_2_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_3_0)
		self.inAniming = nil

		if arg_2_1 then
			arg_2_1()
		end

		return
	end)

	return
end

function SummaryAnimationPage:inAnim()
	return self.inAniming
end

return SummaryAnimationPage
