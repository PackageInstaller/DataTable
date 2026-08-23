local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = g.core.common.Path
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local DrawKnight = require("app.view.common.DrawKnight")
local KnightSkinBookShowLayer = class("KnightSkinBookShowLayer", require("app.fairyGUI.knightSkinBook.UI_KnightSkinBookShowLayer"), function()
	return fgui.GComponent:create({
		pkgName = "knightSkinBook",
		isFullScreen = true,
		pkgPath = "ui/knightSkinBook/knightSkinBook",
		resName = "KnightSkinBookShowLayer"
	})
end)
local var_0_6 = g.core.model.User.skinData
local var_0_7 = g.core.model.User
local var_0_8 = g.core.config.knight_base_info

function KnightSkinBookShowLayer:ctor(arg_2_1)
	self._knightAdvId = arg_2_1.knight_advance_id
	self._info = arg_2_1
	self._knight = nil
	self._skinBookList = nil
	self._isFirstIn = true
	self._isTransition = false
	self._minScale = 0.5
	self._changeInterval = 1
	self._sliderRate = 100
	self._picStartPos = nil
	self._startPos = nil
	self._canMove = false
	self._knightSkinSpine = nil
	self._picDefaultPos = self.m_knightPicComp:getPosition()
	self._sliderClickHeight = self.m_sliderBg:getHeight()
	self._sliderPosY = self.m_sliderBg:getPosition().y
	self._isInitSkinSpine = false
	self._spineDefaultPos = self.m_knightSpineComp:getPosition()
	self._defaultLockPos = self.m_iconLock:getPosition()
	self._isNeedForceUpdateSpine = true

	self:_initComp()
	self:_addListener()
end

function KnightSkinBookShowLayer:onLoad()
	self:_addNetWorkListener()
end

function KnightSkinBookShowLayer:onUnload()
	self._isFirstIn = true

	KnightVoiceCommon.stopVoice()
	self:_stopMovie()
end

function KnightSkinBookShowLayer:_initComp()
	self:_initData()
	self:_initUI()
end

function KnightSkinBookShowLayer:receiveCompEvent(arg_6_1)
	local var_6_0 = {
		...
	}

	if arg_6_1 == "KnightSkinSwitch" then
		if var_6_0[1] == nil or self._info == var_6_0[1] then
			return
		end

		self._isNeedForceUpdateSpine = true
		self._info = var_6_0[1]

		self:updateView()

		if self._isFirstIn then
			self._isFirstIn = false
		end

		self.m_changeEndTransition:play()
		self.m_skinComp:scrollStart()
	end
end

function KnightSkinBookShowLayer:_initData()
	self._skinBookList = var_0_6:getKnightSkins(self._knightAdvId) or {}
	self._knight = var_0_7.knightsData:getKnight({
		advance_id = self._knightAdvId
	})
end

function KnightSkinBookShowLayer:_initUI()
	self._bg1 = self:addBg("bg/shop/bg_pifuxinxi.jpg")
	self._isSpineSelected = self.m_switchSkinBtn:isSelected()

	if self._isSpineSelected then
		self:_showSkinSpine()
	end
end

function KnightSkinBookShowLayer:_addListener()
	self:addListen(self.m_skinComp)
	self.m_descBtn:addClickListener(handler(self, self._onDescBtnClick))
	self.m_touchBg:addClickListener(handler(self, self._onClickTouchBg))
	self.m_hideUIBtn:addClickListener(handler(self, self._onHideUI))
	self.m_topBar:setReturnCallBack(handler(self, self._onLayerReturn))
	self.m_slider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChange))
	self.m_slider:addClickListener(handler(self, self._onSliderClick))
	self.m_sliderBg:addClickListener(handler(self, self._onSliderClick))
	self.m_sliderBg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onBgTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_switchSkinBtn:addClickListener(handler(self, self._onSwitchSkinShow))
end

