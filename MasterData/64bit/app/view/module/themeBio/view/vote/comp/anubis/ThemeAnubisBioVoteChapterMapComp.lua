local ThemeAnubisBioVoteChapterMapComp = class("ThemeAnubisBioVoteChapterMapComp", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteChapterMapComp"))
local ThemeBioConst = require("app.view.module.themeBio.const.ThemeBioConst")
local var_0_4 = g.core.const.ConstMgr.ThemeConst
local var_0_5 = 3

function ThemeAnubisBioVoteChapterMapComp:ctor()
	self.m_chapterArr = {}
	self._chapterInfos = nil

	for iter_1_0 = 1, var_0_5 do
		self.m_chapterArr[iter_1_0] = self["m_chapterComp" .. iter_1_0]
	end
end

function ThemeAnubisBioVoteChapterMapComp:updatePageView(arg_2_1)
	self._chapterInfos = arg_2_1

	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if self.m_chapterArr[iter_2_0] then
			self.m_chapterArr[iter_2_0]:updateData(iter_2_1, var_0_4.THEME_VALUE.ANUBIS, iter_2_0)

			local var_2_1 = self.m_chapterArr[iter_2_0]:getChapterUnlockStatus()

			if var_2_1 > 0 and iter_2_0 <= var_0_5 then
				self.m_curChapterController:setSelectedIndex(iter_2_0)

				if var_2_1 > 0 and var_2_0 < iter_2_0 then
					var_2_0 = iter_2_0
				end
			end
		end
	end

	self:_updateShipView(var_2_0)
end

function ThemeAnubisBioVoteChapterMapComp:_updateShipView(arg_3_1)
	self:_setShipVisible(false)

	if arg_3_1 == 1 then
		if self.m_effShip1 then
			self.m_effShip1:setVisible(true)
			self.m_effShip1:removeAllEffect()
			self.m_effShip1:addEffectSpine({
				isLoop = true,
				name = "eff_ui_themeAnubisBio_boat",
				anim = "idle"
			})
		end
	elseif arg_3_1 == 2 then
		if self.m_effShip2 then
			self.m_effShip2:setVisible(true)
			self.m_effShip2:setPosition(self.m_position2:getPosition())
			self.m_effShip2:removeAllEffect()
			self.m_effShip2:addEffectSpine({
				isLoop = true,
				name = "eff_ui_themeAnubisBio_boat",
				anim = "idle"
			})
		end
	elseif arg_3_1 == 3 then
		if not self.m_chapterArr[3] or self.m_chapterArr[3]:getChapterFinishStatus() then
			-- block empty
		elseif self.m_effShip2 then
			self.m_effShip2:setVisible(true)
			self.m_effShip2:setPosition(self.m_position3:getPosition())
			self.m_effShip2:removeAllEffect()
			self.m_effShip2:addEffectSpine({
				isLoop = true,
				name = "eff_ui_themeAnubisBio_boat",
				anim = "idle"
			})
		end
	end
end

function ThemeAnubisBioVoteChapterMapComp:_playShip2Idle()
	if self.m_effShip2 then
		self.m_effShip2:setPosition(self.m_position2:getPosition())
		self.m_effShip2:removeAllEffect()
		self.m_effShip2:addEffectSpine({
			isLoop = true,
			name = "eff_ui_themeAnubisBio_boat",
			anim = "idle"
		})
	end
end

function ThemeAnubisBioVoteChapterMapComp:_setShipVisible(arg_5_1)
	self.m_ship1:setVisible(arg_5_1)
	self.m_ship2:setVisible(arg_5_1)
	self.m_effShip1:setVisible(arg_5_1)
	self.m_effShip2:setVisible(arg_5_1)
end

function ThemeAnubisBioVoteChapterMapComp:playUnlockEffect(arg_6_1)
	if self["m_chapterComp" .. arg_6_1 + 1] then
		self["m_chapterComp" .. arg_6_1 + 1]:playUnlockEnterEffect()
	end

	self:_setShipVisible(false)

	if arg_6_1 == 1 then
		self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			self.m_hideLine1Transition:play()
		end), cc.DelayTime:create(1.7), cc.CallFunc:create(function()
			self.m_curChapterController:setSelectedIndex(arg_6_1 + 1)
			self.m_effShip1:setVisible(true)
			self.m_effShip1:removeAllEffect()
			self.m_effShip1:addEffectSpine({
				isLoop = true,
				name = "eff_ui_themeAnubisBio_boat",
				anim = "move"
			})
			self.m_shipMove1Transition:play(function()
				self.m_effShip1:removeAllEffect()
				self.m_effShip1:addEffectSpine({
					isLoop = true,
					name = "eff_ui_themeAnubisBio_boat",
					anim = "idle"
				})
			end)
		end)))
	elseif arg_6_1 == 2 then
		self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			self.m_hideLine2Transition:play()
		end), cc.DelayTime:create(1.7), cc.CallFunc:create(function()
			self.m_curChapterController:setSelectedIndex(arg_6_1 + 1)
			self.m_effShip2:setVisible(true)
			self.m_effShip2:removeAllEffect()
			self.m_effShip2:addEffectSpine({
				isLoop = true,
				name = "eff_ui_themeAnubisBio_boat",
				anim = "move"
			})
			self.m_shipMove2Transition:play(function()
				if self.m_effShip2 then
					self.m_effShip2:setPosition(self.m_position3:getPosition())
					self.m_effShip2:removeAllEffect()
					self.m_effShip2:addEffectSpine({
						isLoop = true,
						name = "eff_ui_themeAnubisBio_boat",
						anim = "idle"
					})
				end
			end)
		end)))
	end
end

function ThemeAnubisBioVoteChapterMapComp:playEnterEffect(arg_13_1)
	self._chapterInfos = arg_13_1

	for iter_13_0, iter_13_1 in ipairs(self._chapterInfos) do
		if self.m_chapterArr[iter_13_0] then
			self.m_chapterArr[iter_13_0]:checkPlayedPassEffect()
		end
	end
end

return ThemeAnubisBioVoteChapterMapComp
