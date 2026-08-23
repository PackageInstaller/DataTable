local var_0_0 = g.core.model.User.blazingArenaData
local var_0_1 = g.core.const.ConstMgr.LineUpConst
local var_0_2 = g.core.model.User.mulFormationData
local var_0_3 = g.core.model.User.knightsData
local var_0_4 = g.core.module.ModuleManager
local BattleKnight = require("app.view.battle.BattleKnight")
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_7 = g.core.event.EventManager
local var_0_8 = g.core.event.enum
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_10 = g.core.config.knight_info
local var_0_12 = 301
local var_0_13 = "CHIEF_ARENA_DRAG_KNIGHT"
local BlazingArenaBattlePrepareLayer = class("BlazingArenaBattlePrepareLayer", require("app.fairyGUI.blazingArena.UI_BlazingArenaBattlePrepareLayer"), function()
	return fgui.GComponent:create({
		resName = "BlazingArenaBattlePrepareLayer",
		pkgPath = "ui/blazingArena/blazingArena",
		isFullScreen = true,
		pkgName = "blazingArena"
	}, ...)
end)

function BlazingArenaBattlePrepareLayer:ctor(arg_2_1)
	self._challengeData = arg_2_1
	self._rivalData = arg_2_1.formations
	self._isRobot = checkbool(arg_2_1.isRobot)
	self._uid = arg_2_1.id
	self._knightComps = {}
	self._rivalComps = {}
	self._formationIndex = 1
	self._additionList = {
		myList = {},
		rivalList = {}
	}
	self._talentSkillInfo = nil
	self._targetGroup = 0
	self._starPos = 0
	self._localPos = 0
	self._nextPos = 0
	self._curComp = nil
	self._isDragKnight = false
	self._isUseClicking = false
	self._mulFormationStruct = nil
	self._mulFormationStructArr = var_0_2:getFormationStructDict(var_0_1.MulTeamType.BLAZING_ARENA)

	self:_initListener()
	self:_initView()
end

function BlazingArenaBattlePrepareLayer:_initView()
	self:addBg("bg/blazingArena/bg_bljt_duizhan.jpg")
	self:_initCompProperty("m_knightComp", false)
	self:_initCompProperty("m_rivalComp", true)
	self:_updateView()
end

function BlazingArenaBattlePrepareLayer:_initListener()
	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
	self.m_editBtn:addClickListener(handler(self, self._onClickEditBtn))
	self.m_nextBattleBtn:addClickListener(handler(self, self._onClickNextBattleBtn))
	self.m_enterBattleBtn:addClickListener(handler(self, self._onClickEnterBattleBtn))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_blankFG:addClickListener(handler(self, self._onClickBlankFG))

	for iter_4_0 = 1, 3 do
		self["m_screenTouchBtn" .. iter_4_0]:addClickListener(handler(self, self._onClickBattleTeamBtn))
		self["m_screenTouchBtn" .. iter_4_0]:setName("btn_" .. iter_4_0)
	end

	self.m_switchBtn:addClickListener(handler(self, self._onClickSwitchBtn))
end

function BlazingArenaBattlePrepareLayer:_initCompProperty(arg_5_1, arg_5_2)
	while self[arg_5_1 .. 1] do
		self[arg_5_1 .. 1]:setDraggable(not arg_5_2)

		if arg_5_2 then
			self._rivalComps[1] = self[arg_5_1 .. 1]
		else
			self[arg_5_1 .. 1]:addClickListener(handler(self, self._onClickKnight))
			self[arg_5_1 .. 1]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onDragLineupKnight))
			self:addListen(self[arg_5_1 .. 1])
			self[arg_5_1 .. 1]:setPosIndex(1)

			self[arg_5_1 .. 1].formation = 1
			self._knightComps[1] = self[arg_5_1 .. 1]
		end
	end
end

function BlazingArenaBattlePrepareLayer:_resetAdditionList()
	self._additionList = {
		myList = {},
		rivalList = {}
	}
end

function BlazingArenaBattlePrepareLayer:_updateView()
	self:_updateMyTeam()
	self:_updateRivalTeam()
end

function BlazingArenaBattlePrepareLayer:_updateMyTeam()
	self._mulFormationStruct = self._mulFormationStructArr[self._formationIndex]

	for iter_8_0, iter_8_1 in ipairs(self._knightComps) do
		iter_8_1:updateCompByStruct(var_0_3:getKnightById((self._mulFormationStruct:getKnightSid(iter_8_0))), nil, true)
	end

	self.m_myPowerNumTxt:setText(self._mulFormationStruct:getFightValue())
