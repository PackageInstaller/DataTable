local var_0_0 = g.core.model.User
local var_0_1 = g.core.common.Path
local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_3 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_4 = g.core.model.User.formationData
local var_0_5 = g.core.model.User.knightsData
local var_0_6 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_7 = g.core.common.ModuleUnlock
local var_0_8 = g.core.module.ModuleManager
local FormationMainComp = class("FormationMainComp", require("app.fairyGUI.formation.UI_FormationMainComp"))
local var_0_10 = 202
local var_0_11 = "drag_knight"

function FormationMainComp:ctor()
	self._posHpList = nil
	self._knightComps = {}
	self._starPos = 0
	self._localPos = 0
	self._nextPos = 0
	self._skillPos = {}
	self._lineUpKnightDict = {}
	self._knightPosIdList = {}
	self._curComp = nil
	self._isDragKnight = false
	self._otherData = {}
	self._isOtherUser = false

	self:_initData()
	self:_initView()
	self:addListen(self.m_changeComp)
end

function FormationMainComp:_initData()
	for iter_2_0, iter_2_1 in pairs((var_0_0.uniteTokenData:getLineupTokenList())) do
		if next(iter_2_1) then
			self._skillPos[iter_2_0] = true
		end
	end

	self._knightPosIdList = var_0_5:getFormation()

	for iter_2_2, iter_2_3 in pairs((var_0_5:getFormationKnights())) do
		if iter_2_3 > 0 then
			self._lineUpKnightDict[iter_2_2] = true
		end
	end
end

function FormationMainComp:_initView()
	self.m_bottomComp:setSize(display.width, display.height)

	while self["m_knight" .. 1] do
		self["m_knight" .. 1]:setDraggable(true)
		self["m_knight" .. 1]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupKnight))
		self["m_knight" .. 1]:addClickListener(handler(self, self._onClickKnight))
		self:addListen(self["m_knight" .. 1])
		self["m_knight" .. 1]:setPosIndex(1)

		self["m_knight" .. 1].formation = 1

		if self._posHpList then
			self["m_knight" .. 1]:showPosHpBar(self._posHpList[1])
		end

		self._knightComps[1] = self["m_knight" .. 1]
	end

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_haloBtn:addClickListener(handler(self, self._onClickHaloPopBtn))
	self.m_assctNum:addClickListener(handler(self, self._onClickAssNum))
	self.m_touchBg:addClickListener(handler(self, self._onHideChangeComp))
	self.m_touchBg:setVisible(false)
end

function FormationMainComp:_onClickAssNum()
	var_0_8:pushPopup(require("app.view.module.tip.view.KnightAssctTip").new(nil, self._isOtherUser and self:getOtherAssList() or self:getUserSelfAssList()), {
		touchDisappear = true
	})
end

function FormationMainComp:getOtherAssList()
	if not self._otherData then
		return {}
	end

	local var_5_0 = {}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(self._otherData.knightStructArr or {}) do
		if next(iter_5_1) then
			table.insert(var_5_0, iter_5_1)

			var_5_1[iter_5_1:getAdvanceId()] = iter_5_1
		end
	end

	local var_5_2 = {}

	for iter_5_2, iter_5_3 in pairs(self._otherData.otherKnightStructTab or {}) do
		if next(iter_5_3) then
			var_5_2[iter_5_3:getAdvanceId()] = iter_5_3
		end
	end

	local var_5_3, var_5_4, var_5_5 = var_0_4:getAllActiveAssList(var_5_0, var_5_1, var_5_2)

	return var_5_5
end

function FormationMainComp:getUserSelfAssList()
	local var_6_0 = {}
	local var_6_1 = {}

	for iter_6_0 = 1, var_0_3.LINEUP_MAX do
		local var_6_2 = var_0_5:getKnight({
			pos = iter_6_0
		})

		if var_6_2 then
			table.insert(var_6_0, var_6_2)

			var_6_1[var_6_2:getAdvanceId()] = var_6_2
		end
	end

	local var_6_3 = {}

	for iter_6_1 = var_0_3.LINEUP_MAX, var_0_3.SHOW_PARTNER_NUM + var_0_3.LINEUP_MAX do
		local var_6_4 = var_0_5:getKnight({
			pos = iter_6_1
		})

		if var_6_4 then
			var_6_3[var_6_4:getAdvanceId()] = var_6_4
		end
	end

	local var_6_5, var_6_6, var_6_7 = var_0_4:getAllActiveAssList(var_6_0, var_6_1, var_6_3)

	return var_6_7
