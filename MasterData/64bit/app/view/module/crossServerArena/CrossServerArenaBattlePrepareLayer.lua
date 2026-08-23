local var_0_0 = g.core.model.User.crossServerArenaData
local var_0_1 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_2 = g.core.const.ConstMgr.LineUpConst
local var_0_3 = g.core.model.User.mulFormationData
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = g.core.module.ModuleManager
local BattleKnight = require("app.view.battle.BattleKnight")
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_8 = g.core.event.EventManager
local var_0_9 = g.core.event.enum
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_11 = g.core.config.knight_info
local var_0_12 = g.core.common.Path
local var_0_13 = 301
local var_0_14 = "CHIEF_ARENA_DRAG_KNIGHT"
local CrossServerArenaBattlePrepareLayer = class("CrossServerArenaBattlePrepareLayer", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaBattlePrepareLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/crossServerArena/crossServerArena",
		resName = "CrossServerArenaBattlePrepareLayer",
		pkgName = "crossServerArena",
		isFullScreen = true
	}, ...)
end)

function CrossServerArenaBattlePrepareLayer:ctor(arg_2_1)
	self._challengeData = arg_2_1 and arg_2_1.challengeData
	self._rivalData = arg_2_1 and arg_2_1.rivalData
	self._isRobot = checkbool(self._rivalData and self._rivalData.isRobot)
	self._enterBattle = false
	self._isModified = false

	if self._isRobot then
		self._uid = self._challengeData.robotId or self._challengeData.user.id
	end

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
	self._mulFormationStructArr = var_0_3:getFormationStructDict(var_0_2.MulTeamType.CROSS_SERVER_ARENA)

	self:_initListener()
	self:_initView()
end

function CrossServerArenaBattlePrepareLayer:_initView()
	self:addBg("bg/arena/bg_dfjjc_duizhanbianji.jpg")
	self.m_topBarComp:setResInfoById(var_0_1.TOP_BAR_PREPARE_LAYER)
	self:_initCompProperty("m_knightComp", false)
	self:_initCompProperty("m_rivalComp", true)
	self:_updateView()
end

function CrossServerArenaBattlePrepareLayer:_initListener()
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

	self.m_contrastBtn:addClickListener(handler(self, self._onClickContrastBtn))
	self.m_switchBtn:addClickListener(handler(self, self._onClickSwitchBtn))
end

function CrossServerArenaBattlePrepareLayer:_initCompProperty(arg_5_1, arg_5_2)
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

function CrossServerArenaBattlePrepareLayer:_resetAdditionList()
	self._additionList = {
		myList = {},
		rivalList = {}
	}
end

function CrossServerArenaBattlePrepareLayer:_updateView()
	self:_updateMyTeam()
	self:_updateRivalTeam()
end

function CrossServerArenaBattlePrepareLayer:_updateBuff()
	local var_8_0 = var_0_0:getBuffInfo()

	if var_8_0 then
		local var_8_1, var_8_2 = var_0_0:getBuffGroupAndTalentSkillInfo(var_8_0.buff)

		self._targetGroup = var_8_1

		self:addBg(var_0_12:getChiefArenaBg(var_8_0.pic))
		self.m_buffComp:getChild("groupIcon"):setURL(var_0_12:getCampURL(var_8_1, 6))
		self.m_buffComp:getChild("buffTxt"):setText(g.core.lang:get(411033, {
			name = var_8_2.name,
			num = var_8_2.affect_value_1 / 10
		}))
	end
end

function CrossServerArenaBattlePrepareLayer:_updateMyTeam()
	self._mulFormationStruct = self._mulFormationStructArr[self._formationIndex]

	for iter_9_0, iter_9_1 in ipairs(self._knightComps) do
		local var_9_0 = var_0_4:getKnightById((self._mulFormationStruct:getKnightSid(iter_9_0)))

		iter_9_1:updateCompByStruct(var_9_0, nil, true)
		iter_9_1:playBuff(var_9_0 and self._targetGroup == var_9_0:getGroup())
	end

	self.m_myPowerNumTxt:setText(self._mulFormationStruct:getFightValue())
