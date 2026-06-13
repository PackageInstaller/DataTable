local title = {
	id = 0,
	activityId = 0,
	wantedLevel = 0,
	wantedExp = 0,
	wantedReward = {}
}

local value = {
[1] =
{
 		id=1,
 		activityId=7001,
 		wantedExp=20,
 	wantedReward={1,1}
},
[2] =
{
 		id=2,
 		activityId=7001,
 		wantedLevel=1,
 		wantedExp=20,
 	wantedReward={101,2}
},
[3] =
{
 		id=3,
 		activityId=7001,
 		wantedLevel=2,
 		wantedExp=20,
 	wantedReward={1,40000}
},
[4] =
{
 		id=4,
 		activityId=7001,
 		wantedLevel=3,
 		wantedExp=20,
 	wantedReward={3,40000}
},
[5] =
{
 		id=5,
 		activityId=7001,
 		wantedLevel=4,
 		wantedExp=20,
 	wantedReward={1,40000}
},
[6] =
{
 		id=6,
 		activityId=7001,
 		wantedLevel=5,
 		wantedExp=20,
 	wantedReward={201,14}
},
[7] =
{
 		id=7,
 		activityId=7001,
 		wantedLevel=6,
 		wantedExp=20,
 	wantedReward={8506,6}
},
[8] =
{
 		id=8,
 		activityId=7001,
 		wantedLevel=7,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[9] =
{
 		id=9,
 		activityId=7001,
 		wantedLevel=8,
 		wantedExp=20,
 	wantedReward={3,50000}
},
[10] =
{
 		id=10,
 		activityId=7001,
 		wantedLevel=9,
 		wantedExp=20,
 	wantedReward={241,6}
},
[11] =
{
 		id=11,
 		activityId=7001,
 		wantedLevel=10,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[12] =
{
 		id=12,
 		activityId=7001,
 		wantedLevel=11,
 		wantedExp=20,
 	wantedReward={202,9}
},
[13] =
{
 		id=13,
 		activityId=7001,
 		wantedLevel=12,
 		wantedExp=20,
 	wantedReward={8507,6}
},
[14] =
{
 		id=14,
 		activityId=7001,
 		wantedLevel=13,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[15] =
{
 		id=15,
 		activityId=7001,
 		wantedLevel=14,
 		wantedExp=20,
 	wantedReward={3,50000}
},
[16] =
{
 		id=16,
 		activityId=7001,
 		wantedLevel=15,
 		wantedExp=20,
 	wantedReward={202,9}
},
[17] =
{
 		id=17,
 		activityId=7001,
 		wantedLevel=16,
 		wantedExp=20,
 	wantedReward={1,60000}
},
[18] =
{
 		id=18,
 		activityId=7001,
 		wantedLevel=17,
 		wantedExp=20,
 	wantedReward={3,60000}
},
[19] =
{
 		id=19,
 		activityId=7001,
 		wantedLevel=18,
 		wantedExp=20,
 	wantedReward={203,4}
},
[20] =
{
 		id=20,
 		activityId=7001,
 		wantedLevel=19,
 		wantedExp=20,
 	wantedReward={251,2}
},
[21] =
{
 		id=21,
 		activityId=7001,
 		wantedLevel=20,
 		wantedExp=20,
 	wantedReward={242,6}
},
[22] =
{
 		id=22,
 		activityId=7001,
 		wantedLevel=21,
 		wantedExp=20,
 	wantedReward={203,4}
},
[23] =
{
 		id=23,
 		activityId=7002,
 		wantedExp=20,
 	wantedReward={1,1}
},
[24] =
{
 		id=24,
 		activityId=7002,
 		wantedLevel=1,
 		wantedExp=20,
 	wantedReward={114,2}
},
[25] =
{
 		id=25,
 		activityId=7002,
 		wantedLevel=2,
 		wantedExp=20,
 	wantedReward={1,40000}
},
[26] =
{
 		id=26,
 		activityId=7002,
 		wantedLevel=3,
 		wantedExp=20,
 	wantedReward={3,40000}
},
[27] =
{
 		id=27,
 		activityId=7002,
 		wantedLevel=4,
 		wantedExp=20,
 	wantedReward={1,40000}
},
[28] =
{
 		id=28,
 		activityId=7002,
 		wantedLevel=5,
 		wantedExp=20,
 	wantedReward={201,14}
},
[29] =
{
 		id=29,
 		activityId=7002,
 		wantedLevel=6,
 		wantedExp=20,
 	wantedReward={8506,6}
},
[30] =
{
 		id=30,
 		activityId=7002,
 		wantedLevel=7,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[31] =
{
 		id=31,
 		activityId=7002,
 		wantedLevel=8,
 		wantedExp=20,
 	wantedReward={3,50000}
},
[32] =
{
 		id=32,
 		activityId=7002,
 		wantedLevel=9,
 		wantedExp=20,
 	wantedReward={241,6}
},
[33] =
{
 		id=33,
 		activityId=7002,
 		wantedLevel=10,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[34] =
{
 		id=34,
 		activityId=7002,
 		wantedLevel=11,
 		wantedExp=20,
 	wantedReward={202,9}
},
[35] =
{
 		id=35,
 		activityId=7002,
 		wantedLevel=12,
 		wantedExp=20,
 	wantedReward={8507,6}
},
[36] =
{
 		id=36,
 		activityId=7002,
 		wantedLevel=13,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[37] =
{
 		id=37,
 		activityId=7002,
 		wantedLevel=14,
 		wantedExp=20,
 	wantedReward={3,50000}
},
[38] =
{
 		id=38,
 		activityId=7002,
 		wantedLevel=15,
 		wantedExp=20,
 	wantedReward={202,9}
},
[39] =
{
 		id=39,
 		activityId=7002,
 		wantedLevel=16,
 		wantedExp=20,
 	wantedReward={1,60000}
},
[40] =
{
 		id=40,
 		activityId=7002,
 		wantedLevel=17,
 		wantedExp=20,
 	wantedReward={3,60000}
},
[41] =
{
 		id=41,
 		activityId=7002,
 		wantedLevel=18,
 		wantedExp=20,
 	wantedReward={203,4}
},
[42] =
{
 		id=42,
 		activityId=7002,
 		wantedLevel=19,
 		wantedExp=20,
 	wantedReward={251,2}
},
[43] =
{
 		id=43,
 		activityId=7002,
 		wantedLevel=20,
 		wantedExp=20,
 	wantedReward={242,6}
},
[44] =
{
 		id=44,
 		activityId=7002,
 		wantedLevel=21,
 		wantedExp=20,
 	wantedReward={203,4}
},
[45] =
{
 		id=45,
 		activityId=7003,
 		wantedExp=20,
 	wantedReward={1,1}
},
[46] =
{
 		id=46,
 		activityId=7003,
 		wantedLevel=1,
 		wantedExp=20,
 	wantedReward={115,2}
},
[47] =
{
 		id=47,
 		activityId=7003,
 		wantedLevel=2,
 		wantedExp=20,
 	wantedReward={1,40000}
},
[48] =
{
 		id=48,
 		activityId=7003,
 		wantedLevel=3,
 		wantedExp=20,
 	wantedReward={3,40000}
},
[49] =
{
 		id=49,
 		activityId=7003,
 		wantedLevel=4,
 		wantedExp=20,
 	wantedReward={1,40000}
},
[50] =
{
 		id=50,
 		activityId=7003,
 		wantedLevel=5,
 		wantedExp=20,
 	wantedReward={201,14}
},
[51] =
{
 		id=51,
 		activityId=7003,
 		wantedLevel=6,
 		wantedExp=20,
 	wantedReward={8506,6}
},
[52] =
{
 		id=52,
 		activityId=7003,
 		wantedLevel=7,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[53] =
{
 		id=53,
 		activityId=7003,
 		wantedLevel=8,
 		wantedExp=20,
 	wantedReward={3,50000}
},
[54] =
{
 		id=54,
 		activityId=7003,
 		wantedLevel=9,
 		wantedExp=20,
 	wantedReward={241,6}
},
[55] =
{
 		id=55,
 		activityId=7003,
 		wantedLevel=10,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[56] =
{
 		id=56,
 		activityId=7003,
 		wantedLevel=11,
 		wantedExp=20,
 	wantedReward={202,9}
},
[57] =
{
 		id=57,
 		activityId=7003,
 		wantedLevel=12,
 		wantedExp=20,
 	wantedReward={8507,6}
},
[58] =
{
 		id=58,
 		activityId=7003,
 		wantedLevel=13,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[59] =
{
 		id=59,
 		activityId=7003,
 		wantedLevel=14,
 		wantedExp=20,
 	wantedReward={3,50000}
},
[60] =
{
 		id=60,
 		activityId=7003,
 		wantedLevel=15,
 		wantedExp=20,
 	wantedReward={202,9}
},
[61] =
{
 		id=61,
 		activityId=7003,
 		wantedLevel=16,
 		wantedExp=20,
 	wantedReward={1,60000}
},
[62] =
{
 		id=62,
 		activityId=7003,
 		wantedLevel=17,
 		wantedExp=20,
 	wantedReward={3,60000}
},
[63] =
{
 		id=63,
 		activityId=7003,
 		wantedLevel=18,
 		wantedExp=20,
 	wantedReward={203,4}
},
[64] =
{
 		id=64,
 		activityId=7003,
 		wantedLevel=19,
 		wantedExp=20,
 	wantedReward={251,2}
},
[65] =
{
 		id=65,
 		activityId=7003,
 		wantedLevel=20,
 		wantedExp=20,
 	wantedReward={242,6}
},
[66] =
{
 		id=66,
 		activityId=7003,
 		wantedLevel=21,
 		wantedExp=20,
 	wantedReward={203,4}
},
[67] =
{
 		id=67,
 		activityId=7004,
 		wantedExp=20,
 	wantedReward={1,1}
},
[68] =
{
 		id=68,
 		activityId=7004,
 		wantedLevel=1,
 		wantedExp=20,
 	wantedReward={116,2}
},
[69] =
{
 		id=69,
 		activityId=7004,
 		wantedLevel=2,
 		wantedExp=20,
 	wantedReward={1,40000}
},
[70] =
{
 		id=70,
 		activityId=7004,
 		wantedLevel=3,
 		wantedExp=20,
 	wantedReward={3,40000}
},
[71] =
{
 		id=71,
 		activityId=7004,
 		wantedLevel=4,
 		wantedExp=20,
 	wantedReward={1,40000}
},
[72] =
{
 		id=72,
 		activityId=7004,
 		wantedLevel=5,
 		wantedExp=20,
 	wantedReward={201,14}
},
[73] =
{
 		id=73,
 		activityId=7004,
 		wantedLevel=6,
 		wantedExp=20,
 	wantedReward={8506,6}
},
[74] =
{
 		id=74,
 		activityId=7004,
 		wantedLevel=7,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[75] =
{
 		id=75,
 		activityId=7004,
 		wantedLevel=8,
 		wantedExp=20,
 	wantedReward={3,50000}
},
[76] =
{
 		id=76,
 		activityId=7004,
 		wantedLevel=9,
 		wantedExp=20,
 	wantedReward={241,6}
},
[77] =
{
 		id=77,
 		activityId=7004,
 		wantedLevel=10,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[78] =
{
 		id=78,
 		activityId=7004,
 		wantedLevel=11,
 		wantedExp=20,
 	wantedReward={202,9}
},
[79] =
{
 		id=79,
 		activityId=7004,
 		wantedLevel=12,
 		wantedExp=20,
 	wantedReward={8507,6}
},
[80] =
{
 		id=80,
 		activityId=7004,
 		wantedLevel=13,
 		wantedExp=20,
 	wantedReward={1,50000}
},
[81] =
{
 		id=81,
 		activityId=7004,
 		wantedLevel=14,
 		wantedExp=20,
 	wantedReward={3,50000}
},
[82] =
{
 		id=82,
 		activityId=7004,
 		wantedLevel=15,
 		wantedExp=20,
 	wantedReward={202,9}
},
[83] =
{
 		id=83,
 		activityId=7004,
 		wantedLevel=16,
 		wantedExp=20,
 	wantedReward={1,60000}
},
[84] =
{
 		id=84,
 		activityId=7004,
 		wantedLevel=17,
 		wantedExp=20,
 	wantedReward={3,60000}
},
[85] =
{
 		id=85,
 		activityId=7004,
 		wantedLevel=18,
 		wantedExp=20,
 	wantedReward={203,4}
},
[86] =
{
 		id=86,
 		activityId=7004,
 		wantedLevel=19,
 		wantedExp=20,
 	wantedReward={251,2}
},
[87] =
{
 		id=87,
 		activityId=7004,
 		wantedLevel=20,
 		wantedExp=20,
 	wantedReward={242,6}
},
[88] =
{
 		id=88,
 		activityId=7004,
 		wantedLevel=21,
 		wantedExp=20,
 	wantedReward={203,4}
}
}

return {title=title, value=value}