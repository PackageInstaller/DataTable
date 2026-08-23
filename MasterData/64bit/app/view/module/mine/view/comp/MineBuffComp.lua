local MineConst = require("app.view.module.mine.const.MineConst")
local MineBuffComp = class("MineBuffComp", require("app.fairyGUI.mine.UI_MineBuffComp"))

function MineBuffComp:updateBuffComp(arg_1_1, arg_1_2)
	self._cityStruct = arg_1_1.struct

	local var_1_0 = arg_1_1.struct:getCfg()
	local var_1_1 = arg_1_1.struct:isCapital()

	self.m_isCapitalController:setSelectedIndex(var_1_1 and 1 or 0)

	local var_1_2 = arg_1_1.struct:getEventId()
	local var_1_3 = arg_1_1.struct:getPeopleNum()

	self.m_normalCapitalController:setSelectedIndex(0)
	self.m_itemIcon:setURL(g.core.common.Goods:convert(g.core.const.ConstMgr.MineConst.PRODUCT_ITEM).icon)

	if var_1_1 then
		local var_1_4 = 0

		if var_1_2 == MineConst.EVENT_ID.CAPITAL then
			var_1_4 = g.core.config.mine_event_info.get(var_1_2).cap_preduce_speed
		else
			self.m_normalCapitalController:setSelectedIndex(1)
		end

		self.m_radioTxt:setText(g.core.lang:get(307506, {
			num = var_1_4
		}))

		return
	end

	self.m_richTypeController:setSelectedIndex(var_1_2 == MineConst.EVENT_ID.BONUS and 1 or var_1_2 == MineConst.EVENT_ID.ADVANCE_BONUS and 2 or 0)

	local var_1_6 = g.core.config.mine_city_info.get(var_1_0.mine_parameter)

	self.m_uniqueTxt:setText(g.core.lang:get(307539, {
		num = var_1_6.exclusive_bonus / 10
	}))
	self.m_occuTxt:setText(g.core.lang:get(307539, {
		num = var_1_6.occu_bonus / 10
	}))

	local var_1_7 = g.core.model.User.mineData:getOwnCity()
	local var_1_8, var_1_9 = arg_1_1.struct:isDecrease()

	self.m_isEnterController:setSelectedIndex(var_1_7 == var_1_0.id and 1 or 0)

	local var_1_10 = g.core.platform.ServerListProxy:getSelectedServer().sid
	local var_1_11 = g.core.model.User.guildData:getGuildId()
	local var_1_12 = arg_1_1.struct:getGuildData()

	if not g.core.model.User.guildData:hasGuild() then
		arg_1_2 = MineConst.NOT_OCCU
	elseif var_1_7 ~= var_1_0.id then
		if var_1_3 == 0 then
			arg_1_2 = MineConst.UNIQUE_STATE
		else
			var_1_8, var_1_9 = arg_1_1.struct:isDecrease(var_1_3 + 1)

			if not var_1_12 or tostring(var_1_12.id) ~= tostring(var_1_11) then
				arg_1_2 = MineConst.NOT_OCCU
			end
		end
	elseif not var_1_12 or tostring(var_1_12.id) ~= tostring(var_1_11) then
		arg_1_2 = MineConst.NOT_OCCU
	end

	if var_1_12 and arg_1_2 ~= MineConst.UNIQUE_STATE then
		arg_1_2 = g.core.const.ConstMgr.MineConst.OCCU_STATE
	end

	self.m_stateController:setSelectedIndex(arg_1_2)
	self.m_isOverController:setSelectedIndex(var_1_8 and 1 or 0)

	local var_1_13 = 0

	if arg_1_2 == MineConst.OCCU_STATE then
		var_1_13 = var_1_6.occu_bonus
	elseif arg_1_2 == MineConst.UNIQUE_STATE then
		var_1_13 = var_1_6.occu_bonus + var_1_6.exclusive_bonus
	end

	if var_1_8 then
		var_1_13 = var_1_13 - var_1_9 * 1000

		self.m_overTxt:setText(g.core.lang:get(307541, {
			num = var_1_9 * 100
		}))
		self.m_overNumTxt:setText(g.core.lang:get(307540, {
			count = var_1_3,
			limit = var_1_6.station_num
		}))
	end

	self.m_isDebuffController:setSelectedIndex(var_1_13 < 0 and 1 or 0)
	self.m_buffTxt:setText(math.abs(math.floor(var_1_13 / 10)) .. "%)")
	self.m_bonusStateController:setSelectedIndex(var_1_13 == 0 and 1 or 0)
	self.m_radioTxt:setText(g.core.lang:get(307506, {
		num = var_1_6.preduce_speed * ((var_1_2 > 0 or nil) and g.core.config.mine_event_info.get(var_1_2).preduce_speed_rate1 / 1000) * (1 + var_1_13 / 1000)
	}))
	self:updateAddition()
end

function MineBuffComp:updateAddition()
	local var_2_0 = 0
	local var_2_1 = g.core.model.User.mineData:getTimeStage() == MineConst.TIME_STAGE.TOTAL_WAR

	if var_2_1 then
		var_2_0 = var_2_0 + 1

		local var_2_2 = g.core.config.mine_desc_info.get(2)

		self["m_stateDesc" .. var_2_0]:setText(var_2_2.name .. "：" .. var_2_2.simple_desc)
	end

	local var_2_3 = self._cityStruct:getEventId()

	if var_2_3 > 0 then
		local var_2_4 = g.core.config.mine_event_info.get(var_2_3)

		if var_2_4.desc == 5 and var_2_1 then
			-- block empty
		else
			local var_2_5 = g.core.config.mine_desc_info.get(var_2_4.desc)

			var_2_0 = var_2_0 + 1

			self["m_stateDesc" .. var_2_0]:setText(var_2_5.name .. "：" .. var_2_5.simple_desc)
		end
	end

	self.m_stateNumController:setSelectedIndex(var_2_0)
end

return MineBuffComp
