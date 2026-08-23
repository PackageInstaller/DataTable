local var_0_0 = g.core.lang
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.BASE_CONST.DRAG_TAG.TEAM_BATTLE_FORMATION
local var_0_3 = g.core.model.User.teamBattleData
local var_0_4 = g.core.const.ConstMgr.LineUpConst
local var_0_5 = g.core.module.ModuleManager
local var_0_6 = g.core.common.Goods
local var_0_7 = g.core.common.ModuleUnlock
local var_0_8 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_9 = g.core.sound.SoundManager
local var_0_10 = g.core.const.ConstMgr.SoundConst
local TeamBattleFormationComp = class("TeamBattleFormationComp", require("app.fairyGUI.teamBattle.UI_TeamBattleFormationComp"))

function TeamBattleFormationComp:ctor()
	self._placeCellStartDragStationPos = 0
	self._petStartDragStationPos = 0
	self._succStartDragStationPos = 0
	self._uniteTokenStartDragStationPos = 0
	self._isDragArtifact = false
	self._triggeredDropEvent = false
	self._updateAllRedPoint = true
	self._enterBattle = false
	self._saveSchedule = nil
	self._formationData = var_0_3:getFormationData()
	self._mulFormationStruct = nil
	self._placeCellArr = self:_getPlaceCellArr()
	self._clickSaveBtn = false

	self:initView()
end

function TeamBattleFormationComp:initView()
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
	self.m_petBtn:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(var_0_1.FUNCTION_TYPE.PET)))

	local var_2_0 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_1.FUNCTION_TYPE.SUCCUBA)

	self.m_succubaBtn:setVisible(false)
end

function TeamBattleFormationComp:_getPlaceCellArr()
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

function TeamBattleFormationComp:_onPetListRenderer(arg_4_1, arg_4_2)
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

function TeamBattleFormationComp:_onUniteTokenListRenderer(arg_5_1, arg_5_2)
	arg_5_2:setFormationType(self._mulFormationStruct:getFormationType())
	arg_5_2:updateComp(arg_5_1 + 1, self._mulFormationStruct:getUniteTokenSid(arg_5_1 + 1), self._mulFormationStruct:getMulIndex())

	if arg_5_2:hasEventListener(fgui.UIEventType.DragStart) then
		-- block empty
	else
		arg_5_2:setDraggable(true)
		arg_5_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onUniteTokenCompDragStart))
		arg_5_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onUniteTokenCompDrop))
	end
end

function TeamBattleFormationComp:_onSuccubaListRenderer(arg_6_1, arg_6_2)
	arg_6_2:setFormationType(self._mulFormationStruct:getFormationType())
	arg_6_2:updateComp(arg_6_1 + 1, self._mulFormationStruct:getSuccubaSid(arg_6_1 + 1), self._mulFormationStruct:getMulIndex(), self._mulFormationStruct:getFormationType())

	if var_0_7:isModuleUnlock(var_0_8.SUCCUBA) then
		if arg_6_2:hasEventListener(fgui.UIEventType.DragStart) then
			-- block empty
		else
			arg_6_2:setDraggable(true)
			arg_6_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onSuccubaCompDragStart))
			arg_6_2:addEventListener(fgui.UIEventType.Drop, handler(self, self._onSuccubaCompDrop))
		end
	else
		arg_6_2:setDraggable(false)
	end
end

function TeamBattleFormationComp:_onPetCompDragStart(arg_7_1)
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

		local var_7_2 = arg_7_1:getInput()
		local var_7_3 = fgui.DragDropManager:getInstance()

		var_7_3.startDrag(var_7_2, var_7_0:getResourceURL(), var_7_1, (var_7_2:getTouchId()))

		local var_7_4 = var_7_3:getAgent()
		local var_7_5 = var_7_4:getComponent()

		var_7_5:bindLua("app.view.module.teamBattle.view.formation.comp.TeamBattleFormationPetComp")
		var_7_5:becomeTo(var_7_0)
		var_7_4:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPetCompDragEnd), var_0_2)
	end
end

function TeamBattleFormationComp:_onPetCompDrop(arg_8_1)
	if self._petStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	self._mulFormationStruct:lineupPet(arg_8_1:getSender():getStationPos(), (self._mulFormationStruct:getPetSid(self._petStartDragStationPos)))
	self.m_petList:setNumItems(var_0_1.PetConst.LINEUP_MAX)
	self:_updateFightValue(var_0_4.FRESH.PET)
