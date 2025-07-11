-- from 169 拼图游戏配置表.xlsx

local jigsaw_puzzle_data=

{
	[1001]={ name="1-1", first_award=22001, begin_time={}, jigsaw_list={
		[1]={ row=1, col=2 },
		[2]={ row=2, col=1 },
		[3]={ row=1, col=1 },
		[4]={ row=2, col=2 },
}, pre_id=0, bg_img="putImage_bg_01.png"
},
	[1002]={ name="1-2", first_award=22001, begin_time={}, jigsaw_list={
		[1]={ row=2, col=1 },
		[2]={ row=2, col=2 },
		[3]={ row=1, col=2 },
		[4]={ row=1, col=1 },
}, pre_id=1001, bg_img="putImage_bg_02.png"
},
	[1003]={ name="1-3", first_award=22001, begin_time={}, jigsaw_list={
		[1]={ row=2, col=1 },
		[2]={ row=1, col=1 },
		[3]={ row=1, col=2 },
		[4]={ row=2, col=2 },
}, pre_id=1002, bg_img="putImage_bg_03.png"
},
	[1004]={ name="1-4", first_award=22001, begin_time={{2025,3,5},{5,0,0}}, jigsaw_list={
		[1]={ row=1, col=1 },
		[2]={ row=3, col=2 },
		[3]={ row=1, col=3 },
		[4]={ row=3, col=1 },
		[5]={ row=2, col=2 },
		[6]={ row=2, col=3 },
		[7]={ row=2, col=1 },
		[8]={ row=1, col=2 },
		[9]={ row=3, col=3 },
}, pre_id=1003, bg_img="putImage_bg_04.png"
},
	[1005]={ name="1-5", first_award=22001, begin_time={{2025,3,6},{5,0,0}}, jigsaw_list={
		[1]={ row=1, col=2 },
		[2]={ row=2, col=2 },
		[3]={ row=3, col=2 },
		[4]={ row=1, col=1 },
		[5]={ row=3, col=1 },
		[6]={ row=2, col=3 },
		[7]={ row=1, col=3 },
		[8]={ row=2, col=1 },
		[9]={ row=3, col=3 },
}, pre_id=1004, bg_img="putImage_bg_05.png"
},
	[1006]={ name="1-6", first_award=22001, begin_time={{2025,3,7},{5,0,0}}, jigsaw_list={
		[1]={ row=2, col=1 },
		[2]={ row=1, col=2 },
		[3]={ row=3, col=3 },
		[4]={ row=1, col=1 },
		[5]={ row=3, col=2 },
		[6]={ row=2, col=3 },
		[7]={ row=3, col=1 },
		[8]={ row=1, col=3 },
		[9]={ row=2, col=2 },
}, pre_id=1005, bg_img="putImage_bg_06.png"
},
	[1007]={ name="1-7", first_award=22001, begin_time={{2025,3,8},{5,0,0}}, jigsaw_list={
		[1]={ row=3, col=3 },
		[2]={ row=2, col=3 },
		[3]={ row=3, col=1 },
		[4]={ row=3, col=2 },
		[5]={ row=1, col=1 },
		[6]={ row=1, col=2 },
		[7]={ row=1, col=3 },
		[8]={ row=2, col=1 },
		[9]={ row=2, col=2 },
}, pre_id=1006, bg_img="putImage_bg_07.png"
},
	[1008]={ name="1-8", first_award=22001, begin_time={{2025,3,9},{5,0,0}}, jigsaw_list={
		[1]={ row=3, col=2 },
		[2]={ row=1, col=1 },
		[3]={ row=1, col=3 },
		[4]={ row=2, col=1 },
		[5]={ row=2, col=2 },
		[6]={ row=3, col=1 },
		[7]={ row=3, col=3 },
		[8]={ row=2, col=3 },
		[9]={ row=1, col=2 },
}, pre_id=1007, bg_img="putImage_bg_08.png"
},
	[2001]={ name="2-1", first_award=22001, begin_time={{2025,3,10},{5,0,0}}, jigsaw_list={
		[1]={ row=2, col=1 },
		[2]={ row=1, col=2 },
		[3]={ row=3, col=3 },
		[4]={ row=1, col=1 },
		[5]={ row=3, col=2 },
		[6]={ row=2, col=3 },
		[7]={ row=3, col=1 },
		[8]={ row=1, col=3 },
		[9]={ row=2, col=2 },
}, pre_id=1008, bg_img="putImage_bg_09.png"
},
	[2002]={ name="2-2", first_award=22001, begin_time={{2025,3,11},{5,0,0}}, jigsaw_list={
		[1]={ row=3, col=2 },
		[2]={ row=2, col=2 },
		[3]={ row=1, col=3 },
		[4]={ row=1, col=1 },
		[5]={ row=3, col=3 },
		[6]={ row=2, col=3 },
		[7]={ row=2, col=1 },
		[8]={ row=3, col=1 },
		[9]={ row=1, col=2 },
}, pre_id=2001, bg_img="putImage_bg_10.png"
},
	[2003]={ name="2-3", first_award=22001, begin_time={{2025,3,12},{5,0,0}}, jigsaw_list={
		[1]={ row=3, col=1 },
		[2]={ row=3, col=3 },
		[3]={ row=2, col=3 },
		[4]={ row=2, col=1 },
		[5]={ row=1, col=1 },
		[6]={ row=1, col=3 },
		[7]={ row=3, col=2 },
		[8]={ row=1, col=2 },
		[9]={ row=2, col=2 },
}, pre_id=2002, bg_img="putImage_bg_11.png"
},
	[2004]={ name="2-4", first_award=22001, begin_time={{2025,3,13},{5,0,0}}, jigsaw_list={
		[1]={ row=1, col=1 },
		[2]={ row=2, col=3 },
		[3]={ row=1, col=3 },
		[4]={ row=1, col=2 },
		[5]={ row=4, col=3 },
		[6]={ row=4, col=2 },
		[7]={ row=3, col=4 },
		[8]={ row=2, col=4 },
		[9]={ row=3, col=1 },
		[10]={ row=3, col=2 },
		[11]={ row=3, col=3 },
		[12]={ row=2, col=2 },
		[13]={ row=4, col=1 },
		[14]={ row=1, col=4 },
		[15]={ row=2, col=1 },
		[16]={ row=4, col=4 },
}, pre_id=2003, bg_img="putImage_bg_12.png"
},
	[2005]={ name="2-5", first_award=22001, begin_time={{2025,3,14},{5,0,0}}, jigsaw_list={
		[1]={ row=2, col=2 },
		[2]={ row=2, col=1 },
		[3]={ row=3, col=2 },
		[4]={ row=1, col=4 },
		[5]={ row=4, col=1 },
		[6]={ row=4, col=3 },
		[7]={ row=3, col=1 },
		[8]={ row=2, col=4 },
		[9]={ row=1, col=3 },
		[10]={ row=1, col=2 },
		[11]={ row=3, col=3 },
		[12]={ row=3, col=4 },
		[13]={ row=1, col=1 },
		[14]={ row=4, col=2 },
		[15]={ row=4, col=4 },
		[16]={ row=2, col=3 },
}, pre_id=2004, bg_img="putImage_bg_13.png"
},
	[2006]={ name="2-6", first_award=22001, begin_time={{2025,3,15},{5,0,0}}, jigsaw_list={
		[1]={ row=1, col=1 },
		[2]={ row=1, col=2 },
		[3]={ row=2, col=3 },
		[4]={ row=1, col=3 },
		[5]={ row=4, col=3 },
		[6]={ row=3, col=1 },
		[7]={ row=2, col=4 },
		[8]={ row=1, col=4 },
		[9]={ row=3, col=3 },
		[10]={ row=4, col=4 },
		[11]={ row=3, col=4 },
		[12]={ row=2, col=1 },
		[13]={ row=4, col=1 },
		[14]={ row=3, col=2 },
		[15]={ row=2, col=2 },
		[16]={ row=4, col=2 },
}, pre_id=2005, bg_img="putImage_bg_14.png"
},
	[2007]={ name="2-7", first_award=22001, begin_time={{2025,3,16},{5,0,0}}, jigsaw_list={
		[1]={ row=4, col=2 },
		[2]={ row=1, col=4 },
		[3]={ row=4, col=1 },
		[4]={ row=4, col=3 },
		[5]={ row=2, col=1 },
		[6]={ row=1, col=2 },
		[7]={ row=1, col=3 },
		[8]={ row=3, col=3 },
		[9]={ row=3, col=1 },
		[10]={ row=2, col=2 },
		[11]={ row=1, col=1 },
		[12]={ row=4, col=4 },
		[13]={ row=3, col=4 },
		[14]={ row=2, col=4 },
		[15]={ row=2, col=3 },
		[16]={ row=3, col=2 },
}, pre_id=2006, bg_img="putImage_bg_15.png"
},
	[2008]={ name="2-8", first_award=22001, begin_time={{2025,3,17},{5,0,0}}, jigsaw_list={
		[1]={ row=4, col=1 },
		[2]={ row=1, col=1 },
		[3]={ row=1, col=3 },
		[4]={ row=1, col=4 },
		[5]={ row=3, col=1 },
		[6]={ row=2, col=1 },
		[7]={ row=2, col=2 },
		[8]={ row=2, col=3 },
		[9]={ row=2, col=5 },
		[10]={ row=5, col=4 },
		[11]={ row=1, col=2 },
		[12]={ row=3, col=2 },
		[13]={ row=3, col=3 },
		[14]={ row=4, col=4 },
		[15]={ row=3, col=5 },
		[16]={ row=2, col=4 },
		[17]={ row=5, col=5 },
		[18]={ row=3, col=4 },
		[19]={ row=4, col=2 },
		[20]={ row=5, col=3 },
		[21]={ row=5, col=1 },
		[22]={ row=4, col=5 },
		[23]={ row=4, col=3 },
		[24]={ row=5, col=2 },
		[25]={ row=1, col=5 },
}, pre_id=2007, bg_img="putImage_bg_16.png"
},
	[3001]={ name="3-1", first_award=22001, begin_time={{2025,3,18},{5,0,0}}, jigsaw_list={
		[1]={ row=1, col=1 },
		[2]={ row=4, col=2 },
		[3]={ row=2, col=5 },
		[4]={ row=1, col=4 },
		[5]={ row=3, col=3 },
		[6]={ row=2, col=2 },
		[7]={ row=2, col=1 },
		[8]={ row=2, col=3 },
		[9]={ row=2, col=4 },
		[10]={ row=5, col=1 },
		[11]={ row=1, col=3 },
		[12]={ row=3, col=2 },
		[13]={ row=3, col=1 },
		[14]={ row=3, col=4 },
		[15]={ row=5, col=5 },
		[16]={ row=1, col=5 },
		[17]={ row=4, col=1 },
		[18]={ row=5, col=4 },
		[19]={ row=4, col=4 },
		[20]={ row=1, col=2 },
		[21]={ row=4, col=3 },
		[22]={ row=5, col=2 },
		[23]={ row=5, col=3 },
		[24]={ row=4, col=5 },
		[25]={ row=3, col=5 },
}, pre_id=2008, bg_img="putImage_bg_17.png"
},
	[3002]={ name="3-2", first_award=22001, begin_time={{2025,3,19},{5,0,0}}, jigsaw_list={
		[1]={ row=2, col=5 },
		[2]={ row=5, col=4 },
		[3]={ row=4, col=1 },
		[4]={ row=1, col=1 },
		[5]={ row=1, col=5 },
		[6]={ row=5, col=3 },
		[7]={ row=1, col=2 },
		[8]={ row=2, col=3 },
		[9]={ row=4, col=2 },
		[10]={ row=3, col=3 },
		[11]={ row=4, col=4 },
		[12]={ row=3, col=2 },
		[13]={ row=1, col=3 },
		[14]={ row=3, col=4 },
		[15]={ row=2, col=2 },
		[16]={ row=3, col=1 },
		[17]={ row=2, col=1 },
		[18]={ row=4, col=3 },
		[19]={ row=5, col=2 },
		[20]={ row=4, col=5 },
		[21]={ row=5, col=1 },
		[22]={ row=2, col=4 },
		[23]={ row=5, col=5 },
		[24]={ row=3, col=5 },
		[25]={ row=1, col=4 },
}, pre_id=3001, bg_img="putImage_bg_18.png"
},
	[3003]={ name="3-3", first_award=22001, begin_time={{2025,3,20},{5,0,0}}, jigsaw_list={
		[1]={ row=1, col=1 },
		[2]={ row=1, col=2 },
		[3]={ row=1, col=5 },
		[4]={ row=5, col=5 },
		[5]={ row=3, col=2 },
		[6]={ row=1, col=4 },
		[7]={ row=1, col=3 },
		[8]={ row=3, col=4 },
		[9]={ row=2, col=2 },
		[10]={ row=2, col=3 },
		[11]={ row=3, col=1 },
		[12]={ row=4, col=2 },
		[13]={ row=3, col=3 },
		[14]={ row=4, col=4 },
		[15]={ row=3, col=5 },
		[16]={ row=4, col=1 },
		[17]={ row=5, col=2 },
		[18]={ row=4, col=5 },
		[19]={ row=5, col=1 },
		[20]={ row=2, col=4 },
		[21]={ row=2, col=5 },
		[22]={ row=5, col=4 },
		[23]={ row=5, col=3 },
		[24]={ row=2, col=1 },
		[25]={ row=4, col=3 },
}, pre_id=3002, bg_img="putImage_bg_19.png"
},
	[3004]={ name="3-4", first_award=22001, begin_time={{2025,3,21},{5,0,0}}, jigsaw_list={
		[1]={ row=3, col=5 },
		[2]={ row=5, col=3 },
		[3]={ row=3, col=3 },
		[4]={ row=5, col=1 },
		[5]={ row=1, col=1 },
		[6]={ row=2, col=5 },
		[7]={ row=2, col=2 },
		[8]={ row=2, col=1 },
		[9]={ row=2, col=4 },
		[10]={ row=1, col=5 },
		[11]={ row=3, col=1 },
		[12]={ row=1, col=3 },
		[13]={ row=2, col=3 },
		[14]={ row=1, col=2 },
		[15]={ row=4, col=3 },
		[16]={ row=3, col=4 },
		[17]={ row=5, col=4 },
		[18]={ row=4, col=4 },
		[19]={ row=4, col=5 },
		[20]={ row=1, col=4 },
		[21]={ row=4, col=2 },
		[22]={ row=4, col=1 },
		[23]={ row=3, col=2 },
		[24]={ row=5, col=2 },
		[25]={ row=5, col=5 },
}, pre_id=3003, bg_img="putImage_bg_20.png"
},
	[3005]={ name="3-5", first_award=22001, begin_time={{2025,3,22},{5,0,0}}, jigsaw_list={
		[1]={ row=3, col=3 },
		[2]={ row=1, col=2 },
		[3]={ row=1, col=3 },
		[4]={ row=2, col=4 },
		[5]={ row=3, col=1 },
		[6]={ row=1, col=1 },
		[7]={ row=2, col=1 },
		[8]={ row=2, col=3 },
		[9]={ row=4, col=3 },
		[10]={ row=4, col=4 },
		[11]={ row=3, col=5 },
		[12]={ row=2, col=2 },
		[13]={ row=5, col=3 },
		[14]={ row=4, col=2 },
		[15]={ row=1, col=4 },
		[16]={ row=2, col=5 },
		[17]={ row=4, col=5 },
		[18]={ row=4, col=1 },
		[19]={ row=5, col=1 },
		[20]={ row=5, col=4 },
		[21]={ row=3, col=4 },
		[22]={ row=1, col=5 },
		[23]={ row=5, col=2 },
		[24]={ row=3, col=2 },
		[25]={ row=5, col=5 },
}, pre_id=3004, bg_img="putImage_bg_21.png"
},
	[3006]={ name="3-6", first_award=22001, begin_time={{2025,3,23},{5,0,0}}, jigsaw_list={
		[1]={ row=5, col=4 },
		[2]={ row=1, col=4 },
		[3]={ row=4, col=3 },
		[4]={ row=2, col=3 },
		[5]={ row=5, col=1 },
		[6]={ row=1, col=1 },
		[7]={ row=2, col=2 },
		[8]={ row=1, col=5 },
		[9]={ row=4, col=1 },
		[10]={ row=5, col=5 },
		[11]={ row=4, col=2 },
		[12]={ row=1, col=2 },
		[13]={ row=2, col=1 },
		[14]={ row=3, col=3 },
		[15]={ row=5, col=2 },
		[16]={ row=4, col=4 },
		[17]={ row=3, col=4 },
		[18]={ row=3, col=2 },
		[19]={ row=1, col=3 },
		[20]={ row=3, col=5 },
		[21]={ row=4, col=5 },
		[22]={ row=3, col=1 },
		[23]={ row=5, col=3 },
		[24]={ row=2, col=5 },
		[25]={ row=2, col=4 },
}, pre_id=3005, bg_img="putImage_bg_22.png"
},
	[3007]={ name="3-7", first_award=22001, begin_time={{2025,3,24},{5,0,0}}, jigsaw_list={
		[1]={ row=3, col=1 },
		[2]={ row=3, col=5 },
		[3]={ row=3, col=4 },
		[4]={ row=2, col=4 },
		[5]={ row=2, col=3 },
		[6]={ row=4, col=4 },
		[7]={ row=2, col=1 },
		[8]={ row=4, col=1 },
		[9]={ row=1, col=4 },
		[10]={ row=1, col=1 },
		[11]={ row=1, col=5 },
		[12]={ row=1, col=3 },
		[13]={ row=3, col=3 },
		[14]={ row=2, col=2 },
		[15]={ row=5, col=3 },
		[16]={ row=1, col=2 },
		[17]={ row=5, col=4 },
		[18]={ row=5, col=5 },
		[19]={ row=4, col=5 },
		[20]={ row=4, col=2 },
		[21]={ row=4, col=3 },
		[22]={ row=5, col=2 },
		[23]={ row=5, col=1 },
		[24]={ row=3, col=2 },
		[25]={ row=2, col=5 },
}, pre_id=3006, bg_img="putImage_bg_23.png"
},
	[3008]={ name="3-8", first_award=22001, begin_time={{2025,3,25},{5,0,0}}, jigsaw_list={
		[1]={ row=4, col=3 },
		[2]={ row=5, col=1 },
		[3]={ row=5, col=5 },
		[4]={ row=1, col=4 },
		[5]={ row=4, col=2 },
		[6]={ row=4, col=1 },
		[7]={ row=3, col=4 },
		[8]={ row=3, col=2 },
		[9]={ row=4, col=4 },
		[10]={ row=1, col=5 },
		[11]={ row=3, col=1 },
		[12]={ row=3, col=5 },
		[13]={ row=5, col=2 },
		[14]={ row=2, col=2 },
		[15]={ row=5, col=3 },
		[16]={ row=3, col=3 },
		[17]={ row=4, col=5 },
		[18]={ row=1, col=3 },
		[19]={ row=2, col=4 },
		[20]={ row=5, col=4 },
		[21]={ row=2, col=5 },
		[22]={ row=2, col=3 },
		[23]={ row=1, col=2 },
		[24]={ row=2, col=1 },
		[25]={ row=1, col=1 },
}, pre_id=3007, bg_img="putImage_bg_24.png"
}
}

return jigsaw_puzzle_data