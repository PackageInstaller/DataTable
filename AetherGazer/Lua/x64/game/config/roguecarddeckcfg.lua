return {
	{
		name = "无咎的牌组",
		score_rate = 120,
		deck = 1,
		id = 1,
		pic = "rogue_card_back_1",
		condition = 0,
		desc = "本牌组包含4种角色牌，每种角色牌有 2~A点数牌各1张\n弃牌次数+1",
		effect_list = {
			501
		}
	},
	{
		effect_list = "",
		name = "必安的牌组",
		score_rate = 100,
		deck = 2,
		id = 2,
		pic = "rogue_card_back_2",
		condition = 1270101,
		desc = "本牌组仅包含无咎牌与奥西里斯牌，每种行动牌有 2~A点数牌各2张"
	},
	{
		name = "薇儿丹蒂的牌组",
		score_rate = 150,
		deck = 1,
		id = 3,
		pic = "rogue_card_back_3",
		condition = 1270201,
		desc = "本牌组包含4种角色牌，每种角色牌有 2~A点数牌各1张\n可携带物件数+1，但弃牌次数-1",
		effect_list = {
			503,
			550
		}
	},
	{
		effect_list = "",
		name = "奥西里斯的牌组",
		score_rate = 150,
		deck = 3,
		id = 4,
		pic = "rogue_card_back_4",
		condition = 1270202,
		desc = "本牌组的所有牌的点数和花色随机"
	},
	all = {
		1,
		2,
		3,
		4
	}
}
