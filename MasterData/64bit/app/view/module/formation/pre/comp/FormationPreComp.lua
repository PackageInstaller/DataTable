local var_0_0 = g.core.common.Path
local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_3 = g.core.model.User.formationData
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = g.core.module.ModuleManager
local var_0_6 = g.core.common.ModuleUnlock
local var_0_7 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_8 = g.core.const.ConstMgr.FormationConst
local FormationPreComp = class("FormationPreComp", require("app.fairyGUI.formation.UI_FormationPreComp"))
local var_0_10 = 201
local var_0_11 = "drag_pre_knight"

function FormationPreComp:ctor(arg_1_1)
	self._posHpList = nil
	self._knightComps = {}
	self._formationIndex = 0
	self._formationPreStruct = nil
	self._clickPos = 0
	self._isOtherUser = false
	self._starPos = 0
	self._localPos = 0
	self._nextPos = 0
	self._skillPos = {}
	self._curComp = nil
	self._isDragKnight = false
	self._isUseClicking = false

	self:_initView(arg_1_1)
	self:addListen(self.m_changeComp)
end

function FormationPreComp:_initView(arg_2_1)
	self.m_bottomComp:setSize(display.width, display.height)

	local var_2_0 = 1

	while self["m_knight" .. var_2_0] do
		local var_2_1 = self["m_knight" .. var_2_0]

		self["m_knight" .. var_2_0]:setDraggable(true)
		var_2_1:addClickListener(handler(self, self._onClickKnight))
		var_2_1:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupKnight))
		self:addListen(var_2_1)
		var_2_1:setPosIndex(var_2_0)

		var_2_1.formation = var_2_0

		if self._posHpList then
			var_2_1:showPosHpBar(self._posHpList[var_2_0])
		end

		local var_2_2 = var_0_4:getKnight({
			pos = var_2_0
		})

		if var_2_2 then
			var_2_1:updateLevelAndRank(true, var_2_2:getLevel(), var_2_2:getAdvanceLevel())
		else
			var_2_1:updateLevelAndRank(false)
		end

		self._knightComps[var_2_0] = var_2_1
		var_2_0 = var_2_0 + 1
	end

	self:addListen(self.m_bottomComp)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_haloBtn:addClickListener(handler(self, self._onClickHaloPopBtn))
	self.m_assctNum:addClickListener(handler(self, self._onClickAssNum))
	self.m_useBtn:addClickListener(handler(self, self._onClickUseBtn))
	self.m_checkInterchangeBtn:addClickListener(handler(self, self._onClickInterchangeBtn))
	self.m_checkInterchangeBtn:setSelected(var_0_3:isInterchangeFormation())
	self.m_touchBg:addClickListener(handler(self, self._onHideChangeComp))
	self.m_touchBg:setVisible(false)

	if var_0_6:isModuleUnlock(var_0_7.FORMATION_PRE) then
		g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_7.FORMATION_PRE)
	end
end

function FormationPreComp:_onHideChangeComp()
	self.m_changeComp:setKnightId(0)
	self.m_changeComp:setMainKnightId(0)
	self.m_touchBg:setVisible(false)
end

function FormationPreComp:_onClickHaloPopBtn()
	var_0_5:pushPopup(require("app.view.module.lineUp.view.haloPop.LineUpHaloPop").new(self._isOtherUser and self._formationPreStruct:getOtherHaolGroupInfo() or self._formationPreStruct:getHaloGroupInfo()), {
		touchDisappear = true
	})
end

function FormationPreComp:_onClickAssNum()
	local var_5_0, var_5_1, var_5_2 = self._formationPreStruct:getAllAssCount()

	if self._isOtherUser then
		local var_5_3, var_5_4

		var_5_3, var_5_4, var_5_2 = self._formationPreStruct:getOtherAllAssCount()
	end

	var_0_5:pushPopup(require("app.view.module.tip.view.KnightAssctTip").new(nil, var_5_2), {
		touchDisappear = true
	})
end

function FormationPreComp:_onClickUseBtn()
	self._isUseClicking = false

	if self:checkFormationChange() then
		self._isUseClicking = true

		return
	end

	self:_sendUsePresetFormation()
end

