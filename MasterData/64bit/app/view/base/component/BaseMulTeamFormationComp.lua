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
local BaseMulTeamFormationComp = class("BaseMulTeamFormationComp", require("app.fairyGUI.base_new.UI_BaseMulTeamFormationComp"))

function BaseMulTeamFormationComp:ctor()
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
	self.m_uniteBtn:setRedPointId(465)
	self.m_petBtn:setRedPointId(468)
	self.m_succubaBtn:setRedPointId(504)
end

function BaseMulTeamFormationComp:updateBottomBtn()
	self.m_petBtn:setVisible((var_0_2:isModuleUnlock(var_0_1.FUNCTION_TYPE.PET)))

	if self._mulFormationStruct:getLimitUpSuccubaCnt() == 0 then
		self.m_succubaBtn:setVisible(false)
	else
		self.m_succubaBtn:setVisible((var_0_2:isModuleUnlock(var_0_1.FUNCTION_TYPE.SUCCUBA)))
	end
end

function BaseMulTeamFormationComp:addBgByName()
	self:addBg("bg/formation/bg_bz_wenli.png", false, nil, 1)
end

function BaseMulTeamFormationComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, handler(self, self._onS2CFormationGet), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._onS2CFormationSave), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_FIGHTVALUE, handler(self, self._onS2CFormationFightValue), self)
	self:_sendC2SFormationGet()
	self.m_enterTransition:play(handler(self, self.onEnterTransAnimFinish))
end

function BaseMulTeamFormationComp:onEnterTransAnimFinish()
	if not self.m_guideHelper then
		return
	end

	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
			key = "AUTO_FORMATION",
			objects = {
				self.m_guideHelper,
				self.m_placeCell_1,
				self.m_placeCell_4,
				self.m_readFormationBtn
			}
		})
	end, 0)
end

function BaseMulTeamFormationComp:onUnload()
	local var_7_0 = self._mulFormationStruct:getFormationType()

	if var_0_9:isModified(var_7_0) then
		var_0_9:resetFormationStruct(var_7_0)
	end

	local var_7_1 = fgui.DragDropManager:getInstance():getAgent()

	var_7_1:removeEventListener(fgui.UIEventType.DragMove, var_0_5)
	var_7_1:removeEventListener(fgui.UIEventType.DragEnd, var_0_5)
	g.core.service.ServiceManager:getServiceByName("TipGuideService"):reset()
end

function BaseMulTeamFormationComp:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "CompEventClickKnight" then
		self:_onClickPlaceCellKnightIcon(arg_8_2, self._mulFormationInfo.knight_group)
	elseif arg_8_1 == "CompEventClickArtifact" then
		self:_onClickPlaceCellArtifactIcon(arg_8_2)
	elseif arg_8_1 == "FormationPreUsagePop_Preset_Select" then
		self:_onUsePreformationKnights(arg_8_2.ids)
	else
		return false
	end
end

function BaseMulTeamFormationComp:updateComp(arg_9_1, arg_9_2)
	self._updateAllRedPoint = true

	local var_9_0 = self._formationType ~= arg_9_1

	self._formationType = arg_9_1
	self._mulFormationStruct = var_0_9:getFormationStruct(arg_9_1, arg_9_2)

	assert(self._mulFormationStruct, "Error! BaseMulTeamFormationComp:updateComp invalide funcId, index: ", arg_9_1, arg_9_2)

	self._mulFormationInfo = var_0_0.get(arg_9_1)

	self._mulFormationStruct:refreshFixedAttr()
	self:setGroupType()
	self:setReadFormationBtnVisible(self._mulFormationInfo.if_reserve == 1)
	self:_updateComp()
	self:_sendC2SFormationGet()

	if var_9_0 then
		self:updateBottomBtn()
	end
end

function BaseMulTeamFormationComp:sendC2SFormationSave()
	self._saveSchedule = nil

	local var_10_0 = self._mulFormationStruct:getFormationType()

	if not self._mulFormationStruct then
		return false
	elseif not var_0_9:isModified(var_10_0) then
		return false
	end

	if var_10_0 == var_0_4.MulTeamType.CROSS_SERVER_ARENA and not g.core.model.User.crossServerArenaData:isFormationValid() then
		return false
	end

	local var_10_1

	if var_10_0 == var_0_4.MulTeamType.ANCIENTS and not self._mulFormationStruct:isFormationValid() then
		do return false end

		var_10_1 = {
			tp = var_10_0
		}
	end

	var_10_1.formations = var_0_9:getOutBaseFormationArr(var_10_0)

	g.core.network.GameNetProxy:send_C2S_Formation_Save(var_10_1)

	return true
end

function BaseMulTeamFormationComp:_onS2CFormationGet()
	self:_updateComp()
	self:refreshAllRedPoint()
end

function BaseMulTeamFormationComp:_onS2CFormationSave()
	self:_updateFightValue()
end

function BaseMulTeamFormationComp:_onS2CFormationFightValue()
	self.m_powerTxt:setText(self._mulFormationStruct:getFightValue())
	self:unSaveSchedule()
end

