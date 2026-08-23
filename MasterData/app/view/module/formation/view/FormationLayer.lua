local var_0_0 = g.core.model.User
local var_0_1 = g.core.common.Path
local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_3 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_4 = g.core.model.User.formationData
local FormationLayer = class("FormationLayer", require("app.fairyGUI.formation.UI_FormationLayer"), function()
	return fgui.GComponent:create({
		resName = "FormationLayer",
		pkgPath = "ui/formation/formation",
		isFullScreen = true,
		pkgName = "formation"
	})
end)

FormationLayer.DRAG_MOVE_TAG = 200

function FormationLayer:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.title then
		self.m_topBar:setTitle(arg_2_1.title)
	end

	if arg_2_1 and arg_2_1.posHpList then
		self._posHpList = arg_2_1.posHpList
	end

	self._starPos = 0
	self._localPos = 0
	self._nextPos = 0
	self._skillPos = {}

	for iter_2_0, iter_2_1 in pairs((var_0_0.uniteTokenData:getLineupTokenList())) do
		if next(iter_2_1) then
			self._skillPos[iter_2_0] = true
		end
	end

	self._knightPos = {}

	for iter_2_2, iter_2_3 in pairs((var_0_0.knightsData:getFormationKnights())) do
		if iter_2_3 > 0 then
			self._knightPos[iter_2_2] = true
		end
	end

	self._knightComps = {}

	for iter_2_4 = 1, 6 do
		self._knightComps[iter_2_4] = self["m_knight" .. iter_2_4]

		self._knightComps[iter_2_4]:setPosIndex(iter_2_4)

		self._knightComps[iter_2_4].formation = iter_2_4

		if self._posHpList then
			self["m_knight" .. iter_2_4]:showPosHpBar(self._posHpList[iter_2_4])
		end
	end

	self.m_haloBtn:addClickListener(handler(self, self._onClickHaloPopBtn))
	self:addBg("bg/formation/pic_bz_beijing.jpg")
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_touchBg:addClickListener(handler(self, self._onHideChangeComp))
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_topBar:setResInfoById(75)
end

function FormationLayer:_onClickHaloPopBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.lineUp.view.haloPop.LineUpHaloPop").new(), {
		touchDisappear = true
	})
end

function FormationLayer:onLoad()
	fgui.DragDropManager:getInstance():getAgent():addEventListener(fgui.UIEventType.DragMove, handler(self, self._dragMoveKnight), FormationLayer.DRAG_MOVE_TAG)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEPOSITION, handler(self, self._recvChangePosition), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_INHERITFORMATION, handler(self, self._recvInheritFormation), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, self._onChangeFormation, self)
	self:updateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self.m_enterTransition:play(handler(self, self.onAnimEnd))
	self:_onHideChangeComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	self:updateLineUpHaloCount()
end

function FormationLayer:onAnimEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	self._waitEvent = false
end

function FormationLayer:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "FormationKnightComp_GuildDropEnd" then
		self:_onGuildDropEnd(arg_6_2.index)
	elseif arg_6_1 == "FormationKnightComp_GuildDropCancel" then
		self:_onGuildDropCancel()
	end
end

function FormationLayer:updateView()
	self:_updateKnight()
	self:_updateAssctNum()
	self.m_spComp:updateFormatInfo()
end

function FormationLayer:_updateKnight()
	self._knightData = g.core.model.User.knightsData:getFormation()

	for iter_8_0 = 1, 6 do
		local var_8_0 = self._knightComps[iter_8_0]
		local var_8_1 = self._knightData[iter_8_0]

		self._knightComps[iter_8_0]:setKnightId(self._knightData[iter_8_0])
		var_8_0:updateComp()

		if not self._init then
			var_8_0:setDraggable(true)
			var_8_0:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupKnight))
			var_8_0:addClickListener(handler(self, self._onClickKnight))
			self:addListen(var_8_0)
		end

		var_8_0:setTouchable(var_8_1 > 0)
	end

	self._init = true
end

