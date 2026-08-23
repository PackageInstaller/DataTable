local ShowFactory = require("app.view.module.show.ShowFactory")
local var_0_1 = g.core.const.ConstMgr.InfoConst.BlitzType
local BlitzResultPop = class("BlitzResultPop", require("app.fairyGUI.infoPop.UI_BlitzResultPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		resName = "BlitzResultPop",
		pkgName = "infoPop"
	})
end)

function BlitzResultPop:ctor(arg_2_1)
	if arg_2_1 then
		self._num = arg_2_1.num or 1
	end

	if arg_2_1 then
		self._stageId = arg_2_1.stageId or 1
	end

	if arg_2_1 then
		self._acqData = arg_2_1.acqData or {}
	end

	self._needNum = self._acqData.needNum or 0

	if arg_2_1 then
		self._isAdvModule = arg_2_1.isAdvModule or false
	end

	if arg_2_1 then
		self._advPos = arg_2_1.advPos or 0
	end

	if arg_2_1 then
		self._knightSid = arg_2_1.knightSid or 0
	end

	self._blitzType = arg_2_1.type or var_0_1.DUNGEON
	self._autoUse = arg_2_1.autoUse == 1
	self._dropAcqNum = 0
	self._knightExp = 0
	self._roleExp = 0
	self._silver = 0
	self._result = {}
	self._curTime = 0
	self._totalTimes = 0
	self._lineupCount = g.core.model.User.knightsData:getFormationKnightsCount()
	self._acqCount = 0
	self._blitzCount = 0
	self._fightCount = 0
	self._isEnough = false
	self._speedParam = 2
	self._scheduleCount = 0
	self._finishEffect = nil
	self._showAcq = checkbool(next(self._acqData))
	self._waitState = true

	self:_initAcquireCount()
	self:getView():setSize(display.width, display.height)
	self.m_touchComp:addClickListener(handler(self, self._onClickSpeedUp))
	self.m_backBtnComp:addClickListener(handler(self, self._onClickBack))
	self:sendBlitzMsg()
	self:_updateAcquireProgComp()

	self._biographie = g.core.model.User.resourceData:getBioGraphie()

	if self._num > 1 then
		self.m_backBtnComp:setTitle(g.core.lang:get(300032))
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
end

function BlitzResultPop:onLoad()
	self.m_touchComp:setVisible(false)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_ADVANCEEQUIP, self._onRcvAdvanceEquip, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_FASTCHALLENGESTAGE, self._onRcvBlitz, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_FASTEXECUTEMISSION, self._onRcvBlitz, self)
	self:_initList()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT)
end

function BlitzResultPop:_onRcvAdvanceEquip()
	g.core.module.ModuleManager:popComponent()
end

function BlitzResultPop:_initAcquireCount()
	self._acqCount = next(self._acqData) and g.core.model.User.bagData:getCountById(self._acqData.type, self._acqData.value) or 0
end

function BlitzResultPop:_updateAcquireProgComp(arg_6_1)
	if self._showAcq then
		arg_6_1 = arg_6_1 or g.core.model.User.bagData:getCountById(self._acqData.type, self._acqData.value)
		self._isEnough = arg_6_1 >= self._needNum
	end

	local var_6_0 = not self._isAdvModule and self._showAcq

	self:setCtrlState("times", {
		index = self._num == 1 and 0 or 1
	})
	self:setCtrlState("type", {
		index = var_6_0 and 1 or 0
	})

	if self._isEnough and self._advPos > 0 and self._knightSid > 0 then
		self:setCtrlState("type", {
			index = 2
		})
	end
end

function BlitzResultPop:sendBlitzMsg()
	self._diffStamina = g.core.model.User.resourceData:getVit()

	local var_7_0 = {}

	if checkbool(next(self._acqData)) and self._needNum > 0 then
		if self._needNum >= 0 then
			var_7_0 = {
				type = self._acqData.type,
				value = self._acqData.value,
				size = self._needNum
			}
		end
	end

	if self._blitzType == var_0_1.DUNGEON then
		g.core.network.GameNetProxy:send_C2S_Dungeon_FastChallengeStage({
			id = self._stageId,
			num = self._num,
			award = var_7_0,
			use_items = self._autoUse
		})
	elseif self._blitzType == var_0_1.BIOGRAPHY then
		g.core.network.GameNetProxy:send_C2S_Biography_FastExecuteMission({
			use_items = true,
			id = self._stageId,
			num = self._num
		})
	end
