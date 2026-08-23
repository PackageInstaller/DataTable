local var_0_0 = g.core.config.multi_team_formation_info
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_4 = g.core.const.ConstMgr.LineUpConst
local var_0_5 = g.core.const.ConstMgr.BASE_CONST.DRAG_TAG.BASE_MUL_FORMATION
local var_0_6 = "CompEventFormationChanged"
local var_0_7 = g.core.model.User.artifactData
local var_0_8 = g.core.module.ModuleManager
local var_0_9 = g.core.model.User.mulFormationData
local var_0_10 = g.core.common.Goods
local var_0_11 = g.core.lang
local var_0_12 = g.core.model.User.knightsData
local BlazingArenaFormationComp = class("BlazingArenaFormationComp", require("app.fairyGUI.blazingArena.UI_BlazingArenaFormationComp"))

function BlazingArenaFormationComp:ctor()
	self._formationType = nil
	self._placeCellStartDragStationPos = 0
	self._petStartDragStationPos = 0
	self._uniteTokenStartDragStationPos = 0
	self._succubaStartDragStationPos = 0
	self._isDragArtifact = false
	self._triggeredDropEvent = false
	self._updateAllRedPoint = true
	self._saveSchedule = nil
	self._group = 0
	self._mulFormationStruct = nil
	self._mulFormationInfo = nil
	self._placeCellArr = self:_getPlaceCellArr()

	self:_addListeners()
	self:initPlaceLock()
	self:initBottom()
	self.m_uniteBtn:setRedPointId(465)
	self.m_petBtn:setRedPointId(468)
	self.m_succubaBtn:setRedPointId(504)
end

function BlazingArenaFormationComp:initPlaceLock()
	for iter_2_0, iter_2_1 in ipairs(self._placeCellArr) do
		iter_2_1:setLockUrl("ui://blazingArena/pic_bljt_huanwei")
	end
end

function BlazingArenaFormationComp:initBottom()
	self.m_petBtn:setVisible((var_0_2:isModuleUnlock(var_0_1.FUNCTION_TYPE.PET)))
	self.m_succubaBtn:setVisible((var_0_2:isModuleUnlock(var_0_1.FUNCTION_TYPE.SUCCUBA)))
end

function BlazingArenaFormationComp:addBgByName()
	self:addBg("bg/formation/bg_bz_wenli.png", false, nil, 1)
end

function BlazingArenaFormationComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, handler(self, self._onS2CFormationGet), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._onS2CFormationSave), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_FIGHTVALUE, handler(self, self._onS2CFormationFightValue), self)
	self:_sendC2SFormationGet()
	self.m_enterTransition:play()
end

function BlazingArenaFormationComp:onUnload()
	local var_6_0 = self._mulFormationStruct:getFormationType()

	if var_0_9:isModified(var_6_0) then
		var_0_9:resetFormationStruct(var_6_0)
	end

	local var_6_1 = fgui.DragDropManager:getInstance():getAgent()

	var_6_1:removeEventListener(fgui.UIEventType.DragMove, var_0_5)
	var_6_1:removeEventListener(fgui.UIEventType.DragEnd, var_0_5)
end

function BlazingArenaFormationComp:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "CompEventClickKnight" then
		if not self._mulFormationStruct:canLineUpKnight() and not self._mulFormationStruct:isStationPosLineupKnight(arg_7_2) then
			g.core.module.ModuleManager:tip(g.core.lang:get(431426))
		else
			self:_onClickPlaceCellKnightIcon(arg_7_2, self._mulFormationInfo.knight_group)
		end
	elseif arg_7_1 == "CompEventClickArtifact" then
		self:_onClickPlaceCellArtifactIcon(arg_7_2)
	elseif arg_7_1 == "FormationPreUsagePop_Preset_Select" then
		self:_onUsePreformationKnights(arg_7_2.ids)
	else
		return false
	end
end

function BlazingArenaFormationComp:updateComp(arg_8_1, arg_8_2)
	self._updateAllRedPoint = true
	self._formationType = arg_8_1
	self._mulFormationStruct = var_0_9:getFormationStruct(arg_8_1, arg_8_2)

	assert(self._mulFormationStruct, "Error! BlazingArenaFormationComp:updateComp invalide funcId, index: ", arg_8_1, arg_8_2)

	self._mulFormationInfo = var_0_0.get(arg_8_1)

	self._mulFormationStruct:refreshFixedAttr()
	self:setGroupType()
	self:setReadFormationBtnVisible(self._mulFormationInfo.if_reserve == 1)
	self:_updateComp()
	self:_sendC2SFormationGet()
end

function BlazingArenaFormationComp:sendC2SFormationSave()
	self._saveSchedule = nil

	local var_9_0 = self._mulFormationStruct:getFormationType()

	if not self._mulFormationStruct then
		return false
	elseif not var_0_9:isModified(var_9_0) then
		return false
	end

	local var_9_1

	if var_9_0 == var_0_4.MulTeamType.BLAZING_ARENA and not g.core.model.User.blazingArenaData:isFormationValid() then
		do return false end

		var_9_1 = {
			tp = var_9_0
		}
	end

	var_9_1.formations = var_0_9:getOutBaseFormationArr(var_9_0)

	g.core.network.GameNetProxy:send_C2S_Formation_Save(var_9_1)

	return true
end

function BlazingArenaFormationComp:_onS2CFormationGet()
	self:_updateComp()
	self:refreshAllRedPoint()
end

function BlazingArenaFormationComp:_onS2CFormationSave()
	self:_updateFightValue()

	if self._formationType == var_0_4.MulTeamType.BLAZING_ARENA then
		self:_updateComp()
		self:refreshAllRedPoint()
	end
end

function BlazingArenaFormationComp:_onS2CFormationFightValue()
	self.m_powerTxt:setText(self._mulFormationStruct:getFightValue())
	self:unSaveSchedule()
end