function FormationPreComp:_sendUsePresetFormation()
	local var_7_0 = self._formationPreStruct:isFormationFightEnable()

	if var_7_0 == var_0_8.USE_CONDITION_STATE.KNIGHT then
		var_0_5:tip(g.core.lang:get(200029))
	elseif var_7_0 == var_0_8.USE_CONDITION_STATE.PET then
		var_0_5:tip(g.core.lang:get(200033))
	elseif self._formationPreStruct:getFormationUniqueId() > 0 then
		g.core.network.GameNetProxy:send_C2S_PresetFormation_Inherit({
			preset_id = self._formationPreStruct:getFormationUniqueId(),
			artifact_id = self._formationPreStruct:getAutoLineupArtifact()
		})
		var_0_3:refreshPreDataByCurFormation()
	end
end

function FormationPreComp:_onClickInterchangeBtn()
	var_0_3:setInterchangeFormation((self.m_checkInterchangeBtn:isSelected()))
end

function FormationPreComp:onLoad()
	fgui.DragDropManager:getInstance():getAgent():addEventListener(fgui.UIEventType.DragMove, handler(self, self._dragMoveKnight), var_0_10)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_NAMEMODIFY, handler(self, self.updateNameComp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_ERROR_SAVE, handler(self, self.updateViewBySaveEvent), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_SAVE, handler(self, self._onFormationSaveSuccess), self)
	self:updateInterChangeBtn()
end

function FormationPreComp:updateInterChangeBtn()
	self.m_checkInterchangeBtn:setSelected(var_0_3:isInterchangeFormation())
end

function FormationPreComp:updateView(arg_11_1)
	self._formationIndex = arg_11_1

	local var_11_0 = var_0_3:getPreFormation(arg_11_1)

	if var_11_0 then
		self._formationPreStruct = var_11_0

		if not self._formationPreStruct:isValidName() then
			g.core.network.GameNetProxy:send_C2S_PresetFormation_NameModify({
				id = self._formationPreStruct:getFormationUniqueId(),
				name = self._formationPreStruct:getFormationName()
			})
		end

		self:_updateKnight(true)
		self:_updateAssctNum()
		self:updateLineUpHaloCount()
		self:updateNameComp()
		self.m_bottomComp:updateComp(self._formationPreStruct)
	end
end

function FormationPreComp:updateViewBySaveEvent()
	if self._formationPreStruct then
		self:_updateKnight()
		self:_updateAssctNum()
		self:updateLineUpHaloCount()
		self:updateNameComp()
		self.m_bottomComp:updateComp(self._formationPreStruct)
	end
end

function FormationPreComp:_onFormationSaveSuccess()
	if self._isUseClicking then
		self:_sendUsePresetFormation()
	end

	self._isUseClicking = false
end

function FormationPreComp:checkFormationChange()
	if not self._isOtherUser and self._formationPreStruct and self._formationPreStruct:isChangeFormation() and var_0_3:isGetPreFormationData() then
		g.core.network.GameNetProxy:send_C2S_PresetFormation_Save({
			formations = {
				(self._formationPreStruct:toOutBaseFormation())
			}
		})
		var_0_3:setNeedSaveFormation(self._formationPreStruct)

		return true
	end

	return false
end

function FormationPreComp:updateNameComp()
	self.m_nameComp:setIsUnlock(var_0_6:isModuleUnlock(var_0_7.FORMATION_PRE))
	self.m_nameComp:updateComp(self._formationPreStruct:getFormationName(), false)
end

function FormationPreComp:_updateKnight(arg_16_1)
	for iter_16_0 = 1, #self._knightComps do
		self._knightComps[iter_16_0]:setKnightId((self._formationPreStruct:getKnightSid(iter_16_0)))
		self._knightComps[iter_16_0]:updateComp()
		self._knightComps[iter_16_0]:updateBottomShowState(true)

		if arg_16_1 then
			self._knightComps[iter_16_0]:playInAnim()
		end
	end
end

function FormationPreComp:_updateAssctNum()
	self.m_assctNum:setTitle((self._formationPreStruct:getAllAssCount()))
end

function FormationPreComp:getFormationIndex()
	return self._formationIndex
end

function FormationPreComp:_onClickKnight(arg_19_1)
	if self._isDragKnight then
		return
	end

	local var_19_0 = arg_19_1:getSender()

	self._clickPos = var_19_0.formation

	if self._isOtherUser then
		local var_19_1 = g.core.model.User.friendData:getPlayerInfo().formationData.knightStructArr[var_19_0.formation]

		if var_19_1 then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
				isOthers = true,
				knightStruct = var_19_1,
				matchInfos = self._formationPreStruct:getOtherMatchInfos(),
				knightPos = g.core.model.User.friendData:getPlayerInfo().formation.position[var_19_0.formation]
			})))
		end
	else
		local var_19_2 = var_0_3:getPreFormation(self._formationIndex):getKnightIds()[var_19_0.formation]

		if var_19_2 > 0 then
			local var_19_3 = var_19_0:getPosition()
			local var_19_4 = var_19_0:getScaleX()

			var_19_3.x = var_19_3.x + 125 * var_19_4
			var_19_3.y = var_19_3.y + 162 * var_19_4

			self.m_changeComp:setPosition(var_19_3)
			self.m_changeComp:setMainKnightId((var_0_4:getKnightByPos(var_19_0.formation):getServerId()))
			self.m_changeComp:setKnightId(var_19_2)
			self.m_touchBg:setVisible(true)
		else
			self:_changeKnight()
		end
	end
