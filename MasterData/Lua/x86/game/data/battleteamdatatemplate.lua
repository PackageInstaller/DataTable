BattleTeamPlayerTemplate = class("BattleTeamHeroTemplate")

function BattleTeamPlayerTemplate:Ctor(arg_1_1)
	self.playerID = arg_1_1.player_id
	self.nick = arg_1_1.player_battle_info.nick
	self.level = arg_1_1.player_battle_info.level
	self.channel = arg_1_1.player_battle_info.channel
	self.server = arg_1_1.player_battle_info.server
	self.heroList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.player_battle_info.hero_list) do
		local var_1_0 = iter_1_1.hero_type == 2 and CooperationHeroDataTemplate.New(HeroStandardSystemCfg[iter_1_1.hero_base_info.id].hero_id) or CooperationHeroDataTemplate.New(iter_1_1.hero_base_info.id)

		var_1_0:Init(iter_1_1)
		table.insert(self.heroList, var_1_0)
	end

	self:UpdateRoomData(arg_1_1.player_room_info)
end

function BattleTeamPlayerTemplate:UpdateRoomData(arg_2_1)
	self.is_ready = arg_2_1.is_ready
	self.is_master = arg_2_1.is_master
	self.be_liked_uids = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.be_liked_uids) do
		table.insert(self.be_liked_uids, iter_2_1)
	end
end
