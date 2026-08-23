local var_0_0 = g.core.common.Path
local var_0_1 = g.core.config.dungeon_stinger_info
local var_0_2 = g.core.model.User.easterEggData
local var_0_3 = g.core.const.ConstMgr.EasterEggConst
local EasterEggLayer = class("EasterEggLayer", require("app.fairyGUI.easterEgg.UI_EasterEggLayer"), function()
	return fgui.GComponent:create({
		resName = "EasterEggLayer",
		pkgPath = "ui/easterEgg/easterEgg",
		isFullScreen = true,
		pkgName = "easterEgg"
	}, ...)
end)

function EasterEggLayer:ctor(arg_2_1)
	self._params = arg_2_1
	self._interactionId = arg_2_1.interactionId
	self._eggId = arg_2_1.eggId
	self._isFromShare = arg_2_1.isFromShare or false
	self._uid = arg_2_1.uid or 0

	if self._uid > 0 then
		self._uid = g.core.model.User:getId()
	end

	self._userData = arg_2_1.userData or {}
	self._eggData = {}
	self._eggInfo = {}
	self._talkListStr = {}
	self._isNew = false
	self._lastTime = 0

	self:_initData()
	self:_initView(arg_2_1)
end

function EasterEggLayer:_initData()
	local var_3_0 = var_0_1.get(self._interactionId, self._eggId)

	self._eggInfo = var_3_0.toObject()

	for iter_3_0 = 1, var_0_3.TALK_NUM do
		if var_3_0["talk" .. iter_3_0] and var_3_0["talk" .. iter_3_0] ~= "" then
			table.insert(self._talkListStr, {
				index = iter_3_0,
				talkStr = var_3_0["talk" .. iter_3_0],
				knightId = var_3_0["avatar" .. iter_3_0]
			})
		end
	end
end

function EasterEggLayer:_initView()
	self.m_eggName:setText(self._eggInfo.title)
	self.m_eggNumber:setText(g.core.lang:get(300040, {
		number = self._eggInfo.stinger_number
	}))
	self.m_eggImage:setURL(var_0_0:getEasterEggImage(self._eggInfo.icon))
	self.m_logoLoader:setURL(var_0_0:getEggLogoByRegionId())
	self.m_shareTalkComp:setVisible(false)
	self.m_isShareController:setSelectedIndex(self._isFromShare and 1 or 0)
	self.m_shareComp:setVisibleEx(not self._isFromShare)
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_eggDescComp:setTitle(self._eggInfo.des)
	self.m_shareComp:setShowAwardState(0)
	self.m_closeBtn:setClickCallBack(handler(self, self._onCloseClick))
	self.m_talkList:setIniter()
	self.m_talkList:setItemRenderer(handler(self, self._onRendererTalkList))
	self.m_talkList:setNumItems(#self._talkListStr)
	self.m_openTransition:play()
end

function EasterEggLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_INTERACTION_INFO, self._onRcvInteractionInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_INTERACTION_OTHERINFO, self._onRcvInteractionOtherInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_INTERACTION_LIKE, self._onRcvInteractionLike, self)

	if not var_0_2:checkEggIsGet(self._eggInfo) and not self._isFromShare then
		self._isNew = true
	end

	if self._uid > 0 and self._isFromShare then
		g.core.network.GameNetProxy:send_C2S_Interaction_OtherInfo({
			id = self._eggId,
			interaction_id = self._interactionId,
			uid = self._uid
		})
	else
		g.core.network.GameNetProxy:send_C2S_Interaction_Info({
			id = self._eggId,
			interaction_id = self._interactionId
		})
	end
end

function EasterEggLayer:_onRcvInteractionInfo()
	self._eggData = var_0_2:getUserDataByKey(self._interactionId .. "_" .. self._eggId)

	self:updateView()
end

function EasterEggLayer:_onRcvInteractionOtherInfo(arg_7_1, arg_7_2, arg_7_3)
	self._eggData = arg_7_3.data

	self:updateView()
