-- from 176 排位游戏配置表.xlsx

local ranking_game_data=

{
	[1001]={ name="1-1", first_award=22001, begin_time={}, game_parameter_list={{3,1,15},{1,2,3}}, pre_id=0, star_list={1,2,3}
},
	[1002]={ name="1-2", first_award=22001, begin_time={}, game_parameter_list={{4,2,15},{1,2,3,4}}, pre_id=1001, star_list={4,5,6}
},
	[1003]={ name="1-3", first_award=22001, begin_time={}, game_parameter_list={{4,2,13},{5,6,7,8}}, pre_id=1002, star_list={7,8,9}
},
	[1004]={ name="1-4", first_award=22001, begin_time={}, game_parameter_list={{4,0,16},{9,10,11,12}}, pre_id=1003, star_list={10,11,12}
},
	[1005]={ name="1-5", first_award=22001, begin_time={{2025,8,7},{5,0,0}}, game_parameter_list={{4,0,14},{1,3,5,7}}, pre_id=1004, star_list={13,14,15}
},
	[1006]={ name="1-6", first_award=22001, begin_time={{2025,8,7},{5,0,0}}, game_parameter_list={{4,0,12},{2,4,6,8}}, pre_id=1005, star_list={16,17,18}
},
	[1007]={ name="1-7", first_award=22001, begin_time={{2025,8,8},{5,0,0}}, game_parameter_list={{5,3,15},{1,2,3,4,5}}, pre_id=1006, star_list={19,20,21}
},
	[1008]={ name="1-8", first_award=22001, begin_time={{2025,8,8},{5,0,0}}, game_parameter_list={{5,3,13},{6,7,8,9,10}}, pre_id=1007, star_list={22,23,24}
},
	[2001]={ name="2-1", first_award=22001, begin_time={{2025,8,9},{5,0,0}}, game_parameter_list={{5,1,15},{8,9,10,11,12}}, pre_id=1008, star_list={25,26,27}
},
	[2002]={ name="2-2", first_award=22001, begin_time={{2025,8,9},{5,0,0}}, game_parameter_list={{5,1,13},{1,2,3,5,8}}, pre_id=2001, star_list={28,29,30}
},
	[2003]={ name="2-3", first_award=22001, begin_time={{2025,8,10},{5,0,0}}, game_parameter_list={{5,1,11},{4,6,9,10,11}}, pre_id=2002, star_list={31,32,33}
},
	[2004]={ name="2-4", first_award=22001, begin_time={{2025,8,10},{5,0,0}}, game_parameter_list={{6,4,15},{1,2,3,4,5,6}}, pre_id=2003, star_list={34,35,36}
},
	[2005]={ name="2-5", first_award=22001, begin_time={{2025,8,11},{5,0,0}}, game_parameter_list={{6,4,13},{7,8,9,10,11,12}}, pre_id=2004, star_list={37,38,39}
},
	[2006]={ name="2-6", first_award=22001, begin_time={{2025,8,11},{5,0,0}}, game_parameter_list={{6,2,15},{1,2,3,4,5,6}}, pre_id=2005, star_list={40,41,42}
},
	[2007]={ name="2-7", first_award=22001, begin_time={{2025,8,12},{5,0,0}}, game_parameter_list={{6,2,13},{7,8,9,10,11,12}}, pre_id=2006, star_list={43,44,45}
},
	[2008]={ name="2-8", first_award=22001, begin_time={{2025,8,12},{5,0,0}}, game_parameter_list={{6,2,11},{1,2,3,4,5,6}}, pre_id=2007, star_list={46,47,48}
},
	[3001]={ name="3-1", first_award=22001, begin_time={{2025,8,13},{5,0,0}}, game_parameter_list={{6,0,15},{7,8,9,10,11,12}}, pre_id=2008, star_list={49,50,51}
},
	[3002]={ name="3-2", first_award=22001, begin_time={{2025,8,13},{5,0,0}}, game_parameter_list={{7,5,17},{1,2,3,5,8,11,12}}, pre_id=3001, star_list={52,53,54}
},
	[3003]={ name="3-3", first_award=22001, begin_time={{2025,8,14},{5,0,0}}, game_parameter_list={{7,3,17},{6,7,8,9,10,11,12}}, pre_id=3002, star_list={55,56,57}
},
	[3004]={ name="3-4", first_award=22001, begin_time={{2025,8,14},{5,0,0}}, game_parameter_list={{7,1,17},{1,2,3,5,8,11,12}}, pre_id=3003, star_list={58,59,60}
},
	[3005]={ name="3-5", first_award=22001, begin_time={{2025,8,15},{5,0,0}}, game_parameter_list={{8,6,20},{1,2,3,4,5,8,11,12}}, pre_id=3004, star_list={61,62,63}
},
	[3006]={ name="3-6", first_award=22001, begin_time={{2025,8,15},{5,0,0}}, game_parameter_list={{8,4,20},{5,6,7,8,9,10,11,12}}, pre_id=3005, star_list={64,65,66}
},
	[3007]={ name="3-7", first_award=22001, begin_time={{2025,8,16},{5,0,0}}, game_parameter_list={{8,2,20},{1,2,3,5,7,8,11,12}}, pre_id=3006, star_list={67,68,69}
},
	[3008]={ name="3-8", first_award=22001, begin_time={{2025,8,16},{5,0,0}}, game_parameter_list={{8,0,20},{3,6,7,8,9,10,11,12}}, pre_id=3007, star_list={70,71,72}
}
}

return ranking_game_data