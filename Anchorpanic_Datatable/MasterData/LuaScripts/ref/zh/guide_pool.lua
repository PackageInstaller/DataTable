-- from 997 新手引导统计配置表.xlsx

local guide_pool=

{
	[1]={ guide_id=1013, step_id=1, step_des="战员开始战斗后会出现<color=#1792ff>行动倒计时</color>，在倒计时结束前可以发动攻击", event_name=""
},
	[2]={ guide_id=1013, step_id=2, step_des="发动技能需要消耗<color=#1792ff>能量</color>，此处显示战员拥有的<color=#1792ff>能量</color>，每个角色单独一个能量槽", event_name=""
},
	[3]={ guide_id=1013, step_id=3, step_des="此处显示发动技能需要消耗的<color=#1792ff>能量</color>", event_name=""
},
	[4]={ guide_id=1013, step_id=4, step_des="趁现在消耗1格<color=#1792ff>能量</color>，发动艾丽西亚技能——<color=#1792ff>流光·月刃</color>！！", event_name=""
},
	[5]={ guide_id=1014, step_id=1, step_des="此处是角色<color=#1792ff>行动条</color>，战场上所有角色的行动顺序会在此处显示，现在轮到敌方行动", event_name=""
},
	[6]={ guide_id=1015, step_id=1, step_des="现在发动艾丽西亚技能——<color=#1792ff>流光·连闪</color>！！", event_name=""
},
	[7]={ guide_id=1016, step_id=1, step_des="现在发动艾丽西亚的<color=#1792ff>源能爆发</color>——<color=#1792ff>流光·裁决</color>", event_name=""
},
	[8]={ guide_id=1018, step_id=1, step_des="此处显示敌人的<color=#1792ff>弱点属性</color>，使用相应的属性攻击怪物能够造成更高的伤害", event_name=""
},
	[9]={ guide_id=1018, step_id=2, step_des="血量上方显示敌人的<color=#1792ff>硬直</color>，受到相应的弱点属性攻击时会减少\n该值，当硬直条被清空时怪物会陷入<color=#1792ff>击破状态</color>", event_name=""
},
	[10]={ guide_id=1018, step_id=3, step_des="本次攻击可以将敌人的<color=#1792ff>硬直</color>清空", event_name=""
},
	[11]={ guide_id=1041, step_id=1, step_des="链尉官，<color=#1792ff>自动战斗</color>已开启，可以通过点击此处开启自动战斗！", event_name=""
},
	[12]={ guide_id=1041, step_id=2, step_des="点击战员头像可设置技能释放倾向（自动模式下技能一、二会交替释放）", event_name=""
},
	[13]={ guide_id=1041, step_id=3, step_des="点击技能一可让战员在自动模式下优先释放此技能", event_name=""
},
	[14]={ guide_id=1019, step_id=1, step_des="链尉官，<color=#1792ff>链接检索系统</color>已开启，可以寻找新队员了！", event_name=""
},
	[15]={ guide_id=1019, step_id=2, step_des="从此处进入链接检索界面", event_name=""
},
	[16]={ guide_id=1019, step_id=3, step_des="点击进入常规链接界面", event_name=""
},
	[17]={ guide_id=1019, step_id=4, step_des="点击此处消耗一张<color=#1792ff>链接许可</color>进行战员链接", event_name=""
},
	[18]={ guide_id=2060, step_id=1, step_des="链尉官，训练场已开放！", event_name=""
},
	[19]={ guide_id=2060, step_id=2, step_des="", event_name=""
},
	[20]={ guide_id=2060, step_id=3, step_des="在训练场中可以迅速掌握战斗技巧", event_name=""
},
	[21]={ guide_id=2060, step_id=4, step_des="点击进入基础训练", event_name=""
},
	[22]={ guide_id=2060, step_id=5, step_des="选择第一个训练", event_name=""
},
	[23]={ guide_id=2060, step_id=6, step_des="开始进行第一个训练", event_name=""
},
	[24]={ guide_id=2060, step_id=7, step_des="此处为通过训练的关键信息提示", event_name=""
},
	[25]={ guide_id=2060, step_id=8, step_des="了解训练要素后，再从此处选择一个合适的战员去进行挑战", event_name=""
},
	[26]={ guide_id=3030, step_id=1, step_des="链尉官，战斗获得了<color=#1792ff>模组</color>，快去给战员安装吧", event_name=""
},
	[27]={ guide_id=3030, step_id=2, step_des="", event_name=""
},
	[28]={ guide_id=3030, step_id=3, step_des="", event_name=""
},
	[29]={ guide_id=3030, step_id=4, step_des="点击此处进入模组系统界面", event_name=""
},
	[30]={ guide_id=3030, step_id=5, step_des="点击此处开始安装模组", event_name=""
},
	[31]={ guide_id=3030, step_id=6, step_des="点击即可查看模组的信息", event_name=""
},
	[32]={ guide_id=3030, step_id=7, step_des="点击此处为战员安装模组", event_name=""
},
	[33]={ guide_id=3030, step_id=8, step_des="选择第二个模组安装位置", event_name=""
},
	[34]={ guide_id=3030, step_id=9, step_des="点击即可查看模组信息", event_name=""
},
	[35]={ guide_id=3030, step_id=10, step_des="点击此处为战员安装模组，若安装同种模组，套装效果可自动激活", event_name=""
},
	[36]={ guide_id=1100, step_id=1, step_des="链尉官，事务所已开放！", event_name=""
},
	[37]={ guide_id=1100, step_id=2, step_des="", event_name=""
},
	[38]={ guide_id=1100, step_id=3, step_des="从此处进入事务所", event_name=""
},
	[39]={ guide_id=1100, step_id=4, step_des="此处显示事务累计评分，当天评分累计达到不同阶段可以领取对应的奖励", event_name=""
},
	[40]={ guide_id=1100, step_id=5, step_des="链尉官，现在点击领取完成事务的奖励吧！", event_name=""
},
	[41]={ guide_id=2080, step_id=1, step_des="链尉官，您已获得识域勘探的进入权限，请前往探索", event_name=""
},
	[42]={ guide_id=2080, step_id=2, step_des="", event_name=""
},
	[43]={ guide_id=2080, step_id=3, step_des="从此处进入未知的挑战", event_name=""
},
	[44]={ guide_id=2080, step_id=4, step_des="点击进入识域勘探", event_name=""
},
	[45]={ guide_id=2080, step_id=5, step_des="选定第一个区域", event_name=""
},
	[46]={ guide_id=2080, step_id=6, step_des="选定第一处开发区域", event_name=""
},
	[47]={ guide_id=2080, step_id=7, step_des="开始进行脑域开发吧！", event_name=""
},
	[48]={ guide_id=2010, step_id=1, step_des="链尉官，战员情报已经开放了！赶紧去看看吧", event_name=""
},
	[49]={ guide_id=2010, step_id=2, step_des="", event_name=""
},
	[50]={ guide_id=2010, step_id=3, step_des="从此处进入情报馆", event_name=""
},
	[51]={ guide_id=2010, step_id=4, step_des="每天共有4次挑战机会", event_name=""
},
	[52]={ guide_id=2010, step_id=5, step_des="链尉官，选择战员，去搜集关于她的情报吧！", event_name=""
},
	[53]={ guide_id=1110, step_id=1, step_des="链尉官，特殊主线作战已经开启了！赶紧去看看吧", event_name=""
},
	[54]={ guide_id=1110, step_id=2, step_des="从此处进入特殊主线章节", event_name=""
},
	[55]={ guide_id=1110, step_id=3, step_des="选择进入对应的章节", event_name=""
},
	[56]={ guide_id=1110, step_id=4, step_des="开始挑战第一个关卡吧！", event_name=""
},
	[57]={ guide_id=1017, step_id=1, step_des="点击此处可以查看关卡信息", event_name=""
},
	[58]={ guide_id=1017, step_id=2, step_des="点击此处可以进入备战", event_name=""
},
	[59]={ guide_id=1017, step_id=3, step_des="点击<color=#1792ff>阵型发光区域</color>可上阵战员", event_name=""
},
	[60]={ guide_id=1017, step_id=4, step_des="点击选择战员上阵", event_name=""
},
	[61]={ guide_id=1017, step_id=5, step_des="点击左侧对应的战员头像可以直接进行快捷培养", event_name=""
},
	[62]={ guide_id=1017, step_id=6, step_des="消耗相应的<color=#1792ff>战员经验</color>即可提升1次战员等级", event_name=""
},
	[63]={ guide_id=1017, step_id=7, step_des="勾选一键升级", event_name=""
},
	[64]={ guide_id=1017, step_id=8, step_des="点击升级按钮", event_name=""
},
	[65]={ guide_id=1017, step_id=9, step_des="点击这里可以返回出战界面", event_name=""
},
	[66]={ guide_id=1017, step_id=10, step_des="战员部署完毕！链尉官，现在开始出战吧！", event_name=""
},
	[67]={ guide_id=2091, step_id=1, step_des="链尉官，您已获得移动迷宫的进入权限，请前往探索", event_name=""
},
	[68]={ guide_id=2091, step_id=2, step_des="", event_name=""
},
	[69]={ guide_id=2091, step_id=3, step_des="从此处进入未知的挑战", event_name=""
},
	[70]={ guide_id=2091, step_id=4, step_des="点击进入移动迷宫", event_name=""
},
	[71]={ guide_id=2091, step_id=5, step_des="选择第一个区域进入", event_name=""
},
	[72]={ guide_id=2091, step_id=6, step_des="迷宫中充满了许多危险和宝藏，要是出现了无法再继续推进\n关卡的情况可以点击重置按钮进行关卡重置", event_name=""
},
	[73]={ guide_id=2091, step_id=7, step_des="这里会显示当前迷宫中的宝箱打开进度（重置不会重置宝箱）", event_name=""
},
	[74]={ guide_id=2091, step_id=8, step_des="当你找不到自己时，可以点击这里快速将自己定位在屏幕正中间", event_name=""
},
	[75]={ guide_id=3011, step_id=1, step_des="链尉官，您已获得异想回渊的进入权限，请前往探索", event_name=""
},
	[76]={ guide_id=3011, step_id=2, step_des="", event_name=""
},
	[77]={ guide_id=3011, step_id=3, step_des="从此处进入未知的挑战", event_name=""
},
	[78]={ guide_id=3011, step_id=4, step_des="点击进入异想回渊", event_name=""
},
	[79]={ guide_id=3011, step_id=5, step_des="这里可以选择不同的BOSS进行挑战", event_name=""
},
	[80]={ guide_id=3011, step_id=6, step_des="这里显示距离下一次奖励领取所需要的星星数", event_name=""
},
	[81]={ guide_id=3011, step_id=7, step_des="这里显示获得不同星星所需要达成的条件", event_name=""
},
	[82]={ guide_id=3011, step_id=8, step_des="这里显示回渊共鸣效果，该效果会增幅对应的战员", event_name=""
},
	[83]={ guide_id=3011, step_id=9, step_des="这里显示被锁定在当前BOSS的战员列表，被锁定的战员在本周内只能用于挑战该BOSS", event_name=""
},
	[84]={ guide_id=3011, step_id=10, step_des="每天都会获得一定的挑战次数，训练模式通关不会消耗挑战次数，同时挑战通关也不会锁定战员", event_name=""
},
	[85]={ guide_id=3021, step_id=1, step_des="链尉官，您已获得溯战外章的进入权限，请前往探索", event_name=""
},
	[86]={ guide_id=3021, step_id=2, step_des="", event_name=""
},
	[87]={ guide_id=3021, step_id=3, step_des="", event_name=""
},
	[88]={ guide_id=3021, step_id=4, step_des="点击进入溯战外章", event_name=""
},
	[89]={ guide_id=3021, step_id=5, step_des="这里显示当前玩法等级，提升玩法等级后可点击进入领取对应奖励", event_name=""
},
	[90]={ guide_id=3021, step_id=6, step_des="点击这里可以查看该玩法的当前任务，任务每15天刷新", event_name=""
},
	[91]={ guide_id=3021, step_id=7, step_des="点击这里可以该玩法的天赋系统，提升玩法等级可以获得天赋点", event_name=""
},
	[92]={ guide_id=3021, step_id=8, step_des="从这里就可以开始挑战玩法了", event_name=""
},
	[93]={ guide_id=1021, step_id=1, step_des="从这里可查看关卡的敌人信息", event_name=""
},
	[94]={ guide_id=1021, step_id=2, step_des="敌人的弱点属性会显示在右下方，左侧显示敌人的伤害类型", event_name=""
},
	[95]={ guide_id=1021, step_id=3, step_des="点击这里可以返回出战界面", event_name=""
},
	[96]={ guide_id=1021, step_id=4, step_des="所有关卡都会有推荐阵容，从这里可以查看关卡的推荐等级和\n推荐上阵元素，点击可以查看详细的属性弱点击破效果", event_name=""
},
	[97]={ guide_id=1022, step_id=1, step_des="从这里可以查看相应的环境效果总览", event_name=""
},
	[98]={ guide_id=1025, step_id=1, step_des="链尉官，<color=#1792ff>基建系统</color>已开启，可以去建造自己的家园了！", event_name=""
},
	[99]={ guide_id=1025, step_id=2, step_des="从此处进入基建", event_name=""
},
	[100]={ guide_id=1025, step_id=3, step_des="基建中烽火之心用于控制其他建筑的建造和升级", event_name=""
},
	[101]={ guide_id=1025, step_id=4, step_des="点击这里进入建造模式", event_name=""
},
	[102]={ guide_id=1025, step_id=5, step_des="点击可建造区域来建造动力模块吧", event_name=""
},
	[103]={ guide_id=1025, step_id=6, step_des="动力模块可以提供电力，建筑建造和升级都会需要占用电力，电力不足时无法建造和升级其他建筑", event_name=""
},
	[104]={ guide_id=1025, step_id=7, step_des="点击消耗<color=#1792ff>钛基材料</color>开始建造建筑吧", event_name=""
},
	[105]={ guide_id=1025, step_id=8, step_des="<color=#1792ff>钛基材料</color>是由提纯车间生产获得，点击这里进行建造", event_name=""
},
	[106]={ guide_id=1025, step_id=9, step_des="提纯车间主要用于生产<color=#1792ff>钛基材料</color>", event_name=""
},
	[107]={ guide_id=1025, step_id=10, step_des="点击消耗<color=#1792ff>钛基材料</color>开始建造建筑吧", event_name=""
},
	[108]={ guide_id=1025, step_id=11, step_des="点击可建造区域来建造舰员宿舍吧", event_name=""
},
	[109]={ guide_id=1025, step_id=12, step_des="舰员宿舍可入驻战员帮助恢复疲劳值，还可以DIY摆放家具提高宿舍的舒适度，舒适度越高战员的疲劳恢复速度越快", event_name=""
},
	[110]={ guide_id=1025, step_id=13, step_des="点击消耗<color=#1792ff>钛基材料</color>开始建造建筑吧", event_name=""
},
	[111]={ guide_id=1025, step_id=14, step_des="战员训练模块可以生产大量的<color=#1792ff>作战经验报告</color>用于提升战员等级，点击这里进行建造", event_name=""
},
	[112]={ guide_id=1025, step_id=15, step_des="战员训练模块入驻相关基建技能的战员后可以加速生产", event_name=""
},
	[113]={ guide_id=1025, step_id=16, step_des="点击消耗<color=#1792ff>钛基材料</color>开始建造建筑吧", event_name=""
},
	[114]={ guide_id=1025, step_id=17, step_des="点击这里进入退出建造模式", event_name=""
},
	[115]={ guide_id=1025, step_id=18, step_des="再次点击提纯车间可进入建筑内部", event_name=""
},
	[116]={ guide_id=1025, step_id=19, step_des="这里可以查看生产状态，入驻战员可以加速生产<color=#1792ff>钛基材料</color>", event_name=""
},
	[117]={ guide_id=1025, step_id=20, step_des="点击这里打开进驻信息弹窗", event_name=""
},
	[118]={ guide_id=1025, step_id=21, step_des="点击这里入驻战员", event_name=""
},
	[119]={ guide_id=1025, step_id=22, step_des="点击选择战员", event_name=""
},
	[120]={ guide_id=1025, step_id=23, step_des="从这里可以查看战员的基建技能，不同的战员拥有不同的\n基建技能，养成达到一定阶段还可以解锁第2个基建技能", event_name=""
},
	[121]={ guide_id=1025, step_id=24, step_des="战员初始疲劳值为200，处于工作中会消耗自身的疲劳\n值，当疲劳值为0时则会进入疲劳状态基建能会失效", event_name=""
},
	[122]={ guide_id=1025, step_id=25, step_des="点击确定入驻战员", event_name=""
},
	[123]={ guide_id=1025, step_id=26, step_des="点击这里可以消耗生产机器人加速生产", event_name=""
},
	[124]={ guide_id=1025, step_id=27, step_des="点击此处可以添加当前所有的生产机器人", event_name=""
},
	[125]={ guide_id=1025, step_id=28, step_des="点击确定则会消耗相应数量的机器人加速生产对应份数道具", event_name=""
},
	[126]={ guide_id=1025, step_id=29, step_des="点击这里可以返回基建", event_name=""
},
	[127]={ guide_id=1025, step_id=30, step_des="点击这里一键领取", event_name=""
},
	[128]={ guide_id=1025, step_id=31, step_des="", event_name=""
},
	[129]={ guide_id=1025, step_id=32, step_des="再次点击进入舰员宿舍安排战员入驻吧", event_name=""
},
	[130]={ guide_id=1025, step_id=33, step_des="点击此处可为宿舍装扮家具增加宿舍舒适度", event_name=""
},
	[131]={ guide_id=2001, step_id=1, step_des="链尉官，<color=#1792ff>锚驴系统</color>已开启，可以携带战斗伙伴了！", event_name=""
},
	[132]={ guide_id=2001, step_id=2, step_des="不同的锚驴可以给队伍带来不同的增益效果", event_name=""
},
	[133]={ guide_id=2001, step_id=3, step_des="点击此处解锁或携带锚驴伙伴", event_name=""
},
	[134]={ guide_id=2002, step_id=1, step_des="链尉官，潜能激发已经开放了！赶紧去看看吧", event_name=""
},
	[135]={ guide_id=2002, step_id=2, step_des="", event_name=""
},
	[136]={ guide_id=2002, step_id=3, step_des="从此处进入资源筹备", event_name=""
},
	[137]={ guide_id=2002, step_id=4, step_des="点击进入潜能激发", event_name=""
},
	[138]={ guide_id=2002, step_id=5, step_des="不同属性的战员激发潜能需要刷取对应属性的材料", event_name=""
},
	[139]={ guide_id=2003, step_id=1, step_des="链尉官，战斗获得了<color=#1792ff>烙痕</color>，快去给战员安装吧", event_name=""
},
	[140]={ guide_id=2003, step_id=2, step_des="", event_name=""
},
	[141]={ guide_id=2003, step_id=3, step_des="", event_name=""
},
	[142]={ guide_id=2003, step_id=4, step_des="点击进入战员烙痕系统", event_name=""
},
	[143]={ guide_id=2003, step_id=5, step_des="点击此处安装烙痕", event_name=""
},
	[144]={ guide_id=2003, step_id=6, step_des="点击强化可进入当前烙痕的培养界面", event_name=""
},
	[145]={ guide_id=2003, step_id=7, step_des="点击添加强化材料", event_name=""
},
	[146]={ guide_id=2003, step_id=8, step_des="选择1个烙痕强化剂", event_name=""
},
	[147]={ guide_id=2003, step_id=9, step_des="点击强化即可消耗所选材料提升烙痕等级", event_name=""
},
	[148]={ guide_id=2003, step_id=10, step_des="", event_name=""
},
	[149]={ guide_id=2003, step_id=11, step_des="<color=#1792ff>神血塑痕系统</color>已开启，在这里可以获得全新的烙痕！", event_name=""
},
	[150]={ guide_id=2003, step_id=12, step_des="从此处进入链接检索界面", event_name=""
},
	[151]={ guide_id=2003, step_id=13, step_des="神血塑痕每天都会有一次免费的塑痕机会", event_name=""
},
	[152]={ guide_id=10001, step_id=1, step_des="这里可查看当前拥有的天赋点，提升记战行录的等级可以获得天赋点", event_name=""
},
	[153]={ guide_id=10001, step_id=2, step_des="点击可以查看天赋的效果和激活所需天赋点", event_name=""
},
	[154]={ guide_id=10001, step_id=3, step_des="从这里可以查看所有已激活的天赋技能总览", event_name=""
},
	[155]={ guide_id=10002, step_id=1, step_des="探索的第一个阶段需要选择合适的作战策略", event_name=""
},
	[156]={ guide_id=10003, step_id=1, step_des="探索中的战员需要从已有的战员中重新招募，快点选择合适的招募组合吧", event_name=""
},
	[157]={ guide_id=10004, step_id=1, step_des="不同品质的战员招募消耗所需要的<color=#1792ff>后勤值</color>不同，从这里可以查看当前剩余的后勤值", event_name=""
}
}

return guide_pool