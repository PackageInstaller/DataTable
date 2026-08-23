local var_0_0 = g.core.common.Path
local WorldRedPacketShowPop = require("app.view.module.worldRedPacket.view.WorldRedPacketShowPop")
local var_0_2 = g.core.const.ConstMgr.GuildCommonConst
local WorldRedPacketOpenPop = class("WorldRedPacketOpenPop", require("app.fairyGUI.worldRedPacket.UI_WorldRedPacketOpenPop"), function()
	return fgui.GComponent:create({
		resName = "WorldRedPacketOpenPop",
		pkgPath = "ui/worldRedPacket/worldRedPacket",
		pkgName = "worldRedPacket"
	}, ...)
end)

function WorldRedPacketOpenPop:ctor(arg_2_1)
	self._awardList = arg_2_1.awards
	self._detailData = arg_2_1.world_red_packet_detail
	self._lastTouchPos = nil
	self._drawList = {}
	self._lightNode = nil
	self._realPoints = {}
	self._isFinish = false
	self._isOpen = false
	self._isEnd = false

	self:showAtCenter()
	self:initView()
	self.m_touchLayer:setSize(display.width, display.height)
	self:_initTouchRect()
	self:initRealPoints()
	self.m_enterTransition:play()
end

function WorldRedPacketOpenPop:initView()
	self.m_icon:setURL(var_0_0:getIconByTypeValue(self._awardList[1].type, self._awardList[1].value))
	self.m_numTxt:setText(self._awardList[1].size)
end

function WorldRedPacketOpenPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_DETAIL, handler(self, self._onGetDetailData), self)
	self._renderTexture:setVisible(false)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.OPEN_REDPACKAGE_POP)
end

function WorldRedPacketOpenPop:initRealPoints()
	self._realPoints = {}

	local var_5_0 = math.floor(var_0_2.openPopParam.POINT_NUM / var_0_2.openPopParam.POINT_NUM_ONE_LINE)
	local var_5_1 = self:getView():getX() - var_0_2.openPopParam.REAL_WIDTH / 2
	local var_5_2 = display.height - self:getView():getY() + 34 - var_0_2.openPopParam.REAL_HEIGHT / 2

	for iter_5_0 = 1, var_0_2.openPopParam.POINT_NUM_ONE_LINE do
		for iter_5_1 = 1, var_5_0 do
			table.insert(self._realPoints, {
				isFinish = false,
				x = var_5_1 + iter_5_0 * (var_0_2.openPopParam.REAL_WIDTH / (var_0_2.openPopParam.POINT_NUM_ONE_LINE + 1)),
				y = var_5_2 + iter_5_1 * (var_0_2.openPopParam.REAL_HEIGHT / (var_5_0 + 1))
			})
		end
	end
end

function WorldRedPacketOpenPop:isInRange(arg_6_1, arg_6_2, arg_6_3)
	return arg_6_2 >= cc.pGetDistance(arg_6_1, arg_6_3)
end

function WorldRedPacketOpenPop:checkAllOpen(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self._realPoints) do
		iter_7_1.isFinish = iter_7_1.isFinish or self:isInRange(arg_7_1, var_0_2.openPopParam.CIRCLE_SIZE, cc.p(iter_7_1.x, iter_7_1.y))
	end

	for iter_7_2, iter_7_3 in ipairs(self._realPoints) do
		if not iter_7_3.isFinish then
			self._isFinish = false

			return
		end
	end

	self._isFinish = true
end

function WorldRedPacketOpenPop:onDrawScheduler(arg_8_1, arg_8_2, arg_8_3)
	if #self._drawList > 0 then
		for iter_8_0 = 1, 25 do
			table.remove(self._drawList, 1)
			self._drawNode:setPosition(self._drawList[1].x, self._drawList[1].y)
			self._drawNode:setVisible(true)
			self._renderTexture:begin()
			self._drawNode:visit()
			self._renderTexture:endToLua()
			self._drawNode:setVisible(false)

			if #self._drawList == 0 then
				return
			end
		end
	end
end

function WorldRedPacketOpenPop:checkAndOpen()
	if self._isOpen then
		return
	end

	self._isOpen = true

	self._renderTexture:setVisible(true)
	self.m_clickGroup:setVisible(false)
end