function FormationLayer:_updateAssctNum()
	self.m_assctNum:setTitle((var_0_0.formationData:getAssctTotalCount()))
end

function FormationLayer:_onClickKnight(arg_10_1)
	local var_10_0 = arg_10_1:getSender()

	if self._knightData[var_10_0.formation] > 0 then
		local var_10_1 = var_10_0:getPosition()
		local var_10_2 = var_10_0:getScaleX()

		var_10_1.x = var_10_1.x + 125 * var_10_2
		var_10_1.y = var_10_1.y + 162 * var_10_2

		self.m_changeComp:setPosition(var_10_1)
		self.m_changeComp:setKnightId(self._knightData[var_10_0.formation])
		self.m_touchBg:setVisible(true)
	end
end

function FormationLayer:_onHideChangeComp()
	self.m_changeComp:setKnightId(0)
	self.m_touchBg:setVisible(false)
end

function FormationLayer:_dragLineupKnight(arg_12_1)
	self:_onHideChangeComp()

	self._isDragKnight = true

	arg_12_1:preventDefault()

	self._curComp = arg_12_1:getSender()

	self._curComp:hideKnight(true)

	self._starPos = self._curComp.formation
	self._localPos = self._starPos

	for iter_12_0 = 1, 6 do
		self._knightComps[iter_12_0]:checkTouchable(false)
	end

	if self._knightData[self._starPos] > 0 then
		local var_12_0 = fgui.DragDropManager:getInstance()

		var_12_0:startDrag("common/ui_cocos/lineUp/pic_touming.png", nil, (arg_12_1:getInput():getTouchId()))

		local var_12_1 = BattleKnight.new({
			breath = true,
			scale = 1.2,
			base = true,
			resId = g.core.model.User.knightsData:getKnight({
				id = self._knightData[self._starPos]
			}):getResInfo().fight_id
		})

		var_12_1:setScale(1.2)
		var_12_1:setName("knight")
		var_12_0:getAgent():displayObject():addChild(var_12_1)
		var_12_1:setPosition(50, 0)
		self:_updateKnightOpacity(204)
	end
end

function FormationLayer:_dragMoveKnight(arg_13_1)
	if not self._isDragKnight then
		return
	end

	local var_13_0 = arg_13_1:getInput():getTouch()

	if not var_13_0 then
		return
	end

	local var_13_1 = var_13_0:getLocation()

	var_13_1.y = var_13_1.y - 50

	local var_13_2 = false
	local var_13_3

	for iter_13_0 = 1, 6 do
		if self._knightComps[iter_13_0].m_imgPosTouch:hitTest(var_13_1, cc.Camera:create()) then
			var_13_2 = true

			if iter_13_0 ~= self._localPos then
				var_13_3 = iter_13_0
			end
		end
	end

	if var_13_3 then
		self._nextPos = var_13_3

		self:_updateExchangeKnight()
	elseif not var_13_2 then
		self._nextPos = self._starPos

		self:_updateExchangeKnight()
	end
end

function FormationLayer:_onTouchEnd(arg_14_1)
	if not self._isDragKnight then
		return
	end

	local var_14_0 = arg_14_1:getInput():getTouch()

	if not var_14_0 then
		return
	end

	self:_updateKnightOpacity(255)

	local var_14_1 = var_14_0:getLocation()

	var_14_1.y = var_14_1.y - 50

	if self._starPos ~= self._localPos then
		local var_14_2 = clone(g.core.model.User.knightsData:getPositions())

		for iter_14_0 = 1, #var_14_2 do
			if var_14_2[iter_14_0] == self._starPos then
				var_14_2[iter_14_0] = self._localPos
			elseif var_14_2[iter_14_0] == self._localPos then
				var_14_2[iter_14_0] = self._starPos
			end
		end

		g.core.network.GameNetProxy:send_C2S_Formation_ChangePosition({
			position = var_14_2
		})
		self._knightComps[self._localPos]:updateComp(self._knightData[self._starPos])
	elseif self._isDragKnight and self._curComp then
		self._curComp:updateComp(self._knightData[self._starPos])
	end

	local var_14_3 = fgui.DragDropManager:getInstance():getAgent()

	if var_14_3:displayObject():getChildByName("knight") then
		var_14_3:displayObject():removeChildByName("knight", true)
	end

	for iter_14_1 = 1, 6 do
		self._knightComps[iter_14_1]:setTouchable(self._knightData[iter_14_1] > 0)
	end

	self._isDragKnight = false
