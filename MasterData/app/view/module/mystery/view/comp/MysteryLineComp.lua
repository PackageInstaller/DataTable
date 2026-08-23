local var_0_0 = g.core.model.User.mysteryData
local var_0_1 = g.core.const.ConstMgr.MysteryConst
local MysteryLineComp = class("MysteryLineComp", require("app.fairyGUI.mystery.UI_MysteryLineComp"))

function MysteryLineComp:ctor()
	self.m_lineList:setVirtual()
	self.m_lineList:setItemRenderer(handler(self, self._onLineItemRenderer))
	self.m_lineList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickChangeRoomLine))
	self.m_dropDownController:setSelectedIndex(0)
	self:addClickListener(handler(self, self._onClickSelf))
end

function MysteryLineComp:_onLineItemRenderer(arg_2_1, arg_2_2)
	arg_2_2:updateCell(self._roomList[arg_2_1 + 1])
end

function MysteryLineComp:updateLineInfo()
	local var_3_0 = var_0_0:getChapterDataById((var_0_0:getCurChapterId())):getChapterConfig()

	self.m_title:setText(g.core.lang:get(423008, {
		id = var_3_0.id,
		str = var_3_0.name
	}))

	local var_3_1 = var_0_0:getRoomsData()
	local var_3_2 = var_0_0:getCurRoomId()

	if var_3_2 and var_3_1[var_3_2] then
		self.m_curLineTxt:setText(g.core.lang:get(423003, {
			num = var_3_2
		}) .. g.core.lang:get(423002, {
			cur = var_3_1[var_3_2].num,
			max = var_0_0:getRoomMaxUserCount()
		}))
	end

	self._roomList = table.values(var_3_1)

	self.m_lineList:setNumItems(#self._roomList)

	if #self._roomList > var_0_1.LINE_MAX then
		self.m_lineList:resizeToFit(var_0_1.LINE_MAX)
	else
		self.m_lineList:resizeToFit(#self._roomList)
	end
end

function MysteryLineComp:_onClickChangeRoomLine()
	local var_4_0 = var_0_0:getCurRoomId()

	if not var_4_0 then
		return
	end

	local var_4_1 = self.m_lineList:getSelectedIndex() + 1

	if not self._roomList[var_4_1] then
		return
	end

	local var_4_2 = self._roomList[var_4_1].id

	if self._roomList[var_4_1].id == var_4_0 then
		return
	end

	self:dispatchCompEvent("CHANGE_ROOM_LINE", var_4_2)
end

function MysteryLineComp:_onClickSelf()
	self.m_dropDownController:setSelectedIndex(self.m_dropDownController:getSelectedIndex() == 0 and 1 or 0)
end

return MysteryLineComp