end

function BlitzResultPop:_initList()
	self.m_awardList:setItemIniter(function(arg_9_0, arg_9_1)
		if arg_9_0 == fgui.UIPackage:normalizeURL("ui://infoPop/BlitzResultCell") then
			arg_9_1:bindLua("app.view.base.infoPop.BlitzResultCell")
		else
			arg_9_1:bindLua("app.view.base.infoPop.BlitzResultFinishCell")
		end
	end)
	self:_updateItemRenderer()
end

function BlitzResultPop:_updateItemRenderer()
	self.m_awardList:setItemRenderer(function(arg_11_0, arg_11_1)
		if arg_11_0 < self._totalTimes then
			local var_11_0 = {
				index = arg_11_0 + 1,
				data = self._result[arg_11_0 + 1],
				blitzCount = self._blitzCount,
				isAnim = self._speedParam > 1
			}

			if self._showAcq then
				local var_11_1 = var_11_0.data.drops or {}

				if var_11_1 then
					for iter_11_0, iter_11_1 in ipairs(var_11_1) do
						iter_11_1.effect = iter_11_1.type == self._acqData.type and iter_11_1.value == self._acqData.value
					end
				end
			end

			arg_11_1:update(var_11_0)
		elseif self._showAcq then
			local var_11_2 = self._acqData.needNum
			local var_11_3

			if self._acqData.needNum == 0 then
				var_11_2 = self._dropAcqNum
				var_11_3 = {}
			end

			var_11_3.acqData = {
				type = self._acqData.type,
				value = self._acqData.value,
				size = self._dropAcqNum,
				numCost = var_11_2
			}

			arg_11_1:update(var_11_3)
		else
			arg_11_1:update({
				roleExp = self._roleExp,
				silver = self._silver,
				result = self._result
			})
		end
	end)
end

function BlitzResultPop:_onUpdateList(arg_12_1, arg_12_2)
	self:_updateList()
end

function BlitzResultPop:_updateList()
	self._scheduleCount = self._scheduleCount + 1

	if self._scheduleCount < self._speedParam then
		return
	end

	self._scheduleCount = self._scheduleCount - self._speedParam

	if self._curTime < self._totalTimes then
		local var_13_3 = self.m_awardList:animationAddCell("ui://infoPop/BlitzResultCell")
	else
		local var_13_4 = "ui://infoPop/BlitzResultFinishCell"

		self.m_touchComp:setVisible(false)
		self.m_backBtnComp:setTitle(g.core.lang:get(300033))

		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._speedParam = 2

		local var_13_5 = self.m_awardList:animationAddCell(var_13_4)

		var_13_5:setCtrlState("isEnough", {
			index = self._fightCount < self._num and 0 or 1
		})

		if self._blitzType == var_0_1.BIOGRAPHY and self._totalTimes < self._num then
			var_13_5:setCtrlState("isEnough", {
				index = 0
			})
		end

		self:cancelAllSchedule()
		self:runFGAction((fgui.FSequence:create({
			fgui.FDelayTime:create(0.4),
			fgui.FCallFunc:create(handler(self, function()
				self:_updateBtnState(true)
				self:_checkRebelState()
			end))
		})))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_DUNGEON_BLITZ_FINISH, false)

		if g.core.model.User:isLevelUp() then
			if self._diffStamina then
				local var_13_6
				local var_13_7, var_13_8

				if self._blitzType == var_0_1.DUNGEON then
					var_13_6 = g.core.config.dungeon_stage_info.get(self._stageId)
				else
					var_13_6 = g.core.model.User.bioData:getMission(self._stageId)
					var_13_7 = {}
					var_13_8 = {
						popScene = false
					}
				end

				var_13_8.diff = g.core.model.User.resourceData:getVit() - (var_13_6.cost * self._totalTimes - self._diffStamina)
				var_13_7.dungeonBlitz = var_13_8

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
					showNow = true,
					frontShow = {
						{
							flag = "levelUp",
							func = function()
								return ShowFactory:showLevelUp(false, var_13_7.diff)
							end
						}
					}
				})
			else
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
					showNow = true,
					frontShow = {
						{
							flag = "levelUp",
							func = function()
								return ShowFactory:showLevelUp()
							end
						}
					}
				})
			end
		end
	end

	self._curTime = self._curTime + 1
end

