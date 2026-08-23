local var_0_0 = g.core.lang
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.BASE_CONST.DRAG_TAG.EXPLORATION_FORMATION
local var_0_3 = g.core.model.User.explorationData
local var_0_4 = g.core.const.ConstMgr.LineUpConst
local var_0_5 = g.core.module.ModuleManager
local var_0_6 = g.core.common.Goods
local var_0_7 = g.core.common.ModuleUnlock
local var_0_8 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_9 = g.core.sound.SoundManager
local var_0_10 = g.core.const.ConstMgr.SoundConst
local ExplorationFormationComp = class("ExplorationFormationComp", require("app.fairyGUI.exploration.UI_ExplorationFormationComp"))

function ExplorationFormationComp:ctor()
	self._placeCellStartDragStationPos = 0
	self._petStartDragStationPos = 0
	self._uniteTokenStartDragStationPos = 0
	self._isDragArtifact = false
	self._triggeredDropEvent = false
	self._updateAllRedPoint = true
	self._enterBattle = false
	self._saveSchedule = nil
	self._formationData = var_0_3:getFormationData()
	self._mulFormationStruct = nil
	self._placeCellArr = self:_getPlaceCellArr()

	self:initView()
end

function ExplorationFormationComp:initView()
	for iter_2_0, iter_2_1 in ipairs(self._placeCellArr) do
		iter_2_1:setDraggable(true)
		iter_2_1:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onPlaceCellDragStart))
		iter_2_1:addEventListener(fgui.UIEventType.Drop, handler(self, self._onPlaceCellDrop))
	end

	self.m_petList:setVirtual(self)
	self.m_petList:setItemRenderer(handler(self, self._onPetListRenderer))
	self.m_petList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickPetListItem))
	self.m_uniteTokenList:setVirtual(self)
	self.m_uniteTokenList:setItemRenderer(handler(self, self._onUniteTokenListRenderer))
	self.m_uniteTokenList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickUniteTokenListItem))
	self.m_succubaList:setVirtual(self)
	self.m_succubaList:setItemRenderer(handler(self, self._onSuccubaListRenderer))
	self.m_succubaList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickSuccubaListItem))
	self.m_uniteBtn:setRedPointId(739)
	self.m_petBtn:setRedPointId(740)
	self.m_succubaBtn:setRedPointId(907)
	self.m_petBtn:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(var_0_1.FUNCTION_TYPE.PET)))
	self.m_succubaBtn:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(var_0_1.FUNCTION_TYPE.SUCCUBA)))
end

function ExplorationFormationComp:_getPlaceCellArr()
	local var_3_0 = {}

	while true do
		if not self["m_placeCell_" .. 1] then
			break
		end

		self:addListen(self["m_placeCell_" .. 1])
		table.insert(var_3_0, self["m_placeCell_" .. 1])
		self["m_placeCell_" .. 1]:setStationPos(1)
	end

	return var_3_0
end

function ExplorationFormationComp:_onPetListRenderer(arg_4_1, arg_4_2)
	arg_4_2:setFormationType(self._mulFormationStruct:getFormationType())
	arg_4_2:updateComp(arg_4_1 + 1, self._mulFormationStruct:getPetSid(arg_4_1 + 1), self._mulFormationStruct:getMulIndex(), self._mulFormationStruct:getFormationType())

	if var_0_7:isModuleUnlock(var_0_8["PET_LINE_UP_" .. arg_4_1 + 1]) then
		if arg_4_2:hasEventListener(fgui.UIEventType.DragStart) then
			-- block empty
		else
			arg_4_2:setDraggable(true)
			arg_4_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onPetCompDragStart))
			arg_4_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onPetCompDrop))
		end
	else
		arg_4_2:setDraggable(false)
	end
end

function ExplorationFormationComp:_onSuccubaListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateComp(arg_5_1 + 1, self._mulFormationStruct:getSuccubaSid(arg_5_1 + 1), self._mulFormationStruct:getMulIndex(), self._mulFormationStruct:getFormationType())

	if var_0_7:isModuleUnlock(var_0_8.SUCCUBA) then
		if arg_5_2:hasEventListener(fgui.UIEventType.DragStart) then
			-- block empty
		else
			arg_5_2:setDraggable(true)
			arg_5_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onSuccubaCompDragStart))
			arg_5_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onSuccubaCompDrop))
		end
	else
		arg_5_2:setDraggable(false)
	end
end

function ExplorationFormationComp:_onUniteTokenListRenderer(arg_6_1, arg_6_2)
	arg_6_2:setFormationType(self._mulFormationStruct:getFormationType())
	arg_6_2:updateComp(arg_6_1 + 1, self._mulFormationStruct:getUniteTokenSid(arg_6_1 + 1), self._mulFormationStruct:getMulIndex())

	if arg_6_2:hasEventListener(fgui.UIEventType.DragStart) then
		-- block empty
	else
		arg_6_2:setDraggable(true)
		arg_6_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onUniteTokenCompDragStart))
		arg_6_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onUniteTokenCompDrop))
	end
end