function BlazingArenaFormationComp:_onPlaceCellDragStart(arg_13_1)
	self._triggeredDropEvent = false

	arg_13_1:preventDefault()
	arg_13_1:stopPropagation()

	local var_13_0 = arg_13_1:getSender()
	local var_13_1 = arg_13_1:getInput()

	if var_13_0.m_artifactComp:containPoint((var_13_1:getTouch():getLocation())) then
		if var_13_0.m_artifactComp:isEmpty() then
			self._placeCellStartDragStationPos = 0

			return
		else
			self._isDragArtifact = true
			self._placeCellStartDragStationPos = var_13_0.m_artifactComp:getStationPos()

			var_13_0.m_artifactComp:onDragStart()

			local var_13_2 = fgui.DragDropManager:getInstance()

			var_13_2:startDrag(var_13_0.m_artifactComp:getResourceURL(), self._placeCellStartDragStationPos, var_13_1:getTouchId())

			local var_13_3 = var_13_2:getAgent()
			local var_13_4 = var_13_3:getComponent()

			var_13_4:bindLua(var_13_4:getRemark())
			var_13_4:becomeTo(var_13_0.m_artifactComp)
			var_13_3:addEventListener(fgui.UIEventType.DragMove, handler(self, self._onPlaceCellDragMove), var_0_5)
			var_13_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPlaceCellDragEnd), var_0_5)
		end
	elseif var_13_0.m_knightComp:isEmpty() then
		self._placeCellStartDragStationPos = 0

		return
	else
		self._isDragArtifact = false
		self._placeCellStartDragStationPos = var_13_0:getStationPos()

		var_13_0:onDragStart()

		local var_13_5 = fgui.DragDropManager:getInstance()

		var_13_5:startDrag(var_13_0:getResourceURL(), self._placeCellStartDragStationPos, var_13_1:getTouchId())

		local var_13_6 = var_13_5:getAgent()
		local var_13_7 = var_13_6:getComponent()

		var_13_7:bindLua(var_13_7:getRemark())
		var_13_7:becomeTo(var_13_0)
		var_13_6:addEventListener(fgui.UIEventType.DragMove, handler(self, self._onPlaceCellDragMove), var_0_5)
		var_13_6:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPlaceCellDragEnd), var_0_5)
	end
end

function BlazingArenaFormationComp:_onPlaceCellDrop(arg_14_1)
	if self._placeCellStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	local var_14_0 = self._mulFormationStruct
	local var_14_1 = arg_14_1:getSender()
	local var_14_2 = var_14_1:getStationPos()

	if self._isDragArtifact then
		if self._mulFormationStruct:isStationPosLineupKnight(var_14_2) then
			local var_14_3 = var_14_0:getArtifactSid(self._placeCellStartDragStationPos)
			local var_14_4 = var_0_12:getKnight({
				id = var_14_0:getKnightSid(var_14_2)
			})

			if var_14_4 and not var_0_7:getArtifactBySid(var_14_3):checkWearKnight(var_14_4:getAdvanceId()) then
				g.core.module.ModuleManager:tip(g.core.lang:get(205539))
				self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(var_14_0)
				var_14_1:playDropAni()

				return
			end

			local var_14_5 = var_0_7:getArtifactBySid((var_14_0:getArtifactSid(var_14_2)))

			if var_14_5 then
				local var_14_6 = var_0_12:getKnight({
					id = var_14_0:getKnightSid(self._placeCellStartDragStationPos)
				})

				if var_14_6 and not var_14_5:checkWearKnight(var_14_6:getAdvanceId()) then
					g.core.module.ModuleManager:tip(g.core.lang:get(205539))
					self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(var_14_0)
					var_14_1:playDropAni()

					return
				end
			end

			var_14_0:lineupArtifact(var_14_2, var_14_3)
			self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(var_14_0)
			var_14_1.m_artifactComp:updateComp(var_14_0)
			var_14_1:playDropAni()
		else
			var_0_8:tip(var_0_11:get(200041))
			self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:onDragEnd()
			self._placeCellArr[self._placeCellStartDragStationPos]:playDropAni()
			var_14_1:playHoveringAni(false)

			return
		end
	else
		var_14_0:lineupKnight(var_14_2, (var_14_0:getKnightSid(self._placeCellStartDragStationPos)))
		self._placeCellArr[self._placeCellStartDragStationPos]:updateCell(var_14_0)
		self._placeCellArr[self._placeCellStartDragStationPos].m_knightComp:playKnightLineupAni()
		var_14_1:updateCell(var_14_0)
		var_14_1:playDropAni()
		var_14_1.m_knightComp:playKnightLineupAni()
		self:_checkAndUpdateLockPlaceCell()
		self:_updateLeaderGain()
	end

	self:_updateFightValue(var_0_4.FRESH.KNIGHT)
	self:dispatchCompEvent(var_0_6, {
		(var_14_0:getFormationIdx())
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TURN_CARD_SUCCESS)
end

function BlazingArenaFormationComp:_onPlaceCellDragMove(arg_15_1)
	local var_15_0 = arg_15_1:getInput():getTouch():getLocation()

	for iter_15_0, iter_15_1 in ipairs(self._placeCellArr) do
		iter_15_1:playHoveringAni((iter_15_1:containPoint(var_15_0)))
	end
end

function BlazingArenaFormationComp:_onPlaceCellDragEnd(arg_16_1)
	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, var_0_5)

	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._placeCellStartDragStationPos = 0

		return
	end

	local var_16_0 = self._placeCellStartDragStationPos

	self._placeCellStartDragStationPos = 0

	local var_16_1 = self._placeCellArr[var_16_0]

	if self._isDragArtifact then
		self._mulFormationStruct:lineupArtifact(var_16_0, 0)
	else
		self._mulFormationStruct:lineupKnight(var_16_0, 0)
		self:_updateLeaderGain()
	end

	self:_checkAndUpdateLockPlaceCell()
	self:_updateFightValue(var_0_4.FRESH.KNIGHT)
	var_16_1:onDragEnd()
end

function BlazingArenaFormationComp:_onPetCompDragStart(arg_17_1)
	self._triggeredDropEvent = false

	arg_17_1:preventDefault()
	arg_17_1:stopPropagation()

	local var_17_0 = arg_17_1:getSender()

	if var_17_0:isEmpty() then
		self._petStartDragStationPos = 0
	else
		local var_17_1 = var_17_0:getStationPos()

		self._petStartDragStationPos = var_17_1

		var_17_0:onDragStart()

		local var_17_2 = fgui.DragDropManager:getInstance()

		var_17_2:startDrag(var_17_0:getResourceURL(), var_17_1, (arg_17_1:getInput():getTouchId()))

		local var_17_3 = var_17_2:getAgent()
		local var_17_4 = var_17_3:getComponent()

		var_17_4:bindLua("app.view.base.component.BaseMulTeamFormationPetComp")
		var_17_4:becomeTo(var_17_0)
		var_17_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPetCompDragEnd), var_0_5)
	end
end

