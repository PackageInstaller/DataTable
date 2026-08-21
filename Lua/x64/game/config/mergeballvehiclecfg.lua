return {
	[50111] = {
		name = "黑白滚滚号",
		unlock_stage = 0,
		type = 1,
		desc = "最基础的机甲，没有特殊能力。",
		desc_lock = "",
		icon_small = "TextureConfig/Activity_WuLuo/BallHead/50111",
		id = 50111,
		icon = "TextureConfig/Activity_WuLuo/Ball/50111",
		passive_skill = 0,
		param = {
			100,
			2500,
			150,
			1
		}
	},
	[50112] = {
		name = "涡轮爬爬号",
		unlock_stage = 50101,
		type = 1,
		desc = "撞击敌人时20%概率生成1颗「克隆弹」，「克隆弹」继承机甲所有武装效果，但拥有较低初始速度。「克隆弹」不会再生成「克隆弹」。",
		desc_lock = "完成「系统校准 」后解锁",
		icon_small = "TextureConfig/Activity_WuLuo/BallHead/50112",
		id = 50112,
		icon = "TextureConfig/Activity_WuLuo/Ball/50112",
		passive_skill = 50150112,
		param = {
			100,
			2500,
			150,
			1
		}
	},
	[50113] = {
		name = "闪电喵喵号",
		unlock_stage = 50102,
		type = 1,
		desc = "造成的范围伤害增加50%。",
		desc_lock = "完成「清场效率」后解锁",
		icon_small = "TextureConfig/Activity_WuLuo/BallHead/50113",
		id = 50113,
		icon = "TextureConfig/Activity_WuLuo/Ball/50113",
		passive_skill = 50150113,
		param = {
			100,
			2500,
			150,
			1
		}
	},
	[50121] = {
		name = "备选方案",
		unlock_stage = 50101,
		type = 2,
		desc = "每次测试可以刷新3次武装选项。",
		desc_lock = "完成「系统校准 」后解锁",
		icon_small = "TextureConfig/Activity_WuLuo/BuffIcon/50121",
		id = 50121,
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/50121",
		passive_skill = 0,
		param = {}
	},
	[50122] = {
		name = "插件扩容",
		unlock_stage = 50102,
		type = 2,
		desc = "主动武装槽位+1。",
		desc_lock = "完成「清场效率」后解锁",
		icon_small = "TextureConfig/Activity_WuLuo/BuffIcon/50122",
		id = 50122,
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/50122",
		passive_skill = 0,
		param = {}
	},
	[50123] = {
		name = "极速启动",
		unlock_stage = 50103,
		type = 2,
		desc = "每次测试第1回合选择的武装直接升到2级。",
		desc_lock = "完成「功率输出」后解锁",
		icon_small = "TextureConfig/Activity_WuLuo/BuffIcon/50123",
		id = 50123,
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/50123",
		passive_skill = 0,
		param = {}
	},
	get_id_list_by_type = {
		[2] = {
			50121,
			50122,
			50123
		},
		{
			50111,
			50112,
			50113
		}
	},
	all = {
		50111,
		50112,
		50113,
		50121,
		50122,
		50123
	}
}
