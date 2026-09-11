return {
	Normal = {
		value = 0,
		name = "Normal",
		annotation = ""
	},
	Charge = {
		value = 1,
		name = "Charge",
		annotation = "持续蓄力"
	},
	Transfiguration = {
		value = 2,
		name = "Transfiguration",
		annotation = "形态切换"
	},
	Persist = {
		value = 3,
		name = "Persist",
		annotation = "持续释放"
	},
	Strengthen = {
		value = 4,
		name = "Strengthen",
		annotation = "强化技能"
	},
	Switch = {
		value = 5,
		name = "Switch",
		annotation = "分支选择"
	},
	Prepare = {
		value = 6,
		name = "Prepare",
		annotation = "前置准备"
	},
	get_id_list_by_value = {
		[6] = {
			"Prepare"
		},
		[5] = {
			"Switch"
		},
		[4] = {
			"Strengthen"
		},
		[3] = {
			"Persist"
		},
		[2] = {
			"Transfiguration"
		},
		{
			"Charge"
		},
		[0] = {
			"Normal"
		}
	}
}
