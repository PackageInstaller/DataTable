-- from 8000 角色展示配置表.xlsx

local role_showmode=

{
	[1]={ always="stand", action="goin", weapon=1, random_interval=0, random_actions={}, play_actions={}, is_play_cv=0, is_play_xz=0
},
	[10]={ always="showstand", action="showstandtime01", weapon=1, random_interval=1500, random_actions={"showstandtime01"}, play_actions={}, is_play_cv=0, is_play_xz=1
},
	[11]={ always="showidle", action="", weapon=0, random_interval=800, random_actions={"showidletime01","showidletime02","showidletime03"}, play_actions={}, is_play_cv=0, is_play_xz=0
},
	[12]={ always="showidle", action="", weapon=0, random_interval=800, random_actions={"showidletime01","showidletime02","showidletime03"}, play_actions={"showtime01", "showtime02", "showtime03"}, is_play_cv=1, is_play_xz=0
},
	[13]={ always="showidle", action="", weapon=0, random_interval=0, random_actions={}, play_actions={}, is_play_cv=0, is_play_xz=0
},
	[14]={ always="showidle", action="", weapon=0, random_interval=0, random_actions={}, play_actions={}, is_play_cv=0, is_play_xz=1
},
	[15]={ always="showidle", action="", weapon=0, random_interval=0, random_actions={}, play_actions={}, is_play_cv=0, is_play_xz=1
},
	[20]={ always="showstand", action="showstandtime01", weapon=1, random_interval=1500, random_actions={"showstandtime01"}, play_actions={}, is_play_cv=0, is_play_xz=1
},
	[21]={ always="showidle", action="", weapon=0, random_interval=0, random_actions={}, play_actions={}, is_play_cv=0, is_play_xz=1
},
	[30]={ always="showidle", action="", weapon=0, random_interval=800, random_actions={"showidletime01","showidletime02","showidletime03"}, play_actions={"showtime01", "showtime02", "showtime03", "showtime04"}, is_play_cv=1, is_play_xz=0
},
	[31]={ always="showidle", action="", weapon=0, random_interval=800, random_actions={}, play_actions={}, is_play_cv=0, is_play_xz=0
}
}

return role_showmode