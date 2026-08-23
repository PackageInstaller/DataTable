local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.KnightFavoConst.PANEL_PATH
local var_0_2 = g.core.const.ConstMgr.KnightFavoConst.TAB_TYPE
local var_0_3 = 200
local var_0_4 = g.core.config.skin_info
local var_0_5 = g.core.event.enum
local var_0_6 = g.core.event.EventManager
local DrawKnight = require("app.view.common.DrawKnight")
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local FavoLayer = class("FavoLayer", require("app.fairyGUI.knightFavorability.UI_FavoLayer"), function()
	return fgui.GComponent:create({
		resName = "FavoLayer",
		pkgPath = "ui/knightFavorability/knightFavorability",
		isFullScreen = true,
		pkgName = "knightFavorability"
	}, ...)
end)

function FavoLayer:ctor(arg_2_1)
	self._tab = var_0_2.FAVO_NUM
	self._curLevel = 0
	self._touchSkewPicPosX = nil
	self._picPosX = self.m_knightPlaceHolderComp:getX()
	self._canTouchKnight = true
	self._loadedPanel = {}
	self._knightStruct = nil
	self._knightFavoStruct = nil
	self._knightComp = nil
	self._isMovieOn = false
	self._alphaNode = nil

	if arg_2_1.selectedIndex then
		self._selectedIndex = arg_2_1.selectedIndex
		self._knightFavoStructList = arg_2_1.knightList
		self._maxIndex = #self._knightFavoStructList

		self:_setKnightFavoStruct(self._knightFavoStructList[self._selectedIndex])
	else
		self:_setKnightFavoStruct(arg_2_1)
	end

	self:_initView()
end

function FavoLayer:onLoad()
	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_KNIGHT_FAVORABILITYUPGRADE, self._onFavoUpdate, self)
	var_0_6:addEventListener(var_0_5.EVENT_FAVO_PLAY_LINES, self._onPlayLines, self)
	var_0_6:addEventListener(var_0_5.EVENT_FAVO_PLAY_LINES_END, self._onPlayLinesEnd, self)
	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_FESTIVAL_GET_INFOS, self._onS2CFestivalGetInfos, self)
	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_WEDDING_VOW_ACTIVE, handler(self, self._onRcvWeddingActive), self)

	if g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIRTHDAY_CARD, nil, true) then
		local var_3_0 = {}
		local var_3_1 = self._resId

		if not g.core.config.knight_favorability_info.fetch(self._resId) then
			local var_3_2 = g.core.config.skin_info.fetch(self._resId)

			if var_3_2 then
				var_3_1 = var_3_2.knight_advance_id
			end
		end

		table.insert(var_3_0, var_3_1)
		g.core.network.GameNetProxy:send_C2S_Festival_Get_Infos({
			advance_ids = var_3_0
		})
	end

	self:_updateKnight()
	var_0_6:dispatchEvent(var_0_5.EVENT_TICK_WEAK_GUIDE_TICK, false, {
		key = "FIRST_ENTER_GIVING_GIFT_LAYER",
		targetBtn = self.m_guideGraph
	})
end

function FavoLayer:_stopPlayMovie()
	self:removeMovieSprite()

	self._isMovieOn = false
end

function FavoLayer:onUnload()
	self:_stopSound()
	self:_stopPlayMovie()
	var_0_6:dispatchEvent(var_0_5.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FavoLayer:_onRcvWeddingActive()
	local var_6_0 = self._knightStruct:getResInfo().painted_id

	if self._resId ~= var_6_0 then
		self._resId = var_6_0

		self:_updateKnightPic(self._resId)
	end
end

function FavoLayer:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "EVENT_CHANGE_SKIN" then
		if self._loadedPanel[var_0_2.SOUND] then
			self._loadedPanel[var_0_2.SOUND]:updateView(self._knightFavoStruct, arg_7_2)
		end

		if self._resId ~= arg_7_2 then
			self._resId = arg_7_2

			self:_updateKnightPic(arg_7_2)
		end
	end
end

function FavoLayer:_onS2CFestivalGetInfos()
	if self._tab == var_0_2.SOUND then
		if self._loadedPanel[var_0_2.SOUND] and self._resId then
			self._loadedPanel[var_0_2.SOUND]:updateView(self._knightFavoStruct, self._resId)
		end
	end
end

function FavoLayer:_initView()
	self:addBg("bg/knightFavorability/bg_wenquanlvguan.jpg")
	self.m_topBarComp:setResInfoById(8)
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChanged))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function FavoLayer:_updateKnight()
	self:_stopSound()
	self:_updateKnightPic(self._resId)
	self:_onTabChanged()
	self.m_weddingBtn:setKnightAdvId(self._knightStruct:getAdvanceId())
	self.m_showLinesController:setSelectedIndex(1)
end

function FavoLayer:_updateKnightPic(arg_11_1)
	self:_stopPlayMovie()
	self:newScheduleOnce(handler(self, function(arg_12_0)
		if not arg_12_0.m_knightPlaceHolderComp then
			return
		end

		arg_12_0.m_knightPlaceHolderComp:removeChildren()

		local var_12_0 = DrawKnight.new({
			isAlphaNode = true,
			isShowBg = true,
			resId = arg_11_1
		})

		arg_12_0._knightComp = var_12_0

		var_12_0:setAlphaRect(var_0_0.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 300)
		var_12_0:setPosition(cc.p(250, 300))
		arg_12_0.m_knightPlaceHolderComp:addChild(var_12_0)
		arg_12_0.m_knightPlaceHolderComp:setAlpha(1)

		if arg_12_0._knightStruct then
			local var_12_1 = g.core.config.knight_base_info.fetch(arg_11_1).knight_show2
		end
	end), 0.05)