function ExplorationFormationComp:_onPetCompDragStart(arg_7_1)
	self._triggeredDropEvent = false

	arg_7_1:preventDefault()
	arg_7_1:stopPropagation()

	local var_7_0 = arg_7_1:getSender()

	if var_7_0:isEmpty() then
		self._petStartDragStationPos = 0
	else
		local var_7_1 = var_7_0:getStationPos()

		self._petStartDragStationPos = var_7_1

		var_7_0:onDragStart()

		local var_7_2 = fgui.DragDropManager:getInstance()

		var_7_2:startDrag(var_7_0:getResourceURL(), var_7_1, (arg_7_1:getInput():getTouchId()))

		local var_7_3 = var_7_2:getAgent()
		local var_7_4 = var_7_3:getComponent()

		var_7_4:bindLua("app.view.module.exploration.view.formation.comp.ExplorationFormationPetComp")
		var_7_4:becomeTo(var_7_0)
		var_7_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPetCompDragEnd), var_0_2)
	end
end

function ExplorationFormationComp:_onPetCompDrop(arg_8_1)
	if self._petStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	self._mulFormationStruct:lineupPet(arg_8_1:getSender():getStationPos(), (self._mulFormationStruct:getPetSid(self._petStartDragStationPos)))
	self.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
	self:_updateFightValue(var_0_4.FRESH.PET)
end

function ExplorationFormationComp:_onPetCompDragEnd(arg_9_1)
	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._petStartDragStationPos = 0

		return
	end

	local var_9_0 = self._petStartDragStationPos

	self._petStartDragStationPos = 0

	self._mulFormationStruct:lineupPet(var_9_0, 0)
	self.m_petList:getChildAt(var_9_0 - 1):updateComp(var_9_0, 0, self._mulFormationStruct and self._mulFormationStruct:getMulIndex())
	self:_updateFightValue(var_0_4.FRESH.PET)
end

function ExplorationFormationComp:_onSuccubaCompDragStart(arg_10_1)
	self._triggeredDropEvent = false

	arg_10_1:preventDefault()
	arg_10_1:stopPropagation()

	local var_10_0 = arg_10_1:getSender()

	if var_10_0:isEmpty() then
		self._succStartDragStationPos = 0
	else
		local var_10_1 = var_10_0:getStationPos()

		self._succStartDragStationPos = var_10_1

		var_10_0:onDragStart()

		local var_10_2 = fgui.DragDropManager:getInstance()

		var_10_2:startDrag(var_10_0:getResourceURL(), var_10_1, (arg_10_1:getInput():getTouchId()))

		local var_10_3 = var_10_2:getAgent()
		local var_10_4 = var_10_3:getComponent()

		var_10_4:bindLua("app.view.module.exploration.view.formation.comp.ExplorationFormationSuccubaIconComp")
		var_10_4:becomeTo(var_10_0)
		var_10_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onSuccubaCompDragEnd), var_0_2)
	end
end

function ExplorationFormationComp:_onSuccubaCompDrop(arg_11_1)
	if self._succStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	local var_11_0 = arg_11_1:getSender()

	var_11_0:onDragEnd()
	self._mulFormationStruct:lineupSuccuba(var_11_0:getStationPos(), (self._mulFormationStruct:getSuccubaSid(self._succStartDragStationPos)))
	self.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
end

function ExplorationFormationComp:_onSuccubaCompDragEnd(arg_12_1)
	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._succStartDragStationPos = 0

		return
	end

	local var_12_0 = self._succStartDragStationPos

	self._succStartDragStationPos = 0

	local var_12_1 = self.m_succubaList:getChildAt(var_12_0 - 1)

	self._mulFormationStruct:lineupSuccuba(var_12_0, 0)
	var_12_1:updateComp(var_12_0, 0, self._mulFormationStruct and self._mulFormationStruct:getMulIndex())
	var_12_1:onDragEnd()
end

function ExplorationFormationComp:_onUniteTokenCompDrop(arg_13_1)
	if self._uniteTokenStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	self._mulFormationStruct:lineupUniteToken(arg_13_1:getSender():getStationPos(), (self._mulFormationStruct:getUniteTokenSid(self._uniteTokenStartDragStationPos)))
	self.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
	self:_updateFightValue(var_0_4.FRESH.UNITE)
end

function ExplorationFormationComp:_onUniteTokenCompDragStart(arg_14_1)
	self._triggeredDropEvent = false

	arg_14_1:preventDefault()
	arg_14_1:stopPropagation()

	local var_14_0 = arg_14_1:getSender()

	if var_14_0:isEmpty() then
		self._uniteTokenStartDragStationPos = 0
	else
		local var_14_1 = var_14_0:getStationPos()

		self._uniteTokenStartDragStationPos = var_14_1

		var_14_0:onDragStart()

		local var_14_2 = fgui.DragDropManager:getInstance()

		var_14_2:startDrag(var_14_0:getResourceURL(), var_14_1, (arg_14_1:getInput():getTouchId()))

		local var_14_3 = var_14_2:getAgent()
		local var_14_4 = var_14_3:getComponent()

		var_14_4:bindLua("app.view.module.exploration.view.formation.comp.ExplorationFormationUniteTokenComp")
		var_14_4:becomeTo(var_14_0)
		var_14_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onUniteTokenCompDragEnd), var_0_2)
	end
