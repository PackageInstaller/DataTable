local WushFloorComp = class("WushFloorComp", require("app.fairyGUI.wush.UI_WushFloorComp"))
local var_0_1 = g.core.config.dead_battle_floor_info

WushFloorComp.CLOSE = 1
WushFloorComp.CAN_RECEIVE = 2
WushFloorComp.EMPTY = 3
WushFloorComp.BOSS_STAGE = 4
WushFloorComp.NORMAL_STAGE = 6

function WushFloorComp:ctor()
	self._isBoss = false
	self._floorId = 1
	self._boxState = 0
	self._routeData = {}
	self._stageIndex = 1
	self._selectState = false

	self.m_chestComp:addClickListener(handler(self, self._onClickChest))
end

function WushFloorComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_BOXAWARD, handler(self, self._onRcvBoxAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, handler(self, self.checkSpeWeakGuide), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_PICKBUFF, handler(self, self._onRcvChooseBuff), self)

	if g.core.model.User.wushData:getNewStageIndex() >= 0 then
		self:_updateMonster(true)
	end

	self:_checkIsPassFinish()
end

function WushFloorComp:_checkIsPassFinish()
	local var_3_0 = g.core.model.User.wushData:isPassFinish()

	self.m_passFinishController:setSelectedIndex(var_3_0 and 1 or 0)

	if var_3_0 then
		self.m_finishTransition:play()
	end

	return var_3_0
end

function WushFloorComp:update(arg_4_1)
	if self:_checkIsPassFinish() then
		return
	end

	if arg_4_1 then
		self._floorId = arg_4_1.floorId or 1
	end

	self._isBoss = var_0_1.get(self._floorId).type == 2

	self.m_isBossController:setSelectedIndex(self._isBoss and 1 or 0)

	if self._isBoss then
		self.m_open2Transition:play()
	else
		self.m_open1Transition:play()
	end

	self:_updateMonster()
	self:_updateBoxState()
	self:_checkFloorBuff()
	self:_checkFloorBoxAward()
	self:checkSpeWeakGuide()
end

function WushFloorComp:_updateMonster(arg_5_1)
	local var_5_0 = var_0_1.get(self._floorId)

	if not self._isBoss then
		for iter_5_0 = 1, 3 do
			self["m_monsterComp" .. iter_5_0]:update({
				floorId = self._floorId,
				stageId = var_5_0["stage" .. iter_5_0],
				stageIndex = iter_5_0 - 1,
				isWin = arg_5_1
			})
		end
	else
		self.m_bossComp:update({
			isBoss = true,
			stageIndex = 0,
			floorId = self._floorId,
			stageId = var_5_0.stage1,
			isWin = arg_5_1
		})
	end

	self.m_chestComp:getController("isBoss"):setSelectedIndex(self._isBoss and 1 or 0)
end

function WushFloorComp:checkSpeWeakGuide()
	local var_6_0 = var_0_1.get(self._floorId)

	if self._floorId == 1 and g.core.model.User.wushData:getOldMaxFloor() <= 1 then
		for iter_6_0 = 1, 3 do
			if g.core.model.User.wushData:getHistoryStar(var_6_0["stage" .. iter_6_0]) == 0 and not self._selectState then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "WUSH_MAIN_STAY",
					targetBtn = self["m_monsterComp" .. iter_6_0]
				})
			end
		end
	end
end

function WushFloorComp:_updateBoxState()
	self._boxState = g.core.model.User.wushData:getBoxState()

	self.m_chestComp:getController("isGetAward"):setSelectedIndex(self._boxState == 2 and 1 or 0)

	local var_7_0 = self.m_chestComp:getChild("effChest")

	if self._boxState == 2 and var_7_0 then
		var_7_0:addEffectSpine({
			name = "eff_ui_wush_chest",
			isLoop = false
		})
	end
end

function WushFloorComp:checkFloorInfoByBlitz(arg_8_1)
	if g.core.model.User.wushData:isPassFinish() then
		self:dispatchCompEvent("WUSHFLOORCOMP_PASS_FINISH")
	else
		local var_8_0 = g.core.model.User.wushData:getCurStageIndex()

		if arg_8_1 then
			for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
				if iter_8_1 > 0 then
					var_8_0 = iter_8_0
				end
			end
		end

		self:playMainRoleMove(var_8_0)
		self:_updateMonster()
		self:_updateBoxState()
		self:_checkFloorBuff()
	end
end

function WushFloorComp:setSelectedMonsterState(arg_9_1)
	self._selectState = arg_9_1
end

