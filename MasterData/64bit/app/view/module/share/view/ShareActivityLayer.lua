local ShareActivityLayer = class("ShareActivityLayer", require("app.fairyGUI.share.UI_ShareActivityLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/share/share",
		resName = "ShareActivityLayer",
		pkgName = "share",
		isFullScreen = false
	}, ...)
end)

function ShareActivityLayer:ctor(arg_2_1)
	self._shotComp = nil

	self:_initView(arg_2_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SHARE_SCREENSHOT_PHOTO)
end

function ShareActivityLayer:_initView(arg_3_1)
	self:showAtCenter()

	if arg_3_1.shareType and self._shotComp == nil then
		self._shotComp = fgui.UIPackage:createObject("share", arg_3_1.shareType)

		self._shotComp:setSize(display.width, display.height)
		self._shotComp:setTouchable(true)
		self.m_shotCompRoot:addChild(self._shotComp)
	end
end

function ShareActivityLayer:uniqueStyleOutTrans(arg_4_1)
	if self._shotComp and self._shotComp.uniqueStyleOutTrans then
		self._shotComp:uniqueStyleOutTrans(arg_4_1)
	else
		arg_4_1()
	end
end

function ShareActivityLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SHARE_SUCCESS, handler(self, self._onSdkShareSucc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WE_CHAT_SHARE, handler(self, self._onRcvShareSuccess), self)
end

function ShareActivityLayer:_onSdkShareSucc()
	g.core.network.GameNetProxy:send_C2S_WeChat_Share({
		id = 1
	})
end

function ShareActivityLayer:_onRcvShareSuccess(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_7_4.awards)
	end
end

return ShareActivityLayer
