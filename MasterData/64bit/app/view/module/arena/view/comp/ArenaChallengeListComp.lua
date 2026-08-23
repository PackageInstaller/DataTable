local ArenaChallengeListComp = class("ArenaChallengeListComp", require("app.fairyGUI.arena.UI_ArenaChallengeListComp"))

function ArenaChallengeListComp:ctor()
	self._challengeList = nil
	self._cellNum = 0

	self:_initListView()
end

function ArenaChallengeListComp:_initListView()
	local var_2_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_2_1 = self:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_2_0.x > 0 then
		var_2_1 = var_2_1 - var_2_0.x * 2
	end

	self:setWidth(var_2_1)
	self.m_challengeList:setVirtual()
	self.m_challengeList:doFairyBatching(false)
	self.m_challengeList:setItemRenderer(handler(self, self._onChallengeList))
	self.m_challengeList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	self.m_effArrowLeft:addEffectSpine({
		isLoop = true,
		name = "eff_ui_arena_cutarrow"
	})
	self.m_effArrowright:addEffectSpine({
		isLoop = true,
		name = "eff_ui_arena_cutarrow"
	})
end

function ArenaChallengeListComp:_onChallengeList(arg_3_1, arg_3_2)
	arg_3_2:getChild("beChallengerComp"):updateCell((self._challengeList:at(arg_3_1)))
end

function ArenaChallengeListComp:_onListScroll()
	local var_4_0 = self.m_challengeList:numChildren()
	local var_4_1 = true

	if self.m_challengeList:childIndexToItemIndex(0) == 0 then
		local var_4_2 = self.m_challengeList:globalToLocal((self.m_challengeList:getChildAt(0):localToGlobal(cc.p(0, 0))))

		if var_4_2.x + 50 > 0 then
			var_4_1 = false
		elseif var_4_2.x < 50 then
			var_4_1 = true
		end
	end

	if self.m_effArrowLeft:isVisible() ~= var_4_1 then
		if var_4_1 then
			self.m_effArrowLeft:stopAllFGActions()
			self.m_effArrowLeft:setOpacity(0)
			self.m_effArrowLeft:runFGAction(fgui.FFadeTo:create(1, 255))
		end

		self.m_effArrowLeft:setVisible(var_4_1)
	end

	local var_4_3 = true

	if self.m_challengeList:childIndexToItemIndex(var_4_0 - 1) == self._cellNum - 1 then
		local var_4_4 = self.m_challengeList:getChildAt(var_4_0 - 1)
		local var_4_5 = self.m_challengeList:globalToLocal((var_4_4:localToGlobal(cc.p(var_4_4:getWidth(), 0))))

		if var_4_5.x < self.m_challengeList:getWidth() + 50 then
			var_4_3 = false
		elseif var_4_5.x > self.m_challengeList:getWidth() - 50 then
			var_4_3 = true
		end
	end

	if self.m_effArrowright:isVisible() ~= var_4_3 then
		if var_4_3 then
			self.m_effArrowright:stopAllFGActions()
			self.m_effArrowright:setOpacity(0)
			self.m_effArrowright:runFGAction(fgui.FFadeTo:create(1, 255))
		end

		self.m_effArrowright:setVisible(var_4_3)
	end
end

function ArenaChallengeListComp:_getIdxScrollTo()
	local var_5_0 = g.core.model.User.arenaData:getRank()
	local var_5_1 = 1

	if not self._challengeList then
		var_5_1 = 1
	elseif not var_5_0 then
		var_5_1 = 1
	else
		for iter_5_0 = self._challengeList:getLength(), 1, -1 do
			if var_5_0 < self._challengeList:at(iter_5_0).rank then
				var_5_1 = iter_5_0

				break
			end
		end
	end

	return var_5_1 - 1
end

function ArenaChallengeListComp:playRollAni()
	self.m_enterTransition:play()
	self.m_enterTransition:setHook("roll", handler(self, self.scrollOnEnter))
	self.m_effRoll:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_arena_roll"
	})
end

function ArenaChallengeListComp:updateView()
	self._challengeList = g.core.model.User.arenaData:getChallengeList()
	self._cellNum = self._challengeList:getLength() + 1

	self.m_challengeList:setNumItems(self._cellNum)
end

function ArenaChallengeListComp:scrollOnEnter()
	self.m_challengeList:transitionShowCells("enter_leftroll", 0.03)
end

return ArenaChallengeListComp
