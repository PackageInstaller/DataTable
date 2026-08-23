local var_0_0 = g.core.const.ConstMgr.AllianceConst
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.allianceData
local var_0_3 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_4 = g.core.model.User.snapShotCacheData
local AllianceMainBgComp = class("AllianceMainBgComp", require("app.fairyGUI.alliance.UI_AllianceMainBgComp"))
local var_0_6 = 500

function AllianceMainBgComp:ctor()
	self._otherKnight = {}
	self._myKnight = nil
	self._scrollPanel = self:getScrollPane()
	self._showBoxDict = {}
	self._checkBoxSchedule = nil
	self._getBoxDict = {}
	self._left = 0
	self._right = 500
	self._moveToPos = cc.p(0, 0)

	self:initView()
end

function AllianceMainBgComp:initView()
	local var_2_0 = display.height / self:getHeight()
	local var_2_1 = self.m_bg1:getSize()

	self.m_bg1:setSize(var_2_1.width * var_2_0, var_2_1.height * var_2_0)

	local var_2_2 = self.m_pg1:getSize()

	self.m_pg1:setSize(var_2_2.width * var_2_0, var_2_2.height * var_2_0)
	self:setSize(display.width, display.height)

	self._right = self._right * var_2_0

	self._scrollPanel:setPosX(327)

	self._lastPosX = 327

	self.m_moveComp:addClickListener(handler(self, self._onClickMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onScrollEnd))

	self._myKnight = fgui.UIPackage:createObject("alliance", "AllianceMoveKnightComp")

	self._myKnight:updateSelfKnight()
	self.m_myRoot:addChild(self._myKnight)
	self._myKnight:setPosition(display.center.x + 327, self.m_moveComp:getY() + math.random(1, self.m_moveComp:getHeight() - 1))

	self._left = self._myKnight:getWidth()

	self:newSchedule(handler(self, self.scheduleKnightMove), 2)
	self:newSchedule(handler(self, self.scheduleLogTip), 5)
end

function AllianceMainBgComp:setMoveToPos(arg_3_1)
	self._moveToPos = arg_3_1
end

function AllianceMainBgComp:scheduleLogTip()
	if var_0_2:getBoxData():updateBoxTime() then
		local var_4_0 = g.core.common.ServerTime:getTime()
		local var_4_1 = g.core.model.User.allianceData:getParams(var_0_0.PARAMETER.BOX_TIME_MAX) - 5

		for iter_4_0, iter_4_1 in pairs(self._showBoxDict) do
			if var_4_0 >= iter_4_1.boxData.box_time + var_4_1 then
				iter_4_1.comp:removeFromParent()

				self._showBoxDict[iter_4_0] = nil
			end
		end
	end
end

function AllianceMainBgComp:_onClickMove(arg_5_1)
	if self._myKnight:isMoving() then
		return
	end

	local var_5_0 = arg_5_1:getInput()
	local var_5_1 = var_5_0:getTouch():getLocation()

	self:moveKnight(self._myKnight, (cc.p(var_5_0.x + self._scrollPanel:getPosX(), cc.p(var_5_1.x, display.height - var_5_1.y).y + self._scrollPanel:getPosY())))

	if not self._checkBoxSchedule then
		self:checkGetBoxSchedule()

		self._checkBoxSchedule = self:newSchedule(handler(self, self.checkGetBoxSchedule), 0.1)
	end
end

function AllianceMainBgComp:checkGetBoxSchedule()
	local var_6_0 = self._myKnight:getPosition()

	for iter_6_0, iter_6_1 in pairs(self._showBoxDict) do
		local var_6_1 = iter_6_1.comp:getPosition()

		if math.abs(var_6_0.x - var_6_1.x) < 100 and math.abs(var_6_0.y - var_6_1.y) < 150 then
			self:playBoxGet(iter_6_1)

			self._showBoxDict[iter_6_0] = nil
		end
	end

	if not self._myKnight:isMoving() then
		self:cancelSchedule(self._checkBoxSchedule)

		self._checkBoxSchedule = nil

		self:getBox()

		return
	end
end

function AllianceMainBgComp:playBoxGet(arg_7_1)
	if var_0_2:getBoxData():boxIsExpired(arg_7_1.boxData.box_time) then
		return
	end

	self._getBoxDict[arg_7_1.boxData.box_id] = self._getBoxDict[arg_7_1.boxData.box_id] or 0
	self._getBoxDict[arg_7_1.boxData.box_id] = self._getBoxDict[arg_7_1.boxData.box_id] + 1

	local var_7_0 = arg_7_1.comp

	arg_7_1.comp:runFGAction((fgui.FSequence:create({
		fgui.FSpawn:create({
			fgui.FEaseBackOut:create(fgui.FMoveBy:create(0.3, cc.p(0, -100))),
			fgui.FScaleTo:create(0.3, 1.2)
		}),
		fgui.FSpawn:create({
			fgui.FMoveTo:create(0.5, cc.p(self._moveToPos.x + self._scrollPanel:getPosX(), self._moveToPos.y)),
			fgui.FScaleTo:create(0.5, 0.3)
		}),
		fgui.FCallFunc:create(handler(self, function(arg_8_0)
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_box_collect)
			self:dispatchCompEvent("Play_fly_effect")
			var_7_0:removeFromParent()
		end))
	})))
end

function AllianceMainBgComp:getBox()
	if not next(self._getBoxDict) then
		return
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self._getBoxDict) do
		table.insert(var_9_0, {
			id = iter_9_0,
			num = iter_9_1
		})
	end

	g.core.network.GameNetProxy:send_C2S_GuildAlliance_BoxGet({
		boxes = var_9_0
	})

	self._getBoxDict = {}
