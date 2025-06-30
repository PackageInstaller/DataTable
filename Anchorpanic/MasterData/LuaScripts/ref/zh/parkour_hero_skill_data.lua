-- from 1002 跑酷玩法配置表.xlsx

local parkour_hero_skill_data=

{
	[1001]={ type=1, effect={200,10}, buff_id={100101}, cd_time=0, use_cd_time=1000, icon="parkour_skill_icon_1001.png", max_useCount=2, release_effect={"fx_wild_prop_shunyi.prefab"}, sound_effect={"ui_wild_teleport.prefab"}, damage_type=0, damage_range={0}, icon_effect=""
},
	[1002]={ type=2, effect={100}, buff_id={10601,100102,10102}, cd_time=5000, use_cd_time=-1, icon="passkill_icon_94.png", max_useCount=1, release_effect={}, sound_effect={"ui_wild_shield.prefab"}, damage_type=0, damage_range={0}, icon_effect="fx_ui_fieldExploration_01"
},
	[1003]={ type=3, effect={200,100}, buff_id={}, cd_time=500, use_cd_time=0, icon="passkill_icon_165.png", max_useCount=1, release_effect={"fx_wild_prop_shanxian_01.prefab","fx_wild_prop_shanxian_02.prefab"}, sound_effect={}, damage_type=1, damage_range={20}, icon_effect=""
},
	[1004]={ type=4, effect={3001}, buff_id={}, cd_time=500, use_cd_time=1000, icon="passkill_icon_166.png", max_useCount=0, release_effect={"fx_wild_prop_xiangzi_zhiyin.prefab"}, sound_effect={}, damage_type=4, damage_range={40,30}, icon_effect="fx_ui_fieldExploration_04"
},
	[1005]={ type=5, effect={1212,10002}, buff_id={}, cd_time=500, use_cd_time=1000, icon="passkill_icon_166.png", max_useCount=0, release_effect={}, sound_effect={}, damage_type=4, damage_range={40,30}, icon_effect="fx_ui_fieldExploration_04"
}
}

return parkour_hero_skill_data