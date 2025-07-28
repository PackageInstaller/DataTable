-- from 1002 跑酷玩法配置表.xlsx

local parkour_event_data=

{
	[1001]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/wild/prefab/wild_prop_stone_A.prefab", is_cross=0, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[1002]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/wild/prefab/wild_prop_stone_B.prefab", is_cross=0, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[1003]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/wild/prefab/wild_prop_stone_C.prefab", is_cross=0, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[1004]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/wild/prefab/wild prop_muxiang.prefab", is_cross=0, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[1005]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/wild/prefab/wild_prop_mutong.prefab", is_cross=0, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[1101]={ type=4, skill_id={1101}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_wild_prop_zhaoze.prefab", is_cross=1, interact_type=1,30, interact_range={100}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[1201]={ type=2, skill_id={1201}, delay_time=0, normal_speed=5, prefab_name="arts/fx/3d/sceneModule/maze/fx_wild_prop_longjuanfeng.prefab", is_cross=1, interact_type=1,30, interact_range={80}, interact_center={}, movePos={{{6,0},7}}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1202]={ type=2, skill_id={1201}, delay_time=0, normal_speed=5, prefab_name="arts/fx/3d/sceneModule/maze/fx_wild_prop_longjuanfeng.prefab", is_cross=1, interact_type=1,30, interact_range={80}, interact_center={}, movePos={{{0,-6},7}}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1203]={ type=2, skill_id={1201}, delay_time=0, normal_speed=5, prefab_name="arts/fx/3d/sceneModule/maze/fx_wild_prop_longjuanfeng.prefab", is_cross=1, interact_type=1,30, interact_range={80}, interact_center={}, movePos={{{6,-6},10}}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1204]={ type=2, skill_id={1201}, delay_time=0, normal_speed=5, prefab_name="arts/fx/3d/sceneModule/maze/fx_wild_prop_longjuanfeng.prefab", is_cross=1, interact_type=1,30, interact_range={80}, interact_center={}, movePos={{{-6,-6},10}}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1205]={ type=2, skill_id={1201}, delay_time=0, normal_speed=5, prefab_name="arts/fx/3d/sceneModule/maze/fx_wild_prop_longjuanfeng.prefab", is_cross=1, interact_type=1,30, interact_range={80}, interact_center={}, movePos={{{-6,0},7},{{0,-6},7},{{6,0},7}}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1206]={ type=0, skill_id={}, delay_time=0, normal_speed=5, prefab_name="arts/fx/3d/sceneModule/maze/wild_prop_jiazixianjing.prefab", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=1, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1207]={ type=0, skill_id={}, delay_time=0, normal_speed=5, prefab_name="arts/fx/3d/sceneModule/maze/wild_prop_jiancizhadan.prefab", is_cross=0, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=1, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1208]={ type=101, skill_id={1208}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_zhu_b_01.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[1209]={ type=102, skill_id={1209}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_b.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=2, effect={"","fx_wild_prop_zhadan_stand.prefab","fx_wild_prop_zhadan_die.prefab",""}, sound_effect={}
},
	[1210]={ type=103, skill_id={1210}, delay_time=0, normal_speed=0, prefab_name="arts/scene/Public/Pickup/objects/prefabs/gold_08_dimian_02.prefab", is_cross=0, interact_type=2, interact_range={200,200}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[1212]={ type=106, skill_id={3001}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_box_01.prefab", is_cross=0, interact_type=2, interact_range={85,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[1213]={ type=105, skill_id={1210}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/dx_prop_02_door.prefab", is_cross=0, interact_type=2, interact_range={200,200}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[1214]={ type=101, skill_id={1208}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_zhu_g_01.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[1215]={ type=101, skill_id={1208}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_zhu_r_01.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[1216]={ type=101, skill_id={1208}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_zhu_y_01.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[1217]={ type=106, skill_id={3001}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_box_02.prefab", is_cross=0, interact_type=2, interact_range={85,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[1218]={ type=102, skill_id={1209}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_g.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=2, effect={"","fx_wild_prop_zhadan_stand.prefab","fx_wild_prop_zhadan_die.prefab",""}, sound_effect={}
},
	[1219]={ type=102, skill_id={1209}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_r.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=2, effect={"","fx_wild_prop_zhadan_stand.prefab","fx_wild_prop_zhadan_die.prefab",""}, sound_effect={}
},
	[1220]={ type=102, skill_id={1209}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_y.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=2, effect={"","fx_wild_prop_zhadan_stand.prefab","fx_wild_prop_zhadan_die.prefab",""}, sound_effect={}
},
	[1221]={ type=104, skill_id={1211,100001}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/mg_chuansong_02g/704_chuansong_02b.prefab", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[1222]={ type=104, skill_id={1211}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/mg_chuansong_02g/704_chuansong_02g.prefab", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[1223]={ type=104, skill_id={1211}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/mg_chuansong_02g/704_chuansong_02r.prefab", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[1224]={ type=104, skill_id={1211}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/mg_chuansong_02g/704_chuansong_02y.prefab", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[1225]={ type=106, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_box_02.prefab", is_cross=0, interact_type=2, interact_range={85,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[2001]={ type=5, skill_id={2001}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/wild_prop_boom/modelwild_prop_boom.prefab", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=1, is_repeat=0, effect={"","fx_wild_prop_zhadan_stand.prefab","fx_wild_prop_zhadan_die.prefab",""}, sound_effect={"","","ui_wild_boom_die.prefab",""}
},
	[2002]={ type=14, skill_id={2002}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/wild_prop_crystal_B/modelwild_prop_crystal_B.prefab", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"fx_wild_prop_crystal_B_goin.prefab","fx_wild_prop_crystal_B_stand.prefab","fx_wild_prop_crystal_B_die.prefab",""}, sound_effect={"","","ui_wild_goin_in.prefab",""}
},
	[2003]={ type=6, skill_id={2003}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/wild_prop_crystal_A/modelwild_prop_crystal_A.prefab", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"fx_wild_prop_crystal_A_goin.prefab","fx_wild_prop_crystal_A_stand.prefab","fx_wild_prop_crystal_A_die.prefab",""}, sound_effect={"","","ui_wild_goin_in.prefab",""}
},
	[2004]={ type=7, skill_id={2004}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/wild_prop_wind/modelwild_prop_wind.prefab", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={}
},
	[2005]={ type=8, skill_id={2005}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/wild_prop_shoot/modelwild_prop_shoot.prefab", is_cross=1, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={}
},
	[2006]={ type=9, skill_id={2006}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/wild_prop_heart/modelwild_prop_heart.prefab", is_cross=1, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"fx_wild_prop_aixin_goin.prefab","fx_wild_prop_aixin_stand.prefab","fx_wild_prop_aixin_die.prefab",""}, sound_effect={}
},
	[2007]={ type=10, skill_id={2007}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/wild_prop_shake/modelwild_prop_shake.prefab", is_cross=1, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={}
},
	[2008]={ type=11, skill_id={2008}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/wild_prop_cactu/modelwild_prop_cactu.prefab", is_cross=1, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"","","vfx_action_general_prop_confusion_die",""}, sound_effect={}
},
	[2009]={ type=12, skill_id={2008}, delay_time=0, normal_speed=0, prefab_name="arts/character/scene_module/wild_prop_baozhu.prefab", is_cross=1, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={}
},
	[2011]={ type=13, skill_id={3002}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/push/prefab/push_prop_transmit.prefab", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=1, is_repeat=0, effect={"","","",""}, sound_effect={}
},
	[3001]={ type=3, skill_id={3001}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/push/prefab/push_prop_obstacle_01.prefab", is_cross=0, interact_type=2, interact_range={85,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[3002]={ type=3, skill_id={3001}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/push/prefab/push_prop_obstacle_02.prefab", is_cross=0, interact_type=2, interact_range={185,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[3003]={ type=3, skill_id={3001}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/push/prefab/push_prop_obstacle_03.prefab", is_cross=0, interact_type=2, interact_range={285,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[10003]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_slchuansongmen.prefab", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10004]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/704_chuansong_02g.prefab", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10005]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/704_chuansong_02b.prefab", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10002]={ type=106, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_box_01.prefab", is_cross=0, interact_type=1, interact_range={40,150}, interact_center={0,30,0}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[10006]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/704_chuansong_02y.prefab", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10007]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/704_chuansong_02r.prefab", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10008]={ type=106, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_box_02.prefab", is_cross=0, interact_type=1, interact_range={40,150}, interact_center={0,30,0}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[10000]={ type=105, skill_id={10000}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/scene/dx_101/fx_scene_pickup_fengbi.prefab", is_cross=0, interact_type=2, interact_range={15,260}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={"","fx_scene_dx_101_fengbi.prefab","",""}, sound_effect={}
},
	[10001]={ type=101, skill_id={10001}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_zhu_b_01.prefab", is_cross=1, interact_type=1, interact_range={20,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10101]={ type=104, skill_id={10101,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","fx_maze_704_chuansong_02_b.prefab","",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10102]={ type=104, skill_id={10102,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","fx_maze_704_chuansong_02_g.prefab","",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10103]={ type=104, skill_id={10103,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","fx_maze_704_chuansong_02_b.prefab","",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10104]={ type=104, skill_id={10104,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","fx_maze_704_chuansong_02_g.prefab","",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10105]={ type=102, skill_id={10105}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_b.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10106]={ type=102, skill_id={10106}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_g.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10201]={ type=104, skill_id={10201,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10202]={ type=104, skill_id={10202,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10203]={ type=104, skill_id={10203,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10204]={ type=104, skill_id={10204,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10205]={ type=102, skill_id={10205}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_b.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10206]={ type=102, skill_id={10206}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_g.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10301]={ type=104, skill_id={10301}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10302]={ type=104, skill_id={10302}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10303]={ type=104, skill_id={10303}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_y.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10304]={ type=104, skill_id={10304}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10305]={ type=104, skill_id={10305}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10306]={ type=104, skill_id={10306}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_y.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10307]={ type=102, skill_id={10307}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_g.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10308]={ type=104, skill_id={10309,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10309]={ type=104, skill_id={10308,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10310]={ type=103, skill_id={1210}, delay_time=0, normal_speed=0, prefab_name="arts/scene/Public/Pickup/objects/prefabs/gold_10_danpingtai_a_002.prefab", is_cross=0, interact_type=2, interact_range={200,200}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[10311]={ type=101, skill_id={10311}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_zhu_b_01.prefab", is_cross=1, interact_type=1, interact_range={20,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10401]={ type=104, skill_id={10403,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10402]={ type=104, skill_id={10404,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10403]={ type=104, skill_id={10405,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10404]={ type=104, skill_id={10406,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10405]={ type=102, skill_id={10401}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_b.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10406]={ type=102, skill_id={10402}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_g.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10501]={ type=104, skill_id={10501,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10502]={ type=104, skill_id={10502,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10503]={ type=102, skill_id={10503}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_b.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10601]={ type=104, skill_id={10603,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10602]={ type=104, skill_id={10604,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10603]={ type=104, skill_id={10605,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10604]={ type=104, skill_id={10606,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10605]={ type=102, skill_id={10601}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_b.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10606]={ type=102, skill_id={10602}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_g.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10607]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="arts/scene/Public/Pickup/objects/prefabs/gold_10_langan_001.prefab", is_cross=0, interact_type=2, interact_range={100,300}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[10701]={ type=104, skill_id={10703,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10702]={ type=104, skill_id={10704,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10703]={ type=104, skill_id={10705,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10704]={ type=104, skill_id={10706,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10705]={ type=102, skill_id={10701}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_b.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10706]={ type=102, skill_id={10702}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_g.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10707]={ type=104, skill_id={10707,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10708]={ type=104, skill_id={10708,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10709]={ type=102, skill_id={10709}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_r.prefab", is_cross=1, interact_type=1, interact_range={40,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10710]={ type=104, skill_id={10710,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_y.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10711]={ type=104, skill_id={10711,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_y.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10712]={ type=102, skill_id={10712}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_y.prefab", is_cross=1, interact_type=1, interact_range={20,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10713]={ type=103, skill_id={10715}, delay_time=0, normal_speed=0, prefab_name="arts/scene/Public/Pickup/objects/prefabs/gold_10_danpingtai_b_002.prefab", is_cross=0, interact_type=3, interact_range={}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[10714]={ type=101, skill_id={10716}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_zhu_b_01.prefab", is_cross=1, interact_type=1, interact_range={20,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10801]={ type=104, skill_id={10804,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10802]={ type=104, skill_id={10805,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_b.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10803]={ type=104, skill_id={10807,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10804]={ type=104, skill_id={10806,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_g.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10805]={ type=104, skill_id={10808,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10806]={ type=104, skill_id={10809,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10807]={ type=102, skill_id={10801}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_b.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10808]={ type=102, skill_id={10802}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_g.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10809]={ type=102, skill_id={10803}, delay_time=0, normal_speed=0, prefab_name="arts/sceneModule/maze/prefab/builder/mg_kaiguan_r.prefab", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
}
}

return parkour_event_data