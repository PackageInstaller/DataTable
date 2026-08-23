local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_2 = false
local var_0_3 = g.core.const.ConstMgr.KNIGHT_CONST
local KnightSkinLayer = class("KnightSkinLayer", require("app.fairyGUI.knight.UI_KnightSkinLayer"), function()
	return fgui.GComponent:create({
		pkgName = "knight",
		isFullScreen = true,
		pkgPath = "ui/knight/knight",
		resName = "KnightSkinLayer"
	})
end)
local var_0_5 = g.core.model.User.skinData
local var_0_6 = g.core.model.User
local var_0_7 = g.core.config.knight_base_info

function KnightSkinLayer:ctor(arg_2_1)
	self._knightAdvId = arg_2_1.knightAdvId
	self._knightStruct = nil
	self._skinList = nil
	self._curShowData = nil
	self._isFirstIn = true
	self._isTransition = false
	self._minScale = 0.5
	self._changeInterval = 1
	self._SLIDER_RATE = 100
	self._picStartPos = nil
	self._startPos = nil
	self._canMove = false
	self._picDefaultPos = self.m_knightPicComp:getPosition()
	self._sliderClickHeight = self.m_sliderBg:getHeight()
	self._sliderPosY = self.m_sliderBg:getPosition().y
	self._spineDefaultPos = self.m_knightSpineComp:getPosition()
	self._defaultLockPos = self.m_iconLock:getPosition()
	self._isNeedForceUpdateSpine = true
	self._isFirstEnter = true
	self._knightSkinSpine = nil
	self._isMovieOn = false

	self:_initComp()
	self:_addListener()
end

function KnightSkinLayer:onLoad()
	if self._isFirstEnter then
		self.m_enterTransition:play()
		self.m_enterTransition:setPaused(true)
	end

	self:_addNetWorkListener()

	if g.core.platform.ServerListProxy:isTesting() then
		self.m_bookBtn:setVisible(false)
	end
end

function KnightSkinLayer:onUnload()
	self._isFirstIn = true

	KnightVoiceCommon.stopVoice()
	self:_stopMovie()
end

function KnightSkinLayer:_stopMovie()
	if self._knightSkinSpine then
		self._knightSkinSpine:removeSpecialShowAction()
	end

	self._isMovieOn = false
end

function KnightSkinLayer:_initComp()
	self:_initData()
	self:_initUI()
end

function KnightSkinLayer:receiveCompEvent(arg_7_1)
	local var_7_0 = {
		...
	}

	if arg_7_1 == "knightSkin_KnightSkinSwitch" then
		if not var_7_0[1] or self._curShowData == var_7_0[1] then
			return
		end

		self._isNeedForceUpdateSpine = true
		self._curShowData = var_7_0[1]

		self:updateView()

		if self._isFirstIn then
			self._isFirstIn = false
		end

		self.m_skinComp:scrollStart()
		self.m_changeEndTransition:play()
	end
end

function KnightSkinLayer:_initData()
	self._skinList = var_0_5:getKnightSkins(self._knightAdvId) or {}
	self._knightStruct = var_0_6.knightsData:getKnight({
		advance_id = self._knightAdvId
	})
end

function KnightSkinLayer:_initUI()
	self:addBg("bg/common/pic_yht_beijing.jpg")

	self._isSpineSelected = self.m_switchSkinBtn:isSelected()

	if self._isSpineSelected then
		self:_showSkinSpine()
	end

	self.m_isShowDescController:setSelectedIndex(0)

	if g.core.utils.Rule.isHideSkinHandbook() then
		self.m_bookBtn:setVisible(false)
	end
end

function KnightSkinLayer:_addListener()
	self:addListen(self.m_skinComp)
	self.m_hideUIBtn:addClickListener(handler(self, self._onHideUI))
	self.m_topBar:setReturnCallBack(handler(self, self._onLayerReturn))
	self.m_slider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChange))
	self.m_slider:addClickListener(handler(self, self._onSliderClick))
	self.m_sliderBg:addClickListener(handler(self, self._onSliderClick))
	self.m_sliderBg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onBgTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_switchSkinBtn:addClickListener(handler(self, self._onSwitchSkinShow))
	self.m_bookBtn:addClickListener(handler(self, self._onSkinBookShow))
	self.m_descBtn:addClickListener(handler(self, self._onDescBtnClick))
	self.m_touchBg:addClickListener(handler(self, self._onClickTouchBg))
end

