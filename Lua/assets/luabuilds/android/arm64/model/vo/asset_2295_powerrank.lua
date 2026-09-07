local PowerRank = class("PowerRank", import(".PlayerAttire"))

PowerRank.TYPE_POWER = 1
PowerRank.TYPE_COLLECTION = 2
PowerRank.TYPE_PT = 3
PowerRank.TYPE_PLEDGE = 4
PowerRank.TYPE_CHALLENGE = 5
PowerRank.TYPE_EXTRA_CHAPTER = 6
PowerRank.TYPE_ACT_BOSS_BATTLE = 7
PowerRank.TYPE_GUILD_BATTLE = 8
PowerRank.TYPE_MILITARY_RANK = 9
PowerRank.TYPE_BOSSRUSH = 10
PowerRank.TYPE_ISLAND_SEASON_PT = 11
PowerRank.TYPE_TB_ENDLESS_WAVE = 12
PowerRank.TYPE_TB_ATTR_SUM = 13
PowerRank.typeInfo = {
	{
		title_word = {
			5,
			8,
			7,
			1
		},
		score_icon = {
			"ui/billboardui_atlas",
			"power_icon"
		}
	},
	{
		title_word = {
			5,
			8,
			7,
			2
		}
	},
	{
		title_word = {
			5,
			8,
			7,
			2
		},
		score_icon = {
			"ui/commonui_atlas",
			"pt_icon"
		},
		act_type = ActivityConst.ACTIVITY_TYPE_PT_RANK
	},
	{
		title_word = {
			5,
			8,
			7,
			3
		}
	},
	{
		title_word = {
			5,
			8,
			7,
			4
		},
		act_type = ActivityConst.ACTIVITY_TYPE_CHALLENGE_RANK
	},
	{
		title_word = {
			5,
			8,
			7,
			4
		},
		act_type = ActivityConst.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK
	},
	{
		title_word = {
			5,
			8,
			7,
			10
		},
		act_type = ActivityConst.ACTIVITY_TYPE_BOSS_RANK
	},
	[9] = {
		title_word = {
			5,
			8,
			6,
			9
		},
		score_icon = {
			"ui/billboardui_atlas",
			"rank_icon"
		}
	},
	[10] = {
		title_word = {
			5,
			8,
			7,
			4
		},
		act_type = ActivityConst.ACTIVITY_TYPE_EXTRA_BOSSRUSH_RANK
	}
}

function PowerRank:Ctor(arg_1_1, arg_1_2)
	PowerRank.super.Ctor(self, arg_1_1)

	self.id = arg_1_1.user_id or arg_1_1.id
	self.lv = arg_1_1.lv or arg_1_1.level
	self.name = arg_1_1.name
	self.power = arg_1_1.point or arg_1_1.score or 0
	self.rank = arg_1_1.rank or 0
	self.arenaRank = math.min(math.max(arg_1_1.arena_rank or 0, 1), 14)

	assert(arg_1_2, "type can not be nil")

	self.type = arg_1_2

	return
end

function PowerRank:getPainting()
	return (pg.ship_skin_template[self.skinId] or nil) and (pg.ship_skin_template[self.skinId].painting or "unknown")
end

function PowerRank:setRank(arg_3_1)
	self.rank = arg_3_1

	return
end

function PowerRank:setArenaRank(arg_4_1)
	self.arenaRank = arg_4_1

	return
end

function PowerRank:getPowerTxt()
	if self.type == PowerRank.TYPE_POWER then
		return math.floor(self.power^0.667)
	elseif self.type == PowerRank.TYPE_COLLECTION then
		return string.format("%0.01f", self.power / getProxy(CollectionProxy):getCollectionTotal() * 100) .. "%"
	elseif self.type == PowerRank.TYPE_MILITARY_RANK then
		return self.power + SeasonInfo.INIT_POINT
	else
		return self.power
	end

	return
end

function PowerRank:getTitleWord(arg_6_1, arg_6_2)
	local var_6_0 = {}

	for iter_6_0 = 1, 4 do
		table.insert(var_6_0, i18n("ranking_word_" .. PowerRank.typeInfo[arg_6_1].title_word[iter_6_0]))
	end

	if arg_6_1 == PowerRank.TYPE_PT then
		var_6_0[4] = Item.getConfigData((id2ItemId(getProxy(ActivityProxy):getActivityById(arg_6_2):getConfig("config_id")))).name
	end

	return var_6_0
end

function PowerRank:getScoreIcon(arg_7_1)
	return PowerRank.typeInfo[arg_7_1].score_icon
end

function PowerRank:getActivityByRankType(arg_8_1)
	if not PowerRank.typeInfo[arg_8_1].act_type then
		return nil
	end

	return _.detect(getProxy(ActivityProxy):getActivitiesByType(PowerRank.typeInfo[arg_8_1].act_type), function(arg_9_0)
		return not arg_9_0:isEnd() and (arg_8_1 ~= PowerRank.TYPE_PT or tonumber(arg_9_0:getConfig("config_data")) > 0)
	end)
end

return PowerRank