end

function BlazingArenaBattlePrepareLayer:_updateRivalTeam()
	if not self._rivalData then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(self._rivalComps) do
		local var_9_0

		if self._rivalData[self._formationIndex].knights[iter_9_0] and self._rivalData[self._formationIndex].knights[iter_9_0] > 0 then
			local var_9_1 = var_0_10.get(self._rivalData[self._formationIndex].knights[iter_9_0])
			local var_9_2 = KnightStruct.new(var_9_1.advance_id)

			var_9_2:addCfgInfo(var_9_1)

			var_9_0 = var_9_2
		end

		iter_9_1:updateCompByStruct(var_9_0, true, true)
	end

	self.m_rivalPowerNumTxt:setText(self._rivalData[self._formationIndex].fight_value)
end

function BlazingArenaBattlePrepareLayer:_onClickKnight(arg_10_1)
	if self._isDragKnight then
		return
	end

	if arg_10_1:getSender():getEmptyStatus() == 0 then
		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.BLAZING_ARENA_FORMATION)
end

function BlazingArenaBattlePrepareLayer:_onClickBattleTeamBtn(arg_11_1)
	local var_11_0 = arg_11_1:getSender()

	if var_11_0 == self["m_screenTouchBtn" .. self._formationIndex] then
		return
	end

	self.m_isSwitchController:setSelectedIndex(0)

	for iter_11_0 = 1, 3 do
		self["m_screenTouchBtn" .. iter_11_0]:setVisible(false)
	end

	self["m_battleTeamBtn" .. self._formationIndex]:setCtrlState("isSwitch", {
		index = 0
	})
	self:_switchAndSaveMyTeams(self._formationIndex, (tonumber(string.match(var_11_0:getName(), "%d"))))

	for iter_11_1 = 1, 3 do
		if iter_11_1 ~= self._formationIndex then
			self:_playSwitchBtnAnim(iter_11_1, 0)
		end
	end
end

function BlazingArenaBattlePrepareLayer:_resetBtnStatus()
	if self.m_isSwitchController:getSelectedIndex() == 1 then
		for iter_12_0 = 1, 3 do
			if self["m_battleTeamBtn" .. iter_12_0]:getController("isSwitch"):getSelectedIndex() == 1 then
				self["m_battleTeamBtn" .. iter_12_0]:setTouchable(false)
				self:_playSwitchBtnAnim(iter_12_0, 0)
			end
		end
	end
end

function BlazingArenaBattlePrepareLayer:_playSwitchBtnAnim(arg_13_1, arg_13_2)
	local var_13_0 = self["m_battleTeamBtn" .. arg_13_1]
	local var_13_1 = self["m_battleTeamBtn" .. arg_13_1]:getChild("btnEffect")

	self["m_battleTeamBtn" .. arg_13_1]:setCtrlState("isSwitch", {
		index = arg_13_2
	})

	if var_13_1 then
		self["m_battleTeamBtn" .. arg_13_1]:setTouchable(false)
		var_13_1:removeAllEffect()
		var_13_1:addEffectSpine({
			anim = "up",
			name = "eff_ui_chiefArena_changeBtn",
			isLoop = false,
			eventHandler = function()
				var_13_0:setTouchable(true)
			end
		})
	end
end

function BlazingArenaBattlePrepareLayer:_isPlayingAnim(arg_15_1)
	for iter_15_0 = 1, 3 do
		if self["m_battleTeamBtn" .. iter_15_0]:getController("isSwitch"):getSelectedIndex() ~= arg_15_1 then
			return true
		end
	end

	return false
end

function BlazingArenaBattlePrepareLayer:_switchAndSaveMyTeams(arg_16_1, arg_16_2)
	local var_16_0 = var_0_2:getOutBaseFormationArr(var_0_1.MulTeamType.BLAZING_ARENA)

	var_16_0[arg_16_1], var_16_0[arg_16_2] = var_16_0[arg_16_2], var_16_0[arg_16_1]
	var_16_0[arg_16_1].seq = arg_16_1
	var_16_0[arg_16_2].seq = arg_16_2

	g.core.network.GameNetProxy:send_C2S_Formation_Save({
		tp = var_0_1.MulTeamType.BLAZING_ARENA,
		formations = var_16_0
	})
end

function BlazingArenaBattlePrepareLayer:_updateKnightOpacity(arg_17_1)
	for iter_17_0 = 1, #self._knightComps do
		self._knightComps[iter_17_0]:updateKnightOpacity(arg_17_1)
	end
end

