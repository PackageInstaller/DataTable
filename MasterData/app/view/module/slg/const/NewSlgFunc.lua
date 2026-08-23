local var_0_0 = {}
local var_0_1 = g.core.const.ConstMgr.NewSlgConst

function var_0_0.getBlockCenterPos(arg_1_0, arg_1_1)
	local var_1_0 = math.floor(var_0_1.SERVER_BLOCK_NUM / 2)

	return cc.p(math.floor(arg_1_0 / var_0_1.SERVER_BLOCK_NUM) * var_0_1.SERVER_BLOCK_NUM + var_1_0, math.floor(arg_1_1 / var_0_1.SERVER_BLOCK_NUM) * var_0_1.SERVER_BLOCK_NUM + var_1_0)
end

function var_0_0:getArroundBlockRC(arg_2_1, arg_2_2)
	local var_2_0 = {}

	for iter_2_0 = self.x - arg_2_1 * arg_2_2, self.x + arg_2_1 * arg_2_2, arg_2_2 do
		for iter_2_1 = self.y - arg_2_1 * arg_2_2, self.y + arg_2_1 * arg_2_2, arg_2_2 do
			table.insert(var_2_0, cc.p(iter_2_0, iter_2_1))
		end
	end

	return var_2_0
end

function var_0_0.getMarchDurationByPath(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0 or #arg_3_0 <= 1 then
		return 0
	end

	return var_0_0.getMarchDurationByPathLen(#arg_3_0 - 1, arg_3_1, arg_3_2)
end

function var_0_0.getMarchDurationByPathLen(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = g.core.model.User.newSlgData:getNewSlgParamsCfg()
	local var_4_1 = var_4_0.parameter_4
	local var_4_2 = var_4_0.parameter_5
	local var_4_3 = var_4_0.parameter_6

	if arg_4_2 == var_0_1.MONSTER_TYPE.BOSS then
		var_4_1 = g.core.model.User.newSlgData:getNewSlgParamsValueById(165)
		var_4_2 = g.core.model.User.newSlgData:getNewSlgParamsValueById(166)
		var_4_3 = g.core.model.User.newSlgData:getNewSlgParamsValueById(167)
	end

	local var_4_4 = arg_4_1 or 0

	return arg_4_0 <= var_4_1 and math.floor(arg_4_0 * var_4_2 * (1000 - var_4_4) / 1000) or math.floor((var_4_1 * var_4_2 + (arg_4_0 - var_4_1) * var_4_3) * (1000 - var_4_4) / 1000)
end

function var_0_0.getMarchLengthByDuration(arg_5_0)
	local var_5_0 = g.core.model.User.newSlgData:getNewSlgParamsCfg()

	if arg_5_0 <= var_5_0.parameter_4 * var_5_0.parameter_5 then
		return math.floor(arg_5_0 / var_5_0.parameter_5)
	else
		return var_5_0.parameter_4 + math.floor((arg_5_0 - var_5_0.parameter_4 * var_5_0.parameter_5) / var_5_0.parameter_6)
	end
end

function var_0_0:vectorToAngle()
	local var_6_0 = math.atan2(self.y, self.x) * (180 / math.pi)

	if var_6_0 < 0 then
		var_6_0 = var_6_0 + 360
	end

	return var_6_0
end

function var_0_0.addSchedule(arg_7_0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_SCHEDULE_PARAM, false, arg_7_0)
end

function var_0_0.removeSchedule(arg_8_0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REMOVE_SCHEDULE_PARAM, false, arg_8_0)
end

function var_0_0.openTeamBossAssistPop(arg_9_0)
	local var_9_0, var_9_1 = g.core.model.User.newSlgData:getBossChallengeAssistTime()

	g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
		title = g.core.lang:get(428909),
		desc = g.core.lang:get(428910) .. "\n" .. g.core.lang:get(428911, {
			num1 = var_9_0,
			num2 = var_9_1
		}),
		onConfirm = function()
			if arg_9_0.callback then
				arg_9_0.callback(arg_9_0.data)
			end
		end
	})
end

function var_0_0.openBossTeamDetailPop(arg_11_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BOSS_TEAM_DETAIL_POP, arg_11_0)
end

function var_0_0:openTeamPlayerInfo()
	if self.id == g.core.model.User:getId() then
		g.core.module.ModuleManager:tip(g.core.lang:get(429011))
	elseif self.is_robot then
		g.core.module.ModuleManager:tip(g.core.lang:get(428979))
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_PLAYER_INFO, {
			uid = self.id
		})
	end
