local KnightSpSoulComp = class("KnightSpSoulComp", require("app.fairyGUI.knight.UI_KnightSpSoulComp"))

function KnightSpSoulComp:ctor()
	self._param = nil
	self._attrChangeList = nil
	self._isMaxSpSoul = false

	self.m_attrChangeList:setVirtual()
	self.m_attrChangeList:setItemRenderer(handler(self, self._onAttrChangeRenderer))
	self.m_upBtn:addClickListener(handler(self, self.onUpBtnClick))
end

function KnightSpSoulComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_MR_SUPPORTUP, self.onMrKnightLevelUp, self)
end

function KnightSpSoulComp:onMrKnightLevelUp()
	self:updateView()
end

function KnightSpSoulComp:_onAttrChangeRenderer(arg_4_1, arg_4_2)
	if self._isMaxSpSoul then
		arg_4_2:setWidth(362)
	else
		arg_4_2:setWidth(190)
	end

	arg_4_2:updateAttr(self._attrChangeList[arg_4_1 + 1])
end

function KnightSpSoulComp:updateView(arg_5_1)
	arg_5_1 = arg_5_1 or self._param
	self._param = arg_5_1

	local var_5_0

	if arg_5_1 then
		var_5_0 = arg_5_1.data or {}
	end

	local var_5_1 = var_5_0.knight

	self.m_level:setText(var_5_0.knight:getSpSoulLevel())

	if var_5_1:isMaxSoulLevel() then
		self._isMaxSpSoul = true

		self.m_isMaxController:setSelectedIndex(1)
		self.m_upgradeCostController:setSelectedIndex(0)
		self.m_knightFragComp:updateComp(var_5_1)
	else
		self._isMaxSpSoul = false

		self.m_isMaxController:setSelectedIndex(0)
		self.m_nextLevel:setText(var_5_1:getSpSoulLevel() + 1)

		local var_5_2 = var_5_1:getSoulUpCost()

		if var_5_2.type == g.core.common.Goods.TYPE_FRAGMENT then
			self.m_upgradeCostController:setSelectedIndex(0)
			self.m_knightFragComp:updateComp(var_5_1)
		else
			self.m_upgradeCostController:setSelectedIndex(1)
			self.m_costItem:updateIcon(var_5_2)
			self.m_costItem:setNum(g.core.model.User.bagData:getOwnNum(var_5_2.type, var_5_2.value), var_5_2.size)
		end
	end

	self._attrChangeList = var_5_1:getSpSoulAttr(var_5_1:getSpSoulLevel())

	self.m_attrChangeList:setNumItems(#self._attrChangeList)
end

function KnightSpSoulComp:onUpBtnClick()
	local var_6_0

	if self._param then
		var_6_0 = self._param.data or {}
	end

	local var_6_1 = var_6_0.knight
	local var_6_2 = var_6_0.knight:getSoulUpCost()

	if g.core.model.User.bagData:getOwnNum(var_6_2.type, var_6_2.value) < var_6_2.size then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource(var_6_2)
	else
		g.core.network.GameNetProxy:send_C2S_Knight_MR_SupportUp({
			knight_id = var_6_1:getServerId()
		})
	end
end

return KnightSpSoulComp