function BaseMulTeamFormationComp:_onPlaceCellDragStart(arg_14_1)
	self._triggeredDropEvent = false

	arg_14_1:preventDefault()
	arg_14_1:stopPropagation()

	local var_14_0 = arg_14_1:getSender()
	local var_14_1 = arg_14_1:getInput()

	if var_14_0.m_artifactComp:containPoint((var_14_1:getTouch():getLocation())) then
		if var_14_0.m_artifactComp:isEmpty() then
			self._placeCellStartDragStationPos = 0

			return
		else
			self._isDragArtifact = true
			self._placeCellStartDragStationPos = var_14_0.m_artifactComp:getStationPos()

			var_14_0.m_artifactComp:onDragStart()

			local var_14_2 = fgui.DragDropManager:getInstance()

			var_14_2:startDrag(var_14_0.m_artifactComp:getResourceURL(), self._placeCellStartDragStationPos, var_14_1:getTouchId())

			local var_14_3 = var_14_2:getAgent()
			local var_14_4 = var_14_3:getComponent()

			var_14_4:bindLua(var_14_4:getRemark())
			var_14_4:becomeTo(var_14_0.m_artifactComp)
			var_14_3:addEventListener(fgui.UIEventType.DragMove, handler(self, self._onPlaceCellDragMove), var_0_5)
			var_14_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPlaceCellDragEnd), var_0_5)
		end
	elseif var_14_0.m_knightComp:isEmpty() then
		self._placeCellStartDragStationPos = 0

		return
	else
		self._isDragArtifact = false
		self._placeCellStartDragStationPos = var_14_0:getStationPos()

		var_14_0:onDragStart()

		local var_14_5 = fgui.DragDropManager:getInstance()

		var_14_5:startDrag(var_14_0:getResourceURL(), self._placeCellStartDragStationPos, var_14_1:getTouchId())

		local var_14_6 = var_14_5:getAgent()
		local var_14_7 = var_14_6:getComponent()

		var_14_7:bindLua(var_14_7:getRemark())
		var_14_7:becomeTo(var_14_0)
		var_14_6:addEventListener(fgui.UIEventType.DragMove, handler(self, self._onPlaceCellDragMove), var_0_5)
		var_14_6:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPlaceCellDragEnd), var_0_5)
	end
end

function BaseMulTeamFormationComp:_onPlaceCellDrop(arg_15_1)
	if self._placeCellStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	local var_15_0 = self._mulFormationStruct
	local var_15_1 = arg_15_1:getSender()
	local var_15_2 = var_15_1:getStationPos()

	if self._isDragArtifact then
		if self._mulFormationStruct:isStationPosLineupKnight(var_15_2) then
			local var_15_3 = var_15_0:getArtifactSid(self._placeCellStartDragStationPos)
			local var_15_4 = var_0_12:getKnight({
				id = var_15_0:getKnightSid(var_15_2)
			})

			if var_15_4 and not var_0_7:getArtifactBySid(var_15_3):checkWearKnight(var_15_4:getAdvanceId()) then
				g.core.module.ModuleManager:tip(g.core.lang:get(205539))
				self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(var_15_0)
				var_15_1:playDropAni()

				return
			end

			local var_15_5 = var_0_7:getArtifactBySid((var_15_0:getArtifactSid(var_15_2)))

			if var_15_5 then
				local var_15_6 = var_0_12:getKnight({
					id = var_15_0:getKnightSid(self._placeCellStartDragStationPos)
				})

				if var_15_6 and not var_15_5:checkWearKnight(var_15_6:getAdvanceId()) then
					g.core.module.ModuleManager:tip(g.core.lang:get(205539))
					self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(var_15_0)
					var_15_1:playDropAni()

					return
				end
			end

			var_15_0:lineupArtifact(var_15_2, var_15_3)
			self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(var_15_0)
			var_15_1.m_artifactComp:updateComp(var_15_0)
			var_15_1:playDropAni()
		else
			var_0_8:tip(var_0_11:get(200041))
			self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:onDragEnd()
			self._placeCellArr[self._placeCellStartDragStationPos]:playDropAni()
			var_15_1:playHoveringAni(false)

			return
		end
	else
		var_15_0:lineupKnight(var_15_2, (var_15_0:getKnightSid(self._placeCellStartDragStationPos)))
		self._placeCellArr[self._placeCellStartDragStationPos]:updateCell(var_15_0)
		self._placeCellArr[self._placeCellStartDragStationPos].m_knightComp:playKnightLineupAni()
		var_15_1:updateCell(var_15_0)
		var_15_1:playDropAni()
		var_15_1.m_knightComp:playKnightLineupAni()
		self:_updateLeaderGain()
	end

	self:_updateFightValue(var_0_4.FRESH.KNIGHT)
	self:dispatchCompEvent(var_0_6, {
		(var_15_0:getFormationIdx())
	})
end

function BaseMulTeamFormationComp:_onPlaceCellDragMove(arg_16_1)
	local var_16_0 = arg_16_1:getInput():getTouch():getLocation()

	for iter_16_0, iter_16_1 in ipairs(self._placeCellArr) do
		iter_16_1:playHoveringAni((iter_16_1:containPoint(var_16_0)))
	end
end

function BaseMulTeamFormationComp:_onPlaceCellDragEnd(arg_17_1)
	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, var_0_5)

	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._placeCellStartDragStationPos = 0

		return
	end

	local var_17_0 = self._placeCellStartDragStationPos

	self._placeCellStartDragStationPos = 0

	local var_17_1 = self._placeCellArr[var_17_0]

	if self._isDragArtifact then
		self._mulFormationStruct:lineupArtifact(var_17_0, 0)
	elseif self._mulFormationStruct:canLineUpKnight(var_17_0, 0) then
		self._mulFormationStruct:lineupKnight(var_17_0, 0)
		self:_updateLeaderGain()
	end

	self:_updateFightValue(var_0_4.FRESH.KNIGHT)
	var_17_1:onDragEnd()
end

function BaseMulTeamFormationComp:_onPetCompDragStart(arg_18_1)
	self._triggeredDropEvent = false

	arg_18_1:preventDefault()
	arg_18_1:stopPropagation()

	local var_18_0 = arg_18_1:getSender()

	if var_18_0:isEmpty() then
		self._petStartDragStationPos = 0
	else
		local var_18_1 = var_18_0:getStationPos()

		self._petStartDragStationPos = var_18_1

		var_18_0:onDragStart()

		local var_18_2 = fgui.DragDropManager:getInstance()

		var_18_2:startDrag(var_18_0:getResourceURL(), var_18_1, (arg_18_1:getInput():getTouchId()))

		local var_18_3 = var_18_2:getAgent()
		local var_18_4 = var_18_3:getComponent()

		var_18_4:bindLua("app.view.base.component.BaseMulTeamFormationPetComp")
		var_18_4:becomeTo(var_18_0)
		var_18_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPetCompDragEnd), var_0_5)
	end
