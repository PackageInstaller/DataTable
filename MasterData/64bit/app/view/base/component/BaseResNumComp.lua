local BaseConst = require("app.view.base.const.BaseConst")
local BaseResNumComp = class("BaseResNumComp", require("app.fairyGUI.base_new.UI_BaseResNumComp"))

function BaseResNumComp:ctor()
	self._type = 0
	self._value = 0
	self._normalIndex = 0
	self._needNum = 0
	self._haveNum = 0
end

function BaseResNumComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self.updateHaveNum), self)
end

function BaseResNumComp:updateByTVS(arg_3_1)
	if type(arg_3_1) ~= "table" then
		return
	end

	if not arg_3_1.type then
		return
	end

	self._type = arg_3_1.type
	self._value = arg_3_1.value
	self._needNum = arg_3_1.size or 0
	self._showHave = arg_3_1.showHave or false
	self._customGetNumFunc = arg_3_1.customFunc or self._customGetNumFunc

	if arg_3_1 then
		self._oldSize = arg_3_1.oldSize or 0
	end

	if arg_3_1 and arg_3_1.icon then
		self:setIcon(arg_3_1.icon)
	else
		self:setIcon((g.core.common.Path:getIconByTypeValue(self._type, self._value, true)))
	end

	if self._oldSize > 0 then
		self.m_isOnSaleController:setSelectedIndex(1)
		self.m_discountPriceTitle:setText(self._oldSize)
	else
		self.m_isOnSaleController:setSelectedIndex(0)
	end

	self:updateHaveNum()
end

function BaseResNumComp:updateHaveNum()
	if self._type <= 0 then
		return
	end

	if self._customGetNumFunc then
		self._haveNum = self._customGetNumFunc()
	elseif self._type == g.core.common.Goods.TYPE_GOLD then
		if self._value == 0 then
			self._haveNum = g.core.model.User:getFreeGold()
		elseif self._value == 1 then
			self._haveNum = g.core.model.User:getGold()
		end
	else
		self._haveNum = self._type == g.core.common.Goods.TYPE_OUTPOST_ITEM and g.core.model.User.outpostData:getBagData():getOwnNum(self._value) or g.core.model.User.bagData:getCountById(self._type, self._value)
	end

	if self.m_showHaveController:getSelectedIndex() == BaseConst.CTRL.RESNUM_SHOW_HAVE then
		self:setTitle(self._haveNum)
		self.m_haveNum:setText("/" .. self._needNum)
	elseif self._showHave then
		self:setTitle(self._haveNum)
	else
		self:setTitle(self._needNum)
	end

	if self.m_changeColorController:getSelectedIndex() == BaseConst.CTRL.RESNUM_CHANGE_COLOR then
		if self:isLack() then
			self.m_isLackController:setSelectedIndex(BaseConst.CTRL.RESNUM_IS_LACK)
		else
			self.m_isLackController:setSelectedIndex(self._normalIndex)
		end
	end
end

function BaseResNumComp:setFontSize(arg_5_1)
	self:getChild("title"):setFontSize(arg_5_1)
	self.m_haveNum:setFontSize(arg_5_1)
end

function BaseResNumComp:setCustomGetNumFunc(arg_6_1)
	self._customGetNumFunc = arg_6_1

	self:updateHaveNum()
end

function BaseResNumComp:isLack()
	return self._haveNum < self._needNum
end

function BaseResNumComp:setTitleNormalColor(arg_8_1)
	self._normalIndex = arg_8_1
end

function BaseResNumComp:updateHaveNumTextColor(arg_9_1)
	arg_9_1 = arg_9_1 or g.core.common.Color.A6

	self.m_haveNum:setColor(arg_9_1)
end

function BaseResNumComp:updateOwnTextColor()
	self:getChild("title"):setColor((self:isLack() or nil) and (g.core.common.Color.A4 or g.core.common.Color.A5))
end

function BaseResNumComp:popGotoSource()
	g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
		type = self._type,
		value = self._value
	})
end

function BaseResNumComp:fixIconSize(arg_12_1)
	local var_12_0 = self:getChild("icon")

	var_12_0:setAutoSize(false)
	var_12_0:setFill(4)
	var_12_0:setSize(arg_12_1)
end

return BaseResNumComp
