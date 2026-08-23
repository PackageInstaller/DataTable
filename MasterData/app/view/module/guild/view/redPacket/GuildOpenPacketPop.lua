local var_0_0 = g.core.const.ConstMgr.GuildCommonConst
local GuildOpenPacketPop = class("GuildOpenPacketPop", require("app.fairyGUI.guild.UI_GuildOpenPacketPop"), function()
	return fgui.GComponent:create({
		resName = "GuildOpenPacketPop",
		pkgPath = "ui/guild/guild",
		pkgName = "guild"
	}, ...)
end)

function GuildOpenPacketPop:ctor(arg_2_1)
	self:showAtCenter()

	self._id = arg_2_1.id
	self._lastTouchPos = nil
	self._drawList = {}
	self._lightNode = nil
	self._realPoints = {}
	self._isFinish = false
	self._isOpen = false

	self.m_touchLayer:setSize(display.width, display.height)
	self.m_touchLayer:addClickListener(handler(self, self._onOpenPacketClick))

	self.m_backTransition = self:getView():getTransition("back")
	self.m_wordTransition = self:getView():getTransition("word")
	self.m_enterTransition = self:getView():getTransition("enter")
end

function GuildOpenPacketPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_PICK, handler(self, self._onPickPacketSuc), self)
	self:_initTouchRect()
	self:initRealPoints()
	self._renderTexture:setVisible(false)
	self.m_enterTransition:play()
	g.core.network.GameNetProxy:send_C2S_Guild_RedPacket_Pick({
		id = self._id
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.OPEN_REDPACKAGE_POP)
end

function GuildOpenPacketPop:initRealPoints()
	self._realPoints = {}

	local var_4_0 = math.floor(var_0_0.openPopParam.POINT_NUM / var_0_0.openPopParam.POINT_NUM_ONE_LINE)
	local var_4_1 = self:getView():getX() - var_0_0.openPopParam.REAL_WIDTH / 2
	local var_4_2 = display.height - self:getView():getY() + 34 - var_0_0.openPopParam.REAL_HEIGHT / 2

	for iter_4_0 = 1, var_0_0.openPopParam.POINT_NUM_ONE_LINE do
		for iter_4_1 = 1, var_4_0 do
			table.insert(self._realPoints, {
				isFinish = false,
				x = var_4_1 + iter_4_0 * (var_0_0.openPopParam.REAL_WIDTH / (var_0_0.openPopParam.POINT_NUM_ONE_LINE + 1)),
				y = var_4_2 + iter_4_1 * (var_0_0.openPopParam.REAL_HEIGHT / (var_4_0 + 1))
			})
		end
	end
end

function GuildOpenPacketPop:isInRange(arg_5_1, arg_5_2, arg_5_3)
	return arg_5_2 >= cc.pGetDistance(arg_5_1, arg_5_3)
end

function GuildOpenPacketPop:checkAllOpen(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self._realPoints) do
		iter_6_1.isFinish = iter_6_1.isFinish or self:isInRange(arg_6_1, var_0_0.openPopParam.CIRCLE_SIZE, cc.p(iter_6_1.x, iter_6_1.y))
	end

	for iter_6_2, iter_6_3 in ipairs(self._realPoints) do
		if not iter_6_3.isFinish then
			self._isFinish = false

			return
		end
	end

	self._isFinish = true
end

function GuildOpenPacketPop:onDrawScheduler(arg_7_1, arg_7_2, arg_7_3)
	if #self._drawList > 0 then
		for iter_7_0 = 1, 25 do
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

function GuildOpenPacketPop:checkAndOpen()
	if self._isOpen then
		return
	end

	self._isOpen = true

	self._renderTexture:setVisible(true)
	self.m_clickGroup:setVisible(false)
end

function GuildOpenPacketPop:_initTouchRect()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))

	self._renderTexture = cc.RenderTexture:create(display.width, display.height)

	self._renderTexture:setPosition(display.width / 2, display.height / 2)
	self._renderTexture:setCascadeOpacityEnabled(true)
	self:addNode(self._renderTexture)

	local var_9_0 = cc.Sprite:create("ui_cocos/redPackage/pic_bg_hb03_1.png")

	self:addNode(var_9_0)

	self._lightNode = var_9_0
	self._drawNode = cc.DrawNode:create()

	self._drawNode:drawPolygon(var_0_0.polygonPoints, #var_0_0.polygonPoints, cc.c4f(1, 1, 1, 1), 0, cc.c4f(1, 1, 1, 1))
	self._drawNode:setBlendFunc({
		src = GL_ONE,
		dst = GL_ZERO
	})
	self:addNode(self._drawNode)
	var_9_0:setPosition(self:getView():getX(), display.height - self:getView():getY() + 34)

	self._boundingBox = var_9_0:getBoundingBox()

	self._renderTexture:begin()
	var_9_0:visit()
	self._renderTexture:endToLua()
	var_9_0:setVisible(false)
	self._drawNode:setVisible(false)
end

function GuildOpenPacketPop:onEraserOnePoint(arg_10_1, arg_10_2)
	table.insert(self._drawList, {
		x = arg_10_1,
		y = arg_10_2
	})
end

function GuildOpenPacketPop:_onTouchBegin(arg_11_1)
	if self._isFinish then
		return
	end

	arg_11_1:captureTouch()

	local var_11_0 = arg_11_1:getInput():getPosition()

	self._lastTouchPos = var_11_0

	self:checkAndOpen()
	self:checkAndPlaySound(cc.p(var_11_0.x, display.height - var_11_0.y))
end

function GuildOpenPacketPop:checkAndPlaySound(arg_12_1)
	if cc.rectContainsPoint(self._boundingBox, arg_12_1) then
		if not self._isPlayingSound then
			self._isPlayingSound = true

			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SCRATCH_REAPACKAGE)
		end
	elseif self._isPlayingSound then
		self._isPlayingSound = false

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SCRATCH_REAPACKAGE_STOP)
	end
