return {
	{
		word = "",
		face = "",
		action = "normal",
		cueName = "",
		id = 1,
		awbName = "",
		sheetName = ""
	},
	{
		action = "enter",
		id = 2,
		face = {
			"joy",
			"joy",
			"joy"
		},
		sheetName = {
			"activity_v_2_0",
			"activity_v_2_0",
			"activity_v_2_0"
		},
		cueName = {
			"activity_v_2_0_enter1",
			"activity_v_2_0_enter2",
			"activity_v_2_0_enter3"
		},
		awbName = {
			"activity_v_2_0.awb",
			"activity_v_2_0.awb",
			"activity_v_2_0.awb"
		},
		word = {
			"啊呀~这位风度翩翩的客人，第一眼见面，就觉得和你十分投缘~入场券先给你打个9折吧，来，坐这，咱给你倒一盏虚恒大麦茶。",
			"哎呀呀，贵客的光临真是让这儿蓬荜生辉啊！不过，入场前，烦请先交下费用，价格？小问题，立马给你办一个会员！",
			"欢迎光临！外面凉，快请进快请进！"
		}
	},
	{
		action = "seal",
		id = 3,
		face = {
			"normal",
			"normal",
			"normal"
		},
		sheetName = {
			"activity_v_2_0",
			"activity_v_2_0",
			"activity_v_2_0"
		},
		cueName = {
			"activity_v_2_0_fail1",
			"activity_v_2_0_fail2",
			"activity_v_2_0_fail3"
		},
		awbName = {
			"activity_v_2_0.awb",
			"activity_v_2_0.awb",
			"activity_v_2_0.awb"
		},
		word = {
			"嘿嘿，多试几次，这世上没有钱不能解决的问题。",
			"就差这么一小步，就能拿到大奖了……骗局？怎么会呢？咱们百解钤印向来以诚信著称，童叟无欺。",
			"哎！就差一点了，可惜啊，再来一次估计就成了……嗯？有没有转运绳卖？哈哈，真是好眼神！都是自己人，给你打个9.5折，拿去吧！"
		}
	},
	{
		action = "reward1",
		id = 4,
		face = {
			"joy",
			"surprise"
		},
		sheetName = {
			"activity_v_2_0",
			"activity_v_2_0"
		},
		cueName = {
			"activity_v_2_0_normal1",
			"activity_v_2_0_normal2"
		},
		awbName = {
			"activity_v_2_0.awb",
			"activity_v_2_0.awb"
		},
		word = {
			"恭喜恭喜，拿到奖品的感觉如何？很兴奋吧，后面还有更多大奖，敬请期待！",
			"你是天选之子吗？这么快就拿到了？"
		}
	},
	{
		action = "reward2",
		id = 5,
		face = {
			"surprise"
		},
		sheetName = {
			"activity_v_2_0"
		},
		cueName = {
			"activity_v_2_0_main1"
		},
		awbName = {
			"activity_v_2_0.awb"
		},
		word = {
			"前面可没多少顾客能拿到这个，你这么轻松就拿到了，嘶——心疼咱兜里的钱包。"
		}
	},
	{
		action = "click",
		id = 6,
		face = {
			"joy",
			"joy",
			"normal"
		},
		sheetName = {
			"activity_v_2_0",
			"activity_v_2_0",
			"activity_v_2_0"
		},
		cueName = {
			"activity_v_2_0_click1",
			"activity_v_2_0_click2",
			"activity_v_2_0_click3"
		},
		awbName = {
			"activity_v_2_0.awb",
			"activity_v_2_0.awb",
			"activity_v_2_0.awb"
		},
		word = {
			"谈钱伤感情，不谈钱更伤感情。",
			"堪比钱串子的存在？哈哈，当然是傍晚集市的烟火气。",
			"虚假营销？哎呀，误会大了~促销活动的重点是向顾客抛售仪式感，顾客不仅买到了商品，还买到了参与活动的快乐，怎么能说咱是在坑蒙拐骗呢？"
		}
	},
	get_id_list_by_action = {
		click = {
			6
		},
		reward2 = {
			5
		},
		reward1 = {
			4
		},
		seal = {
			3
		},
		enter = {
			2
		},
		normal = {
			1
		}
	},
	all = {
		1,
		2,
		3,
		4,
		5,
		6
	}
}
