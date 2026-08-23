local ThemePuzzlePieceCell = class("ThemePuzzlePieceCell", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzlePieceCell"))
local var_0_1 = g.core.common.Path

function ThemePuzzlePieceCell:ctor()
	self._info = nil
	self._hasPlayed = false
	self._isRight = false

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function ThemePuzzlePieceCell:update(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._info = arg_2_1.info
	self._cellIdx = arg_2_1.cellIdx

	self:setIcon((var_0_1:getThemePuzzlePic(self._info.res)))
end

function ThemePuzzlePieceCell:onLoad()
	return
end

function ThemePuzzlePieceCell:onUnload()
	return
end

function ThemePuzzlePieceCell:getPieceInfo()
	return self._info
end

function ThemePuzzlePieceCell:_onTouchBegin()
	local var_6_0 = self:getPieceInsertData()

	if var_6_0 then
		self:dispatchCompEvent("ThemePuzzle_PressBigPiece", var_6_0)
	end
end

function ThemePuzzlePieceCell:needPlayRightEffect()
	if not self._info or not self._cellIdx then
		return
	end

	if self._cellIdx == tonumber((string.gsub(self._info.res, "%d+[-_]%d+[-_]", ""))) and not self._hasPlayed then
		return true
	end

	return false
end

function ThemePuzzlePieceCell:checkInsertRight()
	if not self._info or not self._cellIdx then
		return
	end

	if self._cellIdx == tonumber((string.gsub(self._info.res, "%d+[-_]%d+[-_]", ""))) and not self._hasPlayed then
		self._isRight = true
		self._hasPlayed = true
	end
end

function ThemePuzzlePieceCell:playRightEffect()
	if not self._hasPlayed and self._info and self._cellIdx then
		self._hasPlayed = true
		self._isRight = true

		local var_9_0 = self.m_sizeController:getSelectedIndex()
		local var_9_1 = "3x3"

		if var_9_0 == 1 then
			var_9_1 = "3x4"
		elseif var_9_0 == 2 then
			var_9_1 = "4x4"
		end

		self.m_effectComp:addEffectSpine({
			isLoop = false,
			name = "eff_ui_themePuzzle" .. var_9_1 .. "_correct",
			anim = "play_" .. self._cellIdx
		})
	end
end

function ThemePuzzlePieceCell:isRightInsert()
	return self._isRight
end

function ThemePuzzlePieceCell:getPieceInsertData()
	if self._isRight then
		return nil
	end

	local var_11_0

	if self._info and self._cellIdx then
		local var_11_1 = self:getSize()

		var_11_0 = {
			info = self._info,
			cellIdx = self._cellIdx,
			pos = self:localToGlobal(cc.p(var_11_1.width / 2, var_11_1.height / 2))
		}
	end

	return var_11_0
end

function ThemePuzzlePieceCell:clearData()
	self._info = nil
	self._hasPlayed = false
	self._isRight = false

	self:setIcon("")
end

return ThemePuzzlePieceCell