end

function GuildOpenPacketPop:_onTouchMove(arg_13_1)
	local var_13_0 = arg_13_1:getInput():getPosition()

	self:checkAndPlaySound(cc.p(var_13_0.x, display.height - var_13_0.y))
	self._drawNode:setVisible(true)

	if cc.pGetDistance(self._lastTouchPos, var_13_0) < var_0_0.openPopParam.DRAW_DES or not self._lastTouchPos then
		self._drawNode:setPosition(var_13_0.x - var_0_0.openPopParam.CIRCLE_SIZE, display.height - var_13_0.y - var_0_0.openPopParam.CIRCLE_SIZE)
		self:checkAllOpen(cc.p(var_13_0.x, display.height - var_13_0.y))
		self._renderTexture:begin()
		self._drawNode:visit()
		self._renderTexture:endToLua()

		self._lastTouchPos = var_13_0
	else
		self._lastTouchPos = cc.pAdd(self._lastTouchPos, cc.pMul(cc.pNormalize(cc.pSub(var_13_0, self._lastTouchPos)), var_0_0.openPopParam.DRAW_DES))

		self._drawNode:setPosition(self._lastTouchPos.x - var_0_0.openPopParam.CIRCLE_SIZE, display.height - self._lastTouchPos.y - var_0_0.openPopParam.CIRCLE_SIZE)
		self:checkAllOpen(cc.p(self._lastTouchPos.x, display.height - self._lastTouchPos.y))
		self._renderTexture:begin()
		self._drawNode:visit()
		self._renderTexture:endToLua()
	end

	self._drawNode:setVisible(false)
end

function GuildOpenPacketPop:_onTouchEnd(arg_14_1)
	self._lastTouchPos = nil

	if self._isFinish then
		self:onOpenFinish()
	end

	if self._isPlayingSound then
		self._isPlayingSound = false

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SCRATCH_REAPACKAGE_STOP)
	end
end

function GuildOpenPacketPop:_onOpenPacketClick()
	return
end

function GuildOpenPacketPop:_onPickPacketSuc(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if arg_16_4.ret == 1 then
		self.m_numTxt:setText(g.core.lang:get(109536, {
			num = arg_16_4.awards[1].size
		}))
		self.m_icon:setURL((g.core.common.Path:getIconByTypeValue(arg_16_4.awards[1].type, arg_16_4.awards[1].value, false)))
	else
		if arg_16_4.ret == 116 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109526))
		elseif arg_16_4.ret == 117 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109527))
		end

		g.core.network.GameNetProxy:send_C2S_Guild_RedPacket_Info({})
		g.core.module.ModuleManager:popComponent()
	end
end

function GuildOpenPacketPop:_showOpenAnim()
	self.m_wordTransition:play(handler(self, self._onSpineStart))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SCRAPE)
end

function GuildOpenPacketPop:_onSpineStart()
	self._panelEffect = self.m_spinePlaceHolder:addEffectSpine({
		anim = "play",
		name = "eff_ui_redpacket_ticket",
		isLoop = false,
		eventHandler = handler(self, self._onOpenPacket)
	})

	self._panelEffect:setAnchorPoint(0.5, 0.5)
	self.m_stateController:setSelectedIndex(1)
end

function GuildOpenPacketPop:_onOpenPacket()
	g.core.common.Scheduler:newScheduleOnce(handler(self, self._onShowDetail), 1)
end

function GuildOpenPacketPop:onOpenFinish()
	if self._renderTexture then
		self._renderTexture:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.RemoveSelf:create(), cc.CallFunc:create(function()
			self._renderTexture = nil
		end)))
		self._lightNode:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.RemoveSelf:create(), cc.CallFunc:create(function()
			self._lightNode = nil
		end)))
	end

	g.core.common.Scheduler:newScheduleOnce(handler(self, self._onShowDetail), 1)
end

function GuildOpenPacketPop:_onShowDetail()
	if self.m_backTransition then
		self.m_backTransition:play(handler(self, self._changePage))
	end
end

function GuildOpenPacketPop:_changePage()
	local var_24_0 = g.core.model.User.redPacketData:getPacketInfoById(self._id)

	g.core.module.ModuleManager:popComponent()

	if var_24_0 and var_24_0.base_id and var_24_0.base_id > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.guild.view.redPacket.GuildRedPacketInfoPop").new({
			id = self._id
		}), {
			touchDisappear = true
		})
	end
end

return GuildOpenPacketPop