end

function ExplorationFormationComp:_onUniteTokenCompDragEnd(arg_15_1)
	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._uniteTokenStartDragStationPos = 0

		return
	end

	local var_15_0 = self._uniteTokenStartDragStationPos

	self._uniteTokenStartDragStationPos = 0

	self._mulFormationStruct:lineupUniteToken(var_15_0, 0)
	self.m_uniteTokenList:getChildAt(var_15_0 - 1):updateComp(var_15_0, 0, self._mulFormationStruct and self._mulFormationStruct:getMulIndex())
	self:_updateFightValue(var_0_4.FRESH.UNITE)
end

function ExplorationFormationComp:_onClickPetListItem(arg_16_1)
	local var_16_0 = arg_16_1:getDataValue() + 1

	if not var_0_7:isModuleUnlock(var_0_8["PET_LINE_UP_" .. var_16_0]) then
		local var_16_1, var_16_2 = var_0_7:getModuleUnlockLevelAndComment(var_0_8["PET_LINE_UP_" .. var_16_0])

		var_0_5:tip(var_0_0:get(202514, {
			level = var_16_1
		}))

		return
	end

	local var_16_3

	var_16_3 = require("app.view.base.infoPop.lineup.CommonLineUpPetPop").new({
		itemUrl = "ui://exploration/ExplorationFormationLineupPetCell",
		isFilter = true,
		allList = self._formationData:getAllPetList(),
		isLineUpCall = handler(self, function(arg_17_0, arg_17_1)
			return arg_17_0._formationData:isPetLineup(arg_17_1:getSid())
		end),
		clickCheckFunc = handler(self, function(arg_18_0, arg_18_1)
			local var_18_0 = arg_18_1:getSid()

			if arg_18_0._mulFormationStruct:isPetLineUp(var_18_0) then
				local var_18_1, var_18_2 = arg_18_0._mulFormationStruct:getPetStationPos(var_18_0)

				if var_16_0 == var_18_1 then
					var_0_5:tip(var_0_0:get(200031))

					return false
				else
					arg_18_0._mulFormationStruct:takeOffPet(var_18_2)
					arg_18_0._mulFormationStruct:lineupPet(var_16_0, var_18_0)
					arg_18_0.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
					arg_18_0:_updateFightValue(var_0_4.FRESH.PET)

					return true
				end
			elseif arg_18_0._formationData:isPetLineup(var_18_0) then
				local var_18_3 = arg_18_0._formationData:getFormationStructPetLineup(var_18_0)
				local var_18_4, var_18_5 = var_18_3:getPetStationPos(var_18_0)

				var_0_5:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_0:get(200028, {
						name = var_0_0:get(103034),
						num = arg_18_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_6.TYPE_PET,
							value = arg_18_1:getCfg().id,
							teamName = var_0_0:get(200027, {
								num = var_18_3:getFormationIdx()
							})
						}
					},
					onConfirm = handler(arg_18_0, function(arg_19_0)
						var_18_3:takeOffPet(var_18_5)
						arg_19_0._mulFormationStruct:lineupPet(var_16_0, var_18_0)
						arg_19_0.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
						arg_19_0:_updateFightValue(var_0_4.FRESH.PET)
						var_0_5:onlyPopSelfByDisplay(var_16_3)
					end)
				}))

				return false
			else
				arg_18_0._mulFormationStruct:lineupPet(var_16_0, var_18_0)
				arg_18_0.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
				arg_18_0:_updateFightValue(var_0_4.FRESH.PET)

				return true
			end
		end),
		cellParam = {}
	})

	var_0_5:pushPopup(nil, {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function ExplorationFormationComp:_onClickSuccubaListItem(arg_20_1)
	local var_20_0 = arg_20_1:getDataValue() + 1

	if not var_0_7:isModuleUnlock(var_0_8.SUCCUBA) then
		local var_20_1, var_20_2 = var_0_7:getModuleUnlockLevelAndComment(var_0_8.SUCCUBA)

		var_0_5:tip(var_0_0:get(202514, {
			level = var_20_1
		}))

		return
	end

	local var_20_3

	var_20_3 = require("app.view.base.infoPop.lineup.CommonLineUpSuccubaPop").new({
		itemUrl = "ui://infoPop/CommonLineUpSuccubaCell",
		isFilter = true,
		allList = g.core.model.User.succubaData:getSuccubaList(),
		isLineUpCall = handler(self, function(arg_21_0, arg_21_1)
			return arg_21_0._formationData:isSuccubaLineUp(arg_21_1:getSid(), arg_21_0._mulFormationStruct:getFormationIdx())
		end),
		clickCheckFunc = handler(self, function(arg_22_0, arg_22_1)
			local var_22_0 = arg_22_1:getSid()

			if arg_22_0._mulFormationStruct:isSuccubaLineUp(var_22_0) then
				if var_20_0 == arg_22_0._mulFormationStruct:getSuccubaStationPos(var_22_0) then
					var_0_5:tip(var_0_0:get(431044))

					return false
				else
					arg_22_0._mulFormationStruct:takeOffSuccuba((arg_22_1:getSid()))
					arg_22_0._mulFormationStruct:lineupSuccuba(var_20_0, var_22_0)
					arg_22_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)

					return true
				end
			elseif arg_22_0._formationData:isSuccubaLineUp(var_22_0) then
				local var_22_1 = arg_22_0._formationData:getFormationStructSuccubaLineup(var_22_0)
				local var_22_2 = var_22_0

				var_0_5:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_0:get(200028, {
						name = var_0_0:get(103041),
						num = arg_22_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_6.TYPE_SUCCUBA,
							value = arg_22_1:getCurCfg().id,
							teamName = var_0_0:get(200027, {
								num = var_22_1:getFormationIdx()
							})
						}
					},
					onConfirm = handler(arg_22_0, function(arg_23_0)
						var_22_1:takeOffSuccuba(var_22_2)
						arg_23_0._mulFormationStruct:lineupSuccuba(var_20_0, var_22_0)
						arg_23_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
						var_0_5:onlyPopSelfByDisplay(var_20_3)
					end)
				}))

				return false
			else
				arg_22_0._mulFormationStruct:lineupSuccuba(var_20_0, var_22_0)
				arg_22_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)

				return true
			end
		end),
		cellParam = {}
	})

	var_0_5:pushPopup(nil, {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function ExplorationFormationComp:_onClickUniteTokenListItem(arg_24_1)
	local var_24_0 = arg_24_1:getDataValue() + 1
	local var_24_1

	var_24_1 = require("app.view.base.infoPop.lineup.CommonLineUpUnitePop").new({
		itemUrl = "ui://exploration/ExplorationFormationLineupUniteTokenCell",
		isFilter = true,
		allList = self._formationData:getAllUniteTokenList(),
		isLineUpCall = handler(self, function(arg_25_0, arg_25_1)
			return arg_25_0._formationData:isUniteTokenLineup(arg_25_1:getServerId())
		end),
		clickCheckFunc = handler(self, function(arg_26_0, arg_26_1)
			local var_26_0 = arg_26_1:getServerId()

			if arg_26_0._mulFormationStruct:isUniteTokenLineUp(var_26_0) then
				local var_26_1, var_26_2 = arg_26_0._mulFormationStruct:getUniteTokenStationPos(var_26_0)

				if var_26_1 == var_24_0 then
					var_0_5:tip(var_0_0:get(200032))

					return false
				else
					arg_26_0._mulFormationStruct:takeOffUniteToken(var_26_2)
					arg_26_0._mulFormationStruct:lineupUniteToken(var_24_0, var_26_0)
					arg_26_0.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
					arg_26_0:_updateFightValue(var_0_4.FRESH.UNITE)

					return true
				end
			elseif arg_26_0._formationData:isUniteTokenLineup(var_26_0) then
				local var_26_3 = arg_26_0._formationData:getFormationStructUniteTokenLineup(var_26_0)
				local var_26_4, var_26_5 = var_26_3:getUniteTokenStationPos(var_26_0)

				var_0_5:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_0:get(200028, {
						name = var_0_0:get(103031),
						num = arg_26_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_6.TYPE_UNITETOKEN,
							value = arg_26_1:getBaseId(),
							teamName = var_0_0:get(200027, {
								num = var_26_3:getFormationIdx()
							})
						}
					},
					onConfirm = handler(arg_26_0, function(arg_27_0)
						var_26_3:takeOffUniteToken(var_26_5)
						arg_27_0._mulFormationStruct:lineupUniteToken(var_24_0, var_26_5)
						arg_27_0.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
						arg_27_0:_updateFightValue(var_0_4.FRESH.UNITE)
						var_0_5:onlyPopSelfByDisplay(var_24_1)
					end)
				}))

				return false
			else
				arg_26_0._mulFormationStruct:lineupUniteToken(var_24_0, var_26_0)
				arg_26_0.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
				arg_26_0:_updateFightValue(var_0_4.FRESH.UNITE)

				return true
			end
		end),
		cellParam = {}
	})

	var_0_5:pushPopup(nil, {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function ExplorationFormationComp:_onPlaceCellDragStart(arg_28_1)
	self._triggeredDropEvent = false

	arg_28_1:preventDefault()
	arg_28_1:stopPropagation()

	local var_28_0 = arg_28_1:getSender()
	local var_28_1 = arg_28_1:getInput()

	if var_28_0.m_artifactComp:containPoint((var_28_1:getTouch():getLocation())) then
		if var_28_0.m_artifactComp:isEmpty() then
			self._placeCellStartDragStationPos = 0

			return
		else
			self._isDragArtifact = true
			self._placeCellStartDragStationPos = var_28_0.m_artifactComp:getStationPos()

			var_28_0.m_artifactComp:onDragStart()

			local var_28_2 = fgui.DragDropManager:getInstance()

			var_28_2:startDrag(var_28_0.m_artifactComp:getResourceURL(), self._placeCellStartDragStationPos, var_28_1:getTouchId())

			local var_28_3 = var_28_2:getAgent()
			local var_28_4 = var_28_3:getComponent()

			var_28_4:bindLua(var_28_4:getRemark())
			var_28_4:becomeTo(var_28_0.m_artifactComp)
			var_28_3:addEventListener(fgui.UIEventType.DragMove, handler(self, self._onPlaceCellDragMove), var_0_2)
			var_28_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPlaceCellDragEnd), var_0_2)
		end
	elseif var_28_0.m_knightComp:isEmpty() then
		self._placeCellStartDragStationPos = 0

		return
	else
		self._isDragArtifact = false
		self._placeCellStartDragStationPos = var_28_0:getStationPos()

		var_28_0:onDragStart()

		local var_28_5 = fgui.DragDropManager:getInstance()

		var_28_5:startDrag(var_28_0:getResourceURL(), self._placeCellStartDragStationPos, var_28_1:getTouchId())

		local var_28_6 = var_28_5:getAgent()
		local var_28_7 = var_28_6:getComponent()

		var_28_7:bindLua(var_28_7:getRemark())
		var_28_7:becomeTo(var_28_0)
		var_28_6:addEventListener(fgui.UIEventType.DragMove, handler(self, self._onPlaceCellDragMove), var_0_2)
		var_28_6:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPlaceCellDragEnd), var_0_2)
	end