end

function CrossServerArenaBattlePrepareLayer:_updateRivalTeam()
	if not self._rivalData then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(self._rivalComps) do
		local var_10_0

		if self._rivalData.formations[self._formationIndex].knight_id[iter_10_0] > 0 then
			local var_10_1 = var_0_11.get(self._rivalData.formations[self._formationIndex].knight_id[iter_10_0])
			local var_10_2 = KnightStruct.new(var_10_1.advance_id)

			var_10_2:addCfgInfo(var_10_1)

			var_10_0 = var_10_2
		end

		iter_10_1:updateCompByStruct(var_10_0, true, true)
		iter_10_1:playBuff(var_10_0 and self._targetGroup == var_10_0:getGroup())
	end

	self.m_rivalPowerNumTxt:setText(self._rivalData.formations[self._formationIndex].fight_value)
end

function CrossServerArenaBattlePrepareLayer:_onClickKnight(arg_11_1)
	if self._isDragKnight then
		return
	end

	if arg_11_1:getSender():getEmptyStatus() == 0 then
		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.CROSS_SERVER_FORMATION)
end

function CrossServerArenaBattlePrepareLayer:_onClickBattleTeamBtn(arg_12_1)
	local var_12_0 = arg_12_1:getSender()

	if var_12_0 == self["m_screenTouchBtn" .. self._formationIndex] then
		return
	end

	self.m_isSwitchController:setSelectedIndex(0)

	for iter_12_0 = 1, 3 do
		self["m_screenTouchBtn" .. iter_12_0]:setVisible(false)
	end

	self["m_battleTeamBtn" .. self._formationIndex]:setCtrlState("isSwitch", {
		index = var_0_1.CTRL_NOT_SWITCH
	})
	self:_switchAndSaveMyTeams(self._formationIndex, (tonumber(string.match(var_12_0:getName(), "%d"))))

	for iter_12_1 = 1, 3 do
		if iter_12_1 ~= self._formationIndex then
			self:_playSwitchBtnAnim(iter_12_1, var_0_1.CTRL_NOT_SWITCH)
		end
	end
end

function CrossServerArenaBattlePrepareLayer:_resetBtnStatus()
	if self.m_isSwitchController:getSelectedIndex() == 1 then
		for iter_13_0 = 1, 3 do
			if self["m_battleTeamBtn" .. iter_13_0]:getController("isSwitch"):getSelectedIndex() == 1 then
				self["m_battleTeamBtn" .. iter_13_0]:setTouchable(false)
				self:_playSwitchBtnAnim(iter_13_0, var_0_1.CTRL_NOT_SWITCH)
			end
		end
	end
end

function CrossServerArenaBattlePrepareLayer:_playSwitchBtnAnim(arg_14_1, arg_14_2)
	local var_14_0 = self["m_battleTeamBtn" .. arg_14_1]
	local var_14_1 = self["m_battleTeamBtn" .. arg_14_1]:getChild("btnEffect")

	self["m_battleTeamBtn" .. arg_14_1]:setCtrlState("isSwitch", {
		index = arg_14_2
	})

	if var_14_1 then
		self["m_battleTeamBtn" .. arg_14_1]:setTouchable(false)
		var_14_1:removeAllEffect()
		var_14_1:addEffectSpine({
			isLoop = false,
			name = "eff_ui_chiefArena_changeBtn",
			anim = "up",
			eventHandler = function()
				var_14_0:setTouchable(true)
			end
		})
	end
end

function CrossServerArenaBattlePrepareLayer:_isPlayingAnim(arg_16_1)
	for iter_16_0 = 1, 3 do
		if self["m_battleTeamBtn" .. iter_16_0]:getController("isSwitch"):getSelectedIndex() ~= arg_16_1 then
			return true
		end
	end

	return false
end