function KnightSkinBookShowLayer:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SKINSHOPPING, handler(self, self._onShopping), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SKIN_WEAR, handler(self, self._recvSkin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SKIN_SHOP_GM_INFO, handler(self, self._onRecGmSkinInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_ACTIVE, handler(self, self._onRcvWeddingActive), self)
	g.core.network.GameNetProxy:send_C2S_SkinShopGMInfo({})
end

function KnightSkinBookShowLayer:_onRecGmSkinInfo()
	self:_updateLayer()
	self:_checkSkinState()
end

function KnightSkinBookShowLayer:_updateLayer()
	self.m_skinComp:initSkinList({
		skinBookList = self._skinBookList,
		knight = self._knight,
		curSkin = self._info
	})
end

function KnightSkinBookShowLayer:updateView()
	if self._info then
		self.m_isShowDescController:setSelectedIndex(0)

		local var_13_0 = var_0_8.get(self._info.knight_advance_id)
		local var_13_2 = var_0_8.get(self._info.res)

		self.m_iconLoader:setURL(var_0_2:getKnightIconById(var_13_2.icon_id))
		self.m_spineComp:updateComp(var_13_2, var_13_0.quality)
		self.m_skinComp:updateComp({
			baseInfo = var_13_0,
			info = self._info,
			knight = self._knight
		})
		self.m_descComp:updateComp(self._info, var_13_2)
		self.m_knightPicComp:updateKnight({
			isUsePrePos = true,
			resId = self._info.res
		})

		self._isOwn = var_0_6:getSkinState(self._info.id) == 1

		self.m_isShowLookController:setSelectedIndex(self._isOwn and 1 or 0)

		if self._isSpineSelected then
			if self._knightSkinSpine then
				self._knightSkinSpine:removeSpecialShowAction()
			end

			self:_showSkinSpine()
		end

		self:_checkSkinState()
	end
end

function KnightSkinBookShowLayer:_onDescBtnClick()
	if self.m_isShowDescController:getSelectedIndex() == 1 then
		self.m_isShowDescController:setSelectedIndex(0)
	else
		self.m_isShowDescController:setSelectedIndex(1)
	end
end

function KnightSkinBookShowLayer:_onClickTouchBg()
	self.m_isShowDescController:setSelectedIndex(0)
end

function KnightSkinBookShowLayer:_onLayerReturn()
	if self.m_hideUIController:getSelectedIndex() == 1 then
		self:_onShowUI()
	elseif not self._hasPop then
		self._hasPop = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function KnightSkinBookShowLayer:_onHideUI()
	self.m_hideUIController:setSelectedIndex(1)

	self._bg2 = self._bg2 or self:addBg("bg/common/pic_yht_beijing.jpg")

	self._bg1:setVisible(false)
	self._bg2:setVisible(true)

	if self._isSpineSelected then
		self.m_knightSpineComp:setPosition(display.width / 2, 410)
	else
		self.m_knightPicComp:setPosition(display.width / 2, 410)
	end

	self.m_iconLock:setPosition(display.width / 2, display.height / 2)
end

function KnightSkinBookShowLayer:_onShowUI()
	self._bg1:setVisible(true)

	if self._bg2 then
		self._bg2:setVisible(false)
	end

	self:_resetPic()
	self.m_hideUIController:setSelectedIndex(0)
end

function KnightSkinBookShowLayer:_resetPic()
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

function KnightSkinBookShowLayer:_onSliderChange()
	local var_20_0 = self.m_knightPicComp:getScaleNum()

	if self._isSpineSelected then
		var_20_0 = 1
	end

	local var_20_1 = self.m_slider:getValue() / self._sliderRate

	if self._isSpineSelected then
		self.m_knightSpineComp:setScale(var_20_0 * (var_20_1 * self._changeInterval + self._minScale))
	else
		self.m_knightPicComp:setScale(var_20_0 * (var_20_1 * self._changeInterval + self._minScale))
	end
end

function KnightSkinBookShowLayer:_onSliderClick(arg_21_1)
	self.m_slider:setValue((g.core.utils.Number.formatNumberByLimit((1 - (arg_21_1:getInput():getPosition().y - self._sliderPosY) / self._sliderClickHeight) * 100, 0, 100)))
	self:_onSliderChange()
end

function KnightSkinBookShowLayer:_onBgTouchBegin(arg_22_1)
	arg_22_1:stopPropagation()
end

function KnightSkinBookShowLayer:_onTouchBegin(arg_23_1)
	if self.m_hideUIController:getSelectedIndex() ~= 1 then
		return
	end

	local var_23_0 = arg_23_1:getInput():getPosition()

	if self.m_slider:containPoint(var_23_0) then
		return
	else
		self._picStartPos = self._isSpineSelected and self.m_knightSpineComp:getPosition() or self.m_knightPicComp:getPosition()
		self._startPos = var_23_0
		self._canMove = true

		arg_23_1:captureTouch()
	end
end

function KnightSkinBookShowLayer:_onTouchMove(arg_24_1)
	if not self._startPos and not self._canMove or not self._picStartPos then
		return
	end

	local var_24_0 = arg_24_1:getInput():getPosition()
	local var_24_1 = cc.p(0, 0)

	var_24_1.x = var_24_0.x - self._startPos.x + self._picStartPos.x
	var_24_1.y = var_24_0.y - self._startPos.y + self._picStartPos.y

	if self._isSpineSelected then
		self.m_knightSpineComp:setPosition(var_24_1)
	else
		self.m_knightPicComp:setPosition(var_24_1)
	end
end

function KnightSkinBookShowLayer:_onTouchEnd()
	self._picStartPos = nil
	self._startPos = nil
	self._canMove = false
end

function KnightSkinBookShowLayer:_onShopping(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_4.awards and self:isVisible() then
		g.core.module.ModuleManager:awardSummary(arg_26_4.awards)
		self:_updateLayer()
	end
end

function KnightSkinBookShowLayer:_showSkinSpine()
	local var_27_0 = self._info.res

	if self._isNeedForceUpdateSpine then
		if self._knightSkinSpine then
			self._knightSkinSpine:removeFromParent()

			self._knightSkinSpine = nil
		end

		self._knightSkinSpine = DrawKnight.new({
			isShowBg = true,
			resId = var_27_0
		})

		self.m_knightSpineComp:addChild(self._knightSkinSpine)

		self._isNeedForceUpdateSpine = false
	elseif not self._knightSkinSpine then
		self._knightSkinSpine = DrawKnight.new({
			isShowBg = true,
			resId = var_27_0
		})

		self.m_knightSpineComp:addChild(self._knightSkinSpine)
	end

	self.m_knightPicComp:setVisible(false)
	self.m_knightSpineComp:setVisible(true)

	if self.m_knightSpineComp:isVisible() then
		local var_27_1 = var_0_8.fetch(var_27_0)

		if var_27_1 then
			local var_27_3 = (var_27_1.pre_spine_scale or 100) / 100

			self._knightSkinSpine:setPosition(var_27_1.pre_spine_x or 0, var_27_1.pre_spine_y or 0)
			self._knightSkinSpine:setScale(var_27_3)

			if self._isOwn and self._knight:getVideoShowType() == var_0_1.VIDEO_SHOW_TYPE.ALL then
				self._knightSkinSpine:playSpecialShowAction(self.m_knightMovieComp, nil, handler(self, self._stopMovie), handler(self, self._showTransEffect))
			end
		end
	end
end

function KnightSkinBookShowLayer:_stopMovie()
	if self._knightSkinSpine then
		self._knightSkinSpine:removeSpecialShowAction()
	end

	self._isMovieOn = false
end

function KnightSkinBookShowLayer:_showTransEffect()
	self.m_effectComp:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_home_trans"
	})
end

function KnightSkinBookShowLayer:_onSwitchSkinShow()
	self._isSpineSelected = self.m_switchSkinBtn:isSelected()

	self:_stopMovie()

	if self._isSpineSelected then
		self:_showSkinSpine()
	else
		self.m_knightPicComp:setVisible(true)
		self.m_knightSpineComp:setVisible(false)
	end
end

function KnightSkinBookShowLayer:_recvSkin()
	self:_updateLayer()
	g.core.module.ModuleManager:tip(g.core.lang:get(204021))
end

function KnightSkinBookShowLayer:_onRcvWeddingActive()
	if g.core.model.User.weddingData:isWeddingSkin(self._knight:getSkin()) then
		self:_updateLayer()
	end
end

function KnightSkinBookShowLayer:_checkSkinState()
	self.m_isOwnController:setSelectedIndex(self._isOwn and 0 or 1)
end

return KnightSkinBookShowLayer