end

function ExplorationFormationComp:_onPlaceCellDragMove(arg_29_1)
	local var_29_0 = arg_29_1:getInput():getTouch():getLocation()

	for iter_29_0, iter_29_1 in ipairs(self._placeCellArr) do
		iter_29_1:playHoveringAni((iter_29_1:containPoint(var_29_0)))
	end
end

function ExplorationFormationComp:_onPlaceCellDragEnd(arg_30_1)
	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, var_0_2)

	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._placeCellStartDragStationPos = 0

		return
	end

	local var_30_0 = self._placeCellStartDragStationPos

	self._placeCellStartDragStationPos = 0

	local var_30_1 = self._placeCellArr[var_30_0]

	if self._isDragArtifact then
		self._mulFormationStruct:lineupArtifact(var_30_0, 0)
	else
		self._mulFormationStruct:lineupKnight(var_30_0, 0)
	end

	self:_updateFightValue(var_0_4.FRESH.KNIGHT)
	var_30_1:onDragEnd()
end

function ExplorationFormationComp:_onPlaceCellDrop(arg_31_1)
	if self._placeCellStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	local var_31_0 = arg_31_1:getSender()
	local var_31_1 = var_31_0:getStationPos()

	if self._isDragArtifact then
		if self._mulFormationStruct:isStationPosLineupKnight(var_31_1) then
			local var_31_2 = self._mulFormationStruct:getArtifactSid(self._placeCellStartDragStationPos)
			local var_31_3 = self._formationData:getKnightByServerId((self._mulFormationStruct:getKnightSid(var_31_1)))

			if var_31_3 and not self._formationData:getArtifactByServerId(var_31_2):checkWearKnight(var_31_3:getAdvanceId()) then
				g.core.module.ModuleManager:tip(g.core.lang:get(205539))
				self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(self._mulFormationStruct)
				var_31_0:playDropAni()

				return
			end

			local var_31_4 = self._formationData:getArtifactByServerId((self._mulFormationStruct:getArtifactSid(var_31_1)))

			if var_31_4 then
				local var_31_5 = self._formationData:getKnightByServerId((self._mulFormationStruct:getKnightSid(self._placeCellStartDragStationPos)))

				if var_31_5 and not var_31_4:checkWearKnight(var_31_5:getAdvanceId()) then
					g.core.module.ModuleManager:tip(g.core.lang:get(205539))
					self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(self._mulFormationStruct)
					var_31_0:playDropAni()

					return
				end
			end

			self._mulFormationStruct:lineupArtifact(var_31_1, var_31_2)
			self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(self._mulFormationStruct)
			var_31_0.m_artifactComp:updateComp(self._mulFormationStruct)
			var_31_0:playDropAni()
		else
			var_0_5:tip(var_0_0:get(200041))
			self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:onDragEnd()
			self._placeCellArr[self._placeCellStartDragStationPos]:playDropAni()
			var_31_0:playHoveringAni(false)

			return
		end
	else
		self._mulFormationStruct:lineupKnight(var_31_1, (self._mulFormationStruct:getKnightSid(self._placeCellStartDragStationPos)))
		self._placeCellArr[self._placeCellStartDragStationPos]:updateCell(self._mulFormationStruct)
		self._placeCellArr[self._placeCellStartDragStationPos].m_knightComp:playKnightLineupAni()
		var_31_0:updateCell(self._mulFormationStruct)
		var_31_0:playDropAni()
		var_31_0.m_knightComp:playKnightLineupAni()
	end

	self:_updateFightValue(var_0_4.FRESH.KNIGHT)
