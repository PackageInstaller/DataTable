-- from 1002 跑酷玩法配置表.xlsx

local parkour_event_data=

{
	[1001]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="shitou01", is_cross=0, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[1002]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="shitou02", is_cross=0, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[1003]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="shitou03", is_cross=0, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[1004]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="muxiang01", is_cross=0, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[1005]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="muxiang02", is_cross=0, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[1101]={ type=4, skill_id={1101}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_wild_prop_zhaoze.prefab", is_cross=1, interact_type=1,30, interact_range={100}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[1201]={ type=2, skill_id={1201}, delay_time=0, normal_speed=5, prefab_name="fx_longjuanfeng", is_cross=1, interact_type=1,30, interact_range={80}, interact_center={}, movePos={{{6,0},7}}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1202]={ type=2, skill_id={1201}, delay_time=0, normal_speed=5, prefab_name="fx_longjuanfeng", is_cross=1, interact_type=1,30, interact_range={80}, interact_center={}, movePos={{{0,-6},7}}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1203]={ type=2, skill_id={1201}, delay_time=0, normal_speed=5, prefab_name="fx_longjuanfeng", is_cross=1, interact_type=1,30, interact_range={80}, interact_center={}, movePos={{{6,-6},10}}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1204]={ type=2, skill_id={1201}, delay_time=0, normal_speed=5, prefab_name="fx_longjuanfeng", is_cross=1, interact_type=1,30, interact_range={80}, interact_center={}, movePos={{{-6,-6},10}}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1205]={ type=2, skill_id={1201}, delay_time=0, normal_speed=5, prefab_name="fx_longjuanfeng", is_cross=1, interact_type=1,30, interact_range={80}, interact_center={}, movePos={{{-6,0},7},{{0,-6},7},{{6,0},7}}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1206]={ type=0, skill_id={}, delay_time=0, normal_speed=5, prefab_name="jiazi", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=1, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1207]={ type=0, skill_id={}, delay_time=0, normal_speed=5, prefab_name="jianci", is_cross=0, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=1, is_repeat=1, effect={}, sound_effect={"","","ui_wild_wind_die.prefab",""}
},
	[1208]={ type=101, skill_id={1208}, delay_time=0, normal_speed=0, prefab_name="yalikaiguan_lanse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[1209]={ type=102, skill_id={1209}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lanse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=2, effect={"","fx_wild_prop_zhadan_stand.prefab","fx_wild_prop_zhadan_die.prefab",""}, sound_effect={}
},
	[1210]={ type=103, skill_id={1210}, delay_time=0, normal_speed=0, prefab_name="dianti", is_cross=0, interact_type=2, interact_range={200,200}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[1212]={ type=106, skill_id={3001}, delay_time=0, normal_speed=0, prefab_name="xiangzi_lanse", is_cross=0, interact_type=2, interact_range={85,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[1213]={ type=105, skill_id={1210}, delay_time=0, normal_speed=0, prefab_name="jiguanmen", is_cross=0, interact_type=2, interact_range={200,200}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[1214]={ type=101, skill_id={1208}, delay_time=0, normal_speed=0, prefab_name="yalikaigua_green", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[1215]={ type=101, skill_id={1208}, delay_time=0, normal_speed=0, prefab_name="yalikaigua_red", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[1216]={ type=101, skill_id={1208}, delay_time=0, normal_speed=0, prefab_name="yalikaigua_yellow", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[1217]={ type=106, skill_id={3001}, delay_time=0, normal_speed=0, prefab_name="xiangzi_huangse", is_cross=0, interact_type=2, interact_range={85,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[1218]={ type=102, skill_id={1209}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lvse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=2, effect={"","fx_wild_prop_zhadan_stand.prefab","fx_wild_prop_zhadan_die.prefab",""}, sound_effect={}
},
	[1219]={ type=102, skill_id={1209}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_hongse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=2, effect={"","fx_wild_prop_zhadan_stand.prefab","fx_wild_prop_zhadan_die.prefab",""}, sound_effect={}
},
	[1220]={ type=102, skill_id={1209}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_huangse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=2, effect={"","fx_wild_prop_zhadan_stand.prefab","fx_wild_prop_zhadan_die.prefab",""}, sound_effect={}
},
	[1221]={ type=104, skill_id={1211,100001}, delay_time=0, normal_speed=0, prefab_name="chuansongmen_bule", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[1222]={ type=104, skill_id={1211}, delay_time=0, normal_speed=0, prefab_name="chuansongmen_green", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[1223]={ type=104, skill_id={1211}, delay_time=0, normal_speed=0, prefab_name="chuansongmen_red", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[1224]={ type=104, skill_id={1211}, delay_time=0, normal_speed=0, prefab_name="chuansongmen_yellow", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[1225]={ type=106, skill_id={}, delay_time=0, normal_speed=0, prefab_name="xiangzi_huangse", is_cross=0, interact_type=2, interact_range={85,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[2001]={ type=5, skill_id={2001}, delay_time=0, normal_speed=0, prefab_name="zhadan", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=1, is_repeat=0, effect={"","fx_wild_prop_zhadan_stand.prefab","fx_wild_prop_zhadan_die.prefab",""}, sound_effect={"","","ui_wild_boom_die.prefab",""}
},
	[2002]={ type=14, skill_id={2002}, delay_time=0, normal_speed=0, prefab_name="yinbi", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"fx_wild_prop_crystal_B_goin.prefab","fx_wild_prop_crystal_B_stand.prefab","fx_wild_prop_crystal_B_die.prefab",""}, sound_effect={"","","ui_wild_goin_in.prefab",""}
},
	[2003]={ type=6, skill_id={2003}, delay_time=0, normal_speed=0, prefab_name="jinbi", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"fx_wild_prop_crystal_A_goin.prefab","fx_wild_prop_crystal_A_stand.prefab","fx_wild_prop_crystal_A_die.prefab",""}, sound_effect={"","","ui_wild_goin_in.prefab",""}
},
	[2004]={ type=7, skill_id={2004}, delay_time=0, normal_speed=0, prefab_name="shensushuiguo", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={}
},
	[2005]={ type=8, skill_id={2005}, delay_time=0, normal_speed=0, prefab_name="jiansushuiguo", is_cross=1, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={}
},
	[2006]={ type=9, skill_id={2006}, delay_time=0, normal_speed=0, prefab_name="jiaxueshuiguo", is_cross=1, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"fx_wild_prop_aixin_goin.prefab","fx_wild_prop_aixin_stand.prefab","fx_wild_prop_aixin_die.prefab",""}, sound_effect={}
},
	[2007]={ type=10, skill_id={2007}, delay_time=0, normal_speed=0, prefab_name="hunluanshuiguo", is_cross=1, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={}
},
	[2008]={ type=11, skill_id={2008}, delay_time=0, normal_speed=0, prefab_name="fulanshuiguo", is_cross=1, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"","","vfx_action_general_prop_confusion_die",""}, sound_effect={}
},
	[2009]={ type=12, skill_id={2008}, delay_time=0, normal_speed=0, prefab_name="wudibaozhu", is_cross=1, interact_type=1, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"","","fx_wild_prop_boom_die.prefab",""}, sound_effect={}
},
	[2011]={ type=13, skill_id={3002}, delay_time=0, normal_speed=0, prefab_name="chuansongdai", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=1, is_repeat=0, effect={"","","",""}, sound_effect={}
},
	[3001]={ type=3, skill_id={3001}, delay_time=0, normal_speed=0, prefab_name="juma01", is_cross=0, interact_type=2, interact_range={85,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[3002]={ type=3, skill_id={3001}, delay_time=0, normal_speed=0, prefab_name="juma02", is_cross=0, interact_type=2, interact_range={185,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[3003]={ type=3, skill_id={3001}, delay_time=0, normal_speed=0, prefab_name="juma03", is_cross=0, interact_type=2, interact_range={285,85}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[10003]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="zhongduanmen", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10004]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="linshiziyuan01", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10005]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="linshiziyuan02", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10002]={ type=106, skill_id={}, delay_time=0, normal_speed=0, prefab_name="xiangzi_lanse", is_cross=0, interact_type=1, interact_range={40,150}, interact_center={0,30,0}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[10006]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="linshiziyuan03", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10007]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="linshiziyuan04", is_cross=1, interact_type=0, interact_range={}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10008]={ type=106, skill_id={}, delay_time=0, normal_speed=0, prefab_name="xiangzi_huangse", is_cross=0, interact_type=1, interact_range={40,150}, interact_center={0,30,0}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[10000]={ type=105, skill_id={10000}, delay_time=0, normal_speed=0, prefab_name="fx_fengbimen", is_cross=0, interact_type=2, interact_range={15,260}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={"","fx_scene_dx_101_fengbi.prefab","",""}, sound_effect={}
},
	[10001]={ type=101, skill_id={10001}, delay_time=0, normal_speed=0, prefab_name="yalikaiguan_lanse", is_cross=1, interact_type=1, interact_range={20,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10101]={ type=104, skill_id={10101,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","fx_maze_704_chuansong_02_b.prefab","",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10102]={ type=104, skill_id={10102,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","fx_maze_704_chuansong_02_g.prefab","",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10103]={ type=104, skill_id={10103,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","fx_maze_704_chuansong_02_b.prefab","",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10104]={ type=104, skill_id={10104,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={"","fx_maze_704_chuansong_02_g.prefab","",""}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10105]={ type=102, skill_id={10105}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lanse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10106]={ type=102, skill_id={10106}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lvse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10201]={ type=104, skill_id={10201,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10202]={ type=104, skill_id={10202,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10203]={ type=104, skill_id={10203,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10204]={ type=104, skill_id={10204,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10205]={ type=102, skill_id={10205}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lanse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10206]={ type=102, skill_id={10206}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lvse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10301]={ type=104, skill_id={10301}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10302]={ type=104, skill_id={10302}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10303]={ type=104, skill_id={10303}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_y.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10304]={ type=104, skill_id={10304}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10305]={ type=104, skill_id={10305}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10306]={ type=104, skill_id={10306}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_y.prefab", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10307]={ type=102, skill_id={10307}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lvse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10308]={ type=104, skill_id={10309,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10309]={ type=104, skill_id={10308,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10310]={ type=103, skill_id={1210}, delay_time=0, normal_speed=0, prefab_name="pingtai", is_cross=0, interact_type=2, interact_range={200,200}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[10311]={ type=101, skill_id={10311}, delay_time=0, normal_speed=0, prefab_name="yalikaiguan_lanse", is_cross=1, interact_type=1, interact_range={20,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10401]={ type=104, skill_id={10403,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10402]={ type=104, skill_id={10404,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10403]={ type=104, skill_id={10405,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10404]={ type=104, skill_id={10406,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10405]={ type=102, skill_id={10401}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lanse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10406]={ type=102, skill_id={10402}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lvse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10501]={ type=104, skill_id={10501,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10502]={ type=104, skill_id={10502,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10503]={ type=102, skill_id={10503}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lanse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10601]={ type=104, skill_id={10603,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10602]={ type=104, skill_id={10604,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10603]={ type=104, skill_id={10605,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10604]={ type=104, skill_id={10606,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={35,35}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10605]={ type=102, skill_id={10601}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lanse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10606]={ type=102, skill_id={10602}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lvse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10607]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="langan", is_cross=0, interact_type=2, interact_range={100,300}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[10701]={ type=104, skill_id={10703,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10702]={ type=104, skill_id={10704,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10703]={ type=104, skill_id={10705,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10704]={ type=104, skill_id={10706,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10705]={ type=102, skill_id={10701}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lanse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10706]={ type=102, skill_id={10702}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lvse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10707]={ type=104, skill_id={10707,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10708]={ type=104, skill_id={10708,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10709]={ type=102, skill_id={10709}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_hongse", is_cross=1, interact_type=1, interact_range={40,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10710]={ type=104, skill_id={10710,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_y.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10711]={ type=104, skill_id={10711,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_y.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10712]={ type=102, skill_id={10712}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_huangse", is_cross=1, interact_type=1, interact_range={20,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10713]={ type=103, skill_id={10715}, delay_time=0, normal_speed=0, prefab_name="xiepo", is_cross=0, interact_type=3, interact_range={}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[10714]={ type=101, skill_id={10716}, delay_time=0, normal_speed=0, prefab_name="yalikaiguan_lanse", is_cross=1, interact_type=1, interact_range={20,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10801]={ type=104, skill_id={10804,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10802]={ type=104, skill_id={10805,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lanse", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10803]={ type=104, skill_id={10807,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10804]={ type=104, skill_id={10806,10116}, delay_time=0, normal_speed=0, prefab_name="fx_chuansongmen_lvse", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10805]={ type=104, skill_id={10808,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10806]={ type=104, skill_id={10809,10116}, delay_time=0, normal_speed=0, prefab_name="arts/fx/3d/sceneModule/maze/fx_maze_704_chuansong_02_r.prefab", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[10807]={ type=102, skill_id={10801}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lanse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10808]={ type=102, skill_id={10802}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_lvse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[10809]={ type=102, skill_id={10803}, delay_time=0, normal_speed=0, prefab_name="zhuangtaikaiguan_hongse", is_cross=1, interact_type=1, interact_range={50,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[102010]={ type=107, skill_id={10202}, delay_time=0, normal_speed=0, prefab_name="", is_cross=0, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[102020]={ type=108, skill_id={10203}, delay_time=0, normal_speed=0, prefab_name="", is_cross=0, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[102030]={ type=108, skill_id={10204}, delay_time=0, normal_speed=0, prefab_name="", is_cross=0, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[102040]={ type=109, skill_id={10205}, delay_time=0, normal_speed=0, prefab_name="", is_cross=0, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=2, is_repeat=1, effect={}, sound_effect={}
},
	[12000]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="MuXiang", is_cross=0, interact_type=2, interact_range={50,50}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[12001]={ type=6, skill_id={2003}, delay_time=0, normal_speed=0, prefab_name="jinbi", is_cross=1, interact_type=1, interact_range={35,1}, interact_center={}, movePos={}, trigger_type=0, is_repeat=0, effect={"fx_wild_prop_crystal_A_goin.prefab","fx_wild_prop_crystal_A_stand.prefab","fx_wild_prop_crystal_A_die.prefab",""}, sound_effect={"","","ui_wild_goin_in.prefab",""}
},
	[12002]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="PingTai", is_cross=0, interact_type=2, interact_range={70,1}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[12003]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="WeiLan", is_cross=0, interact_type=3, interact_range={}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[12004]={ type=1, skill_id={}, delay_time=0, normal_speed=0, prefab_name="JiaoTongZhui", is_cross=0, interact_type=2, interact_range={30,30,550}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[12005]={ type=1, skill_id={10206}, delay_time=0, normal_speed=0, prefab_name="Fx_GeZi_HongSe", is_cross=0, interact_type=2, interact_range={200,200,400}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[13101]={ type=0, skill_id={13100}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13102]={ type=0, skill_id={13100}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13103]={ type=0, skill_id={13100}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13104]={ type=0, skill_id={13100}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13105]={ type=0, skill_id={13100}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13106]={ type=0, skill_id={13100}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13107]={ type=0, skill_id={13100}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13201]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13202]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13203]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13204]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13205]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13206]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13207]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13208]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13209]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13210]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13211]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13212]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13213]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13214]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13215]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13216]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13217]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13218]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13219]={ type=0, skill_id={13200}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13301]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13302]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13303]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13304]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13305]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13306]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13307]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13308]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13309]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13310]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13311]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13312]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13313]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13314]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13315]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13316]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13317]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13318]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13319]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13320]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13321]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13322]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13323]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13324]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13325]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13326]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13327]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13328]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13329]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13330]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13331]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13332]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13333]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13334]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13335]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13336]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13337]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13338]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13339]={ type=0, skill_id={13300}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={60,60}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13401]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13402]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13403]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13404]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13405]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13406]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13407]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13408]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13409]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13410]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13411]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13412]={ type=0, skill_id={13400}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13501]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13502]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13503]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13504]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13505]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13506]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13507]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13508]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13509]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13510]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13511]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13512]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13513]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13514]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13515]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13516]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13517]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13518]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13519]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13520]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13521]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13522]={ type=0, skill_id={13500}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13601]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13602]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13603]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13604]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13605]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13606]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13607]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13608]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13609]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13610]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13611]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13612]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13613]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13614]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13615]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13616]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13617]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13618]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13619]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13620]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13621]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13622]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13623]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13624]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13625]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13626]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13627]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13628]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13629]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13630]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13631]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13632]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13633]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13634]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13635]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13636]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13637]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13638]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13639]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13640]={ type=0, skill_id={13600}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13701]={ type=0, skill_id={13700}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13702]={ type=0, skill_id={13700}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13703]={ type=0, skill_id={13700}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13704]={ type=0, skill_id={13700}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13705]={ type=0, skill_id={13700}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13706]={ type=0, skill_id={13700}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13707]={ type=0, skill_id={13700}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13708]={ type=0, skill_id={13700}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13709]={ type=104, skill_id={13701}, delay_time=0, normal_speed=0, prefab_name="Fx_ChuanSongMen_LanSe", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[13710]={ type=104, skill_id={13702}, delay_time=0, normal_speed=0, prefab_name="Fx_ChuanSongMen_LanSe", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[13801]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13802]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13803]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13804]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13805]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13806]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13807]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13808]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13809]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13810]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13811]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13812]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13813]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13814]={ type=0, skill_id={13800}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13815]={ type=104, skill_id={13801}, delay_time=0, normal_speed=0, prefab_name="Fx_ChuanSongMen_LanSe", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[13816]={ type=104, skill_id={13802}, delay_time=0, normal_speed=0, prefab_name="Fx_ChuanSongMen_LanSe", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[13901]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13902]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13903]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13904]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13905]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13906]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13907]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13908]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13909]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13910]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13911]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13912]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13913]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13914]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13915]={ type=0, skill_id={13900}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[13916]={ type=104, skill_id={13901}, delay_time=0, normal_speed=0, prefab_name="Fx_ChuanSongMen_LanSe", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[13917]={ type=104, skill_id={13902}, delay_time=0, normal_speed=0, prefab_name="Fx_ChuanSongMen_LanSe", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[14001]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14002]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14003]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14004]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14005]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14006]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14007]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14008]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14009]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14010]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14011]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14012]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14013]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14014]={ type=0, skill_id={14000}, delay_time=0, normal_speed=0, prefab_name="GeZi", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={}
},
	[14015]={ type=1, skill_id={10206}, delay_time=0, normal_speed=0, prefab_name="Fx_GeZi_HongSe", is_cross=0, interact_type=2, interact_range={200,200,400}, interact_center={}, movePos={}, trigger_type=-1, is_repeat=0, effect={}, sound_effect={}
},
	[14016]={ type=104, skill_id={14001}, delay_time=0, normal_speed=0, prefab_name="Fx_ChuanSongMen_LanSe", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
},
	[14017]={ type=104, skill_id={14002}, delay_time=0, normal_speed=0, prefab_name="Fx_ChuanSongMen_LanSe", is_cross=1, interact_type=2, interact_range={20,20}, interact_center={}, movePos={}, trigger_type=0, is_repeat=1, effect={}, sound_effect={"","","","ui_common_transmit.prefab"}
}
}

return parkour_event_data