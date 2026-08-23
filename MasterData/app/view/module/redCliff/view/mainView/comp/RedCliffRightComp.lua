local var_0_0 = g.core.config.chibi_pool_info
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.model.User.redCliffData
local var_0_3 = g.core.const.ConstMgr.RedCliffConst
local var_0_4 = g.core.sound.SoundManager
local var_0_5 = g.core.const.ConstMgr.SoundConst
local var_0_6 = g.core.module.ModuleManager
local RedCliffRightComp = class("RedCliffRightComp", require("app.fairyGUI.redCliff.UI_RedCliffRightComp"))

function RedCliffRightComp:ctor()
	self._myPoolId = 0
	self._curShowIndex = var_0_3.POOL_LIST_MAX_INDEX
	self._isPlaying = false

	self:_initPoolInfoList()

	self._fightEffect = nil
	self._applyEffect = nil
	self._touchStartPosition = nil

	self.m_poolList:setIniter()
	self.m_poolList:doFairyBatching(false)
	self.m_poolList:setItemRenderer(handler(self, self._onRenderPoolList))
	self.m_poolList:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_poolList:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_poolList:setScrollEnabled(false)
	self.m_poolList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
	self.m_applyBtn:addClickListener(handler(self, self._onClickApplyBtn))
	self.m_fightBtn:addClickListener(handler(self, self._onClickFightBtn))
	self:_initView()
end

function RedCliffRightComp:_initView()
	self.m_applyStateController:setSelectedIndex(var_0_3.APPLY_STATE.APPLY_ABLE)

	local var_2_0 = {
		isLoop = true,
		name = "idle"
	}

	self:_playBtnAnim(self._applyEffect, self.m_applyBtn, var_2_0)
	self:_playBtnAnim(self._fightEffect, self.m_fightBtn, var_2_0)
end

function RedCliffRightComp:_initPoolInfoList()
	self._poolInfoList = {}

	for iter_3_0, iter_3_1 in var_0_0.ipairs() do
		table.insert(self._poolInfoList, iter_3_1)
	end
end

function RedCliffRightComp:updateListSelected()
	self._myPoolId = var_0_2:getMyPoolId()

	self["m_point" .. self._curShowIndex]:setSelected(false)

	self._curShowIndex = self:_getListInitIndex((var_0_2:getGameStage()))

	self.m_poolList:setNumItems(var_0_3.POOL_LIST_SIZE)
	self.m_poolList:scrollToView(self:_getScrollIndex(self._curShowIndex), true)
	self["m_point" .. self._curShowIndex]:setSelected(true)
	self:_updateArrow()
end

