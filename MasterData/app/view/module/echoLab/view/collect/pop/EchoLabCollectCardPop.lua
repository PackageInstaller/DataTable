local EchoLabCollectCardPop = class("EchoLabCollectCardPop", require("app.fairyGUI.echoLab.UI_EchoLabCollectCardPop"), function()
	return fgui.GComponent:create({
		resName = "EchoLabCollectCardPop",
		pkgPath = "ui/echoLab/echoLab",
		isFullScreen = true,
		pkgName = "echoLab"
	})
end)

function EchoLabCollectCardPop:ctor(arg_2_1)
	self._cardStruct = arg_2_1

	self:setWidth(display.width)
	self:showAtCenter()
	self.m_bgLoader:setURL("pic/base_new/bg_tjshengjidi.png")
	self.m_clickNode:addClickListener(handler(self, self._onClose))
	self:_init()
end

function EchoLabCollectCardPop:_init()
	self.m_knightPicComp:updatePic({
		url = self._cardStruct:getTargetPicURL()
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
end

function EchoLabCollectCardPop:_addCustomListeners()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_UPGRADECOMPOSE, handler(self, self._onActiveCardSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_ACTIVECOMPOSE, handler(self, self._onUpgradeCardSuccess), self)
end

function EchoLabCollectCardPop:onLoad()
	self:_addCustomListeners()
	self:_updateView()
end

function EchoLabCollectCardPop:_onActiveCardSuccess(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if self._cardStruct:canUpgrade() then
		self:_updateView()
	else
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function EchoLabCollectCardPop:_onUpgradeCardSuccess(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if self._cardStruct:canUpgrade() then
		self:_updateView()
	else
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function EchoLabCollectCardPop:_updateView()
	self.m_nameComp:updateView({
		name = self._cardStruct:getCardName(),
		quality = self._cardStruct:getCardQuality(true)
	})
	self.m_infoComp:updateView(self._cardStruct)
end

function EchoLabCollectCardPop:_onClose()
	g.core.module.ModuleManager:popByDisplay(self)
end

return EchoLabCollectCardPop
