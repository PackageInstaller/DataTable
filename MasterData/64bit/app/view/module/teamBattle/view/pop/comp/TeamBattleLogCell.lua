local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.config.team_battle_journal_info
local TeamBattleLogCell = class("TeamBattleLogCell", require("app.fairyGUI.teamBattle.UI_TeamBattleLogCell"))

function TeamBattleLogCell:ctor()
	self.m_descTxt:enableRich()
end

function TeamBattleLogCell:updateLogShow(arg_2_1)
	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.user_id)

	if var_2_0 then
		local var_2_1 = ""

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.awards or {}) do
			if iter_2_0 ~= 1 then
				var_2_1 = var_2_1 .. "、"
			end

			local var_2_2 = var_0_0:convert(iter_2_1)

			var_2_1 = var_2_1 .. var_2_2.name .. " x " .. var_2_2.size
		end

		local var_2_3 = ""
		local var_2_4 = ""

		if arg_2_1.tp == 1 then
			local var_2_5 = g.core.config.team_battle_monster_info.get(arg_2_1.value)
			local var_2_6 = g.core.config.team_battle_monster_name_info.match(function(arg_3_0)
				return arg_3_0.name_group == var_2_5.guard_name
			end)

			var_2_3 = var_2_6[math.max(1, arg_2_1.value * g.core.model.User.teamBattleData:getActivityId() % (#var_2_6 + 1))].monster_name
			var_2_4 = g.core.model.User.teamBattleData:getMapData():getHomeCfg(arg_2_1.grid_id).name
		elseif arg_2_1.tp == 2 then
			-- block empty
		elseif arg_2_1.tp == 3 then
			-- block empty
		elseif arg_2_1.tp == 4 then
			var_2_4 = g.core.config.team_battle_map_info.get(arg_2_1.value, g.core.model.User.teamBattleData:getActivityId()).name
		elseif arg_2_1.tp == 5 then
			var_2_3 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.value).name
		end

		local var_2_7 = var_0_1.get(arg_2_1.tp)

		if var_2_7 then
			self.m_descTxt:setText((g.core.lang:getByString(var_2_7.text, {
				name = var_2_0.name,
				reward = var_2_1,
				num = var_2_4,
				name2 = var_2_3
			})))

			local var_2_8 = g.core.common.ServerTime:getDateObject(arg_2_1.time)

			self.m_dateTxt:setText(g.core.lang:get(1057, {
				month = var_2_8.month,
				day = var_2_8.day
			}))
			self.m_timeTxt:setText(g.core.lang:get(420672, {
				hour = var_2_8.hour,
				minute = var_2_8.min
			}))
		end
	end
end

return TeamBattleLogCell