function WorldRedPacketOpenPop:_initTouchRect()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))

	self._renderTexture = cc.RenderTexture:create(display.width, display.height)

	self._renderTexture:setPosition(display.width / 2, display.height / 2)
	self._renderTexture:setCascadeOpacityEnabled(true)
	self:addNode(self._renderTexture)

	local var_10_0 = cc.Sprite:create("ui_cocos/redPackage/pic_bg_hb03_1.png")

	self:addNode(var_10_0)

	self._lightNode = var_10_0
	self._drawNode = cc.DrawNode:create()

	self._drawNode:drawPolygon(var_0_2.polygonPoints, #var_0_2.polygonPoints, cc.c4f(1, 1, 1, 1), 0, cc.c4f(1, 1, 1, 1))
	self._drawNode:setBlendFunc({
		src = GL_ONE,
		dst = GL_ZERO
	})
	self:addNode(self._drawNode)
	var_10_0:setPosition(self:getView():getX(), display.height - self:getView():getY() + 34)

	self._boundingBox = var_10_0:getBoundingBox()

	self._renderTexture:begin()
	var_10_0:visit()
	self._renderTexture:endToLua()
	var_10_0:setVisible(false)
	self._drawNode:setVisible(false)
end

function WorldRedPacketOpenPop:onEraserOnePoint(arg_11_1, arg_11_2)
	table.insert(self._drawList, {
		x = arg_11_1,
		y = arg_11_2
	})
end

function WorldRedPacketOpenPop:_onTouchBegin(arg_12_1)
	if self._isFinish then
		return
	end

	arg_12_1:captureTouch()

	local var_12_0 = arg_12_1:getInput():getPosition()

	self._lastTouchPos = var_12_0

	self:checkAndOpen()
	self:checkAndPlaySound(cc.p(var_12_0.x, display.height - var_12_0.y))
end

function WorldRedPacketOpenPop:checkAndPlaySound(arg_13_1)
	if cc.rectContainsPoint(self._boundingBox, arg_13_1) then
		if not self._isPlayingSound then
			self._isPlayingSound = true

			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SCRATCH_REAPACKAGE)
		end
	elseif self._isPlayingSound then
		self._isPlayingSound = false

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SCRATCH_REAPACKAGE_STOP)
	end
end

function WorldRedPacketOpenPop:_onTouchMove(arg_14_1)
	local var_14_0 = arg_14_1:getInput():getPosition()

	self:checkAndPlaySound(cc.p(var_14_0.x, display.height - var_14_0.y))
	self._drawNode:setVisible(true)

	if cc.pGetDistance(self._lastTouchPos, var_14_0) < var_0_2.openPopParam.DRAW_DES or not self._lastTouchPos then
		self._drawNode:setPosition(var_14_0.x - var_0_2.openPopParam.CIRCLE_SIZE, display.height - var_14_0.y - var_0_2.openPopParam.CIRCLE_SIZE)
		self:checkAllOpen(cc.p(var_14_0.x, display.height - var_14_0.y))
		self._renderTexture:begin()
		self._drawNode:visit()
		self._renderTexture:endToLua()

		self._lastTouchPos = var_14_0
	else
		self._lastTouchPos = cc.pAdd(self._lastTouchPos, cc.pMul(cc.pNormalize(cc.pSub(var_14_0, self._lastTouchPos)), var_0_2.openPopParam.DRAW_DES))

		self._drawNode:setPosition(self._lastTouchPos.x - var_0_2.openPopParam.CIRCLE_SIZE, display.height - self._lastTouchPos.y - var_0_2.openPopParam.CIRCLE_SIZE)
		self:checkAllOpen(cc.p(self._lastTouchPos.x, display.height - self._lastTouchPos.y))
		self._renderTexture:begin()
		self._drawNode:visit()
		self._renderTexture:endToLua()
	end

	self._drawNode:setVisible(false)
end

function WorldRedPacketOpenPop:_onTouchEnd(arg_15_1)
	self._lastTouchPos = nil

	if self._isFinish then
		self:onOpenFinish()
	end

	if self._isPlayingSound then
		self._isPlayingSound = false

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SCRATCH_REAPACKAGE_STOP)
	end
end

function WorldRedPacketOpenPop:_onOpenPacketClick()
	return
end

function WorldRedPacketOpenPop:_onGetDetailData(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self._detailData = arg_17_4.world_red_packet_detail

	if self._isEnd then
		self:openShowPop()
	end
end

function WorldRedPacketOpenPop:onOpenFinish()
	if self._renderTexture then
		self._renderTexture:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.RemoveSelf:create(), cc.CallFunc:create(function()
			self._renderTexture = nil
		end)))
		self._lightNode:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.RemoveSelf:create(), cc.CallFunc:create(function()
			self._lightNode = nil
		end)))
	end

	self:newScheduleOnce(handler(self, self._onShowDetail), 1)
end

function WorldRedPacketOpenPop:_onShowDetail()
	if self._isBacking then
		return
	end

	self._isBacking = true

	self.m_backTransition:play(handler(self, self._changePage))
end

function WorldRedPacketOpenPop:_changePage()
	self:openShowPop()
end

function WorldRedPacketOpenPop:openShowPop()
	g.core.module.ModuleManager:pushPopup(WorldRedPacketShowPop.new(self._detailData), {
		touchDisappear = true
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return WorldRedPacketOpenPop