function RedCliffRightComp:updateRightComp()
	self._myPoolId = var_0_2:getMyPoolId()

	local var_5_0 = var_0_2:isApply()
	local var_5_1 = var_0_2:getGameStage()
	local var_5_2 = var_0_2:getApplyState()

	self.m_applyStateController:setSelectedIndex(var_5_2)
	self.m_gameStageController:setSelectedIndex(var_5_1)

	if var_5_1 == var_0_3.GAME_STAGE.LADDER then
		if var_5_2 == var_0_3.APPLY_STATE.APPLY_ABLE then
			self.m_applyBtn:setVisible(true)
			self.m_applyBtn:setCtrlState("isApply", {
				index = 0
			})
			self.m_tipTxt:setText(g.core.lang:get(421007, {
				time = var_0_1:getDateMDHMFormat((var_0_2:getApplyEndTime()))
			}))
		elseif var_5_2 == var_0_3.APPLY_STATE.APPLIED then
			self.m_applyBtn:setVisible(false)

			local var_5_3, var_5_4 = var_0_2:getGameStageDuration(var_0_3.GAME_STAGE.LADDER)

			self.m_tipTxt:setText(g.core.lang:get(421126, {
				startTime = var_0_1:getDateMDFormat(var_5_3),
				endTime = var_0_1:getDateMDFormat(var_5_4 - 86400)
			}))
			self.m_fightBtn:setVisible(var_0_2:getUpgradeStateByPoolId(var_0_3.POOL_ID_INDEX[self._curShowIndex]) >= var_0_3.UPGRADE_STATE.CURRENT)
			self.m_fightBtn:setCtrlState("canFight", {
				index = var_0_2:checkCanFightByPoolId(self._myPoolId) and 1 or 0
			})
		else
			self.m_applyBtn:setVisible(false)

			local var_5_5, var_5_6 = var_0_2:getGameStageDuration(var_0_3.GAME_STAGE.LADDER)

			self.m_tipTxt:setText(g.core.lang:get(421126, {
				startTime = var_0_1:getDateMDFormat(var_5_5),
				endTime = var_0_1:getDateMDFormat(var_5_6 - 86400)
			}))
		end
	elseif var_5_1 == var_0_3.GAME_STAGE.APPLY then
		self.m_applyBtn:setVisible(true)
		self.m_applyBtn:setCtrlState("isApply", {
			index = var_5_0 and 1 or 0
		})
		self.m_tipTxt:setText(g.core.lang:get(421007, {
			time = var_0_1:getDateMDHMFormat((var_0_2:getApplyEndTime()))
		}))
	else
		self.m_applyBtn:setVisible(false)

		if var_5_1 == var_0_3.GAME_STAGE.FINAL then
			if var_0_2:isInPoolTimeDuration(var_0_3.POOL_ID.SEMI) then
				self.m_tipTxt:setText(g.core.lang:get(421018, {
					startTime = var_0_1:getDateMDFormat((var_0_2:getDurationByPoolId(var_0_3.POOL_ID.SEMI)))
				}))
				self.m_finishTipGroup:setVisible(var_5_0 and self._myPoolId < var_0_3.POOL_ID.SEMI)
				self.m_fightBtn:setVisible(self._myPoolId >= var_0_3.POOL_ID.SEMI)
				self.m_fightBtn:setCtrlState("canFight", {
					index = var_0_2:checkCanFightByPoolId(self._myPoolId) and 1 or 0
				})
			else
				local var_5_7 = {}

				var_5_7.startTime = var_0_1:getDateMDFormat((var_0_2:getDurationByPoolId(var_0_3.POOL_ID.GRAND)))

				self.m_tipTxt:setText(g.core.lang:get(421019, var_5_7))

				local var_5_8 = (not checkbool((var_0_2:getCurrentPoolFightTime(var_0_3.POOL_ID.GRAND))) or self._myPoolId < var_0_3.POOL_ID.GRAND) and var_5_0

				self.m_finishTipGroup:setVisible(var_5_8)
				self.m_fightBtn:setVisible(self._myPoolId == var_0_3.POOL_ID.GRAND and not var_5_8)
				self.m_fightBtn:setCtrlState("canFight", {
					index = var_0_2:checkCanFightByPoolId(self._myPoolId) and 1 or 0
				})
			end
		end
	end
end

function RedCliffRightComp:refreshListView()
	self.m_poolList:setNumItems(var_0_3.POOL_LIST_SIZE)
end

function RedCliffRightComp:playPoolCompEnterTransition()
	local var_7_0 = self.m_poolList:getChildAt(self._curShowIndex)

	if var_7_0 and var_7_0.m_enterTransition then
		var_7_0.m_enterTransition:play()
	end
end

function RedCliffRightComp:_updateArrow()
	self.m_upArrow:setVisible(self._curShowIndex > 1)
	self.m_downArrow:setVisible(self._curShowIndex < 4)
end

function RedCliffRightComp:_onRenderPoolList(arg_9_1, arg_9_2)
	arg_9_2:updatePoolComp({
		poolInfo = self._poolInfoList[var_0_3.POOL_LIST_SIZE - arg_9_1 - 1],
		myPoolId = var_0_2:getMyPoolId(),
		isSel = arg_9_1 == self._curShowIndex
	})
end

function RedCliffRightComp:_onTouchBegin(arg_10_1)
	arg_10_1:captureTouch()

	self._touchStartPosition = arg_10_1:getInput():getTouch():getLocation()
end

