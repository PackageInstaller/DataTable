local ThemeGuessKnightFrontComp = class("ThemeGuessKnightFrontComp", require("app.fairyGUI.summerThemeGame.UI_ThemeGuessKnightFrontComp"))

function ThemeGuessKnightFrontComp:ctor()
	self._initPos = self.m_mask:getPosition()
end

function ThemeGuessKnightFrontComp:changeKnight(arg_2_1)
	self._defaultCfg = arg_2_1

	self:onChangeKnight()
end

function ThemeGuessKnightFrontComp:playCloseAnim(arg_3_1)
	self._curRange = 2200

	self.m_mask:setPosition(self._initPos)

	local var_3_0 = {
		startFlag = {
			self._curRange,
			self._curRange
		},
		endFlag = {
			0,
			0
		}
	}

	if arg_3_1 then
		self.m_hideAllTransition:changeParams(var_3_0):play(arg_3_1)
	else
		self.m_hideAllTransition:changeParams(var_3_0):play()
	end
end

function ThemeGuessKnightFrontComp:onChangeKnight()
	self._curRange = self._defaultCfg.initial_range
	self._perAddRange = self._defaultCfg.enlarge_range

	self.m_mask:setSize(cc.size(0, 0))
	self.m_changeSizeTransition:changeParams({
		startFlag = {
			0,
			0
		},
		endFlag = {
			self._curRange,
			self._curRange
		}
	}):play()
	self.m_mask:setPosition(cc.pAdd(self._initPos, cc.p(-self._defaultCfg.x_pos * 0.7, -self._defaultCfg.y_pos * 0.7)))
end

function ThemeGuessKnightFrontComp:onDefaultSelection()
	if self._curRange and self._perAddRange then
		local var_5_0 = {
			startFlag = {
				self._curRange,
				self._curRange
			}
		}

		self._curRange = self._curRange + self._perAddRange
		var_5_0.endFlag = {
			self._curRange,
			self._curRange
		}

		self.m_changeSizeTransition:changeParams(var_5_0):play()
	end
end

function ThemeGuessKnightFrontComp:showAll()
	local var_6_0 = {
		startFlag = {
			self._curRange,
			self._curRange
		}
	}

	self._curRange = 2200
	var_6_0.endFlag = {
		self._curRange,
		self._curRange
	}

	self.m_changeSizeAllTransition:changeParams(var_6_0):play()
end

return ThemeGuessKnightFrontComp