end

function FormationMainComp:_onClickHaloPopBtn()
	var_0_8:pushPopup(require("app.view.module.lineUp.view.haloPop.LineUpHaloPop").new((self._isOtherUser or nil) and {
		curCnt = self._otherData.groupInfo.count,
		group = self._otherData.groupInfo.group,
		knights = self._otherData.knightStructArr
	}), {
		touchDisappear = true
	})
end

function FormationMainComp:onLoad()
	fgui.DragDropManager:getInstance():getAgent():addEventListener(fgui.UIEventType.DragMove, handler(self, self._dragMoveKnight), var_0_10)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEPOSITION, handler(self, self._recvChangePosition), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_INHERITFORMATION, handler(self, self._recvInheritFormation), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, handler(self, self._onChangeFormation), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PET_INHERITFORMATION, handler(self, self.updatePetView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_MODIFYNAME, handler(self, self._onChangeMainName), self)
end

function FormationMainComp:updateView()
	if not var_0_4:isValidMainName() then
		g.core.network.GameNetProxy:send_C2S_Formation_ModifyName({
			name = var_0_4:getMainName()
		})
	end

	self:_updateKnight(true)
	self:_updateAssctNum()
	self:updateLineUpHaloCount()
	self:_onHideChangeComp()
	self:updateNameComp()
	self.m_bottomComp:updateComp()
end

function FormationMainComp:updateNameComp()
	if var_0_7:isModuleShow(var_0_6.FORMATION_PRE) then
		local var_10_0 = var_0_7:isModuleUnlock(var_0_6.FORMATION_PRE)

		self.m_isShowNameCompController:setSelectedIndex(1)
		self.m_nameComp:setIsUnlock(var_10_0)
		self.m_nameComp:updateComp(var_0_4:getMainName(), true)

		if var_10_0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
				tickType = 6,
				enum = g.core.const.ConstMgr.GuideConst.ENUM_TICK.PRE_FORMATION_MODULE_OPEN
			})
		end
	else
		self.m_isShowNameCompController:setSelectedIndex(0)
	end
end

function FormationMainComp:_updateKnight(arg_11_1)
	self._knightPosIdList = var_0_5:getFormation()

	for iter_11_0 = 1, #self._knightComps do
		local var_11_0 = self._knightComps[iter_11_0]
		local var_11_1 = self._knightPosIdList[iter_11_0] or 0

		var_11_0:setKnightId(var_11_1)
		var_11_0:updateComp()
		var_11_0:updateBottomShowState(false)
		var_11_0:setTouchable(var_11_1 > 0)

		if arg_11_1 then
			var_11_0:playInAnim()
		end

		local var_11_2 = var_0_5:getKnight({
			id = var_11_1
		})

		if var_11_2 then
			var_11_0:updateLevelAndRank(true, var_11_2:getLevel(), var_11_2:getAdvanceLevel())
		else
			var_11_0:updateLevelAndRank(false)
		end
	end
end

function FormationMainComp:updateKnightHp(arg_12_1)
	for iter_12_0 = 1, #self._knightComps do
		self._knightComps[iter_12_0]:showPosHpBar(arg_12_1[iter_12_0] or 0)
	end
end

function FormationMainComp:_updateAssctNum()
	self.m_assctNum:setTitle((var_0_4:getAssctTotalCount()))
end

function FormationMainComp:_onClickKnight(arg_14_1)
	local var_14_0 = arg_14_1:getSender()

	if self._isOtherUser then
		local var_14_1 = g.core.model.User.friendData:getPlayerInfo().formationData.knightStructArr

		if var_14_1[var_14_0.formation] then
			var_0_8:pushPopup((require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
				isOthers = true,
				knightStruct = var_14_1[var_14_0.formation],
				matchInfos = self._otherData.matchInfos[var_14_0.formation],
				knightPos = g.core.model.User.friendData:getPlayerInfo().formation.position[var_14_0.formation]
			})))
		end
	else
		local var_14_2 = self._knightPosIdList[var_14_0.formation] or 0

		if var_14_2 > 0 then
			local var_14_3 = var_14_0:getPosition()
			local var_14_4 = var_14_0:getScaleX()

			var_14_3.x = var_14_3.x + 125 * var_14_4
			var_14_3.y = var_14_3.y + 162 * var_14_4

			self.m_changeComp:setPosition(var_14_3)
			self.m_changeComp:setKnightId(var_14_2)
			self.m_touchBg:setVisible(true)
		end
	end
end