function RedCliffRightComp:_onTouchEnd(arg_11_1)
	if self._isPlaying or not self._touchStartPosition then
		self._touchStartPosition = nil

		return
	end

	self.m_screenTouch:setVisible(true)
	self:newScheduleOnce(handler(self, function(arg_12_0)
		arg_12_0.m_screenTouch:setVisible(false)
	end), var_0_3.SWITCH_INTERVAL)

	local var_11_0 = arg_11_1:getInput()
	local var_11_1 = var_11_0:getTouch():getLocation()

	if math.abs(self._touchStartPosition.y - var_11_0.y) < 10 then
		self._touchStartPosition = nil

		return
	end

	if self._touchStartPosition.y > var_11_1.y then
		if self._curShowIndex == 1 then
			return
		end

		self:_playOpenAndCloseTransition(self._curShowIndex, self._curShowIndex - 1)
	elseif self._touchStartPosition.y < var_11_1.y then
		if self._curShowIndex == 4 then
			return
		end

		self:_playOpenAndCloseTransition(self._curShowIndex, self._curShowIndex + 1)
	end
end

function RedCliffRightComp:_onClickItem(arg_13_1)
	if self._isPlaying then
		return
	end

	local var_13_0 = arg_13_1:getDataValue()

	if var_13_0 == self._curShowIndex then
		return
	end

	self.m_screenTouch:setVisible(true)
	self:newScheduleOnce(handler(self, function(arg_14_0)
		arg_14_0.m_screenTouch:setVisible(false)
	end), var_0_3.SWITCH_INTERVAL)
	self:_playOpenAndCloseTransition(self._curShowIndex, var_13_0)
end

function RedCliffRightComp:_playOpenAndCloseTransition(arg_15_1, arg_15_2)
	self._isPlaying = true
	self._touchStartPosition = nil

	self.m_poolList:setTouchable(false)
	self.m_fightBtn:setTouchable(false)
	var_0_4:playSound(var_0_5.Sound.UI_EVENT_SMALL_SLIDE_HAIDAO)
	self:newScheduleOnce(handler(self, function(arg_16_0)
		arg_16_0.m_poolList:setTouchable(true)
		arg_16_0.m_fightBtn:setTouchable(true)
	end), 0.5)

	local var_15_1 = self.m_poolList:getChildAt((self.m_poolList:itemIndexToChildIndex(arg_15_1)))
	local var_15_2 = self.m_poolList:getChildAt((self.m_poolList:itemIndexToChildIndex(arg_15_2)))

	if var_15_2.m_openTransition then
		var_15_2.m_openTransition:play(handler(self, self._onOpenEnd))
	end

	if var_15_1.m_closeTransition then
		var_15_1.m_closeTransition:play()
	end

	self.m_poolList:scrollToView(self:_getScrollIndex(arg_15_2), true)
	self["m_point" .. arg_15_1]:setSelected(false)
	self["m_point" .. arg_15_2]:setSelected(true)

	self._curShowIndex = arg_15_2

	self:_updateArrow()
end

function RedCliffRightComp:_onOpenEnd()
	self._isPlaying = false
end

function RedCliffRightComp:_getScrollIndex(arg_18_1)
	if arg_18_1 < 3 then
		return 1
	elseif arg_18_1 > 3 then
		return 4
	else
		return 3
	end
end

function RedCliffRightComp:_getListInitIndex(arg_19_1)
	if arg_19_1 == var_0_3.GAME_STAGE.APPLY then
		return var_0_3.POOL_INDEX.CROSS
	elseif arg_19_1 == var_0_3.GAME_STAGE.LADDER then
		if var_0_2:isApply() then
			if var_0_2:getMyPoolId() == var_0_3.POOL_ID.CROSS then
				return var_0_3.POOL_INDEX.CROSS
			else
				return var_0_3.POOL_INDEX.ALL
			end
		else
			return var_0_3.POOL_INDEX.CROSS
		end
	else
		if var_0_2:isInPoolTimeDuration(var_0_3.POOL_ID.SEMI) then
			return var_0_3.POOL_INDEX.SEMI
		end

		return var_0_3.POOL_INDEX.GRAND
	end

	return var_0_3.POOL_INDEX.CROSS