end

function FormationPreComp:_changeKnight()
	var_0_5:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpKnightPop").new({
		itemUrl = "ui://formation/FormationPreLineupKnightCell",
		isFilter = true,
		allList = var_0_4:getOwnerAllList(),
		isLineUpCall = handler(self, self._isLineupCall),
		clickCheckFunc = handler(self, self._clickLineupKnight),
		sortFunc = handler(self, self._sortFunc),
		filterStr = g.core.lang:get(200037),
		cellParam = {
			isLineupPos = true,
			formationStruct = self._formationPreStruct,
			clickPos = self._clickPos
		}
	}), {
		ignoreTouch = false,
		blackOpacity = 0.5,
		touchDisappear = false
	})
end

function FormationPreComp:_sortFunc(arg_21_1, arg_21_2)
	local var_21_0 = self._formationPreStruct:getKnightSid(self._clickPos)
	local var_21_1 = arg_21_1:getServerId()
	local var_21_2 = arg_21_2:getServerId()

	if var_21_0 ~= var_21_1 and var_21_0 == var_21_2 then
		return false
	end

	local var_21_3 = self._formationPreStruct:isKnightLineUp(var_21_1)

	if var_21_3 ~= self._formationPreStruct:isKnightLineUp(var_21_2) then
		return var_21_3
	end

	local var_21_4 = self._formationPreStruct:isPartnerLineUp(var_21_1)

	if var_21_4 ~= self._formationPreStruct:isPartnerLineUp(var_21_2) then
		return var_21_4
	end

	local var_21_5 = arg_21_1:getQuality()
	local var_21_6 = arg_21_2:getQuality()

	if var_21_5 ~= var_21_6 then
		return var_21_6 < var_21_5
	end

	local var_21_7 = self._formationPreStruct:getKnightAssCount(var_21_1, self._clickPos, true, false)
	local var_21_8 = self._formationPreStruct:getKnightAssCount(var_21_2, self._clickPos, true, false)

	if var_21_7 ~= var_21_8 then
		return var_21_8 < var_21_7
	end

	local var_21_9 = arg_21_1:getStarLv()
	local var_21_10 = arg_21_2:getStarLv()

	if var_21_9 ~= var_21_10 then
		return var_21_10 < var_21_9
	end

	return arg_21_1:getBaseId() > arg_21_2:getBaseId()
end

function FormationPreComp:_dragLineupKnight(arg_22_1)
	if not self._formationPreStruct then
		return
	end

	self._isDragKnight = true

	arg_22_1:preventDefault()

	self._curComp = arg_22_1:getSender()

	self._curComp:hideKnight(true)

	self._starPos = self._curComp.formation
	self._localPos = self._starPos

	local var_22_0 = self._formationPreStruct:getKnightSid(self._starPos) or 0

	if var_22_0 > 0 then
		local var_22_1 = arg_22_1:getInput()
		local var_22_2 = fgui.DragDropManager:getInstance()

		var_22_2.startDrag(var_22_1, "common/ui_cocos/lineUp/pic_touming.png", nil, (var_22_1:getTouchId()))

		local var_22_3 = BattleKnight.new({
			scale = 1.2,
			breath = true,
			base = true,
			resId = var_0_4:getKnight({
				id = var_22_0
			}):getResInfo().fight_id
		})

		var_22_3:setScale(1.2)
		var_22_3:setName(var_0_11)
		var_22_2:getAgent():displayObject():addChild(var_22_3)
		var_22_3:setPosition(50, 0)
		self:_updateKnightOpacity(204)
	end
end