end

function BaseMulTeamFormationComp:_onPetCompDrop(arg_19_1)
	if self._petStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	self._mulFormationStruct:lineupPet(arg_19_1:getSender():getStationPos(), (self._mulFormationStruct:getPetSid(self._petStartDragStationPos)))
	self.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
	self:_updateFightValue(var_0_4.FRESH.PET)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BaseMulTeamFormationComp:_onPetCompDragEnd(arg_20_1)
	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._petStartDragStationPos = 0

		return
	end

	local var_20_0 = self._petStartDragStationPos

	self._petStartDragStationPos = 0

	self._mulFormationStruct:lineupPet(var_20_0, 0)
	self.m_petList:getChildAt(var_20_0 - 1):updateComp(var_20_0, 0, self._mulFormationStruct and self._mulFormationStruct:getMulIndex())
	self:_updateFightValue(var_0_4.FRESH.PET)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BaseMulTeamFormationComp:_onUniteTokenCompDragStart(arg_21_1)
	self._triggeredDropEvent = false

	arg_21_1:preventDefault()
	arg_21_1:stopPropagation()

	local var_21_0 = arg_21_1:getSender()

	if var_21_0:isEmpty() then
		self._uniteTokenStartDragStationPos = 0
	else
		local var_21_1 = var_21_0:getStationPos()

		self._uniteTokenStartDragStationPos = var_21_1

		var_21_0:onDragStart()

		local var_21_2 = fgui.DragDropManager:getInstance()

		var_21_2:startDrag(var_21_0:getResourceURL(), var_21_1, (arg_21_1:getInput():getTouchId()))

		local var_21_3 = var_21_2:getAgent()
		local var_21_4 = var_21_3:getComponent()

		var_21_4:bindLua("app.view.base.component.BaseMulTeamFormationUniteTokenComp")
		var_21_4:becomeTo(var_21_0)
		var_21_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onUniteTokenCompDragEnd), var_0_5)
	end
end

function BaseMulTeamFormationComp:_onUniteTokenCompDrop(arg_22_1)
	if self._uniteTokenStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	self._mulFormationStruct:lineupUniteToken(arg_22_1:getSender():getStationPos(), (self._mulFormationStruct:getUniteTokenSid(self._uniteTokenStartDragStationPos)))
	self.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
	self:_updateFightValue(var_0_4.FRESH.UNITE)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BaseMulTeamFormationComp:_onUniteTokenCompDragEnd(arg_23_1)
	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._uniteTokenStartDragStationPos = 0

		return
	end

	local var_23_0 = self._uniteTokenStartDragStationPos

	self._uniteTokenStartDragStationPos = 0

	self._mulFormationStruct:lineupUniteToken(var_23_0, 0)
	self.m_uniteTokenList:getChildAt(var_23_0 - 1):updateComp(var_23_0, 0, self._mulFormationStruct and self._mulFormationStruct:getMulIndex())
	self:_updateFightValue(var_0_4.FRESH.UNITE)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BaseMulTeamFormationComp:_onSuccubaCompDragStart(arg_24_1)
	self._triggeredDropEvent = false

	arg_24_1:preventDefault()
	arg_24_1:stopPropagation()

	local var_24_0 = arg_24_1:getSender()

	if var_24_0:isEmpty() then
		self._succStartDragStationPos = 0
	else
		local var_24_1 = var_24_0:getStationPos()

		self._succStartDragStationPos = var_24_1

		var_24_0:onDragStart()

		local var_24_2 = fgui.DragDropManager:getInstance()

		var_24_2:startDrag(var_24_0:getResourceURL(), var_24_1, (arg_24_1:getInput():getTouchId()))

		local var_24_3 = var_24_2:getAgent()
		local var_24_4 = var_24_3:getComponent()

		var_24_4:bindLua("app.view.base.component.BaseMulTeamFormationSuccubaComp")
		var_24_4:becomeTo(var_24_0)
		var_24_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onSuccubaCompDragEnd), var_0_5)
	end
end

function BaseMulTeamFormationComp:_onSuccubaCompDrop(arg_25_1)
	if self._succStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	local var_25_0 = arg_25_1:getSender()

	var_25_0:onDragEnd()
	self._mulFormationStruct:lineupSuccuba(var_25_0:getStationPos(), (self._mulFormationStruct:getSuccubaSid(self._succStartDragStationPos)))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA)
	self.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BaseMulTeamFormationComp:_onSuccubaCompDragEnd(arg_26_1)
	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._succStartDragStationPos = 0

		return
	end

	local var_26_0 = self._succStartDragStationPos

	self._succStartDragStationPos = 0

	local var_26_1 = self.m_succubaList:getChildAt(var_26_0 - 1)

	if var_26_1 then
		var_26_1:onDragEnd()
	end

	self._mulFormationStruct:lineupSuccuba(var_26_0, 0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA)
	self.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
	self:dispatchCompEvent(var_0_6, {
		(self._mulFormationStruct:getFormationIdx())
	})
end

function BaseMulTeamFormationComp:_onClickLeaderGainComp(arg_27_1)
	if not self._mulFormationStruct then
		return
	end

	local var_27_0, var_27_1 = self._mulFormationStruct:getLeaderGainTV()

	var_0_8:pushPopup(require("app.view.module.lineUp.view.haloPop.LineUpHaloPop").new({
		group = var_27_0,
		curCnt = var_27_1,
		knights = table.values((self._mulFormationStruct:getKnightDict()))
	}), {
		touchDisappear = true
	})
end