function KnightSkinLayer:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SKIN_WEAR, handler(self, self._recvSkin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SKIN_TAKEOFF, handler(self, self._recvSkin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SKIN_SHOP_GM_INFO, handler(self, self._onRecGmSkinInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_ACTIVE, handler(self, self._onRcvWeddingActive), self)
	g.core.network.GameNetProxy:send_C2S_SkinShopGMInfo({})
end

function KnightSkinLayer:_onRcvWeddingActive()
	if g.core.model.User.weddingData:isWeddingSkin(self._knightStruct:getSkin()) then
		self:_resetPic()
		self:_updateLayer()
	end
end

function KnightSkinLayer:_onRecGmSkinInfo()
	if self._isFirstEnter then
		self._isFirstEnter = false

		self.m_enterTransition:setPaused(false)
	end

	self:_updateLayer()
	self:_checkSkinState()
end

function KnightSkinLayer:_updateLayer()
	self.m_skinComp:initSkinList({
		skinList = self._skinList,
		knightStruct = self._knightStruct
	})
end

function KnightSkinLayer:_resetPic()
	if self._isSpineSelected then
		self.m_knightSpineComp:setPosition(self._spineDefaultPos)
		self.m_knightSpineComp:setScale(1)
	else
		self.m_knightPicComp:setPosition(self._picDefaultPos)
		self.m_knightPicComp:setScale(self.m_knightPicComp:getScaleNum())
	end

	self.m_slider:setValue(50)
	self.m_iconLock:setPosition(self._defaultLockPos)
end

function KnightSkinLayer:updateView()
	if self._curShowData then
		local var_16_0 = var_0_7.get((self:getCurKnightId()))
		local var_16_1 = self:getCurShowResId()
		local var_16_2 = var_0_7.get(var_16_1)

		self.m_spineComp:updateComp(var_16_2, var_16_0.quality)
		self.m_skinComp:updateComp({
			baseInfo = var_16_0,
			showData = self._curShowData,
			knightStruct = self._knightStruct
		})

		if self.m_descComp.updateComp then
			local var_16_3 = g.core.config.skin_info.fetch(var_16_1) or {}

			self._curShowData.description = self._curShowData.description or var_16_3.description or ""
			self._curShowData.name = self._curShowData.name or var_16_3.name or ""

			self.m_descComp:updateComp(self._curShowData, var_16_2)
		end

		self.m_knightPicComp:updateKnight({
			isUsePrePos = true,
			resId = var_16_1
		})

		if self._curShowData.skinInfo and self._curShowData.skinInfo.id then
			self._isOwn = var_0_5:getSkinState(self._curShowData.skinInfo.id) == 1
		end

		self.m_isShowLookController:setSelectedIndex(self._isOwn and 1 or 0)

		if self._isSpineSelected then
			self:_showSkinSpine()
		end

		self:_checkSkinState()
	end
end

function KnightSkinLayer:_onHideUI()
	if self._isMovieOn then
		self:_stopMovie()
	end

	self.m_hideUIController:setSelectedIndex(1)

	if var_0_2 then
		self.m_posText:setText("pos:" .. self._picDefaultPos.x .. "," .. self._picDefaultPos.y)
	end

	local var_17_0 = display.cy - 375 + 50

	if self._isSpineSelected then
		self.m_knightSpineComp:setPosition(display.width / 2, 410 + var_17_0)
	else
		self.m_knightPicComp:setPosition(display.width / 2, 410 + var_17_0)
	end

	self.m_iconLock:setPosition(display.width / 2, display.height / 2)
end

function KnightSkinLayer:_onShareClick()
	if self._isMovieOn then
		self:_stopMovie()
	end

	local var_18_0 = 0

	var_18_0 = self._curShowData.knightInfo and self._curShowData.knightInfo.res_id or self._curShowData.skinInfo.res

	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_3,
		resId = var_18_0
	})
end

function KnightSkinLayer:_onShowUI()
	self:_resetPic()
	self.m_hideUIController:setSelectedIndex(0)
end

function KnightSkinLayer:_onLayerReturn()
	if self.m_hideUIController:getSelectedIndex() == 1 then
		self:_onShowUI()
	elseif not self._hasPop then
		self._hasPop = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function KnightSkinLayer:_onSliderChange()
	local var_21_0 = self.m_knightPicComp:getScaleNum()
	local var_21_1 = ((self._isSpineSelected or nil) and 1) * (self.m_slider:getValue() / self._SLIDER_RATE * self._changeInterval + self._minScale)

	if self._isSpineSelected then
		self.m_knightSpineComp:setScale(var_21_1)
	else
		self.m_knightPicComp:setScale(var_21_1)
	end

	if var_0_2 then
		self.m_scaleText:setText("scale:" .. math.floor(var_21_1 * 100))
	end
end

function KnightSkinLayer:_onSliderClick(arg_22_1)
	self.m_slider:setValue((g.core.utils.Number.formatNumberByLimit((1 - (arg_22_1:getInput():getPosition().y - self._sliderPosY) / self._sliderClickHeight) * 100, 0, 100)))
	self:_onSliderChange()
end

function KnightSkinLayer:_onBgTouchBegin(arg_23_1)
	arg_23_1:stopPropagation()
end

function KnightSkinLayer:_onTouchBegin(arg_24_1)
	if self.m_hideUIController:getSelectedIndex() ~= 1 then
		return
	end

	local var_24_0 = arg_24_1:getInput():getPosition()

	if self.m_slider:containPoint(var_24_0) then
		return
	else
		self._picStartPos = self._isSpineSelected and self.m_knightSpineComp:getPosition() or self.m_knightPicComp:getPosition()
		self._startPos = var_24_0
		self._canMove = true

		arg_24_1:captureTouch()

		if var_0_2 then
			self.m_knightPicComp:setPosition(self._picDefaultPos)
		end
	end
