local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.const.ConstMgr.LineUpConst.PET_LINE_UP_FUNC_ID_PRE_KEY
local var_0_4 = 377
local var_0_5 = 377
local var_0_6 = g.core.common.Path
local var_0_7 = g.core.event.EventManager
local var_0_8 = g.core.model.User.petsData
local LineUpPetIconCell = class("LineUpPetIconCell", require("app.fairyGUI.lineUp.UI_LineUpPetIconCell"))

function LineUpPetIconCell:ctor()
	self._quality = var_0_1.QUALITY_TYPE.NONE
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onButtonStateChange))
end

function LineUpPetIconCell:updateCell(arg_2_1)
	local var_2_0 = {
		advId = 0,
		index = arg_2_1.pos,
		id = arg_2_1.sid,
		pos = arg_2_1.pos
	}
	local var_2_1 = var_0_8:getPetBySid(arg_2_1.sid)

	if var_2_1 then
		local var_2_2 = var_2_1:getCfg()

		self._quality = var_2_2.quality

		self.m_emptyController:setSelectedIndex(0)
		self.m_lockedController:setSelectedIndex(0)
		self.m_canLineUpController:setSelectedIndex(0)
		self.m_addPic:stopAllFGActions()
		self.m_petTeamIconLoader:getChild("petTeamIconLoader"):setURL((var_0_6:getPetIcon(var_2_2.resource)))

		local var_2_3, var_2_4, var_2_5 = var_0_6:getLineUpQualityBg(var_2_2.quality)

		self.m_qualityBg:setURL(var_2_3)
		self.m_qualitySelectBgLeft:setURL(var_2_4)
		self.m_qualitySelectBgRight:setURL(var_2_5)
		self.m_starComp:initStar({
			index = 3,
			style = 2,
			gap = -7,
			num = var_2_1:getStarNum()
		})

		local var_2_6 = var_2_1:getBigSmallStage()

		self.m_stageGroup:setVisible(var_2_6 > 0)

		if var_2_6 > 0 then
			self.m_stageText:setText(var_2_6)
		else
			self.m_stageText:setText("")
		end

		self.m_redPointComp:setId(var_0_5)

		var_2_0.advId = var_2_1:getAdvanceId()
	else
		self._quality = var_0_1.QUALITY_TYPE.NONE

		self.m_emptyController:setSelectedIndex(1)

		local var_2_7 = self:_getLineupFuncId(arg_2_1.pos)

		if g.core.common.ModuleUnlock:isModuleUnlock(var_2_7) then
			self.m_lockedController:setSelectedIndex(0)
			self.m_canLineUpController:setSelectedIndex(1)
			g.core.utils.Action.playBlinkAction(self.m_addPic, 1, 0)
		else
			self.m_lockedController:setSelectedIndex(1)
			self.m_canLineUpController:setSelectedIndex(0)
			self.m_unLockText:setText(g.core.lang:get(200001, {
				level = g.core.common.ModuleUnlock:getModuleUnlockLevel(var_2_7)
			}))
		end

		self.m_redPointComp:setId(var_0_4)
	end

	var_2_0.isLocked = self.m_lockedController:getSelectedIndex() == 1

	var_0_7:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = var_2_0
	})
end

function LineUpPetIconCell:_onButtonStateChange()
	if self.m_buttonController:getSelectedIndex() == 0 then
		-- block empty
	else
		local var_3_0 = {
			isLoop = false
		}

		var_3_0.name = self:_getUpQualityEffName(self._quality)

		self.m_effectHolder:addEffectSpine(var_3_0)
	end
end

function LineUpPetIconCell:_getLineupFuncId(arg_4_1)
	return var_0_2[var_0_3 .. arg_4_1]
end

function LineUpPetIconCell:_getUpQualityEffName(arg_5_1)
	return "eff_ui_lineup_iconcell_" .. math.clamp(arg_5_1, var_0_1.QUALITY_TYPE.NONE, var_0_1.QUALITY_TYPE.MAX_QUALITY) + 1
end

return LineUpPetIconCell
