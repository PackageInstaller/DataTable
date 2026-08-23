local VipLinkPop = class("VipLinkPop", require("app.fairyGUI.vipLink.UI_VipLinkPop"), function()
	return fgui.GComponent:create({
		pkgName = "vipLink",
		isFullScreen = false,
		pkgPath = "ui/vipLink/vipLink",
		resName = "VipLinkPop"
	}, ...)
end)

function VipLinkPop:ctor(arg_2_1)
	self._params = arg_2_1 or {}

	self:_initView()
	self:showAtCenter(true)

	self._award = g.core.model.User.vipLinkData:getReward()

	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
	self.m_closeBtn:addClickListener(handler(self, self._onClose))
	self.m_copyBtn:addClickListener(handler(self, self._onCopy))
	self.m_enterTransition:play()
	self.m_effBg:removeAllEffect()
	self.m_effBg:addEffectSpine({
		name = "eff_ui_VipLink_bglight",
		isLoop = true
	})
	g.core.model.User.vipLinkData:setIsOpen(true)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_VIP_LINK_OPEN)
end

function VipLinkPop:onLoad()
	self.m_regionController:setSelectedIndex(g.core.model.User.vipLinkData:getLinkType())
	self:_updateView()
end

function VipLinkPop:onUnload()
	return
end

function VipLinkPop:_initView()
	return
end

function VipLinkPop:_onCopy()
	g.core.platform.PlatformProxy:copyToClipboard(self.m_linkTxt:getText())
	g.core.module.ModuleManager:tip(g.core.lang:get(109551))
end

function VipLinkPop:_updateView()
	self.m_awardList:setNumItems(#self._award)

	if g.core.model.User.vipLinkData:getLinkType() == 0 then
		self.m_linkTxt:setText(g.core.model.User.vipLinkData:getLinkCode())
	end
end

function VipLinkPop:_onAwardItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateView(self._award[arg_8_1 + 1])
end

function VipLinkPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return VipLinkPop
