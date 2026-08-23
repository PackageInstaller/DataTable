local var_0_0 = g.core.model.User.monopolyDataMgr
local MonopolyConst = require("app.view.module.monopoly.const.MonopolyConst")
local MonopolyPathGridComp = class("MonopolyPathGridComp", require("app.fairyGUI.monopoly.UI_MonopolyPathGridComp"))

function MonopolyPathGridComp:ctor()
	self._level = 1
	self._exp = 0
	self._gridData = nil
end

function MonopolyPathGridComp:updateGridLv(arg_2_1)
	self._gridCfg = arg_2_1

	local var_2_0 = var_0_0:getMonopolyData():getGridData(arg_2_1.id)

	self._gridData = var_2_0

	if var_2_0 then
		self._level = var_2_0.level or self._level
		self._exp = var_2_0.exp or self._exp
	end

	self:updateGridShow()
end

function MonopolyPathGridComp:getGridData()
	return {
		cfg = self._gridCfg,
		level = self._level
	}
end

function MonopolyPathGridComp:playLevelUpAnim(arg_4_1, arg_4_2)
	self._level = arg_4_1.level or self._level
	self._exp = arg_4_1.exp or self._exp

	self:updateGridShow()

	if self._level ~= self._level then
		self._effNode:showGridEff({
			eff = {
				anim = "play",
				name = "eff_ui_monopoly_levelUp",
				isLoop = false,
				remove = true,
				eventHandler = function(self, arg_5_1)
					if self.type == "complete" and arg_4_2 then
						arg_4_2()
					end
				end
			},
			node = self.m_eff
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.MONOPOLY_UPDATE_LEVEL, false, {
			oldLv = self._level,
			newLv = self._level,
			gridCfg = self._gridCfg
		})
	else
		arg_4_2()
	end
end

function MonopolyPathGridComp:showRewardEff(arg_6_1)
	self._effNode:showGridEff({
		eff = {
			anim = "play1",
			name = "eff_ui_monopoly_rewardDown",
			isLoop = false,
			remove = true,
			eventHandler = function(self, arg_7_1)
				if self.type == "complete" and arg_6_1 then
					arg_6_1()
				end
			end
		},
		node = self.m_effDown
	}, true)
	self._effNode:showGridEff({
		eff = {
			name = "eff_ui_monopoly_rewardUp",
			remove = true,
			isLoop = false,
			anim = "play" .. 4 - self._gridCfg.type
		},
		node = self.m_eff
	})
end

function MonopolyPathGridComp:showEffExMove(arg_8_1, arg_8_2)
	self.m_effDown:addEffectSpine({
		name = "eff_ui_monopoly_move",
		isLoop = false,
		remove = true,
		anim = arg_8_1 and "play_forward" or "play_backward",
		eventHandler = function(self, arg_9_1)
			if self.type == "complete" and arg_8_2 then
				arg_8_2()
			end
		end
	})
	self._effNode:showGridEff({
		eff = {
			name = "eff_ui_monopoly_move",
			isLoop = false,
			remove = true,
			anim = arg_8_1 and "play_forward" or "play_backward",
			eventHandler = function(self, arg_10_1)
				if self.type == "complete" and arg_8_2 then
					arg_8_2()
				end
			end
		},
		node = self.m_effDown
	}, true)
end

function MonopolyPathGridComp:setEffNode(arg_11_1)
	self._effNode = arg_11_1
end

function MonopolyPathGridComp:changeGridType(arg_12_1)
	self._gridCfg = arg_12_1

	self.m_typeController:setSelectedIndex(arg_12_1.type)
	self.m_title:setText(arg_12_1.type)

	local var_12_0 = var_0_0:getMonopolyData():getGridData(arg_12_1.id)

	self:updateGridShow()

	local var_12_1 = self.m_imgIcon:getScale()

	self.m_imgIcon:setScaleX(var_12_1.x)
	self.m_imgIcon:setScaleY(var_12_1.y)

	local var_12_2 = 83
	local var_12_3 = 41.5

	local function var_12_4(arg_13_0, arg_13_1)
		return (arg_13_0 - arg_13_1) * var_12_2, -(-(arg_13_0 + arg_13_1) * var_12_3)
	end

	if arg_12_1.type == MonopolyConst.EVENT_TYPE.FRONT_GRIDS then
		local var_12_5 = math.abs(var_12_1.x)
		local var_12_6 = math.abs(var_12_1.y)
		local var_12_7 = g.core.config.monopoly_grid_info.get(arg_12_1.next_id)
		local var_12_8, var_12_9 = var_12_4(arg_12_1.x, arg_12_1.y)
		local var_12_10, var_12_11 = var_12_4(var_12_7.x, var_12_7.y)

		if var_12_8 < var_12_10 then
			if var_12_9 < var_12_11 then
				self.m_imgIcon:setScaleX(-var_12_5)
				self.m_imgIcon:setScaleY(-var_12_6)
			else
				self.m_imgIcon:setScaleX(-var_12_5)
				self.m_imgIcon:setScaleY(var_12_6)
			end
		elseif var_12_11 < var_12_9 then
			self.m_imgIcon:setScaleX(var_12_5)
			self.m_imgIcon:setScaleY(var_12_6)
		else
			self.m_imgIcon:setScaleX(var_12_5)
			self.m_imgIcon:setScaleY(-var_12_6)
		end
	elseif arg_12_1.type == MonopolyConst.EVENT_TYPE.BEHIND_GRIDS then
		local var_12_12 = g.core.config.monopoly_grid_info.get(arg_12_1.front_id)
		local var_12_13 = math.abs(var_12_1.x)
		local var_12_14 = math.abs(var_12_1.y)
		local var_12_15, var_12_16 = var_12_4(arg_12_1.x, arg_12_1.y)
		local var_12_17, var_12_18 = var_12_4(var_12_12.x, var_12_12.y)

		if var_12_17 < var_12_15 then
			if var_12_18 < var_12_16 then
				self.m_imgIcon:setScaleX(var_12_13)
				self.m_imgIcon:setScaleY(var_12_14)
			else
				self.m_imgIcon:setScaleX(var_12_13)
				self.m_imgIcon:setScaleY(-var_12_14)
			end
		elseif var_12_16 < var_12_18 then
			self.m_imgIcon:setScaleX(-var_12_13)
			self.m_imgIcon:setScaleY(-var_12_14)
		else
			self.m_imgIcon:setScaleX(-var_12_13)
			self.m_imgIcon:setScaleY(var_12_14)
		end
	end

	self._gridData = var_12_0
end

function MonopolyPathGridComp:playRewardBoxAnim(arg_14_1)
	self._effNode:showGridEff({
		eff = {
			anim = "play",
			name = "eff_ui_monopoly_chest",
			isLoop = false,
			remove = true,
			eventHandler = function(self, arg_15_1)
				if self.type == "complete" and arg_14_1 then
					arg_14_1()
				end
			end
		},
		node = self.m_boxComp
	})
end

function MonopolyPathGridComp:showNewBox()
	self._effNode:showBoxWithTarget(self.m_boxComp)
end

function MonopolyPathGridComp:updateGridShow(arg_17_1)
	local var_17_0 = var_0_0:getMonopolyData()

	if not var_17_0:isInDiceAnim() and var_17_0:getBoxGridId() == self._gridCfg.id then
		self._effNode:showBoxWithTarget(self.m_boxComp)
	end

	local var_17_1 = var_17_0:getGridLvCfg(self._gridCfg.type, self._level)

	if self._gridCfg.type ~= MonopolyConst.EVENT_TYPE.START then
		if self._level > 5 then
			self.m_qualityController:setSelectedIndex(5)
		else
			self.m_qualityController:setSelectedIndex(self._level)
		end

		self.m_levelTxt:setNumProgressShow(self._exp, var_17_1.exp)
	end

	if var_17_1 and var_17_1.next_level == 0 then
		self.m_levelTxt:setIsMax()
	end
end

function MonopolyPathGridComp:updateGridSkipShow()
	local var_18_0 = var_0_0:getMonopolyData():getGridData(self._gridCfg.id)

	self._gridData = var_18_0

	if var_18_0 then
		self._level = var_18_0.level or self._level
		self._exp = var_18_0.exp or self._exp
	end

	self:updateGridShow()
end

function MonopolyPathGridComp:_onAnimationEnd(arg_19_1)
	if arg_19_1.type == "event" and arg_19_1.eventData.name == "cut" then
		self:updateGridIcon()
	end
end

function MonopolyPathGridComp:updateGridIcon()
	self.m_typeController:setSelectedIndex(self._gridCfg.type - 1)
end

return MonopolyPathGridComp