end

function var_0_0:clickBossInvite()
	if not g.core.model.User.newSlgData:isPlaying() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428800))
		g.core.module.ModuleManager:popComponent()

		return true
	end

	if g.core.common.ServerTime:getTime() > self.createTime + g.core.model.User.newSlgData:getBossTeamGatherTotalTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428930))

		return false
	end

	if g.core.module.ModuleManager:isCurModule(g.view.entrance.NEW_SLG_MAIN) then
		g.core.module.ModuleManager:popComponent()
		g.core.event.EventManager:dispatchEvent(g.core.const.ConstMgr.NewSlgConst.GOTO_BOSS_INVITE_POS, false, self)
	else
		g.core.module.ModuleManager:popComponent()
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_MAIN, {
			bossInviteInfo = self
		})
	end
end

function var_0_0.dealDevelopRoute1(arg_14_0)
	if not arg_14_0 then
		return
	end

	local var_14_0
	local var_14_1

	if arg_14_0 == 1 then
		var_14_0 = g.view.entrance.NEW_SLG_MAIN_CITY_LAYER
	elseif arg_14_0 == 2 then
		var_14_0 = g.view.entrance.NEW_SLG_SUPPLY_POP
	elseif arg_14_0 == 3 then
		var_14_0 = g.view.entrance.NEW_SLG_BARRACK_POP
		var_14_1 = {
			type = var_0_1.ARMY_TYPE.QI
		}
	elseif arg_14_0 == 4 then
		var_14_0 = g.view.entrance.NEW_SLG_BARRACK_POP
		var_14_1 = {
			type = var_0_1.ARMY_TYPE.DUN
		}
	elseif arg_14_0 == 5 then
		var_14_0 = g.view.entrance.NEW_SLG_BARRACK_POP
		var_14_1 = {
			type = var_0_1.ARMY_TYPE.GONG
		}
	end

	if var_14_0 then
		g.core.module.ModuleManager:pushModule(var_14_0, var_14_1)
	end
end

function var_0_0:getIconPathByChapterOrStruct(arg_15_1, arg_15_2)
	if self then
		if self.base_id and self.base_id ~= 0 then
			local var_15_0 = g.core.common.Goods.CFG[self.tp].get(self.base_id)

			if self.tp == g.core.common.Goods.TYPE_KNIGHT then
				return g.core.common.Path:getRoleHeadIcon(var_15_0.res_id), var_15_0
			else
				return ""
			end
		elseif self.id and self.id ~= 0 then
			local var_15_1 = g.core.common.GlobalFunc.getStructByTypeAndSerId(self.tp, self.id)

			if var_15_1 and var_15_1:isOwn() then
				local var_15_2 = var_15_1:getCfg()

				arg_15_2 = self.tp

				if self.tp == g.core.common.Goods.TYPE_KNIGHT then
					return g.core.common.Path:getRoleHeadIcon(var_15_2.res_id), var_15_2
				end
			end
		else
			return ""
		end
	elseif arg_15_1 and arg_15_1 and arg_15_1:isOwn() then
		local var_15_3 = arg_15_1:getCfg()

		if arg_15_2 == g.core.common.Goods.TYPE_KNIGHT then
			return g.core.common.Path:getRoleHeadIcon(var_15_3.res_id), var_15_3
		end
	end

	return ""
end

return var_0_0