function CrossServerArenaBattlePrepareLayer:_switchAndSaveMyTeams(arg_17_1, arg_17_2)
	local var_17_0 = var_0_3:getOutBaseFormationArr(var_0_2.MulTeamType.CROSS_SERVER_ARENA)

	var_17_0[arg_17_1], var_17_0[arg_17_2] = var_17_0[arg_17_2], var_17_0[arg_17_1]
	var_17_0[arg_17_1].seq = arg_17_1
	var_17_0[arg_17_2].seq = arg_17_2

	g.core.network.GameNetProxy:send_C2S_Formation_Save({
		tp = var_0_2.MulTeamType.CROSS_SERVER_ARENA,
		formations = var_17_0
	})
end

function CrossServerArenaBattlePrepareLayer:_updateKnightOpacity(arg_18_1)
	for iter_18_0 = 1, #self._knightComps do
		self._knightComps[iter_18_0]:updateKnightOpacity(arg_18_1)
	end
end

function CrossServerArenaBattlePrepareLayer:_clearMoveComp()
	local var_19_0 = fgui.DragDropManager:getInstance():getAgent()

	if var_19_0:displayObject():getChildByName(var_0_14) then
		var_19_0:displayObject():removeChildByName(var_0_14, true)
	end
end

function CrossServerArenaBattlePrepareLayer:_updateKnight()
	for iter_20_0 = 1, #self._knightComps do
		local var_20_0 = self._mulFormationStruct:getKnightSid(iter_20_0)
		local var_20_1 = var_0_4:getKnightById(var_20_0)

		self._knightComps[iter_20_0]:setKnightId(var_20_0)
		self._knightComps[iter_20_0]:updateCompByStruct(var_20_1, false)
		self._knightComps[iter_20_0]:playBuff(var_20_1 and self._targetGroup == var_20_1:getGroup())
	end
end

function CrossServerArenaBattlePrepareLayer:_onDragLineupKnight(arg_21_1)
	if not self._mulFormationStruct then
		return
	end

	self._isDragKnight = true

	arg_21_1:preventDefault()

	self._curComp = arg_21_1:getSender()

	self._curComp:hideKnight(true)
	self._curComp:playBuff(false)

	self._starPos = self._curComp.formation
	self._localPos = self._starPos

	local var_21_0 = self._mulFormationStruct:getKnightSid(self._starPos) or 0

	if var_21_0 > 0 then
		local var_21_1 = arg_21_1:getInput()
		local var_21_2 = fgui.DragDropManager:getInstance()

		var_21_2.startDrag(var_21_1, "common/ui_cocos/lineUp/pic_touming.png", nil, (var_21_1:getTouchId()))

		local var_21_3 = BattleKnight.new({
			scale = 1.2,
			base = true,
			breath = true,
			resId = var_0_4:getKnight({
				id = var_21_0
			}):getResInfo().fight_id
		})

		var_21_3:setScale(1.2)
		var_21_3:setName(var_0_14)
		var_21_2:getAgent():displayObject():addChild(var_21_3)
		var_21_3:setPosition(50, 0)
	end
end

function CrossServerArenaBattlePrepareLayer:_onDragMoveKnight(arg_22_1)
	if not self._isDragKnight then
		return
	end

	local var_22_0 = arg_22_1:getInput():getTouch()

	if not var_22_0 then
		return
	end

	local var_22_1 = var_22_0:getLocation()

	var_22_1.y = var_22_1.y - 50

	local var_22_2 = false
	local var_22_3

	for iter_22_0 = 1, #self._knightComps do
		if self._knightComps[iter_22_0].m_imgPosTouch:hitTest(var_22_1, cc.Camera:create()) then
			var_22_2 = true

			if iter_22_0 ~= self._localPos then
				var_22_3 = iter_22_0
			end
		end
	end

	if var_22_3 then
		self._nextPos = var_22_3

		self:_updateExchangeKnight()
	elseif not var_22_2 then
		self._nextPos = self._starPos

		self:_updateExchangeKnight()
	end
end

function CrossServerArenaBattlePrepareLayer:_onTouchBegin(arg_23_1)
	arg_23_1:captureTouch()
end

