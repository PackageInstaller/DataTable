local var_0_0 = g.core.model.User.echoLabData
local var_0_1 = g.core.const.ConstMgr.EchoLabConst
local EchoLabCommonLineUpLayer = class("EchoLabCommonLineUpLayer", require("app.fairyGUI.echoLab.UI_EchoLabCommonLineUpLayer"), function()
	return fgui.GComponent:create({
		resName = "EchoLabCommonLineUpLayer",
		pkgPath = "ui/echoLab/echoLab",
		isFullScreen = true,
		pkgName = "echoLab"
	}, ...)
end)

function EchoLabCommonLineUpLayer:ctor(arg_2_1)
	self:addBg("bg/echoLab/bg_echo_zhongduan.jpg", nil, nil, 1)

	self._type = arg_2_1.type
	self._cardType = arg_2_1.cardType
	self._selectPos = arg_2_1.selectPos
	self._listData = {}

	self.m_filterBtn:setSelected(true)
	self.m_cardList:setVirtual()
	self.m_cardList:setItemRenderer(handler(self, self._onCardListItemRender))
	self.m_clickLoader:addClickListener(handler(self, self._onCloseClick))
	self.m_filterBtn:addClickListener(handler(self, self._onFilterChanged))
	self.m_enterTransition:play()
end

function EchoLabCommonLineUpLayer:_onFilterChanged()
	self:_updateCommonLineUpView()
end

function EchoLabCommonLineUpLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_USECOMPOSE, handler(self, self._onS2CPalaceUseCompose), self)
	self:_updateCommonLineUpView()
end

function EchoLabCommonLineUpLayer:_updateCommonLineUpView()
	self.m_slotComp:updateSlotComp(self._type, self._cardType, self._selectPos)
	self.m_coreComp:updateCoreComp(self._type, self._cardType)

	self._listData = self:_getListData()

	self.m_cardList:setNumItems(#self._listData)
	self.m_cardList:transitionShowCells("enter_right", 0.03)
	self.m_isEmptyController:setSelectedIndex(next(self._listData) and 0 or 1)
	self.m_filterBtn:setTitle(g.core.lang:get(408535, {
		name = var_0_1.EchoLabNameArray[self._type].name
	}))
end

function EchoLabCommonLineUpLayer:_onS2CPalaceUseCompose()
	self:_updateCommonLineUpView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_CARDBATTLE)
end

function EchoLabCommonLineUpLayer:_onCloseClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function EchoLabCommonLineUpLayer:_onCardListItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateLineUpCell(self._listData[arg_8_1 + 1], self._selectPos)
end

function EchoLabCommonLineUpLayer:_getListData()
	local var_9_0 = var_0_0:getCanLineUpCardListByType(self._cardType)
	local var_9_1 = {}

	if self.m_filterBtn:isSelected() then
		for iter_9_0 = 1, #var_9_0 do
			if not var_9_0[iter_9_0]:isLineUp() then
				table.insert(var_9_1, var_9_0[iter_9_0])
			end
		end
	else
		var_9_1 = var_9_0
	end

	table.sort(var_9_1, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:getLineUpAttrInfo().value
		local var_10_1 = arg_10_1:getLineUpAttrInfo().value
		local var_10_2 = arg_10_0:isLineUp() and 1 or 0
		local var_10_3 = arg_10_1:isLineUp() and 1 or 0

		if var_10_2 ~= var_10_3 then
			return var_10_3 < var_10_2
		end

		if var_10_0 ~= var_10_1 then
			return var_10_1 < var_10_0
		end

		return false
	end)

	return var_9_1
end

function EchoLabCommonLineUpLayer:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "select_embryo_slot_pos" then
		self._selectPos = arg_11_2.pos

		self:_updateCommonLineUpView()
	end
end

return EchoLabCommonLineUpLayer
