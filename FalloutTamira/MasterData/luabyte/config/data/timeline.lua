local title = {
	id = 0,
	describe = "",
	timelinePath = "",
	startEventTag = 0,
	startEventParams = {},
	endEventTag = 0,
	endEventParams = {},
	endCameraFov = 0,
	dormParams = {},
	furnitureId = {}
}

local value = {
[1] =
{
 		id=1,
 		describe="看板娘入场",
 		timelinePath="Timeline/Prefab/ShowGirl/showgirltrack00",
 		startEventTag=1,
 		startEventParams={85560,580},
 		endEventTag=1,
 		endEventParams={1},
 		endCameraFov=35,
 	furnitureId={}
},
[2] =
{
 		id=2,
 		describe="看板娘3-1",
 		timelinePath="Timeline/Prefab/ShowGirl/showgirltrack2",
 		startEventTag=1,
 		startEventParams={-163000,580},
 		endEventTag=1,
 		endEventParams={1},
 		endCameraFov=35,
 	furnitureId={}
},
[3] =
{
 		id=3,
 		describe="看板娘1-2",
 		timelinePath="Timeline/Prefab/ShowGirl/showgirltrack0",
 		startEventTag=1,
 		startEventParams={25000,580},
 		endEventTag=1,
 		endEventParams={1},
 		endCameraFov=35,
 	furnitureId={}
},
[4] =
{
 		id=4,
 		describe="看板娘2-3",
 		timelinePath="Timeline/Prefab/ShowGirl/showgirltrack1",
 		startEventTag=1,
 		startEventParams={85560,580},
 		endEventTag=1,
 		endEventParams={1},
 		endCameraFov=35,
 	furnitureId={}
},
[1001] =
{
 		id=1001,
 		describe="看板娘1号freelock相机位到看板娘一号观察地球位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleSelectCam_01",
 		startEventTag=2,
 		startEventParams={2266483,1894,252,4445,274467,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=35,
 	furnitureId={}
},
[1002] =
{
 		id=1002,
 		describe="看板娘1号观察地球位置到地球中心位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleEnterCam_01",
 		startEventTag=2,
 		startEventParams={2265025,1581,-5,4445,274467,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=35,
 	furnitureId={}
},
[1003] =
{
 		id=1003,
 		describe="看板娘1号地球中心位置到看板娘1号观察地球位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleEnterCam_01b",
 		startEventTag=2,
 		startEventParams={2266483,1894,252,4445,274467,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=35,
 	furnitureId={}
},
[1004] =
{
 		id=1004,
 		describe="看板娘1号观察地球位置到看板娘freelock相机位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleSelectCam_01b",
 		startEventTag=1,
 		startEventParams={2271260,1442,-2692,4485,274467,0},
 		endEventTag=1,
 		endEventParams={1},
 		endCameraFov=35,
 	furnitureId={}
},
[2001] =
{
 		id=2001,
 		describe="看板娘2号freelock相机位到看板娘2号观察地球位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleSelectCam_02",
 		startEventTag=2,
 		startEventParams={2262705,1892,-2760,4690,387723,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=35,
 	furnitureId={}
},
[2002] =
{
 		id=2002,
 		describe="看板娘2号观察地球位置到地球中心位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleEnterCam_02",
 		startEventTag=2,
 		startEventParams={2263198,1442,-893,4690,387723,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=35,
 	furnitureId={}
},
[2003] =
{
 		id=2003,
 		describe="看板娘2号地球中心位置到看板娘2号观察地球位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleEnterCam_02b",
 		startEventTag=2,
 		startEventParams={2262705,1892,-2760,4690,387723,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=35,
 	furnitureId={}
},
[2004] =
{
 		id=2004,
 		describe="看板娘2号观察地球位置到看板娘freelock相机位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleSelectCam_02b",
 		startEventTag=1,
 		startEventParams={2258330,1442,-6148,4684,387723,0},
 		endEventTag=1,
 		endEventParams={1},
 		endCameraFov=35,
 	furnitureId={}
},
[3001] =
{
 		id=3001,
 		describe="看板娘3号freelock相机位到看板娘3号观察地球位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleSelectCam_03",
 		startEventTag=2,
 		startEventParams={2264876,1868,2631,4355,214054,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=35,
 	furnitureId={}
},
[3002] =
{
 		id=3002,
 		describe="看板娘3号观察地球位置到地球中心位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleEnterCam_03",
 		startEventTag=2,
 		startEventParams={2264059,1516,857,4355,214054,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=35,
 	furnitureId={}
},
[3003] =
{
 		id=3003,
 		describe="看板娘3号地球中心位置到看板娘3号观察地球位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleEnterCam_03b",
 		startEventTag=2,
 		startEventParams={2264876,1868,2631,4355,214054,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=35,
 	furnitureId={}
},
[3004] =
{
 		id=3004,
 		describe="看板娘3号观察地球位置到看板娘freelock相机位置",
 		timelinePath="Timeline/Prefab/ShowGirl/BattleSelectCam_03b",
 		startEventTag=1,
 		startEventParams={2269759,1442,5371,4385,214054,0},
 		endEventTag=1,
 		endEventParams={1},
 		endCameraFov=35,
 	furnitureId={}
},
[10001] =
{
 		id=10001,
 		describe="养成界面入场",
 		timelinePath="Timeline/Prefab/Interface/CharacterEnter",
 		startEventTag=2,
 		startEventParams={-4520,520,6050,6200,-221907,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10011] =
{
 		id=10011,
 		describe="养成界面主镜头——个人信息镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterInformation_01",
 		startEventTag=2,
 		startEventParams={-3000,630,4400,3110,144000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10012] =
{
 		id=10012,
 		describe="个人信息镜头——养成界面主镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterInformation_01b",
 		startEventTag=2,
 		startEventParams={-4520,520,6050,6200,-221907,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10021] =
{
 		id=10021,
 		describe="养成界面主镜头——好感度镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterInformation_01",
 		startEventTag=2,
 		startEventParams={-3000,630,4400,3110,144000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10022] =
{
 		id=10022,
 		describe="好感度镜头——养成界面主镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterInformation_01b",
 		startEventTag=2,
 		startEventParams={-4520,520,6050,6200,-221907,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10031] =
{
 		id=10031,
 		describe="养成界面主镜头——核心强化镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterCoreReinforcement_01",
 		startEventTag=2,
 		startEventParams={-3000,630,4300,3110,137000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10032] =
{
 		id=10032,
 		describe="核心强化镜头——养成界面主镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterCoreReinforcement_01b",
 		startEventTag=2,
 		startEventParams={-4520,520,6050,5000,-221907,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10033] =
{
 		id=10033,
 		describe="核心强化镜头——核心强化信息镜头a",
 		timelinePath="Timeline/Prefab/Interface/CharacterCoreReinforcement_02",
 		startEventTag=2,
 		startEventParams={-3000,630,4300,3110,147000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10034] =
{
 		id=10034,
 		describe="核心强化信息镜头a——核心强化镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterCoreReinforcement_02b",
 		startEventTag=2,
 		startEventParams={-3000,630,4300,3110,137000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10035] =
{
 		id=10035,
 		describe="养成界面主镜头——核心强化镜头loli",
 		timelinePath="Timeline/Prefab/Interface/CharacterCoreReinforcement_03",
 		startEventTag=2,
 		startEventParams={-3000,480,4300,3110,137000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10036] =
{
 		id=10036,
 		describe="核心强化镜头loli——养成界面主镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterCoreReinforcement_03b",
 		startEventTag=2,
 		startEventParams={-4520,520,6050,5000,-221907,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10037] =
{
 		id=10037,
 		describe="核心强化镜头loli——核心强化信息镜头loli",
 		timelinePath="Timeline/Prefab/Interface/CharacterCoreReinforcement_04",
 		startEventTag=2,
 		startEventParams={-3000,480,4300,3110,147000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10038] =
{
 		id=10038,
 		describe="核心强化信息镜头loli——核心强化镜头loli",
 		timelinePath="Timeline/Prefab/Interface/CharacterCoreReinforcement_04b",
 		startEventTag=2,
 		startEventParams={-3000,480,4300,3110,137000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10041] =
{
 		id=10041,
 		describe="养成界面主镜头——进阶镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterLevelup_01",
 		startEventTag=2,
 		startEventParams={-3600,610,4530,3110,142000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10042] =
{
 		id=10042,
 		describe="进阶镜头——养成界面主镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterLevelup_01b",
 		startEventTag=2,
 		startEventParams={-4520,520,6050,6200,-221907,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10051] =
{
 		id=10051,
 		describe="养成界面主镜头——技能升级镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterSkill_01",
 		startEventTag=2,
 		startEventParams={-3420,630,4770,3110,137000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10052] =
{
 		id=10052,
 		describe="技能升级镜头——养成界面主镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterSkill_01b",
 		startEventTag=2,
 		startEventParams={-4520,520,6050,6200,-221907,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10061] =
{
 		id=10061,
 		describe="养成界面主镜头——基因升级01",
 		timelinePath="Timeline/Prefab/Interface/CharacterGene_01",
 		startEventTag=2,
 		startEventParams={-1510,660,-850,1780,-180000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10062] =
{
 		id=10062,
 		describe="基因升级01——养成界面主镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterGene_01b",
 		startEventTag=2,
 		startEventParams={-4520,520,6050,6200,-221907,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10063] =
{
 		id=10063,
 		describe="基因升级01——基因升级02",
 		timelinePath="Timeline/Prefab/Interface/CharacterGene_02",
 		startEventTag=2,
 		startEventParams={-2030,660,-850,1780,-180000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10064] =
{
 		id=10064,
 		describe="基因升级02——基因升级01",
 		timelinePath="Timeline/Prefab/Interface/CharacterGene_02b",
 		startEventTag=2,
 		startEventParams={-1510,660,-850,1780,-180000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10065] =
{
 		id=10065,
 		describe="基因升级01——基因升级03",
 		timelinePath="Timeline/Prefab/Interface/CharacterGene_03",
 		startEventTag=2,
 		startEventParams={-1510,660,-2150,1780,-180000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10066] =
{
 		id=10066,
 		describe="基因升级03——基因升级01",
 		timelinePath="Timeline/Prefab/Interface/CharacterGene_03b",
 		startEventTag=2,
 		startEventParams={-1510,660,-850,1780,-180000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10067] =
{
 		id=10067,
 		describe="基因升级03",
 		timelinePath="Timeline/Prefab/Interface/CharacterGene_03_hold",
 		startEventTag=2,
 		startEventParams={-1510,660,-850,1780,-180000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10071] =
{
 		id=10071,
 		describe="养成界面主镜头——核心养成01",
 		timelinePath="Timeline/Prefab/Interface/CharacterCore_01",
 		startEventTag=2,
 		startEventParams={2000,450,-4450,0,-180000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[10072] =
{
 		id=10072,
 		describe="核心养成01——养成界面主镜头",
 		timelinePath="Timeline/Prefab/Interface/CharacterCore_01b",
 		startEventTag=2,
 		startEventParams={-4520,520,6050,6200,-221907,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[11001] =
{
 		id=11001,
 		describe="养成界面——玛蒂尔达入场",
 		timelinePath="Timeline/Prefab/Interface/DisplayRoom_Enter_Matilda_120002",
 		startEventTag=2,
 		startEventParams={-4978,520,5525,5000,-225349,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=30,
 	furnitureId={}
},
[20001] =
{
 		id=20001,
 		describe="序章开场安息香",
 		timelinePath="Timeline/Prefab/Story/MainStory_0-1-1",
 	furnitureId={}
},
[20002] =
{
 		id=20002,
 		describe="序章玛乔丽出场",
 		timelinePath="Timeline/Prefab/Story/MainStory_0-2-1",
 	furnitureId={}
},
[20003] =
{
 		id=20003,
 		describe="序章玛乔丽轰门",
 		timelinePath="Timeline/Prefab/Story/MainStory_0-3-1",
 	furnitureId={}
},
[20004] =
{
 		id=20004,
 		describe="战舰降落",
 	furnitureId={}
},
[20005] =
{
 		id=20005,
 		describe="战舰飞船驶离",
 		timelinePath="Timeline/Prefab/CutScene/battleship_landing",
 	furnitureId={}
},
[300101] =
{
 		id=300101,
 		describe="安息香膝枕",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_SleepOnTheKnees_01",
 		dormParams={1,0},
 	furnitureId={}
},
[300102] =
{
 		id=300102,
 		describe="安息香看书",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_TogetherLookBook_01",
 		dormParams={1,0},
 	furnitureId={}
},
[300103] =
{
 		id=300103,
 		describe="安息香洗澡b",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_Bath_110003",
 		dormParams={4,112208},
 	furnitureId={}
},
[300104] =
{
 		id=300104,
 		describe="安息香喂糖",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_FeedCandy_01",
 		dormParams={1,0},
 	furnitureId={215002}
},
[300105] =
{
 		id=300105,
 		describe="安息香蒙眼",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_Blindfold_01",
 		dormParams={4,0},
 	furnitureId={}
},
[300201] =
{
 		id=300201,
 		describe="一松樱独舞",
 		timelinePath="Timeline/Prefab/Home/Yisongying/Story_DanceAlone",
 	furnitureId={}
},
[300202] =
{
 		id=300202,
 		describe="一松樱洗澡hx",
 		timelinePath="Timeline/Prefab/Home/Yisongying/Story_Bath_120001_hx",
 	furnitureId={}
},
[3010101] =
{
 		id=3010101,
 		describe="安息香膝枕-默认常服",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_SleepOnTheKnees_01",
 		dormParams={1,0},
 	furnitureId={}
},
[3010201] =
{
 		id=3010201,
 		describe="安息香膝枕-旗袍",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_SleepOnTheKnees_02",
 		dormParams={1,0},
 	furnitureId={}
},
[3010102] =
{
 		id=3010102,
 		describe="安息香看书-默认常服",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_TogetherLookBook_01",
 		dormParams={1,0},
 	furnitureId={}
},
[3010202] =
{
 		id=3010202,
 		describe="安息香看书-旗袍",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_TogetherLookBook_02",
 		dormParams={1,0},
 	furnitureId={}
},
[3010103] =
{
 		id=3010103,
 		describe="安息香洗澡b-默认裸模（对应常服1-默认常服）",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_Bath_110003_b",
 		dormParams={4,112208},
 	furnitureId={}
},
[3010203] =
{
 		id=3010203,
 		describe="安息香洗澡b-默认裸模（对应常服2-旗袍）",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_Bath_110003_b",
 		dormParams={4,112208},
 	furnitureId={}
},
[3010104] =
{
 		id=3010104,
 		describe="安息香喂糖-默认常服",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_FeedCandy_01",
 		dormParams={1,0},
 	furnitureId={215002}
},
[3010204] =
{
 		id=3010204,
 		describe="安息香喂糖-旗袍",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_FeedCandy_02",
 		dormParams={1,0},
 	furnitureId={215002}
},
[3010105] =
{
 		id=3010105,
 		describe="安息香蒙眼-默认常服",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_Blindfold_01",
 		dormParams={4,0},
 	furnitureId={}
},
[3010205] =
{
 		id=3010205,
 		describe="安息香蒙眼-旗袍",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Story_Blindfold_02",
 		dormParams={4,0},
 	furnitureId={}
},
[3020101] =
{
 		id=3020101,
 		describe="一松樱独舞",
 		timelinePath="Timeline/Prefab/Home/Yisongying/Story_DanceAlone",
 	furnitureId={}
},
[3020102] =
{
 		id=3020102,
 		describe="一松樱洗澡hx",
 		timelinePath="Timeline/Prefab/Home/Yisongying/Story_Bath_120001_hx",
 	furnitureId={}
},
[300100] =
{
 		id=300100,
 		describe="宿舍睁眼",
 		timelinePath="Timeline/Prefab/CutScene/Blink",
 		startEventTag=2,
 		startEventParams={-227,1425,-1000,14097,1000,0},
 		endEventTag=1,
 		endCameraFov=50,
 	furnitureId={}
},
[3001001] =
{
 		id=3001001,
 		describe="宿舍门口——特写",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_stand",
 		startEventTag=2,
 		startEventParams={-3450,1400,2900,9648,-197819,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001002] =
{
 		id=3001002,
 		describe="特写——宿舍门口",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_stand_b",
 		startEventTag=2,
 		startEventParams={-4000,1300,4500,7282,153435,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001003] =
{
 		id=3001003,
 		describe="宿舍门口——洗澡",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_shower",
 		startEventTag=2,
 		startEventParams={-4100,1000,-1000,1637,-180000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001004] =
{
 		id=3001004,
 		describe="洗澡——宿舍门口",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_shower_b",
 		startEventTag=2,
 		startEventParams={-4000,1300,4500,7282,153435,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001005] =
{
 		id=3001005,
 		describe="宿舍门口——睡觉",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_bed",
 		startEventTag=2,
 		startEventParams={400,800,-3600,14684,-162424,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001006] =
{
 		id=3001006,
 		describe="睡觉——宿舍门口",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_bed_b",
 		startEventTag=2,
 		startEventParams={-4000,1300,4500,7282,153435,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001007] =
{
 		id=3001007,
 		describe="睡觉——起床",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_bed_wakeup",
 		startEventTag=2,
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001008] =
{
 		id=3001008,
 		describe="宿舍门口——床上看书",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_bed_book",
 		startEventTag=2,
 		startEventParams={-600,1000,-3300,18775,150945,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001009] =
{
 		id=3001009,
 		describe="床上看书——宿舍门口",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_bed_book_b",
 		startEventTag=2,
 		startEventParams={-4000,1300,4500,7282,153435,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001010] =
{
 		id=3001010,
 		describe="床上看书——坐起",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_bed_book_wake",
 		startEventTag=2,
 		startEventParams={-20,1000,-2800,4052,-172674,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001011] =
{
 		id=3001011,
 		describe="宿舍门口——书桌",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_desk",
 		startEventTag=2,
 		startEventParams={2280,1000,-2750,4736,-291890,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001012] =
{
 		id=3001012,
 		describe="书桌——宿舍门口",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_desk_b",
 		startEventTag=2,
 		startEventParams={-4000,1300,4500,7282,153435,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001013] =
{
 		id=3001013,
 		describe="宿舍门口——沙发",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_sofa",
 		startEventTag=2,
 		startEventParams={-2800,1000,3800,5150,-212735,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001014] =
{
 		id=3001014,
 		describe="沙发——宿舍门口",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_sofa_b",
 		startEventTag=2,
 		startEventParams={-4000,1300,4500,7282,153435,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[3001015] =
{
 		id=3001015,
 		describe="宿舍淡入转镜头",
 		timelinePath="Timeline/Prefab/Home/Anxixiang/Home_stand_trans",
 		startEventTag=2,
 		startEventParams={-3450,1400,2900,9648,-197819,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=40,
 	furnitureId={}
},
[8] =
{
 		id=8,
 		describe="新反塔测试镜头-默认视角到跟随视角",
 		timelinePath="Timeline/Prefab/CutScene/AttackCam1",
 		startEventTag=2,
 		startEventParams={11270,3580,26560,15580,173380,30},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=45,
 	furnitureId={}
},
[9] =
{
 		id=9,
 		describe="新反塔测试镜头-跟随视角到默认视角",
 		timelinePath="Timeline/Prefab/CutScene/AttackCam2",
 		startEventTag=2,
 		startEventParams={10410,4820,26000,31010,158500,-1610},
 		endEventTag=1,
 		endEventParams={3},
 		endCameraFov=45,
 	furnitureId={}
},
[12001] =
{
 		id=12001,
 		describe="制造仓默认——特写",
 		timelinePath="Timeline/Prefab/Interface/MakeInterface_01",
 		startEventTag=2,
 		startEventParams={0,1300,8500,0,-180000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=23,
 	furnitureId={}
},
[12002] =
{
 		id=12002,
 		describe="制造仓特写——默认",
 		timelinePath="Timeline/Prefab/Interface/MakeInterface_01b",
 		startEventTag=2,
 		startEventParams={0,1500,8500,0,-180000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=39,
 	furnitureId={}
},
[13001] =
{
 		id=13001,
 		describe="餐厅回到主视角",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_main",
 		startEventTag=2,
 		startEventParams={-5000,2200,3800,19000,142500,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13002] =
{
 		id=13002,
 		describe="主视角——餐桌",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_table",
 		startEventTag=2,
 		startEventParams={-1600,1010,275,9000,90000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13003] =
{
 		id=13003,
 		describe="主视角——操作台",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_kitchen",
 		startEventTag=2,
 		startEventParams={300,1600,0,11235,90000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13004] =
{
 		id=13004,
 		describe="操作台——主视角",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_kitchen_b",
 		startEventTag=2,
 		startEventParams={-5000,2200,3800,19000,142500,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13011] =
{
 		id=13011,
 		describe="餐桌A",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_table_a",
 		startEventTag=2,
 		startEventParams={-1600,1010,275,9000,90000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13012] =
{
 		id=13012,
 		describe="餐桌B",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_table_b",
 		startEventTag=2,
 		startEventParams={-1600,1010,-1320,9000,90000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13013] =
{
 		id=13013,
 		describe="餐桌C",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_table_c",
 		startEventTag=2,
 		startEventParams={-950,1010,1025,11000,270000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13014] =
{
 		id=13014,
 		describe="餐桌D",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_table_d",
 		startEventTag=2,
 		startEventParams={-950,1010,-530,11000,270000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13015] =
{
 		id=13015,
 		describe="餐桌E",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_table_e",
 		startEventTag=2,
 		startEventParams={-5350,1000,275,10000,90000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13016] =
{
 		id=13016,
 		describe="餐桌F",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_table_f",
 		startEventTag=2,
 		startEventParams={-5350,1000,-1280,10000,90000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13017] =
{
 		id=13017,
 		describe="餐桌G",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_table_g",
 		startEventTag=2,
 		startEventParams={-4740,1000,1025,9000,270000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[13018] =
{
 		id=13018,
 		describe="餐桌H",
 		timelinePath="Timeline/Prefab/DiningRoom/DiningRoom_table_h",
 		startEventTag=2,
 		startEventParams={-4740,1000,-540,9000,270000,0},
 		endEventTag=1,
 		endEventParams={2},
 		endCameraFov=50,
 	furnitureId={}
},
[100001] =
{
 		id=100001,
 		describe="P1A",
 		timelinePath="Timeline/Prefab/BattleCamAB/P_1_1_A",
 		startEventTag=2,
 		startEventParams={-14020,21690,-19370,45000,107500,0},
 		endEventTag=1,
 		endCameraFov=25,
 	furnitureId={}
},
[100002] =
{
 		id=100002,
 		describe="P1B",
 		timelinePath="Timeline/Prefab/BattleCamAB/P_1_1_B",
 		startEventTag=2,
 		startEventParams={-8330,17060,12750,45000,107500,0},
 		endEventTag=1,
 		endCameraFov=25,
 	furnitureId={}
},
[100003] =
{
 		id=100003,
 		describe="P2A",
 		timelinePath="Timeline/Prefab/BattleCamAB/P_1_2_A",
 		startEventTag=2,
 		startEventParams={-10070,17920,-1737,45000,107500,0},
 		endEventTag=1,
 		endCameraFov=25,
 	furnitureId={}
},
[100004] =
{
 		id=100004,
 		describe="P2B",
 		timelinePath="Timeline/Prefab/BattleCamAB/P_1_2_B",
 		startEventTag=2,
 		startEventParams={-7210,16570,16820,45000,107500,0},
 		endEventTag=1,
 		endCameraFov=25,
 	furnitureId={}
},
[100005] =
{
 		id=100005,
 		describe="P3A",
 		timelinePath="Timeline/Prefab/BattleCamAB/P_1_3_A",
 		startEventTag=2,
 		startEventParams={-11290,20380,-12640,45000,107500,0},
 		endEventTag=1,
 		endCameraFov=25,
 	furnitureId={}
},
[100006] =
{
 		id=100006,
 		describe="P3B",
 		timelinePath="Timeline/Prefab/BattleCamAB/P_1_3_B",
 		startEventTag=2,
 		startEventParams={-11210,20370,17530,45000,107500,0},
 		endEventTag=1,
 		endCameraFov=25,
 	furnitureId={}
},
[100007] =
{
 		id=100007,
 		describe="P4A",
 		timelinePath="Timeline/Prefab/BattleCamAB/P_1_4_A",
 		startEventTag=2,
 		startEventParams={-8880,18820,-5010,45000,107500,0},
 		endEventTag=1,
 		endCameraFov=25,
 	furnitureId={}
},
[100008] =
{
 		id=100008,
 		describe="P4B",
 		timelinePath="Timeline/Prefab/BattleCamAB/P_1_4_B",
 		startEventTag=2,
 		startEventParams={-9530,19550,18590,45000,107500,0},
 		endEventTag=1,
 		endCameraFov=25,
 	furnitureId={}
},
[100009] =
{
 		id=100009,
 		describe="P5A",
 		timelinePath="Timeline/Prefab/BattleCamAB/P_1_5_A",
 		startEventTag=2,
 		startEventParams={-11700,20180,-11190,45000,107500,0},
 		endEventTag=1,
 		endCameraFov=25,
 	furnitureId={}
},
[100010] =
{
 		id=100010,
 		describe="P5B",
 		timelinePath="Timeline/Prefab/BattleCamAB/P_1_5_B",
 		startEventTag=2,
 		startEventParams={-9740,18260,15060,45000,107500,0},
 		endEventTag=1,
 		endCameraFov=25,
 	furnitureId={}
}
}

return {title=title, value=value}