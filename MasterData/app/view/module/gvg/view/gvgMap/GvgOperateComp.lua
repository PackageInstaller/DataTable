local GvgOperateComp = class("GvgOperateComp", require("app.fairyGUI.gvg.UI_GvgOperateComp"))

function GvgOperateComp:ctor()
	self._data = nil

	self:_initView()
end

function GvgOperateComp:_initView()
	return
end

function GvgOperateComp:updateView(arg_3_1)
	self._data = arg_3_1
end

return GvgOperateComp