function BlazingArenaFormationComp:_onPetCompDrop(arg_18_1)
	if self._petStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	self._mulFormationStruct:lineupPet(arg_18_1:getSender():getStationPos(), (self._mulFormationStruct:getPetSid(self._petStartDragStationPos)))
	self:_updatePetList()
	self:_updateFightValue(var_0_4.FRESH.PET)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BlazingArenaFormationComp:_onPetCompDragEnd(arg_19_1)
	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._petStartDragStationPos = 0

		return
	end

	local var_19_0 = self._petStartDragStationPos

	self._petStartDragStationPos = 0

	self._mulFormationStruct:lineupPet(var_19_0, 0)
	self.m_petList:getChildAt(var_19_0 - 1):updateComp(var_19_0, 0, self._mulFormationStruct and self._mulFormationStruct:getMulIndex())
	self:_updateFightValue(var_0_4.FRESH.PET)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BlazingArenaFormationComp:_onUniteTokenCompDragStart(arg_20_1)
	self._triggeredDropEvent = false

	arg_20_1:preventDefault()
	arg_20_1:stopPropagation()

	local var_20_0 = arg_20_1:getSender()

	if var_20_0:isEmpty() then
		self._uniteTokenStartDragStationPos = 0
	else
		local var_20_1 = var_20_0:getStationPos()

		self._uniteTokenStartDragStationPos = var_20_1

		var_20_0:onDragStart()

		local var_20_2 = fgui.DragDropManager:getInstance()

		var_20_2:startDrag(var_20_0:getResourceURL(), var_20_1, (arg_20_1:getInput():getTouchId()))

		local var_20_3 = var_20_2:getAgent()
		local var_20_4 = var_20_3:getComponent()

		var_20_4:bindLua("app.view.base.component.BaseMulTeamFormationUniteTokenComp")
		var_20_4:becomeTo(var_20_0)
		var_20_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onUniteTokenCompDragEnd), var_0_5)
	end
end

function BlazingArenaFormationComp:_onUniteTokenCompDrop(arg_21_1)
	if self._uniteTokenStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	self._mulFormationStruct:lineupUniteToken(arg_21_1:getSender():getStationPos(), (self._mulFormationStruct:getUniteTokenSid(self._uniteTokenStartDragStationPos)))
	self:_updateUniteList()
	self:_updateFightValue(var_0_4.FRESH.UNITE)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BlazingArenaFormationComp:_onUniteTokenCompDragEnd(arg_22_1)
	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._uniteTokenStartDragStationPos = 0

		return
	end

	local var_22_0 = self._uniteTokenStartDragStationPos

	self._uniteTokenStartDragStationPos = 0

	self._mulFormationStruct:lineupUniteToken(var_22_0, 0)
	self.m_uniteTokenList:getChildAt(var_22_0 - 1):updateComp(var_22_0, 0, self._mulFormationStruct and self._mulFormationStruct:getMulIndex())
	self:_updateFightValue(var_0_4.FRESH.UNITE)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BlazingArenaFormationComp:_onSuccubaCompDragStart(arg_23_1)
	self._triggeredDropEvent = false

	arg_23_1:preventDefault()
	arg_23_1:stopPropagation()

	local var_23_0 = arg_23_1:getSender()

	if var_23_0:isEmpty() then
		self._succStartDragStationPos = 0
	else
		local var_23_1 = var_23_0:getStationPos()

		self._succStartDragStationPos = var_23_1

		var_23_0:onDragStart()

		local var_23_2 = fgui.DragDropManager:getInstance()

		var_23_2:startDrag(var_23_0:getResourceURL(), var_23_1, (arg_23_1:getInput():getTouchId()))

		local var_23_3 = var_23_2:getAgent()
		local var_23_4 = var_23_3:getComponent()

		var_23_4:bindLua("app.view.base.component.BaseMulTeamFormationSuccubaComp")
		var_23_4:becomeTo(var_23_0)
		var_23_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onSuccubaCompDragEnd), var_0_5)
	end
end

function BlazingArenaFormationComp:_onSuccubaCompDrop(arg_24_1)
	if self._succStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	local var_24_0 = arg_24_1:getSender()

	var_24_0:onDragEnd()
	self._mulFormationStruct:lineupSuccuba(var_24_0:getStationPos(), (self._mulFormationStruct:getSuccubaSid(self._succStartDragStationPos)))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA)
	self.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BlazingArenaFormationComp:_onSuccubaCompDragEnd(arg_25_1)
	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._succStartDragStationPos = 0

		return
	end

	local var_25_0 = self._succStartDragStationPos

	self._succStartDragStationPos = 0

	local var_25_1 = self.m_succubaList:getChildAt(var_25_0 - 1)

	self._mulFormationStruct:lineupSuccuba(var_25_0, 0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA)
	var_25_1:updateComp(var_25_0, 0, self._mulFormationStruct and self._mulFormationStruct:getMulIndex())
	var_25_1:onDragEnd()
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BlazingArenaFormationComp:_onClickLeaderGainComp(arg_26_1)
	if not self._mulFormationStruct then
		return
	end

	local var_26_0, var_26_1 = self._mulFormationStruct:getLeaderGainTV()

	var_0_8:pushPopup(require("app.view.module.lineUp.view.haloPop.LineUpHaloPop").new({
		group = var_26_0,
		curCnt = var_26_1,
		knights = table.values((self._mulFormationStruct:getKnightDict()))
	}), {
		touchDisappear = true
	})
end

function BlazingArenaFormationComp:_onClickReadFormationBtn()
	if not self._mulFormationStruct then
		return
	end

	local var_27_0 = require("app.view.module.formation.pre.FormationPreUsagePop").new({
		type = var_0_1.FormationConst.POP_TYPE.MYTEAM
	})

	self:addListen(var_27_0)
	var_0_8:pushPopup(var_27_0, {
		touchDisappear = true
	})
end

function BlazingArenaFormationComp:_onPetListRenderer(arg_28_1, arg_28_2)
	arg_28_2:setFormationType(self._mulFormationStruct:getFormationType())
	arg_28_2:updateComp(arg_28_1 + 1, self._mulFormationStruct:getPetSid(arg_28_1 + 1), self._mulFormationStruct:getMulIndex(), self._mulFormationStruct:getFormationType())

	if var_0_2:isModuleUnlock(var_0_3["PET_LINE_UP_" .. arg_28_1 + 1]) then
		if arg_28_2:hasEventListener(fgui.UIEventType.DragStart) then
			-- block empty
		else
			arg_28_2:setDraggable(true)
			arg_28_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onPetCompDragStart))
			arg_28_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onPetCompDrop))
		end
	else
		arg_28_2:setDraggable(false)
	end
end

function BlazingArenaFormationComp:_onUniteTokenListRenderer(arg_29_1, arg_29_2)
	arg_29_2:setFormationType(self._mulFormationStruct:getFormationType())
	arg_29_2:updateComp(arg_29_1 + 1, self._mulFormationStruct:getUniteTokenSid(arg_29_1 + 1), self._mulFormationStruct:getMulIndex())

	if arg_29_2:hasEventListener(fgui.UIEventType.DragStart) then
		-- block empty
	else
		arg_29_2:setDraggable(true)
		arg_29_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onUniteTokenCompDragStart))
		arg_29_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onUniteTokenCompDrop))
	end
end

