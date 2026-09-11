return {
	[1001] = {
		clue_num = 3,
		name = "订单记录",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "餐品订单生成，发送至<color=#E78300>餐车</color>。",
		stage_type = 1,
		pre_stage = 0,
		desc = "花坛区18号桌上的餐饮服务终端内有一条已完成的订单记录，点餐内容为「海洋之星联名小食拼盘×1」，附赠第二份半价的绑定优惠券。",
		ori_pos = "",
		stageID = 1001,
		answer = "",
		conclusion = ""
	},
	[1002] = {
		clue_num = 4,
		name = "遗落的优惠券",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "<color=#E78300>配送员</color>完成订单，准备回到所属餐车。要找到配送员需要先知道所属<color=#E78300>餐车</color>的店名。",
		stage_type = 1,
		pre_stage = 1001,
		desc = "花坛里发现的海洋之星联名小食的半价优惠券，似乎还未绑定用户的样子。应该是派送员遗落在这里的。",
		ori_pos = "",
		stageID = 1002,
		answer = "",
		conclusion = ""
	},
	[1003] = {
		clue_num = 5,
		name = "园区地图",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "园区地图可以根据店名查找<color=#E78300>门店的具体位置</color>，由此可以确认配送员所属餐车的方位。",
		stage_type = 1,
		pre_stage = 1002,
		desc = "园区服务终端内的海洋之星游乐园园区地图，输入品牌名可以查询该品牌下属餐车所在位置。",
		ori_pos = "",
		stageID = 1003,
		answer = "",
		conclusion = ""
	},
	[1004] = {
		clue_num = 5,
		name = "告示牌",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "<color=#E78300>餐车</color>内对应订单餐品<color=#E78300>已告罄</color>，需要申请<color=#E78300>调配</color>。",
		stage_type = 1,
		pre_stage = 1003,
		desc = "餐车前的告示牌，最醒目的位置显示着「本餐车点海洋之星联名小食今日已告罄，如有需要的话将后台调配其他餐车进行餐点派送，时间较长请耐心等待」。",
		ori_pos = "",
		stageID = 1004,
		answer = "",
		conclusion = ""
	},
	[1005] = {
		clue_num = 5,
		name = "内部调配记录",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "<color=#E78300>调配</color>申请已生成，分配至负责的<color=#E78300>配送员</color>。",
		stage_type = 1,
		pre_stage = 1004,
		desc = "餐车服务后台内的调配记录，显示3号餐车向2号餐车发送了订餐调配申请，调配状态为已完成。",
		ori_pos = "",
		stageID = 1005,
		answer = "",
		conclusion = ""
	},
	[1006] = {
		clue_num = 6,
		name = "宣传海报",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "根据海报内容可以知道<color=#E78300>具体店名</color>，还需要查询<color=#E78300>该店的具体位置</color>。",
		stage_type = 1,
		pre_stage = 1005,
		desc = "贴在餐车上的品牌宣传海报，最醒目的地方写着品牌广告语「金色海岸、夏日伙伴！」。",
		ori_pos = "",
		stageID = 1006,
		answer = "",
		conclusion = ""
	},
	[1007] = {
		clue_num = 0,
		name = "",
		conclusion_desc = "",
		stage_type = 2,
		pre_stage = 0,
		desc = "",
		stageID = 1007,
		ori_pos = {
			1001,
			1002,
			1003,
			1004,
			1005,
			1006
		},
		answer = {
			1001,
			1004,
			1005,
			1002,
			1006,
			1003
		},
		fixed_pos = {
			1001,
			0,
			0,
			0,
			0,
			0
		},
		conclusion = {
			470001,
			470002,
			470003,
			470004
		},
		conclusion_list = {
			{
				1001,
				1004,
				1005
			},
			{
				1002
			},
			{
				1003,
				1006
			}
		}
	},
	[2001] = {
		clue_num = 5,
		name = "订单状态",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "<color=#E78300>完成订单</color>的阿波罗回到餐车又接取了<color=#E78300>其他配送订单</color>。",
		stage_type = 1,
		pre_stage = 0,
		desc = "餐车服务后台显示该餐车所有的运输单都在进行中。部分人工运输单的负责人为「配送员A」。",
		ori_pos = "",
		stageID = 2001,
		answer = "",
		conclusion = ""
	},
	[2002] = {
		clue_num = 6,
		name = "保温箱",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "接取到<color=#E78300>其他配送订单</color>的阿波罗现在正在园区内进行配送。由于订单较多，无法确认他的位置。",
		stage_type = 1,
		pre_stage = 2001,
		desc = "餐车旁的架子上放着3个保温箱，看剩余空间似乎还能再容纳一个，看来有人接单后出去工作了。",
		ori_pos = "",
		stageID = 2002,
		answer = "",
		conclusion = ""
	},
	[2003] = {
		clue_num = 6,
		name = "运力状态",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "<color=#E78300>摆脱铃兰团抓捕</color>的阿波罗在中午开始担任餐车的小食配送员，完成了<color=#E78300>订单配送</color>。",
		stage_type = 1,
		pre_stage = 2002,
		desc = "餐车的运力公示栏显示，刚刚完成18号餐桌订单的「配送员A」注册时间在今天中午。",
		ori_pos = "",
		stageID = 2003,
		answer = "",
		conclusion = ""
	},
	[2004] = {
		clue_num = 6,
		name = "园区广播",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "在游乐园向游客<color=#E78300>开放前</color>，阿波罗参与了游乐园主题背景乐的录制。",
		stage_type = 1,
		pre_stage = 2003,
		desc = "园区内持续播放着的音乐节主题背景乐，应当是游乐园开放之前就录制好的内容。仔细辨别的话，有一段乐段很像阿波罗的演奏习惯。",
		ori_pos = "",
		stageID = 2004,
		answer = "",
		conclusion = ""
	},
	[2005] = {
		clue_num = 7,
		name = "顾客的交谈",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "<color=#E78300>今日清晨</color>开园时，阿波罗帮忙维持了入园秩序。",
		stage_type = 1,
		pre_stage = 2004,
		desc = "餐桌上的两位顾客正在聊天，大致内容是入园时遇到的黄发员工很快安抚了哭闹的小孩，使入园队伍重新畅通。",
		ori_pos = "",
		stageID = 2005,
		answer = "",
		conclusion = ""
	},
	[2006] = {
		clue_num = 7,
		name = "服务智械",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "<color=#E78300>上午</color>，铃兰团骑士在游乐园内偶遇了阿波罗，但看起来阿波罗<color=#E78300>逃走了</color>。",
		stage_type = 1,
		pre_stage = 2005,
		desc = "在智械的投诉记录中有一条新增内容，大致是今早遇到了一群女骑士追赶一位游乐园员工，两人买到的联名小食套餐被撞到了地上，希望园方能够加强园区管理。",
		ori_pos = "",
		stageID = 2006,
		answer = "",
		conclusion = ""
	},
	[2007] = {
		clue_num = 0,
		name = "",
		conclusion_desc = "",
		stage_type = 2,
		pre_stage = 0,
		desc = "",
		stageID = 2007,
		ori_pos = {
			2001,
			2002,
			2003,
			2004,
			2005,
			2006
		},
		answer = {
			2004,
			2005,
			2006,
			2003,
			2001,
			2002
		},
		fixed_pos = {
			2004,
			0,
			0,
			0,
			0,
			0
		},
		conclusion = {
			470005,
			470006,
			470007,
			470008
		},
		conclusion_list = {
			{
				2004
			},
			{
				2005,
				2006,
				2003
			},
			{
				2001,
				2002
			}
		}
	},
	[3001] = {
		clue_num = 3,
		name = "特殊颜料",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "",
		stage_type = 3,
		pre_stage = 0,
		desc = "将箱子里的颜料填入水枪后，被击中的参赛选手将被淘汰。",
		ori_pos = "",
		stageID = 3001,
		answer = "",
		conclusion = ""
	},
	[3002] = {
		clue_num = 3,
		name = "最终大奖",
		fixed_pos = "",
		conclusion_list = "",
		conclusion_desc = "",
		stage_type = 3,
		pre_stage = 0,
		desc = "三件珍宝恰到好处地拼合了起来，但怎么看也只是把它们粗暴地揉在了一起吧。",
		ori_pos = "",
		stageID = 3002,
		answer = "",
		conclusion = ""
	},
	all = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1006,
		1007,
		2001,
		2002,
		2003,
		2004,
		2005,
		2006,
		2007,
		3001,
		3002
	}
}
