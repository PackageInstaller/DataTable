local BattleBuffInfoComp = class("BattleBuffInfoComp", require("app.fairyGUI.battle.UI_BattleBuffInfoComp"), function()
	return fgui.GComponent:create({
		resName = "BattleBuffInfoComp",
		pkgPath = "ui/battle/battle",
		pkgName = "battle"
	})
end)

function BattleBuffInfoComp:ctor()
	self._buff = {}
	self._debuff = {}
	self._buffClickIndex = 0
	self._debuffClickIndex = 0
	self._clickBuff = false
	self._clickDebuff = false

	self.m_buffList:setVirtual()
	self.m_buffList:setItemRenderer(handler(self, self._renderBuffItem))
	self.m_buffList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickBuffItem))
	self.m_debuffList:setVirtual()
	self.m_debuffList:setItemRenderer(handler(self, self._renderDeBuffItem))
	self.m_debuffList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickDebuffItem))
end

function BattleBuffInfoComp:_renderBuffItem(arg_3_1, arg_3_2)
	local var_3_0 = self._buff[arg_3_1 + 1]

	if self._buff[arg_3_1 + 1] and type(var_3_0) ~= "table" then
		var_3_0 = self._mergeBuff[var_3_0][1]
	end

	arg_3_2:updateView(var_3_0, self._buffClickIndex == arg_3_1 + 1)
end

function BattleBuffInfoComp:_renderDeBuffItem(arg_4_1, arg_4_2)
	local var_4_0 = self._debuff[arg_4_1 + 1]

	if self._debuff[arg_4_1 + 1] and type(var_4_0) ~= "table" then
		var_4_0 = self._mergeDebuff[var_4_0][1]
	end

	arg_4_2:updateView(var_4_0, self._debuffClickIndex == arg_4_1 + 1)
end

function BattleBuffInfoComp:_onClickBuffItem(arg_5_1)
	local var_5_0 = arg_5_1:getDataValue()

	if var_5_0 + 1 == self._buffClickIndex then
		return
	end

	self.m_showController:setSelectedIndex(1)

	self._buffClickIndex = var_5_0 + 1
	self._debuffClickIndex = 0

	local var_5_1 = self._buff[self._buffClickIndex] or {}

	if var_5_1 and type(var_5_1) ~= "table" then
		local var_5_2 = ""

		for iter_5_0, iter_5_1 in ipairs(self._mergeBuff[var_5_1]) do
			if var_5_2 ~= "" then
				var_5_2 = var_5_2 .. "\n"
			end

			if iter_5_1 and iter_5_1.buffCfg and iter_5_1.buffCfg.buff_name then
				var_5_2 = var_5_2 .. g.core.utils.String.formatBuffDesc(iter_5_1.buffCfg.id)
			end
		end

		self.m_desText:setText(var_5_2)
	elseif var_5_1 and var_5_1.buffCfg and var_5_1.buffCfg.buff_name then
		self.m_desText:setText((g.core.utils.String.formatBuffDesc(var_5_1.buffCfg.id)))
	end

	self.m_buffList:setNumItems(#self._buff)
	self.m_debuffList:setNumItems(#self._debuff)
end

function BattleBuffInfoComp:_onClickDebuffItem(arg_6_1)
	local var_6_0 = arg_6_1:getDataValue()

	if var_6_0 + 1 == self._debuffClickIndex then
		return
	end

	self.m_showController:setSelectedIndex(1)

	self._debuffClickIndex = var_6_0 + 1
	self._buffClickIndex = 0

	local var_6_1 = self._debuff[self._debuffClickIndex] or {}

	if var_6_1 and type(var_6_1) ~= "table" then
		local var_6_2 = ""

		for iter_6_0, iter_6_1 in ipairs(self._mergeDebuff[var_6_1]) do
			if var_6_2 ~= "" then
				var_6_2 = var_6_2 .. "\n"
			end

			if iter_6_1 and iter_6_1.buffCfg and iter_6_1.buffCfg.buff_name then
				var_6_2 = var_6_2 .. g.core.utils.String.formatBuffDesc(iter_6_1.buffCfg.id)
			end
		end

		self.m_desText:setText(var_6_2)
	elseif var_6_1 and var_6_1.buffCfg and var_6_1.buffCfg.buff_name then
		self.m_desText:setText((g.core.utils.String.formatBuffDesc(var_6_1.buffCfg.id)))
	end

	self.m_buffList:setNumItems(#self._buff)
	self.m_debuffList:setNumItems(#self._debuff)
end

function BattleBuffInfoComp:checkMerge(arg_7_1, arg_7_2)
	if arg_7_1.buffCfg.buff_type == 1001 or arg_7_1.buffCfg.buff_type == 1002 then
		if arg_7_2 then
			self._mergeDebuff[arg_7_1.buffCfg.buff_type] = self._mergeDebuff[arg_7_1.buffCfg.buff_type] or {}

			table.insert(self._mergeDebuff[arg_7_1.buffCfg.buff_type], arg_7_1)
		else
			self._mergeBuff[arg_7_1.buffCfg.buff_type] = self._mergeBuff[arg_7_1.buffCfg.buff_type] or {}

			table.insert(self._mergeBuff[arg_7_1.buffCfg.buff_type], arg_7_1)
		end

		return arg_7_1.buffCfg.buff_type
	end

	return arg_7_1
end

function BattleBuffInfoComp:updateView(arg_8_1)
	arg_8_1 = clone(arg_8_1)
	self._buff = {}
	self._debuff = {}
	self._mergeBuff = {}
	self._mergeDebuff = {}
	self._buffClickIndex = 0
	self._debuffClickIndex = 0
	self._clickBuff = false
	self._clickDebuff = false

	self.m_showController:setSelectedIndex(0)

	local var_8_0 = {
		{},
		{}
	}

	for iter_8_0 = 1, #arg_8_1.buffs do
		if arg_8_1.buffs[iter_8_0].buffCfg and arg_8_1.buffs[iter_8_0].buffCfg.buff_increase_type == 1 and arg_8_1.buffs[iter_8_0].buffCfg.is_banned ~= 1 then
			local var_8_1 = self:checkMerge(arg_8_1.buffs[iter_8_0], false)

			if type(var_8_1) ~= "table" then
				if not var_8_0[1][var_8_1] then
					table.insert(self._buff, var_8_1)
				end

				var_8_0[1][var_8_1] = true
			else
				table.insert(self._buff, var_8_1)
			end
		elseif arg_8_1.buffs[iter_8_0].buffCfg and arg_8_1.buffs[iter_8_0].buffCfg.buff_increase_type == 2 and arg_8_1.buffs[iter_8_0].buffCfg.is_banned ~= 1 then
			local var_8_2 = self:checkMerge(arg_8_1.buffs[iter_8_0], true)

			if type(var_8_2) ~= "table" then
				if not var_8_0[2][var_8_2] then
					table.insert(self._debuff, var_8_2)
				end

				var_8_0[2][var_8_2] = true
			else
				table.insert(self._debuff, var_8_2)
			end
		end
	end

	self.m_name:setText(arg_8_1.name)
	self.m_buffList:setNumItems(#self._buff)
	self.m_debuffList:setNumItems(#self._debuff)
end

return BattleBuffInfoComp
