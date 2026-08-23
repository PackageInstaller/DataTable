local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.const.ConstMgr.RecruitConst
local var_0_2 = g.core.model.User.recruitData

return {
	on_S2C_NewRecruit_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_2:processRecruitInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Recruit_Info = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_2:processRecruitInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_NewRecruit_Recruit = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.recruitData:updateGuaranteedInfos(arg_3_2.minimum)
			g.core.model.User.recruitData:updateDrawInfo(arg_3_2.recruit, true)

			local var_3_0 = arg_3_2.recruit_type

			if arg_3_2.recruit_type < 100000 then
				local function var_3_1(arg_4_0)
					if arg_4_0:getActivityType() == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.LIMIT_RECRUIT then
						return arg_4_0:getActivityId() == var_3_0
					end
				end

				local var_3_2 = g.core.model.User.activityDataManager:getActivityDataListByFilter(var_3_1)

				for iter_3_0, iter_3_1 in ipairs((var_0_2:getAllCrossData())) do
					if var_3_1(iter_3_1) then
						table.insert(var_3_2, iter_3_1)
					end
				end

				if not var_3_2[1] then
					return
				end

				var_3_0 = var_3_2[1]:getInfo().sub_activity_id
			end

			local var_3_3 = var_0_2:getRecruitTypeById(var_3_0)

			if var_3_3 == 1 then
				-- block empty
			elseif var_3_3 == 2 then
				if arg_3_2.consume_type == 0 then
					var_0_2:setAdvanceFreeTime((g.core.common.ServerTime:getTime()))
				end
			elseif var_3_3 == var_0_1.RECRUIT_TYPE.DAILY_RECRUIT then
				var_0_2:setDailyTotalCount(arg_3_2)
			end

			if var_3_3 == 6 or var_3_3 == 7 or var_3_3 == 8 then
				var_0_2:addAllUniteTokenTimes(arg_3_2.num)
			end

			if arg_3_2.recruit then
				var_0_2:updateWishInfos(arg_3_2.recruit.wish_ids, var_3_3, (var_3_3 == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT or nil) and var_0_2:getDrawInfo(arg_3_2.recruit.id):getNetId())
			end

			local var_3_5 = clone(arg_3_2)

			var_3_5.recruitTypeNet = var_3_5.recruit_type
			var_3_5.recruit_type = var_3_3

			g.core.model.User.UserTitleData:checkRecruitPopComment(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, false, arg_3_1, var_3_5)
		end
	end,
	on_S2C_NewRecruit_NoviceTenRecruit = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			dump(arg_5_2, "=========> on_S2C_NewRecruit_NoviceTenRecruit")
			var_0_2:updateOnePrimaryReward(arg_5_2.awards, arg_5_2.pos)

			local var_5_0 = clone(arg_5_2)

			var_5_0.recruit_type = g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.PRIMARY
			var_5_0.num = 10

			for iter_5_0, iter_5_1 in ipairs(var_5_0.awards) do
				iter_5_1.hideFrag = true
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_NOVICETENRECRUIT, false, arg_5_1, var_5_0)
		end
	end,
	on_S2C_NewRecruit_NoviceTenAward = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_2:enterNextPrimaryRound()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_NOVICETENAWARD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Recruit_GetRecruitKnightInfo = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.goldRecruitData:updateRecruitData(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECRUIT_GETRECRUITKNIGHTINFO, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Recruit_RecruitKnight = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.goldRecruitData:updateByRecruit(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUITKNIGHT, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Recruit_GetRecruitKnightAward = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.goldRecruitData:updateAchieveData(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECRUIT_GETRECRUITKNIGHTAWARD, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Recruit_NotifyRank = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.goldRecruitData:updateRankDataByNotify(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECRUIT_NOTIFYRANK, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Recruit_GetRecruitAuKnightInfo = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.spaceTimeRecruitData:resRecruitAuKnightInfo(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECRUIT_GETRECRUITAUKNIGHTINFO, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Recruit_RecruitAuKnight = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.spaceTimeRecruitData:resRecruitAuKnight(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUITAUKNIGHT, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_Recruit_GetRecruitAuKnightAward = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.model.User.spaceTimeRecruitData:resRecruitAuKnightAward(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECRUIT_GETRECRUITAUKNIGHTAWARD, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_NewRecruit_Luck = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			for iter_14_0, iter_14_1 in ipairs(arg_14_2.wish) do
				local var_14_0 = var_0_2:getRecruitCfgByIdOrActId(arg_14_2.id, true).type
				local var_14_2 = {
					type = var_14_0,
					pos = iter_14_1.pos,
					r_type = iter_14_1.r_type,
					r_value = iter_14_1.r_value
				}

				var_0_2:updateOneWishInfo(var_14_2, var_14_2.type, var_14_2.pos, (var_14_0 == var_0_1.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT or var_14_0 == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT or var_14_0 == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT or var_14_0 == var_0_1.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT or var_14_0 == var_0_1.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT or var_14_0 == var_0_1.RECRUIT_TYPE.RECRUIT_SUCCUBA or var_14_0 == var_0_1.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING or nil) and arg_14_2.id)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_NewRecruit_ProgressAward = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			var_0_2:updateProAward(arg_15_2.recruit_id, arg_15_2.award_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_PROGRESSAWARD, false, arg_15_1, arg_15_2)
		end
	end
}