function BaseMulTeamFormationComp:_onClickReadFormationBtn()
	if not self._mulFormationStruct then
		return
	end

	local var_28_0 = require("app.view.module.formation.pre.FormationPreUsagePop").new({
		type = var_0_1.FormationConst.POP_TYPE.MYTEAM
	})

	self:addListen(var_28_0)
	var_0_8:pushPopup(var_28_0, {
		touchDisappear = true
	})
end

function BaseMulTeamFormationComp:_onPetListRenderer(arg_29_1, arg_29_2)
	arg_29_2:setFormationType(self._mulFormationStruct:getFormationType())
	arg_29_2:updateComp(arg_29_1 + 1, self._mulFormationStruct:getPetSid(arg_29_1 + 1), self._mulFormationStruct:getMulIndex(), self._mulFormationStruct:getFormationType())

	if var_0_2:isModuleUnlock(var_0_3["PET_LINE_UP_" .. arg_29_1 + 1]) then
		if arg_29_2:hasEventListener(fgui.UIEventType.DragStart) then
			-- block empty
		else
			arg_29_2:setDraggable(true)
			arg_29_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onPetCompDragStart))
			arg_29_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onPetCompDrop))
		end
	else
		arg_29_2:setDraggable(false)
	end
end

function BaseMulTeamFormationComp:_onUniteTokenListRenderer(arg_30_1, arg_30_2)
	arg_30_2:setFormationType(self._mulFormationStruct:getFormationType())
	arg_30_2:updateComp(arg_30_1 + 1, self._mulFormationStruct:getUniteTokenSid(arg_30_1 + 1), self._mulFormationStruct:getMulIndex())

	if arg_30_2:hasEventListener(fgui.UIEventType.DragStart) then
		-- block empty
	else
		arg_30_2:setDraggable(true)
		arg_30_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onUniteTokenCompDragStart))
		arg_30_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onUniteTokenCompDrop))
	end
end

function BaseMulTeamFormationComp:_onSuccubaListRenderer(arg_31_1, arg_31_2)
	arg_31_2:setFormationType(self._mulFormationStruct:getFormationType())
	arg_31_2:updateComp(arg_31_1 + 1, self._mulFormationStruct:getSuccubaSid(arg_31_1 + 1), self._mulFormationStruct:getMulIndex(), self._mulFormationStruct:getFormationType())
	arg_31_2:resetCompAlpha()
	arg_31_2:checkRedPoint({
		formationType = self._mulFormationStruct:getFormationType(),
		formationIndex = self._mulFormationStruct:getMulIndex()
	})

	if var_0_2:isModuleUnlock(var_0_3.SUCCUBA) then
		if arg_31_2:hasEventListener(fgui.UIEventType.DragStart) then
			-- block empty
		else
			arg_31_2:setDraggable(true)
			arg_31_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onSuccubaCompDragStart))
			arg_31_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onSuccubaCompDrop))
		end
	else
		arg_31_2:setDraggable(false)
	end
end

function BaseMulTeamFormationComp:_onClickPlaceCellKnightIcon(arg_32_1, arg_32_2)
	local var_32_0 = self._mulFormationStruct:getFormationType()
	local var_32_1 = self._mulFormationStruct:getFormationIdx()
	local var_32_2 = self._mulFormationStruct:getKnightSid(arg_32_1)
	local var_32_3 = self._placeCellArr[arg_32_1]
	local var_32_4

	var_32_4 = require("app.view.base.infoPop.lineup.CommonLineUpKnightPop").new({
		isFilter = true,
		itemUrl = "ui://infoPop/MulFormationLineupKnightCell",
		allList = var_0_9:getAllLineUpKnight(self._formationType, {
			group = arg_32_2
		}),
		group = arg_32_2,
		isLineUpCall = function(self)
			return var_0_9:isKnightLineup(var_32_0, self:getServerId())
		end,
		clickCheckFunc = handler(self, function(arg_34_0, arg_34_1)
			local var_34_0 = arg_34_1:getServerId()

			if arg_34_1:isElementLeader() then
				local var_34_1 = arg_34_0._mulFormationStruct:getKnightStationPos(var_34_0)

				for iter_34_0 = 1, #arg_34_0._placeCellArr do
					if iter_34_0 ~= arg_32_1 and iter_34_0 ~= var_34_1 then
						local var_34_2 = arg_34_0._mulFormationStruct:getKnightSid(iter_34_0)

						if var_34_2 and var_34_2 > 0 then
							local var_34_3 = var_0_12:getKnightById(var_34_2)

							if var_34_3 and var_34_3:isElementLeader() then
								var_0_8:tip(var_0_11:get(200051))

								return false
							end
						end
					end
				end
			end

			if arg_34_0._mulFormationStruct:isKnightLineUp(var_34_0) then
				if var_34_0 == var_32_2 then
					var_0_8:tip(var_0_11:get(200004))

					return false
				else
					arg_34_0._mulFormationStruct:lineupKnight(arg_32_1, var_34_0)
					arg_34_0:_updatePlaceCells()
					var_32_3.m_knightComp:playKnightLineupAni()
					arg_34_0:dispatchCompEvent(var_0_6, {
						var_32_1
					})

					return true
				end
			elseif var_0_9:isKnightLineup(var_32_0, var_34_0) then
				local var_34_4 = var_0_9:getFormationStructKnightLineup(var_32_0, var_34_0)
				local var_34_5 = var_34_4:getFormationIdx()

				var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_11:get(200028, {
						name = var_0_11:get(103028),
						num = var_32_1
					}),
					itemDataArr = {
						{
							type = var_0_10.TYPE_KNIGHT,
							value = arg_34_1:getBaseId(),
							teamName = var_0_11:get(200027, {
								num = var_34_5
							})
						}
					},
					onConfirm = handler(arg_34_0, function()
						var_34_4:takeOffKnight(var_34_0)
						arg_34_0._mulFormationStruct:lineupKnight(arg_32_1, var_34_0)
						var_32_3:updateCell(arg_34_0._mulFormationStruct)
						var_32_3.m_knightComp:playKnightLineupAni()
						arg_34_0:_updateLeaderGain()
						arg_34_0:_updateFightValue(var_0_4.FRESH.KNIGHT)
						arg_34_0:dispatchCompEvent(var_0_6, {
							var_32_1,
							var_34_5
						})
						var_0_8:onlyPopSelfByDisplay(var_32_4)
					end)
				}))

				return false
			else
				arg_34_0._mulFormationStruct:lineupKnight(arg_32_1, var_34_0)
				var_32_3:updateCell(arg_34_0._mulFormationStruct)
				var_32_3.m_knightComp:playKnightLineupAni()
				arg_34_0:_updateLeaderGain()
				arg_34_0:_updateFightValue(var_0_4.FRESH.KNIGHT)
				arg_34_0:dispatchCompEvent(var_0_6, {
					var_32_1
				})

				return true
			end
		end),
		cellParam = {
			formationType = var_32_0
		}
	})

	var_0_8:pushPopup(nil, {
		ignoreTouch = false,
		blackOpacity = 0.5,
		touchDisappear = false
	})
