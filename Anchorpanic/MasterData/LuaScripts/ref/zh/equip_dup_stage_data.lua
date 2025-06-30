-- from 058 装备副本配置表.xlsx

local equip_dup_stage_data=

{
	[101]={ name="装备副本上(40级)", explain="前篇装备副本1", sort=1, chapter=1, next_id=102, enter_lv=40, need_tid=10, need_num=20, dup_guard={100001,100002,100003,100004,100005}, battle_scene=1001, drop={102}, hero_exp=120, main_exp=120, show_drop={100002}, position={10,10}
},
	[102]={ name="装备副本上(60级)", explain="前篇装备副本2", sort=2, chapter=1, next_id=103, enter_lv=60, need_tid=10, need_num=30, dup_guard={100001,100002,100003,100004,100005}, battle_scene=1001, drop={103}, hero_exp=140, main_exp=140, show_drop={100002}, position={20,20}
},
	[103]={ name="装备副本上(80级)", explain="前篇装备副本3", sort=3, chapter=1, next_id=104, enter_lv=80, need_tid=10, need_num=40, dup_guard={100001,100002,100003,100004,100005}, battle_scene=1001, drop={104}, hero_exp=160, main_exp=160, show_drop={100002}, position={30,30}
},
	[104]={ name="装备副本上（100级)", explain="前篇装备副本4", sort=4, chapter=1, next_id=105, enter_lv=100, need_tid=10, need_num=50, dup_guard={100001,100002,100003,100004,100005}, battle_scene=1001, drop={105}, hero_exp=180, main_exp=180, show_drop={100002}, position={40,40}
},
	[105]={ name="装备副本上（120级)", explain="前篇装备副本5", sort=5, chapter=1, next_id=201, enter_lv=120, need_tid=10, need_num=60, dup_guard={100001,100002,100003,100004,100005}, battle_scene=1001, drop={106}, hero_exp=200, main_exp=200, show_drop={100002}, position={50,50}
},
	[201]={ name="装备副本下(40级)", explain="后篇装备副本1", sort=1, chapter=2, next_id=202, enter_lv=40, need_tid=10, need_num=20, dup_guard={100001,100002,100003,100004,100005}, battle_scene=1001, drop={102}, hero_exp=120, main_exp=120, show_drop={100002}, position={10,10}
},
	[202]={ name="装备副本下(60级)", explain="后篇装备副本2", sort=2, chapter=2, next_id=203, enter_lv=60, need_tid=10, need_num=30, dup_guard={100001,100002,100003,100004,100005}, battle_scene=1001, drop={103}, hero_exp=140, main_exp=140, show_drop={100002}, position={20,20}
},
	[203]={ name="装备副本下(80级)", explain="后篇装备副本3", sort=3, chapter=2, next_id=204, enter_lv=80, need_tid=10, need_num=40, dup_guard={100001,100002,100003,100004,100005}, battle_scene=1001, drop={104}, hero_exp=160, main_exp=160, show_drop={100002}, position={30,30}
},
	[204]={ name="装备副本下（100级)", explain="后篇装备副本4", sort=4, chapter=2, next_id=205, enter_lv=100, need_tid=10, need_num=50, dup_guard={100001,100002,100003,100004,100005}, battle_scene=1001, drop={105}, hero_exp=180, main_exp=180, show_drop={100002}, position={40,40}
},
	[205]={ name="装备副本下（120级)", explain="后篇装备副本5", sort=5, chapter=2, next_id=0, enter_lv=120, need_tid=10, need_num=60, dup_guard={100001,100002,100003,100004,100005}, battle_scene=1001, drop={106}, hero_exp=200, main_exp=200, show_drop={100002}, position={50,50}
}
}

return equip_dup_stage_data