function BlazingArenaFormationComp:_onSuccubaListRenderer(arg_30_1, arg_30_2)
	arg_30_2:setFormationType(self._mulFormationStruct:getFormationType())
	arg_30_2:updateComp(arg_30_1 + 1, self._mulFormationStruct:getSuccubaSid(arg_30_1 + 1), self._mulFormationStruct:getMulIndex(), self._mulFormationStruct:getFormationType())
	arg_30_2:resetCompAlpha()
	arg_30_2:checkRedPoint({
		formationType = self._mulFormationStruct:getFormationType(),
		formationIndex = self._mulFormationStruct:getMulIndex()
	})

	if var_0_2:isModuleUnlock(var_0_3.SUCCUBA) then
		if arg_30_2:hasEventListener(fgui.UIEventType.DragStart) then
			-- block empty
		else
			arg_30_2:setDraggable(true)
			arg_30_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onSuccubaCompDragStart))
			arg_30_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onSuccubaCompDrop))
		end
	else
		arg_30_2:setDraggable(false)
	end
end

function BlazingArenaFormationComp:_onClickPlaceCellKnightIcon(arg_31_1, arg_31_2)
	local var_31_0 = self._mulFormationStruct:getFormationType()
	local var_31_1 = self._mulFormationStruct:getFormationIdx()
	local var_31_2 = self._mulFormationStruct:getKnightSid(arg_31_1)
	local var_31_3 = self._placeCellArr[arg_31_1]
	local var_31_4

	var_31_4 = require("app.view.base.infoPop.lineup.CommonLineUpKnightPop").new({
		isFilter = true,
		itemUrl = "ui://infoPop/MulFormationLineupKnightCell",
		allList = var_0_9:getAllLineUpKnight(self._formationType, {
			group = arg_31_2
		}),
		group = arg_31_2,
		isLineUpCall = function(self)
			return var_0_9:isKnightLineup(var_31_0, self:getServerId())
		end,
		clickCheckFunc = handler(self, function(arg_33_0, arg_33_1)
			local var_33_0 = arg_33_1:getServerId()

			if not arg_33_0._mulFormationStruct:canLineUpKnight(arg_31_1, var_33_0) then
				var_0_8:tip(var_0_11:get(431401))

				return
			end

			if not arg_33_0._mulFormationStruct:isKnightLineUp(var_33_0) and arg_33_1:isElementLeader() then
				for iter_33_0, iter_33_1 in pairs(arg_33_0._mulFormationStruct:getKnightDict()) do
					if iter_33_0 ~= arg_31_1 and iter_33_1:isElementLeader() then
						var_0_8:tip(var_0_11:get(200051))

						return false
					end
				end
			end

			if arg_33_0._mulFormationStruct:isKnightLineUp(var_33_0) then
				if var_33_0 == var_31_2 then
					var_0_8:tip(var_0_11:get(200004))

					return false
				else
					arg_33_0._mulFormationStruct:lineupKnight(arg_31_1, var_33_0)
					arg_33_0:_updatePlaceCells()
					var_31_3.m_knightComp:playKnightLineupAni()
					arg_33_0:dispatchCompEvent(var_0_6, {
						var_31_1
					})

					return true
				end
			elseif var_0_9:isKnightLineup(var_31_0, var_33_0) then
				local var_33_1 = var_0_9:getFormationStructKnightLineup(var_31_0, var_33_0)
				local var_33_2 = var_33_1:getFormationIdx()

				var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_11:get(200028, {
						name = var_0_11:get(103028),
						num = var_31_1
					}),
					itemDataArr = {
						{
							type = var_0_10.TYPE_KNIGHT,
							value = arg_33_1:getBaseId(),
							teamName = var_0_11:get(200027, {
								num = var_33_2
							})
						}
					},
					onConfirm = handler(arg_33_0, function()
						var_33_1:takeOffKnight(var_33_0)
						arg_33_0._mulFormationStruct:lineupKnight(arg_31_1, var_33_0)
						var_31_3:updateCell(arg_33_0._mulFormationStruct)
						arg_33_0:_checkAndUpdateLockPlaceCell()
						var_31_3.m_knightComp:playKnightLineupAni()
						arg_33_0:_updateLeaderGain()
						arg_33_0:_updateFightValue(var_0_4.FRESH.KNIGHT)
						arg_33_0:dispatchCompEvent(var_0_6, {
							var_31_1,
							var_33_2
						})
						var_0_8:onlyPopSelfByDisplay(var_31_4)
					end)
				}))

				return false
			else
				arg_33_0._mulFormationStruct:lineupKnight(arg_31_1, var_33_0)
				var_31_3:updateCell(arg_33_0._mulFormationStruct)
				var_31_3.m_knightComp:playKnightLineupAni()
				arg_33_0:_updateLeaderGain()
				arg_33_0:_updateFightValue(var_0_4.FRESH.KNIGHT)
				arg_33_0:_checkAndUpdateLockPlaceCell()
				arg_33_0:dispatchCompEvent(var_0_6, {
					var_31_1
				})

				return true
			end
		end),
		cellParam = {
			formationType = var_31_0
		}
	})

	var_0_8:pushPopup(nil, {
		blackOpacity = 0.5,
		touchDisappear = false,
		ignoreTouch = false
	})
end