end

function ExplorationFormationComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._onS2CFormationSave), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_FIGHTVALUE, handler(self, self._onS2CFormationFightValue), self)
end

function ExplorationFormationComp:_onS2CFormationFightValue()
	if not self._enterBattle then
		self.m_powerTxt:setText(self._mulFormationStruct:getFightValue())
	end

	self:unSaveSchedule()
end

function ExplorationFormationComp:_onS2CFormationSave()
	self:_updateFightValue()
end

function ExplorationFormationComp:updateComp(arg_35_1)
	self._updateAllRedPoint = true
	self._mulFormationStruct = self._formationData:getFormationStruct(arg_35_1)

	self:_updateComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ALL)
end

function ExplorationFormationComp:_updateComp()
	self:_updatePlaceCells()
	self.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
	self.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
	self.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)

	if not self._mulIndex or self._mulFormationStruct:getMulIndex() ~= self._mulIndex then
		self.m_uniteBtn:getRedPointComp():setCustomData({
			formationIndex = self._mulFormationStruct:getMulIndex()
		})
		self.m_petBtn:getRedPointComp():setCustomData({
			formationIndex = self._mulFormationStruct:getMulIndex()
		})
	end

	self._mulIndex = self._mulFormationStruct:getMulIndex()
end

function ExplorationFormationComp:_updatePlaceCells(arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(self._placeCellArr) do
		iter_37_1:updateCell(self._mulFormationStruct)

		if arg_37_1 then
			iter_37_1.m_knightComp:playKnightLineupAni()
		end
	end

	self:_updateFightValue(var_0_1.LineUpConst.FRESH.KNIGHT)
end

function ExplorationFormationComp:setEnterBattle(arg_38_1)
	self._enterBattle = arg_38_1 == true
end

function ExplorationFormationComp:_updateFightValue(arg_39_1)
	local var_39_0 = g.core.common.ServerTime:getTime()

	if var_39_0 - self._formationData:getLastSyncTime() > var_0_4.REFRESH_FIGHT_VALUE_TIME and self._mulFormationStruct:isModified() then
		if (self._mulFormationStruct:getFormationType() == var_0_4.MulTeamType.CROSS_SERVER_ARENA or nil) and g.core.model.User.crossServerArenaData:isFormationValid() then
			self._formationData:setLastSyncTime(var_39_0)
			self:sendC2SFormationSave()
		else
			self.m_powerTxt:setText(var_0_0:get(200047))
		end
	elseif self._mulFormationStruct:isModified() then
		self.m_powerTxt:setText(var_0_0:get(200047))
		self:addSaveSchedule()
	elseif not self._enterBattle then
		self.m_powerTxt:setText((self._mulFormationStruct:getFightValue()))
		self:unSaveSchedule()
	end

	if arg_39_1 then
		if arg_39_1 == var_0_4.FRESH.KNIGHT then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_KNIGHT)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ARTIFACT)
		elseif arg_39_1 == var_0_4.FRESH.ARTIFACT then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ARTIFACT)
		elseif arg_39_1 == var_0_4.FRESH.UNITE then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_UNITE)
		elseif arg_39_1 == var_0_4.FRESH.PET then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_PET)
		end
	end

	self:dispatchCompEvent("CompEventFormationChanged")