function FormationMainComp:_onHideChangeComp()
	self.m_changeComp:setKnightId(0)
	self.m_touchBg:setVisible(false)
end

function FormationMainComp:_dragLineupKnight(arg_16_1)
	self:_onHideChangeComp()

	self._isDragKnight = true

	arg_16_1:preventDefault()

	self._curComp = arg_16_1:getSender()

	self._curComp:hideKnight(true)

	self._starPos = self._curComp.formation
	self._localPos = self._starPos

	for iter_16_0 = 1, #self._knightComps do
		self._knightComps[iter_16_0]:checkTouchable(false)
		self._knightComps[iter_16_0]:updateLevelAndRank(false)
	end

	local var_16_0 = self._knightPosIdList[self._starPos] or 0

	if var_16_0 > 0 then
		local var_16_1 = arg_16_1:getInput()
		local var_16_2 = fgui.DragDropManager:getInstance()

		var_16_2.startDrag(var_16_1, "common/ui_cocos/lineUp/pic_touming.png", nil, (var_16_1:getTouchId()))

		local var_16_3 = BattleKnight.new({
			scale = 1.2,
			breath = true,
			base = true,
			resId = var_0_5:getKnight({
				id = var_16_0
			}):getResInfo().fight_id
		})

		var_16_3:setScale(1.2)
		var_16_3:setName(var_0_11)
		var_16_2:getAgent():displayObject():addChild(var_16_3)
		var_16_3:setPosition(50, 0)
		self:_updateKnightOpacity(204)
	end
end

function FormationMainComp:_dragMoveKnight(arg_17_1)
	if not self._isDragKnight then
		return
	end

	local var_17_0 = arg_17_1:getInput():getTouch()

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0:getLocation()

	var_17_1.y = var_17_1.y - 50

	local var_17_2 = false
	local var_17_3

	for iter_17_0 = 1, #self._knightComps do
		if self._knightComps[iter_17_0].m_imgPosTouch:hitTest(var_17_1, cc.Camera:create()) then
			var_17_2 = true

			if iter_17_0 ~= self._localPos then
				var_17_3 = iter_17_0
			end
		end
	end

	if var_17_3 then
		self._nextPos = var_17_3

		self:_updateExchangeKnight()
	elseif not var_17_2 then
		self._nextPos = self._starPos

		self:_updateExchangeKnight()
	end
end

function FormationMainComp:_onTouchBegin(arg_18_1)
	arg_18_1:captureTouch()
end

function FormationMainComp:_onTouchEnd(arg_19_1)
	if not self._isDragKnight then
		return
	end

	if not arg_19_1:getInput():getTouch() then
		return
	end

	self:_updateKnightOpacity(255)

	local var_19_0 = false

	if self._starPos ~= self._localPos then
		var_19_0 = true

		local var_19_1 = clone(var_0_5:getPositions())

		for iter_19_0 = 1, #var_19_1 do
			if var_19_1[iter_19_0] == self._starPos then
				var_19_1[iter_19_0] = self._localPos
			elseif var_19_1[iter_19_0] == self._localPos then
				var_19_1[iter_19_0] = self._starPos
			end
		end

		g.core.network.GameNetProxy:send_C2S_Formation_ChangePosition({
			position = var_19_1
		})
		self._knightComps[self._localPos]:updateComp(self._knightPosIdList[self._starPos] or 0)
	else
		var_19_0 = false

		if self._isDragKnight and self._curComp then
			self._curComp:updateComp(self._knightPosIdList[self._starPos] or 0)
		end
	end

	self:_clearMoveComp()

	for iter_19_1 = 1, #self._knightComps do
		local var_19_3 = self._knightPosIdList[iter_19_1] or 0

		self._knightComps[iter_19_1]:setTouchable(var_19_3 > 0)

		if not var_19_0 then
			local var_19_4 = var_0_5:getKnight({
				id = var_19_3
			})

			if var_19_4 then
				self._knightComps[iter_19_1]:updateLevelAndRank(true, var_19_4:getLevel(), var_19_4:getAdvanceLevel())
			else
				self._knightComps[iter_19_1]:updateLevelAndRank(false)
			end
		end
	end

	self._isDragKnight = false
end

