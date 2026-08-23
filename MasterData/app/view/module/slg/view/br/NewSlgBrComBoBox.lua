local NewSlgBrComBoBox = class("NewSlgBrComBoBox")

function NewSlgBrComBoBox:ctor()
	self._list = self:getChild("List_item")

	self._list:setVirtual()
	self._list:setItemRenderer(handler(self, self._renderItem))

	self._selIndex = 1

	self._list:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onListClickItem))

	self._openState = false

	self:addClickListener(handler(self, self.onClickSelf))

	self._maxShowNum = 3.5
end

function NewSlgBrComBoBox:setData(arg_2_1, arg_2_2)
	self._selIndex = arg_2_2 or self._selIndex
	self._data = arg_2_1

	self._list:setNumItems(#self._data)
	self._list:resizeToFit((#self._data > self._maxShowNum or nil) and (self._maxShowNum or #self._data))
end

function NewSlgBrComBoBox:setMaxShowNum(arg_3_1)
	self._maxShowNum = arg_3_1 or self._maxShowNum

	local var_3_0

	if self._data then
		var_3_0 = #self._data or 0
	end

	self._list:resizeToFit(var_3_0 < self._maxShowNum and var_3_0 or self._maxShowNum)
end

function NewSlgBrComBoBox:onClickSelf()
	self._openState = not self._openState

	self:setCtrlState("state", {
		index = self._openState and 1 or 0
	})
end

function NewSlgBrComBoBox:_renderItem(arg_5_1, arg_5_2)
	arg_5_2:onRenderComDropCell(self._data[arg_5_1 + 1], self._selIndex == arg_5_1 + 1, arg_5_1 + 1)
end

function NewSlgBrComBoBox:setChangeCallBack(arg_6_1)
	self._changeCF = arg_6_1
end

function NewSlgBrComBoBox:_onListClickItem()
	local var_7_0 = self._list:getSelectedIndex() + 1

	if self._selIndex == var_7_0 then
		return
	end

	self._selIndex = var_7_0

	if self._changeCF then
		self._changeCF(self._selIndex)
	end

	if self._data then
		self._list:setNumItems(#self._data)
	end
end

return NewSlgBrComBoBox
