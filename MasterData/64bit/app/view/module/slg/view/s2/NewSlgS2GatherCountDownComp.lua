local NewSlgS2GatherCountDownComp = class("NewSlgS2GatherCountDownComp")

function NewSlgS2GatherCountDownComp:ctor()
	self._compProg = self:getChild("Comp_prog")
	self._txtCountDown = self:getChild("Txt_countDown")
end

function NewSlgS2GatherCountDownComp:updateView(arg_2_1, arg_2_2)
	local var_2_0 = math.max(arg_2_2 - g.core.common.ServerTime:getTime(), 0)

	self._compProg:setMax(arg_2_2 - arg_2_1)
	self._compProg:setValue(var_2_0)
	self._txtCountDown:setText((g.core.common.ServerTime:secondToHMSString(var_2_0)))
end

return NewSlgS2GatherCountDownComp