function FormationMainComp:onGuildDropEnd(arg_20_1)
	if not self._isDragKnight then
		return
	end

	self:_updateKnightOpacity(255)

	self._localPos = arg_20_1

	local var_20_0 = clone(var_0_5:getPositions())

	for iter_20_0 = 1, #var_20_0 do
		if var_20_0[iter_20_0] == self._starPos then
			var_20_0[iter_20_0] = self._localPos
		elseif var_20_0[iter_20_0] == self._localPos then
			var_20_0[iter_20_0] = self._starPos
		end
	end

	g.core.network.GameNetProxy:send_C2S_Formation_ChangePosition({
		position = var_20_0
	})
	self._knightComps[self._localPos]:updateComp(self._knightPosIdList[self._starPos] or 0)
	self:_clearMoveComp()

	for iter_20_1 = 1, #self._knightComps do
		self._knightComps[iter_20_1]:setTouchable((self._knightPosIdList[iter_20_1] or 0) > 0)
	end

	self._isDragKnight = false
end

function FormationMainComp:onGuildDropCancel()
	if not self._isDragKnight then
		return
	end

	self:_updateKnightOpacity(255)

	if self._isDragKnight and self._curComp then
		self._curComp:updateComp(self._knightPosIdList[self._starPos] or 0)
	end

	if self._localPos ~= self._starPos then
		self._knightComps[self._localPos]:updateComp(self._knightPosIdList[self._localPos] or 0)

		self._localPos = 0
		self._starPos = 0
	end

	self:_clearMoveComp()

	for iter_21_0 = 1, #self._knightComps do
		self._knightComps[iter_21_0]:setTouchable((self._knightPosIdList[iter_21_0] or 0) > 0)
	end

	self._isDragKnight = false
end

function FormationMainComp:_clearMoveComp()
	local var_22_0 = fgui.DragDropManager:getInstance():getAgent()

	if var_22_0:displayObject():getChildByName(var_0_11) then
		var_22_0:displayObject():removeChildByName(var_0_11, true)
	end
end

function FormationMainComp:_updateKnightOpacity(arg_23_1)
	for iter_23_0 = 1, #self._knightComps do
		self._knightComps[iter_23_0]:updateKnightOpacity(arg_23_1)
	end
end

function FormationMainComp:_updateExchangeKnight()
	local var_24_0 = false

	if self._localPos ~= self._starPos then
		self._knightComps[self._localPos]:updateComp(self._knightPosIdList[self._localPos] or 0)

		var_24_0 = true
	end

	self._localPos = self._nextPos

	if self._localPos ~= self._starPos then
		self._knightComps[self._starPos]:updateComp(self._knightPosIdList[self._localPos] or 0)

		var_24_0 = true
	end

	if var_24_0 then
		self._knightComps[self._localPos]:setKnightId(self._knightPosIdList[self._starPos] or 0)
		self._knightComps[self._localPos]:hideKnight(true)
	end
end

function FormationMainComp:_recvChangePosition()
	self:_updateKnight()

	self._starPos = 0
	self._localPos = 0

	var_0_8:tip(g.core.lang:get(200006))
end

function FormationMainComp:_onChangeMainName()
	self:updateNameComp()
end