function BlitzResultPop:_onRcvBlitz(arg_17_1, arg_17_2, arg_17_3)
	if arg_17_3.num <= 0 then
		return
	end

	self._knightExp = arg_17_3.knight_add_exp or 0

	local var_17_0 = arg_17_3.num
	local var_17_1 = {}

	if self._blitzType == var_0_1.DUNGEON then
		var_17_1 = clone(arg_17_3.results)
	elseif self._blitzType == var_0_1.BIOGRAPHY then
		var_17_1 = clone(arg_17_3.awards)

		for iter_17_0, iter_17_1 in ipairs(var_17_1) do
			self._knightExp = self._knightExp + iter_17_1.knight_exp
			iter_17_1.drops = iter_17_1.finish_drops
		end
	end

	self._blitzCount = self._blitzCount + 1
	self._fightCount = arg_17_3.num
	self._dropAcqNum = 0

	if self._diffStamina then
		self._diffStamina = self._diffStamina - g.core.model.User.resourceData:getVit()
	end

	self._roleExp = 0
	self._silver = 0

	self:_updateBtnState(false)

	self._result = {}

	if var_17_0 == 1 then
		self._result[1] = var_17_1[1]
		self._roleExp = var_17_1[1].role_exp or 0
		self._silver = var_17_1[1].silver or 0
	else
		self.m_touchComp:setVisible(true)
		self.m_backBtnComp:setTitle(g.core.lang:get(300032))

		for iter_17_2 = 1, var_17_0 do
			if var_17_1[iter_17_2] then
				self._result[var_17_1[iter_17_2].index] = var_17_1[iter_17_2]
				self._roleExp = self._roleExp + (var_17_1[iter_17_2].role_exp or 0)
				self._silver = self._silver + (var_17_1[iter_17_2].silver or 0)
			else
				break
			end
		end
	end

	for iter_17_3 = 1, #self._result do
		for iter_17_4 = 1, #self._result[iter_17_3].drops do
			if self._acqData.type and self._result[iter_17_3].drops[iter_17_4].type == self._acqData.type then
				self._dropAcqNum = self._dropAcqNum + self._result[iter_17_3].drops[iter_17_4].size

				break
			end
		end
	end

	self._totalTimes = table.nums(self._result)

	self:cancelAllSchedule()
	self:_updateItemRenderer()
	self:newSchedule(function()
		self:_onUpdateList()
	end, 0.5)
end

function BlitzResultPop:_updateBtnState(arg_19_1)
	self.m_backBtnComp:setTouchable(arg_19_1)
	self.m_popPanel:getChild("closeBtn"):setVisible(arg_19_1)
end

function BlitzResultPop:_checkRebelState()
	local var_20_0 = g.core.model.User.rebelData:getNewestRebelElem()
	local var_20_1

	if var_20_0 and g.core.model.User.rebelData:isTodayNotify() then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.function.DungeonFindHostPop").new(var_20_0)))

		var_20_1 = g.core.model.User.goldSavingData:getHasNewGameId()
	end

	if not g.core.model.User.goldSavingData:isIgnoreTodayTip() and var_20_1 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.function.GoldSavingTickPop").new({
			id = var_20_1
		}), {
			blackOpacity = 0
		})
	end
end

function BlitzResultPop:_onClickBack()
	if self._isEnough and self._advPos > 0 and self._knightSid > 0 then
		if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ADVANCE) then
			return
		end
	elseif self._showAcq and not self._isAdvModule then
		g.core.module.ModuleManager:popAllPopup()
	else
		g.core.module.ModuleManager:popComponent({
			popScene = false
		})
	end
end

function BlitzResultPop:_onClickSpeedUp()
	self.m_touchComp:setVisible(false)
	self.m_backBtnComp:setTitle(g.core.lang:get(300033))
	self:cancelAllSchedule()
	self.m_awardList:setNumItems(self._totalTimes)

	self._speedParam = 1
	self._curTime = self._totalTimes

	self:_updateList()
end

function BlitzResultPop:receiveCompEvent(arg_23_1, arg_23_2)
	if arg_23_1 == "txt_pop_ok" then
		if arg_23_2 and arg_23_2.flag == "dungeonReset" then
			g.core.network.GameNetProxy:send_C2S_Dungeon_ResetChallengeCount({
				id = self._stageId
			})
		end
	elseif arg_23_1 == "rebel_appear_pop_cancel" then
		return false
	end
end

function BlitzResultPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MOP_UP_POP_CLOSE)

	if self._waitState then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitState = false
	end
end

return BlitzResultPop
