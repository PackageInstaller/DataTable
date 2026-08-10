BattleTeamPlayerTemplate = class("BattleTeamHeroTemplate")

function BattleTeamPlayerTemplate.Ctor(arg_1_0, arg_1_1)
	arg_1_0.playerID = arg_1_1.player_id

	local var_1_0 = arg_1_1.player_battle_info

	arg_1_0.nick = var_1_0.nick
	arg_1_0.level = var_1_0.level
	arg_1_0.channel = var_1_0.channel
	arg_1_0.server = var_1_0.server
	arg_1_0.heroList = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.hero_list) do
		local var_1_1

		if iter_1_1.hero_type == 2 then
			var_1_1 = CooperationHeroDataTemplate.New(HeroStandardSystemCfg[iter_1_1.hero_base_info.id].hero_id)
		else
			var_1_1 = CooperationHeroDataTemplate.New(iter_1_1.hero_base_info.id)
		end

		var_1_1:Init(iter_1_1)
		table.insert(arg_1_0.heroList, var_1_1)
	end

	local var_1_2 = arg_1_1.player_room_info

	arg_1_0:UpdateRoomData(var_1_2)
end

function BattleTeamPlayerTemplate.UpdateRoomData(arg_2_0, arg_2_1)
	arg_2_0.is_ready = arg_2_1.is_ready
	arg_2_0.is_master = arg_2_1.is_master
	arg_2_0.be_liked_uids = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.be_liked_uids) do
		table.insert(arg_2_0.be_liked_uids, iter_2_1)
	end
end
