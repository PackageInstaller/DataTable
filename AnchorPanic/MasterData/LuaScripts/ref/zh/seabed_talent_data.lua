-- from 161 溟谷虚吟配置表.xlsx

local seabed_talent_data=

{
	[1]={ pre_id={}, next_id={4}, row=1, col=1, type=3, need_talent=1, title=111098, des=111100, icon="heroResonance/resonance_icon_shengmingjiacheng_1.png"
},
	[2]={ pre_id={}, next_id={5}, row=1, col=2, type=3, need_talent=1, title=111098, des=111101, icon="heroResonance/resonance_icon_gongjijiacheng_1.png"
},
	[3]={ pre_id={}, next_id={6}, row=1, col=3, type=3, need_talent=1, title=111098, des=111102, icon="heroResonance/resonance_icon_sudujiacheng.png"
},
	[4]={ pre_id={1}, next_id={7}, row=2, col=1, type=3, need_talent=2, title=111098, des=111103, icon="heroResonance/resonance_icon_gedangjilv.png"
},
	[5]={ pre_id={2}, next_id={7}, row=2, col=2, type=3, need_talent=2, title=111098, des=111104, icon="heroResonance/resonance_icon_pojijilv.png"
},
	[6]={ pre_id={3}, next_id={7}, row=2, col=3, type=3, need_talent=2, title=111098, des=111105, icon="heroResonance/resonance_icon_xiaoguodikangjiacheng.png"
},
	[7]={ pre_id={4,5,6}, next_id={8,9,10}, row=3, col=2, type=1, need_talent=3, title=111098, des=111106, icon="heroResonance/resonance_icon_sudujiacheng.png"
},
	[8]={ pre_id={7}, next_id={11}, row=4, col=1, type=3, need_talent=1, title=111098, des=111107, icon="heroResonance/resonance_icon_shengmingjiacheng_1.png"
},
	[9]={ pre_id={7}, next_id={12}, row=4, col=2, type=3, need_talent=1, title=111098, des=111108, icon="heroResonance/resonance_icon_gongjijiacheng_1.png"
},
	[10]={ pre_id={7}, next_id={13}, row=4, col=3, type=3, need_talent=1, title=111098, des=111109, icon="heroResonance/resonance_icon_sudujiacheng.png"
},
	[11]={ pre_id={8}, next_id={14}, row=5, col=1, type=3, need_talent=2, title=111098, des=111110, icon="heroResonance/resonance_icon_gedangjilv.png"
},
	[12]={ pre_id={9}, next_id={14}, row=5, col=2, type=3, need_talent=2, title=111098, des=111111, icon="heroResonance/resonance_icon_wushifangyu.png"
},
	[13]={ pre_id={10}, next_id={14}, row=5, col=3, type=3, need_talent=2, title=111098, des=111112, icon="heroResonance/resonance_icon_xiaoguomingzhongjiacheng.png"
},
	[14]={ pre_id={11,12,13}, next_id={15,16,17}, row=6, col=2, type=2, need_talent=3, title=111098, des=111113, icon="heroResonance/resonance_icon_xinpianjiacheng.png"
},
	[15]={ pre_id={14}, next_id={18}, row=7, col=1, type=3, need_talent=1, title=111098, des=111114, icon="heroResonance/resonance_icon_shengmingjiacheng_1.png"
},
	[16]={ pre_id={14}, next_id={19}, row=7, col=2, type=3, need_talent=1, title=111098, des=111115, icon="heroResonance/resonance_icon_gongjijiacheng_1.png"
},
	[17]={ pre_id={14}, next_id={20}, row=7, col=3, type=3, need_talent=1, title=111098, des=111116, icon="heroResonance/resonance_icon_sudujiacheng.png"
},
	[18]={ pre_id={15}, next_id={21}, row=8, col=1, type=3, need_talent=2, title=111098, des=111117, icon="heroResonance/resonance_icon_gedangjilv.png"
},
	[19]={ pre_id={16}, next_id={21}, row=8, col=2, type=3, need_talent=2, title=111098, des=111118, icon="heroResonance/resonance_icon_pojijilv.png"
},
	[20]={ pre_id={17}, next_id={21}, row=8, col=3, type=3, need_talent=2, title=111098, des=111119, icon="heroResonance/resonance_icon_xiaoguodikangjiacheng.png"
},
	[21]={ pre_id={18,19,20}, next_id={22,23,24}, row=9, col=2, type=4, need_talent=5, title=111099, des=111120, icon="heroResonance/resonance_icon_jinengshanghaijiacheng.png"
},
	[22]={ pre_id={21}, next_id={25}, row=10, col=1, type=3, need_talent=2, title=111098, des=111121, icon="heroResonance/resonance_icon_shengmingjiacheng_1.png"
},
	[23]={ pre_id={21}, next_id={26}, row=10, col=2, type=3, need_talent=2, title=111098, des=111122, icon="heroResonance/resonance_icon_gongjijiacheng_1.png"
},
	[24]={ pre_id={21}, next_id={27}, row=10, col=3, type=3, need_talent=2, title=111098, des=111123, icon="heroResonance/resonance_icon_sudujiacheng.png"
},
	[25]={ pre_id={22}, next_id={28}, row=11, col=1, type=3, need_talent=4, title=111098, des=111124, icon="heroResonance/resonance_icon_gedangjilv.png"
},
	[26]={ pre_id={23}, next_id={28}, row=11, col=2, type=3, need_talent=4, title=111098, des=111125, icon="heroResonance/resonance_icon_wushifangyu.png"
},
	[27]={ pre_id={24}, next_id={28}, row=11, col=3, type=3, need_talent=4, title=111098, des=111126, icon="heroResonance/resonance_icon_xiaoguomingzhongjiacheng.png"
},
	[28]={ pre_id={25,26,27}, next_id={29,30,31}, row=12, col=2, type=4, need_talent=5, title=111099, des=111127, icon="heroResonance/resonance_icon_jinengshanghaijiacheng.png"
},
	[29]={ pre_id={28}, next_id={32}, row=13, col=1, type=3, need_talent=2, title=111098, des=111128, icon="heroResonance/resonance_icon_shengmingjiacheng_1.png"
},
	[30]={ pre_id={28}, next_id={33}, row=13, col=2, type=3, need_talent=2, title=111098, des=111129, icon="heroResonance/resonance_icon_gongjijiacheng_1.png"
},
	[31]={ pre_id={28}, next_id={34}, row=13, col=3, type=3, need_talent=2, title=111098, des=111130, icon="heroResonance/resonance_icon_sudujiacheng.png"
},
	[32]={ pre_id={29}, next_id={35}, row=14, col=1, type=3, need_talent=4, title=111098, des=111131, icon="heroResonance/resonance_icon_gedangjilv.png"
},
	[33]={ pre_id={30}, next_id={35}, row=14, col=2, type=3, need_talent=4, title=111098, des=111132, icon="heroResonance/resonance_icon_pojijilv.png"
},
	[34]={ pre_id={31}, next_id={35}, row=14, col=3, type=3, need_talent=4, title=111098, des=111133, icon="heroResonance/resonance_icon_xiaoguodikangjiacheng.png"
},
	[35]={ pre_id={32,33,34}, next_id={36,37,38}, row=15, col=2, type=4, need_talent=5, title=111099, des=111134, icon="heroResonance/resonance_icon_jinengshanghaijiacheng.png"
},
	[36]={ pre_id={35}, next_id={39}, row=16, col=1, type=3, need_talent=2, title=111098, des=111135, icon="heroResonance/resonance_icon_shengmingjiacheng_1.png"
},
	[37]={ pre_id={35}, next_id={39}, row=16, col=2, type=3, need_talent=2, title=111098, des=111136, icon="heroResonance/resonance_icon_gongjijiacheng_1.png"
},
	[38]={ pre_id={35}, next_id={39}, row=16, col=3, type=3, need_talent=2, title=111098, des=111137, icon="heroResonance/resonance_icon_sudujiacheng.png"
},
	[39]={ pre_id={36,37,38}, next_id={}, row=17, col=2, type=4, need_talent=5, title=111099, des=111138, icon="heroResonance/resonance_icon_jinengshanghaijiacheng.png"
}
}

return seabed_talent_data