function BlazingArenaBattlePrepareLayer:_clearMoveComp()
	local var_18_0 = fgui.DragDropManager:getInstance():getAgent()

	if var_18_0:displayObject():getChildByName(var_0_13) then
		var_18_0:displayObject():removeChildByName(var_0_13, true)
	end
end

function BlazingArenaBattlePrepareLayer:_updateKnight()
	for iter_19_0 = 1, #self._knightComps do
		local var_19_0 = self._mulFormationStruct:getKnightSid(iter_19_0)
		local var_19_1 = var_0_3:getKnightById(var_19_0)

		self._knightComps[iter_19_0]:setKnightId(var_19_0)
		self._knightComps[iter_19_0]:updateCompByStruct(var_19_1, false)
	end
end

function BlazingArenaBattlePrepareLayer:_onDragLineupKnight(arg_20_1)
	if not self._mulFormationStruct then
		return
	end

	self._isDragKnight = true

	arg_20_1:preventDefault()

	self._curComp = arg_20_1:getSender()

	self._curComp:hideKnight(true)

	self._starPos = self._curComp.formation
	self._localPos = self._starPos

	local var_20_0 = self._mulFormationStruct:getKnightSid(self._starPos) or 0

	if var_20_0 > 0 then
		local var_20_1 = fgui.DragDropManager:getInstance()

		var_20_1:startDrag("common/ui_cocos/lineUp/pic_touming.png", nil, (arg_20_1:getInput():getTouchId()))

		local var_20_2 = BattleKnight.new({
			breath = true,
			scale = 1.2,
			base = true,
			resId = var_0_3:getKnight({
				id = var_20_0
			}):getResInfo().fight_id
		})

		var_20_2:setScale(1.2)
		var_20_2:setName(var_0_13)
		var_20_1:getAgent():displayObject():addChild(var_20_2)
		var_20_2:setPosition(50, 0)
	end
end

function BlazingArenaBattlePrepareLayer:_onDragMoveKnight(arg_21_1)
	if not self._isDragKnight then
		return
	end

	local var_21_0 = arg_21_1:getInput():getTouch()

	if not var_21_0 then
		return
	end

	local var_21_1 = var_21_0:getLocation()

	var_21_1.y = var_21_1.y - 50

	local var_21_2 = false
	local var_21_3

	for iter_21_0 = 1, #self._knightComps do
		if self._knightComps[iter_21_0].m_imgPosTouch:hitTest(var_21_1, cc.Camera:create()) then
			var_21_2 = true

			if iter_21_0 ~= self._localPos then
				var_21_3 = iter_21_0
			end
		end
	end

	if var_21_3 then
		self._nextPos = var_21_3

		self:_updateExchangeKnight()
	elseif not var_21_2 then
		self._nextPos = self._starPos

		self:_updateExchangeKnight()
	end
end

function BlazingArenaBattlePrepareLayer:_onTouchBegin(arg_22_1)
	arg_22_1:captureTouch()
end

function BlazingArenaBattlePrepareLayer:_onTouchEnd(arg_23_1)
	if not self._isDragKnight or not self._mulFormationStruct then
		return
	end

	if not arg_23_1:getInput():getTouch() then
		return
	end

	self:_updateKnightOpacity(255)

	local var_23_0 = self._mulFormationStruct:getKnightSidByPos((self._mulFormationStruct:getKnightPosByStationPos(self._starPos)))

	if self._starPos ~= self._localPos then
		self._mulFormationStruct:lineupKnight(self._localPos, var_23_0)
		self:_updateKnight()
	elseif self._isDragKnight and self._curComp then
		self._curComp:updateCompByStruct((var_0_3:getKnightById(var_23_0)))
	end

	self:_clearMoveComp()
	self:newScheduleOnce(handler(self, self._setDragKnightStatus), 0.02)
end

function BlazingArenaBattlePrepareLayer:_setDragKnightStatus()
	self._isDragKnight = false
end

function BlazingArenaBattlePrepareLayer:_updateExchangeKnight()
	if not self._mulFormationStruct then
		return
	end

	local var_25_0 = false

	if self._localPos ~= self._starPos then
		self._knightComps[self._localPos]:updateCompByStruct((var_0_3:getKnightById((self._mulFormationStruct:getKnightSid(self._localPos)))))

		var_25_0 = true
	end

	self._localPos = self._nextPos

	if self._localPos ~= self._starPos then
		self._knightComps[self._starPos]:updateCompByStruct((var_0_3:getKnightById((self._mulFormationStruct:getKnightSid(self._nextPos)))))

		var_25_0 = true
	end

	if var_25_0 then
		self._knightComps[self._localPos]:setKnightId(self._mulFormationStruct:getKnightSidByPos((self._mulFormationStruct:getKnightPosByStationPos(self._starPos))) or 0)
		self._knightComps[self._localPos]:hideKnight(true)
	end