function CrossServerArenaBattlePrepareLayer:_onTouchEnd(arg_24_1)
	if not self._isDragKnight or not self._mulFormationStruct then
		return
	end

	if not arg_24_1:getInput():getTouch() then
		return
	end

	self:_updateKnightOpacity(255)

	local var_24_0 = self._mulFormationStruct:getKnightSidByPos((self._mulFormationStruct:getKnightPosByStationPos(self._starPos)))

	if self._starPos ~= self._localPos then
		self._mulFormationStruct:lineupKnight(self._localPos, var_24_0)
		self:_updateKnight()
	elseif self._isDragKnight and self._curComp then
		local var_24_1 = var_0_4:getKnightById(var_24_0)

		self._curComp:updateCompByStruct(var_24_1)
		self._curComp:playBuff(var_24_1 and self._targetGroup == var_24_1:getGroup())
	end

	self:_clearMoveComp()
	self:newScheduleOnce(handler(self, self._setDragKnightStatus), 0.02)
end

function CrossServerArenaBattlePrepareLayer:_setDragKnightStatus()
	self._isDragKnight = false
end

function CrossServerArenaBattlePrepareLayer:_updateExchangeKnight()
	if not self._mulFormationStruct then
		return
	end

	local var_26_0 = false

	if self._localPos ~= self._starPos then
		self._knightComps[self._localPos]:updateCompByStruct((var_0_4:getKnightById((self._mulFormationStruct:getKnightSid(self._localPos)))))

		var_26_0 = true
	end

	self._localPos = self._nextPos

	if self._localPos ~= self._starPos then
		self._knightComps[self._starPos]:updateCompByStruct((var_0_4:getKnightById((self._mulFormationStruct:getKnightSid(self._nextPos)))))

		var_26_0 = true
	end

	if var_26_0 then
		self._knightComps[self._localPos]:setKnightId(self._mulFormationStruct:getKnightSidByPos((self._mulFormationStruct:getKnightPosByStationPos(self._starPos))) or 0)
		self._knightComps[self._localPos]:hideKnight(true)
	end
end

function CrossServerArenaBattlePrepareLayer:_saveCurFormation()
	self._isModified = var_0_3:isModified(var_0_2.MulTeamType.CROSS_SERVER_ARENA)

	if self._isModified then
		self._isModified = false

		g.core.network.GameNetProxy:send_C2S_Formation_Save({
			tp = var_0_2.MulTeamType.CROSS_SERVER_ARENA,
			formations = var_0_3:getOutBaseFormationArr(var_0_2.MulTeamType.CROSS_SERVER_ARENA)
		})
	end
end

function CrossServerArenaBattlePrepareLayer:_onTabSelChanged()
	self:_saveCurFormation()
	self:_resetBtnStatus()

	self._formationIndex = self.m_tabSelController:getSelectedIndex() + 1

	if self._formationIndex == 3 then
		self:_checkTipsGuide2()
	end

	if not self._isModified then
		self:_updateMyTeam()
	end

	self:_updateRivalTeam()
end

function CrossServerArenaBattlePrepareLayer:_onClickEditBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.CROSS_SERVER_FORMATION, {
		needSaveTip = false
	})
end

function CrossServerArenaBattlePrepareLayer:_onClickNextBattleBtn()
	self.m_tabSelController:setSelectedIndex(self._formationIndex)
end

function CrossServerArenaBattlePrepareLayer:_onClickContrastBtn()
	local var_31_0 = {}

	if not self._isRobot then
		var_31_0.uid = self._uid
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.crossServerArena.pop.CrossServerArenaContrastPop").new(var_31_0), {
		touchDisappear = true,
		hideContinue = true
	})
end

function CrossServerArenaBattlePrepareLayer:_onClickSwitchBtn()
	local var_32_0 = self.m_tabSelController:getSelectedIndex()

	if self.m_isSwitchController:getSelectedIndex() == 1 then
		-- block empty
	else
		self.m_isSwitchController:setSelectedIndex(1)

		for iter_32_0 = 1, 3 do
			self["m_screenTouchBtn" .. iter_32_0]:setVisible(true)

			if var_32_0 + 1 ~= iter_32_0 then
				self["m_battleTeamBtn" .. iter_32_0]:setTouchable(false)
				self:_playSwitchBtnAnim(iter_32_0, var_0_1.CTRL_IS_SWITCH)
			end
		end
	end
