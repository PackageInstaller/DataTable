local MovieComp = class("MovieComp", require("app.fairyGUI.recruit.UI_MovieComp"))

function MovieComp:ctor()
	self._movieList = nil
	self._indexInfoList = {}
	self._curCriSprites = {}
	self._criSpritePool = {}
	self._floatCriSprites = {}
	self._playIdx = -1
	self._normalPlayEnd = false
	self._isJump = false

	self.m_jumpBtn:addClickListener(handler(self, self._onJumpBtnClicked))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchComp))
end

function MovieComp:_reset()
	self._movieList = nil
	self._indexInfoList = {}
	self._criSpritePool = {}
	self._curCriSprites = {}
	self._preLoad = false
	self._playIdx = -1

	self:setTouchable(false)
	self.m_jumpBtn:setVisible(false)
end

function MovieComp:setMovieList(arg_3_1, arg_3_2, arg_3_3)
	self._isJump = false
	self._keepCriSprites = {}

	if self._movieList then
		self:_clearPoolSprites()
		self:_reset()
	end

	self._movieList = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = {}

		if #iter_3_1 > 0 then
			for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
				var_3_0[iter_3_2] = self:_analyzeMovieItem(iter_3_3)
			end
		else
			var_3_0[1] = self:_analyzeMovieItem(iter_3_1)
		end

		self._movieList[iter_3_0] = var_3_0
	end

	self._touchFunc = arg_3_3
	self._callBack = arg_3_2
end

function MovieComp:setPreLoadEnable(arg_4_1)
	self._preLoad = arg_4_1
end

function MovieComp:setPlayEndNormal(arg_5_1)
	self._normalPlayEnd = arg_5_1
end

function MovieComp:isJump()
	return self._isJump
end

function MovieComp:_getAndCheckCriSpriteParams(arg_7_1)
	local var_7_0 = {
		width = false,
		height = false,
		anchorX = false,
		isAdditive = false,
		moduleName = true,
		isLoop = false,
		isReverse = false,
		fullScreenState = false,
		autoRemove = false,
		movieName = true,
		y = false,
		anchorY = false,
		x = false
	}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		var_7_0[iter_7_0] = arg_7_1[iter_7_0]

		if not var_7_0[iter_7_0] and iter_7_1 then
			assert(true, string.format("error: the required param(%s) is null", iter_7_0))

			return
		end
	end

	var_7_0.listener = handler(self, self._onMovieEventCall)

	if arg_7_1.isFloat then
		var_7_0.isLoop = true
	end

	return var_7_0
end

function MovieComp:_analyzeMovieItem(arg_8_1)
	local var_8_0 = {
		criParams = self:_getAndCheckCriSpriteParams(arg_8_1),
		id = arg_8_1.id
	}

	var_8_0.canJump = arg_8_1.canJump or false
	var_8_0.jumpId = arg_8_1.jumpId

	if var_8_0.jumpId and arg_8_1.canJump == nil then
		var_8_0.canJump = true
	end

	var_8_0.sound = arg_8_1.sound
	var_8_0.events = arg_8_1.events or {}
	var_8_0.scale = arg_8_1.scale

	return var_8_0
end

function MovieComp:_play()
	self:loadCriSprites(self._playIdx)

	if self._preLoad then
		self:loadCriSprites(self._playIdx + 1)
	end

	local var_9_0 = table.remove(self._criSpritePool, 1)

	self._curCriSprites = var_9_0.criSprites

	for iter_9_0, iter_9_1 in ipairs(self._curCriSprites) do
		iter_9_1:setVisible(true)
		iter_9_1:pause(false)

		if self._movieList[self._playIdx][iter_9_0].sound then
			g.core.sound.SoundManager:playSound(self._movieList[self._playIdx][iter_9_0].sound)
		end
	end

	self.m_jumpBtn:setVisible(var_9_0.showJump)
end

function MovieComp:_onMovieEventCall(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not self._movieList then
		return
	end

	local var_10_0 = self:_getIndex(arg_10_4)

	if not var_10_0 then
		return
	end

	local var_10_1 = self._movieList[self._playIdx][var_10_0].events[arg_10_1]

	if self._movieList[self._playIdx][var_10_0].events[arg_10_1] then
		if var_10_1.handler then
			var_10_1.handler(arg_10_1, arg_10_2, arg_10_3, arg_10_4, self)
		elseif var_10_1.jumpId then
			self:jump(var_10_1.jumpId)
		end

		return
	elseif arg_10_1 == "complete" and not arg_10_2 then
		for iter_10_0, iter_10_1 in ipairs(self._curCriSprites) do
			if iter_10_1 == arg_10_4 then
				table.remove(self._curCriSprites, iter_10_0)
				self:_removeIndexInfo(arg_10_4)

				break
			end
		end
	end

	if #self._curCriSprites < 1 then
		self:_oneMoviePlayEnd()
	end
end

function MovieComp:_oneMoviePlayEnd(arg_11_1)
	self._playIdx = self._playIdx + 1

	if self._playIdx > #self._movieList or arg_11_1 then
		self:_reset()

		self._normalPlayEnd = true

		if self._callBack then
			self:_callBack()
		end

		return
	end

	self:_play()
end

function MovieComp:jump(arg_12_1)
	self:_clearCriSpites()

	local var_12_0 = self._playIdx + 1

	if not arg_12_1 then
		for iter_12_0, iter_12_1 in ipairs(self._movieList[self._playIdx]) do
			if iter_12_1.jumpId then
				break
			end
		end
	end

	if arg_12_1 then
		for iter_12_2 = self._playIdx + 1, #self._movieList do
			for iter_12_3, iter_12_4 in ipairs(self._movieList[iter_12_2]) do
				if iter_12_4.id == arg_12_1 then
					var_12_0 = iter_12_2
					arg_12_1 = nil

					break
				end
			end

			if arg_12_1 == nil then
				break
			end
		end
	end

	self._playIdx = var_12_0

	if self._playIdx <= #self._movieList then
		self:_play()
	else
		self:_oneMoviePlayEnd()
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_SKIP)
end

