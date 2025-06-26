-- from 1002 跑酷玩法配置表.xlsx

local parkour_buff_data=

{
	[10001]={ type=100, effect={-50}, buff_effect={}
},
	[10101]={ type=101, effect={-50,2000}, buff_effect={"fx_wild_prop_wind_jiasu.prefab"}
},
	[10102]={ type=101, effect={100,5000}, buff_effect={}
},
	[10103]={ type=101, effect={-80,-1}, buff_effect={"fx_wild_prop_wind_jiasu.prefab"}
},
	[10104]={ type=101, effect={100,3000}, buff_effect={}
},
	[10201]={ type=102, effect={-30}, buff_effect={}
},
	[10202]={ type=102, effect={20}, buff_effect={"fx_wild_prop_heart_hfsm.prefab"}
},
	[10301]={ type=103, effect={300}, buff_effect={}
},
	[10401]={ type=104, effect={50}, buff_effect={}
},
	[10402]={ type=104, effect={100}, buff_effect={}
},
	[10501]={ type=105, effect={3000}, buff_effect={"fx_wild_prop_shake_hunluan.prefab"}
},
	[10601]={ type=106, effect={-100}, buff_effect={}
},
	[10602]={ type=106, effect={5}, buff_effect={}
},
	[10701]={ type=107, effect={1}, buff_effect={}
},
	[10801]={ type=108, effect={1}, buff_effect={}
},
	[100101]={ type=1001, effect={500}, buff_effect={}
},
	[100102]={ type=1001, effect={3000}, buff_effect={"fx_wild_prop_hudun.prefab"}
},
	[100103]={ type=1002, effect={20,100}, buff_effect={}
},
	[100301]={ type=1003, effect={-30}, buff_effect={"fx_wild_prop_hit.prefab"}
},
	[100302]={ type=1003, effect={-10}, buff_effect={"fx_wild_prop_hit.prefab"}
}
}

return parkour_buff_data