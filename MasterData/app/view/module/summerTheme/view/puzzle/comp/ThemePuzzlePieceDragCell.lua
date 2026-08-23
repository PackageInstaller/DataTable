local ThemePuzzlePieceDragCell = class("ThemePuzzlePieceDragCell", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzlePieceDragCell"))
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.ThemeConst

function ThemePuzzlePieceDragCell:ctor()
	self.getSharedTrans(self, "enter_up", "CommonLongCellList", self)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
end

function ThemePuzzlePieceDragCell:update(arg_2_1)
	self._info = arg_2_1 and arg_2_1.info
	self._cellIdx = arg_2_1 and arg_2_1.cellIdx

	self.m_sizeController:setSelectedIndex((arg_2_1 or nil) and (arg_2_1.ctrlIdx or 0))
	self:setIcon((var_0_1:getThemePuzzlePic(self._info.res)))
end

function ThemePuzzlePieceDragCell:_onTouchBegin(arg_3_1)
	arg_3_1:captureTouch()

	local var_3_0 = arg_3_1:getInput():getTouch()

	if not var_3_0 then
		return
	end

	self._beginPos = var_3_0:getLocation()
	self._isBegin = true
end

function ThemePuzzlePieceDragCell:_onTouchMove(arg_4_1)
	local var_4_0 = arg_4_1:getInput():getTouch()

	if not var_4_0 then
		return
	end

	if self._beginPos.x - var_4_0:getLocation().x > var_0_2.PUZZLE_DRAG_X and self._info and self._isBegin then
		self._isBegin = false

		local var_4_1 = self:getSize()

		self:dispatchCompEvent("ThemePuzzle_PressSmallPiece", {
			info = self._info,
			cellIdx = self._cellIdx,
			pos = self:localToGlobal(cc.p(var_4_1.width / 2, var_4_1.height / 2))
		})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.PUZZLE_SELECT)
	end
end

function ThemePuzzlePieceDragCell:onLoad()
	return
end

function ThemePuzzlePieceDragCell:onUnload()
	return
end

function ThemePuzzlePieceDragCell:getPieceInfo()
	return self._info
end

return ThemePuzzlePieceDragCell
