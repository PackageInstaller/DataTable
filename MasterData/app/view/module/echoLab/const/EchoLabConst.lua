return {
	ENTRANCE_NUM = 3,
	ECHOLAB_SLOT_COUNT = 6,
	HANG_UP_COUNT = 2,
	TERMINAL = 3,
	COLLECT = 1,
	DATATREE = 2,
	EchoLabNameArray = {
		{
			attrId = 911,
			cardType = 4,
			name = g.core.lang:get(408507),
			defaultAttr = g.core.lang:get(408903)
		},
		{
			attrId = 910,
			cardType = 14,
			name = g.core.lang:get(408508),
			defaultAttr = g.core.lang:get(408514)
		},
		{
			attrId = 910,
			cardType = 17,
			name = g.core.lang:get(408509),
			defaultAttr = g.core.lang:get(408514)
		},
		{
			attrId = 911,
			cardType = 5,
			name = g.core.lang:get(408510),
			defaultAttr = g.core.lang:get(408903)
		},
		{
			attrId = 910,
			cardType = 13,
			name = g.core.lang:get(408511),
			defaultAttr = g.core.lang:get(408514)
		}
	},
	EMBRYO_SLOT_FIELDS = {
		{
			name = "knight",
			scale = 0.6,
			desc = g.core.lang:get(408513, {
				name = g.core.lang:get(408507)
			})
		},
		{
			name = "artifact",
			scale = 1,
			desc = g.core.lang:get(408513, {
				name = g.core.lang:get(408508)
			})
		},
		{
			name = "pet",
			scale = 0.7,
			desc = g.core.lang:get(408513, {
				name = g.core.lang:get(408509)
			})
		},
		{
			name = "unite",
			scale = 0.5,
			desc = g.core.lang:get(408513, {
				name = g.core.lang:get(408510)
			})
		},
		{
			name = "skin",
			scale = 0.6,
			desc = g.core.lang:get(408513, {
				name = g.core.lang:get(408511)
			})
		}
	},
	CARD_TYPE = {
		KNIGHT = 4,
		UNITE = 5,
		PET = 17,
		SKIN = 13,
		ARTIFACT = 14
	},
	COLLECT_BUILDING_TYPE = {
		ANALYSIS_TERMINAL = 2,
		COLLECT_CENTER = 1
	},
	COLLECT_DAILY_MAX_ACTIVE_COUNT_IDS = {
		[g.core.common.Goods.TYPE_KNIGHT] = 20207,
		[g.core.common.Goods.TYPE_UNITETOKEN] = 20208,
		[g.core.common.Goods.TYPE_SKIN] = 20209,
		[g.core.common.Goods.TYPE_ARTIFACT] = 20210,
		[g.core.common.Goods.TYPE_PET] = 20211
	},
	NODE_TYPE1 = {
		VALUE3 = 3,
		VALUE2 = 2,
		VALUE1 = 1
	},
	NODE_TYPE2 = {
		VALUE2 = 2,
		VALUE1 = 1
	}
}