end

function AllianceMainBgComp:moveKnight(arg_10_1, arg_10_2)
	arg_10_2.x = math.clamp(arg_10_2.x, self._left, self.m_moveComp:getWidth() - self._right)

	local var_10_0 = arg_10_2.x >= arg_10_1:getPosition().x

	arg_10_1:stopAllFGActions()
	arg_10_1:runFGAction((fgui.FSequence:create({
		fgui.FCallFunc:create(handler(self, function(arg_11_0)
			arg_10_1:startMove(var_10_0)
		end)),
		fgui.FMoveTo:create(cc.pGetLength(cc.pSub(arg_10_2, arg_10_1:getPosition())) / var_0_6, arg_10_2),
		fgui.FCallFunc:create(handler(self, function(arg_12_0)
			arg_10_1:stopMove()
		end))
	})))
end

function AllianceMainBgComp:_onScrollEnd()
	if math.abs(self._lastPosX - self._scrollPanel:getPosX()) < 10 then
		return
	end

	if self._myKnight:isMoving() then
		return
	end

	self._lastPosX = self._scrollPanel:getPosX()

	self:moveKnight(self._myKnight, (cc.p(display.center.x + self._lastPosX, self._myKnight:getY())))

	if not self._checkBoxSchedule then
		self:checkGetBoxSchedule()

		self._checkBoxSchedule = self:newSchedule(handler(self, self.checkGetBoxSchedule), 0.1)
	end
end

function AllianceMainBgComp:refreshOtherKnight()
	for iter_14_0, iter_14_1 in pairs((var_0_2:getShowUserList())) do
		if not self._otherKnight[iter_14_0] then
			local var_14_0 = fgui.UIPackage:createObject("alliance", "AllianceMoveKnightComp")

			self._otherKnight[iter_14_0] = var_14_0

			self.m_boxRoot:addChild(var_14_0)
			var_14_0:setPosition(self._scrollPanel:getPosX() + math.random(self._left, display.width - self._right), self.m_moveComp:getY() + math.random(1, self.m_moveComp:getHeight() - 1))
		end

		local var_14_1 = var_0_4:getSnapShot(var_0_3.SNAP_SHOT_KEY.USER, iter_14_1)

		if var_14_1 then
			self._otherKnight[iter_14_0]:setShowKnight(var_14_1)
		end
	end

	self._isShowKnight = true

	if self._isShowBox then
		self:sortBoxRootIndex()
	end
end

function AllianceMainBgComp:scheduleKnightMove()
	local var_15_0 = self._otherKnight[math.random(1, #self._otherKnight)]

	if var_15_0 and not var_15_0:isMoving() then
		self:moveKnight(var_15_0, cc.p(math.random(self._left, self.m_moveComp:getWidth() - self._right), var_15_0:getY()), false)
	end
end

function AllianceMainBgComp:hideShowBox()
	self._isShowBox = false

	self.m_boxRoot:setVisible(false)
end

function AllianceMainBgComp:showBoxView()
	self.m_logComp:checkLog()

	if not var_0_2:canGetBoxInTime() then
		return
	end

	for iter_17_0, iter_17_1 in pairs(self._showBoxDict) do
		iter_17_1.comp:removeFromParent()
	end

	self._showBoxDict = {}

	local var_17_0 = var_0_2:getBoxData():getShowBoxList()
	local var_17_1 = self.m_moveComp:getWidth() - self._right
	local var_17_2 = self.m_moveComp:getY() + 120
	local var_17_3 = (self.m_moveComp:getHeight() - 120) / #var_17_0

	for iter_17_2, iter_17_3 in pairs(var_17_0) do
		local var_17_4 = fgui.GLoader:create()

		var_17_4:setTouchable(false)
		var_17_4:setAutoSize(true)
		var_17_4:setPivot(0.5, 1, true)
		var_17_4:setScale(1)
		var_17_4:setPosition(math.random(self._left, var_17_1), var_17_2 + math.random(var_17_3 * (iter_17_2 - 1), var_17_3))
		var_17_4:setURL(var_0_1:getAllianceBox128(iter_17_3.boxInfo.box_pic))
		self.m_boxRoot:addChild(var_17_4)

		self._showBoxDict[iter_17_2] = {
			comp = var_17_4,
			boxData = iter_17_3
		}
	end

	self:checkGetBoxSchedule()

	self._isShowBox = true

	if self._isShowKnight then
		self:sortBoxRootIndex()
	end

	self.m_boxRoot:setVisible(true)
end

function AllianceMainBgComp:sortBoxRootIndex()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(self.m_boxRoot:getChildren()) do
		table.insert(var_18_0, iter_18_1)
	end

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		return arg_19_0:getY() < arg_19_1:getY()
	end)

	for iter_18_2, iter_18_3 in ipairs(var_18_0) do
		iter_18_3:setSortingOrder(iter_18_2)
	end
end

function AllianceMainBgComp:updateEnterBtn()
	for iter_20_0, iter_20_1 in pairs(var_0_0.ENTER_BTN) do
		if self["m_" .. iter_20_0] then
			self["m_" .. iter_20_0]:setData(iter_20_1)
		end
	end

	self.m_announceComp:setTitle(var_0_2:getAllianceAnnounce(), false, true)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_hallBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_honorBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_battleBtn
	})
end

function AllianceMainBgComp:checkLevelUpUnlockBtn()
	for iter_21_0, iter_21_1 in pairs(var_0_0.ENTER_BTN) do
		if self["m_" .. iter_21_0] then
			self["m_" .. iter_21_0]:checkLevelUpUnlock(iter_21_1)
		end
	end
end

return AllianceMainBgComp