function FormationPreComp:_dragMoveKnight(arg_23_1)
	if not self._isDragKnight then
		return
	end

	local var_23_0 = arg_23_1:getInput():getTouch()

	if not var_23_0 then
		return
	end

	local var_23_1 = var_23_0:getLocation()

	var_23_1.y = var_23_1.y - 50

	local var_23_2 = false
	local var_23_3

	for iter_23_0 = 1, #self._knightComps do
		if self._knightComps[iter_23_0].m_imgPosTouch:hitTest(var_23_1, cc.Camera:create()) then
			var_23_2 = true

			if iter_23_0 ~= self._localPos then
				var_23_3 = iter_23_0
			end
		end
	end

	if var_23_3 then
		self._nextPos = var_23_3

		self:_updateExchangeKnight()
	elseif not var_23_2 then
		self._nextPos = self._starPos

		self:_updateExchangeKnight()
	end
end

function FormationPreComp:_onTouchBegin(arg_24_1)
	arg_24_1:captureTouch()
end

function FormationPreComp:_onTouchEnd(arg_25_1)
	if not self._isDragKnight or not self._formationPreStruct then
		return
	end

	if not arg_25_1:getInput():getTouch() then
		return
	end

	self:_updateKnightOpacity(255)

	local var_25_0 = self._formationPreStruct:getKnightSid(self._starPos)

	if self._starPos ~= self._localPos then
		self._formationPreStruct:lineupKnight(self._localPos, var_25_0)
		var_0_5:tip(g.core.lang:get(200006))
		self:_updateKnight()
	elseif self._isDragKnight and self._curComp then
		self._curComp:updateComp(var_25_0 or 0)
	end

	self:_clearMoveComp()
	self:newScheduleOnce(handler(self, function()
		self._isDragKnight = false
	end), 0.02)
end

function FormationPreComp:_clearMoveComp()
	local var_27_0 = fgui.DragDropManager:getInstance():getAgent()

	if var_27_0:displayObject():getChildByName(var_0_11) then
		var_27_0:displayObject():removeChildByName(var_0_11, true)
	end
end

function FormationPreComp:onUnload()
	self._curComp = nil

	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, var_0_10)
end

function FormationPreComp:_updateKnightOpacity(arg_29_1)
	for iter_29_0 = 1, #self._knightComps do
		self._knightComps[iter_29_0]:updateKnightOpacity(arg_29_1)
	end
end

function FormationPreComp:_updateExchangeKnight()
	if not self._formationPreStruct then
		return
	end

	local var_30_0 = false

	if self._localPos ~= self._starPos then
		self._knightComps[self._localPos]:updateComp(self._formationPreStruct:getKnightSid(self._localPos) or 0)

		var_30_0 = true
	end

	self._localPos = self._nextPos

	if self._localPos ~= self._starPos then
		self._knightComps[self._starPos]:updateComp(self._formationPreStruct:getKnightSid(self._nextPos) or 0)

		var_30_0 = true
	end

	if var_30_0 then
		self._knightComps[self._localPos]:setKnightId(self._formationPreStruct:getKnightSid(self._starPos) or 0)
		self._knightComps[self._localPos]:hideKnight(true)
	end
end

function FormationPreComp:getFormationString()
	return self._formationPreStruct:toStringFormation()
end

function FormationPreComp:_isLineupCall(arg_32_1)
	if self._formationPreStruct:getKnightSid(self._clickPos) == arg_32_1:getServerId() then
		return false
	end

	return self._formationPreStruct:isKnightLineUp(arg_32_1:getServerId()) or self._formationPreStruct:isPartnerLineUp(arg_32_1:getServerId())
end

function FormationPreComp:_clickLineupKnight(arg_33_1)
	if self._clickPos > 0 then
		if arg_33_1:isElementLeader() then
			local var_33_0 = arg_33_1:getServerId()
			local var_33_1 = 0

			for iter_33_0 = 1, var_0_2.LINEUP_MAX do
				if self._formationPreStruct:getKnightSid(iter_33_0) == var_33_0 then
					var_33_1 = iter_33_0

					break
				end
			end

			for iter_33_1 = 1, var_0_2.LINEUP_MAX do
				if iter_33_1 ~= self._clickPos and iter_33_1 ~= var_33_1 then
					local var_33_2 = self._formationPreStruct:getKnightSid(iter_33_1)

					if var_33_2 and var_33_2 > 0 then
						local var_33_3 = var_0_4:getKnightById(var_33_2)

						if var_33_3 and var_33_3:isElementLeader() then
							var_0_5:tip(g.core.lang:get(200051))

							return false
						end
					end
				end
			end
		end

		self._formationPreStruct:lineupKnight(self._clickPos, arg_33_1:getServerId())

		if self._formationPreStruct:isKnightLineUp(arg_33_1:getServerId()) then
			var_0_5:tip(g.core.lang:get(200038))
		else
			var_0_5:tip(g.core.lang:get(200008))
		end
	end

	self._clickPos = 0

	self:_updateKnight()
	self:_updateAssctNum()
	self:updateLineUpHaloCount()
	self.m_bottomComp:updatePartnerView()

	return true
