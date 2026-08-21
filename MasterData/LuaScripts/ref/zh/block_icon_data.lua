-- from 179 六边形俄罗斯方块配置表.xlsx

local block_icon_data=

{
	[1]={ shape_list={{0,0}}, score=100, weight=100
},
	[2]={ shape_list={{0,0},{-1,1},{1,1},{1,-1}}, score=400, weight=50
},
	[3]={ shape_list={{0,0},{-1,0},{1,0},{-1,1}}, score=400, weight=50
},
	[4]={ shape_list={{0,0},{-1,0},{-1,-1},{1,1}}, score=400, weight=50
},
	[5]={ shape_list={{0,0},{-1,0},{1,0},{1,-1}}, score=400, weight=50
},
	[6]={ shape_list={{0,0},{-1,1},{1,1},{-1,-1}}, score=400, weight=50
},
	[7]={ shape_list={{0,0},{-1,0},{-1,1},{1,-1}}, score=400, weight=50
},
	[8]={ shape_list={{0,0},{-1,-1},{1,-1},{1,1}}, score=400, weight=50
},
	[9]={ shape_list={{0,0},{-1,0},{1,0},{1,1}}, score=400, weight=50
},
	[10]={ shape_list={{0,0},{-1,0},{1,0},{-1,-1}}, score=400, weight=50
},
	[11]={ shape_list={{1,1},{-1,1},{1,0},{1,-1}}, score=400, weight=50
},
	[12]={ shape_list={{-1,1},{-1,0},{1,1},{1,0}}, score=400, weight=50
},
	[13]={ shape_list={{-1,-1},{1,-1},{-1,0},{-1,1}}, score=400, weight=50
},
	[14]={ shape_list={{-1,-1},{-1,0},{1,-1},{1,0}}, score=400, weight=50
},
	[15]={ shape_list={{0,0},{-1,-1},{1,-1},{1,0}}, score=400, weight=100
},
	[16]={ shape_list={{0,0},{1,-1},{1,0},{2,-1}}, score=400, weight=100
},
	[17]={ shape_list={{0,0},{1,-1},{1,1},{1,0}}, score=400, weight=100
},
	[18]={ shape_list={{0,0},{1,1},{-1,-1},{-1,-2}}, score=400, weight=100
},
	[19]={ shape_list={{0,0},{-1,1},{1,-1},{1,-2}}, score=400, weight=100
},
	[20]={ shape_list={{0,0},{-1,0},{1,0},{2,0}}, score=400, weight=100
}
}

return block_icon_data