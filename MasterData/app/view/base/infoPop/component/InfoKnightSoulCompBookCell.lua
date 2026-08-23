local var_0_0 = g.core.model.User.bagData
local var_0_1 = g.core.const.ConstMgr.BAG_TYPE
local InfoKnightSoulCompBookCell = class("InfoKnightSoulCompBookCell", require("app.fairyGUI.infoPop.UI_InfoKnightSoulCompBookCell"))

function InfoKnightSoulCompBookCell:ctor()
	self._bookStruct = nil
	self._needKnightList = {}
	self._isActivate = false

	self.m_ksoulList:setVirtual()
	self.m_ksoulList:setItemRenderer(handler(self, self._onRenderKsoulList))
	self.m_ksoulList:setScrollEnabled(false)
end

function InfoKnightSoulCompBookCell:updateBookCell(arg_2_1)
	self._bookStruct = arg_2_1

	self.m_nameTxt:setText(g.core.lang:get(410615, {
		name = arg_2_1:getName()
	}))

	self._isActivate = arg_2_1:isActivate()

	self.m_isActivateController:setSelectedIndex(self._isActivate and 1 or 0)
	self.m_actStatusTxt:setText(g.core.lang:get(410606, {
		num = arg_2_1:getActivateHonor()
	}))

	self._needKnightList = arg_2_1:getNeedKnightSoulList()

	self.m_ksoulList:setNumItems(#self._needKnightList)
end

function InfoKnightSoulCompBookCell:_onRenderKsoulList(arg_3_1, arg_3_2)
	local var_3_0 = var_0_0:getOwnNum(var_0_1.KSOUL, self._needKnightList[arg_3_1 + 1])

	arg_3_2:updateIcon({
		isGetShow = true,
		scaleIndex = 3,
		type = var_0_1.KSOUL,
		value = self._needKnightList[arg_3_1 + 1],
		size = var_3_0
	})
	arg_3_2:getChild("numTxt"):setVisible(false)

	if not self._isActivate then
		arg_3_2:setGrayed(var_3_0 == 0)
	end
end

return InfoKnightSoulCompBookCell