end

function EasterEggLayer:_onRcvInteractionLike(arg_8_1, arg_8_2, arg_8_3)
	self:updateView()
end

function EasterEggLayer:_onRendererTalkList(arg_9_1, arg_9_2)
	arg_9_2:updateCell(self._talkListStr[arg_9_1 + 1], handler(self, self._onSelectCell))
end

function EasterEggLayer:_onSelectCell(arg_10_1, arg_10_2)
	local var_10_0 = var_0_2:getCurInteractionTalkData()

	if arg_10_2 > 0 or not var_10_0.likeCount or var_10_0.likeCount >= var_0_3.USER_LIKE_MAX_COUNT then
		local var_10_1 = g.core.common.ServerTime:getTime()

		if var_10_1 > self._lastTime + var_0_3.TIP_TIME_INTERVAL then
			self._lastTime = var_10_1

			g.core.module.ModuleManager:tip(g.core.lang:get(300039))
		end

		return
	else
		g.core.network.GameNetProxy:send_C2S_Interaction_Like({
			id = self._eggId,
			interaction_id = self._interactionId,
			index = arg_10_1
		})
	end
end

function EasterEggLayer:updateView()
	local var_11_0 = var_0_2:getCurInteractionTalkData()

	table.sort(self._talkListStr, function(arg_12_0, arg_12_1)
		local var_12_0 = var_11_0.userLike[arg_12_0.index] or 0
		local var_12_1 = var_11_0.userLike[arg_12_1.index] or 0

		if var_12_0 ~= var_12_1 then
			return var_12_1 < var_12_0
		else
			return (var_11_0.talkLikes[arg_12_1.index] or 0) < (var_11_0.talkLikes[arg_12_0.index] or 0)
		end
	end)
	self.m_talkList:setNumItems(#self._talkListStr)
end

function EasterEggLayer:onUnload()
	if self._isNew then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			easterEggPop = {
				type = g.core.const.ConstMgr.ShowConst.POPLAYER_TP.EASTER_EGG
			}
		})
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.EASTER_EGG_POP_CLOSE)
	var_0_2:resetInteractionTalkData()
end

function EasterEggLayer:_onShareClick()
	local var_14_0 = self.m_showGroup:getPosition()

	self.m_showGroup:setPosition(var_14_0.x, var_14_0.y + 40)
	self.m_shareBg:setVisible(true)
	self.m_shareComp:setVisible(false)
	self.m_shareTalkComp:updateShareComp(self._talkListStr, self.m_talkList:getScrollPane():getPosY())
	self.m_shareTalkComp:setVisible(true)
	self.m_talkList:setVisible(false)
	self.m_shareDesc:setVisible(true)
	self.m_eggDescComp:setVisible(false)
	self.m_shareDesc:setText(self._eggInfo.des)

	local var_14_1 = cc.utils:captureNode(self)

	var_14_1:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_14_1:release()
	self.m_shareBg:setVisible(false)
	self.m_shareComp:setVisible(true)
	self.m_shareTalkComp:setVisible(false)
	self.m_talkList:setVisible(true)
	self.m_shareDesc:setVisible(false)
	self.m_eggDescComp:setVisible(true)
	self.m_showGroup:setPosition(var_14_0.x, var_14_0.y)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_14,
		interactionId = self._interactionId,
		eggId = self._eggId,
		eggName = self._eggInfo.title
	})
end

function EasterEggLayer:_onCloseClick()
	if self._inClose then
		return
	end

	self._inClose = true

	if self.m_closeTransition then
		self.m_closeTransition:play(handler(self, self._onCloseFinish))
	else
		self:_onCloseFinish()
	end
end

function EasterEggLayer:_onClose()
	if self._isNew then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			easterEggPop = {
				type = g.core.const.ConstMgr.ShowConst.POPLAYER_TP.EASTER_EGG
			}
		})
	end
end

function EasterEggLayer:_onCloseFinish()
	self:removeSelf()
end

return EasterEggLayer