end

function RedCliffRightComp:_onClickApplyBtn()
	if var_0_2:isApply() then
		var_0_6:tip(g.core.lang:get(421022))

		return
	end

	self:_playBtnAnim(self._applyEffect, self.m_applyBtn, {
		remove = true,
		name = "click",
		isLoop = false
	})
	g.core.network.GameNetProxy:send_C2S_ChiBi_Apply({})
end

function RedCliffRightComp:_onClickFightBtn()
	local var_21_0 = var_0_2:checkCanFightByPoolId(self._myPoolId)
	local var_21_1 = {
		remove = true,
		name = "click",
		isLoop = false
	}

	if var_0_3.POOL_ID_INDEX[self._curShowIndex] == self._myPoolId then
		if var_21_0 then
			var_0_4:playSound(var_0_5.Sound.UI_EVENT_ENTER_OCEAN)
			g.core.network.GameNetProxy:send_C2S_ChiBi_EnterRoom({})
		else
			local var_21_2 = var_0_2:getPoolInfoByPoolId(self._myPoolId)

			if self._myPoolId == var_0_3.POOL_ID.GRAND then
				if var_0_2:isLastMatchEndByPoolId(var_0_3.POOL_ID.GRAND) then
					var_0_6:tip(g.core.lang:get(421117, {
						pool = var_21_2.pool_name
					}))
				else
					var_0_6:tip(g.core.lang:get(421023, {
						pool = var_21_2.pool_name
					}))
				end
			else
				var_0_6:tip(g.core.lang:get(421023, {
					pool = var_21_2.pool_name
				}))
			end
		end
	else
		local var_21_3 = self._curShowIndex

		self._curShowIndex = self:_getPoolIndex(self._myPoolId)

		self:_playOpenAndCloseTransition(var_21_3, self._curShowIndex)
		self.m_poolList:scrollToView(self:_getScrollIndex(self._curShowIndex), true)
		self["m_point" .. var_21_3]:setSelected(false)
		self["m_point" .. self._curShowIndex]:setSelected(true)
		self:_updateArrow()

		if var_21_0 then
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_ENTER_OCEAN)
			self.m_fightBtn:setTouchable(false)
			self:newScheduleOnce(handler(self, function(arg_22_0)
				g.core.network.GameNetProxy:send_C2S_ChiBi_EnterRoom({})
				arg_22_0.m_fightBtn:setTouchable(true)
			end), 0.3)
		else
			local var_21_4 = {}

			var_21_4.pool = var_0_2:getPoolInfoByPoolId(self._myPoolId).pool_name

			var_0_6:tip(g.core.lang:get(421023, var_21_4))
		end
	end

	if var_21_0 then
		self:_playBtnAnim(self._fightEffect, self.m_fightBtn, var_21_1)
	end
end

function RedCliffRightComp:_getPoolIndex(arg_23_1)
	if arg_23_1 == var_0_3.POOL_ID.CROSS then
		return var_0_3.POOL_INDEX.CROSS
	elseif arg_23_1 == var_0_3.POOL_ID.ALL then
		return var_0_3.POOL_INDEX.ALL
	elseif arg_23_1 == var_0_3.POOL_ID.SEMI then
		return var_0_3.POOL_INDEX.SEMI
	elseif arg_23_1 == var_0_3.POOL_ID.GRAND then
		return var_0_3.POOL_INDEX.GRAND
	end

	return var_0_3.POOL_INDEX.CROSS
end

function RedCliffRightComp:_playBtnAnim(arg_24_1, arg_24_2, arg_24_3)
	if not arg_24_1 then
		arg_24_1 = arg_24_2:getChild("effect"):addEffectSpine({
			name = "eff_ui_redCliff_btn",
			isLoop = arg_24_3.isLoop,
			anim = arg_24_3.name,
			remove = arg_24_3.remove
		})
	else
		arg_24_1:setAnimation(0, arg_24_3.name, arg_24_3.isLoop)
	end
end

function RedCliffRightComp:onUnload()
	self._isPlaying = false
	self._touchStartPosition = nil
end

return RedCliffRightComp
