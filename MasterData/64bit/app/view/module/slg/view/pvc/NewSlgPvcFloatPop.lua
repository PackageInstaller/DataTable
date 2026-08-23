local NewSlgPvcFloatPop = class("NewSlgPvcFloatPop", function()
	return fgui.GComponent:create({
		pkgName = "newSlg",
		resName = "NewSlgPvcFloatPop",
		pkgPath = "ui/newSlg/newSlg"
	}, ...)
end)

function NewSlgPvcFloatPop:ctor(arg_2_1)
	self:getView():center(true)

	arg_2_1 = arg_2_1 or {}
	self._listFloat = self:getChild("List_float")

	self._listFloat:setVirtual(self)
	self._listFloat:setItemRenderer(handler(self, self._onRenderListFloatCell))

	self._floatArr = arg_2_1.arr or {}

	self._listFloat:setNumItems(#self._floatArr)
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgPvcFloatPop_onSchedule"
	})
end

function NewSlgPvcFloatPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
end

function NewSlgPvcFloatPop:_onSchedule(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.key == "NewSlgPvcFloatPop_onSchedule" then
		for iter_4_0, iter_4_1 in ipairs(self._floatArr) do
			if iter_4_1.startTime and iter_4_1.startTime + iter_4_1.totalTime - g.core.common.ServerTime:getTime() <= 0 then
				table.remove(self._floatArr, iter_4_0)
			end
		end

		if #self._floatArr == 0 then
			self:removeSelf()
		else
			self._listFloat:setNumItems(#self._floatArr)
		end
	end
end

function NewSlgPvcFloatPop:onUnLoad()
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgPvcFloatPop_onSchedule")
end

function NewSlgPvcFloatPop:_onRenderListFloatCell(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._floatArr[arg_6_1 + 1])
end

return NewSlgPvcFloatPop