function MovieComp:createCriSprites(arg_13_1)
	local var_13_0 = false
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_2 = require("app.view.common.CriSprite").new(iter_13_1.criParams)

		if iter_13_1.criParams.autoRemove == false then
			table.insert(self._keepCriSprites, var_13_2)
		end

		if iter_13_1.scale then
			var_13_2:setScale(iter_13_1.scale)
		end

		if not iter_13_1.criParams.x and not iter_13_1.criParams.y then
			-- block empty
		end

		self.m_midComp:addNode(var_13_2)
		var_13_2:setVisible(false)
		var_13_2:pause(true)

		var_13_1[iter_13_0] = var_13_2

		table.insert(self._indexInfoList, {
			node = var_13_2,
			tag = iter_13_0
		})

		if iter_13_1.canJump then
			var_13_0 = true
		end
	end

	return var_13_1, var_13_0
end

function MovieComp:_getIndex(arg_14_1)
	local var_14_0

	for iter_14_0, iter_14_1 in ipairs(self._indexInfoList) do
		if iter_14_1.node == arg_14_1 then
			var_14_0 = iter_14_1.tag

			break
		end
	end

	return var_14_0
end

function MovieComp:_removeIndexInfo(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(self._indexInfoList) do
		if iter_15_1.node == arg_15_1 then
			table.remove(self._indexInfoList, iter_15_0)

			break
		end
	end
end

function MovieComp:loadCriSprites(arg_16_1)
	if not self._movieList[arg_16_1] or self:_isLoadedCriSprites(arg_16_1) then
		return
	end

	local var_16_0, var_16_1 = self:createCriSprites(self._movieList[arg_16_1])

	self._criSpritePool[#self._criSpritePool + 1] = {
		idx = arg_16_1,
		showJump = var_16_1,
		criSprites = var_16_0
	}
end

function MovieComp:_clearCriSpites(arg_17_1)
	local var_17_0 = self._keepCriSprites

	if not arg_17_1 then
		arg_17_1 = self._curCriSprites
	else
		var_17_0 = self._curCriSprites
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		if var_17_0 then
			for iter_17_2, iter_17_3 in ipairs(var_17_0) do
				if iter_17_3 == iter_17_1 then
					table.remove(var_17_0, iter_17_2)

					break
				end
			end
		end

		iter_17_1:dispose()
	end

	if arg_17_1 == self._curCriSprites then
		self._curCriSprites = {}
	end
end

function MovieComp:_isLoadedCriSprites(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self._criSpritePool) do
		if iter_18_1.idx == arg_18_1 then
			return true
		end
	end
end

function MovieComp:_clearPoolSprites()
	for iter_19_0, iter_19_1 in ipairs(self._criSpritePool) do
		self:_clearCriSpites(iter_19_1.criSprites)
	end

	self._criSpritePool = {}
end

function MovieComp:_clearFloatSprites()
	for iter_20_0, iter_20_1 in pairs(self._floatCriSprites) do
		self:clearFloatSprite(iter_20_0, iter_20_1)
	end

	self._floatCriSprites = {}
end

function MovieComp:clearFloatSprite(arg_21_1, arg_21_2)
	arg_21_2 = arg_21_2 or self._floatCriSprites[arg_21_1]

	arg_21_2.spr:dispose()

	self._floatCriSprites[arg_21_2.param.id] = nil
end

function MovieComp:_onTouchComp()
	if self._touchFunc then
		self._touchFunc(self._movieList[self._playIdx], self)
	end
end

function MovieComp:_onJumpBtnClicked()
	self._isJump = true

	for iter_23_0 = self._playIdx, #self._movieList do
		self:jump()
	end
end

function MovieComp:playShow()
	self._normalPlayEnd = false
	self._playIdx = 1

	self:_play()
	self:setTouchable(true)
	self:setVisible(true)
end

function MovieComp:playHide()
	self:setVisible(false)
end

function MovieComp:onUnload()
	self:_clearCriSpites()
	self:_clearPoolSprites()
	self:_clearFloatSprites()
	self:clearKeepCriSpites()
end

function MovieComp:clearKeepCriSpites()
	if self._keepCriSprites and self._normalPlayEnd then
		self:_clearCriSpites(self._keepCriSprites)
	end

	self._keepCriSprites = nil
end

return MovieComp
