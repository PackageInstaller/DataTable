local NewSlgTopBarComp = class("NewSlgTopBarComp")

function NewSlgTopBarComp:ctor()
	self._comResCount1 = self:getChild("ComResCount1")
	self._comResCount2 = self:getChild("ComResCount2")
	self._listTop = self:getChild("List_top")

	self._listTop:setIniter(self)
	self._listTop:setItemRenderer(handler(self, self._onRenderListTopCell))

	self._compTips = self:getChild("Comp_tips")
end

function NewSlgTopBarComp:onLoad()
	return
end

function NewSlgTopBarComp:updateView(arg_3_1)
	self._param = arg_3_1 or {}

	self:updateItem()
end

function NewSlgTopBarComp:getResPos()
	return (self._listTop:localToGlobal(cc.p(0, 0)))
end

function NewSlgTopBarComp:updateItem()
	return
end

function NewSlgTopBarComp:_onRenderListTopCell(arg_6_1, arg_6_2)
	return
end

function NewSlgTopBarComp:onHideTips()
	self._compTips:setVisible(false)
end

return NewSlgTopBarComp
