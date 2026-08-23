local var_0_0 = 7
local NewSlgBossDropDownListComp = class("NewSlgBossDropDownListComp")

function NewSlgBossDropDownListComp:ctor()
	self._btnShow = self:getChild("Btn_show")
	self._compSelect = self:getChild("Comp_select")

	self._compSelect:addClickListener(handler(self, self._onClickBtnShow))
	self._btnShow:addClickListener(handler(self, self._onClickBtnShow))

	self._listDrop = self:getChild("List_drop")

	self._listDrop:setVirtual(self)
	self._listDrop:setItemRenderer(handler(self, self._onRenderListDropCell))
	self._listDrop:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemClickDrop))

	self._isShowCtrl = self:getController("is_show")
end

function NewSlgBossDropDownListComp:_onItemClickDrop(arg_2_1)
	local var_2_0 = arg_2_1 and arg_2_1:getDataValue() or 0

	self._selectedIndex = var_2_0

	self._isShowCtrl:setSelectedIndex(0)

	local var_2_1 = g.core.model.User.newSlgData:getBossInfoById(self._bossIds[self._selectedIndex + 1])

	if self._bossIds[self._selectedIndex + 1] == 0 then
		self._compSelect:setTitle(var_2_1.name)
	else
		self._compSelect:setTitle(g.core.lang:get(429010, {
			num = var_2_1.level,
			name = var_2_1.name
		}))
	end

	self:dispatchCompEvent("NewSlgBossDropDownListComp_onItemClickDrop", {
		index = var_2_0
	})
end

function NewSlgBossDropDownListComp:initDrop(arg_3_1, arg_3_2)
	self._bossIds = arg_3_1
	self._selectedIndex = arg_3_2

	self._listDrop:setNumItems(#arg_3_1)
	self._listDrop:resizeToFit(math.min(var_0_0, #arg_3_1))

	local var_3_0 = g.core.model.User.newSlgData:getBossInfoById(self._bossIds[arg_3_2 + 1])

	if self._bossIds[arg_3_2 + 1] == 0 then
		self._compSelect:setTitle(var_3_0.name)
	else
		self._compSelect:setTitle(g.core.lang:get(429010, {
			num = var_3_0.level,
			name = var_3_0.name
		}))
	end
end

function NewSlgBossDropDownListComp:_onClickBtnShow()
	local var_4_0 = self._isShowCtrl:getSelectedIndex() == 1

	self._isShowCtrl:setSelectedIndex(var_4_0 and 0 or 1)

	if not var_4_0 then
		self._listDrop:setNumItems(#self._bossIds)
		self._listDrop:resizeToFit(math.min(var_0_0, #self._bossIds))
		self._listDrop:scrollToView(self._selectedIndex)
	end
end

function NewSlgBossDropDownListComp:_onRenderListDropCell(arg_5_1, arg_5_2)
	local var_5_0 = g.core.model.User.newSlgData:getBossInfoById(self._bossIds[arg_5_1 + 1])

	if self._bossIds[arg_5_1 + 1] == 0 then
		arg_5_2:setTitle(var_5_0.name)
	else
		arg_5_2:setTitle(g.core.lang:get(429010, {
			num = var_5_0.level,
			name = var_5_0.name
		}))
	end

	if self._selectedIndex == arg_5_1 then
		arg_5_2:setCtrlState("bg_type", {
			index = 2
		})
	else
		arg_5_2:setCtrlState("bg_type", {
			index = (arg_5_1 + 1) % 2
		})
	end
end

return NewSlgBossDropDownListComp