end

function TeamBattleFormationComp:_onPetCompDragEnd(arg_9_1)
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

function TeamBattleFormationComp:_onUniteTokenCompDrop(arg_10_1)
	if self._uniteTokenStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	self._mulFormationStruct:lineupUniteToken(arg_10_1:getSender():getStationPos(), (self._mulFormationStruct:getUniteTokenSid(self._uniteTokenStartDragStationPos)))
	self.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
	self:_updateFightValue(var_0_4.FRESH.UNITE)
end

function TeamBattleFormationComp:_onUniteTokenCompDragStart(arg_11_1)
	self._triggeredDropEvent = false

	arg_11_1:preventDefault()
	arg_11_1:stopPropagation()

	local var_11_0 = arg_11_1:getSender()

	if var_11_0:isEmpty() then
		self._uniteTokenStartDragStationPos = 0
	else
		local var_11_1 = var_11_0:getStationPos()

		self._uniteTokenStartDragStationPos = var_11_1

		var_11_0:onDragStart()

		local var_11_2 = arg_11_1:getInput()
		local var_11_3 = fgui.DragDropManager:getInstance()

		var_11_3.startDrag(var_11_2, var_11_0:getResourceURL(), var_11_1, (var_11_2:getTouchId()))

		local var_11_4 = var_11_3:getAgent()
		local var_11_5 = var_11_4:getComponent()

		var_11_5:bindLua("app.view.module.teamBattle.view.formation.comp.TeamBattleFormationUniteTokenComp")
		var_11_5:becomeTo(var_11_0)
		var_11_4:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onUniteTokenCompDragEnd), var_0_2)
	end
end

function TeamBattleFormationComp:_onUniteTokenCompDragEnd(arg_12_1)
	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._uniteTokenStartDragStationPos = 0

		return
	end

	local var_12_0 = self._uniteTokenStartDragStationPos

	self._uniteTokenStartDragStationPos = 0

	self._mulFormationStruct:lineupUniteToken(var_12_0, 0)
	self.m_uniteTokenList:getChildAt(var_12_0 - 1):updateComp(var_12_0, 0, self._mulFormationStruct and self._mulFormationStruct:getMulIndex())
	self:_updateFightValue(var_0_4.FRESH.UNITE)
end

function TeamBattleFormationComp:_onSuccubaCompDragStart(arg_13_1)
	self._triggeredDropEvent = false

	arg_13_1:preventDefault()
	arg_13_1:stopPropagation()

	local var_13_0 = arg_13_1:getSender()

	if var_13_0:isEmpty() then
		self._succStartDragStationPos = 0
	else
		local var_13_1 = var_13_0:getStationPos()

		self._succStartDragStationPos = var_13_1

		var_13_0:onDragStart()

		local var_13_2 = arg_13_1:getInput()
		local var_13_3 = fgui.DragDropManager:getInstance()

		var_13_3.startDrag(var_13_2, var_13_0:getResourceURL(), var_13_1, (var_13_2:getTouchId()))

		local var_13_4 = var_13_3:getAgent()
		local var_13_5 = var_13_4:getComponent()

		var_13_5:bindLua("app.view.module.teamBattle.view.formation.comp.TeamBattleFormationSuccubaComp")
		var_13_5:becomeTo(var_13_0)
		var_13_4:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onSuccubaCompDragEnd), var_0_2)
	end
end

function TeamBattleFormationComp:_onSuccubaCompDrop(arg_14_1)
	if self._succStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	local var_14_0 = arg_14_1:getSender()

	var_14_0:onDragEnd()
	self._mulFormationStruct:lineupSuccuba(var_14_0:getStationPos(), (self._mulFormationStruct:getSuccubaSid(self._succStartDragStationPos)))
	self.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)
end

function TeamBattleFormationComp:_onSuccubaCompDragEnd(arg_15_1)
	local var_15_0 = arg_15_1:getSender()

	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._succStartDragStationPos = 0

		return
	end

	local var_15_1 = self._succStartDragStationPos

	self._succStartDragStationPos = 0

	self._mulFormationStruct:lineupSuccuba(var_15_1, 0)
	self.m_succubaList:getChildAt(var_15_1 - 1):updateComp(var_15_1, 0, self._mulFormationStruct and self._mulFormationStruct:getMulIndex())
