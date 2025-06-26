-- from 124 战场环境配置表.xlsx

local pos_effect_data=

{
	[1]={ side=1, pos_list={1,2,3}, effect_list={8000,8000,8000}, background_list={"common_frm_11.png","common_frm_11.png","common_frm_11.png"}, effect_prefab_icon={"buff_zchj_2.prefab","buff_zchj_2.prefab","buff_zchj_2.prefab"}, effect_prefab_buff={"zchj_buff_zyl.prefab","zchj_buff_zyl.prefab","zchj_buff_zyl.prefab"}, icon_list={"zchj_2.png","zchj_2.png","zchj_2.png"}, row={1,2,3}, col={1,1,1}
},
	[2]={ side=2, pos_list={1,2,3}, effect_list={8000,8000,8000}, background_list={"common_frm_11.png","common_frm_11.png","common_frm_11.png"}, effect_prefab_icon={"buff_zchj_2.prefab","buff_zchj_2.prefab","buff_zchj_2.prefab"}, effect_prefab_buff={"zchj_buff_zyl.prefab","zchj_buff_zyl.prefab","zchj_buff_zyl.prefab"}, icon_list={"zchj_2.png","zchj_2.png","zchj_2.png"}, row={1,2,3}, col={1,1,1}
},
	[1000]={ side=1, pos_list={0}, effect_list={8000}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1001]={ side=1, pos_list={0}, effect_list={8001}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1002]={ side=1, pos_list={0}, effect_list={8002}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1003]={ side=1, pos_list={0}, effect_list={8003}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1004]={ side=1, pos_list={0}, effect_list={8004}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1005]={ side=1, pos_list={0}, effect_list={8005}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1006]={ side=1, pos_list={0}, effect_list={8006}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1007]={ side=1, pos_list={0}, effect_list={8007}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1008]={ side=1, pos_list={0}, effect_list={8008}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1009]={ side=1, pos_list={0}, effect_list={8009}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1010]={ side=1, pos_list={0}, effect_list={8010}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1011]={ side=1, pos_list={0}, effect_list={8011}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1012]={ side=1, pos_list={0}, effect_list={8012}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1013]={ side=1, pos_list={0}, effect_list={8013}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1014]={ side=1, pos_list={0}, effect_list={8014}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1015]={ side=1, pos_list={0}, effect_list={8015}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1016]={ side=1, pos_list={0}, effect_list={8016}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1017]={ side=1, pos_list={0}, effect_list={8017}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1018]={ side=1, pos_list={0}, effect_list={8018}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1019]={ side=1, pos_list={0}, effect_list={8019}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1040]={ side=2, pos_list={0}, effect_list={8040}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1041]={ side=1, pos_list={0}, effect_list={8041}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1042]={ side=1, pos_list={0}, effect_list={8042}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1043]={ side=1, pos_list={0}, effect_list={8043}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1044]={ side=2, pos_list={0}, effect_list={8044}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1045]={ side=1, pos_list={0}, effect_list={8045}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[1046]={ side=2, pos_list={0}, effect_list={8046}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1047]={ side=2, pos_list={0}, effect_list={8047}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1048]={ side=2, pos_list={0}, effect_list={8048}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1049]={ side=1, pos_list={0}, effect_list={8049}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1050]={ side=1, pos_list={0}, effect_list={8050}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1051]={ side=1, pos_list={0}, effect_list={8051}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1052]={ side=1, pos_list={0}, effect_list={8052}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1053]={ side=2, pos_list={0}, effect_list={8053}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1054]={ side=2, pos_list={0}, effect_list={8054}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1055]={ side=1, pos_list={0}, effect_list={8055}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1056]={ side=2, pos_list={0}, effect_list={8056}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1057]={ side=2, pos_list={0}, effect_list={8057}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1058]={ side=2, pos_list={0}, effect_list={8058}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1059]={ side=2, pos_list={0}, effect_list={8059}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[1060]={ side=2, pos_list={0}, effect_list={8060}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3001]={ side=2, pos_list={0}, effect_list={8101}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3002]={ side=2, pos_list={0}, effect_list={8102}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3003]={ side=2, pos_list={0}, effect_list={8103}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3004]={ side=2, pos_list={0}, effect_list={8104}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3005]={ side=2, pos_list={0}, effect_list={8105}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3006]={ side=2, pos_list={0}, effect_list={8106}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3007]={ side=2, pos_list={0}, effect_list={8107}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3008]={ side=2, pos_list={0}, effect_list={8108}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3009]={ side=2, pos_list={0}, effect_list={8109}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3010]={ side=2, pos_list={0}, effect_list={8110}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3011]={ side=2, pos_list={0}, effect_list={8111}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3048]={ side=1, pos_list={0}, effect_list={8148}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3049]={ side=1, pos_list={0}, effect_list={8149}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3050]={ side=1, pos_list={0}, effect_list={8150}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3051]={ side=1, pos_list={0}, effect_list={8151}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3061]={ side=1, pos_list={0}, effect_list={8161}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3062]={ side=2, pos_list={0}, effect_list={8162}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3063]={ side=2, pos_list={0}, effect_list={8163}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3064]={ side=1, pos_list={0}, effect_list={8164}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3065]={ side=2, pos_list={0}, effect_list={8165}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3066]={ side=1, pos_list={0}, effect_list={8166}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3067]={ side=2, pos_list={0}, effect_list={8167}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3068]={ side=1, pos_list={0}, effect_list={8168}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3069]={ side=2, pos_list={0}, effect_list={8169}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3070]={ side=2, pos_list={0}, effect_list={8170}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3071]={ side=2, pos_list={0}, effect_list={8171}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3072]={ side=2, pos_list={0}, effect_list={8172}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3073]={ side=2, pos_list={0}, effect_list={8173}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3074]={ side=2, pos_list={0}, effect_list={8174}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3075]={ side=2, pos_list={0}, effect_list={8175}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3076]={ side=2, pos_list={0}, effect_list={8176}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3077]={ side=2, pos_list={0}, effect_list={8177}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3078]={ side=2, pos_list={0}, effect_list={8178}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3079]={ side=2, pos_list={0}, effect_list={8179}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3080]={ side=2, pos_list={0}, effect_list={8180}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3081]={ side=2, pos_list={0}, effect_list={8181}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3082]={ side=2, pos_list={0}, effect_list={8182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3083]={ side=1, pos_list={0}, effect_list={8183}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3084]={ side=2, pos_list={0}, effect_list={8184}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3085]={ side=1, pos_list={0}, effect_list={8185}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3086]={ side=2, pos_list={0}, effect_list={8186}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3087]={ side=1, pos_list={0}, effect_list={8187}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3088]={ side=2, pos_list={0}, effect_list={8188}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3089]={ side=1, pos_list={0}, effect_list={8189}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3090]={ side=2, pos_list={0}, effect_list={8190}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3091]={ side=1, pos_list={0}, effect_list={8191}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3092]={ side=2, pos_list={0}, effect_list={8192}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3093]={ side=1, pos_list={0}, effect_list={8193}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3094]={ side=2, pos_list={0}, effect_list={8194}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30000]={ side=1, pos_list={0}, effect_list={14000}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30001]={ side=2, pos_list={0}, effect_list={14001}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30002]={ side=1, pos_list={0}, effect_list={14002}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30003]={ side=2, pos_list={0}, effect_list={14003}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30004]={ side=1, pos_list={0}, effect_list={14004}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30005]={ side=2, pos_list={0}, effect_list={14005}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30006]={ side=1, pos_list={0}, effect_list={14006}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30007]={ side=2, pos_list={0}, effect_list={14007}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30008]={ side=2, pos_list={0}, effect_list={14008}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30009]={ side=2, pos_list={0}, effect_list={14009}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30010]={ side=2, pos_list={0}, effect_list={14010}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30011]={ side=2, pos_list={0}, effect_list={14011}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30012]={ side=2, pos_list={0}, effect_list={14012}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30013]={ side=2, pos_list={0}, effect_list={14013}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30014]={ side=2, pos_list={0}, effect_list={14014}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[30015]={ side=2, pos_list={0}, effect_list={14015}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3101]={ side=2, pos_list={0}, effect_list={8451}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3102]={ side=2, pos_list={0}, effect_list={8452}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3103]={ side=2, pos_list={0}, effect_list={8453}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3104]={ side=2, pos_list={0}, effect_list={8454}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3105]={ side=2, pos_list={0}, effect_list={8455}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3106]={ side=2, pos_list={0}, effect_list={8456}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3111]={ side=2, pos_list={0}, effect_list={8112}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3112]={ side=2, pos_list={0}, effect_list={8113}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3113]={ side=2, pos_list={0}, effect_list={8114}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3114]={ side=2, pos_list={0}, effect_list={8115}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3115]={ side=2, pos_list={0}, effect_list={8116}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3116]={ side=2, pos_list={0}, effect_list={8117}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3117]={ side=2, pos_list={0}, effect_list={8118}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3118]={ side=2, pos_list={0}, effect_list={8119}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3119]={ side=2, pos_list={0}, effect_list={8120}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3120]={ side=2, pos_list={0}, effect_list={8121}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3121]={ side=2, pos_list={0}, effect_list={8122}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3122]={ side=2, pos_list={0}, effect_list={8123}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3123]={ side=2, pos_list={0}, effect_list={8124}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3124]={ side=2, pos_list={0}, effect_list={8125}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3125]={ side=2, pos_list={0}, effect_list={8126}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3126]={ side=2, pos_list={0}, effect_list={8127}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3131]={ side=1, pos_list={0}, effect_list={8128}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3132]={ side=1, pos_list={0}, effect_list={8129}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3133]={ side=1, pos_list={0}, effect_list={8130}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3134]={ side=1, pos_list={0}, effect_list={8131}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3135]={ side=1, pos_list={0}, effect_list={8132}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3136]={ side=1, pos_list={0}, effect_list={8133}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3137]={ side=1, pos_list={0}, effect_list={8134}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3138]={ side=1, pos_list={0}, effect_list={8135}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3139]={ side=1, pos_list={0}, effect_list={8136}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3140]={ side=1, pos_list={0}, effect_list={8137}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3141]={ side=1, pos_list={0}, effect_list={8138}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3142]={ side=1, pos_list={0}, effect_list={8139}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3143]={ side=1, pos_list={0}, effect_list={8140}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3144]={ side=1, pos_list={0}, effect_list={8141}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3145]={ side=1, pos_list={0}, effect_list={8142}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3146]={ side=1, pos_list={0}, effect_list={8143}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3147]={ side=1, pos_list={0}, effect_list={8144}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3148]={ side=1, pos_list={0}, effect_list={8145}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3149]={ side=1, pos_list={0}, effect_list={8146}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3150]={ side=1, pos_list={0}, effect_list={8147}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3151]={ side=1, pos_list={0}, effect_list={10006}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3152]={ side=1, pos_list={0}, effect_list={10007}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3153]={ side=1, pos_list={0}, effect_list={10008}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3154]={ side=1, pos_list={0}, effect_list={10009}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3201]={ side=2, pos_list={0}, effect_list={8601}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3202]={ side=2, pos_list={0}, effect_list={8602}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3203]={ side=2, pos_list={0}, effect_list={8603}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3204]={ side=2, pos_list={0}, effect_list={8604}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3205]={ side=2, pos_list={0}, effect_list={8605}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3206]={ side=2, pos_list={0}, effect_list={8606}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3207]={ side=2, pos_list={0}, effect_list={8607}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3208]={ side=2, pos_list={0}, effect_list={8608}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3209]={ side=2, pos_list={0}, effect_list={8609}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3210]={ side=2, pos_list={0}, effect_list={8610}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3211]={ side=2, pos_list={0}, effect_list={8611}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3212]={ side=2, pos_list={0}, effect_list={8612}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3213]={ side=2, pos_list={0}, effect_list={8613}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3214]={ side=2, pos_list={0}, effect_list={8614}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3215]={ side=2, pos_list={0}, effect_list={8615}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3216]={ side=2, pos_list={0}, effect_list={8616}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3217]={ side=2, pos_list={0}, effect_list={8617}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3218]={ side=2, pos_list={0}, effect_list={8618}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3219]={ side=2, pos_list={0}, effect_list={8619}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3220]={ side=2, pos_list={0}, effect_list={8620}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3221]={ side=2, pos_list={0}, effect_list={8621}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3222]={ side=2, pos_list={0}, effect_list={8622}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3223]={ side=2, pos_list={0}, effect_list={8623}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3224]={ side=2, pos_list={0}, effect_list={8624}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3225]={ side=2, pos_list={0}, effect_list={8625}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3226]={ side=2, pos_list={0}, effect_list={8626}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3227]={ side=2, pos_list={0}, effect_list={8627}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3228]={ side=2, pos_list={0}, effect_list={8628}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3229]={ side=2, pos_list={0}, effect_list={8629}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3230]={ side=2, pos_list={0}, effect_list={8630}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3231]={ side=2, pos_list={0}, effect_list={8631}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3232]={ side=2, pos_list={0}, effect_list={8632}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3233]={ side=2, pos_list={0}, effect_list={8633}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3234]={ side=2, pos_list={0}, effect_list={8634}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3235]={ side=2, pos_list={0}, effect_list={8635}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3236]={ side=2, pos_list={0}, effect_list={8636}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3237]={ side=2, pos_list={0}, effect_list={8637}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3238]={ side=2, pos_list={0}, effect_list={8638}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3239]={ side=2, pos_list={0}, effect_list={8639}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3240]={ side=2, pos_list={0}, effect_list={8640}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3241]={ side=2, pos_list={0}, effect_list={8641}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3242]={ side=2, pos_list={0}, effect_list={8642}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3243]={ side=2, pos_list={0}, effect_list={8643}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3244]={ side=2, pos_list={0}, effect_list={8644}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3245]={ side=2, pos_list={0}, effect_list={8645}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3246]={ side=2, pos_list={0}, effect_list={8646}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3247]={ side=2, pos_list={0}, effect_list={8647}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3248]={ side=2, pos_list={0}, effect_list={8648}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3249]={ side=2, pos_list={0}, effect_list={8649}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3250]={ side=2, pos_list={0}, effect_list={8650}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3251]={ side=2, pos_list={0}, effect_list={8651}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3252]={ side=2, pos_list={0}, effect_list={8652}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3253]={ side=2, pos_list={0}, effect_list={8653}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3254]={ side=2, pos_list={0}, effect_list={8654}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3255]={ side=2, pos_list={0}, effect_list={8655}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3256]={ side=2, pos_list={0}, effect_list={8656}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3257]={ side=2, pos_list={0}, effect_list={8657}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3258]={ side=2, pos_list={0}, effect_list={8658}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3259]={ side=2, pos_list={0}, effect_list={8659}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3260]={ side=2, pos_list={0}, effect_list={8660}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3261]={ side=1, pos_list={0}, effect_list={8661}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3301]={ side=1, pos_list={0}, effect_list={8551}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3302]={ side=1, pos_list={0}, effect_list={8552}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3303]={ side=2, pos_list={0}, effect_list={8553}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3304]={ side=2, pos_list={0}, effect_list={8554}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3305]={ side=2, pos_list={0}, effect_list={8555}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3306]={ side=2, pos_list={0}, effect_list={8556}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3307]={ side=2, pos_list={0}, effect_list={8557}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3308]={ side=2, pos_list={0}, effect_list={8558}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3401]={ side=2, pos_list={0}, effect_list={8201}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3402]={ side=2, pos_list={0}, effect_list={8202}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3403]={ side=2, pos_list={0}, effect_list={8203}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3404]={ side=2, pos_list={0}, effect_list={8204}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3405]={ side=2, pos_list={0}, effect_list={8205}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3406]={ side=2, pos_list={0}, effect_list={8206}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3407]={ side=2, pos_list={0}, effect_list={8207}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3408]={ side=2, pos_list={0}, effect_list={8208}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3409]={ side=1, pos_list={0}, effect_list={8209}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3410]={ side=1, pos_list={0}, effect_list={8210}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3411]={ side=1, pos_list={0}, effect_list={8211}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3412]={ side=1, pos_list={0}, effect_list={8212}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3413]={ side=1, pos_list={0}, effect_list={8213}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3414]={ side=1, pos_list={0}, effect_list={8214}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3415]={ side=1, pos_list={0}, effect_list={8215}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3416]={ side=2, pos_list={0}, effect_list={8216}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3421]={ side=1, pos_list={0}, effect_list={8221}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3422]={ side=1, pos_list={0}, effect_list={8222}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3423]={ side=1, pos_list={0}, effect_list={8223}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3424]={ side=1, pos_list={0}, effect_list={8224}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3425]={ side=1, pos_list={0}, effect_list={8225}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3426]={ side=1, pos_list={0}, effect_list={8226}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3427]={ side=1, pos_list={0}, effect_list={8227}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3428]={ side=1, pos_list={0}, effect_list={8228}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3429]={ side=1, pos_list={0}, effect_list={8229}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3430]={ side=2, pos_list={0}, effect_list={8230}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3431]={ side=2, pos_list={0}, effect_list={8231}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3432]={ side=2, pos_list={0}, effect_list={8232}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3433]={ side=2, pos_list={0}, effect_list={8233}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3434]={ side=2, pos_list={0}, effect_list={8234}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3435]={ side=2, pos_list={0}, effect_list={8235}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3436]={ side=2, pos_list={0}, effect_list={8236}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3437]={ side=2, pos_list={0}, effect_list={8237}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3438]={ side=2, pos_list={0}, effect_list={8238}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3439]={ side=1, pos_list={0}, effect_list={8239}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3440]={ side=2, pos_list={0}, effect_list={8240}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3441]={ side=2, pos_list={0}, effect_list={8241}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3442]={ side=1, pos_list={0}, effect_list={8242}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_18.png"}, row={0}, col={0}
},
	[3443]={ side=2, pos_list={0}, effect_list={8243}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3444]={ side=2, pos_list={0}, effect_list={8244}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3445]={ side=2, pos_list={0}, effect_list={8245}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3446]={ side=2, pos_list={0}, effect_list={8246}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3447]={ side=2, pos_list={0}, effect_list={8247}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3448]={ side=1, pos_list={0}, effect_list={8248}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3449]={ side=1, pos_list={0}, effect_list={8249}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3450]={ side=1, pos_list={0}, effect_list={8250}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3451]={ side=1, pos_list={0}, effect_list={8251}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3452]={ side=1, pos_list={0}, effect_list={8252}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3453]={ side=1, pos_list={0}, effect_list={8253}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3454]={ side=1, pos_list={0}, effect_list={8254}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3455]={ side=1, pos_list={0}, effect_list={8255}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3456]={ side=2, pos_list={0}, effect_list={8256}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3457]={ side=2, pos_list={0}, effect_list={8257}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3458]={ side=2, pos_list={0}, effect_list={8258}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3459]={ side=2, pos_list={0}, effect_list={8259}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3460]={ side=2, pos_list={0}, effect_list={8260}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3461]={ side=2, pos_list={0}, effect_list={8261}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3462]={ side=2, pos_list={0}, effect_list={8262}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3463]={ side=2, pos_list={0}, effect_list={8263}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3464]={ side=2, pos_list={0}, effect_list={8264}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3465]={ side=2, pos_list={0}, effect_list={8265}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3466]={ side=2, pos_list={0}, effect_list={8266}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3467]={ side=2, pos_list={0}, effect_list={8267}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3468]={ side=2, pos_list={0}, effect_list={8268}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3469]={ side=2, pos_list={0}, effect_list={8269}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3470]={ side=2, pos_list={0}, effect_list={8270}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3471]={ side=1, pos_list={0}, effect_list={8271}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3472]={ side=2, pos_list={0}, effect_list={8272}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3473]={ side=2, pos_list={0}, effect_list={8273}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3474]={ side=2, pos_list={0}, effect_list={8274}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3475]={ side=2, pos_list={0}, effect_list={8275}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3476]={ side=2, pos_list={0}, effect_list={8276}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3477]={ side=1, pos_list={0}, effect_list={8277}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3481]={ side=2, pos_list={0}, effect_list={8081}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3482]={ side=2, pos_list={0}, effect_list={8082}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3483]={ side=2, pos_list={0}, effect_list={8083}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3484]={ side=2, pos_list={0}, effect_list={8084}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3485]={ side=2, pos_list={0}, effect_list={8085}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3486]={ side=1, pos_list={0}, effect_list={8086}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3487]={ side=1, pos_list={0}, effect_list={8087}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3488]={ side=1, pos_list={0}, effect_list={8088}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3489]={ side=1, pos_list={0}, effect_list={8089}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3490]={ side=1, pos_list={0}, effect_list={8090}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3491]={ side=1, pos_list={0}, effect_list={8091}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3492]={ side=1, pos_list={0}, effect_list={8092}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3493]={ side=1, pos_list={0}, effect_list={8093}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3494]={ side=2, pos_list={0}, effect_list={8094}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3495]={ side=2, pos_list={0}, effect_list={8095}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3496]={ side=1, pos_list={0}, effect_list={8096}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3497]={ side=2, pos_list={0}, effect_list={8097}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3498]={ side=1, pos_list={0}, effect_list={8098}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3499]={ side=2, pos_list={0}, effect_list={8099}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3500]={ side=2, pos_list={0}, effect_list={8100}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3501]={ side=2, pos_list={0}, effect_list={25000}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3801]={ side=1, pos_list={0}, effect_list={8701}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3802]={ side=1, pos_list={0}, effect_list={8702}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3803]={ side=1, pos_list={0}, effect_list={8703}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3804]={ side=1, pos_list={0}, effect_list={8704}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3805]={ side=1, pos_list={0}, effect_list={8705}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3806]={ side=1, pos_list={0}, effect_list={8706}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3807]={ side=1, pos_list={0}, effect_list={8707}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3808]={ side=1, pos_list={0}, effect_list={8708}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3809]={ side=1, pos_list={0}, effect_list={8709}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3810]={ side=1, pos_list={0}, effect_list={8710}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3811]={ side=1, pos_list={0}, effect_list={8711}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3812]={ side=1, pos_list={0}, effect_list={8712}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3813]={ side=1, pos_list={0}, effect_list={8713}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3814]={ side=1, pos_list={0}, effect_list={8714}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3815]={ side=1, pos_list={0}, effect_list={8715}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3816]={ side=1, pos_list={0}, effect_list={8716}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3817]={ side=1, pos_list={0}, effect_list={8717}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3818]={ side=1, pos_list={0}, effect_list={8718}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3819]={ side=1, pos_list={0}, effect_list={8719}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3820]={ side=1, pos_list={0}, effect_list={8720}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3821]={ side=1, pos_list={0}, effect_list={8721}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3822]={ side=1, pos_list={0}, effect_list={8722}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3823]={ side=1, pos_list={0}, effect_list={8723}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3824]={ side=1, pos_list={0}, effect_list={8724}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3825]={ side=1, pos_list={0}, effect_list={8725}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3826]={ side=1, pos_list={0}, effect_list={8726}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3827]={ side=1, pos_list={0}, effect_list={8727}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3828]={ side=1, pos_list={0}, effect_list={8728}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3829]={ side=1, pos_list={0}, effect_list={8729}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3830]={ side=1, pos_list={0}, effect_list={8730}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3831]={ side=1, pos_list={0}, effect_list={8731}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3832]={ side=1, pos_list={0}, effect_list={8732}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3833]={ side=1, pos_list={0}, effect_list={8733}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3834]={ side=1, pos_list={0}, effect_list={8734}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3835]={ side=1, pos_list={0}, effect_list={8735}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3836]={ side=1, pos_list={0}, effect_list={8736}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3837]={ side=1, pos_list={0}, effect_list={8737}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3838]={ side=1, pos_list={0}, effect_list={8738}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3839]={ side=1, pos_list={0}, effect_list={8739}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3840]={ side=1, pos_list={0}, effect_list={8740}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3841]={ side=1, pos_list={0}, effect_list={8741}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3842]={ side=1, pos_list={0}, effect_list={8742}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3843]={ side=1, pos_list={0}, effect_list={8743}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3844]={ side=1, pos_list={0}, effect_list={8744}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3845]={ side=1, pos_list={0}, effect_list={8745}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3846]={ side=1, pos_list={0}, effect_list={8746}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3847]={ side=1, pos_list={0}, effect_list={8747}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3848]={ side=1, pos_list={0}, effect_list={8748}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3849]={ side=1, pos_list={0}, effect_list={8749}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3850]={ side=1, pos_list={0}, effect_list={8750}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3851]={ side=1, pos_list={0}, effect_list={8751}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3852]={ side=2, pos_list={0}, effect_list={8752}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3853]={ side=2, pos_list={0}, effect_list={8753}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3854]={ side=2, pos_list={0}, effect_list={8754}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3855]={ side=1, pos_list={0}, effect_list={8755}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3856]={ side=1, pos_list={0}, effect_list={8756}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3857]={ side=1, pos_list={0}, effect_list={8757}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3858]={ side=1, pos_list={0}, effect_list={8758}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3859]={ side=1, pos_list={0}, effect_list={8759}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3860]={ side=1, pos_list={0}, effect_list={8760}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3861]={ side=1, pos_list={0}, effect_list={8761}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3862]={ side=1, pos_list={0}, effect_list={8762}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3863]={ side=1, pos_list={0}, effect_list={8763}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3864]={ side=1, pos_list={0}, effect_list={8764}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3865]={ side=2, pos_list={0}, effect_list={8765}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3866]={ side=2, pos_list={0}, effect_list={8766}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3867]={ side=2, pos_list={0}, effect_list={8767}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3868]={ side=2, pos_list={0}, effect_list={8768}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3869]={ side=2, pos_list={0}, effect_list={8769}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3870]={ side=2, pos_list={0}, effect_list={8770}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3871]={ side=2, pos_list={0}, effect_list={8771}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3872]={ side=2, pos_list={0}, effect_list={8772}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3873]={ side=2, pos_list={0}, effect_list={8773}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3874]={ side=2, pos_list={0}, effect_list={8774}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3875]={ side=2, pos_list={0}, effect_list={8775}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3876]={ side=2, pos_list={0}, effect_list={8776}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3877]={ side=2, pos_list={0}, effect_list={8777}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3878]={ side=2, pos_list={0}, effect_list={8778}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3879]={ side=2, pos_list={0}, effect_list={8779}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3880]={ side=2, pos_list={0}, effect_list={8780}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3881]={ side=2, pos_list={0}, effect_list={8781}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3882]={ side=2, pos_list={0}, effect_list={8782}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3883]={ side=2, pos_list={0}, effect_list={8783}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3884]={ side=2, pos_list={0}, effect_list={8784}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3885]={ side=2, pos_list={0}, effect_list={8785}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3886]={ side=2, pos_list={0}, effect_list={8786}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3887]={ side=2, pos_list={0}, effect_list={8787}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3888]={ side=2, pos_list={0}, effect_list={8788}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3889]={ side=2, pos_list={0}, effect_list={8789}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3890]={ side=2, pos_list={0}, effect_list={8790}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3891]={ side=2, pos_list={0}, effect_list={8791}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3892]={ side=2, pos_list={0}, effect_list={8792}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3893]={ side=2, pos_list={0}, effect_list={8793}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3894]={ side=2, pos_list={0}, effect_list={8794}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3895]={ side=2, pos_list={0}, effect_list={8795}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3896]={ side=2, pos_list={0}, effect_list={8796}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3897]={ side=2, pos_list={0}, effect_list={8797}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3898]={ side=2, pos_list={0}, effect_list={8798}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3899]={ side=2, pos_list={0}, effect_list={8799}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3900]={ side=2, pos_list={0}, effect_list={8800}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3901]={ side=2, pos_list={0}, effect_list={8801}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3902]={ side=2, pos_list={0}, effect_list={8802}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3903]={ side=2, pos_list={0}, effect_list={8803}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3904]={ side=2, pos_list={0}, effect_list={8804}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3905]={ side=2, pos_list={0}, effect_list={8805}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3906]={ side=2, pos_list={0}, effect_list={8806}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3907]={ side=2, pos_list={0}, effect_list={8807}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3908]={ side=2, pos_list={0}, effect_list={8808}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3909]={ side=2, pos_list={0}, effect_list={8809}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3910]={ side=2, pos_list={0}, effect_list={8810}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3911]={ side=2, pos_list={0}, effect_list={8811}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3912]={ side=2, pos_list={0}, effect_list={8812}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3913]={ side=2, pos_list={0}, effect_list={8813}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3914]={ side=2, pos_list={0}, effect_list={8814}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3915]={ side=2, pos_list={0}, effect_list={8815}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3916]={ side=2, pos_list={0}, effect_list={8816}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3917]={ side=2, pos_list={0}, effect_list={8817}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3918]={ side=2, pos_list={0}, effect_list={8818}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3919]={ side=2, pos_list={0}, effect_list={8819}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3920]={ side=2, pos_list={0}, effect_list={8820}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3921]={ side=2, pos_list={0}, effect_list={8821}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3922]={ side=2, pos_list={0}, effect_list={8822}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3923]={ side=2, pos_list={0}, effect_list={8823}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3924]={ side=2, pos_list={0}, effect_list={8824}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3925]={ side=2, pos_list={0}, effect_list={8825}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3926]={ side=2, pos_list={0}, effect_list={8826}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3927]={ side=2, pos_list={0}, effect_list={8827}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3928]={ side=2, pos_list={0}, effect_list={8828}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3929]={ side=2, pos_list={0}, effect_list={8829}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3930]={ side=2, pos_list={0}, effect_list={8830}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3931]={ side=2, pos_list={0}, effect_list={8831}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3932]={ side=2, pos_list={0}, effect_list={8832}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3933]={ side=2, pos_list={0}, effect_list={8833}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3934]={ side=2, pos_list={0}, effect_list={8834}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3935]={ side=2, pos_list={0}, effect_list={8835}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3936]={ side=2, pos_list={0}, effect_list={8836}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3937]={ side=2, pos_list={0}, effect_list={8837}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3938]={ side=2, pos_list={0}, effect_list={8838}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3939]={ side=2, pos_list={0}, effect_list={8839}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3940]={ side=2, pos_list={0}, effect_list={8840}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3941]={ side=2, pos_list={0}, effect_list={8841}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3942]={ side=2, pos_list={0}, effect_list={8842}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3943]={ side=2, pos_list={0}, effect_list={8843}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3944]={ side=2, pos_list={0}, effect_list={8844}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3945]={ side=2, pos_list={0}, effect_list={8845}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3946]={ side=2, pos_list={0}, effect_list={8846}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3947]={ side=2, pos_list={0}, effect_list={8847}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[3948]={ side=2, pos_list={0}, effect_list={8848}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4001]={ side=2, pos_list={0}, effect_list={8351}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4002]={ side=2, pos_list={0}, effect_list={8352}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4003]={ side=2, pos_list={0}, effect_list={8353}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4004]={ side=2, pos_list={0}, effect_list={8354}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4005]={ side=2, pos_list={0}, effect_list={8355}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4006]={ side=2, pos_list={0}, effect_list={8356}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4007]={ side=2, pos_list={0}, effect_list={8357}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4008]={ side=2, pos_list={0}, effect_list={8358}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4009]={ side=2, pos_list={0}, effect_list={8359}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4010]={ side=2, pos_list={0}, effect_list={8360}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2001]={ side=2, pos_list={0}, effect_list={8401}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2002]={ side=2, pos_list={0}, effect_list={8402}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2003]={ side=2, pos_list={0}, effect_list={8403}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2004]={ side=2, pos_list={0}, effect_list={8404}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2005]={ side=2, pos_list={0}, effect_list={8405}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2006]={ side=2, pos_list={0}, effect_list={8406}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2007]={ side=2, pos_list={0}, effect_list={8407}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2008]={ side=2, pos_list={0}, effect_list={8408}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2009]={ side=2, pos_list={0}, effect_list={8409}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2010]={ side=2, pos_list={0}, effect_list={8410}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2011]={ side=2, pos_list={0}, effect_list={8411}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2501]={ side=1, pos_list={0}, effect_list={8501}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2502]={ side=1, pos_list={0}, effect_list={8502}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2503]={ side=1, pos_list={0}, effect_list={8503}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2504]={ side=1, pos_list={0}, effect_list={8504}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2505]={ side=1, pos_list={0}, effect_list={8505}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2506]={ side=1, pos_list={0}, effect_list={8506}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2507]={ side=1, pos_list={0}, effect_list={8507}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2600]={ side=2, pos_list={0}, effect_list={501182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2601]={ side=2, pos_list={0}, effect_list={502192}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2602]={ side=2, pos_list={0}, effect_list={503192}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2603]={ side=2, pos_list={0}, effect_list={505182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2604]={ side=2, pos_list={0}, effect_list={506182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2605]={ side=2, pos_list={0}, effect_list={506196}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2606]={ side=2, pos_list={0}, effect_list={507182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2607]={ side=2, pos_list={0}, effect_list={507192}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2608]={ side=2, pos_list={0}, effect_list={508182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2609]={ side=2, pos_list={0}, effect_list={508192}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2610]={ side=2, pos_list={0}, effect_list={509182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2611]={ side=2, pos_list={0}, effect_list={510182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2612]={ side=2, pos_list={0}, effect_list={505192}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2613]={ side=2, pos_list={0}, effect_list={513182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2614]={ side=2, pos_list={0}, effect_list={513192}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2615]={ side=2, pos_list={0}, effect_list={511182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2616]={ side=2, pos_list={0}, effect_list={5162911}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[2617]={ side=2, pos_list={0}, effect_list={511192}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4100]={ side=2, pos_list={0}, effect_list={8900}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4101]={ side=2, pos_list={0}, effect_list={8901}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4102]={ side=2, pos_list={0}, effect_list={8902}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4103]={ side=2, pos_list={0}, effect_list={8903}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4104]={ side=2, pos_list={0}, effect_list={8904}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4105]={ side=2, pos_list={0}, effect_list={8905}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4106]={ side=2, pos_list={0}, effect_list={8906}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4107]={ side=2, pos_list={0}, effect_list={8907}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4108]={ side=2, pos_list={0}, effect_list={8908}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4109]={ side=2, pos_list={0}, effect_list={8909}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4110]={ side=2, pos_list={0}, effect_list={8910}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4111]={ side=2, pos_list={0}, effect_list={8911}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4112]={ side=2, pos_list={0}, effect_list={8912}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4113]={ side=2, pos_list={0}, effect_list={8913}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4114]={ side=2, pos_list={0}, effect_list={8914}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4115]={ side=2, pos_list={0}, effect_list={8915}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4116]={ side=2, pos_list={0}, effect_list={8916}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4117]={ side=2, pos_list={0}, effect_list={8917}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4118]={ side=2, pos_list={0}, effect_list={8918}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4119]={ side=2, pos_list={0}, effect_list={8919}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4120]={ side=2, pos_list={0}, effect_list={8920}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4121]={ side=2, pos_list={0}, effect_list={8921}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4122]={ side=2, pos_list={0}, effect_list={8922}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4123]={ side=2, pos_list={0}, effect_list={8923}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4124]={ side=2, pos_list={0}, effect_list={8924}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4125]={ side=2, pos_list={0}, effect_list={8925}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4126]={ side=2, pos_list={0}, effect_list={8926}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4127]={ side=2, pos_list={0}, effect_list={8927}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4128]={ side=2, pos_list={0}, effect_list={8928}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4129]={ side=2, pos_list={0}, effect_list={8929}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4130]={ side=2, pos_list={0}, effect_list={8930}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4131]={ side=2, pos_list={0}, effect_list={8931}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4132]={ side=2, pos_list={0}, effect_list={8932}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4133]={ side=2, pos_list={0}, effect_list={8933}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4134]={ side=2, pos_list={0}, effect_list={8934}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4135]={ side=2, pos_list={0}, effect_list={8935}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4136]={ side=2, pos_list={0}, effect_list={8936}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4137]={ side=2, pos_list={0}, effect_list={8937}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4138]={ side=2, pos_list={0}, effect_list={8938}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4139]={ side=2, pos_list={0}, effect_list={8939}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4140]={ side=2, pos_list={0}, effect_list={8940}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4141]={ side=2, pos_list={0}, effect_list={8941}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4142]={ side=2, pos_list={0}, effect_list={8942}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4143]={ side=2, pos_list={0}, effect_list={8943}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4144]={ side=2, pos_list={0}, effect_list={8944}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4145]={ side=2, pos_list={0}, effect_list={8945}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4146]={ side=2, pos_list={0}, effect_list={8946}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4147]={ side=2, pos_list={0}, effect_list={8947}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4148]={ side=2, pos_list={0}, effect_list={8948}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4149]={ side=2, pos_list={0}, effect_list={8949}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4150]={ side=2, pos_list={0}, effect_list={8950}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4151]={ side=2, pos_list={0}, effect_list={8951}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4184]={ side=2, pos_list={0}, effect_list={8953}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4222]={ side=2, pos_list={0}, effect_list={8955}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4223]={ side=2, pos_list={0}, effect_list={8957}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4224]={ side=1, pos_list={0}, effect_list={8959}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4152]={ side=1, pos_list={0}, effect_list={19000}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4153]={ side=1, pos_list={0}, effect_list={19001}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4154]={ side=1, pos_list={0}, effect_list={19002}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4155]={ side=1, pos_list={0}, effect_list={19003}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4156]={ side=1, pos_list={0}, effect_list={19004}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4157]={ side=1, pos_list={0}, effect_list={19005}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4158]={ side=1, pos_list={0}, effect_list={19006}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4159]={ side=1, pos_list={0}, effect_list={19007}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4160]={ side=1, pos_list={0}, effect_list={19008}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4161]={ side=2, pos_list={0}, effect_list={19009}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4162]={ side=2, pos_list={0}, effect_list={19010}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4163]={ side=2, pos_list={0}, effect_list={19011}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4164]={ side=2, pos_list={0}, effect_list={19012}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4165]={ side=2, pos_list={0}, effect_list={19013}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4166]={ side=2, pos_list={0}, effect_list={19014}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4167]={ side=2, pos_list={0}, effect_list={19015}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4168]={ side=2, pos_list={0}, effect_list={19016}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4169]={ side=2, pos_list={0}, effect_list={19017}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4170]={ side=2, pos_list={0}, effect_list={19018}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4171]={ side=2, pos_list={0}, effect_list={19019}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4172]={ side=2, pos_list={0}, effect_list={19020}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4173]={ side=2, pos_list={0}, effect_list={19021}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4174]={ side=2, pos_list={0}, effect_list={19022}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4175]={ side=2, pos_list={0}, effect_list={19023}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4176]={ side=2, pos_list={0}, effect_list={19024}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4177]={ side=2, pos_list={0}, effect_list={19025}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4178]={ side=2, pos_list={0}, effect_list={19026}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4179]={ side=2, pos_list={0}, effect_list={19027}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4180]={ side=2, pos_list={0}, effect_list={19028}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4181]={ side=2, pos_list={0}, effect_list={19029}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4182]={ side=2, pos_list={0}, effect_list={19030}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4183]={ side=2, pos_list={0}, effect_list={19031}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4185]={ side=1, pos_list={0}, effect_list={19032}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4186]={ side=1, pos_list={0}, effect_list={19033}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4187]={ side=1, pos_list={0}, effect_list={19034}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4188]={ side=1, pos_list={0}, effect_list={19035}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4189]={ side=1, pos_list={0}, effect_list={19036}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4190]={ side=1, pos_list={0}, effect_list={19037}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4191]={ side=1, pos_list={0}, effect_list={19038}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4192]={ side=1, pos_list={0}, effect_list={19039}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4193]={ side=2, pos_list={0}, effect_list={19040}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4194]={ side=2, pos_list={0}, effect_list={19041}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4195]={ side=2, pos_list={0}, effect_list={19042}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4196]={ side=2, pos_list={0}, effect_list={19043}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4197]={ side=2, pos_list={0}, effect_list={19044}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4198]={ side=2, pos_list={0}, effect_list={19045}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4199]={ side=2, pos_list={0}, effect_list={19046}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4200]={ side=2, pos_list={0}, effect_list={19047}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4201]={ side=2, pos_list={0}, effect_list={19048}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4202]={ side=2, pos_list={0}, effect_list={19049}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4203]={ side=2, pos_list={0}, effect_list={19050}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4204]={ side=2, pos_list={0}, effect_list={19051}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4205]={ side=2, pos_list={0}, effect_list={19052}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4206]={ side=2, pos_list={0}, effect_list={19053}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4207]={ side=2, pos_list={0}, effect_list={19054}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4208]={ side=2, pos_list={0}, effect_list={19055}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4209]={ side=2, pos_list={0}, effect_list={19056}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4210]={ side=2, pos_list={0}, effect_list={19057}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4211]={ side=2, pos_list={0}, effect_list={19058}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4212]={ side=2, pos_list={0}, effect_list={19059}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4213]={ side=2, pos_list={0}, effect_list={19060}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4214]={ side=2, pos_list={0}, effect_list={19061}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4221]={ side=2, pos_list={0}, effect_list={19062}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4225]={ side=1, pos_list={0}, effect_list={19063}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4226]={ side=1, pos_list={0}, effect_list={19064}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4227]={ side=1, pos_list={0}, effect_list={19065}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4228]={ side=1, pos_list={0}, effect_list={19066}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4229]={ side=1, pos_list={0}, effect_list={19067}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4230]={ side=1, pos_list={0}, effect_list={19068}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4231]={ side=1, pos_list={0}, effect_list={19069}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4232]={ side=1, pos_list={0}, effect_list={19070}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4233]={ side=1, pos_list={0}, effect_list={19071}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4234]={ side=2, pos_list={0}, effect_list={19072}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4235]={ side=2, pos_list={0}, effect_list={19073}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4236]={ side=2, pos_list={0}, effect_list={19074}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4237]={ side=2, pos_list={0}, effect_list={19075}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4238]={ side=2, pos_list={0}, effect_list={19076}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4239]={ side=2, pos_list={0}, effect_list={19077}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4240]={ side=2, pos_list={0}, effect_list={19078}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4241]={ side=2, pos_list={0}, effect_list={19079}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4242]={ side=2, pos_list={0}, effect_list={19080}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4243]={ side=2, pos_list={0}, effect_list={19081}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4244]={ side=2, pos_list={0}, effect_list={19082}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4245]={ side=2, pos_list={0}, effect_list={19083}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4246]={ side=2, pos_list={0}, effect_list={19084}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4247]={ side=2, pos_list={0}, effect_list={19085}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4248]={ side=2, pos_list={0}, effect_list={19086}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4249]={ side=2, pos_list={0}, effect_list={19087}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4250]={ side=2, pos_list={0}, effect_list={19088}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4251]={ side=2, pos_list={0}, effect_list={19089}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4252]={ side=2, pos_list={0}, effect_list={19090}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4253]={ side=2, pos_list={0}, effect_list={19091}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4254]={ side=2, pos_list={0}, effect_list={19092}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4255]={ side=2, pos_list={0}, effect_list={19093}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4256]={ side=1, pos_list={0}, effect_list={19094}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4257]={ side=1, pos_list={0}, effect_list={19095}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4258]={ side=1, pos_list={0}, effect_list={19096}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4259]={ side=1, pos_list={0}, effect_list={19097}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4260]={ side=1, pos_list={0}, effect_list={19098}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4261]={ side=1, pos_list={0}, effect_list={19099}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4262]={ side=1, pos_list={0}, effect_list={19100}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4263]={ side=1, pos_list={0}, effect_list={19101}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4264]={ side=1, pos_list={0}, effect_list={19102}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4265]={ side=2, pos_list={0}, effect_list={19103}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4266]={ side=2, pos_list={0}, effect_list={19104}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4267]={ side=2, pos_list={0}, effect_list={19105}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4268]={ side=2, pos_list={0}, effect_list={19106}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4269]={ side=2, pos_list={0}, effect_list={19107}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4270]={ side=2, pos_list={0}, effect_list={19108}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4271]={ side=2, pos_list={0}, effect_list={19109}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4272]={ side=2, pos_list={0}, effect_list={19110}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4273]={ side=2, pos_list={0}, effect_list={19111}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4274]={ side=2, pos_list={0}, effect_list={19112}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4275]={ side=2, pos_list={0}, effect_list={19113}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4276]={ side=2, pos_list={0}, effect_list={19114}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4277]={ side=2, pos_list={0}, effect_list={19115}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4278]={ side=2, pos_list={0}, effect_list={19116}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4279]={ side=2, pos_list={0}, effect_list={19117}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4280]={ side=2, pos_list={0}, effect_list={19118}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4281]={ side=2, pos_list={0}, effect_list={19119}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4282]={ side=2, pos_list={0}, effect_list={19120}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4283]={ side=2, pos_list={0}, effect_list={19121}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4284]={ side=2, pos_list={0}, effect_list={19122}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4285]={ side=2, pos_list={0}, effect_list={19123}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4286]={ side=2, pos_list={0}, effect_list={19124}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4287]={ side=2, pos_list={0}, effect_list={19125}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4288]={ side=1, pos_list={0}, effect_list={19126}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4289]={ side=1, pos_list={0}, effect_list={19127}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4290]={ side=1, pos_list={0}, effect_list={19128}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4291]={ side=1, pos_list={0}, effect_list={19129}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4292]={ side=1, pos_list={0}, effect_list={19130}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4293]={ side=1, pos_list={0}, effect_list={19131}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4294]={ side=1, pos_list={0}, effect_list={19132}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4295]={ side=1, pos_list={0}, effect_list={19133}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4296]={ side=1, pos_list={0}, effect_list={19134}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4297]={ side=2, pos_list={0}, effect_list={19135}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4298]={ side=2, pos_list={0}, effect_list={19136}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4299]={ side=2, pos_list={0}, effect_list={19137}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4300]={ side=2, pos_list={0}, effect_list={19138}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4301]={ side=2, pos_list={0}, effect_list={19139}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4302]={ side=2, pos_list={0}, effect_list={19140}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4303]={ side=2, pos_list={0}, effect_list={19141}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4304]={ side=2, pos_list={0}, effect_list={19142}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4305]={ side=2, pos_list={0}, effect_list={19143}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4306]={ side=2, pos_list={0}, effect_list={19144}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4307]={ side=2, pos_list={0}, effect_list={19145}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4308]={ side=2, pos_list={0}, effect_list={19146}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4309]={ side=2, pos_list={0}, effect_list={19147}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4310]={ side=2, pos_list={0}, effect_list={19148}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4311]={ side=2, pos_list={0}, effect_list={19149}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4312]={ side=2, pos_list={0}, effect_list={19150}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4313]={ side=2, pos_list={0}, effect_list={19151}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4314]={ side=2, pos_list={0}, effect_list={19152}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4315]={ side=2, pos_list={0}, effect_list={19153}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4316]={ side=2, pos_list={0}, effect_list={19154}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4317]={ side=2, pos_list={0}, effect_list={19155}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4318]={ side=2, pos_list={0}, effect_list={19156}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4319]={ side=1, pos_list={0}, effect_list={19157}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4320]={ side=1, pos_list={0}, effect_list={19158}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4321]={ side=1, pos_list={0}, effect_list={19159}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4322]={ side=1, pos_list={0}, effect_list={19160}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4323]={ side=1, pos_list={0}, effect_list={19161}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4324]={ side=1, pos_list={0}, effect_list={19162}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4325]={ side=1, pos_list={0}, effect_list={19163}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4326]={ side=1, pos_list={0}, effect_list={19164}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4327]={ side=1, pos_list={0}, effect_list={19165}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4328]={ side=2, pos_list={0}, effect_list={19166}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4329]={ side=2, pos_list={0}, effect_list={19167}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4330]={ side=2, pos_list={0}, effect_list={19168}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4331]={ side=2, pos_list={0}, effect_list={19169}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4332]={ side=2, pos_list={0}, effect_list={19170}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4333]={ side=2, pos_list={0}, effect_list={19171}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4334]={ side=2, pos_list={0}, effect_list={19172}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4335]={ side=2, pos_list={0}, effect_list={19173}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4336]={ side=2, pos_list={0}, effect_list={19174}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4337]={ side=2, pos_list={0}, effect_list={19175}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4338]={ side=2, pos_list={0}, effect_list={19176}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4339]={ side=2, pos_list={0}, effect_list={19177}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4340]={ side=2, pos_list={0}, effect_list={19178}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4341]={ side=2, pos_list={0}, effect_list={19179}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4342]={ side=2, pos_list={0}, effect_list={19180}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4343]={ side=2, pos_list={0}, effect_list={19181}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4344]={ side=2, pos_list={0}, effect_list={19182}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4345]={ side=2, pos_list={0}, effect_list={19183}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4346]={ side=2, pos_list={0}, effect_list={19184}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4347]={ side=2, pos_list={0}, effect_list={19185}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4348]={ side=2, pos_list={0}, effect_list={19186}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4349]={ side=2, pos_list={0}, effect_list={19187}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4350]={ side=1, pos_list={0}, effect_list={19188}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4351]={ side=1, pos_list={0}, effect_list={19189}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4352]={ side=1, pos_list={0}, effect_list={19190}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4353]={ side=1, pos_list={0}, effect_list={19191}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4354]={ side=1, pos_list={0}, effect_list={19192}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4355]={ side=1, pos_list={0}, effect_list={19193}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4356]={ side=1, pos_list={0}, effect_list={19194}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4357]={ side=1, pos_list={0}, effect_list={19195}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4358]={ side=1, pos_list={0}, effect_list={19196}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4359]={ side=2, pos_list={0}, effect_list={19197}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4360]={ side=2, pos_list={0}, effect_list={19198}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4361]={ side=2, pos_list={0}, effect_list={19199}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4362]={ side=2, pos_list={0}, effect_list={19200}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4363]={ side=2, pos_list={0}, effect_list={19201}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4364]={ side=2, pos_list={0}, effect_list={19202}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4365]={ side=2, pos_list={0}, effect_list={19203}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4366]={ side=2, pos_list={0}, effect_list={19204}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4367]={ side=2, pos_list={0}, effect_list={19205}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4368]={ side=2, pos_list={0}, effect_list={19206}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4369]={ side=2, pos_list={0}, effect_list={19207}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4370]={ side=2, pos_list={0}, effect_list={19208}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4371]={ side=2, pos_list={0}, effect_list={19209}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4372]={ side=2, pos_list={0}, effect_list={19210}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4373]={ side=2, pos_list={0}, effect_list={19211}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4374]={ side=2, pos_list={0}, effect_list={19212}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4375]={ side=2, pos_list={0}, effect_list={19213}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4376]={ side=2, pos_list={0}, effect_list={19214}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4377]={ side=2, pos_list={0}, effect_list={19215}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4378]={ side=2, pos_list={0}, effect_list={19216}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4379]={ side=2, pos_list={0}, effect_list={19217}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4380]={ side=2, pos_list={0}, effect_list={19218}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4381]={ side=1, pos_list={0}, effect_list={19219}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4382]={ side=1, pos_list={0}, effect_list={19220}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4383]={ side=1, pos_list={0}, effect_list={19221}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4384]={ side=1, pos_list={0}, effect_list={19222}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4385]={ side=1, pos_list={0}, effect_list={19223}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4386]={ side=1, pos_list={0}, effect_list={19224}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4387]={ side=1, pos_list={0}, effect_list={19225}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4388]={ side=1, pos_list={0}, effect_list={19226}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4389]={ side=1, pos_list={0}, effect_list={19227}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4390]={ side=2, pos_list={0}, effect_list={19228}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4391]={ side=2, pos_list={0}, effect_list={19229}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4392]={ side=2, pos_list={0}, effect_list={19230}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4393]={ side=2, pos_list={0}, effect_list={19231}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4394]={ side=2, pos_list={0}, effect_list={19232}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4395]={ side=2, pos_list={0}, effect_list={19233}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4396]={ side=2, pos_list={0}, effect_list={19234}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4397]={ side=2, pos_list={0}, effect_list={19235}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4398]={ side=2, pos_list={0}, effect_list={19236}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4399]={ side=2, pos_list={0}, effect_list={19237}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4400]={ side=2, pos_list={0}, effect_list={19238}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4401]={ side=2, pos_list={0}, effect_list={19239}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4402]={ side=2, pos_list={0}, effect_list={19240}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4403]={ side=2, pos_list={0}, effect_list={19241}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4404]={ side=2, pos_list={0}, effect_list={19242}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4405]={ side=2, pos_list={0}, effect_list={19243}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4406]={ side=2, pos_list={0}, effect_list={19244}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4407]={ side=2, pos_list={0}, effect_list={19245}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4408]={ side=2, pos_list={0}, effect_list={19246}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4409]={ side=2, pos_list={0}, effect_list={19247}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4410]={ side=2, pos_list={0}, effect_list={19248}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4411]={ side=2, pos_list={0}, effect_list={19249}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4215]={ side=2, pos_list={0}, effect_list={9107}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4216]={ side=2, pos_list={0}, effect_list={9108}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4217]={ side=2, pos_list={0}, effect_list={9109}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4218]={ side=2, pos_list={0}, effect_list={9110}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4219]={ side=2, pos_list={0}, effect_list={9111}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4220]={ side=2, pos_list={0}, effect_list={9112}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4501]={ side=2, pos_list={0}, effect_list={9355}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4502]={ side=2, pos_list={0}, effect_list={9356}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4503]={ side=2, pos_list={0}, effect_list={9357}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4504]={ side=2, pos_list={0}, effect_list={9358}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4505]={ side=2, pos_list={0}, effect_list={9359}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4506]={ side=2, pos_list={0}, effect_list={9364}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4507]={ side=2, pos_list={0}, effect_list={9365}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4508]={ side=2, pos_list={0}, effect_list={9366}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4509]={ side=2, pos_list={0}, effect_list={9367}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4510]={ side=2, pos_list={0}, effect_list={9368}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4511]={ side=1, pos_list={0}, effect_list={9369}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4512]={ side=2, pos_list={0}, effect_list={9374}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4513]={ side=2, pos_list={0}, effect_list={9375}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4514]={ side=2, pos_list={0}, effect_list={9376}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4515]={ side=2, pos_list={0}, effect_list={9377}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4516]={ side=2, pos_list={0}, effect_list={9378}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4517]={ side=1, pos_list={0}, effect_list={9379}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4518]={ side=2, pos_list={0}, effect_list={9384}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4519]={ side=2, pos_list={0}, effect_list={9385}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4520]={ side=2, pos_list={0}, effect_list={9386}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4521]={ side=2, pos_list={0}, effect_list={9387}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4522]={ side=2, pos_list={0}, effect_list={9388}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[4523]={ side=1, pos_list={0}, effect_list={9389}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[5001]={ side=2, pos_list={0}, effect_list={24001}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[5002]={ side=2, pos_list={0}, effect_list={24002}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[5003]={ side=2, pos_list={0}, effect_list={24003}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[5004]={ side=2, pos_list={0}, effect_list={24004}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[5005]={ side=2, pos_list={0}, effect_list={24005}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[5006]={ side=2, pos_list={0}, effect_list={24006}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[5007]={ side=2, pos_list={0}, effect_list={24007}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[5008]={ side=2, pos_list={0}, effect_list={24008}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9000]={ side=2, pos_list={0}, effect_list={8963}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9001]={ side=2, pos_list={0}, effect_list={8964}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9002]={ side=1, pos_list={0}, effect_list={8965}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9003]={ side=2, pos_list={0}, effect_list={8969}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9004]={ side=2, pos_list={0}, effect_list={8970}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9005]={ side=1, pos_list={0}, effect_list={8974}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9006]={ side=2, pos_list={0}, effect_list={8975}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9007]={ side=2, pos_list={0}, effect_list={8976}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9008]={ side=1, pos_list={0}, effect_list={8980}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9009]={ side=2, pos_list={0}, effect_list={8981}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9010]={ side=2, pos_list={0}, effect_list={8982}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9011]={ side=1, pos_list={0}, effect_list={8986}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9012]={ side=2, pos_list={0}, effect_list={8987}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9013]={ side=2, pos_list={0}, effect_list={8988}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9014]={ side=2, pos_list={0}, effect_list={8992}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9015]={ side=2, pos_list={0}, effect_list={8993}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9016]={ side=2, pos_list={0}, effect_list={8997}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9017]={ side=2, pos_list={0}, effect_list={8998}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9018]={ side=2, pos_list={0}, effect_list={9016}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9019]={ side=2, pos_list={0}, effect_list={9017}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9020]={ side=2, pos_list={0}, effect_list={9021}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9021]={ side=2, pos_list={0}, effect_list={9022}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9022]={ side=1, pos_list={0}, effect_list={9023}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9023]={ side=2, pos_list={0}, effect_list={9027}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9024]={ side=2, pos_list={0}, effect_list={9028}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9025]={ side=1, pos_list={0}, effect_list={9029}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9026]={ side=2, pos_list={0}, effect_list={9035}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9027]={ side=2, pos_list={0}, effect_list={9036}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9028]={ side=1, pos_list={0}, effect_list={9037}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9029]={ side=2, pos_list={0}, effect_list={9044}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9030]={ side=2, pos_list={0}, effect_list={9045}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9031]={ side=1, pos_list={0}, effect_list={9046}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9032]={ side=2, pos_list={0}, effect_list={9053}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9033]={ side=2, pos_list={0}, effect_list={9054}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
},
	[9034]={ side=1, pos_list={0}, effect_list={9055}, background_list={0}, effect_prefab_icon={0}, effect_prefab_buff={0}, icon_list={"zchj_32.png"}, row={0}, col={0}
}
}

return pos_effect_data