end

function BaseMulTeamFormationComp:_onClickPlaceCellArtifactIcon(arg_36_1)
	if not self._mulFormationStruct:isStationPosLineupKnight(arg_36_1) then
		var_0_8:tip(var_0_11:get(200041))

		return
	end

	local var_36_0 = self._mulFormationStruct:getFormationType()
	local var_36_1 = self._mulFormationStruct:getFormationIdx()
	local var_36_2 = self._mulFormationStruct:getArtifactSid(arg_36_1)
	local var_36_3 = var_0_12:getKnightById((self._mulFormationStruct:getKnightSid(arg_36_1)))
	local var_36_4 = var_36_3 and var_36_3:getAdvanceId()
	local var_36_5

	var_36_5 = require("app.view.base.infoPop.lineup.CommonLineUpArtifactPop").new({
		isFilter = true,
		itemUrl = "ui://infoPop/MulFormationLineupArtifactCell",
		allList = var_0_9:getAllLineUpArtifact(self._formationType),
		isLineUpCall = function(self)
			return var_0_9:isArtifactLineup(var_36_0, self:getServerOnlyId())
		end,
		clickCheckFunc = handler(self, function(arg_38_0, arg_38_1)
			if not arg_38_1:checkWearKnight(var_36_4) then
				g.core.module.ModuleManager:tip(g.core.lang:get(205539))

				return false
			end

			local var_38_0 = arg_38_1:getServerOnlyId()

			if arg_38_0._mulFormationStruct:isArtifactLineUp(var_38_0) then
				if var_38_0 == var_36_2 then
					var_0_8:tip(var_0_11:get(200030))

					return false
				else
					local var_38_1 = var_0_7:getArtifactBySid(var_36_2)

					if var_38_1 then
						local var_38_2 = var_0_12:getKnight({
							id = arg_38_0._mulFormationStruct:getKnightSid((arg_38_0._mulFormationStruct:getArtifactStationPos(var_38_0)))
						})

						if var_38_2 and not var_38_1:checkWearKnight(var_38_2:getAdvanceId()) then
							g.core.module.ModuleManager:tip(g.core.lang:get(205539))

							return false
						end
					end

					arg_38_0._mulFormationStruct:lineupArtifact(arg_36_1, var_38_0)
					arg_38_0:_updatePlaceCells()
					arg_38_0:dispatchCompEvent(var_0_6, {
						var_36_1
					})

					return true
				end
			elseif var_0_9:isArtifactLineup(var_36_0, var_38_0) then
				local var_38_3 = var_0_9:getFormationStructArtifactLineup(var_36_0, var_38_0)
				local var_38_4 = var_0_7:getArtifactBySid(var_36_2)

				if var_38_4 then
					local var_38_5 = var_0_12:getKnight({
						id = var_38_3:getKnightSid((var_38_3:getArtifactStationPos(var_38_0)))
					})

					if var_38_5 and not var_38_4:checkWearKnight(var_38_5:getAdvanceId()) then
						g.core.module.ModuleManager:tip(g.core.lang:get(205539))

						return false
					end
				end

				local var_38_6 = var_38_3:getFormationIdx()

				var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_11:get(200028, {
						name = var_0_11:get(103032),
						num = arg_38_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_10.TYPE_ARTIFACT,
							value = arg_38_1:getArtifactBaseId(),
							teamName = var_0_11:get(200027, {
								num = var_38_6
							})
						}
					},
					onConfirm = handler(arg_38_0, function()
						var_38_3:takeOffArtifact(var_38_0)
						arg_38_0._mulFormationStruct:lineupArtifact(arg_36_1, var_38_0)
						arg_38_0._placeCellArr[arg_36_1]:updateCell(arg_38_0._mulFormationStruct)
						arg_38_0:_updateFightValue(var_0_4.FRESH.ARTIFACT)
						arg_38_0:dispatchCompEvent(var_0_6, {
							var_36_1,
							var_38_6
						})
						var_0_8:onlyPopSelfByDisplay(var_36_5)
					end)
				}))

				return false
			else
				arg_38_0._mulFormationStruct:lineupArtifact(arg_36_1, var_38_0)
				arg_38_0._placeCellArr[arg_36_1]:updateCell(arg_38_0._mulFormationStruct)
				arg_38_0:_updateFightValue(var_0_4.FRESH.ARTIFACT)
				arg_38_0:dispatchCompEvent(var_0_6, {
					var_36_1
				})

				return true
			end
		end),
		isRelated = function(self)
			return self:getBelongToKnightAvdIdIncludingMainRole() == var_36_4
		end,
		cellParam = {
			formationType = var_36_0,
			pos = self._mulFormationStruct:getKnightPosByStationPos(arg_36_1),
			knightAdvId = var_36_4
		}
	})

	var_0_8:pushPopup(nil, {
		ignoreTouch = false,
		blackOpacity = 0.5,
		touchDisappear = false
	})
