local SummaryPage = class("SummaryPage")

function SummaryPage:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)

	pg.DelegateInfo.New(self)

	return
end

function SummaryPage:Init(arg_2_1)
	self.summaryInfoVO = arg_2_1

	self:OnInit()

	return
end

function SummaryPage:OnInit()
	assert(false)

	return
end

function SummaryPage:Show(arg_4_1)
	setActive(self._tf, true)

	if arg_4_1 then
		arg_4_1()
	end

	return
end

function SummaryPage:Hide(arg_5_1)
	setActive(self._tf, false)

	if arg_5_1 then
		arg_5_1()
	end

	return
end

function SummaryPage:inAnim()
	assert(false)

	return
end

function SummaryPage:Clear()
	return
end

function SummaryPage:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

return SummaryPage
