local var_0_0 = g.core.const.ConstMgr.ShareConst
local ShareLayer = class("ShareLayer", require("app.fairyGUI.share.UI_ShareLayer"), function()
	return fgui.GComponent:create({
		resName = "ShareLayer",
		pkgName = "share",
		isFullScreen = true,
		pkgPath = "ui/share/share"
	}, ...)
end)

function ShareLayer:ctor(arg_2_1)
	self._params = arg_2_1

	self:addBg("bg/share/bg_chahuafenxiang.jpg")
	self:_addListener()
	self:_initView(arg_2_1)
	self:initCntGroupView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SHARE_SCREENSHOT_PHOTO)
	self.m_enterTransition:play(function()
		self:_shotPic()
	end)
end

function ShareLayer:initCntGroupView()
	return
end

function ShareLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SHARE_SUCCESS, handler(self, self._onSdkShareSucc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WE_CHAT_SHARE, handler(self, self._onRcvShareSuccess), self)
end

function ShareLayer:_initView(arg_6_1)
	arg_6_1 = arg_6_1 or {}

	self.m_shotComp:updateView(arg_6_1)

	if self:_checkIsShowChat(arg_6_1.shareType) then
		self.m_showChatController:setSelectedIndex(1)
	else
		self.m_showChatController:setSelectedIndex(0)
	end

	self.m_shareBtnList:setVirtual(self)
	self.m_shareBtnList:setItemRenderer(handler(self, self._onShareBtnItemRender))

	local var_6_0 = var_0_0.SHARE_REGION_CFG[config.PUBLISH_REGION] or {}

	self:_checkChannelKey(var_6_0)

	local var_6_1 = #var_6_0

	if config.PCSDK_ENABLED then
		var_6_1 = 0
	else
		self.m_shareBtnList:setNumItems(var_6_1)
		self.m_shareBtnList:resizeToFit(var_6_1)
	end

	self.m_cntController:setSelectedIndex(math.min(var_6_1, 3))
end

function ShareLayer:_onShareBtnItemRender(arg_7_1, arg_7_2)
	local var_7_0 = var_0_0.SHARE_REGION_CFG[config.PUBLISH_REGION] or {}
	local var_7_1 = var_7_0[arg_7_1 + 1]

	arg_7_2:getChild("icon"):setURL(var_0_0.SHARE_PLATFORM_CFG[var_7_0[arg_7_1 + 1]].icon)
	arg_7_2:removeClickListener(0)
	arg_7_2:addClickListener(function()
		if not g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0(true) then
			return
		end

		g.core.platform.PlatformProxy:shareGame(nil, nil, nil, g.core.model.User.ShareData:getSavaPath(), var_7_1)
	end)
end

function ShareLayer:_checkIsShowChat(arg_9_1)
	return arg_9_1 == var_0_0.SHARE_TYPE.TYPE_ID_1 or arg_9_1 == var_0_0.SHARE_TYPE.TYPE_ID_2 or arg_9_1 == var_0_0.SHARE_TYPE.TYPE_ID_7 or arg_9_1 == var_0_0.SHARE_TYPE.TYPE_ID_10 or arg_9_1 == var_0_0.SHARE_TYPE.TYPE_ID_12 or arg_9_1 == var_0_0.SHARE_TYPE.TYPE_ID_13 or arg_9_1 == var_0_0.SHARE_TYPE.TYPE_ID_8 or arg_9_1 == var_0_0.SHARE_TYPE.TYPE_ID_14 or arg_9_1 == var_0_0.SHARE_TYPE.TYPE_ID_11 or arg_9_1 == var_0_0.SHARE_TYPE.TYPE_ID_18
end

function ShareLayer:_addListener()
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_saveBtn:addClickListener(handler(self, self._onSaveClick))
	self.m_saveBtn:setVisible(false)
	self.m_chatBtn:addClickListener(handler(self, self._onChatClick))
end

function ShareLayer:_shotPic()
	local var_11_0 = cc.utils:captureNode(self.m_shotComp)

	g.core.model.User.ShareData:saveImg(var_11_0)
	var_11_0:release()
end

function ShareLayer:_onSdkShareSucc()
	g.core.network.GameNetProxy:send_C2S_WeChat_Share({
		id = 1
	})
end

function ShareLayer:_onRcvShareSuccess(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_13_4.awards)
	end
end

function ShareLayer:_onTouchEnd(arg_14_1)
	local var_14_0 = arg_14_1:getInput():getTouch()

	if not var_14_0 then
		return
	end

	if self.m_shareBtnList:isVisible() and self.m_shareBtnList:containPoint((var_14_0:getLocation())) then
		return
	end

	g.core.module.ModuleManager:popModule()
