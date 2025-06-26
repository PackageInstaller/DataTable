-- from Buff配置表.xlsx

local buff_perform_data=

{
	[1]={ status_id=0, name="1", desc="abc", data_type=1, data_val="100,30,2;102,50,2", time=20, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2]={ status_id=0, name="2", desc="abc", data_type=2, data_val="104,20,2", time=0, interval=0, eft_type=1, eft_name="a1_eft_shiwangfeidai_02.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[3]={ status_id=0, name="3", desc="abc", data_type=1, data_val="105,30,2", time=10, interval=5, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[4]={ status_id=0, name="4", desc="abc", data_type=2, data_val="101,30,2", time=15, interval=5, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[5]={ status_id=0, name="6", desc="abc", data_type=0, data_val="", time=25, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=1, influence_type=105,50,2, influence_val=""
},
	[6]={ status_id=0, name="7", desc="abc", data_type=0, data_val="", time=30, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=2, influence_type=105,10,2, influence_val=""
},
	[7]={ status_id=0, name="8", desc="abc", data_type=0, data_val="", time=35, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=3, influence_type=105,2, influence_val=""
},
	[8]={ status_id=0, name="10", desc="abc", data_type=0, data_val="", time=40, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=4, influence_type=5, influence_val=""
},
	[20]={ status_id=0, name="磁暴干扰", desc="塞薇娅发出磁暴干扰", data_type=2, data_val="104,2500,1", time=15, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[30]={ status_id=0, name="集中火力", desc="集中火力", data_type=2, data_val="113,5000,2", time=10, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[40]={ status_id=0, name="生命再生", desc="生命再生", data_type=2, data_val="101,100,2,100", time=10, interval=1, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[50]={ status_id=0, name="荣光之盾", desc="xxx", data_type=2, data_val="201,50000,2", time=8, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[60]={ status_id=0, name="铜墙铁壁", desc="xxx", data_type=2, data_val="301,6500,2;404,1,2", time=5, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[61]={ status_id=0, name="铜墙铁壁", desc="xxx", data_type=1, data_val="404,1,2", time=5, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[70]={ status_id=0, name="静电领域", desc="xxx", data_type=2, data_val="104,3000,2", time=0, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[71]={ status_id=0, name="静电领域", desc="xxx", data_type=1, data_val="207,50,2", time=0, interval=1, eft_type=1, eft_name="", be_reset=0, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[72]={ status_id=502, name="静电领域", desc="xxx", data_type=0, data_val="0", time=0, interval=0, eft_type=1, eft_name="", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[80]={ status_id=0, name="能量衰竭", desc="xxx", data_type=2, data_val="206,5000,1", time=10, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[81]={ status_id=0, name="能量衰竭", desc="xxx", data_type=1, data_val="207,80,1", time=1, interval=0, eft_type=1, eft_name="", be_reset=0, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[90]={ status_id=0, name="核能光束", desc="xxx", data_type=2, data_val="301,6000,2", time=10, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[100]={ status_id=503, name="磁暴弹", desc="xxx", data_type=0, data_val="", time=2, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[110]={ status_id=503, name="M-167冲击炮", desc="xxx", data_type=0, data_val="", time=0.2, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[120]={ status_id=0, name="预留 暂不使用", desc="xxx", data_type=2, data_val="301,6500,2;404,1,2", time=5, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[130]={ status_id=503, name="动能干扰", desc="xxx", data_type=0, data_val="", time=3, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[131]={ status_id=0, name="动能干扰", desc="xxx", data_type=2, data_val="301,2500,1", time=5, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[140]={ status_id=503, name="干扰电网", desc="xxx", data_type=0, data_val="", time=5, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[141]={ status_id=504, name="干扰电网", desc="xxx", data_type=0, data_val="", time=5, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[150]={ status_id=0, name="预留 暂不使用", desc="xxx", data_type=0, data_val="", time=0, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[160]={ status_id=0, name="C-26干扰器", desc="空buff", data_type=0, data_val="", time=10, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=2, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[3030]={ status_id=0, name="防御祝福", desc="xxx", data_type=2, data_val="105,3000,2", time=10, interval=0, eft_type=1, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2001]={ status_id=0, name="灼烧", desc="灼烧", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=1, overlying_id=1, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2002]={ status_id=0, name="护盾", desc="护盾", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2003]={ status_id=0, name="加深属性伤害", desc="加深属性伤害", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2004]={ status_id=0, name="护盾", desc="护盾", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2005]={ status_id=0, name="眩晕", desc="眩晕", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2006]={ status_id=0, name="降低格挡几率", desc="降低格挡几率", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2007]={ status_id=0, name="提高闪避几率", desc="提高闪避几率", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2008]={ status_id=0, name="兴奋剂", desc="兴奋剂", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2009]={ status_id=0, name="提升攻击力", desc="提升攻击力", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2010]={ status_id=0, name="提升攻击力，暴击率", desc="提升攻击力，暴击率", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2011]={ status_id=0, name="增加速度", desc="增加速度", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2012]={ status_id=0, name="兴奋剂   增强", desc="兴奋剂   增强", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
},
	[2013]={ status_id=0, name="提高暴击率", desc="提高暴击率", data_type=0, data_val="", time=0, interval=0, eft_type=0, eft_name="a1_eft_bingdong_01.prefab", be_reset=0, overlying_id=0, over_eft_flag=0, float=0, influence_type=0, influence_val=""
}
}

return buff_perform_data