end

function FormationLayer:_onGuildDropEnd(arg_15_1)
	if not self._isDragKnight then
		return
	end

	self:_updateKnightOpacity(255)

	self._localPos = arg_15_1

	local var_15_0 = clone(g.core.model.User.knightsData:getPositions())

	for iter_15_0 = 1, #var_15_0 do
		if var_15_0[iter_15_0] == self._starPos then
			var_15_0[iter_15_0] = self._localPos
		elseif var_15_0[iter_15_0] == self._localPos then
			var_15_0[iter_15_0] = self._starPos
		end
	end

	g.core.network.GameNetProxy:send_C2S_Formation_ChangePosition({
		position = var_15_0
	})
	self._knightComps[self._localPos]:updateComp(self._knightData[self._starPos])

	local var_15_1 = fgui.DragDropManager:getInstance():getAgent()

	if var_15_1:displayObject():getChildByName("knight") then
		var_15_1:displayObject():removeChildByName("knight", true)
	end

	for iter_15_1 = 1, 6 do
		self._knightComps[iter_15_1]:setTouchable(self._knightData[iter_15_1] > 0)
	end

	self._isDragKnight = false
end

function FormationLayer:_onGuildDropCancel()
	if not self._isDragKnight then
		return
	end

	self:_updateKnightOpacity(255)

	if self._isDragKnight and self._curComp then
		self._curComp:updateComp(self._knightData[self._starPos])
	end

	if self._localPos ~= self._starPos then
		self._knightComps[self._localPos]:updateComp(self._knightData[self._localPos])

		self._localPos = 0
		self._starPos = 0
	end

	local var_16_0 = fgui.DragDropManager:getInstance():getAgent()

	if var_16_0:displayObject():getChildByName("knight") then
		var_16_0:displayObject():removeChildByName("knight", true)
	end

	for iter_16_0 = 1, 6 do
		self._knightComps[iter_16_0]:setTouchable(self._knightData[iter_16_0] > 0)
	end

	self._isDragKnight = false
end

function FormationLayer:_updateKnightOpacity(arg_17_1)
	for iter_17_0 = 1, 6 do
		self._knightComps[iter_17_0]:updateKnightOpacity(arg_17_1)
	end
end

function FormationLayer:_updateExchangeKnight()
	local var_18_0 = false

	if self._localPos ~= self._starPos then
		self._knightComps[self._localPos]:updateComp(self._knightData[self._localPos])

		var_18_0 = true
	end

	self._localPos = self._nextPos

	if self._localPos ~= self._starPos then
		self._knightComps[self._starPos]:updateComp(self._knightData[self._localPos])

		var_18_0 = true
	end

	if var_18_0 then
		self._knightComps[self._localPos]:setKnightId(self._knightData[self._starPos])
		self._knightComps[self._localPos]:hideKnight(true)
	end
end

function FormationLayer:_recvChangePosition()
	self:_updateKnight()

	self._starPos = 0
	self._localPos = 0

	g.core.module.ModuleManager:tip(g.core.lang:get(200006))
end