end

function TeamBattleFormationComp:_onClickPetListItem(arg_16_1)
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
		itemUrl = "ui://teamBattle/TeamBattleLineUpPetCell",
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

function TeamBattleFormationComp:_onClickUniteTokenListItem(arg_20_1)
	local var_20_0 = arg_20_1:getDataValue() + 1
	local var_20_1

	var_20_1 = require("app.view.base.infoPop.lineup.CommonLineUpUnitePop").new({
		itemUrl = "ui://teamBattle/TeamBattleLineUpUniteTokenCell",
		isFilter = true,
		allList = self._formationData:getAllUniteTokenList(),
		isLineUpCall = handler(self, function(arg_21_0, arg_21_1)
			return arg_21_0._formationData:isUniteTokenLineup(arg_21_1:getServerId())
		end),
		clickCheckFunc = handler(self, function(arg_22_0, arg_22_1)
			local var_22_0 = arg_22_1:getServerId()

			if arg_22_0._mulFormationStruct:isUniteTokenLineUp(var_22_0) then
				local var_22_1, var_22_2 = arg_22_0._mulFormationStruct:getUniteTokenStationPos(var_22_0)

				if var_22_1 == var_20_0 then
					var_0_5:tip(var_0_0:get(200032))

					return false
				else
					arg_22_0._mulFormationStruct:takeOffUniteToken(var_22_2)
					arg_22_0._mulFormationStruct:lineupUniteToken(var_20_0, var_22_0)
					arg_22_0.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
					arg_22_0:_updateFightValue(var_0_4.FRESH.UNITE)

					return true
				end
			elseif arg_22_0._formationData:isUniteTokenLineup(var_22_0) then
				local var_22_3 = arg_22_0._formationData:getFormationStructUniteTokenLineup(var_22_0)
				local var_22_4, var_22_5 = var_22_3:getUniteTokenStationPos(var_22_0)

				var_0_5:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_0:get(200028, {
						name = var_0_0:get(103031),
						num = arg_22_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						{
							type = var_0_6.TYPE_UNITETOKEN,
							value = arg_22_1:getBaseId(),
							teamName = var_0_0:get(200027, {
								num = var_22_3:getFormationIdx()
							})
						}
					},
					onConfirm = handler(arg_22_0, function(arg_23_0)
						var_22_3:takeOffUniteToken(var_22_5)
						arg_23_0._mulFormationStruct:lineupUniteToken(var_20_0, var_22_5)
						arg_23_0.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
						arg_23_0:_updateFightValue(var_0_4.FRESH.UNITE)
						var_0_5:onlyPopSelfByDisplay(var_20_1)
					end)
				}))

				return false
			else
				arg_22_0._mulFormationStruct:lineupUniteToken(var_20_0, var_22_0)
				arg_22_0.m_uniteTokenList:setNumItems(var_0_1.UniteTokenConst.FORMAT_UNITE_NUM_MAX)
				arg_22_0:_updateFightValue(var_0_4.FRESH.UNITE)

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

function TeamBattleFormationComp:_onClickSuccubaListItem(arg_24_1)
	local var_24_0 = arg_24_1:getDataValue() + 1

	if not var_0_7:isModuleUnlock(var_0_8.SUCCUBA) then
		local var_24_1, var_24_2 = var_0_7:getModuleUnlockLevelAndComment(var_0_8.SUCCUBA)

		var_0_5:tip(var_0_0:get(202514, {
			level = var_24_1
		}))

		return
	end

	var_0_5:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpSuccubaPop").new({
		itemUrl = "ui://infoPop/CommonLineUpSuccubaCell",
		isFilter = true,
		allList = g.core.model.User.succubaData:getSuccubaList(),
		isLineUpCall = handler(self, function(arg_25_0, arg_25_1)
			return arg_25_0._mulFormationStruct:isSuccubaLineUp(arg_25_1:getSid())
		end),
		clickCheckFunc = handler(self, function(arg_26_0, arg_26_1)
			local var_26_0 = arg_26_1:getSid()

			if arg_26_0._mulFormationStruct:isSuccubaLineUp(var_26_0) then
				if var_24_0 == arg_26_0._mulFormationStruct:getSuccubaStationPos(var_26_0) then
					var_0_5:tip(var_0_0:get(200031))

					return false
				else
					arg_26_0._mulFormationStruct:takeOffSuccuba(var_26_0)
					arg_26_0._mulFormationStruct:lineupSuccuba(var_24_0, var_26_0)
					arg_26_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)

					return true
				end
			else
				arg_26_0._mulFormationStruct:lineupSuccuba(var_24_0, var_26_0)
				arg_26_0.m_succubaList:setNumItems(var_0_1.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX)

				return true
			end
		end),
		cellParam = {}
	}), {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function TeamBattleFormationComp:_onPlaceCellDragStart(arg_27_1)
	self._triggeredDropEvent = false

	arg_27_1:preventDefault()
	arg_27_1:stopPropagation()

	local var_27_0 = arg_27_1:getSender()
	local var_27_1 = arg_27_1:getInput()

	if var_27_0.m_artifactComp:containPoint((var_27_1:getTouch():getLocation())) then
		if var_27_0.m_artifactComp:isEmpty() then
			self._placeCellStartDragStationPos = 0

			return
		else
			self._isDragArtifact = true
			self._placeCellStartDragStationPos = var_27_0.m_artifactComp:getStationPos()

			var_27_0.m_artifactComp:onDragStart()

			local var_27_2 = fgui.DragDropManager:getInstance()

			var_27_2:startDrag(var_27_0.m_artifactComp:getResourceURL(), self._placeCellStartDragStationPos, var_27_1:getTouchId())

			local var_27_3 = var_27_2:getAgent()
			local var_27_4 = var_27_3:getComponent()

			var_27_4:bindLua(var_27_4:getRemark())
			var_27_4:becomeTo(var_27_0.m_artifactComp)
			var_27_3:addEventListener(fgui.UIEventType.DragMove, handler(self, self._onPlaceCellDragMove), var_0_2)
			var_27_3:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPlaceCellDragEnd), var_0_2)
		end
	elseif var_27_0.m_knightComp:isEmpty() then
		self._placeCellStartDragStationPos = 0

		return
	else
		self._isDragArtifact = false
		self._placeCellStartDragStationPos = var_27_0:getStationPos()

		var_27_0:onDragStart()

		local var_27_5 = fgui.DragDropManager:getInstance()

		var_27_5:startDrag(var_27_0:getResourceURL(), self._placeCellStartDragStationPos, var_27_1:getTouchId())

		local var_27_6 = var_27_5:getAgent()
		local var_27_7 = var_27_6:getComponent()

		var_27_7:bindLua(var_27_7:getRemark())
		var_27_7:becomeTo(var_27_0)
		var_27_6:addEventListener(fgui.UIEventType.DragMove, handler(self, self._onPlaceCellDragMove), var_0_2)
		var_27_6:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onPlaceCellDragEnd), var_0_2)
	end
