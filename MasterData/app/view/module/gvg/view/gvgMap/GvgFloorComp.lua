local GvgFloorComp = class("GvgFloorComp", require("app.fairyGUI.gvg.UI_GvgFloorComp"))

function GvgFloorComp:ctor()
	self._data = nil

	self:_initView()
end

function GvgFloorComp:_initView()
	return
end

function GvgFloorComp:updateView(arg_3_1)
	self._data = arg_3_1
end

function GvgFloorComp:updateCurPos(arg_4_1, arg_4_2)
	return
end

return GvgFloorComp
