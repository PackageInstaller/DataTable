local var_0_0 = g.core.const.ConstMgr.ShareConst
local ActivityShareLayer = class("ActivityShareLayer", require("app.fairyGUI.activity.UI_ActivityShareLayer"), function()
	return fgui.GComponent:create({
		resName = "ActivityShareLayer",
		pkgPath = "ui/activity/activity",
		isFullScreen = true,
		pkgName = "activity"
	}, ...)
end)

function ActivityShareLayer:ctor(arg_2_1)
	self:_initView(arg_2_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SHARE_SCREENSHOT_PHOTO)
	self.m_enterTransition:play(function()
		self:_shotPic()
	end)
end

function ActivityShareLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SHARE_SUCCESS, handler(self, self._onSdkShareSucc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WE_CHAT_SHARE, handler(self, self._onRcvShareSuccess), self)
	self.m_enterTransition:play()
end

function ActivityShareLayer:_initView(arg_5_1)
	self.m_codeText = self.m_shotComp.m_codeText
	self.m_inviteCode = self.m_shotComp.m_inviteCode
	self.m_bg = self.m_shotComp.m_bg

	self:_addListener()
	self.m_codeText:setText(arg_5_1.code)

	if g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].SHARE_PNG_PATH and not g.core.platform.PlatformProxy:isChannelOfEnPC() and not g.core.platform.PlatformProxy:isChannelOfKrPC() then
		self.m_inviteCode:setURL(g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].SHARE_PNG_PATH)
	else
		self.m_inviteCode:setVisible(false)
	end

	local var_5_0 = {
		"bg_fx_haoyouyaoqing1.jpg",
		"bg_fx_haoyouyaoqing2.jpg",
		"bg_fx_haoyouyaoqing3.jpg"
	}

	if #var_5_0 > 0 then
		self.m_bg:setFill(5)
		self.m_bg:setURL("bg/inviteFriend/" .. var_5_0[math.random(#var_5_0)])
	else
		self.m_bg:setFill(5)
		self.m_bg:setURL("bg/inviteFriend/bg_fx_haoyouyaoqing1.jpg")
	end

	local var_5_1 = var_0_0.SHARE_REGION_CFG[config.PUBLISH_REGION] or {}

	self.m_cntController:setSelectedIndex(#var_5_1)

	for iter_5_0 = 1, #var_5_1 do
		local var_5_2 = var_5_1[iter_5_0]

		self["m_shareBtn" .. iter_5_0]:setVisible(not config.PCSDK_ENABLED)
		self["m_shareBtn" .. iter_5_0]:getChild("icon"):setURL(var_0_0.INVITE_FRIEND_SHARE_PLATFORM_CFG[var_5_1[iter_5_0]].icon)
		self["m_shareBtn" .. iter_5_0]:addClickListener(function()
			if not g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0(true) then
				return
			end

			g.core.platform.PlatformProxy:shareGame(nil, nil, nil, g.core.model.User.ShareData:getSavaPath(), var_5_2)
		end)

		if iter_5_0 >= 3 then
			break
		end
	end
end

function ActivityShareLayer:_onTouchEnd(arg_7_1)
	local var_7_0 = arg_7_1:getInput():getTouch()

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:getLocation()
	local var_7_2 = {
		self.m_shareBtn1,
		self.m_shareBtn2,
		self.m_shareBtn3
	}

	for iter_7_0 = 1, #var_7_2 do
		if var_7_2[iter_7_0]:containPoint(var_7_1) then
			return
		end
	end

	g.core.module.ModuleManager:popModule()
end

function ActivityShareLayer:_addListener()
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function ActivityShareLayer:_shotPic()
	local var_9_0 = cc.utils:captureNode(self.m_shotComp)

	g.core.model.User.ShareData:saveImg(var_9_0)
	var_9_0:release()
end

function ActivityShareLayer:_onSdkShareSucc()
	g.core.network.GameNetProxy:send_C2S_WeChat_Share({
		id = 1
	})
end

function ActivityShareLayer:_onRcvShareSuccess(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_11_4.awards)
	end
end

return ActivityShareLayer