end

function BlazingArenaBattlePrepareLayer:_saveCurFormation()
	if var_0_2:isModified(var_0_1.MulTeamType.BLAZING_ARENA) then
		g.core.network.GameNetProxy:send_C2S_Formation_Save({
			tp = var_0_1.MulTeamType.BLAZING_ARENA,
			formations = var_0_2:getOutBaseFormationArr(var_0_1.MulTeamType.BLAZING_ARENA)
		})
	end
end

function BlazingArenaBattlePrepareLayer:_onTabSelChanged()
	self:_saveCurFormation()
	self:_resetBtnStatus()

	self._formationIndex = self.m_tabSelController:getSelectedIndex() + 1

	self:_updateMyTeam()
	self:_updateRivalTeam()
end

function BlazingArenaBattlePrepareLayer:_onClickEditBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.BLAZING_ARENA_FORMATION, {
		needSaveTip = false
	})
end

function BlazingArenaBattlePrepareLayer:_onClickNextBattleBtn()
	self.m_tabSelController:setSelectedIndex(self._formationIndex)
end

function BlazingArenaBattlePrepareLayer:_onClickSwitchBtn()
	local var_30_0 = self.m_tabSelController:getSelectedIndex()

	if self.m_isSwitchController:getSelectedIndex() == 1 then
		-- block empty
	else
		self.m_isSwitchController:setSelectedIndex(1)

		for iter_30_0 = 1, 3 do
			self["m_screenTouchBtn" .. iter_30_0]:setVisible(true)

			if var_30_0 + 1 ~= iter_30_0 then
				self["m_battleTeamBtn" .. iter_30_0]:setTouchable(false)
				self:_playSwitchBtnAnim(iter_30_0, 1)
			end
		end
	end
end

function BlazingArenaBattlePrepareLayer:_onClickEnterBattleBtn()
	if not self._challengeData then
		return
	end

	if not var_0_0:isInActivityPlayTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(431409))

		return
	end

	if var_0_0:getAttackTimes() < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431410))

		return
	end

	if #var_0_0:getAllExpiredMember().typeList > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431414))

		return
	end

	if var_0_0:checkCanSendBattle() then
		g.core.network.GameNetProxy:send_C2S_BlazingArena_ChallengeBegin({
			rank = self._challengeData.rank,
			id = self._uid
		})
		var_0_0:setEnemyFormations(self._rivalData)
		var_0_0:saveLastRank()
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_OPEN_ASSISTANT)
end

function BlazingArenaBattlePrepareLayer:_onClickBlankFG()
	for iter_32_0 = 1, 3 do
		self["m_battleTeamBtn" .. iter_32_0]:setCtrlState("isSwitch", {
			index = 0
		})
		self["m_screenTouchBtn" .. iter_32_0]:setVisible(false)
	end

	self.m_isSwitchController:setSelectedIndex(0)
end

function BlazingArenaBattlePrepareLayer:_onChiefArenaChallengeBegin(arg_33_1, arg_33_2, arg_33_3)
	if arg_33_3.ret == 3426 or arg_33_3.ret == 3429 then
		var_0_4:onlyPopSelfByDisplay(self)

		return
	end

	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		type = BattleConst.TYPE_BLAZING_ARENA,
		battle_id = arg_33_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		bgm = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP_B
	})
	self:_onClose()
end

function BlazingArenaBattlePrepareLayer:_onClose()
	var_0_4:onlyPopSelfByDisplay(self)
end

function BlazingArenaBattlePrepareLayer:_onCrossDayUpdate()
	return
end

function BlazingArenaBattlePrepareLayer:onLoad()
	fgui.DragDropManager:getInstance():getAgent():addEventListener(fgui.UIEventType.DragMove, handler(self, self._onDragMoveKnight), var_0_12)
	var_0_7:addEventListener(var_0_8.EVENT_NET_S2C_BLAZING_ARENA_CHALLENGEBEGIN, self._onChiefArenaChallengeBegin, self)
	var_0_7:addEventListener(var_0_8.EVENT_NET_S2C_FORMATION_SAVE, self._updateMyTeam, self)
	var_0_7:addEventListener(var_0_8.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_updateView()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP)
end

function BlazingArenaBattlePrepareLayer:onUnload()
	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, var_0_12)
	self:_saveCurFormation()
	self.m_backTransition:play()
end

return BlazingArenaBattlePrepareLayer