end

function TeamBattleFormationComp:_onPlaceCellDragMove(arg_28_1)
	local var_28_0 = arg_28_1:getInput():getTouch():getLocation()

	for iter_28_0, iter_28_1 in ipairs(self._placeCellArr) do
		iter_28_1:playHoveringAni((iter_28_1:containPoint(var_28_0)))
	end
end

function TeamBattleFormationComp:_onPlaceCellDragEnd(arg_29_1)
	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, var_0_2)

	if self._triggeredDropEvent then
		self._triggeredDropEvent = false
		self._placeCellStartDragStationPos = 0

		return
	end

	local var_29_0 = self._placeCellStartDragStationPos

	self._placeCellStartDragStationPos = 0

	local var_29_1 = self._placeCellArr[var_29_0]

	if self._isDragArtifact then
		self._mulFormationStruct:lineupArtifact(var_29_0, 0)
	else
		self._mulFormationStruct:lineupKnight(var_29_0, 0)
	end

	self:_updateFightValue(var_0_4.FRESH.KNIGHT)
	var_29_1:onDragEnd()
end

function TeamBattleFormationComp:_onPlaceCellDrop(arg_30_1)
	if self._placeCellStartDragStationPos == 0 then
		return
	end

	self._triggeredDropEvent = true

	local var_30_0 = arg_30_1:getSender()
	local var_30_1 = var_30_0:getStationPos()

	if self._isDragArtifact then
		if self._mulFormationStruct:isStationPosLineupKnight(var_30_1) then
			local var_30_2 = self._mulFormationStruct:getArtifactSid(self._placeCellStartDragStationPos)
			local var_30_3 = self._formationData:getKnightByServerId((self._mulFormationStruct:getKnightSid(var_30_1)))

			if var_30_3 and not self._formationData:getArtifactByServerId(var_30_2):checkWearKnight(var_30_3:getAdvanceId()) then
				g.core.module.ModuleManager:tip(g.core.lang:get(205539))
				self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(self._mulFormationStruct)
				var_30_0:playDropAni()

				return
			end

			local var_30_4 = self._formationData:getArtifactByServerId((self._mulFormationStruct:getArtifactSid(var_30_1)))

			if var_30_4 then
				local var_30_5 = self._formationData:getKnightByServerId((self._mulFormationStruct:getKnightSid(self._placeCellStartDragStationPos)))

				if var_30_5 and not var_30_4:checkWearKnight(var_30_5:getAdvanceId()) then
					g.core.module.ModuleManager:tip(g.core.lang:get(205539))
					self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(self._mulFormationStruct)
					var_30_0:playDropAni()

					return
				end
			end

			self._mulFormationStruct:lineupArtifact(var_30_1, var_30_2)
			self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:updateComp(self._mulFormationStruct)
			var_30_0.m_artifactComp:updateComp(self._mulFormationStruct)
			var_30_0:playDropAni()
		else
			var_0_5:tip(var_0_0:get(200041))
			self._placeCellArr[self._placeCellStartDragStationPos].m_artifactComp:onDragEnd()
			self._placeCellArr[self._placeCellStartDragStationPos]:playDropAni()
			var_30_0:playHoveringAni(false)

			return
		end
	else
		self._mulFormationStruct:lineupKnight(var_30_1, (self._mulFormationStruct:getKnightSid(self._placeCellStartDragStationPos)))
		self._placeCellArr[self._placeCellStartDragStationPos]:updateCell(self._mulFormationStruct)
		self._placeCellArr[self._placeCellStartDragStationPos].m_knightComp:playKnightLineupAni()
		var_30_0:updateCell(self._mulFormationStruct)
		var_30_0:playDropAni()
		var_30_0.m_knightComp:playKnightLineupAni()
	end

	self:_updateFightValue(var_0_4.FRESH.KNIGHT)