function FormationMainComp:_onChangeFormation(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = 200006
	local var_27_1 = 0

	if arg_27_4.tp == 2 then
		for iter_27_0, iter_27_1 in pairs((var_0_0.uniteTokenData:getLineupTokenList())) do
			if next(iter_27_1) and not self._skillPos[iter_27_0] then
				var_27_1 = var_27_1 + 1
				var_27_0 = 200007
				self._skillPos[iter_27_0] = true
			elseif not next(iter_27_1) and self._skillPos[iter_27_0] then
				var_27_1 = var_27_1 + 1
				var_27_0 = 200008
				self._skillPos[iter_27_0] = false
			end
		end

		self.m_bottomComp:updateUniteView()
	elseif arg_27_4.tp == 1 then
		self:_updateAssctNum()

		local var_27_2 = arg_27_4.pos > var_0_3.LINEUP_MAX or arg_27_4.pos == 0

		self:_onHideChangeComp()
		self:_updateKnight()

		for iter_27_2, iter_27_3 in pairs((var_0_5:getFormationKnights())) do
			if iter_27_3 > 0 and not self._lineUpKnightDict[iter_27_2] then
				var_27_1 = var_27_1 + 1
				var_27_0 = var_27_2 and 200010 or 200007
				self._lineUpKnightDict[iter_27_2] = true
			elseif iter_27_3 == 0 and self._lineUpKnightDict[iter_27_2] then
				var_27_1 = var_27_1 + 1
				var_27_0 = 200008
				self._lineUpKnightDict[iter_27_2] = false
			end
		end

		self.m_bottomComp:updatePartnerView()
	elseif arg_27_4.tp == 6 then
		var_27_0 = 200007

		self.m_bottomComp:updatePetView()
	end

	var_0_8:tip(g.core.lang:get((var_27_1 == 2 or nil) and 200006))
	self:updateLineUpHaloCount()
end

function FormationMainComp:_recvInheritFormation(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	var_0_8:tip(g.core.lang:get(200013))
	self:_updateAssctNum()
	self:_updateKnight()
	self:_onHideChangeComp()

	for iter_28_0, iter_28_1 in pairs((var_0_5:getFormationKnights())) do
		if iter_28_1 > 0 and not self._lineUpKnightDict[iter_28_0] then
			self._lineUpKnightDict[iter_28_0] = true
		elseif iter_28_1 == 0 and self._lineUpKnightDict[iter_28_0] then
			self._lineUpKnightDict[iter_28_0] = false
		end
	end

	self:updateLineUpHaloCount()
	self.m_bottomComp:updatePartnerView()

	if arg_28_4.award then
		var_0_8:awardSummary(arg_28_4.award, false, nil, g.core.lang:get(200014))
	end
end

function FormationMainComp:updateLineUpHaloCount()
	local var_29_0, var_29_1 = var_0_4:getCurrentGroupAndCnt()

	self:_updateHaloView(var_29_0, var_29_1)
end

function FormationMainComp:onUnload()
	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end

	self._curComp = nil

	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, var_0_10)
end

function FormationMainComp:updatePetView()
	self.m_bottomComp:updatePetView()
end

function FormationMainComp:_updateHaloView(arg_32_1, arg_32_2)
	arg_32_2 = math.clamp(arg_32_2, 0, 6)

	self.m_haloBtn:getChild("lineUpHaloBar"):setFillAmount(arg_32_2 / 6)

	arg_32_1 = arg_32_1 > 0 and arg_32_1 or var_0_3.GROUP_TYPE.LIN_DONG

	local var_32_0 = self.m_haloBtn:getChild("haloImg")
	local var_32_1 = var_0_1:getCampURL(arg_32_1, 4)
	local var_32_2 = self.m_haloBtn:getChild("effectHolder")

	var_32_2:removeAllEffect()

	if arg_32_2 >= 6 then
		var_32_2:addEffectSpine({
			anim = "play2",
			isLoop = true,
			name = "eff_ui_formation_gain",
			scale = 1
		})

		var_32_1 = var_0_1:getCampActiveURL(arg_32_1)
	elseif arg_32_2 >= 2 then
		var_32_2:addEffectSpine({
			anim = "play1",
			isLoop = true,
			name = "eff_ui_formation_gain",
			scale = 1
		})
	end

	var_32_0:setURL(var_32_1)
end

function FormationMainComp:receiveCompEvent(arg_33_1, arg_33_2)
	if arg_33_1 == "ChangeKnight" then
		var_0_8:pushModule(g.view.entrance.LINE_UP_CHOOSE, {
			index = var_0_4:getKnightPositionBySid(arg_33_2.knightId),
			knightSid = self._knightId
		})
	elseif arg_33_1 == "LookKnight" then
		var_0_8:pushModule(g.view.entrance.LINE_UP, {
			index = var_0_4:getKnightPositionBySid(arg_33_2.knightSid) - 1
		})
	end
end

function FormationMainComp:updateOtherUser(arg_34_1)
	self._isOtherUser = true
	self._otherData = arg_34_1

	local var_34_0 = arg_34_1.knightStructArr or {}

	for iter_34_0 = 1, var_0_3.LINEUP_MAX do
		local var_34_1 = self["m_knight" .. iter_34_0]
		local var_34_2 = var_34_0[iter_34_0]

		self["m_knight" .. iter_34_0]:setDraggable(false)
		var_34_1:updateCompByStruct(var_34_2)
		var_34_1:setTouchable(var_34_2 ~= nil)

		if var_34_2 then
			var_34_1:updateLevelAndRank(true, var_34_2:getLevel(), var_34_2:getAdvanceLevel())
		else
			var_34_1:updateLevelAndRank(false)
		end
	end

	self.m_assctNum:setTitle(arg_34_1.totalAssct)
	self:_updateHaloView(self._otherData.groupInfo.group, self._otherData.groupInfo.count)
	self.m_nameComp:setVisible(false)
	self.m_bottomComp:updateOther(arg_34_1)
end

function FormationMainComp:setBottomHideSuccuba(arg_35_1)
	self.m_bottomComp:setSuccubaHide(arg_35_1)
end

return FormationMainComp