end

function BaseMulTeamFormationComp:_onClickPetListItem(arg_41_1)
	local var_41_0 = arg_41_1:getDataValue() + 1

	if not var_0_2:isModuleUnlock(var_0_3["PET_LINE_UP_" .. var_41_0]) then
		local var_41_1, var_41_2 = var_0_2:getModuleUnlockLevelAndComment(var_0_3["PET_LINE_UP_" .. var_41_0])

		var_0_8:tip(var_0_11:get(202514, {
			level = var_41_1
		}))

		return
	end

	local var_41_3 = self._mulFormationStruct:getFormationType()
	local var_41_4 = self._mulFormationStruct:getFormationIdx()
	local var_41_5 = self._mulFormationStruct:getPetSid(var_41_0)
	local var_41_6

	var_41_6 = require("app.view.base.infoPop.lineup.CommonLineUpPetPop").new({
		isFilter = true,
		itemUrl = "ui://infoPop/MulFormationLineupPetCell",
		allList = var_0_9:getAllLineUpPet(self._formationType),
		isLineUpCall = function(self)
			return var_0_9:isPetLineup(var_41_3, self:getSid())
		end,
		clickCheckFunc = handler(self, function(arg_43_0, arg_43_1)
			local var_43_0 = arg_43_1:getSid()

			if arg_43_0._mulFormationStruct:isPetLineUp(var_43_0) then
				if var_43_0 == var_41_5 then
					var_0_8:tip(var_0_11:get(200031))

					return false
				else
					arg_43_0._mulFormationStruct:lineupPet(var_41_0, var_43_0)
					arg_43_0.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
					arg_43_0:_updateFightValue(var_0_4.FRESH.PET)
					arg_43_0:dispatchCompEvent(var_0_6, {
						var_41_4
					})

					return true
				end
			elseif var_0_9:isPetLineup(var_41_3, var_43_0) then
				local var_43_1 = var_0_9:getFormationStructPetLineup(var_41_3, var_43_0)
				local var_43_2 = var_43_1:getFormationIdx()

				var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_11:get(200028, {
						name = var_0_11:get(103034),
						num = arg_43_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_10.TYPE_PET,
							value = arg_43_1:getCfg().id,
							teamName = var_0_11:get(200027, {
								num = var_43_2
							})
						}
					},
					onConfirm = handler(arg_43_0, function()
						var_43_1:takeOffPet(var_43_0)
						arg_43_0._mulFormationStruct:lineupPet(var_41_0, var_43_0)
						arg_43_0.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
						arg_43_0:_updateFightValue(var_0_4.FRESH.PET)
						arg_43_0:dispatchCompEvent(var_0_6, {
							var_41_4,
							var_43_2
						})
						var_0_8:onlyPopSelfByDisplay(var_41_6)
					end)
				}))

				return false
			else
				arg_43_0._mulFormationStruct:lineupPet(var_41_0, var_43_0)
				arg_43_0.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
				arg_43_0:_updateFightValue(var_0_4.FRESH.PET)
				arg_43_0:dispatchCompEvent(var_0_6, {
					var_41_4
				})

				return true
			end
		end),
		cellParam = {
			formationType = var_41_3
		}
	})

	var_0_8:pushPopup(nil, {
		ignoreTouch = false,
		blackOpacity = 0.5,
		touchDisappear = false
	})
end

function BaseMulTeamFormationComp:_onClickUniteTokenListItem(arg_45_1)
	local var_45_0 = arg_45_1:getDataValue() + 1
	local var_45_1 = self._mulFormationStruct:getFormationType()
	local var_45_2 = self._mulFormationStruct:getFormationIdx()
	local var_45_3 = self._mulFormationStruct:getUniteTokenSid(var_45_0)
	local var_45_4

	var_45_4 = require("app.view.base.infoPop.lineup.CommonLineUpUnitePop").new({
		isFilter = true,
		itemUrl = "ui://infoPop/MulFormationLineupUniteTokenCell",
		allList = var_0_9:getAllLineUpUnite(self._formationType),
		isLineUpCall = function(self)
			return var_0_9:isUniteTokenLineup(var_45_1, self:getServerId())
		end,
		clickCheckFunc = handler(self, function(arg_47_0, arg_47_1)
			local var_47_0 = arg_47_1:getServerId()

			if arg_47_0._mulFormationStruct:isUniteTokenLineUp(var_47_0) then
				if var_47_0 == var_45_3 then
					var_0_8:tip(var_0_11:get(200032))

					return false
				else
					arg_47_0._mulFormationStruct:lineupUniteToken(var_45_0, var_47_0)
					arg_47_0.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
					arg_47_0:_updateFightValue(var_0_4.FRESH.UNITE)
					arg_47_0:dispatchCompEvent(var_0_6, {
						var_45_2
					})

					return true
				end
			elseif var_0_9:isUniteTokenLineup(var_45_1, var_47_0) then
				local var_47_1 = var_0_9:getFormationStructUniteTokenLineup(var_45_1, var_47_0)
				local var_47_2 = var_47_1:getFormationIdx()

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
								num = var_47_2
							})
						}
					},
					onConfirm = handler(arg_47_0, function()
						var_47_1:takeOffUniteToken(var_47_0)
						arg_47_0._mulFormationStruct:lineupUniteToken(var_45_0, var_47_0)
						arg_47_0.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
						arg_47_0:_updateFightValue(var_0_4.FRESH.UNITE)
						arg_47_0:dispatchCompEvent(var_0_6, {
							var_45_2,
							var_47_2
						})
						var_0_8:onlyPopSelfByDisplay(var_45_4)
					end)
				}))

				return false
			else
				arg_47_0._mulFormationStruct:lineupUniteToken(var_45_0, var_47_0)
				arg_47_0.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
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
	})

	var_0_8:pushPopup(nil, {
		ignoreTouch = false,
		blackOpacity = 0.5,
		touchDisappear = false
	})