end

function ExplorationFormationComp:addSaveSchedule()
	self._saveSchedule = self._saveSchedule or self:newScheduleOnce(handler(self, self.sendC2SFormationSave), var_0_4.REFRESH_FIGHT_VALUE_TIME + 1)
end

function ExplorationFormationComp:unSaveSchedule()
	if self._saveSchedule then
		self:cancelSchedule(self._saveSchedule)
	end

	self._saveSchedule = nil
end

function ExplorationFormationComp:sendC2SFormationSave()
	self._saveSchedule = nil

	local var_42_0

	if not self._mulFormationStruct then
		return false
	elseif not self._formationData:isModified() then
		do return false end

		var_42_0 = {
			tp = var_0_4.MulTeamType.EXPLORATION
		}
	end

	var_42_0.formations = self._formationData:getOutBaseFormationArr()

	g.core.network.GameNetProxy:send_C2S_Formation_Save(var_42_0)

	return true
end

function ExplorationFormationComp:receiveCompEvent(arg_43_1, arg_43_2)
	if arg_43_1 == "CompEventClickKnight" then
		self:_onClickPlaceCellKnightIcon(arg_43_2)
	elseif arg_43_1 == "CompEventClickArtifact" then
		self:_onClickPlaceCellArtifactIcon(arg_43_2)
	else
		return false
	end
end