end

function TeamBattleFormationComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._onS2CFormationSave), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_FIGHTVALUE, handler(self, self._onS2CFormationFightValue), self)
end

function TeamBattleFormationComp:_onS2CFormationFightValue()
	if not self._enterBattle then
		self.m_powerTxt:setText(self._mulFormationStruct:getFightValue())
	end

	self:unSaveSchedule()
end

function TeamBattleFormationComp:_onS2CFormationSave()
	self:_updateFightValue()
end

function TeamBattleFormationComp:updateComp(arg_34_1)
	self._updateAllRedPoint = true
	self._mulFormationStruct = self._formationData:getFormationStruct(arg_34_1)

	self:_updateComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ALL)
end

function TeamBattleFormationComp:_updateComp()
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
		self.m_succubaBtn:getRedPointComp():setCustomData({
			formationIndex = self._mulFormationStruct:getMulIndex()
		})
	end

	self._mulIndex = self._mulFormationStruct:getMulIndex()
end

function TeamBattleFormationComp:_updatePlaceCells(arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(self._placeCellArr) do
		iter_36_1:updateCell(self._mulFormationStruct)

		if arg_36_1 then
			iter_36_1.m_knightComp:playKnightLineupAni()
		end
	end

	self:_updateFightValue(var_0_1.LineUpConst.FRESH.KNIGHT)
end

function TeamBattleFormationComp:setEnterBattle(arg_37_1)
	self._enterBattle = arg_37_1 == true
end

function TeamBattleFormationComp:_updateFightValue(arg_38_1)
	local var_38_0 = g.core.common.ServerTime:getTime()

	if var_38_0 - self._formationData:getLastSyncTime() > var_0_4.REFRESH_FIGHT_VALUE_TIME and self._mulFormationStruct:isModified() then
		if (self._mulFormationStruct:getFormationType() == var_0_4.MulTeamType.CROSS_SERVER_ARENA or nil) and g.core.model.User.crossServerArenaData:isFormationValid() then
			self._formationData:setLastSyncTime(var_38_0)
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

	if arg_38_1 then
		if arg_38_1 == var_0_4.FRESH.KNIGHT then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_KNIGHT)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ARTIFACT)
		elseif arg_38_1 == var_0_4.FRESH.ARTIFACT then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ARTIFACT)
		elseif arg_38_1 == var_0_4.FRESH.UNITE then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_UNITE)
		elseif arg_38_1 == var_0_4.FRESH.PET then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_PET)
		end
	end

	self:dispatchCompEvent("CompEventFormationChanged")
