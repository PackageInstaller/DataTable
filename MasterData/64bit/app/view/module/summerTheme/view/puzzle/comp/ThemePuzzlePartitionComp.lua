local ThemePuzzlePartitionComp = class("ThemePuzzlePartitionComp", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzlePartitionComp3"), function()
	local var_1_0 = {
		...
	}

	return fgui.GComponent:create({
		isFullScreen = false,
		pkgName = "summerThemeGame",
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		resName = var_1_0[1].resName
	}, ...)
end)

function ThemePuzzlePartitionComp:ctor(arg_2_1)
	self._pieceNum = arg_2_1 and arg_2_1.pieceNum

	if arg_2_1 then
		self._allPieceSet = arg_2_1.allPieceSet or {}
	end

	self.m_enterTransition:setHook("move", handler(self, self._onTransitionMove))
	self.m_enterTransition:setHook("end", handler(self, self._onTransitionEnd))

	self._originPosMap = {}

	for iter_2_0 = 1, #self._allPieceSet do
		if self["m_cell_" .. iter_2_0] then
			self._originPosMap[iter_2_0] = self["m_cell_" .. iter_2_0]:getPosition()
		end
	end

	self._insertedPieceMap = {}
end

function ThemePuzzlePartitionComp:playBreakAni()
	for iter_3_0 = 1, #self._allPieceSet do
		local var_3_0 = string.gsub(self._allPieceSet[iter_3_0].res, "%d+[-_]%d+[-_]", "")

		if self["m_cell_" .. var_3_0] then
			self["m_cell_" .. var_3_0]:update({
				info = self._allPieceSet[iter_3_0],
				cellIdx = var_3_0
			})
		end
	end
end

function ThemePuzzlePartitionComp:playFlyAni()
	if self.m_enterTransition then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.PUZZLE_BEGIN)
		self.m_enterTransition:play(handler(self, self._onTransitionEnter))
	end
end

function ThemePuzzlePartitionComp:_resetPiecePosition()
	for iter_5_0 = 1, #self._originPosMap do
		if self._originPosMap[iter_5_0] and self["m_cell_" .. iter_5_0] then
			self["m_cell_" .. iter_5_0]:clearData()
			self["m_cell_" .. iter_5_0]:setPosition(self._originPosMap[iter_5_0])
			self["m_cell_" .. iter_5_0]:setScale(1)
			self["m_cell_" .. iter_5_0]:setRotation(0)
		end
	end
end

function ThemePuzzlePartitionComp:_onTransitionEnter()
	self:_resetPiecePosition()
	self:getView():setAlpha(1)
	self:dispatchCompEvent("ThemePuzzle_onEnterBig")
end

function ThemePuzzlePartitionComp:_onTransitionMove()
	self:dispatchCompEvent("ThemePuzzle_EnterBigMove")
end

function ThemePuzzlePartitionComp:_onTransitionEnd()
	self:dispatchCompEvent("ThemePuzzle_EnterBigEnd")
end

function ThemePuzzlePartitionComp:onLoad()
	return
end

function ThemePuzzlePartitionComp:onUnload()
	return
end

function ThemePuzzlePartitionComp:checkInsertPiece(arg_11_1)
	local var_11_0 = arg_11_1 and arg_11_1.toPos
	local var_11_2
	local var_11_3

	for iter_11_0 = 1, 16 do
		if self["m_cell_" .. iter_11_0] then
			local var_11_5 = self["m_cell_" .. iter_11_0]:getPosition()
			local var_11_6 = self["m_cell_" .. iter_11_0]:getSize()

			if cc.rectContainsPoint({
				x = var_11_5.x,
				y = var_11_5.y,
				width = var_11_6.width,
				height = var_11_6.height
			}, (self:globalToLocal(var_11_0))) and not self["m_cell_" .. iter_11_0]:isRightInsert() then
				var_11_2 = iter_11_0
				var_11_3 = self:localToGlobal(cc.p(var_11_5.x + var_11_6.width / 2, var_11_5.y + var_11_6.height / 2))

				break
			end
		end
	end

	if var_11_2 then
		return true, var_11_3, var_11_2
	else
		return false
	end
end

function ThemePuzzlePartitionComp:insert(arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_1 then
		return
	end

	if arg_12_2 and arg_12_3 then
		self._insertedPieceMap[arg_12_2] = arg_12_1
	elseif arg_12_2 and not arg_12_3 then
		self._insertedPieceMap[arg_12_2] = arg_12_1

		if self._insertedPieceMap[arg_12_2] then
			return self._insertedPieceMap[arg_12_2]
		end
	end
end

function ThemePuzzlePartitionComp:pop(arg_13_1)
	self._insertedPieceMap[arg_13_1] = nil

	return self._insertedPieceMap[arg_13_1]
end

function ThemePuzzlePartitionComp:updateView()
	local var_14_0

	for iter_14_0, iter_14_1 in pairs(self._insertedPieceMap) do
		if self["m_cell_" .. iter_14_0] then
			self["m_cell_" .. iter_14_0]:update({
				info = iter_14_1,
				cellIdx = iter_14_0
			})

			if self["m_cell_" .. iter_14_0]:needPlayRightEffect() and not var_14_0 then
				var_14_0 = self["m_cell_" .. iter_14_0]

				break
			end
		end
	end

	if var_14_0 then
		self:getView():setChildIndex(var_14_0, self:getView():numChildren())
		var_14_0:playRightEffect()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.PUZZLE_RIGHT)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.PUZZLE_WRONG)
	end
end

function ThemePuzzlePartitionComp:checkRightPieceCount()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(self._insertedPieceMap) do
		if iter_15_0 == tonumber((string.gsub(iter_15_1.res, "%d+[-_]%d+[-_]", ""))) then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function ThemePuzzlePartitionComp:receiveCompEvent(arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or {}

	if arg_16_1 == "ThemePuzzle_PressBigPiece" and arg_16_2.cellIdx then
		return false
	end
end

function ThemePuzzlePartitionComp:popPiece(arg_17_1, arg_17_2)
	if arg_17_1 and arg_17_2 then
		self._insertedPieceMap[arg_17_2] = nil

		if self["m_cell_" .. arg_17_2] then
			self["m_cell_" .. arg_17_2]:clearData()
		end
	end
end

function ThemePuzzlePartitionComp:getPieceInsertData(arg_18_1)
	local var_18_0

	if arg_18_1 then
		if self["m_cell_" .. arg_18_1] then
			var_18_0 = self["m_cell_" .. arg_18_1]:getPieceInsertData()
		end
	end

	return var_18_0
end

function ThemePuzzlePartitionComp:playCompleteEffect()
	return
end

return ThemePuzzlePartitionComp