function BlazingArenaFormationComp:_onClickPlaceCellArtifactIcon(arg_35_1)
	if not self._mulFormationStruct:isStationPosLineupKnight(arg_35_1) then
		var_0_8:tip(var_0_11:get(200041))

		return
	end

	local var_35_0 = self._mulFormationStruct:getFormationType()
	local var_35_1 = self._mulFormationStruct:getFormationIdx()
	local var_35_2 = self._mulFormationStruct:getArtifactSid(arg_35_1)
	local var_35_3 = var_0_12:getKnightById((self._mulFormationStruct:getKnightSid(arg_35_1)))
	local var_35_4 = var_35_3 and var_35_3:getAdvanceId()
	local var_35_5

	var_35_5 = require("app.view.base.infoPop.lineup.CommonLineUpArtifactPop").new({
		isFilter = true,
		itemUrl = "ui://infoPop/MulFormationLineupArtifactCell",
		allList = var_0_9:getAllLineUpArtifact(self._formationType),
		isLineUpCall = function(self)
			return var_0_9:isArtifactLineup(var_35_0, self:getServerOnlyId())
		end,
		clickCheckFunc = handler(self, function(arg_37_0, arg_37_1)
			if not arg_37_1:checkWearKnight(var_35_4) then
				g.core.module.ModuleManager:tip(g.core.lang:get(205539))

				return false
			end

			local var_37_0 = arg_37_1:getServerOnlyId()

			if arg_37_0._mulFormationStruct:isArtifactLineUp(var_37_0) then
				if var_37_0 == var_35_2 then
					var_0_8:tip(var_0_11:get(200030))

					return false
				else
					local var_37_1 = var_0_7:getArtifactBySid(var_35_2)

					if var_37_1 then
						local var_37_2 = var_0_12:getKnight({
							id = arg_37_0._mulFormationStruct:getKnightSid((arg_37_0._mulFormationStruct:getArtifactStationPos(var_37_0)))
						})

						if var_37_2 and not var_37_1:checkWearKnight(var_37_2:getAdvanceId()) then
							g.core.module.ModuleManager:tip(g.core.lang:get(205539))

							return false
						end
					end

					arg_37_0._mulFormationStruct:lineupArtifact(arg_35_1, var_37_0)
					arg_37_0:_updatePlaceCells()
					arg_37_0:dispatchCompEvent(var_0_6, {
						var_35_1
					})

					return true
				end
			elseif var_0_9:isArtifactLineup(var_35_0, var_37_0) then
				local var_37_3 = var_0_9:getFormationStructArtifactLineup(var_35_0, var_37_0)
				local var_37_4 = var_0_7:getArtifactBySid(var_35_2)

				if var_37_4 then
					local var_37_5 = var_0_12:getKnight({
						id = var_37_3:getKnightSid((var_37_3:getArtifactStationPos(var_37_0)))
					})

					if var_37_5 and not var_37_4:checkWearKnight(var_37_5:getAdvanceId()) then
						g.core.module.ModuleManager:tip(g.core.lang:get(205539))

						return false
					end
				end

				local var_37_6 = var_37_3:getFormationIdx()

				var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_11:get(200028, {
						name = var_0_11:get(103032),
						num = arg_37_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_10.TYPE_ARTIFACT,
							value = arg_37_1:getArtifactBaseId(),
							teamName = var_0_11:get(200027, {
								num = var_37_6
							})
						}
					},
					onConfirm = handler(arg_37_0, function()
						var_37_3:takeOffArtifact(var_37_0)
						arg_37_0._mulFormationStruct:lineupArtifact(arg_35_1, var_37_0)
						arg_37_0._placeCellArr[arg_35_1]:updateCell(arg_37_0._mulFormationStruct)
						arg_37_0:_updateFightValue(var_0_4.FRESH.ARTIFACT)
						arg_37_0:_checkAndUpdateLockPlaceCell()
						arg_37_0:dispatchCompEvent(var_0_6, {
							var_35_1,
							var_37_6
						})
						var_0_8:onlyPopSelfByDisplay(var_35_5)
					end)
				}))

				return false
			else
				arg_37_0._mulFormationStruct:lineupArtifact(arg_35_1, var_37_0)
				arg_37_0._placeCellArr[arg_35_1]:updateCell(arg_37_0._mulFormationStruct)
				arg_37_0:_checkAndUpdateLockPlaceCell()
				arg_37_0:_updateFightValue(var_0_4.FRESH.ARTIFACT)
				arg_37_0:dispatchCompEvent(var_0_6, {
					var_35_1
				})

				return true
			end
		end),
		isRelated = function(self)
			return self:getBelongToKnightAvdIdIncludingMainRole() == var_35_4
		end,
		cellParam = {
			formationType = var_35_0,
			pos = self._mulFormationStruct:getKnightPosByStationPos(arg_35_1),
			knightAdvId = var_35_4
		}
	})

	var_0_8:pushPopup(nil, {
		blackOpacity = 0.5,
		touchDisappear = false,
		ignoreTouch = false
	})
end

function BlazingArenaFormationComp:_onClickPetListItem(arg_40_1)
	local var_40_0 = arg_40_1:getDataValue() + 1

	if not var_0_2:isModuleUnlock(var_0_3["PET_LINE_UP_" .. var_40_0]) then
		local var_40_1, var_40_2 = var_0_2:getModuleUnlockLevelAndComment(var_0_3["PET_LINE_UP_" .. var_40_0])

		var_0_8:tip(var_0_11:get(202514, {
			level = var_40_1
		}))

		return
	end

	local var_40_3 = self._mulFormationStruct:getFormationType()
	local var_40_4 = self._mulFormationStruct:getFormationIdx()
	local var_40_5 = self._mulFormationStruct:getPetSid(var_40_0)
	local var_40_6
	local var_40_8 = {
		isFilter = true,
		itemUrl = "ui://infoPop/MulFormationLineupPetCell",
		allList = var_0_9:getAllLineUpPet(self._formationType),
		isLineUpCall = function(self)
			return var_0_9:isPetLineup(var_40_3, self:getSid(), self:getCfg().advance_id)
		end,
		clickCheckFunc = handler(self, function(arg_42_0, arg_42_1)
			local var_42_0 = arg_42_1:getSid()
			local var_42_1 = arg_42_1:getCfg().advance_id

			if not arg_42_0._mulFormationStruct:canLineUpPet(var_40_0, var_42_0) then
				var_0_8:tip(var_0_11:get(431405))

				return
			end

			local var_42_2 = arg_42_0._mulFormationStruct:isPetLineUp(var_42_0)

			if var_42_2 or arg_42_0._mulFormationStruct:isPetLineUpByAdvanceId(var_42_1) then
				if var_42_2 and var_42_0 == var_40_5 then
					var_0_8:tip(var_0_11:get(200031))

					return false
				else
					if arg_42_0._formationType == var_0_4.MulTeamType.BLAZING_ARENA and not arg_42_1:isOwn() then
						if arg_42_0:doBorrow(var_40_0, g.core.common.Goods.TYPE_PET, arg_42_1:getCfg().id) then
							arg_42_0._mulFormationStruct:takeOffPet(var_42_0, var_42_1)
						end

						return true
					end

					arg_42_0._mulFormationStruct:takeOffPet(var_42_0, var_42_1)
					arg_42_0._mulFormationStruct:lineupPet(var_40_0, var_42_0, var_42_1)
					arg_42_0:_updatePetList()
					arg_42_0:_updateFightValue(var_0_4.FRESH.PET)
					arg_42_0:dispatchCompEvent(var_0_6, {
						var_40_4
					})

					return true
				end
			elseif var_0_9:isPetLineup(var_40_3, var_42_0, var_42_1) then
				local var_42_3 = var_0_9:getFormationStructPetLineup(var_40_3, var_42_0, var_42_1)
				local var_42_4 = var_42_3:getFormationIdx()

				var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_11:get(200028, {
						name = var_0_11:get(103034),
						num = arg_42_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_10.TYPE_PET,
							value = arg_42_1:getCfg().id,
							teamName = var_0_11:get(200027, {
								num = var_42_4
							})
						}
					},
					onConfirm = handler(arg_42_0, function()
						var_42_3:takeOffPet(var_42_0, var_42_1)

						if arg_42_0._formationType == var_0_4.MulTeamType.BLAZING_ARENA and not arg_42_1:isOwn() then
							arg_42_0:doBorrow(var_40_0, g.core.common.Goods.TYPE_PET, arg_42_1:getCfg().id)
						else
							arg_42_0._mulFormationStruct:lineupPet(var_40_0, var_42_0)
							arg_42_0:_updatePetList()
							arg_42_0:_updateFightValue(var_0_4.FRESH.PET)
						end

						arg_42_0:dispatchCompEvent(var_0_6, {
							var_40_4,
							var_42_4
						})
						var_0_8:onlyPopSelfByDisplay(var_40_6)
					end)
				}))

				return false
			else
				if arg_42_0._formationType == var_0_4.MulTeamType.BLAZING_ARENA and (not arg_42_1:isOwn() or arg_42_1:getSource() == g.core.const.ConstMgr.BlazingArenaConst.SOURCE_TYPE) then
					return arg_42_0:doBorrow(var_40_0, g.core.common.Goods.TYPE_PET, arg_42_1:getCfg().id)
				end

				arg_42_0._mulFormationStruct:lineupPet(var_40_0, var_42_0)
				arg_42_0:_updatePetList()
				arg_42_0:_updateFightValue(var_0_4.FRESH.PET)
				arg_42_0:dispatchCompEvent(var_0_6, {
					var_40_4
				})

				return true
			end
		end),
		cellParam = {
			formationType = var_40_3
		}
	}

	if self._formationType == var_0_4.MulTeamType.BLAZING_ARENA then
		var_40_8.topTabInfo = {
			var_0_11:get(431411),
			var_0_11:get(431412)
		}

		local var_40_9 = self:_getBorrowTipTxt(g.core.common.Goods.TYPE_PET)

		function var_40_8:topTabSwitchListener(arg_44_1)
			self.m_otherTipTxt:setText(var_40_9)
			self.m_otherTipTxt:setVisible(arg_44_1 == 1)
		end
	end

	var_40_6 = require("app.view.base.infoPop.lineup.CommonLineUpPetPop").new(var_40_8)

	var_0_8:pushPopup(var_40_6, {
		blackOpacity = 0.5,
		touchDisappear = false,
		ignoreTouch = false
	})
