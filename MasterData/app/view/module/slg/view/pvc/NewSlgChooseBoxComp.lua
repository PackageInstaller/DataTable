local NewSlgChooseBoxComp = class("NewSlgChooseBoxComp", require("app.fairyGUI.newSlg.UI_NewSlgChooseBoxComp"))

function NewSlgChooseBoxComp:ctor()
	self._titleList = {}
	self._selectHandler = nil
	self._listShowHandler = nil

	self:_initChooseComp()
end

function NewSlgChooseBoxComp:_initChooseComp()
	self.m_btn:addClickListener(handler(self, self._onCLickBtn))
	self.m_list:setVirtual(self)
	self.m_list:setItemRenderer(handler(self, self._onChooseItemRender))
	self.m_list:addEventListener(fgui.UIEventType.Click, handler(self, self._onClickItem))
end

function NewSlgChooseBoxComp:_onChooseItemRender(arg_3_1, arg_3_2)
	arg_3_2:setTitle(self._titleList[arg_3_1 + 1])
end

function NewSlgChooseBoxComp:_onClickItem(arg_4_1)
	self:setSelectedIndex(self.m_list:getSelectedIndex() + 1)
end

function NewSlgChooseBoxComp:_onCLickBtn()
	self:setShowListEnable((self.m_btn:isSelected()))
end

function NewSlgChooseBoxComp:setSelectedIndex(arg_6_1, arg_6_2)
	self:setShowListEnable(false)
	self:_setChooseTitle(self._titleList[arg_6_1])

	if not arg_6_2 then
		self._selectHandler(arg_6_1)
	end
end

function NewSlgChooseBoxComp:setSelectHandler(arg_7_1)
	self._selectHandler = arg_7_1
end

function NewSlgChooseBoxComp:setListShowHandler(arg_8_1)
	self._listShowHandler = arg_8_1
end

function NewSlgChooseBoxComp:updateChooseComp(arg_9_1, arg_9_2)
	self._titleList = arg_9_1

	self.m_list:setNumItems(#self._titleList)

	arg_9_2 = arg_9_2 or 1

	self:_setChooseTitle(self._titleList[arg_9_2])
end

function NewSlgChooseBoxComp:addTitleByIdx(arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or #self._titleList

	table.insert(self._titleList, arg_10_2, arg_10_1)
end

function NewSlgChooseBoxComp:setShowListEnable(arg_11_1)
	if arg_11_1 then
		self.m_showListController:setSelectedIndex(1)
	else
		self.m_showListController:setSelectedIndex(0)
	end

	self.m_btn:setSelected(arg_11_1)

	if self._listShowHandler then
		self._listShowHandler(arg_11_1)
	end
end

function NewSlgChooseBoxComp:_setChooseTitle(arg_12_1)
	self.m_btn:setTitle(arg_12_1)
end

return NewSlgChooseBoxComp