end

function FavoLayer:removeMovieSprite()
	if self._spTransTimer then
		self:cancelSchedule(self._spTransTimer)
	end
end

function FavoLayer:_onFavoUpdate(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = self._knightStruct:getFavoLevel()

	if var_14_0 > self._curLevel then
		self._curLevel = var_14_0

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			baseShowPop = {
				type = var_0_0.BaseShowTypeConst.KNIGHT_FAVOR_LEVEL_UP
			}
		})
	end
end

function FavoLayer:_updateKnightLines(arg_15_1)
	self.m_knightLines:setText(arg_15_1.tip)
	self.m_showLinesController:setSelectedIndex(0)
end

function FavoLayer:_onTabChanged()
	self:_stopSound()

	local var_16_0 = self.m_tabController:getSelectedIndex() + 1
	local var_16_1 = self._loadedPanel[var_16_0]

	if not self._loadedPanel[var_16_0] then
		var_16_1 = fgui.UIPackage:createObject("knightFavorability", var_0_1[var_16_0])

		var_16_1:setHeight((self.m_heightTempImg:getHeight()))
		self.m_panelPlaceHolderComp:addChild(var_16_1)

		self._loadedPanel[var_16_0] = var_16_1
	end

	for iter_16_0, iter_16_1 in pairs(var_0_2) do
		if self._loadedPanel[iter_16_1] then
			self._loadedPanel[iter_16_1]:setVisible(iter_16_1 == var_16_0)
		end
	end

	if var_16_0 == var_0_2.SOUND then
		self.m_dressListComp:updateView(self._knightFavoStruct, self._resId)
	else
		var_16_1:updateView(self._knightFavoStruct)
	end

	self._tab = var_16_0
end

function FavoLayer:_onPlayLines(arg_17_1, arg_17_2)
	self:_updateKnightLines(arg_17_2)
end

function FavoLayer:_onPlayLinesEnd()
	self.m_showLinesController:setSelectedIndex(1)
end

function FavoLayer:_stopSound()
	KnightVoiceCommon.stopVoice()
	self:_onPlayLinesEnd()
end

function FavoLayer:_onTouchBegin(arg_20_1)
	if self._isMovieOn then
		return
	end

	local var_20_0 = arg_20_1:getInput():getTouch()

	if not var_20_0 then
		return
	end

	local var_20_1 = var_20_0:getLocation()

	if self._canTouchKnight and self.m_knightPlaceHolderComp:containPoint(var_20_1) then
		self._touchSkewPicPosX = self._picPosX - var_20_1.x

		arg_20_1:captureTouch()
	end
end

function FavoLayer:_onTouchMove(arg_21_1)
	if self._canTouchKnight and self._touchSkewPicPosX then
		local var_21_0 = arg_21_1:getInput()
		local var_21_1 = var_21_0:getTouch():getLocation()

		self.m_knightPlaceHolderComp:setX(var_21_0.x + self._touchSkewPicPosX)

		local var_21_2 = var_21_1.x + self._touchSkewPicPosX - self._picPosX

		var_21_2 = var_21_1.x + self._touchSkewPicPosX - self._picPosX > 0 and var_21_2 or -var_21_2

		self.m_knightPlaceHolderComp:setAlpha(1 - math.min(var_21_2, var_0_3) / var_0_3)
	end
end

function FavoLayer:_onTouchEnd(arg_22_1)
	if self._canTouchKnight and self._touchSkewPicPosX then
		local var_22_0 = arg_22_1:getInput():getTouch():getLocation().x + self._touchSkewPicPosX - self._picPosX

		if math.abs(var_22_0) >= var_0_3 and self._selectedIndex then
			if var_22_0 > 0 then
				self:_onChangeLeft()
			else
				self:_onChangeRight()
			end

			self.m_knightPlaceHolderComp:setX(self._picPosX)
		else
			self._canTouchKnight = false

			self.m_knightPlaceHolderComp:runAction((cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.5, cc.p(-var_22_0, 0)), (cc.FadeIn:create(0.5))), cc.CallFunc:create(handler(self, function()
				self._canTouchKnight = true
			end)))))
		end

		self._touchSkewPicPosX = nil
	end
end

function FavoLayer:_onChangeLeft()
	self._selectedIndex = self._selectedIndex > 1 and self._selectedIndex - 1 or self._maxIndex

	if self._knightFavoStructList[self._selectedIndex] then
		g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.ROLE_SWITCHING)
		self:_setKnightFavoStruct(self._knightFavoStructList[self._selectedIndex])
		self:_updateKnight()
	end
end

function FavoLayer:_onChangeRight()
	self._selectedIndex = self._selectedIndex < self._maxIndex and self._selectedIndex + 1 or 1

	if self._knightFavoStructList[self._selectedIndex] then
		g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.ROLE_SWITCHING)
		self:_setKnightFavoStruct(self._knightFavoStructList[self._selectedIndex])
		self:_updateKnight()
	end
end

function FavoLayer:_setKnightFavoStruct(arg_26_1)
	self._knightFavoStruct = arg_26_1

	local var_26_0 = arg_26_1:getBaseKnightInfo()

	self._knightStruct = var_26_0
	self._curLevel = var_26_0:getFavoLevel()

	local var_26_1 = var_26_0:getSkin()

	self._resId = var_26_1 and var_26_1 > 0 and var_0_4.get(var_26_1).res or var_26_0:getBaseInfo().res_id
end

return FavoLayer
