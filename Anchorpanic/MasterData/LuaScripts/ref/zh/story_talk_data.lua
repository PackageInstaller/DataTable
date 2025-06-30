-- from 666 配置表.xlsx

local story_talk_data=

{
	[1]={ next_id=2, group_id=1, msg="早啊, 今天有什么活动?", talker="小米", show_up={{1101,1,0}}, exit={}, audio=""
},
	[2]={ next_id=3, group_id=1, msg="今天搞个发布会, 迷惑一下消费者.", talker="华为", show_up={{1102,1,0}}, exit={}, audio=""
},
	[3]={ next_id=4, group_id=1, msg="不如带上我去做嘉宾, 让我见识下世面.", talker="OPPO", show_up={{1401,1,0}}, exit={1101}, audio=""
},
	[4]={ next_id=0, group_id=1, msg="我也去看看热闹.", talker="小米", show_up={{1101,-1,1}}, exit={}, audio=""
},
	[5]={ next_id=6, group_id=2, msg="哗~~~呱呱呱~~", talker="观众们", show_up={}, exit={}, audio=""
},
	[6]={ next_id=7, group_id=2, msg="各位久等了, 有请牛BB华为, 特约嘉宾小米s", talker="主持人", show_up={{1501,1,1}}, exit={}, audio=""
},
	[7]={ next_id=8, group_id=2, msg="我们准备来吹牛B", talker="华为", show_up={{1102,1,0}}, exit={}, audio=""
},
	[8]={ next_id=9, group_id=2, msg="大家好, 请关注我们小米产品", talker="小米", show_up={{1101,1,1}}, exit={1501}, audio=""
},
	[9]={ next_id=0, group_id=2, msg="[流汗珠。。。]", talker="主持人", show_up={{1501,-1,0 }}, exit={}, audio=""
},
	[10]={ next_id=11, group_id=3, msg="这是我们最新发明的方砖, 它是由六面一样大小的正文体组成的.", talker="华为", show_up={{1102,1,1}}, exit={}, audio=""
},
	[11]={ next_id=12, group_id=3, msg="。。。", talker="方砖", show_up={{9999,-1,0}}, exit={}, audio=""
},
	[12]={ next_id=13, group_id=3, msg="[一面陶醉中]", talker="OPPO", show_up={{1401,1,0 }}, exit={9999}, audio=""
},
	[13]={ next_id=14, group_id=3, msg="我们散场吧", talker="主持人", show_up={{1501,-1,1}}, exit={}, audio=""
},
	[14]={ next_id=0, group_id=3, msg="。。。%@@%@#!", talker="观众们", show_up={}, exit={}, audio=""
}
}

return story_talk_data