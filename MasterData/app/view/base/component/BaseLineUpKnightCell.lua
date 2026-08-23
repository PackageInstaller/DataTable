local BaseLineUpKnightCell = class("BaseLineUpKnightCell", require("app.fairyGUI.base_new.UI_BaseLineUpKnightCell"))
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.model.User.weddingData

function BaseLineUpKnightCell:ctor()
	self._effectName = "eff_ui_lineup_iconcell_1"
	self._state = 0
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onButtonStateChange))
end

function BaseLineUpKnightCell:updateCell(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if not arg_2_1 then
		return
	end

	local var_2_0

	if arg_2_5 then
		self.m_isOtherController:setSelectedIndex(1)

		var_2_0 = g.core.model.User.friendData:getPlayerInfo().knightIdDict[arg_2_1]
	else
		self.m_isOtherController:setSelectedIndex(0)

		var_2_0 = var_0_2:getKnight({
			id = arg_2_1
		})

		if var_0_3:isWeddingVowByKnightId(var_2_0:getAdvanceId()) then
			self.m_isWeddingController:setSelectedIndex(1)
			self.m_weddingLoader:setURL(g.core.common.Path:getWeddingVowLineUpIcon())
		else
			self.m_isWeddingController:setSelectedIndex(0)
		end

		self.m_redPointComp:setId(arg_2_4 or 0)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				index = arg_2_3,
				id = arg_2_1,
				advId = var_2_0:getAdvanceId(),
				pos = arg_2_3
			}
		})
	end

	if var_2_0 then
		local var_2_1, var_2_2, var_2_3 = var_0_1:getLineUpQualityBg(var_2_0:getQuality())

		self.m_qualityBg:setURL(var_2_1)
		self.m_qualitySelectBgLeft:setURL(var_2_2)
		self.m_qualitySelectBgRight:setURL(var_2_3)
		self.m_isLockController:setSelectedIndex(0)
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_canLineUpController:setSelectedIndex(0)
		self.m_addPic:stopAllFGActions()

		local var_2_4 = var_2_0:getBaseInfo()

		self.m_knightIcon:setIcon((var_0_1:getKnightIconById(var_2_0:getResInfo().painted_id)))
		self.m_starComp:initStar({
			index = 3,
			style = 2,
			gap = -7,
			num = var_2_0:getStarLv()
		})

		local var_2_5 = var_2_0:getAdvStageAndLevel()

		if var_2_5 > 0 then
			self.m_stageGroup:setVisible(true)
			self.m_stageText:setText(var_2_5)
		else
			self.m_stageGroup:setVisible(false)
			self.m_stageText:setText("")
		end

		self._effectName = "eff_ui_lineup_iconcell_" .. math.clamp(var_2_4.quality, g.core.const.ConstMgr.QUALITY_TYPE.NONE, g.core.const.ConstMgr.QUALITY_TYPE.MAX_QUALITY) + 1
	else
		self.m_isEmptyController:setSelectedIndex(1)

		if g.core.common.ModuleUnlock:isModuleUnlock(arg_2_2) then
			self.m_isLockController:setSelectedIndex(0)
			self.m_canLineUpController:setSelectedIndex(1)
		else
			self.m_isLockController:setSelectedIndex(1)
			self.m_unLockText:setText(g.core.lang:get(200001, {
				level = g.core.common.ModuleUnlock:getModuleUnlockLevelAndComment(arg_2_2)
			}))
		end
	end

	self:_onButtonStateChange()
end

function BaseLineUpKnightCell:_onButtonStateChange()
	local var_3_0 = self.m_buttonController:getSelectedIndex()

	if var_3_0 == 0 then
		self:setScale(0.9)
	else
		self:setScale(1)

		if self._state ~= var_3_0 then
			self.m_effectHolder:addEffectSpine({
				scale = 1,
				isLoop = false,
				name = self._effectName
			})
		end
	end

	self._state = var_3_0
end

return BaseLineUpKnightCell