end

function BaseMulTeamFormationComp:_onUsePreformationKnights(arg_49_1)
	local var_49_0 = self._mulFormationStruct:getFormationType()
	local var_49_1 = self._mulFormationStruct:getFormationIdx()
	local var_49_2 = {
		var_49_1
	}
	local var_49_3 = {}

	for iter_49_0, iter_49_1 in pairs(arg_49_1) do
		local var_49_4 = var_0_9:getFormationStructKnightLineup(var_49_0, iter_49_1)

		if var_49_4 and var_49_4 ~= self._mulFormationStruct then
			local var_49_5 = var_49_4:getFormationIdx()

			table.insert(var_49_2, var_49_5)

			local var_49_6 = var_0_12:getKnightById(iter_49_1)

			table.insert(var_49_3, {
				type = var_0_10.TYPE_KNIGHT,
				value = var_49_6:getBaseId(),
				teamName = var_0_11:get(200027, {
					num = var_49_5
				})
			})
		end
	end

	if #var_49_3 > 0 then
		var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
			desc = var_0_11:get(200028, {
				name = var_0_11:get(103028),
				num = var_49_1
			}),
			itemDataArr = var_49_3,
			onConfirm = handler(self, function()
				var_0_9:replaceAllKnights(self._mulFormationStruct, arg_49_1)
				self:_updatePlaceCells(true)
				self:dispatchCompEvent(var_0_6, var_49_2)
			end)
		}))
	else
		self._mulFormationStruct:replaceAllKnights(arg_49_1)
		self:_updatePlaceCells(true)
		self:dispatchCompEvent(var_0_6, var_49_2)
	end
end

function BaseMulTeamFormationComp:_onClickSuccubaListItem(arg_51_1)
	local var_51_0 = arg_51_1:getDataValue() + 1

	if not var_0_2:isModuleUnlock(var_0_3.SUCCUBA) then
		local var_51_1, var_51_2 = var_0_2:getModuleUnlockLevelAndComment(var_0_3.SUCCUBA)

		var_0_8:tip(var_0_11:get(202514, {
			level = var_51_1
		}))

		return
	end

	local var_51_3 = self._mulFormationStruct:getFormationType()
	local var_51_4 = self._mulFormationStruct:getFormationIdx()
	local var_51_5 = self._mulFormationStruct:getSuccubaSid(var_51_0)
	local var_51_6

	var_51_6 = require("app.view.base.infoPop.lineup.CommonLineUpSuccubaPop").new({
		isFilter = true,
		itemUrl = "ui://infoPop/CommonLineUpSuccubaCell",
		allList = var_0_9:getAllLineUpSuccuba(self._formationType),
		isLineUpCall = function(self)
			return var_0_9:isSuccubaLineUp(var_51_3, self:getSid())
		end,
		clickCheckFunc = handler(self, function(arg_53_0, arg_53_1)
			local var_53_0 = arg_53_1:getSid()

			if arg_53_0._mulFormationStruct:isSuccubaLineUp(var_53_0) then
				if var_53_0 == var_51_5 then
					var_0_8:tip(var_0_11:get(431044))

					return false
				else
					arg_53_0._mulFormationStruct:lineupSuccuba(var_51_0, var_53_0)
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA)
					arg_53_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
					arg_53_0:dispatchCompEvent(var_0_6, {
						var_51_4
					})

					return true
				end
			elseif var_0_9:isSuccubaLineUp(var_51_3, var_53_0) then
				local var_53_1 = var_0_9:getFormationStructSuccubaLineup(var_51_3, var_53_0)
				local var_53_2 = var_53_1:getFormationIdx()

				var_0_8:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_11:get(200028, {
						name = var_0_11:get(103041),
						num = arg_53_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_10.TYPE_SUCCUBA,
							value = arg_53_1:getCurCfg().id,
							teamName = var_0_11:get(200027, {
								num = var_53_2
							})
						}
					},
					onConfirm = handler(arg_53_0, function()
						var_53_1:takeOffSuccuba(var_53_0)
						arg_53_0._mulFormationStruct:lineupSuccuba(var_51_0, var_53_0)
						g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA)
						arg_53_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
						arg_53_0:dispatchCompEvent(var_0_6, {
							var_51_4,
							var_53_2
						})
						var_0_8:onlyPopSelfByDisplay(var_51_6)
					end)
				}))

				return false
			else
				arg_53_0._mulFormationStruct:lineupSuccuba(var_51_0, var_53_0)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA)
				arg_53_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
				arg_53_0:dispatchCompEvent(var_0_6, {
					var_51_4
				})

				return true
			end
		end),
		cellParam = {
			formationType = var_51_3
		}
	})

	var_0_8:pushPopup(nil, {
		ignoreTouch = false,
		blackOpacity = 0.5,
		touchDisappear = false
	})
end

function BaseMulTeamFormationComp:_sendC2SFormationGet()
	if not self._mulFormationStruct then
		self:refreshAllRedPoint()
	else
		local var_55_0 = self._mulFormationStruct:getFormationType()

		if var_0_9:isInitWithSvrData(var_55_0) then
			self:refreshAllRedPoint()
		else
			g.core.network.GameNetProxy:send_C2S_Formation_Get({
				tp = var_55_0
			})
		end
	end
end