end

function CrossServerArenaBattlePrepareLayer:_onClickEnterBattleBtn()
	if not self._challengeData then
		return
	end

	if var_0_0:checkChallengeTime(self._challengeData.rank, self._uid) then
		self:_cacheBattleInfo()
		g.core.network.GameNetProxy:send_C2S_ChiefArena_ChallengeBegin({
			rank = self._challengeData.rank,
			id = self._uid
		})
	end
end

function CrossServerArenaBattlePrepareLayer:_onClickBlankFG()
	for iter_34_0 = 1, 3 do
		self["m_battleTeamBtn" .. iter_34_0]:setCtrlState("isSwitch", {
			index = 0
		})
		self["m_screenTouchBtn" .. iter_34_0]:setVisible(false)
	end

	self.m_isSwitchController:setSelectedIndex(0)
end

function CrossServerArenaBattlePrepareLayer:_cacheBattleInfo()
	var_0_0:cacheBattleInfo({
		rivalTeam = self._rivalData,
		rank = self._challengeData.rank,
		isRobot = self._isRobot
	})
end

function CrossServerArenaBattlePrepareLayer:_onChiefArenaChallengeBegin(arg_36_1, arg_36_2, arg_36_3)
	if arg_36_3.ret == 3426 or arg_36_3.ret == 3429 then
		var_0_5:onlyPopSelfByDisplay(self)

		return
	end

	var_0_0:setEnterBattleStatus(true)
	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		type = BattleConst.TYPE_CROSS_SERVER_ARENA,
		battle_id = arg_36_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		bgm = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP_B
	})
	self:_onClose()
end

function CrossServerArenaBattlePrepareLayer:_onClose()
	var_0_5:onlyPopSelfByDisplay(self)
end

function CrossServerArenaBattlePrepareLayer:_onCrossDayUpdate()
	if var_0_0:getSeasonStatus() ~= var_0_1.CTRL_ON_SEASON then
		var_0_5:tip(g.core.lang:get(411013))
		var_0_5:popToRoot()
	end

	self:_updateBuff()
end

function CrossServerArenaBattlePrepareLayer:onLoad()
	fgui.DragDropManager:getInstance():getAgent():addEventListener(fgui.UIEventType.DragMove, handler(self, self._onDragMoveKnight), var_0_13)
	var_0_8:addEventListener(var_0_9.EVENT_NET_S2C_CHIEF_ARENA_CHALLENGEBEGIN, self._onChiefArenaChallengeBegin, self)
	var_0_8:addEventListener(var_0_9.EVENT_NET_S2C_FORMATION_SAVE, self._updateMyTeam, self)
	var_0_8:addEventListener(var_0_9.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_updateBuff()
	self:_updateView()
	self.m_enterTransition:play(handler(self, self._checkTipsGuide))
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP)
end

function CrossServerArenaBattlePrepareLayer:onUnload()
	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, var_0_13)
	self:_saveCurFormation()
	self.m_backTransition:play()
end

function CrossServerArenaBattlePrepareLayer:_checkTipsGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if not var_0_0:isNeedGuide() then
		return
	end

	self:newScheduleOnce(function()
		var_0_8:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
			key = "CS_ARENA_BATTLE_PREPARE",
			objects = {
				self.m_ruleHolder,
				self.m_switchBtn,
				self.m_nextBattleBtn,
				self.m_roundComp3,
				self.m_contrastBtn
			}
		})
	end, 0)
end

function CrossServerArenaBattlePrepareLayer:_checkTipsGuide2()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if not var_0_0:isNeedGuide() then
		return
	end

	g.core.service.ServiceManager:getServiceByName("TipGuideService"):reset()
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
			key = "CS_ARENA_BATTLE_ENTER",
			objects = {
				self.m_enterBattleBtn
			}
		})
	end, 0)
end

return CrossServerArenaBattlePrepareLayer