end

function BlazingArenaFormationComp:_onClickUniteTokenListItem(arg_45_1)
	local var_45_0 = arg_45_1:getDataValue() + 1
	local var_45_1 = self._mulFormationStruct:getFormationType()
	local var_45_2 = self._mulFormationStruct:getFormationIdx()
	local var_45_3 = self._mulFormationStruct:getUniteTokenSid(var_45_0)
	local var_45_4
	local var_45_6 = {
		isFilter = true,
		itemUrl = "ui://infoPop/MulFormationLineupUniteTokenCell",
		allList = var_0_9:getAllLineUpUnite(self._formationType),
		isLineUpCall = function(self)
			local var_46_0 = self:getServerId()
			local var_46_1 = self:getRealServerId()

			return var_0_9:isUniteTokenLineup(var_45_1, (var_46_1 and var_46_1 > 0 or nil) and var_46_1)
		end,
		clickCheckFunc = handler(self, function(arg_47_0, arg_47_1)
			local var_47_0 = arg_47_1:getServerId()
			local var_47_1 = arg_47_1:getRealServerId()

			if var_47_1 > 0 then
				var_47_0 = var_47_1
			end

			if not arg_47_0._mulFormationStruct:canLineUpUniteToken(var_45_0, var_47_0) then
				var_0_8:tip(var_0_11:get(431404))

				return
			end

			if arg_47_0._mulFormationStruct:isUniteTokenLineUp(var_47_0) then
				if var_47_0 == var_45_3 then
					var_0_8:tip(var_0_11:get(200032))

					return false
				else
					if arg_47_0._formationType == var_0_4.MulTeamType.BLAZING_ARENA and not arg_47_1:isOwn() then
						return arg_47_0:doBorrow(var_45_0, g.core.common.Goods.TYPE_UNITETOKEN, arg_47_1:getBaseId())
					end

					arg_47_0._mulFormationStruct:lineupUniteToken(var_45_0, var_47_0)
					arg_47_0:_updateUniteList()
					arg_47_0:_updateFightValue(var_0_4.FRESH.UNITE)
					arg_47_0:dispatchCompEvent(var_0_6, {
						var_45_2
					})

					return true
				end
			elseif var_0_9:isUniteTokenLineup(var_45_1, var_47_0) then
				local var_47_2 = var_0_9:getFormationStructUniteTokenLineup(var_45_1, var_47_0)
				local var_47_3 = var_47_2:getFormationIdx()

				var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_11:get(200028, {
						name = var_0_11:get(103031),
						num = arg_47_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_10.TYPE_UNITETOKEN,
							value = arg_47_1:getBaseId(),
							teamName = var_0_11:get(200027, {
								num = var_47_3
							})
						}
					},
					onConfirm = handler(arg_47_0, function()
						var_47_2:takeOffUniteToken(var_47_0)

						if arg_47_0._formationType == var_0_4.MulTeamType.BLAZING_ARENA and not arg_47_1:isOwn() then
							arg_47_0:doBorrow(var_45_0, g.core.common.Goods.TYPE_UNITETOKEN, arg_47_1:getBaseId())
						else
							arg_47_0._mulFormationStruct:lineupUniteToken(var_45_0, var_47_0)
							arg_47_0:_updateUniteList()
							arg_47_0:_updateFightValue(var_0_4.FRESH.UNITE)
						end

						arg_47_0:dispatchCompEvent(var_0_6, {
							var_45_2,
							var_47_3
						})
						var_0_8:onlyPopSelfByDisplay(var_45_4)
					end)
				}))

				return false
			else
				if arg_47_0._formationType == var_0_4.MulTeamType.BLAZING_ARENA and not arg_47_1:isOwn() then
					return arg_47_0:doBorrow(var_45_0, g.core.common.Goods.TYPE_UNITETOKEN, arg_47_1:getBaseId())
				end

				arg_47_0._mulFormationStruct:lineupUniteToken(var_45_0, var_47_0)
				arg_47_0:_updateUniteList()
				arg_47_0:_updateFightValue(var_0_4.FRESH.UNITE)
				arg_47_0:dispatchCompEvent(var_0_6, {
					var_45_2
				})

				return true
			end
		end),
		cellParam = {
			formationType = var_45_1
		}
	}

	if self._formationType == var_0_4.MulTeamType.BLAZING_ARENA then
		var_45_6.topTabInfo = {
			var_0_11:get(431411),
			var_0_11:get(431412)
		}

		local var_45_7 = self:_getBorrowTipTxt(g.core.common.Goods.TYPE_UNITETOKEN)

		function var_45_6:topTabSwitchListener(arg_49_1)
			self.m_otherTipTxt:setText(var_45_7)
			self.m_otherTipTxt:setVisible(arg_49_1 == 1)
		end
	end

	var_45_4 = require("app.view.base.infoPop.lineup.CommonLineUpUnitePop").new(var_45_6)

	var_0_8:pushPopup(var_45_4, {
		blackOpacity = 0.5,
		touchDisappear = false,
		ignoreTouch = false
	})
end

