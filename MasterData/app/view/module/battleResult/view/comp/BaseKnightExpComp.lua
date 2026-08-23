local BaseKnightExpComp = class("BaseKnightExpComp", require("app.fairyGUI.base.UI_BaseKnightExpComp"))

function BaseKnightExpComp:ctor()
	self._isMax = false
end

function BaseKnightExpComp:update(arg_2_1)
	if self._updated then
		return
	end

	self._updated = true

	local var_2_0 = g.core.model.User:getLevel()
	local var_2_1 = g.core.model.User.resourceData:getExp()
	local var_2_2 = var_2_0
	local var_2_3 = 0
	local var_2_4 = g.core.config.role_info.get(var_2_0)
	local var_2_5 = arg_2_1.result.role_exp or 0

	if var_2_1 < var_2_5 then
		var_2_5 = var_2_5 - var_2_1

		for iter_2_0 = var_2_0 - 1, 1, -1 do
			local var_2_6 = g.core.config.role_info.get(iter_2_0)

			if var_2_5 < var_2_6.level_up_exp then
				var_2_2 = var_2_6.level
				var_2_3 = var_2_6.level_up_exp - var_2_5
				var_2_4 = var_2_6

				break
			elseif iter_2_0 > 1 then
				var_2_5 = var_2_5 - var_2_6.level_up_exp

				if var_2_5 == 0 then
					var_2_2 = var_2_6.level
					var_2_3 = 0
					var_2_4 = var_2_6

					break
				end
			else
				var_2_2 = 1
				var_2_3 = 0
				var_2_4 = var_2_6
			end
		end
	else
		var_2_3 = var_2_1 - var_2_5
	end

	self.m_lvPreText:setText(g.core.lang:get(2084))
	self.m_levelText:setText(var_2_2)

	local var_2_7 = arg_2_1.result.role_exp or 0

	self.m_addExpText:setText(g.core.lang:get(1134, {
		exp = var_2_7
	}))

	if var_2_4 and var_2_4.level_up_exp > 0 then
		self.m_mainProg:setValue(var_2_3)
		self.m_mainProg:setMax(var_2_4.level_up_exp)
		self.m_expPreText:setText(g.core.lang:get(2083) .. var_2_1 .. "/" .. var_2_4.level_up_exp)
	else
		self._isMax = true

		self.m_mainProg:setValue(var_2_1)
		self.m_mainProg:setMax(var_2_1)
		self.m_expPreText:setText("MAX")
	end

	self._curLevel = var_2_0
	self._curExp = var_2_1
	self._preExp = var_2_3
	self._preLevel = var_2_2
end

function BaseKnightExpComp:play()
	if self._isMax then
		-- block empty
	elseif self._curLevel and self._curExp and self._preExp and self._preLevel then
		local var_3_0 = {}

		for iter_3_0 = self._preLevel, self._curLevel do
			local var_3_1 = 0
			local var_3_2 = 0
			local var_3_4 = iter_3_0
			local var_3_5 = g.core.config.role_info.get(iter_3_0)

			if not var_3_5 then
				return
			end

			local var_3_6 = var_3_5.level_up_exp

			var_3_2 = iter_3_0 == self._curLevel and self._curExp or var_3_5.level_up_exp
			var_3_1 = iter_3_0 == self._preLevel and self._preExp or 0

			table.insert(var_3_0, fgui.FCallFunc:create(handler(self, function()
				self.m_mainProg:setValue(var_3_1)
				self.m_mainProg:setMax(var_3_6)
			end)))
			table.insert(var_3_0, fgui.FCallFunc:create(handler(self, function()
				self.m_mainProg:displayObject():stopAllActions()
				self.m_mainProg:tweenValue(var_3_2, 0.4)
			end)))
			table.insert(var_3_0, fgui.FDelayTime:create(0.5))

			if iter_3_0 < self._curLevel then
				table.insert(var_3_0, fgui.FCallFunc:create(handler(self, function()
					self.m_levelText:setText(var_3_4 + 1)
				end)))
			end
		end

		self:runFGAction(fgui.FSequence:create(var_3_0))
	end
end

return BaseKnightExpComp