function WushFloorComp:playMainRoleMove(arg_10_1)
	self._stageIndex = arg_10_1 or g.core.model.User.wushData:getCurStageIndex()

	local var_10_0 = g.core.model.User.wushData:getCurStageIndex()
	local var_10_1 = self["m_line" .. tostring(self._stageIndex)]
	local var_10_2 = self["m_monsterComp" .. var_10_0 + 1]

	if var_10_1 then
		var_10_1:getTransition("switch"):changeParams({
			xy = {
				var_10_1:getWidth(),
				-1
			}
		}):play(handler(self, function()
			if var_10_2 then
				var_10_2:playUnLockEffect(handler(self, function()
					self:_updateBoxState()
					self:_checkFloorBoxAward()
				end))
			end

			if var_10_0 == 3 then
				self:_updateBoxState()
				self:_checkFloorBoxAward()
			end
		end))
	elseif self["m_monsterComp" .. var_10_0 + 1] then
		self["m_monsterComp" .. var_10_0 + 1]:playUnLockEffect(handler(self, function()
			self:_updateBoxState()
			self:_checkFloorBoxAward()
		end))

		if var_10_0 == 3 then
			self:_updateBoxState()
			self:_checkFloorBoxAward()
		end
	end

	g.core.model.User.wushData:resetNewStageIndex()
end

function WushFloorComp:_checkFloorBuff()
	local var_14_0 = g.core.model.User.wushData:isNeedReceiveBuff()

	if var_14_0 then
		self:addPopup(require("app.view.module.wush.view.wushPop.WushBuffChoosePop").new({
			floorId = self._floorId,
			buff = g.core.model.User.wushData:getFloorBuffArray()
		}), {
			blackOpacity = 0,
			tag = g.core.const.ConstMgr.ShowConst.BUFF_CHOOSE
		})
	end

	return var_14_0
end

function WushFloorComp:_checkFloorBoxAward()
	local var_15_0 = g.core.model.User.wushData:isNeedReceiveBox(self._isBoss)

	if var_15_0 then
		self:newScheduleOnce(handler(self, function()
			g.core.network.GameNetProxy:send_C2S_DeadBattle_BoxAward({})
		end), 0.7)
	end

	return var_15_0
end

function WushFloorComp:_onClickChest()
	local var_17_0

	if self._boxState == WushFloorComp.CLOSE then
		var_17_0 = require("app.view.module.wush.view.wushPop.WushAwardPreviewPop").new({
			floorId = self._floorId
		})
	elseif self._boxState == WushFloorComp.CAN_RECEIVE then
		return
	else
		return
	end

	self:addPopup(var_17_0)
end

function WushFloorComp:_onRcvBoxAward(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = clone(arg_18_4.awards)
	local var_18_1 = g.core.model.User.wushData:getCurFloorStar()
	local var_18_2 = g.core.lang:get(303036)

	if var_18_1 <= 9 and var_18_1 > 6 then
		var_18_2 = g.core.lang:get(303038)
	elseif var_18_1 <= 6 and var_18_1 > 3 then
		var_18_2 = g.core.lang:get(303037)
	end

	local var_18_3 = {}

	var_18_3.touchDisappear = false
	var_18_3.ignoreTouch = true
	var_18_3.blackOpacity = 0.7
	var_18_3.withoutAni = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		autoDisappear = true,
		data = var_18_0,
		tips = var_18_2,
		title = g.core.lang:get(303039),
		func = handler(self, self._afterGetBoxAward),
		showComp = fgui.UIPackage:createObject("base_new", "BaseAwardPanel")
	}), var_18_3)
end

function WushFloorComp:_afterGetBoxAward()
	self:_updateBoxState()

	if g.core.model.User.wushData:isPassFinish() then
		self.m_passFinishController:setSelectedIndex(1)
		self.m_finishTransition:play()
		self:dispatchCompEvent("WUSHFLOORCOMP_PASS_FINISH")
	else
		self.m_passFinishController:setSelectedIndex(0)
		self:dispatchCompEvent("WUSHMAINLAYER_HIDE_BATTLEINFO")

		self._isShow = true

		self:_checkFloorBuff()
	end
end

function WushFloorComp:_onRcvChooseBuff()
	self:_checkIsPassFinish()
end

function WushFloorComp:goNextFloor()
	if not g.core.model.User.wushData:isFinish() then
		self._isShow = true

		self:dispatchCompEvent("NEXT_FLOOR")
	elseif self:_checkIsPassFinish() then
		self:dispatchCompEvent("WUSHFLOORCOMP_PASS_FINISH")
		g.core.module.ModuleManager:tip(g.core.lang:get(303026))
	end
end

function WushFloorComp:onFirstAutoShowBattleInfo()
	if self._isBoss then
		self.m_bossComp:onAutoShowBattleInfo()
	else
		self.m_monsterComp1:onAutoShowBattleInfo()
	end
end

function WushFloorComp:doAutoAction()
	if not self._isBoss then
		for iter_23_0 = 1, 3 do
			if self["m_monsterComp" .. iter_23_0]:doAutoAction() then
				return
			end
		end
	else
		self.m_bossComp:doAutoAction()
	end
end

function WushFloorComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return WushFloorComp