function FormationLayer:_onChangeFormation(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = 200006
	local var_20_1 = 0

	if arg_20_3.tp == 2 then
		self.m_spComp:refreshSkillComp()

		for iter_20_0, iter_20_1 in pairs((var_0_0.uniteTokenData:getLineupTokenList())) do
			if next(iter_20_1) and not self._skillPos[iter_20_0] then
				var_20_1 = var_20_1 + 1
				var_20_0 = 200007
				self._skillPos[iter_20_0] = true
			elseif not next(iter_20_1) and self._skillPos[iter_20_0] then
				var_20_1 = var_20_1 + 1
				var_20_0 = 200008
				self._skillPos[iter_20_0] = false
			end
		end
	elseif arg_20_3.tp == 1 then
		self:_updateAssctNum()

		local var_20_2 = arg_20_3.pos > var_0_3.LINEUP_MAX or arg_20_3.pos == 0

		self:_onHideChangeComp()
		self:_updateKnight()
		self.m_spComp:refreshPartnerComp()

		for iter_20_2, iter_20_3 in pairs((var_0_0.knightsData:getFormationKnights())) do
			if iter_20_3 > 0 and not self._knightPos[iter_20_2] then
				var_20_1 = var_20_1 + 1
				var_20_0 = var_20_2 and 200010 or 200007
				self._knightPos[iter_20_2] = true
			elseif iter_20_3 == 0 and self._knightPos[iter_20_2] then
				var_20_1 = var_20_1 + 1
				var_20_0 = 200008
				self._knightPos[iter_20_2] = false
			end
		end
	end

	g.core.module.ModuleManager:tip(g.core.lang:get((var_20_1 == 2 or nil) and 200006))
	self:updateLineUpHaloCount()
end

function FormationLayer:_recvInheritFormation(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(200013))
	self:_updateAssctNum()
	self:_updateKnight()
	self:_onHideChangeComp()
	self.m_spComp:refreshPartnerComp()

	for iter_21_0, iter_21_1 in pairs((var_0_0.knightsData:getFormationKnights())) do
		if iter_21_1 > 0 and not self._knightPos[iter_21_0] then
			self._knightPos[iter_21_0] = true
		elseif iter_21_1 == 0 and self._knightPos[iter_21_0] then
			self._knightPos[iter_21_0] = false
		end
	end

	self:updateLineUpHaloCount()

	if arg_21_4.award then
		g.core.module.ModuleManager:awardSummary(arg_21_4.award, false, nil, g.core.lang:get(200014))
	end
end

function FormationLayer:updateLineUpHaloCount()
	local var_22_0, var_22_1 = var_0_4:getCurrentGroupAndCnt()
	local var_22_2 = math.clamp(var_22_1, 0, 6)

	self.m_haloBtn:getChild("lineUpHaloBar"):setFillAmount(var_22_2 / 6)

	if var_22_0 == 0 then
		var_22_0 = var_0_4:getHaloGroupByCount(var_22_2)
	end

	var_22_0 = var_22_0 > 0 and var_22_0 or var_0_3.GROUP_TYPE.LIN_DONG

	local var_22_3 = self.m_haloBtn:getChild("haloImg")
	local var_22_4 = var_0_1:getCampURL(var_22_0, 4)
	local var_22_5 = self.m_haloBtn:getChild("effectHolder")

	var_22_5:removeAllEffect()

	if var_22_2 >= 6 then
		var_22_5:addEffectSpine({
			anim = "play2",
			name = "eff_ui_formation_gain",
			scale = 1,
			isLoop = true
		})

		var_22_4 = var_0_1:getCampActiveURL(var_22_0)
	elseif var_22_2 >= 2 then
		var_22_5:addEffectSpine({
			anim = "play1",
			name = "eff_ui_formation_gain",
			scale = 1,
			isLoop = true
		})
	end

	var_22_3:setURL(var_22_4)
end

function FormationLayer:_onShareClick()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self.m_shareComp:setVisible(false)

		return
	end

	self.m_shareComp:setVisible(false)
	self.m_topBar:setVisible(false)

	local var_23_0 = cc.utils:captureNode(self)

	var_23_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_23_0:release()
	self.m_shareComp:setVisible(true)
	self.m_topBar:setVisible(true)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_8
	})
end

function FormationLayer:onUnload()
	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end

	self._curComp = nil

	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, FormationLayer.DRAG_MOVE_TAG)
end

return FormationLayer