end

function ShareLayer:_onSaveClick()
	if not g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0(true) then
		return
	end

	local var_15_0 = "android.permission.READ_EXTERNAL_STORAGE"

	if not g.core.platform.PlatformProxy:hasPermission("android.permission.READ_EXTERNAL_STORAGE") then
		g.core.platform.PlatformProxy:requestPermission(var_15_0, function()
			release_print("_onSaveClick------------------>" .. tostring((g.core.platform.PlatformProxy:hasPermission(var_15_0))))
		end)

		return
	end

	local var_15_1 = require("app.core.platform.NativeCallUtils").call("saveImageToGallery", {
		{
			path = g.core.model.User.ShareData:getSavaPath()
		}
	}, "boolean")

	if device.isAndroid() then
		if var_15_1 then
			g.core.module.ModuleManager:tip(g.core.lang:get(308504))
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(308505))
		end
	elseif device.isIOS() and not var_15_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(308505))
	end
end

function ShareLayer:_onChatClick()
	local var_17_0 = {
		title = g.core.lang:get(308501)
	}

	fgui.UIPackage:addPackage("ui/share/share")

	local var_17_1 = fgui.UIPackage:createObject("share", "ShareSendMsgComp")

	var_17_0.childComp = var_17_1

	if self._params.shareType == var_0_0.SHARE_TYPE.TYPE_ID_1 then
		var_17_0.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ADVANCE
		var_17_0.awards = self._params.awards

		var_17_1:setTitle(g.core.lang:get(308502, {
			name = g.core.model.User:getName()
		}))
	elseif self._params.shareType == var_0_0.SHARE_TYPE.TYPE_ID_2 then
		var_17_0.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_FURNITURE

		var_17_1:setTitle(g.core.lang:get(308503, {
			name = g.core.model.User:getName()
		}))
	elseif self._params.shareType == var_0_0.SHARE_TYPE.TYPE_ID_7 then
		var_17_0.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ARTIFACT_BASE
		var_17_0.awards = self._params.awards

		var_17_1:setTitle(g.core.lang:get(308506, {
			name = g.core.model.User:getName()
		}))
	elseif self._params.shareType == var_0_0.SHARE_TYPE.TYPE_ID_8 then
		var_17_0.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_LINE_UP_6
		var_17_0.preset_formation_info = self._params.preset_formation_info

		var_17_1:setTitle(g.core.lang:get(308507, {
			name = g.core.model.User:getName()
		}))
	elseif self._params.shareType == var_0_0.SHARE_TYPE.TYPE_ID_10 then
		var_17_0.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_UNITE_TOKEN_LIMIT
		var_17_0.awards = self._params.awards
		var_17_0.param1 = self._params.param1
		var_17_0.recruitType = self._params.recruitType

		var_17_1:setTitle(g.core.lang:get(308509, {
			name = g.core.model.User:getName()
		}))
	elseif self._params.shareType == var_0_0.SHARE_TYPE.TYPE_ID_11 then
		var_17_0.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.TOUCH_GAME
		var_17_0.shareType = var_0_0.SHARE_TYPE.TYPE_ID_11
		var_17_0.missionId = self._params.missionId
		var_17_0.gameId = self._params.gameId

		var_17_1:setTitle(g.core.lang:get(308512, {
			name = g.core.model.User:getName()
		}))
	elseif self._params.shareType == var_0_0.SHARE_TYPE.TYPE_ID_14 then
		var_17_0.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.EASTEREGG_LAYER
		var_17_0.shareType = var_0_0.SHARE_TYPE.TYPE_ID_14
		var_17_0.interactionId = self._params.interactionId
		var_17_0.eggId = self._params.eggId

		var_17_1:setTitle(g.core.lang:get(308510, {
			name1 = g.core.model.User:getName(),
			name2 = self._params.eggName
		}))
	elseif self._params.shareType == var_0_0.SHARE_TYPE.TYPE_ID_18 then
		var_17_0.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PET_BASE
		var_17_0.awards = self._params.awards

		var_17_1:setTitle(g.core.lang:get(308506, {
			name = g.core.model.User:getName()
		}))
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseChatCallPop").new(var_17_0))
end

function ShareLayer:_checkChannelKey(arg_18_1)
	local var_18_0 = g.core.platform.PlatformProxy:getChannelKey()

	if var_18_0 == "3223_2971" or var_18_0 == "3223_2972" then
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			if iter_18_1 == "7" then
				table.remove(arg_18_1, iter_18_0)

				break
			end
		end
	end
end

return ShareLayer