function BaseMulTeamFormationComp:setGroupType()
	self._group = self._mulFormationInfo.knight_group

	local var_56_0 = {}

	var_56_0.group = self._group or 0
	var_56_0.formationType = self._mulFormationStruct:getFormationType()
	var_56_0.formationIndex = self._mulFormationStruct:getMulIndex()

	self.m_uniteBtn:getRedPointComp():setCustomData(var_56_0)

	local var_56_1 = {}

	var_56_1.group = self._group or 0
	var_56_1.formationType = self._mulFormationStruct:getFormationType()
	var_56_1.formationIndex = self._mulFormationStruct:getMulIndex()

	self.m_petBtn:getRedPointComp():setCustomData(var_56_1)

	local var_56_2 = {}

	var_56_2.group = self._group or 0
	var_56_2.formationType = self._mulFormationStruct:getFormationType()
	var_56_2.formationIndex = self._mulFormationStruct:getMulIndex()

	self.m_succubaBtn:getRedPointComp():setCustomData(var_56_2)

	for iter_56_0, iter_56_1 in ipairs((self:_getPlaceCellArr())) do
		iter_56_1:setGroupType(self._group)
	end
end

function BaseMulTeamFormationComp:_updateComp()
	self:_updatePlaceCells()
	self.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
	self.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
	self.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)

	if not self._mulIndex or self._mulFormationStruct:getMulIndex() ~= self._mulIndex then
		local var_57_0 = self.m_uniteBtn:getRedPointComp()
		local var_57_1 = {}

		var_57_1.group = self._group or 0
		var_57_1.formationType = self._mulFormationStruct:getFormationType()
		var_57_1.formationIndex = self._mulFormationStruct:getMulIndex()

		var_57_0:setCustomData(var_57_1)

		local var_57_2 = {}

		var_57_2.group = self._group or 0
		var_57_2.formationType = self._mulFormationStruct:getFormationType()
		var_57_2.formationIndex = self._mulFormationStruct:getMulIndex()

		self.m_petBtn:getRedPointComp():setCustomData(var_57_2)

		local var_57_3 = {}

		var_57_3.group = self._group or 0
		var_57_3.formationType = self._mulFormationStruct:getFormationType()
		var_57_3.formationIndex = self._mulFormationStruct:getMulIndex()

		self.m_succubaBtn:getRedPointComp():setCustomData(var_57_3)
	end

	self._mulIndex = self._mulFormationStruct:getMulIndex()
end

function BaseMulTeamFormationComp:_getPlaceCellArr()
	local var_58_0 = {}

	while true do
		if not self["m_placeCell_" .. 1] then
			break
		end

		self:addListen(self["m_placeCell_" .. 1])
		table.insert(var_58_0, self["m_placeCell_" .. 1])
	end

	return var_58_0
end

function BaseMulTeamFormationComp:_addListeners()
	for iter_59_0, iter_59_1 in ipairs(self._placeCellArr) do
		iter_59_1:setDraggable(true)
		iter_59_1:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onPlaceCellDragStart))
		iter_59_1:addEventListener(fgui.UIEventType.Drop, handler(self, self._onPlaceCellDrop))
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
		local var_60_0 = self.m_bottomContentController:getSelectedIndex()

		if var_60_0 == 1 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_PET, true)
		elseif var_60_0 == 0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_UNITE, true)
		elseif var_60_0 == 2 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_SUCCUBA, true)
		end
	end)
end

function BaseMulTeamFormationComp:setReadFormationBtnVisible(arg_61_1)
	self.m_readFormationBtn:setVisible(checkbool(arg_61_1))
end

function BaseMulTeamFormationComp:_updateLeaderGain()
	local var_62_0, var_62_1 = self._mulFormationStruct:getLeaderGainTV()

	self.m_leaderGainComp:updateComp(var_62_0, var_62_1)
end

function BaseMulTeamFormationComp:_updatePlaceCells(arg_63_1)
	for iter_63_0, iter_63_1 in ipairs(self._placeCellArr) do
		iter_63_1:updateCell(self._mulFormationStruct)

		if arg_63_1 then
			iter_63_1.m_knightComp:playKnightLineupAni()
		end
	end

	self:_updateLeaderGain()
	self:_updateFightValue(var_0_4.FRESH.KNIGHT)
end

function BaseMulTeamFormationComp:_updateFightValue(arg_64_1)
	local var_64_0 = g.core.common.ServerTime:getTime()

	if var_64_0 - var_0_9:getLastSyncTime() > var_0_4.REFRESH_FIGHT_VALUE_TIME and self._mulFormationStruct:isModified() then
		if (self._mulFormationStruct:getFormationType() == var_0_4.MulTeamType.CROSS_SERVER_ARENA or nil) and g.core.model.User.crossServerArenaData:isFormationValid() then
			var_0_9:setLastSyncTime(var_64_0)
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

	if arg_64_1 then
		if arg_64_1 == var_0_4.FRESH.KNIGHT then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_KNIGHT)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ARTIFACT)
		elseif arg_64_1 == var_0_4.FRESH.ARTIFACT then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ARTIFACT)
		elseif arg_64_1 == var_0_4.FRESH.UNITE then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_UNITE)
		elseif arg_64_1 == var_0_4.FRESH.PET then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_PET)
		end
	end
end

function BaseMulTeamFormationComp:refreshAllRedPoint()
	if self._updateAllRedPoint then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ALL, true)

		self._updateAllRedPoint = false
	end
end

function BaseMulTeamFormationComp:playAnimation()
	self.m_enterTransition:play()
end

function BaseMulTeamFormationComp:addSaveSchedule()
	self._saveSchedule = self._saveSchedule or self:newScheduleOnce(handler(self, self.sendC2SFormationSave), var_0_4.REFRESH_FIGHT_VALUE_TIME + 1)
end

function BaseMulTeamFormationComp:unSaveSchedule()
	if self._saveSchedule then
		self:cancelSchedule(self._saveSchedule)
	end

	self._saveSchedule = nil
end

return BaseMulTeamFormationComp