function ExplorationFormationComp:_onClickPlaceCellKnightIcon(arg_44_1)
	local var_44_0 = self._mulFormationStruct:getFormationIdx()
	local var_44_1 = self._placeCellArr[arg_44_1]
	local var_44_2

	var_44_2 = require("app.view.base.infoPop.lineup.CommonLineUpKnightPop").new({
		itemUrl = "ui://exploration/ExplorationFormationLineupKnightCell",
		isFilter = true,
		allList = self._formationData:getAllKnightList(),
		isLineUpCall = handler(self, function(arg_45_0, arg_45_1)
			return arg_45_0._formationData:isUsingKnight(arg_45_1:getServerId())
		end),
		sortFunc = handler(self, self.sortKnightFunc),
		clickCheckFunc = handler(self, function(arg_46_0, arg_46_1)
			local var_46_0 = arg_46_1:getServerId()

			if not arg_46_0._mulFormationStruct:isKnightLineUp(var_46_0) and arg_46_1:isElementLeader() then
				for iter_46_0, iter_46_1 in pairs(arg_46_0._mulFormationStruct:getKnightDict()) do
					if iter_46_0 ~= arg_44_1 and iter_46_1:isElementLeader() then
						var_0_5:tip(var_0_0:get(200051))

						return false
					end
				end
			end

			if arg_46_0._mulFormationStruct:isKnightLineUp(var_46_0) then
				local var_46_1, var_46_2 = arg_46_0._mulFormationStruct:getKnightStationPos(var_46_0)

				if arg_44_1 == var_46_1 and var_46_2 == var_46_0 then
					var_0_5:tip(var_0_0:get(200004))

					return false
				else
					arg_46_0._mulFormationStruct:takeOffKnight(var_46_2)
					arg_46_0._mulFormationStruct:lineupKnight(arg_44_1, var_46_0)
					arg_46_0._formationData:autoAddArtifact(arg_46_0._mulFormationStruct, arg_44_1)
					arg_46_0:_updatePlaceCells()
					var_44_1.m_knightComp:playKnightLineupAni()

					return true
				end
			elseif arg_46_0._formationData:isKnightLineup(var_46_0) then
				local var_46_3 = arg_46_0._formationData:getFormationStructKnightLineup(var_46_0)
				local var_46_4, var_46_5 = var_46_3:getKnightStationPos(var_46_0)

				var_0_5:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_0:get(200028, {
						name = var_0_0:get(103028),
						num = var_44_0
					}),
					itemDataArr = {
						{
							type = var_0_6.TYPE_KNIGHT,
							value = arg_46_1:getBaseId(),
							teamName = var_0_0:get(200027, {
								num = var_46_3:getFormationIdx()
							})
						}
					},
					onConfirm = handler(arg_46_0, function(arg_47_0)
						var_46_3:takeOffKnight(var_46_5)
						arg_47_0._mulFormationStruct:lineupKnight(arg_44_1, var_46_0)
						arg_47_0._formationData:autoAddArtifact(arg_47_0._mulFormationStruct, arg_44_1)
						var_44_1:updateCell(arg_47_0._mulFormationStruct)
						var_44_1.m_knightComp:playKnightLineupAni()
						arg_47_0:_updateFightValue(var_0_4.FRESH.KNIGHT)
						var_0_5:onlyPopSelfByDisplay(var_44_2)
					end)
				}))

				return false
			else
				arg_46_0._mulFormationStruct:lineupKnight(arg_44_1, var_46_0)
				arg_46_0._formationData:autoAddArtifact(arg_46_0._mulFormationStruct, arg_44_1)
				var_44_1:updateCell(arg_46_0._mulFormationStruct)
				var_44_1.m_knightComp:playKnightLineupAni()
				arg_46_0:_updateFightValue(var_0_4.FRESH.KNIGHT)

				return true
			end
		end),
		cellParam = {
			formationIdx = var_44_0,
			stationPos = arg_44_1
		}
	})

	var_0_9:playSound(var_0_10.Sound.UI_EVENT_ROLE_FORM_INTERFACE)
	var_0_5:pushPopup(var_44_2, {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function ExplorationFormationComp:sortKnightFunc(arg_48_1, arg_48_2)
	local var_48_0 = arg_48_1:getServerId()
	local var_48_1 = arg_48_2:getServerId()
	local var_48_2 = self._formationData:isUsingKnight(var_48_0) and 1 or 0
	local var_48_3 = self._formationData:isUsingKnight(var_48_1) and 1 or 0

	if var_48_2 ~= var_48_3 then
		return var_48_3 < var_48_2
	end

	local var_48_4 = arg_48_1:getQuality()
	local var_48_5 = arg_48_2:getQuality()

	if var_48_4 ~= var_48_5 then
		return var_48_5 < var_48_4
	end

	local var_48_6 = arg_48_1:getStarLv()
	local var_48_7 = arg_48_2:getStarLv()

	if var_48_6 ~= var_48_7 then
		return var_48_7 < var_48_6
	end

	local var_48_8 = arg_48_1:getAdvanceId()
	local var_48_9 = arg_48_2:getAdvanceId()

	if var_48_8 ~= var_48_9 then
		return var_48_9 < var_48_8
	end

	return (self._formationData:isLineUpKnight(var_48_0) and 1 or 0) > (self._formationData:isLineUpKnight(var_48_1) and 1 or 0)
end

function ExplorationFormationComp:_onClickPlaceCellArtifactIcon(arg_49_1)
	if not self._mulFormationStruct:isStationPosLineupKnight(arg_49_1) then
		var_0_5:tip(var_0_0:get(200041))

		return
	end

	local var_49_0 = self._mulFormationStruct:getArtifactSid(arg_49_1)
	local var_49_1 = self._formationData:getKnightByServerId((self._mulFormationStruct:getKnightSid(arg_49_1)))
	local var_49_2 = var_49_1 and var_49_1:getAdvanceId()
	local var_49_3

	var_49_3 = require("app.view.base.infoPop.lineup.CommonLineUpArtifactPop").new({
		itemUrl = "ui://exploration/ExplorationFormationLineupArtifactCell",
		isFilter = true,
		allList = self._formationData:getAllArtifactList(),
		isLineUpCall = handler(self, function(arg_50_0, arg_50_1)
			return arg_50_0._formationData:isArtifactLineup(arg_50_1:getServerOnlyId())
		end),
		clickCheckFunc = handler(self, function(arg_51_0, arg_51_1)
			if not arg_51_1:checkWearKnight(var_49_2) then
				var_0_5:tip(g.core.lang:get(205539))

				return false
			end

			local var_51_0 = arg_51_1:getServerOnlyId()

			if arg_51_0._mulFormationStruct:isArtifactLineUp(var_51_0) then
				local var_51_1, var_51_2 = arg_51_0._mulFormationStruct:getArtifactStationPos(var_51_0)

				if arg_49_1 == var_51_1 then
					var_0_5:tip(var_0_0:get(200030))

					return false
				else
					local var_51_3 = arg_51_0._formationData:getArtifactByServerId(var_49_0)

					if var_51_3 then
						local var_51_4 = arg_51_0._formationData:getKnightByServerId((arg_51_0._mulFormationStruct:getKnightSid(var_51_1)))

						if var_51_4 and not var_51_3:checkWearKnight(var_51_4:getAdvanceId()) then
							var_0_5:tip(g.core.lang:get(205539))

							return false
						end
					end

					arg_51_0._mulFormationStruct:takeOffArtifact(var_51_2)
					arg_51_0._mulFormationStruct:lineupArtifact(arg_49_1, var_51_0)
					arg_51_0:_updatePlaceCells()

					return true
				end
			elseif arg_51_0._formationData:isArtifactLineup(var_51_0) then
				local var_51_5 = arg_51_0._formationData:getFormationStructArtifactLineup(var_51_0)
				local var_51_6, var_51_7 = var_51_5:getArtifactStationPos(var_51_0)
				local var_51_8 = arg_51_0._formationData:getArtifactByServerId(var_49_0)
				local var_51_10, var_51_11

				if var_51_8 then
					local var_51_9 = arg_51_0._formationData:getKnightByServerId((var_51_5:getKnightSid(var_51_6)))

					if var_51_9 and not var_51_8:checkWearKnight(var_51_9:getAdvanceId()) then
						g.core.module.ModuleManager:tip(g.core.lang:get(205539))

						do return false end

						var_51_10 = {
							type = var_0_6.TYPE_ARTIFACT,
							value = arg_51_1:getArtifactBaseId()
						}
						var_51_11 = {}
					end
				end

				var_51_11.num = var_51_5:getFormationIdx()
				var_51_10.teamName = var_0_0:get(200027, var_51_11)

				var_0_5:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_0:get(200028, {
						name = var_0_0:get(103032),
						num = arg_51_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						var_51_10
					},
					onConfirm = handler(arg_51_0, function(arg_52_0)
						var_51_5:takeOffArtifact(var_51_7)
						arg_52_0._mulFormationStruct:lineupArtifact(arg_49_1, var_51_0)
						arg_52_0._placeCellArr[arg_49_1]:updateCell(arg_52_0._mulFormationStruct)
						arg_52_0:_updateFightValue(var_0_4.FRESH.ARTIFACT)
						var_0_5:onlyPopSelfByDisplay(var_49_3)
					end)
				}))

				return false
			else
				arg_51_0._mulFormationStruct:lineupArtifact(arg_49_1, var_51_0)
				arg_51_0._placeCellArr[arg_49_1]:updateCell(arg_51_0._mulFormationStruct)
				arg_51_0:_updateFightValue(var_0_4.FRESH.ARTIFACT)

				return true
			end
		end),
		isRelated = function(self)
			return self:getBelongToKnightAvdIdIncludingMainRole() == var_49_2
		end,
		cellParam = {
			knightAdvId = var_49_2
		}
	})

	var_0_5:pushPopup(nil, {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function ExplorationFormationComp:onUnload()
	if self._formationData:isModified() then
		g.core.network.GameNetProxy:send_C2S_Formation_Save({
			tp = var_0_4.MulTeamType.EXPLORATION,
			formations = self._formationData:getOutBaseFormationArr()
		})
	end

	local var_54_0 = fgui.DragDropManager:getInstance():getAgent()

	var_54_0:removeEventListener(fgui.UIEventType.DragMove, var_0_2)
	var_54_0:removeEventListener(fgui.UIEventType.DragEnd, var_0_2)
end

return ExplorationFormationComp
