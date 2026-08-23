local var_0_0 = {}
local var_0_1 = g.core.model.User.snapShotCacheData
local var_0_2 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER

function var_0_0.sendSimpleUserSnapshot(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		if not var_0_1:getSnapShot(var_0_2, iter_1_1) then
			table.insert(var_1_0, iter_1_1)
		end
	end

	return #var_1_0 <= 0
end

function var_0_0.getSnapshot(arg_2_0)
	return var_0_1:getSnapShot(var_0_2, arg_2_0)
end

function var_0_0.openAncientsMainLayer(arg_3_0)
	if not g.core.model.User.ancientsData:isTimeToOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(433302))

		return
	end

	local var_3_0 = var_0_0.getNeedOpenModule()

	if arg_3_0 then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end

	g.core.module.ModuleManager:pushModule(var_3_0)
end

function var_0_0.getNeedOpenModule()
	return g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.REVIEW and g.view.entrance.ANCIENTS_REVIEW_LAYER or g.core.model.User.ancientsData:isFinalState() and g.view.entrance.ANCIENTS_AGAINST_LAYER or g.core.model.User.ancientsData:getTeamId() == 0 and g.view.entrance.ANCIENTS_COOP_MAIN_LAYER or g.view.entrance.ANCIENTS_MAIN_LAYER
end

function var_0_0.initDebugData()
	local var_5_0 = g.core.const.ConstMgr.AncientsConst

	function g.core.model.User.ancientsData.getAncientsState(arg_6_0)
		return var_5_0.ANCIENT_STATUS.FIGHT
	end

	function g.core.model.User.ancientsData.isFinalState(arg_7_0)
		return false
	end

	local var_5_2 = g.core.model.User:getId()
	local var_5_3 = {
		{
			score = 2400,
			name = "Me",
			team_contribution = 100,
			pos = 1,
			user_id = var_5_2
		},
		{
			score = 2200,
			name = "P2",
			team_contribution = 80,
			user_id = 100002,
			pos = 2
		},
		{
			score = 2600,
			name = "P3",
			team_contribution = 120,
			user_id = 100003,
			pos = 3
		},
		{
			score = 2400,
			name = "P4",
			team_contribution = 90,
			user_id = 100004,
			pos = 4
		}
	}

	g.core.model.User.ancientsData:onRecvEnter({
		active_value = 30,
		score = 2400,
		country = 1,
		loot_exp = 500,
		score_stage_rank = 1,
		has_invitation = false,
		team = {
			score = 9600,
			name = "DebugTeam",
			operate_state = 0,
			pet_fight_value = 50000,
			daily_pet_change_times = 0,
			team_id = 10001,
			join_user_cd_time = 0,
			captain = var_5_2,
			pet = {
				exp = 200,
				level = 5,
				base_id = 1011,
				skills = {}
			},
			users = var_5_3
		},
		tasks = {},
		team_tasks = {},
		active_awarded_ids = {},
		round_teams = {},
		final_teams = {}
	})

	local var_5_4 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_3) do
		table.insert(var_5_4, {
			frame_id = 0,
			vip_level = 1,
			fight_value = 1000000,
			avata_id = 0,
			is_robot = true,
			robot_type = 0,
			title_id = 0,
			base_id = 210000,
			level = 100,
			id = iter_5_1.user_id,
			name = iter_5_1.name
		})
	end

	var_0_1:updateSnapShotCache(var_0_2, var_5_4)
end

return var_0_0