function BlazingArenaFormationComp:_onUsePreformationKnights(arg_50_1)
	local var_50_0 = self._mulFormationStruct:getFormationType()
	local var_50_1 = self._mulFormationStruct:getFormationIdx()
	local var_50_2 = {
		var_50_1
	}
	local var_50_3 = {}

	for iter_50_0, iter_50_1 in pairs(arg_50_1) do
		local var_50_4 = var_0_9:getFormationStructKnightLineup(var_50_0, iter_50_1)

		if var_50_4 and var_50_4 ~= self._mulFormationStruct then
			local var_50_5 = var_50_4:getFormationIdx()

			table.insert(var_50_2, var_50_5)

			local var_50_6 = var_0_12:getKnightById(iter_50_1)

			table.insert(var_50_3, {
				type = var_0_10.TYPE_KNIGHT,
				value = var_50_6:getBaseId(),
				teamName = var_0_11:get(200027, {
					num = var_50_5
				})
			})
		end
	end

	if #var_50_3 > 0 then
		var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
			desc = var_0_11:get(200028, {
				name = var_0_11:get(103028),
				num = var_50_1
			}),
			itemDataArr = var_50_3,
			onConfirm = handler(self, function()
				var_0_9:replaceAllKnights(self._mulFormationStruct, arg_50_1)
				self:_updatePlaceCells(true)
				self:dispatchCompEvent(var_0_6, var_50_2)
			end)
		}))
	else
		self._mulFormationStruct:replaceAllKnights(arg_50_1)
		self:_updatePlaceCells(true)
		self:dispatchCompEvent(var_0_6, var_50_2)
	end
end

function BlazingArenaFormationComp:_onClickSuccubaListItem(arg_52_1)
	local var_52_0 = arg_52_1:getDataValue() + 1

	if not var_0_2:isModuleUnlock(var_0_3.SUCCUBA) then
		local var_52_1, var_52_2 = var_0_2:getModuleUnlockLevelAndComment(var_0_3.SUCCUBA)

		var_0_8:tip(var_0_11:get(202514, {
			level = var_52_1
		}))

		return
	end

	local var_52_3 = self._mulFormationStruct:getFormationType()
	local var_52_4 = self._mulFormationStruct:getFormationIdx()
	local var_52_5 = self._mulFormationStruct:getSuccubaSid(var_52_0)
	local var_52_6

	var_52_6 = require("app.view.base.infoPop.lineup.CommonLineUpSuccubaPop").new({
		isFilter = true,
		itemUrl = "ui://infoPop/CommonLineUpSuccubaCell",
		allList = var_0_9:getAllLineUpSuccuba(self._formationType),
		isLineUpCall = function(self)
			return var_0_9:isSuccubaLineUp(var_52_3, self:getSid())
		end,
		clickCheckFunc = handler(self, function(arg_54_0, arg_54_1)
			local var_54_0 = arg_54_1:getSid()

			if arg_54_0._mulFormationStruct:isSuccubaLineUp(var_54_0) then
				if var_54_0 == var_52_5 then
					var_0_8:tip(var_0_11:get(431044))

					return false
				else
					arg_54_0._mulFormationStruct:lineupSuccuba(var_52_0, var_54_0)
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA)
					arg_54_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
					arg_54_0:dispatchCompEvent(var_0_6, {
						var_52_4
					})

					return true
				end
			elseif var_0_9:isSuccubaLineUp(var_52_3, var_54_0) then
				local var_54_1 = var_0_9:getFormationStructSuccubaLineup(var_52_3, var_54_0)
				local var_54_2 = var_54_1:getFormationIdx()

				var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_11:get(200028, {
						name = var_0_11:get(103041),
						num = arg_54_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_10.TYPE_SUCCUBA,
							value = arg_54_1:getCurCfg().id,
							teamName = var_0_11:get(200027, {
								num = var_54_2
							})
						}
					},
					onConfirm = handler(arg_54_0, function()
						var_54_1:takeOffSuccuba(var_54_0)
						arg_54_0._mulFormationStruct:lineupSuccuba(var_52_0, var_54_0)
						g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA)
						arg_54_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
						arg_54_0:dispatchCompEvent(var_0_6, {
							var_52_4,
							var_54_2
						})
						var_0_8:onlyPopSelfByDisplay(var_52_6)
					end)
				}))

				return false
			else
				arg_54_0._mulFormationStruct:lineupSuccuba(var_52_0, var_54_0)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA)
				arg_54_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
				arg_54_0:dispatchCompEvent(var_0_6, {
					var_52_4
				})

				return true
			end
		end),
		cellParam = {
			formationType = var_52_3
		}
	})

	var_0_8:pushPopup(nil, {
		blackOpacity = 0.5,
		touchDisappear = false,
		ignoreTouch = false
	})
end

function BlazingArenaFormationComp:_sendC2SFormationGet()
	if not self._mulFormationStruct then
		self:refreshAllRedPoint()
	else
		local var_56_0 = self._mulFormationStruct:getFormationType()

		if var_0_9:isInitWithSvrData(var_56_0) then
			self:refreshAllRedPoint()
		else
			g.core.network.GameNetProxy:send_C2S_Formation_Get({
				tp = var_56_0
			})
		end
	end
end

function BlazingArenaFormationComp:setGroupType()
	self._group = self._mulFormationInfo.knight_group

	local var_57_0 = {}

	var_57_0.group = self._group or 0
	var_57_0.formationType = self._mulFormationStruct:getFormationType()
	var_57_0.formationIndex = self._mulFormationStruct:getMulIndex()

	self.m_uniteBtn:getRedPointComp():setCustomData(var_57_0)

	local var_57_1 = {}

	var_57_1.group = self._group or 0
	var_57_1.formationType = self._mulFormationStruct:getFormationType()
	var_57_1.formationIndex = self._mulFormationStruct:getMulIndex()

	self.m_petBtn:getRedPointComp():setCustomData(var_57_1)

	local var_57_2 = {}

	var_57_2.group = self._group or 0
	var_57_2.formationType = self._mulFormationStruct:getFormationType()
	var_57_2.formationIndex = self._mulFormationStruct:getMulIndex()

	self.m_succubaBtn:getRedPointComp():setCustomData(var_57_2)

	for iter_57_0, iter_57_1 in ipairs((self:_getPlaceCellArr())) do
		iter_57_1:setGroupType(self._group)
	end
end

function BlazingArenaFormationComp:_updateComp()
	self:_updatePlaceCells()
	self:_updatePetList()
	self:_updateUniteList()
	self.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)

	if not self._mulIndex or self._mulFormationStruct:getMulIndex() ~= self._mulIndex then
		local var_58_0 = self.m_uniteBtn:getRedPointComp()
		local var_58_1 = {}

		var_58_1.group = self._group or 0
		var_58_1.formationType = self._mulFormationStruct:getFormationType()
		var_58_1.formationIndex = self._mulFormationStruct:getMulIndex()

		var_58_0:setCustomData(var_58_1)

		local var_58_2 = {}

		var_58_2.group = self._group or 0
		var_58_2.formationType = self._mulFormationStruct:getFormationType()
		var_58_2.formationIndex = self._mulFormationStruct:getMulIndex()

		self.m_petBtn:getRedPointComp():setCustomData(var_58_2)

		local var_58_3 = {}

		var_58_3.group = self._group or 0
		var_58_3.formationType = self._mulFormationStruct:getFormationType()
		var_58_3.formationIndex = self._mulFormationStruct:getMulIndex()

		self.m_succubaBtn:getRedPointComp():setCustomData(var_58_3)
	end

	self._mulIndex = self._mulFormationStruct:getMulIndex()
