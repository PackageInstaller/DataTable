-- from 071 系统杂项配置表.xlsx

local system_param=

{
	[1]={ parameter=300, explain="体力初始化值"
},
	[2]={ parameter=1110, explain="初始战员（首次进入游戏解锁的战员）"
},
	[3]={ parameter=10, explain="申请好友上限"
},
	[5]={ parameter=10, explain="体力购买每日上限"
},
	[6]={ parameter=120, explain="玩家最大等级"
},
	[10]={ parameter=1000, explain="核能上限"
},
	[1001]={ parameter=0, explain="金币副本每日挑战次数上限"
},
	[1002]={ parameter=0, explain="经验副本每日挑战次数上限"
},
	[1003]={ parameter=0, explain="装备副本每日挑战次数上限"
},
	[1004]={ parameter=0, explain="芯片副本每日挑战次数上限"
},
	[1005]={ parameter=0, explain="芯片突破副本每日挑战次数上限"
},
	[1006]={ parameter=0, explain="元素芯片副本每日挑战次数上限"
},
	[1007]={ parameter=0, explain="战术芯片副本每日挑战次数上限"
},
	[1008]={ parameter=0, explain="防护芯片副本每日挑战次数上限"
},
	[1009]={ parameter=0, explain="强攻芯片副本每日挑战次数上限"
},
	[1010]={ parameter=0, explain="生命芯片副本每日挑战次数上限"
},
	[1011]={ parameter=0, explain="战术手环副本每日挑战次数上限"
},
	[1012]={ parameter=0, explain="战员晋升副本每日挑战次数上限"
},
	[1013]={ parameter=0, explain="战员增幅副本每日挑战次数上限"
},
	[1014]={ parameter=0, explain="战员技能副本每日挑战次数上限"
},
	[1015]={ parameter=0, explain="轰炎潜能副本每日挑战次数上限"
},
	[1016]={ parameter=0, explain="寒霜潜能副本每日挑战次数上限"
},
	[1017]={ parameter=0, explain="骋电潜能副本每日挑战次数上限"
},
	[1018]={ parameter=0, explain="量蚀潜能副本每日挑战次数上限"
},
	[1019]={ parameter=0, explain="生蕴潜能副本每日挑战次数上限"
},
	[1020]={ parameter=0, explain="手环升级副本每日挑战次数上限"
},
	[1021]={ parameter=0, explain="手环突破副本每日挑战次数上限"
},
	[2001]={ parameter=100, explain="芯片或者动能核心强化一键添加强化材料数量的最大上限"
},
	[7]={ parameter=5, explain="玩家对应可编辑队列的数量上限"
},
	[8]={ parameter=2000, explain="背包最大上限"
},
	[9]={ parameter=1000000, explain="单日高级招募最大招募上限"
},
	[11]={ parameter=800, explain="战员最大获取数量"
},
	[101]={ parameter=25, explain="竞技场胜利增加积分对应参数v"
},
	[102]={ parameter=20, explain="竞技场失败减少积分对应参数u"
},
	[103]={ parameter=4, explain="竞技场参数a"
},
	[104]={ parameter=10000, explain="竞技场参数b"
},
	[12]={ parameter=2150, explain="竞技场挑战消耗道具id"
},
	[18]={ parameter=1, explain="竞技场挑战消耗道具数量"
},
	[13]={ parameter=3, explain="竞技场每日免费挑战次数"
},
	[14]={ parameter=20, explain="竞技场战斗记录最大保存条数"
},
	[15]={ parameter=100, explain="竞技场排行榜最大名次显示"
},
	[16]={ parameter=1000, explain="竞技场玩家初始积分"
},
	[17]={ parameter=5, explain="竞技场每次刷新敌人数"
},
	[19]={ parameter=0, explain=""
},
	[20]={ parameter=15, explain="普通战斗最大回合数限制"
},
	[21]={ parameter=20, explain="竞技场回放日志最大记录上限"
},
	[22]={ parameter=5, explain="每日最大改名次数"
},
	[23]={ parameter=100, explain="好友列表上限"
},
	[24]={ parameter=100, explain="黑名单列表上限"
},
	[25]={ parameter=30, explain="竞技场定时更新间隔，单位：天"
},
	[26]={ parameter=4, explain="每轮推荐好友数"
},
	[27]={ parameter=6, explain="单次赠送抗疫血清数"
},
	[28]={ parameter=60, explain="单日领取抗疫血清上限"
},
	[29]={ parameter=6, explain="好友备注字数上限"
},
	[30]={ parameter=3600, explain="推荐好友时间间隔，单位：秒"
},
	[31]={ parameter=100, explain="初始化世界频道房间数"
},
	[32]={ parameter=300, explain="每隔x秒恢复1点体力"
},
	[33]={ parameter=99999, explain="体力最大上限"
},
	[34]={ parameter=2, explain="初始化中心跨服数据缓存等级限制"
},
	[35]={ parameter=10, explain="新手招募总次数"
},
	[36]={ parameter=6, explain="竞技场pvp默认战斗场景id"
},
	[37]={ parameter=2, explain="竞技场pvp默认背景音乐id"
},
	[38]={ parameter=30, explain="兑换码最大输入位数"
},
	[39]={ parameter=50, explain="玩家个性签名字数上限"
},
	[40]={ parameter=6, explain="玩家名称字数上限"
},
	[41]={ parameter=1, explain="初始战员唯一id"
},
	[42]={ parameter=200, explain="招募日志条数"
},
	[43]={ parameter=1, explain="竞技场第1个回合后可跳过"
},
	[44]={ parameter=4, explain="N、R、SR、SSR最高品质"
},
	[45]={ parameter=0, explain="D卡最高品质"
},
	[46]={ parameter=4, explain="升星所需战员品质"
},
	[47]={ parameter=45, explain="金币祈愿保底次数"
},
	[48]={ parameter=3, explain="金币祈愿每日上限"
},
	[49]={ parameter=5, explain="战员遣散，一次可分解的卡牌数量上限"
},
	[50]={ parameter=2500, explain="竞技场单个赛区人数"
},
	[51]={ parameter=13113, explain="金币祈愿保底掉落包ID"
},
	[52]={ parameter=500, explain="淡出背景时长,单位：毫秒"
},
	[53]={ parameter=300, explain="淡入背景时长,单位：毫秒"
},
	[54]={ parameter=300, explain="对话锁定时长，单位：毫秒"
},
	[55]={ parameter=1950, explain="初始暴击伤害战力修正（减）"
},
	[56]={ parameter=300, explain="单个聊天频道的人数上限"
},
	[57]={ parameter=0, explain=""
},
	[58]={ parameter=3, explain="多少秒内发过x句以上的文字或者图片视作刷屏行为"
},
	[59]={ parameter=4, explain="x秒内发过3句以上的文字或者图片视作刷屏行为"
},
	[60]={ parameter=10, explain="禁止发言时间"
},
	[61]={ parameter=3, explain="第三个获得的战员id"
},
	[62]={ parameter=3000, explain="芯片背包容量上限"
},
	[63]={ parameter=2000, explain="手环背包容量上限"
},
	[64]={ parameter=10, explain="新手训练营阶段上限"
},
	[65]={ parameter=1, explain="队伍改名间隔。单位：秒"
},
	[66]={ parameter=5, explain="队伍名称长度。单位：字"
},
	[67]={ parameter=0, explain="主线隐藏的副本id"
},
	[68]={ parameter=4, explain="传记副本每日最大挑战次数上限"
},
	[69]={ parameter=1202, explain="第二个获得的战员tid"
},
	[70]={ parameter=3, explain="新手引导跳过按钮出现所需时间。单位：秒"
},
	[71]={ parameter=1302, explain="第三个获得的战员id"
},
	[72]={ parameter=10, explain="新手招募总次数"
},
	[73]={ parameter=999, explain="单次购买商品数量上限"
},
	[74]={ parameter=0, explain="普通招募是否触发10连必定给ssr逻辑（1是 0否）"
},
	[75]={ parameter=5, explain="芯片副本前端刷新时间点"
},
	[76]={ parameter=32, explain="聊天字数上限"
},
	[77]={ parameter=2000, explain="招募CV播放界面最短停留时间。单位：毫秒"
},
	[78]={ parameter=30, explain="招募CV下一个文字出现的间隔。单位：毫秒"
},
	[79]={ parameter=2, explain="情报副本单个战员可挑战次数上限"
},
	[80]={ parameter=1, explain="新手招募SR的最多数量"
},
	[81]={ parameter=18, explain="名字输出字数上限"
},
	[82]={ parameter=15, explain="新手活动持续天数（从单个玩家创角开始）"
},
	[83]={ parameter={2,40}, explain="当玩家拥有x个大于等于y级的战员后（读取杂项），战员列表不再显示关于战员升级的红点提示"
},
	[84]={ parameter=9401, explain="异响回渊己方战员技能id"
},
	[85]={ parameter=3407, explain="弱点击破新手引导对应的怪物模板id"
},
	[86]={ parameter=1, explain="上阵人数判断不足，敌方人数判断额外减该值"
},
	[87]={ parameter=1110, explain="升星引导判断的战员星级大于1不触发"
},
	[88]={ parameter=5, explain="每日改名次数上限"
},
	[89]={ parameter=5, explain="每日个性签名修改次数上限"
},
	[90]={ parameter=5, explain="战员最大上阵数量"
},
	[91]={ parameter=1115, explain="弱引导出现的主线进度之前"
},
	[92]={ parameter={0,0,1006,1002,1010}, explain="对应每个格子id解锁所需主线进度，填0则默认解锁"
},
	[93]={ parameter=29, explain="公测登录活动天数（要多加1天，例如持续7天则需要配8天），单位：天数"
},
	[94]={ parameter=1014, explain="公测登录活动领取条件，通关主线id"
},
	[95]={ parameter=1202, explain="元雅的战员id，用于判断新手引导1033是否触发"
},
	[96]={ parameter=6, explain="首充需要满足的金额，单位：元"
},
	[97]={ parameter=7, explain="竞技场小于等于该段位只会匹配到机器人"
},
	[98]={ parameter=5, explain="兑换码使用间隔，单位：秒"
},
	[99]={ parameter=5, explain="星夜漫步活动持续时间，单位：天（从创角还是算起）"
},
	[100]={ parameter={10,80}, explain="7日补给礼包"
},
	[105]={ parameter=21, explain="回归活动持续时间，单位：天"
},
	[106]={ parameter={1,60}, explain="技能升级红点判断等级需求，大于等于这个等级后技能升级不需要红点提示"
},
	[107]={ parameter=1000, explain="竞技场(每个区取得数量=1000/区服数量)"
},
	[108]={ parameter=80, explain="模组方案存储上限"
},
	[109]={ parameter=8, explain="模组方案文字上限，字符数"
},
	[110]={ parameter=8, explain="消消乐提示所需时间，单位：秒"
},
	[111]={ parameter=68, explain="链尉官等级小于等于该等级则会分配至竞技场和颠峰竞技场得保护区"
},
	[112]={ parameter=421, explain="邮件默认的称呼，语言包id"
},
	[113]={ parameter=422, explain="邮件默认的署名，语言包id"
},
	[114]={ parameter=1, explain="无限城跳过所需回合数"
},
	[115]={ parameter={1025,3}, explain="通行证模型查看角色tid，序号"
},
	[116]={ parameter={69,85}, explain="链尉官等级在这个等级段则会分配至竞技场和颠峰竞技场得中级保护区"
},
	[117]={ parameter=4, explain="共鸣第一个位置所需要的战员军阶条件"
},
	[118]={ parameter=1, explain="当前卡池处于上半还是下半。（1.上半   2.下半）"
},
	[119]={ parameter=10000, explain="抽卡需要监听是否需要监听该模块下载额外资源"
},
	[120]={ parameter=10000, explain="道具自选战员会检测是否需要下载额外资源"
},
	[121]={ parameter=500, explain="珍藏邮件上限"
},
	[122]={ parameter=4, explain="最低分区数量"
},
	[123]={ parameter=2000, explain="dna蛋背包容量"
},
	[124]={ parameter=101, explain="主题活动那边关联的卡池id，如果为0则不显示按钮"
},
	[196]={ parameter={{3,50}}, explain="等级重置消耗"
},
	[197]={ parameter=40001, explain="主界面弹脸图读组合包配置的哪个商品id"
},
	[3001]={ parameter=200, explain="格挡点击判定时间段，单位：毫秒"
},
	[3002]={ parameter=0, explain="格挡成功承受伤害比率，单位：万分比"
},
	[3003]={ parameter=2000, explain="格挡点击冷却时间，单位：毫秒"
},
	[3004]={ parameter=8000, explain="格挡失败承受伤害比率，单位：万分比"
},
	[3005]={ parameter=400, explain="格挡成功慢镜头持续时间，单位：毫秒"
},
	[3006]={ parameter=5000, explain="格挡成功慢镜头播放倍率，单位：万分比（0到10000之间）"
},
	[3009]={ parameter=2000, explain="格挡成功冷却时间，单位：毫秒"
},
	[3010]={ parameter=100, explain="初始力场值"
},
	[3011]={ parameter=25, explain="抵挡普通技能所需力场值"
},
	[3012]={ parameter=25, explain="抵挡终结技所需力场值"
},
	[3013]={ parameter=25, explain="抵挡核能技所需力场值"
},
	[3014]={ parameter=25, explain="抵挡普通攻击所需力场值"
},
	[3015]={ parameter=100, explain="普通格挡点击判定时间段，单位：毫秒"
},
	[3016]={ parameter=5000, explain="中等格挡成功承受伤害比率，单位：万分比"
},
	[3017]={ parameter=100, explain="中等格挡点击判定时间段，单位：毫秒"
},
	[1101]={ parameter=3, explain="主界面广告牌轮播时间。单位：秒"
},
	[200]={ parameter=62, explain="每扣除1%的生命时可获得的核能值(/10)"
},
	[201]={ parameter=0, explain="自动跳过镜头技（0为关，1为开）"
},
	[202]={ parameter=1, explain="显示生命和buff（0为关，1为开）"
},
	[203]={ parameter=0, explain="隐藏伤害数字（0为关，1为开）"
},
	[204]={ parameter=0, explain="自动战斗时隐藏ui（0为关，1为开）"
},
	[205]={ parameter=1, explain="进度条显示人数5/10（0为关，1为开）"
},
	[206]={ parameter=0, explain="隐藏职业定位（0为关，1为开）"
},
	[207]={ parameter=0, explain="简化战斗UI（0为关，1为开）"
},
	[291]={ parameter=9991, explain="雷元素印记"
},
	[292]={ parameter=9992, explain="火元素印记"
},
	[293]={ parameter=9993, explain="冰元素印记"
},
	[299]={ parameter=9999, explain="竞技场疲劳设定(技能id)"
},
	[300]={ parameter=0, explain=""
},
	[301]={ parameter=3, explain="1星每日目标数量"
},
	[302]={ parameter=2, explain="2星每日目标数量"
},
	[303]={ parameter=1, explain="3星每日目标数量"
},
	[304]={ parameter=4, explain="可携带补给数量"
},
	[305]={ parameter=3, explain="通关后战利品随机出现数量"
},
	[306]={ parameter=100, explain="通关后战利品随机出现数量"
},
	[307]={ parameter=10551, explain="简单难度对应的技能id"
},
	[308]={ parameter=10651, explain="普通难度对应的技能id"
},
	[309]={ parameter=10751, explain="困难难度对应的技能id"
},
	[310]={ parameter=10851, explain="噩梦难度对应的技能id"
},
	[311]={ parameter=500, explain="噩梦难度对应的技能id"
},
	[401]={ parameter=6, explain="资源副本多倍挑战倍数上限"
},
	[402]={ parameter=6, explain="潜能副本多倍挑战倍数上限"
},
	[403]={ parameter=6, explain="模组副本多倍挑战倍数上限"
},
	[404]={ parameter=2, explain="情报副本多倍挑战倍数上限"
},
	[405]={ parameter={{2,5},{3,10},{4,30},{5,40},{6,45}}, explain="资源副本多倍挑战数量和对应开启指挥官等级"
},
	[501]={ parameter=1, explain="第一条附加属性解锁所需芯片阶段等级"
},
	[502]={ parameter=1, explain="第二条附加属性解锁所需芯片阶段等级"
},
	[503]={ parameter=1, explain="第三条附加属性解锁所需芯片阶段等级"
},
	[504]={ parameter=16, explain="芯片/手环强化材料单词消耗的数量上限"
},
	[505]={ parameter=16, explain="芯片/手环强化材料一键添加的数量上限"
},
	[506]={ parameter=6, explain="手环精炼等级上限"
},
	[601]={ parameter=5, explain="战员初始疲劳值"
},
	[602]={ parameter=1, explain="章节每日重置次数上限"
},
	[603]={ parameter=8000, explain="大于关卡推荐等级*该系数则为安全，单位：万分比"
},
	[604]={ parameter=5000, explain="小于关卡推荐等级*该系数则为危险，单位：万分比"
},
	[605]={ parameter=100, explain="代号希望竞技场排行榜最大名次显示"
},
	[701]={ parameter=604800, explain="更换势力冷却时间。单位：秒"
},
	[702]={ parameter=2, explain="战术助手最多协助的战员数量"
},
	[703]={ parameter=2, explain="每天单个区域探索次数上限"
},
	[704]={ parameter=-990, explain="对应加速探索事件公式中的参数a（单位：万分比）"
},
	[705]={ parameter=-49760, explain="对应加速探索事件公式中的参数b（单位：万分比）"
},
	[706]={ parameter=3560, explain="对应加速探索事件公式中的参数c（单位：万分比）"
},
	[707]={ parameter=1800, explain="对应剩余时间精度计算的参数d"
},
	[708]={ parameter=200, explain="总的基因参数获取上限"
},
	[709]={ parameter=20678300, explain="盟约等阶经验获取上限"
},
	[710]={ parameter=100, explain="盟约等阶上限"
},
	[711]={ parameter=10000, explain="单次派遣刷新消耗金币数量"
},
	[801]={ parameter=4, explain="异常环境buff抽取数量（注：不放回的抓取）"
},
	[802]={ parameter=3, explain="通关关卡从x个数量的矩阵中选取一个"
},
	[803]={ parameter=100, explain="默示之境排行榜最大名次显示"
},
	[901]={ parameter=100, explain="精英数据上限"
},
	[902]={ parameter=720, explain="收益储存上限720分钟"
},
	[903]={ parameter=60, explain="挂机奖励红点触发时间"
},
	[904]={ parameter=5, explain="数据商人每天触发次数上限"
},
	[950]={ parameter=50, explain="宿舍长"
},
	[951]={ parameter=50, explain="宿舍宽"
},
	[952]={ parameter=15, explain="宿舍高"
},
	[953]={ parameter=12, explain="家具过载值上限"
},
	[957]={ parameter=2000, explain="家具背包上限"
},
	[954]={ parameter=2, explain="人物长"
},
	[955]={ parameter=2, explain="人物宽"
},
	[956]={ parameter=2, explain="人物高"
},
	[958]={ parameter=3, explain="战员上限"
},
	[959]={ parameter=17001, explain="默认墙tid"
},
	[960]={ parameter=17002, explain="默认天花板tid"
},
	[961]={ parameter=17003, explain="默认地板tid"
},
	[962]={ parameter=5, explain="战员气泡出现时间"
},
	[963]={ parameter=30, explain="战员气泡冷却时间"
},
	[964]={ parameter=11, explain="盟约天赋初始id"
},
	[751]={ parameter=20, explain="活动持续天数（填0则不开启该活动）"
},
	[851]={ parameter=100, explain="移动迷宫排行榜最大名次显示"
},
	[852]={ parameter=3, explain="通关关卡从x个数量的物资中选取一个"
},
	[853]={ parameter=1, explain="主角自带迷雾光源范围"
},
	[854]={ parameter=150, explain="1到3格模型移动速率"
},
	[855]={ parameter=200, explain="4到7格模型移动速率"
},
	[856]={ parameter=250, explain="8格以上模型移动速率"
},
	[857]={ parameter=1110, explain="迷宫小模型id"
},
	[858]={ parameter=250, explain="冰面移动速度模型移动速率"
},
	[451]={ parameter=100, explain="使徒之战排行榜最大名次显示"
},
	[821]={ parameter=49, explain="战员增幅最大等级"
},
	[831]={ parameter=15, explain="亲密度等级上限"
},
	[861]={ parameter=16000, explain="每周任务获取通行证经验上限（周一5点刷新）"
},
	[862]={ parameter=80, explain="1级对应消耗x钻石"
},
	[863]={ parameter=10, explain="98元档直升等级"
},
	[864]={ parameter=1600, explain="98元档额外奖励包"
},
	[871]={ parameter=30, explain="月卡持续天数"
},
	[872]={ parameter=6, explain="月卡限购数量"
},
	[873]={ parameter=300, explain="立即获得星彩源晶"
},
	[874]={ parameter=80, explain="每日可领取源晶辉锭"
},
	[875]={ parameter=3, explain="月卡不足3天时出现提示"
},
	[876]={ parameter=3, explain="钛金石道具ID"
},
	[877]={ parameter=15, explain="源晶辉锭道具ID"
},
	[878]={ parameter=2202, explain="额外赠送的道具id"
},
	[879]={ parameter=1, explain="额外赠送的道具数量"
},
	[881]={ parameter=1000, explain="N卡初始属性系数。（单位：千分比）"
},
	[882]={ parameter=1000, explain="R卡初始属性系数。（单位：千分比）2~3星"
},
	[883]={ parameter=1000, explain="SR卡初始属性系数。（单位：千分比）4~5星"
},
	[884]={ parameter=1000, explain="SSR卡初始属性系数。（单位：千分比）6星及以上"
},
	[885]={ parameter={{11,30000},{12,10000},{13,20000}}, explain="战员辅助型增益buff的三维增益上限，关联buff开启（单位：万分比）"
},
	[921]={ parameter={1,1,3,3,4,4,1}, explain="号芯片对应安装槽位开启所需军阶"
},
	[927]={ parameter=0, explain=""
},
	[983]={ parameter=500, explain="战员碎片背包容量上限"
},
	[1200]={ parameter=10, explain="buff统计界面可显示的数量上限"
},
	[1201]={ parameter=10000, explain="伤害显示阈值"
},
	[1202]={ parameter=10000, explain="承伤显示阈值"
},
	[1203]={ parameter=10000, explain="治疗显示阈值"
},
	[1204]={ parameter=10, explain="普攻对应硬直减少"
},
	[1205]={ parameter=25, explain="技能对应硬直减少"
},
	[1206]={ parameter=50, explain="奥义对应硬直减少"
},
	[1207]={ parameter=22, explain="3倍速开启条件，指挥官等级"
},
	[1301]={ parameter=2, explain="1点体力等于x点亲密度"
},
	[1305]={ parameter=5, explain="肉鸽重置CD：秒"
},
	[1306]={ parameter=2000, explain="商品价格保底万分比"
},
	[1401]={ parameter=5, explain="最大助战数量"
},
	[1501]={ parameter=2, explain="产能每日购买次数"
},
	[1502]={ parameter=300, explain="单次购买产能获得数量"
},
	[1506]={ parameter=300, explain="单次购买产能花费洛德币数量"
},
	[1503]={ parameter=360, explain="每1产能，可加速多少秒"
},
	[1504]={ parameter=720, explain="每多少秒恢复1点产能"
},
	[1505]={ parameter=500, explain="原料背包上限"
},
	[1507]={ parameter=1440, explain="产能上限"
},
	[1508]={ parameter=120, explain="功能解锁时能源值"
},
	[1601]={ parameter=3, explain="匹配时间下限（单位：秒）"
},
	[1602]={ parameter=8, explain="匹配时间上限（单位：秒）"
},
	[1611]={ parameter=25, explain="巅峰竞技场胜利增加积分对应参数v"
},
	[1612]={ parameter=20, explain="巅峰竞技场失败减少积分对应参数u"
},
	[1613]={ parameter=4, explain="巅峰竞技场参数a"
},
	[1614]={ parameter=10000, explain="巅峰竞技场参数b"
},
	[1615]={ parameter=3, explain="巅峰竞技场挑战消耗道具id（源晶辉锭）"
},
	[1616]={ parameter=50, explain="巅峰竞技场挑战消耗道具数量"
},
	[1617]={ parameter=5, explain="巅峰竞技场每日免费挑战次数"
},
	[1618]={ parameter=20, explain="巅峰竞技场战斗记录最大保存条数"
},
	[1619]={ parameter=100, explain="巅峰竞技场排行榜最大名次显示"
},
	[1620]={ parameter=1000, explain="巅峰竞技场玩家初始积分"
},
	[1621]={ parameter=3, explain="巅峰竞技场每次刷新敌人数"
},
	[1622]={ parameter=15, explain="普通战斗最大回合数限制"
},
	[1623]={ parameter={2023,10,25}, explain="巅峰竞技场开启时间"
},
	[1624]={ parameter=30, explain="巅峰竞技场定时更新间隔，单位：天"
},
	[1625]={ parameter=6, explain="巅峰竞技场pvp默认战斗场景id"
},
	[1626]={ parameter=2, explain="巅峰竞技场pvp默认背景音乐id"
},
	[1627]={ parameter=1, explain="巅峰竞技场第1个回合后可跳过"
},
	[1628]={ parameter=2500, explain="巅峰竞技场单个赛区人数"
},
	[1629]={ parameter=1500, explain="巅峰竞技场小于等于该积分只会匹配到机器人"
},
	[1630]={ parameter=20, explain="小于等于该排名则全部遮住"
},
	[1631]={ parameter=50, explain="小于等于该排名则遮住2，3队伍"
},
	[1632]={ parameter=100, explain="小于等于该排名则遮住3队伍"
},
	[1633]={ parameter=20, explain="每日购买挑战次数上限"
},
	[1634]={ parameter=5, explain="刷新间隔，单位：秒"
},
	[1635]={ parameter=1000, explain="颠峰竞技场每个区取得数量=1000/区服数量"
},
	[1636]={ parameter=3600, explain="颠峰竞技场排行榜刷新间隔，单位：秒"
},
	[1701]={ parameter=9910, explain="偷袭成功给敌人buff"
},
	[1702]={ parameter=9913, explain="被偷袭给自己加buff"
},
	[1703]={ parameter=3, explain="从物资中抽取几个，buff总数小于这个值则按照具体的buff数来读"
},
	[1704]={ parameter=10, explain="战员血量阈值，单位：百分比"
},
	[1705]={ parameter=3, explain="进入地图场景后保护时间，单位：秒"
},
	[1706]={ parameter=5, explain="定时同时的时间间隔，单位秒"
},
	[1707]={ parameter=400, explain="椭圆提示的半长轴"
},
	[1708]={ parameter=250, explain="椭圆提示的半短轴"
},
	[1709]={ parameter=60, explain="遇怪效果帧数"
},
	[1801]={ parameter=3, explain="盟约战场技能能量恢复上限"
},
	[1802]={ parameter=1, explain="每个大回合恢复x能量"
},
	[1803]={ parameter=0, explain="盟约战场技能初始能量"
},
	[1851]={ parameter=2, explain="剧情播放倍速第1档（配0则不显示）"
},
	[1852]={ parameter=4, explain="剧情播放倍速第2档（配0则不显示）"
},
	[1853]={ parameter=8, explain="剧情播放倍速第3档（配0则不显示）"
},
	[1854]={ parameter=12, explain="剧情播放倍速第4档（配0则不显示）"
},
	[1900]={ parameter=10, explain="`"
},
	[1901]={ parameter=1013, explain="小于主线这个进度就会触发指引提示"
},
	[1902]={ parameter=1, explain="第一章选关界面停留超过这个时间就会出现（单位：秒）"
},
	[1903]={ parameter=1500, explain="战斗界面若提示时间间隔（单位：毫秒）"
},
	[1904]={ parameter=1004, explain="战斗界面若提示小于主线这个进度就会触发指引提示"
},
	[1905]={ parameter=1002, explain="大于主线这个进度就会出触发指引提示"
},
	[1911]={ parameter=610, explain="改造属性<0.62为B（千分比）"
},
	[1912]={ parameter=790, explain="改造属性<0.8为A（千分比）"
},
	[1913]={ parameter=990, explain="改造属性<1为S（千分比）"
},
	[1914]={ parameter=300, explain="模组礼包使用上限"
},
	[1915]={ parameter=300, explain="模组改造材料选择上限"
},
	[1916]={ parameter=4, explain="模组改造可选属性数量"
},
	[1917]={ parameter=4, explain="模组改造可选品质数量"
},
	[1921]={ parameter=40, explain="免费重置等级"
},
	[1922]={ parameter=2505, explain="天赋重置道具ID"
},
	[1923]={ parameter=105, explain="天赋道具使用次数上限"
},
	[1931]={ parameter={{2061,1},{1,25000}}, explain="赋能一次所需消耗"
},
	[1932]={ parameter={{2061,2},{1,40000}}, explain="重新设定属性所需消耗"
},
	[1933]={ parameter={{2061,2}}, explain="锁定1条属性所需消耗"
},
	[1934]={ parameter={{2061,4}}, explain="锁定2条属性所需消耗"
},
	[1935]={ parameter={{2061,2},{1,40000}}, explain="锁定一条属性后赋能所需消耗"
},
	[1936]={ parameter={{2061,3},{1,60000}}, explain="锁定一条属性后重新设定属性所需消耗"
},
	[1937]={ parameter={{2061,3},{1,60000}}, explain="锁定两条属性后赋能所需消耗"
},
	[1938]={ parameter={{2061,5},{1,80000}}, explain="锁定两条属性后重新设定属性所需消耗"
},
	[4001]={ parameter=10, explain="初始金币"
},
	[4002]={ parameter=100, explain="初始生命"
},
	[4003]={ parameter=1, explain="每次刷新消耗金币"
},
	[4004]={ parameter=1000, explain="准备期间获得的利息（单位：万分比）"
},
	[4005]={ parameter=5, explain="利息的最高上限"
},
	[4006]={ parameter=5, explain="战斗失败基础扣血量"
},
	[4007]={ parameter=60, explain="准备时间（单位：秒）"
},
	[4008]={ parameter=30, explain="战斗等待时间（单位：秒）"
},
	[4009]={ parameter=1, explain="白色品质基础扣血量"
},
	[4010]={ parameter=2, explain="绿色品质基础扣血量"
},
	[4011]={ parameter=3, explain="蓝色品质基础扣血量"
},
	[4012]={ parameter=4, explain="紫色品质基础扣血量"
},
	[4013]={ parameter=5, explain="橙色品质基础扣血量"
},
	[4014]={ parameter=1, explain="1星卡基础扣血量"
},
	[4015]={ parameter=2, explain="2星卡基础扣血量"
},
	[4016]={ parameter=3, explain="3星卡基础扣血量"
},
	[4017]={ parameter=5, explain="每次刷新抽取卡牌数量"
},
	[4018]={ parameter=8, explain="备战区域可存储战员数量"
},
	[4019]={ parameter=30, explain="战斗的最大回合数"
},
	[4020]={ parameter=2, explain="单次升级消耗的金币"
},
	[4021]={ parameter=2, explain="单次消耗的金币增加的经验"
},
	[4022]={ parameter=1, explain="基础胜利金币"
},
	[4023]={ parameter=5, explain="战斗统计时间（单位：秒）"
},
	[4024]={ parameter=2, explain="参数a（a*x²+b*x-c+基数），单位:十万分比"
},
	[4025]={ parameter=3760, explain="参数b（a*x²+b*x-c+基数），单位:十万分比"
},
	[4026]={ parameter=130000, explain="参数c（a*x²+b*x-c+基数），单位:万分比"
},
	[4027]={ parameter=2000, explain="每周活动货币获取上限"
},
	[4028]={ parameter=21, explain="玩法活动货币id"
},
	[4029]={ parameter=100, explain="对局中金币携带上限"
},
	[4030]={ parameter=0, explain="开启时间点，单位：小时"
},
	[4031]={ parameter=24, explain="关闭时间点，单位：小时"
},
	[4032]={ parameter=3, explain="正常周任务数量"
},
	[4033]={ parameter=1, explain="战令任务数量"
},
	[2000]={ parameter=30, explain="boss战最大回合数"
},
	[2101]={ parameter=128, explain="成长基金价格 元"
},
	[2102]={ parameter=0, explain="占个位置"
},
	[4501]={ parameter=12, explain="SSR招募需要消耗希望值"
},
	[4502]={ parameter=6, explain="SR招募需要消耗希望值"
},
	[4503]={ parameter=0, explain="R招募需要消耗希望值"
},
	[4504]={ parameter=1, explain="单个战员死亡扣除理智基数"
},
	[4505]={ parameter=6, explain="初始商品售卖格子数"
},
	[4506]={ parameter=24, explain="单轮投资上限"
},
	[4507]={ parameter=48, explain="单轮提取上限"
},
	[4508]={ parameter=3, explain="月任务刷新次数"
},
	[4509]={ parameter={1,2,1}, explain="每月1号5点刷新出现任务数量，[类型1数量，类型2数量，类型3数量]"
},
	[4510]={ parameter=120, explain="天赋点获取上限"
},
	[4511]={ parameter=6, explain="放弃后再次挑战cd，单位：秒"
},
	[4512]={ parameter=1080, explain="初次进入挑战第一层线路id"
},
	[5001]={ parameter=200, explain="战员疲劳上限"
},
	[5002]={ parameter={1,216}, explain="发电站生产效率，单位：[数量,每多少秒]"
},
	[5003]={ parameter=200, explain="无人机仓库上限"
},
	[5004]={ parameter=5, explain="体力兑换无人机数量，1体力=x无人机"
},
	[5005]={ parameter={100,200,300,400,500}, explain="宿舍对应初始舒适度"
},
	[5006]={ parameter={1000,2000,3000,4000,5000}, explain="宿舍对应舒适度上限"
},
	[5007]={ parameter={500,2}, explain="每xx点氛围值对应额外恢复y疲劳值"
},
	[5008]={ parameter=99, explain="加工厂订单上限"
},
	[5009]={ parameter=108, explain="单个无人机对应时间减少，单位：秒"
},
	[5010]={ parameter={2,3,4,5,6}, explain="派遣坞对应可派遣队伍数量"
},
	[5011]={ parameter=100, explain="大于该值显示绿色"
},
	[5012]={ parameter=10, explain="大于该值显示橙色，小于等于该值显示红色"
},
	[5013]={ parameter=3, explain="当控制中心到多少级开放一键入驻"
},
	[5101]={ parameter=3, explain="前端SR和SSR天赋等级上限判定"
},
	[5102]={ parameter=13, explain="前端技能等级上限判定"
},
	[5103]={ parameter=3, explain="前端R卡天赋等级上限判定"
},
	[5104]={ parameter=10, explain="技能养成等级上限判定"
},
	[5105]={ parameter=2, explain="R卡星源普攻技能等级增加值"
},
	[5201]={ parameter=86400, explain="手环通讯冷却时间/s"
},
	[5202]={ parameter=0.5, explain="手环通讯自动输入时间/s"
},
	[5203]={ parameter=3, explain="手环通讯每日段数上限"
},
	[5301]={ parameter=1, explain="1源晶辉锭兑换N时装币"
},
	[5302]={ parameter=0, explain=""
},
	[5350]={ parameter={800,1250,1800}, explain="弱点属性初始加伤（小怪、精英、boss）"
},
	[5351]={ parameter=0, explain="硬直击破飘字buffid"
},
	[5352]={ parameter=6667, explain="硬直恢复飘字buffid"
},
	[5356]={ parameter=6000, explain="非弱点击破硬直效率降低值"
},
	[5357]={ parameter=9903, explain="燃烧通用buff触发技能id"
},
	[5361]={ parameter=28, explain="1.1up的天数"
},
	[5362]={ parameter=28, explain="活动期间限时货币id"
},
	[5363]={ parameter={2,3,4,6,7,9,10,11,12,13,14,15,16,19,20,28,30,35,36,37,38,39,41,42,44}, explain="活动期间会掉落活动币的关卡战斗类型"
},
	[5364]={ parameter=1110, explain="特定战员id"
},
	[5365]={ parameter=2021, explain="给平民释加的效果id"
},
	[5366]={ parameter=6, explain="资源增产次数"
},
	[5367]={ parameter=2015, explain="普通关卡最后一关id"
},
	[5371]={ parameter=2, explain="每周次数"
},
	[5372]={ parameter=0, explain="0"
},
	[5401]={ parameter=6, explain="推荐等级小于20级，相差大于等于该值则会弹窗提示等级不足"
},
	[5402]={ parameter=9, explain="推荐等级小于40级大于等于20级时，相差大于等于该值则会弹窗提示等级不足"
},
	[5403]={ parameter=11, explain="推荐等级小于60级大于等于40级时，相差大于等于该值则会弹窗提示等级不足"
},
	[5404]={ parameter=16, explain="推荐等级小于80级大于等于60级时，相差大于等于该值则会弹窗提示等级不足"
},
	[5405]={ parameter=21, explain="推荐等级小于100级大于等于80级时，相差大于等于该值则会弹窗提示等级不足"
},
	[5421]={ parameter=5, explain="自动进入下一关的时间/s"
},
	[5422]={ parameter=0, explain=""
},
	[5431]={ parameter=0, explain="界面模型预览"
},
	[5432]={ parameter={{12330,1}}, explain="累积奖励，艾克皮肤"
},
	[5433]={ parameter=1751490000, explain="taptap登录弹脸结束时间戮"
},
	[5441]={ parameter={{3,300}}, explain="联盟创建消耗"
},
	[5442]={ parameter={{3,300}}, explain="联盟改名消耗"
},
	[5443]={ parameter=20, explain="联盟人数上限"
},
	[5444]={ parameter=6, explain="联盟名字字数上限"
},
	[5445]={ parameter=60, explain="联盟签名字数上限"
},
	[5446]={ parameter=5, explain="联盟刷新列表间隔，单位：秒"
},
	[5447]={ parameter=8, explain="联盟刷新列表数量上限"
},
	[5448]={ parameter=10, explain="联盟申请列表上限"
},
	[5450]={ parameter=24, explain="联盟退出cd，单位：小时"
},
	[5451]={ parameter=3, explain="联盟副会长数量"
},
	[5452]={ parameter=86400, explain="会长弹劾之后的倒计时，单位：秒"
},
	[5453]={ parameter=172800, explain="会长多久没上线可倒计时，单位：秒"
},
	[5454]={ parameter=30, explain="联盟聊天保存x条聊天记录"
},
	[5455]={ parameter=10, explain="联盟训练场最大回合数"
},
	[5456]={ parameter={{3,300}}, explain="联盟改图标消耗"
},
	[5501]={ parameter=3, explain="联盟战每日挑战次数"
},
	[5502]={ parameter=12800, explain="联盟战无限周目叠加的血量成长系数（乘幂），单位：万分比"
},
	[5504]={ parameter=200, explain="排行榜显示数量"
},
	[5505]={ parameter={{{2024,12,23},{2024,12,27}},{{2025,1,20},{2025,1,24}},{{2025,2,24},{2025,2,28}},{{2025,3,24},{2025,3,28}},{{2025,4,27},{2025,5,1}},{{2025,6,4},{2025,6,8}},{{2025,7,9},{2025,7,13}},{{2025,8,13},{2025,8,17}}}, explain="活动{{开启时间}，{结束时间}}"
},
	[5506]={ parameter=10, explain="联盟战最大战斗回合数"
},
	[5507]={ parameter=1, explain="联盟战正常挑战回合数"
},
	[5508]={ parameter={10100,32}, explain="联盟战无限周目叠加的攻击成长系数（乘幂），单位：万分比"
},
	[5521]={ parameter=150, explain="绳索的摆动角度，单位：度"
},
	[5522]={ parameter=0, explain=""
},
	[5523]={ parameter=0, explain=""
},
	[5524]={ parameter=0, explain=""
},
	[5551]={ parameter={3,9}, explain="随机从x和y之间取一个数，单位：秒"
},
	[5552]={ parameter=3, explain="气泡停留时间"
},
	[5553]={ parameter=0, explain="主界面活动入口进入的地图id（配0则打开的是2D界面，配1则是进入场景）"
},
	[5554]={ parameter=5, explain="开心农场玩法进入的场景id"
},
	[5555]={ parameter=10, explain="开心农场仓库容量"
},
	[5556]={ parameter=2, explain="主界面活动入口关卡类型（1.主线，2.活动关卡）"
},
	[5557]={ parameter=12, explain="如果是类型1，这里填对应的主线章节id"
},
	[5571]={ parameter=6501, explain="战区1到战区2的晋升奖励"
},
	[5572]={ parameter=6502, explain="战区2到战区3的晋升奖励"
},
	[5573]={ parameter=10, explain="无限城最大战斗回合数"
},
	[5581]={ parameter=60, explain="1级对应消耗x钻石"
},
	[5582]={ parameter={1022,3}, explain="时装通行证的tid 和 时装id"
},
	[5586]={ parameter=60, explain="1级对应消耗x钻石"
},
	[5587]={ parameter={1011,3}, explain="时装通行证的tid 和 时装id"
},
	[5591]={ parameter=3, explain="鱼脱钩时间，单位：秒"
},
	[5592]={ parameter=20, explain="进度初始百分比"
},
	[5593]={ parameter=100, explain="每次点击鱼移动距离（平滑移动），单位：像素"
},
	[5595]={ parameter=10, explain="浮标成功停留，钓鱼进度每秒增加值，单位：像素"
},
	[5596]={ parameter=100, explain="每秒对应的进度条百分比增加量：单位：万分比"
},
	[5597]={ parameter=30, explain="钓鱼进度颜色为红色小于等于的百分比"
},
	[5598]={ parameter=70, explain="钓鱼进度颜色为黄色小于等于的百分比"
},
	[5599]={ parameter=3, explain="自动钓鱼所需要手动钓成功鱼的数量"
},
	[5601]={ parameter=3, explain="小于等于该难度的不需要前置解锁"
},
	[5602]={ parameter=7, explain="一周内单个玩家的最大挑战次数"
},
	[5603]={ parameter={1,2}, explain="能够开启联盟boss的职位（0.成员，1.会长，2.副会长）"
},
	[5604]={ parameter=10, explain="最大回合数"
},
	[5605]={ parameter=1, explain="联盟boss正常挑战跳过所需回合数"
},
	[5651]={ parameter=3, explain="每天挑战次数"
},
	[5652]={ parameter=5, explain="每轮战斗次数"
},
	[5653]={ parameter=2, explain="跳过所需回合数"
},
	[5654]={ parameter=6, explain="最大挑战回合数"
},
	[5655]={ parameter={69,85}, explain="排行榜中级区范围"
},
	[5701]={ parameter=30, explain="月卡持续天数"
},
	[5702]={ parameter=6, explain="月卡限购数量"
},
	[5703]={ parameter=300, explain="立即获得星彩源晶"
},
	[5704]={ parameter=3, explain="月卡不足3天时出现提示"
},
	[5705]={ parameter=2204, explain="每天赠送的道具id"
},
	[5706]={ parameter=1, explain="每天赠送的道具数量"
},
	[5751]={ parameter=990, explain="下载奖励掉落包"
},
	[5752]={ parameter={}, explain="渠道id"
},
	[5761]={ parameter=10, explain="所需庆典任务数量"
},
	[5762]={ parameter={{12374,1}}, explain="庆典累计奖励，丽丽拉皮肤"
},
	[5763]={ parameter={1105,4}, explain="庆典任务的tid 和 时装id"
},
	[5764]={ parameter={{13200,1}}, explain="庆典月卡激活奖励"
},
	[5766]={ parameter=3, explain=""
},
	[5767]={ parameter=3, explain="战斗后抓取的收藏品数量"
},
	[5768]={ parameter=0, explain="商店商品收藏品数量"
},
	[5769]={ parameter=5, explain="商店商品buff数量"
},
	[5770]={ parameter=95, explain="天赋点获取上限"
},
	[5771]={ parameter=6, explain="放弃后再次挑战cd，单位：秒"
},
	[5772]={ parameter=6, explain="最大挑战回合数"
},
	[5773]={ parameter=10000, explain="肉鸽能量上限"
},
	[5774]={ parameter=1000, explain="使用技能增加肉鸽能量比例"
},
	[5775]={ parameter=0, explain="初始肉鸽能量值"
},
	[5776]={ parameter=1, explain="正常挑战回合数"
},
	[5781]={ parameter=68, explain="活动期间单次充值达到金额"
},
	[5782]={ parameter=810, explain="达标奖励"
},
	[5783]={ parameter=23, explain="跳转界面编码ID"
},
	[5786]={ parameter=68, explain="活动期间充值金额"
},
	[5787]={ parameter={1020,3}, explain="狂欢好礼角色"
},
	[5788]={ parameter=68, explain="活动期间充值金额"
},
	[5789]={ parameter={1004,4}, explain="狂欢好礼角色"
},
	[5791]={ parameter=9800, explain="活动期间累计充值达到金额"
},
	[5796]={ parameter=86400, explain="主界面倒计时显示时间"
},
	[5801]={ parameter=3, explain="团战每日挑战次数"
},
	[5802]={ parameter=3, explain="团战每日防守成功加积分次数（建筑被破坏则失效）"
},
	[5803]={ parameter=3600, explain="匹配阶段所需要时间，单位：秒"
},
	[5804]={ parameter=50, explain="进攻主城所需单个边城被破坏血量低于百分之多少"
},
	[5805]={ parameter=100, explain="胜利方获得积分"
},
	[5806]={ parameter=2190, explain="结算破坏积分x最低值限制"
},
	[5807]={ parameter=5, explain="主动挑战2连胜额外加分"
},
	[5808]={ parameter=10, explain="主动挑战3连胜额外加分"
},
	[5809]={ parameter=0, explain="防守中断3连胜额外加分"
},
	[5810]={ parameter=50, explain="平局方获得积分"
},
	[5811]={ parameter={{{2025,2,17},{2025,2,21}},{{2025,3,17},{2025,3,21}},{{2025,4,21},{2025,4,25}},{{2025,5,21},{2025,5,25}},{{2025,6,23},{2025,6,27}},{{2025,7,23},{2025,7,27}},{{2025,8,27},{2025,8,31}}}, explain="活动{{开启时间}，{结束时间}}"
},
	[5812]={ parameter=15, explain="其他15个小建筑 最少需要入驻几个才算报名成功"
},
	[5813]={ parameter=1, explain="1个主城最少需要入驻几个才算报名成功"
},
	[5814]={ parameter=3, explain="3个边城主城最少要入驻几个才算报名成功"
},
	[5815]={ parameter=10, explain="战斗的最大回合数"
},
	[5816]={ parameter=5, explain="破坏积分转化参数a(算出来的积分除以100w)"
},
	[5817]={ parameter=-12900, explain="破坏积分转化参数b"
},
	[5818]={ parameter=81727000, explain="破坏积分转化参数c"
},
	[5819]={ parameter=0, explain="活动可进入时间戳"
},
	[5820]={ parameter={{1,1,40},{2,41,100},{3,101,200},{4,201,400},{5,401,99999}}, explain="报名成功联盟数对应类型"
},
	[5901]={ parameter=1022, explain="纳源链接功能开启时默认选中的角色id"
},
	[5902]={ parameter=7331, explain="纳源铸痕功能开启时默认选中的烙痕id"
},
	[5903]={ parameter=901, explain="纳源链接重置选择道具"
},
	[5904]={ parameter=800, explain="聚源链接/铸痕重置选择道具"
},
	[5905]={ parameter=7, explain="聚源激活生效时间"
},
	[5900]={ parameter={1023,1019}, explain="聚源链接卡池"
},
	[5899]={ parameter={7332,7325}, explain="聚源铸痕卡池"
},
	[5906]={ parameter={{2607,1},{1,360000}}, explain="金色的卵孵化所需道具"
},
	[5907]={ parameter=4, explain="功能开启所需要的战员军阶条件"
},
	[5911]={ parameter=2071, explain="转转乐道具id"
},
	[5913]={ parameter=2072, explain="转转乐商店用的兑换道具"
},
	[5914]={ parameter=50, explain="必定出的抽数"
},
	[5915]={ parameter=2073, explain="转转乐道具id"
},
	[5916]={ parameter=2074, explain="转转乐商店用的兑换道具"
},
	[5917]={ parameter=50, explain="必定出的抽数"
},
	[5921]={ parameter={{"cv",93,"voice_layback"},{"cv_jp",94,"voice_layback_jp"}}, explain="{语音,选项名,语音延迟字段名}"
}
}

return system_param