end

function TeamBattleFormationComp:addSaveSchedule()
	self._saveSchedule = self._saveSchedule or self:newScheduleOnce(handler(self, self.sendC2SFormationSave), var_0_4.REFRESH_FIGHT_VALUE_TIME + 1)
end

function TeamBattleFormationComp:unSaveSchedule()
	if self._saveSchedule then
		self:cancelSchedule(self._saveSchedule)
	end

	self._saveSchedule = nil
end

function TeamBattleFormationComp:sendC2SFormationSave()
	self._saveSchedule = nil

	local var_41_0

	if not self._mulFormationStruct then
		return false
	elseif not self._formationData:isModified() then
		do return false end

		var_41_0 = {
			tp = var_0_4.MulTeamType.TEAM_BATTLE
		}
	end

	var_41_0.formations = self._formationData:getOutBaseFormationArr()

	g.core.network.GameNetProxy:send_C2S_Formation_Save(var_41_0)

	return true
end

function TeamBattleFormationComp:receiveCompEvent(arg_42_1, arg_42_2)
	if arg_42_1 == "CompEventClickKnight" then
		self:_onClickPlaceCellKnightIcon(arg_42_2)
	elseif arg_42_1 == "CompEventClickArtifact" then
		self:_onClickPlaceCellArtifactIcon(arg_42_2)
	else
		return false
	end
end