end

function KnightSkinLayer:_onTouchMove(arg_25_1)
	if not self._startPos and not self._canMove or not self._picStartPos then
		return
	end

	local var_25_0 = arg_25_1:getInput():getPosition()
	local var_25_1 = cc.p(0, 0)

	var_25_1.x = var_25_0.x - self._startPos.x + self._picStartPos.x
	var_25_1.y = var_25_0.y - self._startPos.y + self._picStartPos.y

	if self._isSpineSelected then
		self.m_knightSpineComp:setPosition(var_25_1)
	else
		self.m_knightPicComp:setPosition(var_25_1)
	end

	if var_0_2 then
		self.m_posText:setText("pos:" .. var_25_1.x - self._picDefaultPos.x .. "," .. var_25_1.y - self._picDefaultPos.y)
	end
end

function KnightSkinLayer:_onTouchEnd()
	self._picStartPos = nil
	self._startPos = nil
	self._canMove = false
end

function KnightSkinLayer:_recvSkin()
	g.core.module.ModuleManager:tip(g.core.lang:get(204021))

	self._isFirstIn = true

	self:_resetPic()
	self:_updateLayer()
end

function KnightSkinLayer:_onSwitchSkinShow()
	if self._isMovieOn then
		self:_stopMovie()
	end

	self._isSpineSelected = self.m_switchSkinBtn:isSelected()

	self:_stopMovie()

	if self._isSpineSelected then
		self:_showSkinSpine()
	else
		self.m_knightPicComp:setVisible(true)
		self.m_knightSpineComp:setVisible(false)
	end
end

function KnightSkinLayer:_showTransEffect()
	self.m_effectComp:addEffectSpine({
		name = "eff_ui_home_trans",
		remove = true,
		isLoop = false
	})
end

function KnightSkinLayer:_showSkinSpine()
	local var_30_0 = self:getCurShowResId()

	if self._isNeedForceUpdateSpine then
		if self._knightSkinSpine then
			self._knightSkinSpine:removeFromParent()

			self._knightSkinSpine = nil
		end

		self._knightSkinSpine = DrawKnight.new({
			baseInfo = self:getCurBaseInfo(),
			resId = var_30_0,
			isShowBg = not var_0_2
		})

		self.m_knightSpineComp:addChild(self._knightSkinSpine)

		self._isNeedForceUpdateSpine = false
	elseif not self._knightSkinSpine then
		self._knightSkinSpine = DrawKnight.new({
			baseInfo = self:getCurBaseInfo(),
			resId = var_30_0,
			isShowBg = not var_0_2
		})

		self.m_knightSpineComp:addChild(self._knightSkinSpine)
	end

	if self._isOwn and self._knightStruct:getVideoShowType() == var_0_3.VIDEO_SHOW_TYPE.ALL then
		self._isMovieOn = true

		self._knightSkinSpine:playSpecialShowAction(self.m_knightMovieComp, nil, handler(self, self._stopMovie), handler(self, self._showTransEffect))
	end

	self.m_knightPicComp:setVisible(false)
	self.m_knightSpineComp:setVisible(true)

	if self.m_knightSpineComp:isVisible() then
		local var_30_1 = var_0_7.fetch(var_30_0)

		if var_30_1 then
			local var_30_3 = (var_30_1.pre_spine_scale or 100) / 100

			self._knightSkinSpine:setPosition(var_30_1.pre_spine_x or 0, var_30_1.pre_spine_y or 0)
			self._knightSkinSpine:setScale(var_30_3)
		end
	end

	if var_0_2 then
		self.m_knightPicComp:setVisible(true)
	end
end

function KnightSkinLayer:getCurBaseInfo()
	return (self._curShowData.knightInfo or nil) and var_0_7.get(self._curShowData.knightInfo.res_id)
end

function KnightSkinLayer:getCurShowResId()
	return self._curShowData.knightInfo and self._curShowData.knightInfo.res_id or self._curShowData.skinInfo.res
end

function KnightSkinLayer:getCurKnightId()
	return self._curShowData.knightInfo and self._curShowData.knightInfo.advance_id or self._curShowData.skinInfo.knight_advance_id
end

function KnightSkinLayer:_onSkinBookShow()
	if self._isMovieOn then
		self:_stopMovie()
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.SKIN_BOOK)
end

function KnightSkinLayer:_checkSkinState()
	self.m_isOwnController:setSelectedIndex(self._isOwn and 0 or 1)
end

function KnightSkinLayer:_onDescBtnClick()
	if self._isMovieOn then
		self:_stopMovie()
	end

	self.m_isShowDescController:setSelectedIndex(self.m_isShowDescController:getSelectedIndex() == 1 and 0 or 1)
end

function KnightSkinLayer:_onClickTouchBg()
	if self._isMovieOn then
		self:_stopMovie()
	end

	self.m_isShowDescController:setSelectedIndex(0)
end

return KnightSkinLayer