end

function FormationPreComp:receiveCompEvent(arg_34_1, arg_34_2)
	if arg_34_1 == "FormationBottomComp_PartnerUpdate" then
		self:_updateKnight()
		self:_updateAssctNum()
	elseif arg_34_1 == "ChangeKnight" then
		self:_changeKnight()
	elseif arg_34_1 == "LookKnight" then
		local var_34_0 = arg_34_2.mainKnightSid
		local var_34_1, var_34_2

		if not arg_34_2.mainKnightSid then
			var_34_0 = 0
			var_34_1 = require("app.view.module.formation.pre.FormationPreAssociationPop").new
			var_34_2 = {}
		end

		var_34_2.index = var_0_3:getKnightPositionBySid(var_34_0)
		var_34_2.knightSid = arg_34_2.knightSid or 0
		var_34_2.mainKnightSid = arg_34_2.mainKnightSid or 0

		g.core.module.ModuleManager:pushPopup((require("app.view.module.formation.pre.FormationPreAssociationPop").new(var_34_2)))
	end
end

function FormationPreComp:updateLineUpHaloCount()
	local var_35_0 = self._formationPreStruct:getHaloGroupInfo()

	self:_updateHaloView(var_35_0.group, var_35_0.curCnt)
end

function FormationPreComp:_updateHaloView(arg_36_1, arg_36_2)
	arg_36_2 = math.clamp(arg_36_2, 0, 6)

	self.m_haloBtn:getChild("lineUpHaloBar"):setFillAmount(arg_36_2 / 6)

	arg_36_1 = arg_36_1 > 0 and arg_36_1 or var_0_2.GROUP_TYPE.LIN_DONG

	local var_36_0 = self.m_haloBtn:getChild("haloImg")
	local var_36_1 = var_0_0:getCampURL(arg_36_1, 4)
	local var_36_2 = self.m_haloBtn:getChild("effectHolder")

	var_36_2:removeAllEffect()

	if arg_36_2 >= 6 then
		var_36_2:addEffectSpine({
			isLoop = true,
			anim = "play2",
			scale = 1,
			name = "eff_ui_formation_gain"
		})

		var_36_1 = var_0_0:getCampActiveURL(arg_36_1)
	elseif arg_36_2 >= 2 then
		var_36_2:addEffectSpine({
			isLoop = true,
			anim = "play1",
			scale = 1,
			name = "eff_ui_formation_gain"
		})
	end

	var_36_0:setURL(var_36_1)
end

function FormationPreComp:_onShareClick()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self.m_shareComp:setVisible(false)

		return
	end

	self.m_shareComp:setVisible(false)
	self.m_topBar:setVisible(false)

	local var_37_0 = cc.utils:captureNode(self)

	var_37_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_37_0:release()
	self.m_shareComp:setVisible(true)
	self.m_topBar:setVisible(true)
	var_0_5:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_8
	})
end

function FormationPreComp:updateOtherUserView(arg_38_1)
	self._isOtherUser = true
	self._formationPreStruct = var_0_3:getPreFormationByString(arg_38_1)

	self:dispatchCompEvent("FormationOtherLayer_name", {
		name = self._formationPreStruct:getOtherUserName()
	})

	for iter_38_0 = 1, var_0_2.LINEUP_MAX do
		self["m_knight" .. iter_38_0]:setDraggable(false)

		local var_38_0 = self._formationPreStruct:getOtherKnightStruct(iter_38_0)

		self["m_knight" .. iter_38_0]:updateCompByStruct(var_38_0)

		if var_38_0 then
			self["m_knight" .. iter_38_0]:updateLevelAndRank(true, var_38_0:getLevel(), var_38_0:getAdvanceLevel())
		else
			self["m_knight" .. iter_38_0]:updateLevelAndRank(false)
		end
	end

	self.m_assctNum:setTitle(self._formationPreStruct:getOtherAllAssCount())

	local var_38_1 = self._formationPreStruct:getOtherHaolGroupInfo()

	self:_updateHaloView(var_38_1.group, var_38_1.curCnt)
	self.m_nameGroup:setVisible(false)
	self.m_bottomComp:updateOther(self._formationPreStruct)
end

function FormationPreComp:setBottomHideSuccuba(arg_39_1)
	self.m_bottomComp:setSuccubaHide(arg_39_1)
end

return FormationPreComp