function TeamBattleFormationComp:_onClickPlaceCellKnightIcon(arg_43_1)
	local var_43_0 = self._mulFormationStruct:getFormationIdx()
	local var_43_1 = self._placeCellArr[arg_43_1]
	local var_43_2

	var_43_2 = require("app.view.base.infoPop.lineup.CommonLineUpKnightPop").new({
		itemUrl = "ui://teamBattle/TeamBattleLineUpKnightCell",
		isFilter = true,
		allList = self._formationData:getAllKnightList(),
		isLineUpCall = handler(self, function(arg_44_0, arg_44_1)
			return arg_44_0._formationData:isUsingKnight(arg_44_1:getServerId())
		end),
		sortFunc = handler(self, self.sortKnightFunc),
		clickCheckFunc = handler(self, function(arg_45_0, arg_45_1)
			local var_45_0 = arg_45_1:getServerId()

			if arg_45_1:getHpRatio() <= 0 then
				var_0_5:tip(var_0_0:get(427146))

				return false
			end

			if not arg_45_0._mulFormationStruct:isKnightLineUp(var_45_0) and arg_45_1:isElementLeader() then
				for iter_45_0, iter_45_1 in pairs(arg_45_0._mulFormationStruct:getKnightDict()) do
					if iter_45_0 ~= arg_43_1 and iter_45_1:isElementLeader() then
						var_0_5:tip(var_0_0:get(200051))

						return false
					end
				end
			end

			if arg_45_0._mulFormationStruct:isKnightLineUp(var_45_0) then
				local var_45_1, var_45_2 = arg_45_0._mulFormationStruct:getKnightStationPos(var_45_0)

				if arg_43_1 == var_45_1 and var_45_2 == var_45_0 then
					var_0_5:tip(var_0_0:get(200004))

					return false
				else
					arg_45_0._mulFormationStruct:takeOffKnight(var_45_2)
					arg_45_0._mulFormationStruct:lineupKnight(arg_43_1, var_45_0)
					arg_45_0._formationData:autoAddArtifact(arg_45_0._mulFormationStruct, arg_43_1)
					arg_45_0:_updatePlaceCells()
					var_43_1.m_knightComp:playKnightLineupAni()

					return true
				end
			elseif arg_45_0._formationData:isKnightLineup(var_45_0) then
				local var_45_3 = arg_45_0._formationData:getFormationStructKnightLineup(var_45_0)
				local var_45_4, var_45_5 = var_45_3:getKnightStationPos(var_45_0)

				var_0_5:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_0:get(200028, {
						name = var_0_0:get(103028),
						num = var_43_0
					}),
					itemDataArr = {
						{
							type = var_0_6.TYPE_KNIGHT,
							value = arg_45_1:getBaseId(),
							teamName = var_0_0:get(200027, {
								num = var_45_3:getFormationIdx()
							})
						}
					},
					onConfirm = handler(arg_45_0, function(arg_46_0)
						var_45_3:takeOffKnight(var_45_5)
						arg_46_0._mulFormationStruct:lineupKnight(arg_43_1, var_45_0)
						arg_46_0._formationData:autoAddArtifact(arg_46_0._mulFormationStruct, arg_43_1)
						var_43_1:updateCell(arg_46_0._mulFormationStruct)
						var_43_1.m_knightComp:playKnightLineupAni()
						arg_46_0:_updateFightValue(var_0_4.FRESH.KNIGHT)
						var_0_5:onlyPopSelfByDisplay(var_43_2)
					end)
				}))

				return false
			else
				arg_45_0._mulFormationStruct:lineupKnight(arg_43_1, var_45_0)
				arg_45_0._formationData:autoAddArtifact(arg_45_0._mulFormationStruct, arg_43_1)
				var_43_1:updateCell(arg_45_0._mulFormationStruct)
				var_43_1.m_knightComp:playKnightLineupAni()
				arg_45_0:_updateFightValue(var_0_4.FRESH.KNIGHT)

				return true
			end
		end),
		cellParam = {
			formationIdx = var_43_0,
			stationPos = arg_43_1
		}
	})

	var_0_9:playSound(var_0_10.Sound.UI_EVENT_ROLE_FORM_INTERFACE)
	var_0_5:pushPopup(var_43_2, {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function TeamBattleFormationComp:sortKnightFunc(arg_47_1, arg_47_2)
	local var_47_0 = arg_47_1:getServerId()
	local var_47_1 = arg_47_2:getServerId()
	local var_47_2 = self._formationData:isUsingKnight(var_47_0) and 1 or 0
	local var_47_3 = self._formationData:isUsingKnight(var_47_1) and 1 or 0
	local var_47_4 = arg_47_1:getHpPercent() > 0

	if var_47_4 ~= (arg_47_2:getHpPercent() > 0) then
		return var_47_4
	end

	if var_47_2 ~= var_47_3 then
		return var_47_3 < var_47_2
	end

	local var_47_5 = arg_47_1:getQuality()
	local var_47_6 = arg_47_2:getQuality()

	if var_47_5 ~= var_47_6 then
		return var_47_6 < var_47_5
	end

	local var_47_7 = arg_47_1:getStarLv()
	local var_47_8 = arg_47_2:getStarLv()

	if var_47_7 ~= var_47_8 then
		return var_47_8 < var_47_7
	end

	local var_47_9 = arg_47_1:getAdvanceId()
	local var_47_10 = arg_47_2:getAdvanceId()

	if var_47_9 ~= var_47_10 then
		return var_47_10 < var_47_9
	end

	return (self._formationData:isLineUpKnight(var_47_0) and 1 or 0) > (self._formationData:isLineUpKnight(var_47_1) and 1 or 0)
end

function TeamBattleFormationComp:_onClickPlaceCellArtifactIcon(arg_48_1)
	if not self._mulFormationStruct:isStationPosLineupKnight(arg_48_1) then
		var_0_5:tip(var_0_0:get(200041))

		return
	end

	local var_48_0 = self._mulFormationStruct:getArtifactSid(arg_48_1)
	local var_48_1 = self._formationData:getKnightByServerId((self._mulFormationStruct:getKnightSid(arg_48_1)))
	local var_48_2 = var_48_1 and var_48_1:getAdvanceId()
	local var_48_3

	var_48_3 = require("app.view.base.infoPop.lineup.CommonLineUpArtifactPop").new({
		itemUrl = "ui://teamBattle/TeamBattleLineUpArtifactCell",
		isFilter = true,
		allList = self._formationData:getAllArtifactList(),
		isLineUpCall = handler(self, function(arg_49_0, arg_49_1)
			return arg_49_0._formationData:isArtifactLineup(arg_49_1:getServerOnlyId())
		end),
		clickCheckFunc = handler(self, function(arg_50_0, arg_50_1)
			if not arg_50_1:checkWearKnight(var_48_2) then
				var_0_5:tip(g.core.lang:get(205539))

				return false
			end

			local var_50_0 = arg_50_1:getServerOnlyId()

			if arg_50_0._mulFormationStruct:isArtifactLineUp(var_50_0) then
				local var_50_1, var_50_2 = arg_50_0._mulFormationStruct:getArtifactStationPos(var_50_0)

				if arg_48_1 == var_50_1 then
					var_0_5:tip(var_0_0:get(200030))

					return false
				else
					local var_50_3 = arg_50_0._formationData:getArtifactByServerId(var_48_0)

					if var_50_3 then
						local var_50_4 = arg_50_0._formationData:getKnightByServerId((arg_50_0._mulFormationStruct:getKnightSid(var_50_1)))

						if var_50_4 and not var_50_3:checkWearKnight(var_50_4:getAdvanceId()) then
							var_0_5:tip(g.core.lang:get(205539))

							return false
						end
					end

					arg_50_0._mulFormationStruct:takeOffArtifact(var_50_2)
					arg_50_0._mulFormationStruct:lineupArtifact(arg_48_1, var_50_0)
					arg_50_0:_updatePlaceCells()

					return true
				end
			elseif arg_50_0._formationData:isArtifactLineup(var_50_0) then
				local var_50_5 = arg_50_0._formationData:getFormationStructArtifactLineup(var_50_0)
				local var_50_6, var_50_7 = var_50_5:getArtifactStationPos(var_50_0)
				local var_50_8 = arg_50_0._formationData:getArtifactByServerId(var_48_0)
				local var_50_10, var_50_11

				if var_50_8 then
					local var_50_9 = arg_50_0._formationData:getKnightByServerId((var_50_5:getKnightSid(var_50_6)))

					if var_50_9 and not var_50_8:checkWearKnight(var_50_9:getAdvanceId()) then
						g.core.module.ModuleManager:tip(g.core.lang:get(205539))

						do return false end

						var_50_10 = {
							type = var_0_6.TYPE_ARTIFACT,
							value = arg_50_1:getArtifactBaseId()
						}
						var_50_11 = {}
					end
				end

				var_50_11.num = var_50_5:getFormationIdx()
				var_50_10.teamName = var_0_0:get(200027, var_50_11)

				var_0_5:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = var_0_0:get(200028, {
						name = var_0_0:get(103032),
						num = arg_50_0._mulFormationStruct:getFormationIdx()
					}),
					itemDataArr = {
						var_50_10
					},
					onConfirm = handler(arg_50_0, function(arg_51_0)
						var_50_5:takeOffArtifact(var_50_7)
						arg_51_0._mulFormationStruct:lineupArtifact(arg_48_1, var_50_0)
						arg_51_0._placeCellArr[arg_48_1]:updateCell(arg_51_0._mulFormationStruct)
						arg_51_0:_updateFightValue(var_0_4.FRESH.ARTIFACT)
						var_0_5:onlyPopSelfByDisplay(var_48_3)
					end)
				}))

				return false
			else
				arg_50_0._mulFormationStruct:lineupArtifact(arg_48_1, var_50_0)
				arg_50_0._placeCellArr[arg_48_1]:updateCell(arg_50_0._mulFormationStruct)
				arg_50_0:_updateFightValue(var_0_4.FRESH.ARTIFACT)

				return true
			end
		end),
		isRelated = function(self)
			return self:getBelongToKnightAvdIdIncludingMainRole() == var_48_2
		end,
		cellParam = {
			knightAdvId = var_48_2
		}
	})

	var_0_5:pushPopup(nil, {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function TeamBattleFormationComp:onUnload()
	if self._formationData:isModified() then
		g.core.network.GameNetProxy:send_C2S_Formation_Save({
			tp = var_0_4.MulTeamType.TEAM_BATTLE,
			formations = self._formationData:getOutBaseFormationArr()
		})
	end

	local var_53_0 = fgui.DragDropManager:getInstance():getAgent()

	var_53_0:removeEventListener(fgui.UIEventType.DragMove, var_0_2)
	var_53_0:removeEventListener(fgui.UIEventType.DragEnd, var_0_2)
end

return TeamBattleFormationComp
