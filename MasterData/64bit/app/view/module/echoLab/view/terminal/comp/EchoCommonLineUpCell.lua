local var_0_0 = g.core.common.Goods
local EchoCommonLineUpCell = class("EchoCommonLineUpCell", require("app.fairyGUI.echoLab.UI_EchoCommonLineUpCell"))

function EchoCommonLineUpCell:ctor()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)

	self._selectPos = 1

	self.m_knightIcon:addClickListener(handler(self, self._onClickIcon))
	self:addClickListener(handler(self, self._onClickLineUp))
end

function EchoCommonLineUpCell:updateLineUpCell(arg_2_1, arg_2_2)
	self._selectPos = arg_2_2
	self._cardData = arg_2_1
	self._advId = arg_2_1:getAdvanceId()
	self._cardType = arg_2_1:getCardType()

	local var_2_0 = var_0_0:convert({
		type = self._cardType,
		value = self._advId
	})

	if var_2_0 then
		self.m_knightIcon:setIcon(var_2_0.icon)
		self.m_qualityBg:setURL(g.core.common.Path:getUserIconQualityStarBg(var_2_0.quality))
		self.m_nameText:setText(arg_2_1:getCardName())
	end

	self.m_starComp:setVisible(false)

	if self._cardType ~= g.core.common.Goods.TYPE_SKIN then
		local var_2_1 = arg_2_1:getStar()

		if var_2_1 > 0 then
			self.m_starComp:setVisible(true)
			self.m_starComp:initStar({
				style = 1,
				gap = 0,
				index = 3,
				num = var_2_1
			})
		end
	end

	self.m_stateController:setSelectedIndex(arg_2_1:isLineUp() and 1 or 0)

	local var_2_2 = arg_2_1:getLineUpAttrInfo()

	self.m_lappingIcon:setURL(g.core.common.Path:getAttrIconByName(g.core.config.attribute_info.get(var_2_2.type).icon))

	local var_2_3, var_2_4 = g.core.lang:getAttr(var_2_2.type, var_2_2.value, false)

	self.m_lappingValueTxt:setText(var_2_4)
end

function EchoCommonLineUpCell:_onClickIcon()
	g.core.common.GlobalFunc.pushInfoPop({
		type = self._cardType,
		value = self._advId
	})
end

function EchoCommonLineUpCell:_onClickLineUp()
	if not self._cardData:isLineUp() then
		g.core.network.GameNetProxy:send_C2S_Palace_UseCompose({
			id = self._cardData:getId(),
			pos = self._selectPos
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(408905))
	end
end

return EchoCommonLineUpCell