end

function BlazingArenaFormationComp:_getPlaceCellArr()
	local var_59_0 = {}

	while true do
		if not self["m_placeCell_" .. 1] then
			break
		end

		self:addListen(self["m_placeCell_" .. 1])
		table.insert(var_59_0, self["m_placeCell_" .. 1])
	end

	return var_59_0
end

function BlazingArenaFormationComp:_addListeners()
	for iter_60_0, iter_60_1 in ipairs(self._placeCellArr) do
		iter_60_1:setDraggable(true)
		iter_60_1:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onPlaceCellDragStart))
		iter_60_1:addEventListener(fgui.UIEventType.Drop, handler(self, self._onPlaceCellDrop))
	end

	self.m_leaderGainComp:addClickListener(handler(self, self._onClickLeaderGainComp))
	self.m_readFormationBtn:addClickListener(handler(self, self._onClickReadFormationBtn))
	self.m_petList:setVirtual(self)
	self.m_petList:setItemRenderer(handler(self, self._onPetListRenderer))
	self.m_petList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickPetListItem))
	self.m_uniteTokenList:setVirtual(self)
	self.m_uniteTokenList:setItemRenderer(handler(self, self._onUniteTokenListRenderer))
	self.m_uniteTokenList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickUniteTokenListItem))
	self.m_succubaList:setVirtual(self)
	self.m_succubaList:setItemRenderer(handler(self, self._onSuccubaListRenderer))
	self.m_succubaList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickSuccubaListItem))
	self.m_bottomContentController:addEventListener(fgui.UIEventType.Changed, function()
		local var_61_0 = self.m_bottomContentController:getSelectedIndex()

		if var_61_0 == 1 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_PET, true)
		elseif var_61_0 == 0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_UNITE, true)
		elseif var_61_0 == 2 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA, true)
		end
	end)
end

function BlazingArenaFormationComp:setReadFormationBtnVisible(arg_62_1)
	self.m_readFormationBtn:setVisible(checkbool(arg_62_1))
end

function BlazingArenaFormationComp:_updateLeaderGain()
	local var_63_0, var_63_1 = self._mulFormationStruct:getLeaderGainTV()

	self.m_leaderGainComp:updateComp(var_63_0, var_63_1)
end

function BlazingArenaFormationComp:_updatePlaceCells(arg_64_1)
	for iter_64_0, iter_64_1 in ipairs(self._placeCellArr) do
		iter_64_1:updateCell(self._mulFormationStruct)

		if arg_64_1 then
			iter_64_1.m_knightComp:playKnightLineupAni()
		end

		self:_checkAndUpdateLockPlaceCell()
	end

	self:_updateLeaderGain()
	self:_updateFightValue(var_0_4.FRESH.KNIGHT)
end

function BlazingArenaFormationComp:_updateFightValue(arg_65_1)
	local var_65_0 = g.core.common.ServerTime:getTime()

	if var_65_0 - var_0_9:getLastSyncTime() > var_0_4.REFRESH_FIGHT_VALUE_TIME and self._mulFormationStruct:isModified() then
		if (self._mulFormationStruct:getFormationType() == var_0_4.MulTeamType.BLAZING_ARENA or nil) and g.core.model.User.blazingArenaData:isFormationValid() then
			var_0_9:setLastSyncTime(var_65_0)
			self:sendC2SFormationSave()
		else
			self.m_powerTxt:setText(var_0_11:get(200047))
		end
	elseif self._mulFormationStruct:isModified() then
		self.m_powerTxt:setText(var_0_11:get(200047))
		self:addSaveSchedule()
	else
		self.m_powerTxt:setText((self._mulFormationStruct:getFightValue()))
		self:unSaveSchedule()
	end

	if arg_65_1 then
		if arg_65_1 == var_0_4.FRESH.KNIGHT then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_KNIGHT)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ARTIFACT)
		elseif arg_65_1 == var_0_4.FRESH.ARTIFACT then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ARTIFACT)
		elseif arg_65_1 == var_0_4.FRESH.UNITE then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_UNITE)
		elseif arg_65_1 == var_0_4.FRESH.PET then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_PET)
		end
	end
end

function BlazingArenaFormationComp:refreshAllRedPoint()
	if self._updateAllRedPoint then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ALL, true)

		self._updateAllRedPoint = false
	end
end

function BlazingArenaFormationComp:playAnimation()
	self.m_enterTransition:play()
end

function BlazingArenaFormationComp:addSaveSchedule()
	self._saveSchedule = self._saveSchedule or self:newScheduleOnce(handler(self, self.sendC2SFormationSave), var_0_4.REFRESH_FIGHT_VALUE_TIME + 1)
end

function BlazingArenaFormationComp:unSaveSchedule()
	if self._saveSchedule then
		self:cancelSchedule(self._saveSchedule)
	end

	self._saveSchedule = nil
end

function BlazingArenaFormationComp:doBorrow(arg_70_1, arg_70_2, arg_70_3)
	local var_70_0 = g.core.model.User.blazingArenaData:isFormationValid()

	if var_70_0 then
		g.core.model.User.blazingArenaData:doBorrowHelpMember(self._mulFormationStruct, arg_70_1, arg_70_2, arg_70_3)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(431417))
	end

	return var_70_0
end

function BlazingArenaFormationComp:_getBorrowTipTxt(arg_71_1)
	return (g.core.lang:get(431418, {
		num = #g.core.model.User.blazingArenaData:getHelpMembers(arg_71_1),
		max = g.core.model.User.blazingArenaData:getShortInfo(arg_71_1)[g.core.model.User.blazingArenaData:getCurDay()].limitNum
	}))
end

function BlazingArenaFormationComp:_checkAndUpdateLockPlaceCell()
	local var_72_0 = not self._mulFormationStruct:canLineUpKnight()

	for iter_72_0, iter_72_1 in ipairs(self._placeCellArr) do
		iter_72_1:setLock(var_72_0 and not self._mulFormationStruct:isStationPosLineupKnight(iter_72_0))
	end
end

function BlazingArenaFormationComp:_updatePetList()
	self.m_petList:setNumItems(self._mulFormationStruct:getLimitUpPetCnt())
end

function BlazingArenaFormationComp:_updateUniteList()
	self.m_uniteTokenList:setNumItems(self._mulFormationStruct:getLimitUpUniteTokenCnt())
end

return BlazingArenaFormationComp
