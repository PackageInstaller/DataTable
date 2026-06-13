local title = {
	id = 0,
	aiType = 0,
	star = 0,
	needLevel = 0,
	costItems = {},
	costNum = {},
	attributeType = {},
	attributeValue = {}
}

local value = {
[1] =
{
 		id=1,
 		aiType=110001001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[2] =
{
 		id=2,
 		aiType=110001001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={5,2}
},
[3] =
{
 		id=3,
 		aiType=110001001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={11,4}
},
[4] =
{
 		id=4,
 		aiType=110001001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={16,6}
},
[5] =
{
 		id=5,
 		aiType=110001001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={21,8}
},
[6] =
{
 		id=6,
 		aiType=110001001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={27,10}
},
[7] =
{
 		id=7,
 		aiType=110001001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={32,12}
},
[8] =
{
 		id=8,
 		aiType=110001002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[9] =
{
 		id=9,
 		aiType=110001002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[10] =
{
 		id=10,
 		aiType=110001002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={14}
},
[11] =
{
 		id=11,
 		aiType=110001002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={21}
},
[12] =
{
 		id=12,
 		aiType=110001002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={28}
},
[13] =
{
 		id=13,
 		aiType=110001002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={35}
},
[14] =
{
 		id=14,
 		aiType=110001002,
 		star=6,
 		attributeType={2},
 	attributeValue={42}
},
[15] =
{
 		id=15,
 		aiType=110001003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[16] =
{
 		id=16,
 		aiType=110001003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={5,19}
},
[17] =
{
 		id=17,
 		aiType=110001003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={10,38}
},
[18] =
{
 		id=18,
 		aiType=110001003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={15,57}
},
[19] =
{
 		id=19,
 		aiType=110001003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={20,76}
},
[20] =
{
 		id=20,
 		aiType=110001003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={25,95}
},
[21] =
{
 		id=21,
 		aiType=110001003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={30,114}
},
[22] =
{
 		id=22,
 		aiType=110001004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[23] =
{
 		id=23,
 		aiType=110001004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={76,1}
},
[24] =
{
 		id=24,
 		aiType=110001004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={152,3}
},
[25] =
{
 		id=25,
 		aiType=110001004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={228,4}
},
[26] =
{
 		id=26,
 		aiType=110001004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={305,5}
},
[27] =
{
 		id=27,
 		aiType=110001004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={381,7}
},
[28] =
{
 		id=28,
 		aiType=110001004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={457,8}
},
[29] =
{
 		id=29,
 		aiType=110001005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[30] =
{
 		id=30,
 		aiType=110001005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={3,6}
},
[31] =
{
 		id=31,
 		aiType=110001005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={7,12}
},
[32] =
{
 		id=32,
 		aiType=110001005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={10,18}
},
[33] =
{
 		id=33,
 		aiType=110001005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={13,24}
},
[34] =
{
 		id=34,
 		aiType=110001005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={17,30}
},
[35] =
{
 		id=35,
 		aiType=110001005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={20,36}
},
[36] =
{
 		id=36,
 		aiType=110002001,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[37] =
{
 		id=37,
 		aiType=110002001,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={73,5}
},
[38] =
{
 		id=38,
 		aiType=110002001,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={146,9}
},
[39] =
{
 		id=39,
 		aiType=110002001,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={219,14}
},
[40] =
{
 		id=40,
 		aiType=110002001,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={292,18}
},
[41] =
{
 		id=41,
 		aiType=110002001,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={365,23}
},
[42] =
{
 		id=42,
 		aiType=110002001,
 		star=6,
 		attributeType={1,2},
 	attributeValue={439,27}
},
[43] =
{
 		id=43,
 		aiType=110002002,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3},
 	attributeValue={0}
},
[44] =
{
 		id=44,
 		aiType=110002002,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3},
 	attributeValue={12}
},
[45] =
{
 		id=45,
 		aiType=110002002,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3},
 	attributeValue={24}
},
[46] =
{
 		id=46,
 		aiType=110002002,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3},
 	attributeValue={37}
},
[47] =
{
 		id=47,
 		aiType=110002002,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3},
 	attributeValue={49}
},
[48] =
{
 		id=48,
 		aiType=110002002,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3},
 	attributeValue={61}
},
[49] =
{
 		id=49,
 		aiType=110002002,
 		star=6,
 		attributeType={3},
 	attributeValue={73}
},
[50] =
{
 		id=50,
 		aiType=110002003,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[51] =
{
 		id=51,
 		aiType=110002003,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={7,9}
},
[52] =
{
 		id=52,
 		aiType=110002003,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={14,18}
},
[53] =
{
 		id=53,
 		aiType=110002003,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={21,27}
},
[54] =
{
 		id=54,
 		aiType=110002003,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={27,37}
},
[55] =
{
 		id=55,
 		aiType=110002003,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={34,46}
},
[56] =
{
 		id=56,
 		aiType=110002003,
 		star=6,
 		attributeType={4,2},
 	attributeValue={41,55}
},
[57] =
{
 		id=57,
 		aiType=110002004,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[58] =
{
 		id=58,
 		aiType=110002004,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={9,3}
},
[59] =
{
 		id=59,
 		aiType=110002004,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={18,6}
},
[60] =
{
 		id=60,
 		aiType=110002004,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={27,9}
},
[61] =
{
 		id=61,
 		aiType=110002004,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={37,12}
},
[62] =
{
 		id=62,
 		aiType=110002004,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={46,15}
},
[63] =
{
 		id=63,
 		aiType=110002004,
 		star=6,
 		attributeType={2,3},
 	attributeValue={55,18}
},
[64] =
{
 		id=64,
 		aiType=110002005,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[65] =
{
 		id=65,
 		aiType=110002005,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={73,5}
},
[66] =
{
 		id=66,
 		aiType=110002005,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={146,10}
},
[67] =
{
 		id=67,
 		aiType=110002005,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={219,15}
},
[68] =
{
 		id=68,
 		aiType=110002005,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={292,20}
},
[69] =
{
 		id=69,
 		aiType=110002005,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={365,25}
},
[70] =
{
 		id=70,
 		aiType=110002005,
 		star=6,
 		attributeType={1,3},
 	attributeValue={439,31}
},
[71] =
{
 		id=71,
 		aiType=110003001,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[72] =
{
 		id=72,
 		aiType=110003001,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[73] =
{
 		id=73,
 		aiType=110003001,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={14}
},
[74] =
{
 		id=74,
 		aiType=110003001,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={21}
},
[75] =
{
 		id=75,
 		aiType=110003001,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={28}
},
[76] =
{
 		id=76,
 		aiType=110003001,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={35}
},
[77] =
{
 		id=77,
 		aiType=110003001,
 		star=6,
 		attributeType={2},
 	attributeValue={42}
},
[78] =
{
 		id=78,
 		aiType=110003002,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[79] =
{
 		id=79,
 		aiType=110003002,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={4,50}
},
[80] =
{
 		id=80,
 		aiType=110003002,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={7,100}
},
[81] =
{
 		id=81,
 		aiType=110003002,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={11,149}
},
[82] =
{
 		id=82,
 		aiType=110003002,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={14,199}
},
[83] =
{
 		id=83,
 		aiType=110003002,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={18,249}
},
[84] =
{
 		id=84,
 		aiType=110003002,
 		star=6,
 		attributeType={4,1},
 	attributeValue={21,299}
},
[85] =
{
 		id=85,
 		aiType=110003003,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[86] =
{
 		id=86,
 		aiType=110003003,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[87] =
{
 		id=87,
 		aiType=110003003,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={16}
},
[88] =
{
 		id=88,
 		aiType=110003003,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={24}
},
[89] =
{
 		id=89,
 		aiType=110003003,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={32}
},
[90] =
{
 		id=90,
 		aiType=110003003,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={40}
},
[91] =
{
 		id=91,
 		aiType=110003003,
 		star=6,
 		attributeType={2},
 	attributeValue={48}
},
[92] =
{
 		id=92,
 		aiType=110003004,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[93] =
{
 		id=93,
 		aiType=110003004,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,2}
},
[94] =
{
 		id=94,
 		aiType=110003004,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={14,4}
},
[95] =
{
 		id=95,
 		aiType=110003004,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={22,6}
},
[96] =
{
 		id=96,
 		aiType=110003004,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={29,8}
},
[97] =
{
 		id=97,
 		aiType=110003004,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={36,10}
},
[98] =
{
 		id=98,
 		aiType=110003004,
 		star=6,
 		attributeType={3,2},
 	attributeValue={43,12}
},
[99] =
{
 		id=99,
 		aiType=110003005,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[100] =
{
 		id=100,
 		aiType=110003005,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={50,3}
},
[101] =
{
 		id=101,
 		aiType=110003005,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={100,6}
},
[102] =
{
 		id=102,
 		aiType=110003005,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={149,9}
},
[103] =
{
 		id=103,
 		aiType=110003005,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={199,12}
},
[104] =
{
 		id=104,
 		aiType=110003005,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={249,15}
},
[105] =
{
 		id=105,
 		aiType=110003005,
 		star=6,
 		attributeType={1,2},
 	attributeValue={299,18}
},
[106] =
{
 		id=106,
 		aiType=110004001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[107] =
{
 		id=107,
 		aiType=110004001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={6,4}
},
[108] =
{
 		id=108,
 		aiType=110004001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={12,7}
},
[109] =
{
 		id=109,
 		aiType=110004001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={18,11}
},
[110] =
{
 		id=110,
 		aiType=110004001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={25,15}
},
[111] =
{
 		id=111,
 		aiType=110004001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={31,19}
},
[112] =
{
 		id=112,
 		aiType=110004001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={37,22}
},
[113] =
{
 		id=113,
 		aiType=110004002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[114] =
{
 		id=114,
 		aiType=110004002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={13}
},
[115] =
{
 		id=115,
 		aiType=110004002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={26}
},
[116] =
{
 		id=116,
 		aiType=110004002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={39}
},
[117] =
{
 		id=117,
 		aiType=110004002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={52}
},
[118] =
{
 		id=118,
 		aiType=110004002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={65}
},
[119] =
{
 		id=119,
 		aiType=110004002,
 		star=6,
 		attributeType={2},
 	attributeValue={78}
},
[120] =
{
 		id=120,
 		aiType=110004003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[121] =
{
 		id=121,
 		aiType=110004003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={9,19}
},
[122] =
{
 		id=122,
 		aiType=110004003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={19,38}
},
[123] =
{
 		id=123,
 		aiType=110004003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={28,58}
},
[124] =
{
 		id=124,
 		aiType=110004003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={37,77}
},
[125] =
{
 		id=125,
 		aiType=110004003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={46,96}
},
[126] =
{
 		id=126,
 		aiType=110004003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={56,115}
},
[127] =
{
 		id=127,
 		aiType=110004004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[128] =
{
 		id=128,
 		aiType=110004004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={77,2}
},
[129] =
{
 		id=129,
 		aiType=110004004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={154,3}
},
[130] =
{
 		id=130,
 		aiType=110004004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={230,5}
},
[131] =
{
 		id=131,
 		aiType=110004004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={307,6}
},
[132] =
{
 		id=132,
 		aiType=110004004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={384,8}
},
[133] =
{
 		id=133,
 		aiType=110004004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={461,9}
},
[134] =
{
 		id=134,
 		aiType=110004005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[135] =
{
 		id=135,
 		aiType=110004005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={4,11}
},
[136] =
{
 		id=136,
 		aiType=110004005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={8,22}
},
[137] =
{
 		id=137,
 		aiType=110004005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={12,33}
},
[138] =
{
 		id=138,
 		aiType=110004005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={15,45}
},
[139] =
{
 		id=139,
 		aiType=110004005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={19,56}
},
[140] =
{
 		id=140,
 		aiType=110004005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={23,67}
},
[141] =
{
 		id=141,
 		aiType=110005001,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[142] =
{
 		id=142,
 		aiType=110005001,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={11}
},
[143] =
{
 		id=143,
 		aiType=110005001,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={22}
},
[144] =
{
 		id=144,
 		aiType=110005001,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={33}
},
[145] =
{
 		id=145,
 		aiType=110005001,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={45}
},
[146] =
{
 		id=146,
 		aiType=110005001,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={56}
},
[147] =
{
 		id=147,
 		aiType=110005001,
 		star=6,
 		attributeType={2},
 	attributeValue={67}
},
[148] =
{
 		id=148,
 		aiType=110005002,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[149] =
{
 		id=149,
 		aiType=110005002,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={8,8}
},
[150] =
{
 		id=150,
 		aiType=110005002,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={15,17}
},
[151] =
{
 		id=151,
 		aiType=110005002,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={23,25}
},
[152] =
{
 		id=152,
 		aiType=110005002,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={30,33}
},
[153] =
{
 		id=153,
 		aiType=110005002,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={38,42}
},
[154] =
{
 		id=154,
 		aiType=110005002,
 		star=6,
 		attributeType={4,2},
 	attributeValue={45,50}
},
[155] =
{
 		id=155,
 		aiType=110005003,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[156] =
{
 		id=156,
 		aiType=110005003,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={12,15}
},
[157] =
{
 		id=157,
 		aiType=110005003,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={24,31}
},
[158] =
{
 		id=158,
 		aiType=110005003,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={36,46}
},
[159] =
{
 		id=159,
 		aiType=110005003,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={48,62}
},
[160] =
{
 		id=160,
 		aiType=110005003,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={60,77}
},
[161] =
{
 		id=161,
 		aiType=110005003,
 		star=6,
 		attributeType={3,1},
 	attributeValue={72,93}
},
[162] =
{
 		id=162,
 		aiType=110005004,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[163] =
{
 		id=163,
 		aiType=110005004,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={139}
},
[164] =
{
 		id=164,
 		aiType=110005004,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={279}
},
[165] =
{
 		id=165,
 		aiType=110005004,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={418}
},
[166] =
{
 		id=166,
 		aiType=110005004,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={557}
},
[167] =
{
 		id=167,
 		aiType=110005004,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={697}
},
[168] =
{
 		id=168,
 		aiType=110005004,
 		star=6,
 		attributeType={1},
 	attributeValue={836}
},
[169] =
{
 		id=169,
 		aiType=110005005,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[170] =
{
 		id=170,
 		aiType=110005005,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={8,3}
},
[171] =
{
 		id=171,
 		aiType=110005005,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={17,6}
},
[172] =
{
 		id=172,
 		aiType=110005005,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={25,9}
},
[173] =
{
 		id=173,
 		aiType=110005005,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={33,12}
},
[174] =
{
 		id=174,
 		aiType=110005005,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={42,15}
},
[175] =
{
 		id=175,
 		aiType=110005005,
 		star=6,
 		attributeType={2,3},
 	attributeValue={50,18}
},
[176] =
{
 		id=176,
 		aiType=110006001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[177] =
{
 		id=177,
 		aiType=110006001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={5,2}
},
[178] =
{
 		id=178,
 		aiType=110006001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={10,4}
},
[179] =
{
 		id=179,
 		aiType=110006001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={15,6}
},
[180] =
{
 		id=180,
 		aiType=110006001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={20,8}
},
[181] =
{
 		id=181,
 		aiType=110006001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={25,10}
},
[182] =
{
 		id=182,
 		aiType=110006001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={30,12}
},
[183] =
{
 		id=183,
 		aiType=110006002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[184] =
{
 		id=184,
 		aiType=110006002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[185] =
{
 		id=185,
 		aiType=110006002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={14}
},
[186] =
{
 		id=186,
 		aiType=110006002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={20}
},
[187] =
{
 		id=187,
 		aiType=110006002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={27}
},
[188] =
{
 		id=188,
 		aiType=110006002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={34}
},
[189] =
{
 		id=189,
 		aiType=110006002,
 		star=6,
 		attributeType={2},
 	attributeValue={41}
},
[190] =
{
 		id=190,
 		aiType=110006003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[191] =
{
 		id=191,
 		aiType=110006003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={5,18}
},
[192] =
{
 		id=192,
 		aiType=110006003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={10,35}
},
[193] =
{
 		id=193,
 		aiType=110006003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={15,53}
},
[194] =
{
 		id=194,
 		aiType=110006003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={20,71}
},
[195] =
{
 		id=195,
 		aiType=110006003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={24,89}
},
[196] =
{
 		id=196,
 		aiType=110006003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={29,106}
},
[197] =
{
 		id=197,
 		aiType=110006004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[198] =
{
 		id=198,
 		aiType=110006004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={71,1}
},
[199] =
{
 		id=199,
 		aiType=110006004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={142,2}
},
[200] =
{
 		id=200,
 		aiType=110006004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={212,4}
},
[201] =
{
 		id=201,
 		aiType=110006004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={283,5}
},
[202] =
{
 		id=202,
 		aiType=110006004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={354,6}
},
[203] =
{
 		id=203,
 		aiType=110006004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={425,7}
},
[204] =
{
 		id=204,
 		aiType=110006005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[205] =
{
 		id=205,
 		aiType=110006005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={3,6}
},
[206] =
{
 		id=206,
 		aiType=110006005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={6,12}
},
[207] =
{
 		id=207,
 		aiType=110006005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={10,18}
},
[208] =
{
 		id=208,
 		aiType=110006005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={13,23}
},
[209] =
{
 		id=209,
 		aiType=110006005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={16,29}
},
[210] =
{
 		id=210,
 		aiType=110006005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={19,35}
},
[211] =
{
 		id=211,
 		aiType=110007001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[212] =
{
 		id=212,
 		aiType=110007001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={8,66}
},
[213] =
{
 		id=213,
 		aiType=110007001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={17,131}
},
[214] =
{
 		id=214,
 		aiType=110007001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={25,197}
},
[215] =
{
 		id=215,
 		aiType=110007001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={33,263}
},
[216] =
{
 		id=216,
 		aiType=110007001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={42,328}
},
[217] =
{
 		id=217,
 		aiType=110007001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={50,394}
},
[218] =
{
 		id=218,
 		aiType=110007002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[219] =
{
 		id=219,
 		aiType=110007002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[220] =
{
 		id=220,
 		aiType=110007002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={15}
},
[221] =
{
 		id=221,
 		aiType=110007002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={22}
},
[222] =
{
 		id=222,
 		aiType=110007002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={29}
},
[223] =
{
 		id=223,
 		aiType=110007002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={37}
},
[224] =
{
 		id=224,
 		aiType=110007002,
 		star=6,
 		attributeType={2},
 	attributeValue={44}
},
[225] =
{
 		id=225,
 		aiType=110007003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[226] =
{
 		id=226,
 		aiType=110007003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,2}
},
[227] =
{
 		id=227,
 		aiType=110007003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={13,5}
},
[228] =
{
 		id=228,
 		aiType=110007003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={20,7}
},
[229] =
{
 		id=229,
 		aiType=110007003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={27,10}
},
[230] =
{
 		id=230,
 		aiType=110007003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={33,12}
},
[231] =
{
 		id=231,
 		aiType=110007003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={40,15}
},
[232] =
{
 		id=232,
 		aiType=110007004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[233] =
{
 		id=233,
 		aiType=110007004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={22,6}
},
[234] =
{
 		id=234,
 		aiType=110007004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={44,12}
},
[235] =
{
 		id=235,
 		aiType=110007004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={66,18}
},
[236] =
{
 		id=236,
 		aiType=110007004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={88,24}
},
[237] =
{
 		id=237,
 		aiType=110007004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={109,30}
},
[238] =
{
 		id=238,
 		aiType=110007004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={131,37}
},
[239] =
{
 		id=239,
 		aiType=110007005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[240] =
{
 		id=240,
 		aiType=110007005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[241] =
{
 		id=241,
 		aiType=110007005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={17}
},
[242] =
{
 		id=242,
 		aiType=110007005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={26}
},
[243] =
{
 		id=243,
 		aiType=110007005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={34}
},
[244] =
{
 		id=244,
 		aiType=110007005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={43}
},
[245] =
{
 		id=245,
 		aiType=110007005,
 		star=6,
 		attributeType={2},
 	attributeValue={51}
},
[246] =
{
 		id=246,
 		aiType=110008001,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[247] =
{
 		id=247,
 		aiType=110008001,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={10}
},
[248] =
{
 		id=248,
 		aiType=110008001,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={20}
},
[249] =
{
 		id=249,
 		aiType=110008001,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={30}
},
[250] =
{
 		id=250,
 		aiType=110008001,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={40}
},
[251] =
{
 		id=251,
 		aiType=110008001,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={50}
},
[252] =
{
 		id=252,
 		aiType=110008001,
 		star=6,
 		attributeType={2},
 	attributeValue={60}
},
[253] =
{
 		id=253,
 		aiType=110008002,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[254] =
{
 		id=254,
 		aiType=110008002,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={6,8}
},
[255] =
{
 		id=255,
 		aiType=110008002,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={12,15}
},
[256] =
{
 		id=256,
 		aiType=110008002,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={19,23}
},
[257] =
{
 		id=257,
 		aiType=110008002,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={25,30}
},
[258] =
{
 		id=258,
 		aiType=110008002,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={31,38}
},
[259] =
{
 		id=259,
 		aiType=110008002,
 		star=6,
 		attributeType={4,2},
 	attributeValue={37,45}
},
[260] =
{
 		id=260,
 		aiType=110008003,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[261] =
{
 		id=261,
 		aiType=110008003,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={10,12}
},
[262] =
{
 		id=262,
 		aiType=110008003,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={19,25}
},
[263] =
{
 		id=263,
 		aiType=110008003,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={29,37}
},
[264] =
{
 		id=264,
 		aiType=110008003,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={39,50}
},
[265] =
{
 		id=265,
 		aiType=110008003,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={49,62}
},
[266] =
{
 		id=266,
 		aiType=110008003,
 		star=6,
 		attributeType={3,1},
 	attributeValue={58,75}
},
[267] =
{
 		id=267,
 		aiType=110008004,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[268] =
{
 		id=268,
 		aiType=110008004,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={112}
},
[269] =
{
 		id=269,
 		aiType=110008004,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={224}
},
[270] =
{
 		id=270,
 		aiType=110008004,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={337}
},
[271] =
{
 		id=271,
 		aiType=110008004,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={449}
},
[272] =
{
 		id=272,
 		aiType=110008004,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={561}
},
[273] =
{
 		id=273,
 		aiType=110008004,
 		star=6,
 		attributeType={1},
 	attributeValue={673}
},
[274] =
{
 		id=274,
 		aiType=110008005,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[275] =
{
 		id=275,
 		aiType=110008005,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={8,2}
},
[276] =
{
 		id=276,
 		aiType=110008005,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={15,5}
},
[277] =
{
 		id=277,
 		aiType=110008005,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={23,7}
},
[278] =
{
 		id=278,
 		aiType=110008005,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={30,10}
},
[279] =
{
 		id=279,
 		aiType=110008005,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={38,12}
},
[280] =
{
 		id=280,
 		aiType=110008005,
 		star=6,
 		attributeType={2,3},
 	attributeValue={45,15}
},
[281] =
{
 		id=281,
 		aiType=110009001,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[282] =
{
 		id=282,
 		aiType=110009001,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[283] =
{
 		id=283,
 		aiType=110009001,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={13}
},
[284] =
{
 		id=284,
 		aiType=110009001,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={20}
},
[285] =
{
 		id=285,
 		aiType=110009001,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={27}
},
[286] =
{
 		id=286,
 		aiType=110009001,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={33}
},
[287] =
{
 		id=287,
 		aiType=110009001,
 		star=6,
 		attributeType={2},
 	attributeValue={40}
},
[288] =
{
 		id=288,
 		aiType=110009002,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[289] =
{
 		id=289,
 		aiType=110009002,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={4,54}
},
[290] =
{
 		id=290,
 		aiType=110009002,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={8,107}
},
[291] =
{
 		id=291,
 		aiType=110009002,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={12,161}
},
[292] =
{
 		id=292,
 		aiType=110009002,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={15,214}
},
[293] =
{
 		id=293,
 		aiType=110009002,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={19,268}
},
[294] =
{
 		id=294,
 		aiType=110009002,
 		star=6,
 		attributeType={4,1},
 	attributeValue={23,321}
},
[295] =
{
 		id=295,
 		aiType=110009003,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[296] =
{
 		id=296,
 		aiType=110009003,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[297] =
{
 		id=297,
 		aiType=110009003,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={15}
},
[298] =
{
 		id=298,
 		aiType=110009003,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={23}
},
[299] =
{
 		id=299,
 		aiType=110009003,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={30}
},
[300] =
{
 		id=300,
 		aiType=110009003,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={38}
},
[301] =
{
 		id=301,
 		aiType=110009003,
 		star=6,
 		attributeType={2},
 	attributeValue={46}
},
[302] =
{
 		id=302,
 		aiType=110009004,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[303] =
{
 		id=303,
 		aiType=110009004,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={8,2}
},
[304] =
{
 		id=304,
 		aiType=110009004,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={15,4}
},
[305] =
{
 		id=305,
 		aiType=110009004,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={23,6}
},
[306] =
{
 		id=306,
 		aiType=110009004,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={30,8}
},
[307] =
{
 		id=307,
 		aiType=110009004,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={38,10}
},
[308] =
{
 		id=308,
 		aiType=110009004,
 		star=6,
 		attributeType={3,2},
 	attributeValue={45,11}
},
[309] =
{
 		id=309,
 		aiType=110009005,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[310] =
{
 		id=310,
 		aiType=110009005,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={54,3}
},
[311] =
{
 		id=311,
 		aiType=110009005,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={107,6}
},
[312] =
{
 		id=312,
 		aiType=110009005,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={161,9}
},
[313] =
{
 		id=313,
 		aiType=110009005,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={214,11}
},
[314] =
{
 		id=314,
 		aiType=110009005,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={268,14}
},
[315] =
{
 		id=315,
 		aiType=110009005,
 		star=6,
 		attributeType={1,2},
 	attributeValue={321,17}
},
[316] =
{
 		id=316,
 		aiType=110010001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[317] =
{
 		id=317,
 		aiType=110010001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={9,71}
},
[318] =
{
 		id=318,
 		aiType=110010001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={18,141}
},
[319] =
{
 		id=319,
 		aiType=110010001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={27,212}
},
[320] =
{
 		id=320,
 		aiType=110010001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={35,283}
},
[321] =
{
 		id=321,
 		aiType=110010001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={44,353}
},
[322] =
{
 		id=322,
 		aiType=110010001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={53,424}
},
[323] =
{
 		id=323,
 		aiType=110010002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[324] =
{
 		id=324,
 		aiType=110010002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[325] =
{
 		id=325,
 		aiType=110010002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={15}
},
[326] =
{
 		id=326,
 		aiType=110010002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={23}
},
[327] =
{
 		id=327,
 		aiType=110010002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={31}
},
[328] =
{
 		id=328,
 		aiType=110010002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={39}
},
[329] =
{
 		id=329,
 		aiType=110010002,
 		star=6,
 		attributeType={2},
 	attributeValue={46}
},
[330] =
{
 		id=330,
 		aiType=110010003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[331] =
{
 		id=331,
 		aiType=110010003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,3}
},
[332] =
{
 		id=332,
 		aiType=110010003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={14,5}
},
[333] =
{
 		id=333,
 		aiType=110010003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={22,8}
},
[334] =
{
 		id=334,
 		aiType=110010003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={29,10}
},
[335] =
{
 		id=335,
 		aiType=110010003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={36,13}
},
[336] =
{
 		id=336,
 		aiType=110010003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={43,15}
},
[337] =
{
 		id=337,
 		aiType=110010004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[338] =
{
 		id=338,
 		aiType=110010004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={24,6}
},
[339] =
{
 		id=339,
 		aiType=110010004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={47,13}
},
[340] =
{
 		id=340,
 		aiType=110010004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={71,19}
},
[341] =
{
 		id=341,
 		aiType=110010004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={94,26}
},
[342] =
{
 		id=342,
 		aiType=110010004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={118,32}
},
[343] =
{
 		id=343,
 		aiType=110010004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={141,39}
},
[344] =
{
 		id=344,
 		aiType=110010005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[345] =
{
 		id=345,
 		aiType=110010005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[346] =
{
 		id=346,
 		aiType=110010005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={18}
},
[347] =
{
 		id=347,
 		aiType=110010005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={27}
},
[348] =
{
 		id=348,
 		aiType=110010005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={36}
},
[349] =
{
 		id=349,
 		aiType=110010005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={45}
},
[350] =
{
 		id=350,
 		aiType=110010005,
 		star=6,
 		attributeType={2},
 	attributeValue={54}
},
[351] =
{
 		id=351,
 		aiType=110011001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[352] =
{
 		id=352,
 		aiType=110011001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={6,3}
},
[353] =
{
 		id=353,
 		aiType=110011001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={12,6}
},
[354] =
{
 		id=354,
 		aiType=110011001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={18,9}
},
[355] =
{
 		id=355,
 		aiType=110011001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={24,12}
},
[356] =
{
 		id=356,
 		aiType=110011001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={30,16}
},
[357] =
{
 		id=357,
 		aiType=110011001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={36,19}
},
[358] =
{
 		id=358,
 		aiType=110011002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[359] =
{
 		id=359,
 		aiType=110011002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={11}
},
[360] =
{
 		id=360,
 		aiType=110011002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={22}
},
[361] =
{
 		id=361,
 		aiType=110011002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={33}
},
[362] =
{
 		id=362,
 		aiType=110011002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={44}
},
[363] =
{
 		id=363,
 		aiType=110011002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={55}
},
[364] =
{
 		id=364,
 		aiType=110011002,
 		star=6,
 		attributeType={2},
 	attributeValue={65}
},
[365] =
{
 		id=365,
 		aiType=110011003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[366] =
{
 		id=366,
 		aiType=110011003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={8,19}
},
[367] =
{
 		id=367,
 		aiType=110011003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={16,37}
},
[368] =
{
 		id=368,
 		aiType=110011003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={23,56}
},
[369] =
{
 		id=369,
 		aiType=110011003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={31,74}
},
[370] =
{
 		id=370,
 		aiType=110011003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={39,93}
},
[371] =
{
 		id=371,
 		aiType=110011003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={47,111}
},
[372] =
{
 		id=372,
 		aiType=110011004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[373] =
{
 		id=373,
 		aiType=110011004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={74,2}
},
[374] =
{
 		id=374,
 		aiType=110011004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={148,3}
},
[375] =
{
 		id=375,
 		aiType=110011004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={222,5}
},
[376] =
{
 		id=376,
 		aiType=110011004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={296,6}
},
[377] =
{
 		id=377,
 		aiType=110011004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={370,8}
},
[378] =
{
 		id=378,
 		aiType=110011004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={444,9}
},
[379] =
{
 		id=379,
 		aiType=110011005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[380] =
{
 		id=380,
 		aiType=110011005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={4,9}
},
[381] =
{
 		id=381,
 		aiType=110011005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={8,19}
},
[382] =
{
 		id=382,
 		aiType=110011005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={12,28}
},
[383] =
{
 		id=383,
 		aiType=110011005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={15,37}
},
[384] =
{
 		id=384,
 		aiType=110011005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={19,47}
},
[385] =
{
 		id=385,
 		aiType=110011005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={23,56}
},
[386] =
{
 		id=386,
 		aiType=110012001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[387] =
{
 		id=387,
 		aiType=110012001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={10,80}
},
[388] =
{
 		id=388,
 		aiType=110012001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={19,161}
},
[389] =
{
 		id=389,
 		aiType=110012001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={29,241}
},
[390] =
{
 		id=390,
 		aiType=110012001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={38,321}
},
[391] =
{
 		id=391,
 		aiType=110012001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={48,401}
},
[392] =
{
 		id=392,
 		aiType=110012001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={57,482}
},
[393] =
{
 		id=393,
 		aiType=110012002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[394] =
{
 		id=394,
 		aiType=110012002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[395] =
{
 		id=395,
 		aiType=110012002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={19}
},
[396] =
{
 		id=396,
 		aiType=110012002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={28}
},
[397] =
{
 		id=397,
 		aiType=110012002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={37}
},
[398] =
{
 		id=398,
 		aiType=110012002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={47}
},
[399] =
{
 		id=399,
 		aiType=110012002,
 		star=6,
 		attributeType={2},
 	attributeValue={56}
},
[400] =
{
 		id=400,
 		aiType=110012003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[401] =
{
 		id=401,
 		aiType=110012003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={8,3}
},
[402] =
{
 		id=402,
 		aiType=110012003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={16,6}
},
[403] =
{
 		id=403,
 		aiType=110012003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={25,9}
},
[404] =
{
 		id=404,
 		aiType=110012003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={33,12}
},
[405] =
{
 		id=405,
 		aiType=110012003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={41,16}
},
[406] =
{
 		id=406,
 		aiType=110012003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={49,19}
},
[407] =
{
 		id=407,
 		aiType=110012004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[408] =
{
 		id=408,
 		aiType=110012004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={27,8}
},
[409] =
{
 		id=409,
 		aiType=110012004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={54,16}
},
[410] =
{
 		id=410,
 		aiType=110012004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={80,23}
},
[411] =
{
 		id=411,
 		aiType=110012004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={107,31}
},
[412] =
{
 		id=412,
 		aiType=110012004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={134,39}
},
[413] =
{
 		id=413,
 		aiType=110012004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={161,47}
},
[414] =
{
 		id=414,
 		aiType=110012005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[415] =
{
 		id=415,
 		aiType=110012005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={11}
},
[416] =
{
 		id=416,
 		aiType=110012005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={22}
},
[417] =
{
 		id=417,
 		aiType=110012005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={33}
},
[418] =
{
 		id=418,
 		aiType=110012005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={44}
},
[419] =
{
 		id=419,
 		aiType=110012005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={55}
},
[420] =
{
 		id=420,
 		aiType=110012005,
 		star=6,
 		attributeType={2},
 	attributeValue={65}
},
[421] =
{
 		id=421,
 		aiType=110013001,
 		attributeType={1,2},
 	attributeValue={0,0}
},
[422] =
{
 		id=422,
 		aiType=110013001,
 		star=1,
 		attributeType={1,2},
 	attributeValue={79,5}
},
[423] =
{
 		id=423,
 		aiType=110013001,
 		star=2,
 		attributeType={1,2},
 	attributeValue={157,9}
},
[424] =
{
 		id=424,
 		aiType=110013001,
 		star=3,
 		attributeType={1,2},
 	attributeValue={236,14}
},
[425] =
{
 		id=425,
 		aiType=110013001,
 		star=4,
 		attributeType={1,2},
 	attributeValue={314,19}
},
[426] =
{
 		id=426,
 		aiType=110013001,
 		star=5,
 		attributeType={1,2},
 	attributeValue={393,24}
},
[427] =
{
 		id=427,
 		aiType=110013001,
 		star=6,
 		attributeType={1,2},
 	attributeValue={472,28}
},
[428] =
{
 		id=428,
 		aiType=110013002,
 		attributeType={3},
 	attributeValue={0}
},
[429] =
{
 		id=429,
 		aiType=110013002,
 		star=1,
 		attributeType={3},
 	attributeValue={13}
},
[430] =
{
 		id=430,
 		aiType=110013002,
 		star=2,
 		attributeType={3},
 	attributeValue={26}
},
[431] =
{
 		id=431,
 		aiType=110013002,
 		star=3,
 		attributeType={3},
 	attributeValue={39}
},
[432] =
{
 		id=432,
 		aiType=110013002,
 		star=4,
 		attributeType={3},
 	attributeValue={52}
},
[433] =
{
 		id=433,
 		aiType=110013002,
 		star=5,
 		attributeType={3},
 	attributeValue={66}
},
[434] =
{
 		id=434,
 		aiType=110013002,
 		star=6,
 		attributeType={3},
 	attributeValue={79}
},
[435] =
{
 		id=435,
 		aiType=110013003,
 		attributeType={4,2},
 	attributeValue={0,0}
},
[436] =
{
 		id=436,
 		aiType=110013003,
 		star=1,
 		attributeType={4,2},
 	attributeValue={7,9}
},
[437] =
{
 		id=437,
 		aiType=110013003,
 		star=2,
 		attributeType={4,2},
 	attributeValue={14,19}
},
[438] =
{
 		id=438,
 		aiType=110013003,
 		star=3,
 		attributeType={4,2},
 	attributeValue={22,28}
},
[439] =
{
 		id=439,
 		aiType=110013003,
 		star=4,
 		attributeType={4,2},
 	attributeValue={29,38}
},
[440] =
{
 		id=440,
 		aiType=110013003,
 		star=5,
 		attributeType={4,2},
 	attributeValue={36,47}
},
[441] =
{
 		id=441,
 		aiType=110013003,
 		star=6,
 		attributeType={4,2},
 	attributeValue={43,56}
},
[442] =
{
 		id=442,
 		aiType=110013004,
 		attributeType={2,3},
 	attributeValue={0,0}
},
[443] =
{
 		id=443,
 		aiType=110013004,
 		star=1,
 		attributeType={2,3},
 	attributeValue={9,3}
},
[444] =
{
 		id=444,
 		aiType=110013004,
 		star=2,
 		attributeType={2,3},
 	attributeValue={19,7}
},
[445] =
{
 		id=445,
 		aiType=110013004,
 		star=3,
 		attributeType={2,3},
 	attributeValue={28,10}
},
[446] =
{
 		id=446,
 		aiType=110013004,
 		star=4,
 		attributeType={2,3},
 	attributeValue={38,13}
},
[447] =
{
 		id=447,
 		aiType=110013004,
 		star=5,
 		attributeType={2,3},
 	attributeValue={47,16}
},
[448] =
{
 		id=448,
 		aiType=110013004,
 		star=6,
 		attributeType={2,3},
 	attributeValue={56,20}
},
[449] =
{
 		id=449,
 		aiType=110013005,
 		attributeType={1,3},
 	attributeValue={0,0}
},
[450] =
{
 		id=450,
 		aiType=110013005,
 		star=1,
 		attributeType={1,3},
 	attributeValue={79,5}
},
[451] =
{
 		id=451,
 		aiType=110013005,
 		star=2,
 		attributeType={1,3},
 	attributeValue={157,11}
},
[452] =
{
 		id=452,
 		aiType=110013005,
 		star=3,
 		attributeType={1,3},
 	attributeValue={236,16}
},
[453] =
{
 		id=453,
 		aiType=110013005,
 		star=4,
 		attributeType={1,3},
 	attributeValue={314,22}
},
[454] =
{
 		id=454,
 		aiType=110013005,
 		star=5,
 		attributeType={1,3},
 	attributeValue={393,27}
},
[455] =
{
 		id=455,
 		aiType=110013005,
 		star=6,
 		attributeType={1,3},
 	attributeValue={472,33}
},
[456] =
{
 		id=456,
 		aiType=110014001,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[457] =
{
 		id=457,
 		aiType=110014001,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={11}
},
[458] =
{
 		id=458,
 		aiType=110014001,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={21}
},
[459] =
{
 		id=459,
 		aiType=110014001,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={32}
},
[460] =
{
 		id=460,
 		aiType=110014001,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={43}
},
[461] =
{
 		id=461,
 		aiType=110014001,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={54}
},
[462] =
{
 		id=462,
 		aiType=110014001,
 		star=6,
 		attributeType={2},
 	attributeValue={64}
},
[463] =
{
 		id=463,
 		aiType=110014002,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[464] =
{
 		id=464,
 		aiType=110014002,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={7,8}
},
[465] =
{
 		id=465,
 		aiType=110014002,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={14,16}
},
[466] =
{
 		id=466,
 		aiType=110014002,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={21,24}
},
[467] =
{
 		id=467,
 		aiType=110014002,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={28,32}
},
[468] =
{
 		id=468,
 		aiType=110014002,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={35,40}
},
[469] =
{
 		id=469,
 		aiType=110014002,
 		star=6,
 		attributeType={4,2},
 	attributeValue={42,48}
},
[470] =
{
 		id=470,
 		aiType=110014003,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[471] =
{
 		id=471,
 		aiType=110014003,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={11,14}
},
[472] =
{
 		id=472,
 		aiType=110014003,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={22,29}
},
[473] =
{
 		id=473,
 		aiType=110014003,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={33,43}
},
[474] =
{
 		id=474,
 		aiType=110014003,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={44,58}
},
[475] =
{
 		id=475,
 		aiType=110014003,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={55,72}
},
[476] =
{
 		id=476,
 		aiType=110014003,
 		star=6,
 		attributeType={3,1},
 	attributeValue={66,87}
},
[477] =
{
 		id=477,
 		aiType=110014004,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[478] =
{
 		id=478,
 		aiType=110014004,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={130}
},
[479] =
{
 		id=479,
 		aiType=110014004,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={260}
},
[480] =
{
 		id=480,
 		aiType=110014004,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={389}
},
[481] =
{
 		id=481,
 		aiType=110014004,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={519}
},
[482] =
{
 		id=482,
 		aiType=110014004,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={649}
},
[483] =
{
 		id=483,
 		aiType=110014004,
 		star=6,
 		attributeType={1},
 	attributeValue={779}
},
[484] =
{
 		id=484,
 		aiType=110014005,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[485] =
{
 		id=485,
 		aiType=110014005,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={8,3}
},
[486] =
{
 		id=486,
 		aiType=110014005,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={16,6}
},
[487] =
{
 		id=487,
 		aiType=110014005,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={24,8}
},
[488] =
{
 		id=488,
 		aiType=110014005,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={32,11}
},
[489] =
{
 		id=489,
 		aiType=110014005,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={40,14}
},
[490] =
{
 		id=490,
 		aiType=110014005,
 		star=6,
 		attributeType={2,3},
 	attributeValue={48,17}
},
[491] =
{
 		id=491,
 		aiType=120001001,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[492] =
{
 		id=492,
 		aiType=120001001,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={126}
},
[493] =
{
 		id=493,
 		aiType=120001001,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={252}
},
[494] =
{
 		id=494,
 		aiType=120001001,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={378}
},
[495] =
{
 		id=495,
 		aiType=120001001,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={505}
},
[496] =
{
 		id=496,
 		aiType=120001001,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={631}
},
[497] =
{
 		id=497,
 		aiType=120001001,
 		star=6,
 		attributeType={1},
 	attributeValue={757}
},
[498] =
{
 		id=498,
 		aiType=120001002,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[499] =
{
 		id=499,
 		aiType=120001002,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={11,16}
},
[500] =
{
 		id=500,
 		aiType=120001002,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={21,32}
},
[501] =
{
 		id=501,
 		aiType=120001002,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={32,47}
},
[502] =
{
 		id=502,
 		aiType=120001002,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={42,63}
},
[503] =
{
 		id=503,
 		aiType=120001002,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={53,79}
},
[504] =
{
 		id=504,
 		aiType=120001002,
 		star=6,
 		attributeType={3,1},
 	attributeValue={63,95}
},
[505] =
{
 		id=505,
 		aiType=120001003,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[506] =
{
 		id=506,
 		aiType=120001003,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={8,16}
},
[507] =
{
 		id=507,
 		aiType=120001003,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={16,32}
},
[508] =
{
 		id=508,
 		aiType=120001003,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={24,47}
},
[509] =
{
 		id=509,
 		aiType=120001003,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={32,63}
},
[510] =
{
 		id=510,
 		aiType=120001003,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={40,79}
},
[511] =
{
 		id=511,
 		aiType=120001003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={48,95}
},
[512] =
{
 		id=512,
 		aiType=120001004,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[513] =
{
 		id=513,
 		aiType=120001004,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={11}
},
[514] =
{
 		id=514,
 		aiType=120001004,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={21}
},
[515] =
{
 		id=515,
 		aiType=120001004,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={32}
},
[516] =
{
 		id=516,
 		aiType=120001004,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={43}
},
[517] =
{
 		id=517,
 		aiType=120001004,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={53}
},
[518] =
{
 		id=518,
 		aiType=120001004,
 		star=6,
 		attributeType={2},
 	attributeValue={64}
},
[519] =
{
 		id=519,
 		aiType=120001005,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[520] =
{
 		id=520,
 		aiType=120001005,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={5,8}
},
[521] =
{
 		id=521,
 		aiType=120001005,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={10,16}
},
[522] =
{
 		id=522,
 		aiType=120001005,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={16,24}
},
[523] =
{
 		id=523,
 		aiType=120001005,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={21,32}
},
[524] =
{
 		id=524,
 		aiType=120001005,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={26,40}
},
[525] =
{
 		id=525,
 		aiType=120001005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={31,48}
},
[526] =
{
 		id=526,
 		aiType=120002001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[527] =
{
 		id=527,
 		aiType=120002001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={6,4}
},
[528] =
{
 		id=528,
 		aiType=120002001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={11,7}
},
[529] =
{
 		id=529,
 		aiType=120002001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={17,11}
},
[530] =
{
 		id=530,
 		aiType=120002001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={23,14}
},
[531] =
{
 		id=531,
 		aiType=120002001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={29,18}
},
[532] =
{
 		id=532,
 		aiType=120002001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={34,21}
},
[533] =
{
 		id=533,
 		aiType=120002002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[534] =
{
 		id=534,
 		aiType=120002002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={12}
},
[535] =
{
 		id=535,
 		aiType=120002002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={25}
},
[536] =
{
 		id=536,
 		aiType=120002002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={37}
},
[537] =
{
 		id=537,
 		aiType=120002002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={50}
},
[538] =
{
 		id=538,
 		aiType=120002002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={62}
},
[539] =
{
 		id=539,
 		aiType=120002002,
 		star=6,
 		attributeType={2},
 	attributeValue={75}
},
[540] =
{
 		id=540,
 		aiType=120002003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[541] =
{
 		id=541,
 		aiType=120002003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={9,18}
},
[542] =
{
 		id=542,
 		aiType=120002003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={18,36}
},
[543] =
{
 		id=543,
 		aiType=120002003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={27,54}
},
[544] =
{
 		id=544,
 		aiType=120002003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={36,71}
},
[545] =
{
 		id=545,
 		aiType=120002003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={44,89}
},
[546] =
{
 		id=546,
 		aiType=120002003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={53,107}
},
[547] =
{
 		id=547,
 		aiType=120002004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[548] =
{
 		id=548,
 		aiType=120002004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={71,1}
},
[549] =
{
 		id=549,
 		aiType=120002004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={143,3}
},
[550] =
{
 		id=550,
 		aiType=120002004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={214,4}
},
[551] =
{
 		id=551,
 		aiType=120002004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={286,6}
},
[552] =
{
 		id=552,
 		aiType=120002004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={357,7}
},
[553] =
{
 		id=553,
 		aiType=120002004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={429,9}
},
[554] =
{
 		id=554,
 		aiType=120002005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[555] =
{
 		id=555,
 		aiType=120002005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={4,11}
},
[556] =
{
 		id=556,
 		aiType=120002005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={7,21}
},
[557] =
{
 		id=557,
 		aiType=120002005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={11,32}
},
[558] =
{
 		id=558,
 		aiType=120002005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={15,43}
},
[559] =
{
 		id=559,
 		aiType=120002005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={18,53}
},
[560] =
{
 		id=560,
 		aiType=120002005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={22,64}
},
[561] =
{
 		id=561,
 		aiType=120003001,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[562] =
{
 		id=562,
 		aiType=120003001,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[563] =
{
 		id=563,
 		aiType=120003001,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={15}
},
[564] =
{
 		id=564,
 		aiType=120003001,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={22}
},
[565] =
{
 		id=565,
 		aiType=120003001,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={30}
},
[566] =
{
 		id=566,
 		aiType=120003001,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={37}
},
[567] =
{
 		id=567,
 		aiType=120003001,
 		star=6,
 		attributeType={2},
 	attributeValue={45}
},
[568] =
{
 		id=568,
 		aiType=120003002,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[569] =
{
 		id=569,
 		aiType=120003002,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={4,54}
},
[570] =
{
 		id=570,
 		aiType=120003002,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={8,107}
},
[571] =
{
 		id=571,
 		aiType=120003002,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={12,161}
},
[572] =
{
 		id=572,
 		aiType=120003002,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={15,214}
},
[573] =
{
 		id=573,
 		aiType=120003002,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={19,268}
},
[574] =
{
 		id=574,
 		aiType=120003002,
 		star=6,
 		attributeType={4,1},
 	attributeValue={23,321}
},
[575] =
{
 		id=575,
 		aiType=120003003,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[576] =
{
 		id=576,
 		aiType=120003003,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[577] =
{
 		id=577,
 		aiType=120003003,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={17}
},
[578] =
{
 		id=578,
 		aiType=120003003,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={26}
},
[579] =
{
 		id=579,
 		aiType=120003003,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={34}
},
[580] =
{
 		id=580,
 		aiType=120003003,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={43}
},
[581] =
{
 		id=581,
 		aiType=120003003,
 		star=6,
 		attributeType={2},
 	attributeValue={51}
},
[582] =
{
 		id=582,
 		aiType=120003004,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[583] =
{
 		id=583,
 		aiType=120003004,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={8,2}
},
[584] =
{
 		id=584,
 		aiType=120003004,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={15,4}
},
[585] =
{
 		id=585,
 		aiType=120003004,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={23,6}
},
[586] =
{
 		id=586,
 		aiType=120003004,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={30,9}
},
[587] =
{
 		id=587,
 		aiType=120003004,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={38,11}
},
[588] =
{
 		id=588,
 		aiType=120003004,
 		star=6,
 		attributeType={3,2},
 	attributeValue={45,13}
},
[589] =
{
 		id=589,
 		aiType=120003005,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[590] =
{
 		id=590,
 		aiType=120003005,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={54,3}
},
[591] =
{
 		id=591,
 		aiType=120003005,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={107,6}
},
[592] =
{
 		id=592,
 		aiType=120003005,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={161,10}
},
[593] =
{
 		id=593,
 		aiType=120003005,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={214,13}
},
[594] =
{
 		id=594,
 		aiType=120003005,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={268,16}
},
[595] =
{
 		id=595,
 		aiType=120003005,
 		star=6,
 		attributeType={1,2},
 	attributeValue={321,19}
},
[596] =
{
 		id=596,
 		aiType=120004001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[597] =
{
 		id=597,
 		aiType=120004001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,3}
},
[598] =
{
 		id=598,
 		aiType=120004001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={14,7}
},
[599] =
{
 		id=599,
 		aiType=120004001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={20,10}
},
[600] =
{
 		id=600,
 		aiType=120004001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={27,14}
},
[601] =
{
 		id=601,
 		aiType=120004001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={34,17}
},
[602] =
{
 		id=602,
 		aiType=120004001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={41,20}
},
[603] =
{
 		id=603,
 		aiType=120004002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[604] =
{
 		id=604,
 		aiType=120004002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={12}
},
[605] =
{
 		id=605,
 		aiType=120004002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={24}
},
[606] =
{
 		id=606,
 		aiType=120004002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={36}
},
[607] =
{
 		id=607,
 		aiType=120004002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={47}
},
[608] =
{
 		id=608,
 		aiType=120004002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={59}
},
[609] =
{
 		id=609,
 		aiType=120004002,
 		star=6,
 		attributeType={2},
 	attributeValue={71}
},
[610] =
{
 		id=610,
 		aiType=120004003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[611] =
{
 		id=611,
 		aiType=120004003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={8,21}
},
[612] =
{
 		id=612,
 		aiType=120004003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={17,43}
},
[613] =
{
 		id=613,
 		aiType=120004003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={25,64}
},
[614] =
{
 		id=614,
 		aiType=120004003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={34,86}
},
[615] =
{
 		id=615,
 		aiType=120004003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={42,107}
},
[616] =
{
 		id=616,
 		aiType=120004003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={51,128}
},
[617] =
{
 		id=617,
 		aiType=120004004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[618] =
{
 		id=618,
 		aiType=120004004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={86,2}
},
[619] =
{
 		id=619,
 		aiType=120004004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={171,3}
},
[620] =
{
 		id=620,
 		aiType=120004004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={257,5}
},
[621] =
{
 		id=621,
 		aiType=120004004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={342,7}
},
[622] =
{
 		id=622,
 		aiType=120004004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={428,9}
},
[623] =
{
 		id=623,
 		aiType=120004004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={514,10}
},
[624] =
{
 		id=624,
 		aiType=120004005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[625] =
{
 		id=625,
 		aiType=120004005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={4,10}
},
[626] =
{
 		id=626,
 		aiType=120004005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={9,20}
},
[627] =
{
 		id=627,
 		aiType=120004005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={13,30}
},
[628] =
{
 		id=628,
 		aiType=120004005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={17,41}
},
[629] =
{
 		id=629,
 		aiType=120004005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={22,51}
},
[630] =
{
 		id=630,
 		aiType=120004005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={26,61}
},
[631] =
{
 		id=631,
 		aiType=120005001,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[632] =
{
 		id=632,
 		aiType=120005001,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={6}
},
[633] =
{
 		id=633,
 		aiType=120005001,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={12}
},
[634] =
{
 		id=634,
 		aiType=120005001,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={17}
},
[635] =
{
 		id=635,
 		aiType=120005001,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={23}
},
[636] =
{
 		id=636,
 		aiType=120005001,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={29}
},
[637] =
{
 		id=637,
 		aiType=120005001,
 		star=6,
 		attributeType={2},
 	attributeValue={35}
},
[638] =
{
 		id=638,
 		aiType=120005002,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[639] =
{
 		id=639,
 		aiType=120005002,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={3,46}
},
[640] =
{
 		id=640,
 		aiType=120005002,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={7,93}
},
[641] =
{
 		id=641,
 		aiType=120005002,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={10,139}
},
[642] =
{
 		id=642,
 		aiType=120005002,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={13,185}
},
[643] =
{
 		id=643,
 		aiType=120005002,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={17,231}
},
[644] =
{
 		id=644,
 		aiType=120005002,
 		star=6,
 		attributeType={4,1},
 	attributeValue={20,278}
},
[645] =
{
 		id=645,
 		aiType=120005003,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[646] =
{
 		id=646,
 		aiType=120005003,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[647] =
{
 		id=647,
 		aiType=120005003,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={13}
},
[648] =
{
 		id=648,
 		aiType=120005003,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={20}
},
[649] =
{
 		id=649,
 		aiType=120005003,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={26}
},
[650] =
{
 		id=650,
 		aiType=120005003,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={33}
},
[651] =
{
 		id=651,
 		aiType=120005003,
 		star=6,
 		attributeType={2},
 	attributeValue={40}
},
[652] =
{
 		id=652,
 		aiType=120005004,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[653] =
{
 		id=653,
 		aiType=120005004,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,2}
},
[654] =
{
 		id=654,
 		aiType=120005004,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={13,3}
},
[655] =
{
 		id=655,
 		aiType=120005004,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={20,5}
},
[656] =
{
 		id=656,
 		aiType=120005004,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={26,7}
},
[657] =
{
 		id=657,
 		aiType=120005004,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={33,8}
},
[658] =
{
 		id=658,
 		aiType=120005004,
 		star=6,
 		attributeType={3,2},
 	attributeValue={39,10}
},
[659] =
{
 		id=659,
 		aiType=120005005,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[660] =
{
 		id=660,
 		aiType=120005005,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={46,2}
},
[661] =
{
 		id=661,
 		aiType=120005005,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={93,5}
},
[662] =
{
 		id=662,
 		aiType=120005005,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={139,7}
},
[663] =
{
 		id=663,
 		aiType=120005005,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={185,10}
},
[664] =
{
 		id=664,
 		aiType=120005005,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={231,12}
},
[665] =
{
 		id=665,
 		aiType=120005005,
 		star=6,
 		attributeType={1,2},
 	attributeValue={278,15}
},
[666] =
{
 		id=666,
 		aiType=120006001,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[667] =
{
 		id=667,
 		aiType=120006001,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={63,4}
},
[668] =
{
 		id=668,
 		aiType=120006001,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={127,9}
},
[669] =
{
 		id=669,
 		aiType=120006001,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={190,13}
},
[670] =
{
 		id=670,
 		aiType=120006001,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={253,17}
},
[671] =
{
 		id=671,
 		aiType=120006001,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={316,22}
},
[672] =
{
 		id=672,
 		aiType=120006001,
 		star=6,
 		attributeType={1,2},
 	attributeValue={380,26}
},
[673] =
{
 		id=673,
 		aiType=120006002,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3},
 	attributeValue={0}
},
[674] =
{
 		id=674,
 		aiType=120006002,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3},
 	attributeValue={11}
},
[675] =
{
 		id=675,
 		aiType=120006002,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3},
 	attributeValue={21}
},
[676] =
{
 		id=676,
 		aiType=120006002,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3},
 	attributeValue={32}
},
[677] =
{
 		id=677,
 		aiType=120006002,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3},
 	attributeValue={42}
},
[678] =
{
 		id=678,
 		aiType=120006002,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3},
 	attributeValue={53}
},
[679] =
{
 		id=679,
 		aiType=120006002,
 		star=6,
 		attributeType={3},
 	attributeValue={63}
},
[680] =
{
 		id=680,
 		aiType=120006003,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[681] =
{
 		id=681,
 		aiType=120006003,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={6,9}
},
[682] =
{
 		id=682,
 		aiType=120006003,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={12,17}
},
[683] =
{
 		id=683,
 		aiType=120006003,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={18,26}
},
[684] =
{
 		id=684,
 		aiType=120006003,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={23,34}
},
[685] =
{
 		id=685,
 		aiType=120006003,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={29,43}
},
[686] =
{
 		id=686,
 		aiType=120006003,
 		star=6,
 		attributeType={4,2},
 	attributeValue={35,52}
},
[687] =
{
 		id=687,
 		aiType=120006004,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[688] =
{
 		id=688,
 		aiType=120006004,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={9,3}
},
[689] =
{
 		id=689,
 		aiType=120006004,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={17,5}
},
[690] =
{
 		id=690,
 		aiType=120006004,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={26,8}
},
[691] =
{
 		id=691,
 		aiType=120006004,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={34,11}
},
[692] =
{
 		id=692,
 		aiType=120006004,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={43,13}
},
[693] =
{
 		id=693,
 		aiType=120006004,
 		star=6,
 		attributeType={2,3},
 	attributeValue={52,16}
},
[694] =
{
 		id=694,
 		aiType=120006005,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[695] =
{
 		id=695,
 		aiType=120006005,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={63,4}
},
[696] =
{
 		id=696,
 		aiType=120006005,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={127,9}
},
[697] =
{
 		id=697,
 		aiType=120006005,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={190,13}
},
[698] =
{
 		id=698,
 		aiType=120006005,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={253,18}
},
[699] =
{
 		id=699,
 		aiType=120006005,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={316,22}
},
[700] =
{
 		id=700,
 		aiType=120006005,
 		star=6,
 		attributeType={1,3},
 	attributeValue={380,26}
},
[701] =
{
 		id=701,
 		aiType=120007001,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[702] =
{
 		id=702,
 		aiType=120007001,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={79,5}
},
[703] =
{
 		id=703,
 		aiType=120007001,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={157,9}
},
[704] =
{
 		id=704,
 		aiType=120007001,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={236,14}
},
[705] =
{
 		id=705,
 		aiType=120007001,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={314,19}
},
[706] =
{
 		id=706,
 		aiType=120007001,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={393,24}
},
[707] =
{
 		id=707,
 		aiType=120007001,
 		star=6,
 		attributeType={1,2},
 	attributeValue={472,28}
},
[708] =
{
 		id=708,
 		aiType=120007002,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3},
 	attributeValue={0}
},
[709] =
{
 		id=709,
 		aiType=120007002,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3},
 	attributeValue={13}
},
[710] =
{
 		id=710,
 		aiType=120007002,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3},
 	attributeValue={26}
},
[711] =
{
 		id=711,
 		aiType=120007002,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3},
 	attributeValue={39}
},
[712] =
{
 		id=712,
 		aiType=120007002,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3},
 	attributeValue={52}
},
[713] =
{
 		id=713,
 		aiType=120007002,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3},
 	attributeValue={66}
},
[714] =
{
 		id=714,
 		aiType=120007002,
 		star=6,
 		attributeType={3},
 	attributeValue={79}
},
[715] =
{
 		id=715,
 		aiType=120007003,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[716] =
{
 		id=716,
 		aiType=120007003,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={7,9}
},
[717] =
{
 		id=717,
 		aiType=120007003,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={14,19}
},
[718] =
{
 		id=718,
 		aiType=120007003,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={22,28}
},
[719] =
{
 		id=719,
 		aiType=120007003,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={29,38}
},
[720] =
{
 		id=720,
 		aiType=120007003,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={36,47}
},
[721] =
{
 		id=721,
 		aiType=120007003,
 		star=6,
 		attributeType={4,2},
 	attributeValue={43,56}
},
[722] =
{
 		id=722,
 		aiType=120007004,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[723] =
{
 		id=723,
 		aiType=120007004,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={9,3}
},
[724] =
{
 		id=724,
 		aiType=120007004,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={19,7}
},
[725] =
{
 		id=725,
 		aiType=120007004,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={28,10}
},
[726] =
{
 		id=726,
 		aiType=120007004,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={38,13}
},
[727] =
{
 		id=727,
 		aiType=120007004,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={47,16}
},
[728] =
{
 		id=728,
 		aiType=120007004,
 		star=6,
 		attributeType={2,3},
 	attributeValue={56,20}
},
[729] =
{
 		id=729,
 		aiType=120007005,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[730] =
{
 		id=730,
 		aiType=120007005,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={79,5}
},
[731] =
{
 		id=731,
 		aiType=120007005,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={157,11}
},
[732] =
{
 		id=732,
 		aiType=120007005,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={236,16}
},
[733] =
{
 		id=733,
 		aiType=120007005,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={314,22}
},
[734] =
{
 		id=734,
 		aiType=120007005,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={393,27}
},
[735] =
{
 		id=735,
 		aiType=120007005,
 		star=6,
 		attributeType={1,3},
 	attributeValue={472,33}
},
[736] =
{
 		id=736,
 		aiType=120008001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[737] =
{
 		id=737,
 		aiType=120008001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={6,3}
},
[738] =
{
 		id=738,
 		aiType=120008001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={13,7}
},
[739] =
{
 		id=739,
 		aiType=120008001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={19,10}
},
[740] =
{
 		id=740,
 		aiType=120008001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={26,13}
},
[741] =
{
 		id=741,
 		aiType=120008001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={32,16}
},
[742] =
{
 		id=742,
 		aiType=120008001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={38,20}
},
[743] =
{
 		id=743,
 		aiType=120008002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[744] =
{
 		id=744,
 		aiType=120008002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={11}
},
[745] =
{
 		id=745,
 		aiType=120008002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={23}
},
[746] =
{
 		id=746,
 		aiType=120008002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={34}
},
[747] =
{
 		id=747,
 		aiType=120008002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={46}
},
[748] =
{
 		id=748,
 		aiType=120008002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={57}
},
[749] =
{
 		id=749,
 		aiType=120008002,
 		star=6,
 		attributeType={2},
 	attributeValue={68}
},
[750] =
{
 		id=750,
 		aiType=120008003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[751] =
{
 		id=751,
 		aiType=120008003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={8,20}
},
[752] =
{
 		id=752,
 		aiType=120008003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={16,40}
},
[753] =
{
 		id=753,
 		aiType=120008003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={24,60}
},
[754] =
{
 		id=754,
 		aiType=120008003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={33,80}
},
[755] =
{
 		id=755,
 		aiType=120008003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={41,100}
},
[756] =
{
 		id=756,
 		aiType=120008003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={49,119}
},
[757] =
{
 		id=757,
 		aiType=120008004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[758] =
{
 		id=758,
 		aiType=120008004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={80,2}
},
[759] =
{
 		id=759,
 		aiType=120008004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={159,3}
},
[760] =
{
 		id=760,
 		aiType=120008004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={239,5}
},
[761] =
{
 		id=761,
 		aiType=120008004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={318,6}
},
[762] =
{
 		id=762,
 		aiType=120008004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={398,8}
},
[763] =
{
 		id=763,
 		aiType=120008004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={478,10}
},
[764] =
{
 		id=764,
 		aiType=120008005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[765] =
{
 		id=765,
 		aiType=120008005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={4,10}
},
[766] =
{
 		id=766,
 		aiType=120008005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={8,20}
},
[767] =
{
 		id=767,
 		aiType=120008005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={13,29}
},
[768] =
{
 		id=768,
 		aiType=120008005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={17,39}
},
[769] =
{
 		id=769,
 		aiType=120008005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={21,49}
},
[770] =
{
 		id=770,
 		aiType=120008005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={25,59}
},
[771] =
{
 		id=771,
 		aiType=120009001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[772] =
{
 		id=772,
 		aiType=120009001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={5,2}
},
[773] =
{
 		id=773,
 		aiType=120009001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={10,4}
},
[774] =
{
 		id=774,
 		aiType=120009001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={15,6}
},
[775] =
{
 		id=775,
 		aiType=120009001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={20,8}
},
[776] =
{
 		id=776,
 		aiType=120009001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={25,10}
},
[777] =
{
 		id=777,
 		aiType=120009001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={30,12}
},
[778] =
{
 		id=778,
 		aiType=120009002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[779] =
{
 		id=779,
 		aiType=120009002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[780] =
{
 		id=780,
 		aiType=120009002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={14}
},
[781] =
{
 		id=781,
 		aiType=120009002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={20}
},
[782] =
{
 		id=782,
 		aiType=120009002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={27}
},
[783] =
{
 		id=783,
 		aiType=120009002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={34}
},
[784] =
{
 		id=784,
 		aiType=120009002,
 		star=6,
 		attributeType={2},
 	attributeValue={41}
},
[785] =
{
 		id=785,
 		aiType=120009003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[786] =
{
 		id=786,
 		aiType=120009003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={5,18}
},
[787] =
{
 		id=787,
 		aiType=120009003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={10,35}
},
[788] =
{
 		id=788,
 		aiType=120009003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={15,53}
},
[789] =
{
 		id=789,
 		aiType=120009003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={20,71}
},
[790] =
{
 		id=790,
 		aiType=120009003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={24,89}
},
[791] =
{
 		id=791,
 		aiType=120009003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={29,106}
},
[792] =
{
 		id=792,
 		aiType=120009004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[793] =
{
 		id=793,
 		aiType=120009004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={71,1}
},
[794] =
{
 		id=794,
 		aiType=120009004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={142,2}
},
[795] =
{
 		id=795,
 		aiType=120009004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={212,4}
},
[796] =
{
 		id=796,
 		aiType=120009004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={283,5}
},
[797] =
{
 		id=797,
 		aiType=120009004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={354,6}
},
[798] =
{
 		id=798,
 		aiType=120009004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={425,7}
},
[799] =
{
 		id=799,
 		aiType=120009005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[800] =
{
 		id=800,
 		aiType=120009005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={3,6}
},
[801] =
{
 		id=801,
 		aiType=120009005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={6,12}
},
[802] =
{
 		id=802,
 		aiType=120009005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={10,18}
},
[803] =
{
 		id=803,
 		aiType=120009005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={13,23}
},
[804] =
{
 		id=804,
 		aiType=120009005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={16,29}
},
[805] =
{
 		id=805,
 		aiType=120009005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={19,35}
},
[806] =
{
 		id=806,
 		aiType=120010001,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[807] =
{
 		id=807,
 		aiType=120010001,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={10}
},
[808] =
{
 		id=808,
 		aiType=120010001,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={20}
},
[809] =
{
 		id=809,
 		aiType=120010001,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={30}
},
[810] =
{
 		id=810,
 		aiType=120010001,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={40}
},
[811] =
{
 		id=811,
 		aiType=120010001,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={50}
},
[812] =
{
 		id=812,
 		aiType=120010001,
 		star=6,
 		attributeType={2},
 	attributeValue={60}
},
[813] =
{
 		id=813,
 		aiType=120010002,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[814] =
{
 		id=814,
 		aiType=120010002,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={5,7}
},
[815] =
{
 		id=815,
 		aiType=120010002,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={9,15}
},
[816] =
{
 		id=816,
 		aiType=120010002,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={14,22}
},
[817] =
{
 		id=817,
 		aiType=120010002,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={18,30}
},
[818] =
{
 		id=818,
 		aiType=120010002,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={23,37}
},
[819] =
{
 		id=819,
 		aiType=120010002,
 		star=6,
 		attributeType={4,2},
 	attributeValue={27,45}
},
[820] =
{
 		id=820,
 		aiType=120010003,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[821] =
{
 		id=821,
 		aiType=120010003,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={7,14}
},
[822] =
{
 		id=822,
 		aiType=120010003,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={14,27}
},
[823] =
{
 		id=823,
 		aiType=120010003,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={22,41}
},
[824] =
{
 		id=824,
 		aiType=120010003,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={29,55}
},
[825] =
{
 		id=825,
 		aiType=120010003,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={36,68}
},
[826] =
{
 		id=826,
 		aiType=120010003,
 		star=6,
 		attributeType={3,1},
 	attributeValue={43,82}
},
[827] =
{
 		id=827,
 		aiType=120010004,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[828] =
{
 		id=828,
 		aiType=120010004,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={123}
},
[829] =
{
 		id=829,
 		aiType=120010004,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={246}
},
[830] =
{
 		id=830,
 		aiType=120010004,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={369}
},
[831] =
{
 		id=831,
 		aiType=120010004,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={491}
},
[832] =
{
 		id=832,
 		aiType=120010004,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={614}
},
[833] =
{
 		id=833,
 		aiType=120010004,
 		star=6,
 		attributeType={1},
 	attributeValue={737}
},
[834] =
{
 		id=834,
 		aiType=120010005,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[835] =
{
 		id=835,
 		aiType=120010005,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={7,2}
},
[836] =
{
 		id=836,
 		aiType=120010005,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={15,4}
},
[837] =
{
 		id=837,
 		aiType=120010005,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={22,5}
},
[838] =
{
 		id=838,
 		aiType=120010005,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={30,7}
},
[839] =
{
 		id=839,
 		aiType=120010005,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={37,9}
},
[840] =
{
 		id=840,
 		aiType=120010005,
 		star=6,
 		attributeType={2,3},
 	attributeValue={45,11}
},
[841] =
{
 		id=841,
 		aiType=120011001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[842] =
{
 		id=842,
 		aiType=120011001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={10,76}
},
[843] =
{
 		id=843,
 		aiType=120011001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={19,152}
},
[844] =
{
 		id=844,
 		aiType=120011001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={29,228}
},
[845] =
{
 		id=845,
 		aiType=120011001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={38,304}
},
[846] =
{
 		id=846,
 		aiType=120011001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={48,379}
},
[847] =
{
 		id=847,
 		aiType=120011001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={57,455}
},
[848] =
{
 		id=848,
 		aiType=120011002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[849] =
{
 		id=849,
 		aiType=120011002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[850] =
{
 		id=850,
 		aiType=120011002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={16}
},
[851] =
{
 		id=851,
 		aiType=120011002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={24}
},
[852] =
{
 		id=852,
 		aiType=120011002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={33}
},
[853] =
{
 		id=853,
 		aiType=120011002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={41}
},
[854] =
{
 		id=854,
 		aiType=120011002,
 		star=6,
 		attributeType={2},
 	attributeValue={49}
},
[855] =
{
 		id=855,
 		aiType=120011003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[856] =
{
 		id=856,
 		aiType=120011003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={8,3}
},
[857] =
{
 		id=857,
 		aiType=120011003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={15,5}
},
[858] =
{
 		id=858,
 		aiType=120011003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={23,8}
},
[859] =
{
 		id=859,
 		aiType=120011003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={31,11}
},
[860] =
{
 		id=860,
 		aiType=120011003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={38,14}
},
[861] =
{
 		id=861,
 		aiType=120011003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={46,16}
},
[862] =
{
 		id=862,
 		aiType=120011004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[863] =
{
 		id=863,
 		aiType=120011004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={25,7}
},
[864] =
{
 		id=864,
 		aiType=120011004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={51,14}
},
[865] =
{
 		id=865,
 		aiType=120011004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={76,20}
},
[866] =
{
 		id=866,
 		aiType=120011004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={101,27}
},
[867] =
{
 		id=867,
 		aiType=120011004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={126,34}
},
[868] =
{
 		id=868,
 		aiType=120011004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={152,41}
},
[869] =
{
 		id=869,
 		aiType=120011005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[870] =
{
 		id=870,
 		aiType=120011005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={10}
},
[871] =
{
 		id=871,
 		aiType=120011005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={19}
},
[872] =
{
 		id=872,
 		aiType=120011005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={29}
},
[873] =
{
 		id=873,
 		aiType=120011005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={38}
},
[874] =
{
 		id=874,
 		aiType=120011005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={48}
},
[875] =
{
 		id=875,
 		aiType=120011005,
 		star=6,
 		attributeType={2},
 	attributeValue={57}
},
[876] =
{
 		id=876,
 		aiType=120012001,
 		attributeType={2},
 	attributeValue={0}
},
[877] =
{
 		id=877,
 		aiType=120012001,
 		star=1,
 		attributeType={2},
 	attributeValue={12}
},
[878] =
{
 		id=878,
 		aiType=120012001,
 		star=2,
 		attributeType={2},
 	attributeValue={25}
},
[879] =
{
 		id=879,
 		aiType=120012001,
 		star=3,
 		attributeType={2},
 	attributeValue={37}
},
[880] =
{
 		id=880,
 		aiType=120012001,
 		star=4,
 		attributeType={2},
 	attributeValue={50}
},
[881] =
{
 		id=881,
 		aiType=120012001,
 		star=5,
 		attributeType={2},
 	attributeValue={62}
},
[882] =
{
 		id=882,
 		aiType=120012001,
 		star=6,
 		attributeType={2},
 	attributeValue={75}
},
[883] =
{
 		id=883,
 		aiType=120012002,
 		attributeType={4,2},
 	attributeValue={0,0}
},
[884] =
{
 		id=884,
 		aiType=120012002,
 		star=1,
 		attributeType={4,2},
 	attributeValue={8,9}
},
[885] =
{
 		id=885,
 		aiType=120012002,
 		star=2,
 		attributeType={4,2},
 	attributeValue={15,19}
},
[886] =
{
 		id=886,
 		aiType=120012002,
 		star=3,
 		attributeType={4,2},
 	attributeValue={23,28}
},
[887] =
{
 		id=887,
 		aiType=120012002,
 		star=4,
 		attributeType={4,2},
 	attributeValue={30,37}
},
[888] =
{
 		id=888,
 		aiType=120012002,
 		star=5,
 		attributeType={4,2},
 	attributeValue={38,47}
},
[889] =
{
 		id=889,
 		aiType=120012002,
 		star=6,
 		attributeType={4,2},
 	attributeValue={45,56}
},
[890] =
{
 		id=890,
 		aiType=120012003,
 		attributeType={3,1},
 	attributeValue={0,0}
},
[891] =
{
 		id=891,
 		aiType=120012003,
 		star=1,
 		attributeType={3,1},
 	attributeValue={12,15}
},
[892] =
{
 		id=892,
 		aiType=120012003,
 		star=2,
 		attributeType={3,1},
 	attributeValue={24,31}
},
[893] =
{
 		id=893,
 		aiType=120012003,
 		star=3,
 		attributeType={3,1},
 	attributeValue={36,46}
},
[894] =
{
 		id=894,
 		aiType=120012003,
 		star=4,
 		attributeType={3,1},
 	attributeValue={48,62}
},
[895] =
{
 		id=895,
 		aiType=120012003,
 		star=5,
 		attributeType={3,1},
 	attributeValue={60,77}
},
[896] =
{
 		id=896,
 		aiType=120012003,
 		star=6,
 		attributeType={3,1},
 	attributeValue={72,93}
},
[897] =
{
 		id=897,
 		aiType=120012004,
 		attributeType={1},
 	attributeValue={0}
},
[898] =
{
 		id=898,
 		aiType=120012004,
 		star=1,
 		attributeType={1},
 	attributeValue={139}
},
[899] =
{
 		id=899,
 		aiType=120012004,
 		star=2,
 		attributeType={1},
 	attributeValue={279}
},
[900] =
{
 		id=900,
 		aiType=120012004,
 		star=3,
 		attributeType={1},
 	attributeValue={418}
},
[901] =
{
 		id=901,
 		aiType=120012004,
 		star=4,
 		attributeType={1},
 	attributeValue={557}
},
[902] =
{
 		id=902,
 		aiType=120012004,
 		star=5,
 		attributeType={1},
 	attributeValue={697}
},
[903] =
{
 		id=903,
 		aiType=120012004,
 		star=6,
 		attributeType={1},
 	attributeValue={836}
},
[904] =
{
 		id=904,
 		aiType=120012005,
 		attributeType={2,3},
 	attributeValue={0,0}
},
[905] =
{
 		id=905,
 		aiType=120012005,
 		star=1,
 		attributeType={2,3},
 	attributeValue={9,3}
},
[906] =
{
 		id=906,
 		aiType=120012005,
 		star=2,
 		attributeType={2,3},
 	attributeValue={19,6}
},
[907] =
{
 		id=907,
 		aiType=120012005,
 		star=3,
 		attributeType={2,3},
 	attributeValue={28,9}
},
[908] =
{
 		id=908,
 		aiType=120012005,
 		star=4,
 		attributeType={2,3},
 	attributeValue={37,12}
},
[909] =
{
 		id=909,
 		aiType=120012005,
 		star=5,
 		attributeType={2,3},
 	attributeValue={47,15}
},
[910] =
{
 		id=910,
 		aiType=120012005,
 		star=6,
 		attributeType={2,3},
 	attributeValue={56,18}
},
[911] =
{
 		id=911,
 		aiType=120013001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[912] =
{
 		id=912,
 		aiType=120013001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={5,2}
},
[913] =
{
 		id=913,
 		aiType=120013001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={10,4}
},
[914] =
{
 		id=914,
 		aiType=120013001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={15,6}
},
[915] =
{
 		id=915,
 		aiType=120013001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={20,8}
},
[916] =
{
 		id=916,
 		aiType=120013001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={25,10}
},
[917] =
{
 		id=917,
 		aiType=120013001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={30,12}
},
[918] =
{
 		id=918,
 		aiType=120013002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[919] =
{
 		id=919,
 		aiType=120013002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[920] =
{
 		id=920,
 		aiType=120013002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={14}
},
[921] =
{
 		id=921,
 		aiType=120013002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={20}
},
[922] =
{
 		id=922,
 		aiType=120013002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={27}
},
[923] =
{
 		id=923,
 		aiType=120013002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={34}
},
[924] =
{
 		id=924,
 		aiType=120013002,
 		star=6,
 		attributeType={2},
 	attributeValue={41}
},
[925] =
{
 		id=925,
 		aiType=120013003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[926] =
{
 		id=926,
 		aiType=120013003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={5,18}
},
[927] =
{
 		id=927,
 		aiType=120013003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={10,35}
},
[928] =
{
 		id=928,
 		aiType=120013003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={15,53}
},
[929] =
{
 		id=929,
 		aiType=120013003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={20,71}
},
[930] =
{
 		id=930,
 		aiType=120013003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={24,89}
},
[931] =
{
 		id=931,
 		aiType=120013003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={29,106}
},
[932] =
{
 		id=932,
 		aiType=120013004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[933] =
{
 		id=933,
 		aiType=120013004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={71,1}
},
[934] =
{
 		id=934,
 		aiType=120013004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={142,2}
},
[935] =
{
 		id=935,
 		aiType=120013004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={212,4}
},
[936] =
{
 		id=936,
 		aiType=120013004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={283,5}
},
[937] =
{
 		id=937,
 		aiType=120013004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={354,6}
},
[938] =
{
 		id=938,
 		aiType=120013004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={425,7}
},
[939] =
{
 		id=939,
 		aiType=120013005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[940] =
{
 		id=940,
 		aiType=120013005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={3,6}
},
[941] =
{
 		id=941,
 		aiType=120013005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={6,12}
},
[942] =
{
 		id=942,
 		aiType=120013005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={10,18}
},
[943] =
{
 		id=943,
 		aiType=120013005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={13,23}
},
[944] =
{
 		id=944,
 		aiType=120013005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={16,29}
},
[945] =
{
 		id=945,
 		aiType=120013005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={19,35}
},
[946] =
{
 		id=946,
 		aiType=130001001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[947] =
{
 		id=947,
 		aiType=130001001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={10,80}
},
[948] =
{
 		id=948,
 		aiType=130001001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={19,161}
},
[949] =
{
 		id=949,
 		aiType=130001001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={29,241}
},
[950] =
{
 		id=950,
 		aiType=130001001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={38,321}
},
[951] =
{
 		id=951,
 		aiType=130001001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={48,401}
},
[952] =
{
 		id=952,
 		aiType=130001001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={57,482}
},
[953] =
{
 		id=953,
 		aiType=130001002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[954] =
{
 		id=954,
 		aiType=130001002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[955] =
{
 		id=955,
 		aiType=130001002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={19}
},
[956] =
{
 		id=956,
 		aiType=130001002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={28}
},
[957] =
{
 		id=957,
 		aiType=130001002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={37}
},
[958] =
{
 		id=958,
 		aiType=130001002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={47}
},
[959] =
{
 		id=959,
 		aiType=130001002,
 		star=6,
 		attributeType={2},
 	attributeValue={56}
},
[960] =
{
 		id=960,
 		aiType=130001003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[961] =
{
 		id=961,
 		aiType=130001003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={8,3}
},
[962] =
{
 		id=962,
 		aiType=130001003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={16,6}
},
[963] =
{
 		id=963,
 		aiType=130001003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={25,9}
},
[964] =
{
 		id=964,
 		aiType=130001003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={33,12}
},
[965] =
{
 		id=965,
 		aiType=130001003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={41,16}
},
[966] =
{
 		id=966,
 		aiType=130001003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={49,19}
},
[967] =
{
 		id=967,
 		aiType=130001004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[968] =
{
 		id=968,
 		aiType=130001004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={27,8}
},
[969] =
{
 		id=969,
 		aiType=130001004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={54,16}
},
[970] =
{
 		id=970,
 		aiType=130001004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={80,23}
},
[971] =
{
 		id=971,
 		aiType=130001004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={107,31}
},
[972] =
{
 		id=972,
 		aiType=130001004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={134,39}
},
[973] =
{
 		id=973,
 		aiType=130001004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={161,47}
},
[974] =
{
 		id=974,
 		aiType=130001005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[975] =
{
 		id=975,
 		aiType=130001005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={11}
},
[976] =
{
 		id=976,
 		aiType=130001005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={22}
},
[977] =
{
 		id=977,
 		aiType=130001005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={33}
},
[978] =
{
 		id=978,
 		aiType=130001005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={44}
},
[979] =
{
 		id=979,
 		aiType=130001005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={55}
},
[980] =
{
 		id=980,
 		aiType=130001005,
 		star=6,
 		attributeType={2},
 	attributeValue={65}
},
[981] =
{
 		id=981,
 		aiType=130002001,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[982] =
{
 		id=982,
 		aiType=130002001,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={109}
},
[983] =
{
 		id=983,
 		aiType=130002001,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={218}
},
[984] =
{
 		id=984,
 		aiType=130002001,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={328}
},
[985] =
{
 		id=985,
 		aiType=130002001,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={437}
},
[986] =
{
 		id=986,
 		aiType=130002001,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={546}
},
[987] =
{
 		id=987,
 		aiType=130002001,
 		star=6,
 		attributeType={1},
 	attributeValue={655}
},
[988] =
{
 		id=988,
 		aiType=130002002,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[989] =
{
 		id=989,
 		aiType=130002002,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={9,14}
},
[990] =
{
 		id=990,
 		aiType=130002002,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={18,27}
},
[991] =
{
 		id=991,
 		aiType=130002002,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={27,41}
},
[992] =
{
 		id=992,
 		aiType=130002002,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={36,55}
},
[993] =
{
 		id=993,
 		aiType=130002002,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={45,68}
},
[994] =
{
 		id=994,
 		aiType=130002002,
 		star=6,
 		attributeType={3,1},
 	attributeValue={54,82}
},
[995] =
{
 		id=995,
 		aiType=130002003,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[996] =
{
 		id=996,
 		aiType=130002003,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={7,14}
},
[997] =
{
 		id=997,
 		aiType=130002003,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={15,27}
},
[998] =
{
 		id=998,
 		aiType=130002003,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={22,41}
},
[999] =
{
 		id=999,
 		aiType=130002003,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={30,55}
},
[1000] =
{
 		id=1000,
 		aiType=130002003,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={37,68}
},
[1001] =
{
 		id=1001,
 		aiType=130002003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={45,82}
},
[1002] =
{
 		id=1002,
 		aiType=130002004,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1003] =
{
 		id=1003,
 		aiType=130002004,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={10}
},
[1004] =
{
 		id=1004,
 		aiType=130002004,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={20}
},
[1005] =
{
 		id=1005,
 		aiType=130002004,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={30}
},
[1006] =
{
 		id=1006,
 		aiType=130002004,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={40}
},
[1007] =
{
 		id=1007,
 		aiType=130002004,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={50}
},
[1008] =
{
 		id=1008,
 		aiType=130002004,
 		star=6,
 		attributeType={2},
 	attributeValue={60}
},
[1009] =
{
 		id=1009,
 		aiType=130002005,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1010] =
{
 		id=1010,
 		aiType=130002005,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={5,7}
},
[1011] =
{
 		id=1011,
 		aiType=130002005,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={9,15}
},
[1012] =
{
 		id=1012,
 		aiType=130002005,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={14,22}
},
[1013] =
{
 		id=1013,
 		aiType=130002005,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={18,30}
},
[1014] =
{
 		id=1014,
 		aiType=130002005,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={23,37}
},
[1015] =
{
 		id=1015,
 		aiType=130002005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={27,45}
},
[1016] =
{
 		id=1016,
 		aiType=130003001,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1017] =
{
 		id=1017,
 		aiType=130003001,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={73,4}
},
[1018] =
{
 		id=1018,
 		aiType=130003001,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={145,7}
},
[1019] =
{
 		id=1019,
 		aiType=130003001,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={218,11}
},
[1020] =
{
 		id=1020,
 		aiType=130003001,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={290,14}
},
[1021] =
{
 		id=1021,
 		aiType=130003001,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={363,18}
},
[1022] =
{
 		id=1022,
 		aiType=130003001,
 		star=6,
 		attributeType={1,2},
 	attributeValue={436,21}
},
[1023] =
{
 		id=1023,
 		aiType=130003002,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3},
 	attributeValue={0}
},
[1024] =
{
 		id=1024,
 		aiType=130003002,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3},
 	attributeValue={12}
},
[1025] =
{
 		id=1025,
 		aiType=130003002,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3},
 	attributeValue={23}
},
[1026] =
{
 		id=1026,
 		aiType=130003002,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3},
 	attributeValue={35}
},
[1027] =
{
 		id=1027,
 		aiType=130003002,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3},
 	attributeValue={47}
},
[1028] =
{
 		id=1028,
 		aiType=130003002,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3},
 	attributeValue={59}
},
[1029] =
{
 		id=1029,
 		aiType=130003002,
 		star=6,
 		attributeType={3},
 	attributeValue={70}
},
[1030] =
{
 		id=1030,
 		aiType=130003003,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1031] =
{
 		id=1031,
 		aiType=130003003,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={15,7}
},
[1032] =
{
 		id=1032,
 		aiType=130003003,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={29,14}
},
[1033] =
{
 		id=1033,
 		aiType=130003003,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={44,21}
},
[1034] =
{
 		id=1034,
 		aiType=130003003,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={58,28}
},
[1035] =
{
 		id=1035,
 		aiType=130003003,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={73,35}
},
[1036] =
{
 		id=1036,
 		aiType=130003003,
 		star=6,
 		attributeType={4,2},
 	attributeValue={87,42}
},
[1037] =
{
 		id=1037,
 		aiType=130003004,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[1038] =
{
 		id=1038,
 		aiType=130003004,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={7,3}
},
[1039] =
{
 		id=1039,
 		aiType=130003004,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={14,6}
},
[1040] =
{
 		id=1040,
 		aiType=130003004,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={21,9}
},
[1041] =
{
 		id=1041,
 		aiType=130003004,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={28,12}
},
[1042] =
{
 		id=1042,
 		aiType=130003004,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={35,15}
},
[1043] =
{
 		id=1043,
 		aiType=130003004,
 		star=6,
 		attributeType={2,3},
 	attributeValue={42,18}
},
[1044] =
{
 		id=1044,
 		aiType=130003005,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[1045] =
{
 		id=1045,
 		aiType=130003005,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={73,5}
},
[1046] =
{
 		id=1046,
 		aiType=130003005,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={145,10}
},
[1047] =
{
 		id=1047,
 		aiType=130003005,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={218,15}
},
[1048] =
{
 		id=1048,
 		aiType=130003005,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={290,20}
},
[1049] =
{
 		id=1049,
 		aiType=130003005,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={363,24}
},
[1050] =
{
 		id=1050,
 		aiType=130003005,
 		star=6,
 		attributeType={1,3},
 	attributeValue={436,29}
},
[1051] =
{
 		id=1051,
 		aiType=130004001,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1052] =
{
 		id=1052,
 		aiType=130004001,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={11}
},
[1053] =
{
 		id=1053,
 		aiType=130004001,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={21}
},
[1054] =
{
 		id=1054,
 		aiType=130004001,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={32}
},
[1055] =
{
 		id=1055,
 		aiType=130004001,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={43}
},
[1056] =
{
 		id=1056,
 		aiType=130004001,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={54}
},
[1057] =
{
 		id=1057,
 		aiType=130004001,
 		star=6,
 		attributeType={2},
 	attributeValue={64}
},
[1058] =
{
 		id=1058,
 		aiType=130004002,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1059] =
{
 		id=1059,
 		aiType=130004002,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={7,8}
},
[1060] =
{
 		id=1060,
 		aiType=130004002,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={14,16}
},
[1061] =
{
 		id=1061,
 		aiType=130004002,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={21,24}
},
[1062] =
{
 		id=1062,
 		aiType=130004002,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={28,32}
},
[1063] =
{
 		id=1063,
 		aiType=130004002,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={35,40}
},
[1064] =
{
 		id=1064,
 		aiType=130004002,
 		star=6,
 		attributeType={4,2},
 	attributeValue={42,48}
},
[1065] =
{
 		id=1065,
 		aiType=130004003,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[1066] =
{
 		id=1066,
 		aiType=130004003,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={11,14}
},
[1067] =
{
 		id=1067,
 		aiType=130004003,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={22,29}
},
[1068] =
{
 		id=1068,
 		aiType=130004003,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={33,43}
},
[1069] =
{
 		id=1069,
 		aiType=130004003,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={44,58}
},
[1070] =
{
 		id=1070,
 		aiType=130004003,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={55,72}
},
[1071] =
{
 		id=1071,
 		aiType=130004003,
 		star=6,
 		attributeType={3,1},
 	attributeValue={66,87}
},
[1072] =
{
 		id=1072,
 		aiType=130004004,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[1073] =
{
 		id=1073,
 		aiType=130004004,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={130}
},
[1074] =
{
 		id=1074,
 		aiType=130004004,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={260}
},
[1075] =
{
 		id=1075,
 		aiType=130004004,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={389}
},
[1076] =
{
 		id=1076,
 		aiType=130004004,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={519}
},
[1077] =
{
 		id=1077,
 		aiType=130004004,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={649}
},
[1078] =
{
 		id=1078,
 		aiType=130004004,
 		star=6,
 		attributeType={1},
 	attributeValue={779}
},
[1079] =
{
 		id=1079,
 		aiType=130004005,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[1080] =
{
 		id=1080,
 		aiType=130004005,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={8,3}
},
[1081] =
{
 		id=1081,
 		aiType=130004005,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={16,6}
},
[1082] =
{
 		id=1082,
 		aiType=130004005,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={24,8}
},
[1083] =
{
 		id=1083,
 		aiType=130004005,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={32,11}
},
[1084] =
{
 		id=1084,
 		aiType=130004005,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={40,14}
},
[1085] =
{
 		id=1085,
 		aiType=130004005,
 		star=6,
 		attributeType={2,3},
 	attributeValue={48,17}
},
[1086] =
{
 		id=1086,
 		aiType=130005001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1087] =
{
 		id=1087,
 		aiType=130005001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={9,71}
},
[1088] =
{
 		id=1088,
 		aiType=130005001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={18,141}
},
[1089] =
{
 		id=1089,
 		aiType=130005001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={27,212}
},
[1090] =
{
 		id=1090,
 		aiType=130005001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={35,283}
},
[1091] =
{
 		id=1091,
 		aiType=130005001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={44,353}
},
[1092] =
{
 		id=1092,
 		aiType=130005001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={53,424}
},
[1093] =
{
 		id=1093,
 		aiType=130005002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1094] =
{
 		id=1094,
 		aiType=130005002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[1095] =
{
 		id=1095,
 		aiType=130005002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={15}
},
[1096] =
{
 		id=1096,
 		aiType=130005002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={23}
},
[1097] =
{
 		id=1097,
 		aiType=130005002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={31}
},
[1098] =
{
 		id=1098,
 		aiType=130005002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={39}
},
[1099] =
{
 		id=1099,
 		aiType=130005002,
 		star=6,
 		attributeType={2},
 	attributeValue={46}
},
[1100] =
{
 		id=1100,
 		aiType=130005003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1101] =
{
 		id=1101,
 		aiType=130005003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,3}
},
[1102] =
{
 		id=1102,
 		aiType=130005003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={14,5}
},
[1103] =
{
 		id=1103,
 		aiType=130005003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={22,8}
},
[1104] =
{
 		id=1104,
 		aiType=130005003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={29,10}
},
[1105] =
{
 		id=1105,
 		aiType=130005003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={36,13}
},
[1106] =
{
 		id=1106,
 		aiType=130005003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={43,15}
},
[1107] =
{
 		id=1107,
 		aiType=130005004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1108] =
{
 		id=1108,
 		aiType=130005004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={24,6}
},
[1109] =
{
 		id=1109,
 		aiType=130005004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={47,13}
},
[1110] =
{
 		id=1110,
 		aiType=130005004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={71,19}
},
[1111] =
{
 		id=1111,
 		aiType=130005004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={94,26}
},
[1112] =
{
 		id=1112,
 		aiType=130005004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={118,32}
},
[1113] =
{
 		id=1113,
 		aiType=130005004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={141,39}
},
[1114] =
{
 		id=1114,
 		aiType=130005005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1115] =
{
 		id=1115,
 		aiType=130005005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[1116] =
{
 		id=1116,
 		aiType=130005005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={18}
},
[1117] =
{
 		id=1117,
 		aiType=130005005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={27}
},
[1118] =
{
 		id=1118,
 		aiType=130005005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={36}
},
[1119] =
{
 		id=1119,
 		aiType=130005005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={45}
},
[1120] =
{
 		id=1120,
 		aiType=130005005,
 		star=6,
 		attributeType={2},
 	attributeValue={54}
},
[1121] =
{
 		id=1121,
 		aiType=130006001,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1122] =
{
 		id=1122,
 		aiType=130006001,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[1123] =
{
 		id=1123,
 		aiType=130006001,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={14}
},
[1124] =
{
 		id=1124,
 		aiType=130006001,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={21}
},
[1125] =
{
 		id=1125,
 		aiType=130006001,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={28}
},
[1126] =
{
 		id=1126,
 		aiType=130006001,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={35}
},
[1127] =
{
 		id=1127,
 		aiType=130006001,
 		star=6,
 		attributeType={2},
 	attributeValue={42}
},
[1128] =
{
 		id=1128,
 		aiType=130006002,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1129] =
{
 		id=1129,
 		aiType=130006002,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={4,50}
},
[1130] =
{
 		id=1130,
 		aiType=130006002,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={7,100}
},
[1131] =
{
 		id=1131,
 		aiType=130006002,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={11,149}
},
[1132] =
{
 		id=1132,
 		aiType=130006002,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={14,199}
},
[1133] =
{
 		id=1133,
 		aiType=130006002,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={18,249}
},
[1134] =
{
 		id=1134,
 		aiType=130006002,
 		star=6,
 		attributeType={4,1},
 	attributeValue={21,299}
},
[1135] =
{
 		id=1135,
 		aiType=130006003,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1136] =
{
 		id=1136,
 		aiType=130006003,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[1137] =
{
 		id=1137,
 		aiType=130006003,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={16}
},
[1138] =
{
 		id=1138,
 		aiType=130006003,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={24}
},
[1139] =
{
 		id=1139,
 		aiType=130006003,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={32}
},
[1140] =
{
 		id=1140,
 		aiType=130006003,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={40}
},
[1141] =
{
 		id=1141,
 		aiType=130006003,
 		star=6,
 		attributeType={2},
 	attributeValue={48}
},
[1142] =
{
 		id=1142,
 		aiType=130006004,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1143] =
{
 		id=1143,
 		aiType=130006004,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,2}
},
[1144] =
{
 		id=1144,
 		aiType=130006004,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={14,4}
},
[1145] =
{
 		id=1145,
 		aiType=130006004,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={22,6}
},
[1146] =
{
 		id=1146,
 		aiType=130006004,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={29,8}
},
[1147] =
{
 		id=1147,
 		aiType=130006004,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={36,10}
},
[1148] =
{
 		id=1148,
 		aiType=130006004,
 		star=6,
 		attributeType={3,2},
 	attributeValue={43,12}
},
[1149] =
{
 		id=1149,
 		aiType=130006005,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1150] =
{
 		id=1150,
 		aiType=130006005,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={50,3}
},
[1151] =
{
 		id=1151,
 		aiType=130006005,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={100,6}
},
[1152] =
{
 		id=1152,
 		aiType=130006005,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={149,9}
},
[1153] =
{
 		id=1153,
 		aiType=130006005,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={199,12}
},
[1154] =
{
 		id=1154,
 		aiType=130006005,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={249,15}
},
[1155] =
{
 		id=1155,
 		aiType=130006005,
 		star=6,
 		attributeType={1,2},
 	attributeValue={299,18}
},
[1156] =
{
 		id=1156,
 		aiType=130007001,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1157] =
{
 		id=1157,
 		aiType=130007001,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={3,69}
},
[1158] =
{
 		id=1158,
 		aiType=130007001,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={7,139}
},
[1159] =
{
 		id=1159,
 		aiType=130007001,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={10,208}
},
[1160] =
{
 		id=1160,
 		aiType=130007001,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={13,278}
},
[1161] =
{
 		id=1161,
 		aiType=130007001,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={17,347}
},
[1162] =
{
 		id=1162,
 		aiType=130007001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={20,416}
},
[1163] =
{
 		id=1163,
 		aiType=130007002,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1164] =
{
 		id=1164,
 		aiType=130007002,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={6}
},
[1165] =
{
 		id=1165,
 		aiType=130007002,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={11}
},
[1166] =
{
 		id=1166,
 		aiType=130007002,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={17}
},
[1167] =
{
 		id=1167,
 		aiType=130007002,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={22}
},
[1168] =
{
 		id=1168,
 		aiType=130007002,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={28}
},
[1169] =
{
 		id=1169,
 		aiType=130007002,
 		star=6,
 		attributeType={2},
 	attributeValue={33}
},
[1170] =
{
 		id=1170,
 		aiType=130007003,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1171] =
{
 		id=1171,
 		aiType=130007003,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,2}
},
[1172] =
{
 		id=1172,
 		aiType=130007003,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={13,4}
},
[1173] =
{
 		id=1173,
 		aiType=130007003,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={20,6}
},
[1174] =
{
 		id=1174,
 		aiType=130007003,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={26,7}
},
[1175] =
{
 		id=1175,
 		aiType=130007003,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={33,9}
},
[1176] =
{
 		id=1176,
 		aiType=130007003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={39,11}
},
[1177] =
{
 		id=1177,
 		aiType=130007004,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1178] =
{
 		id=1178,
 		aiType=130007004,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={23,5}
},
[1179] =
{
 		id=1179,
 		aiType=130007004,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={46,9}
},
[1180] =
{
 		id=1180,
 		aiType=130007004,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={69,14}
},
[1181] =
{
 		id=1181,
 		aiType=130007004,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={93,19}
},
[1182] =
{
 		id=1182,
 		aiType=130007004,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={116,23}
},
[1183] =
{
 		id=1183,
 		aiType=130007004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={139,28}
},
[1184] =
{
 		id=1184,
 		aiType=130007005,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1185] =
{
 		id=1185,
 		aiType=130007005,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={6}
},
[1186] =
{
 		id=1186,
 		aiType=130007005,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={13}
},
[1187] =
{
 		id=1187,
 		aiType=130007005,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={19}
},
[1188] =
{
 		id=1188,
 		aiType=130007005,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={26}
},
[1189] =
{
 		id=1189,
 		aiType=130007005,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={32}
},
[1190] =
{
 		id=1190,
 		aiType=130007005,
 		star=6,
 		attributeType={2},
 	attributeValue={39}
},
[1191] =
{
 		id=1191,
 		aiType=130008001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1192] =
{
 		id=1192,
 		aiType=130008001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={8,61}
},
[1193] =
{
 		id=1193,
 		aiType=130008001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={16,122}
},
[1194] =
{
 		id=1194,
 		aiType=130008001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={24,183}
},
[1195] =
{
 		id=1195,
 		aiType=130008001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={31,244}
},
[1196] =
{
 		id=1196,
 		aiType=130008001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={39,305}
},
[1197] =
{
 		id=1197,
 		aiType=130008001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={47,366}
},
[1198] =
{
 		id=1198,
 		aiType=130008002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1199] =
{
 		id=1199,
 		aiType=130008002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[1200] =
{
 		id=1200,
 		aiType=130008002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={14}
},
[1201] =
{
 		id=1201,
 		aiType=130008002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={21}
},
[1202] =
{
 		id=1202,
 		aiType=130008002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={28}
},
[1203] =
{
 		id=1203,
 		aiType=130008002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={35}
},
[1204] =
{
 		id=1204,
 		aiType=130008002,
 		star=6,
 		attributeType={2},
 	attributeValue={42}
},
[1205] =
{
 		id=1205,
 		aiType=130008003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1206] =
{
 		id=1206,
 		aiType=130008003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={6,2}
},
[1207] =
{
 		id=1207,
 		aiType=130008003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={12,5}
},
[1208] =
{
 		id=1208,
 		aiType=130008003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={19,7}
},
[1209] =
{
 		id=1209,
 		aiType=130008003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={25,9}
},
[1210] =
{
 		id=1210,
 		aiType=130008003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={31,12}
},
[1211] =
{
 		id=1211,
 		aiType=130008003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={37,14}
},
[1212] =
{
 		id=1212,
 		aiType=130008004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1213] =
{
 		id=1213,
 		aiType=130008004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={20,6}
},
[1214] =
{
 		id=1214,
 		aiType=130008004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={41,12}
},
[1215] =
{
 		id=1215,
 		aiType=130008004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={61,17}
},
[1216] =
{
 		id=1216,
 		aiType=130008004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={81,23}
},
[1217] =
{
 		id=1217,
 		aiType=130008004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={102,29}
},
[1218] =
{
 		id=1218,
 		aiType=130008004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={122,35}
},
[1219] =
{
 		id=1219,
 		aiType=130008005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1220] =
{
 		id=1220,
 		aiType=130008005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[1221] =
{
 		id=1221,
 		aiType=130008005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={16}
},
[1222] =
{
 		id=1222,
 		aiType=130008005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={24}
},
[1223] =
{
 		id=1223,
 		aiType=130008005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={32}
},
[1224] =
{
 		id=1224,
 		aiType=130008005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={41}
},
[1225] =
{
 		id=1225,
 		aiType=130008005,
 		star=6,
 		attributeType={2},
 	attributeValue={49}
},
[1226] =
{
 		id=1226,
 		aiType=130009001,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[1227] =
{
 		id=1227,
 		aiType=130009001,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={80}
},
[1228] =
{
 		id=1228,
 		aiType=130009001,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={159}
},
[1229] =
{
 		id=1229,
 		aiType=130009001,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={239}
},
[1230] =
{
 		id=1230,
 		aiType=130009001,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={318}
},
[1231] =
{
 		id=1231,
 		aiType=130009001,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={398}
},
[1232] =
{
 		id=1232,
 		aiType=130009001,
 		star=6,
 		attributeType={1},
 	attributeValue={478}
},
[1233] =
{
 		id=1233,
 		aiType=130009002,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[1234] =
{
 		id=1234,
 		aiType=130009002,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={5,10}
},
[1235] =
{
 		id=1235,
 		aiType=130009002,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={11,20}
},
[1236] =
{
 		id=1236,
 		aiType=130009002,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={16,30}
},
[1237] =
{
 		id=1237,
 		aiType=130009002,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={21,40}
},
[1238] =
{
 		id=1238,
 		aiType=130009002,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={27,50}
},
[1239] =
{
 		id=1239,
 		aiType=130009002,
 		star=6,
 		attributeType={3,1},
 	attributeValue={32,60}
},
[1240] =
{
 		id=1240,
 		aiType=130009003,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[1241] =
{
 		id=1241,
 		aiType=130009003,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={3,10}
},
[1242] =
{
 		id=1242,
 		aiType=130009003,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={6,20}
},
[1243] =
{
 		id=1243,
 		aiType=130009003,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={9,30}
},
[1244] =
{
 		id=1244,
 		aiType=130009003,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={12,40}
},
[1245] =
{
 		id=1245,
 		aiType=130009003,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={15,50}
},
[1246] =
{
 		id=1246,
 		aiType=130009003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={17,60}
},
[1247] =
{
 		id=1247,
 		aiType=130009004,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1248] =
{
 		id=1248,
 		aiType=130009004,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={4}
},
[1249] =
{
 		id=1249,
 		aiType=130009004,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={8}
},
[1250] =
{
 		id=1250,
 		aiType=130009004,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={12}
},
[1251] =
{
 		id=1251,
 		aiType=130009004,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={15}
},
[1252] =
{
 		id=1252,
 		aiType=130009004,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={19}
},
[1253] =
{
 		id=1253,
 		aiType=130009004,
 		star=6,
 		attributeType={2},
 	attributeValue={23}
},
[1254] =
{
 		id=1254,
 		aiType=130009005,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1255] =
{
 		id=1255,
 		aiType=130009005,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={3,3}
},
[1256] =
{
 		id=1256,
 		aiType=130009005,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={6,6}
},
[1257] =
{
 		id=1257,
 		aiType=130009005,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={9,9}
},
[1258] =
{
 		id=1258,
 		aiType=130009005,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={11,12}
},
[1259] =
{
 		id=1259,
 		aiType=130009005,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={14,15}
},
[1260] =
{
 		id=1260,
 		aiType=130009005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={17,17}
},
[1261] =
{
 		id=1261,
 		aiType=130010001,
 		attributeType={1},
 	attributeValue={0}
},
[1262] =
{
 		id=1262,
 		aiType=130010001,
 		star=1,
 		attributeType={1},
 	attributeValue={126}
},
[1263] =
{
 		id=1263,
 		aiType=130010001,
 		star=2,
 		attributeType={1},
 	attributeValue={252}
},
[1264] =
{
 		id=1264,
 		aiType=130010001,
 		star=3,
 		attributeType={1},
 	attributeValue={378}
},
[1265] =
{
 		id=1265,
 		aiType=130010001,
 		star=4,
 		attributeType={1},
 	attributeValue={505}
},
[1266] =
{
 		id=1266,
 		aiType=130010001,
 		star=5,
 		attributeType={1},
 	attributeValue={631}
},
[1267] =
{
 		id=1267,
 		aiType=130010001,
 		star=6,
 		attributeType={1},
 	attributeValue={757}
},
[1268] =
{
 		id=1268,
 		aiType=130010002,
 		attributeType={3,1},
 	attributeValue={0,0}
},
[1269] =
{
 		id=1269,
 		aiType=130010002,
 		star=1,
 		attributeType={3,1},
 	attributeValue={11,16}
},
[1270] =
{
 		id=1270,
 		aiType=130010002,
 		star=2,
 		attributeType={3,1},
 	attributeValue={21,32}
},
[1271] =
{
 		id=1271,
 		aiType=130010002,
 		star=3,
 		attributeType={3,1},
 	attributeValue={32,47}
},
[1272] =
{
 		id=1272,
 		aiType=130010002,
 		star=4,
 		attributeType={3,1},
 	attributeValue={42,63}
},
[1273] =
{
 		id=1273,
 		aiType=130010002,
 		star=5,
 		attributeType={3,1},
 	attributeValue={53,79}
},
[1274] =
{
 		id=1274,
 		aiType=130010002,
 		star=6,
 		attributeType={3,1},
 	attributeValue={63,95}
},
[1275] =
{
 		id=1275,
 		aiType=130010003,
 		attributeType={2,1},
 	attributeValue={0,0}
},
[1276] =
{
 		id=1276,
 		aiType=130010003,
 		star=1,
 		attributeType={2,1},
 	attributeValue={8,16}
},
[1277] =
{
 		id=1277,
 		aiType=130010003,
 		star=2,
 		attributeType={2,1},
 	attributeValue={16,32}
},
[1278] =
{
 		id=1278,
 		aiType=130010003,
 		star=3,
 		attributeType={2,1},
 	attributeValue={24,47}
},
[1279] =
{
 		id=1279,
 		aiType=130010003,
 		star=4,
 		attributeType={2,1},
 	attributeValue={32,63}
},
[1280] =
{
 		id=1280,
 		aiType=130010003,
 		star=5,
 		attributeType={2,1},
 	attributeValue={40,79}
},
[1281] =
{
 		id=1281,
 		aiType=130010003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={48,95}
},
[1282] =
{
 		id=1282,
 		aiType=130010004,
 		attributeType={2},
 	attributeValue={0}
},
[1283] =
{
 		id=1283,
 		aiType=130010004,
 		star=1,
 		attributeType={2},
 	attributeValue={11}
},
[1284] =
{
 		id=1284,
 		aiType=130010004,
 		star=2,
 		attributeType={2},
 	attributeValue={21}
},
[1285] =
{
 		id=1285,
 		aiType=130010004,
 		star=3,
 		attributeType={2},
 	attributeValue={32}
},
[1286] =
{
 		id=1286,
 		aiType=130010004,
 		star=4,
 		attributeType={2},
 	attributeValue={43}
},
[1287] =
{
 		id=1287,
 		aiType=130010004,
 		star=5,
 		attributeType={2},
 	attributeValue={53}
},
[1288] =
{
 		id=1288,
 		aiType=130010004,
 		star=6,
 		attributeType={2},
 	attributeValue={64}
},
[1289] =
{
 		id=1289,
 		aiType=130010005,
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1290] =
{
 		id=1290,
 		aiType=130010005,
 		star=1,
 		attributeType={4,2},
 	attributeValue={5,8}
},
[1291] =
{
 		id=1291,
 		aiType=130010005,
 		star=2,
 		attributeType={4,2},
 	attributeValue={10,16}
},
[1292] =
{
 		id=1292,
 		aiType=130010005,
 		star=3,
 		attributeType={4,2},
 	attributeValue={16,24}
},
[1293] =
{
 		id=1293,
 		aiType=130010005,
 		star=4,
 		attributeType={4,2},
 	attributeValue={21,32}
},
[1294] =
{
 		id=1294,
 		aiType=130010005,
 		star=5,
 		attributeType={4,2},
 	attributeValue={26,40}
},
[1295] =
{
 		id=1295,
 		aiType=130010005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={31,48}
},
[1296] =
{
 		id=1296,
 		aiType=130011001,
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1297] =
{
 		id=1297,
 		aiType=130011001,
 		star=1,
 		attributeType={4,1},
 	attributeValue={10,76}
},
[1298] =
{
 		id=1298,
 		aiType=130011001,
 		star=2,
 		attributeType={4,1},
 	attributeValue={19,152}
},
[1299] =
{
 		id=1299,
 		aiType=130011001,
 		star=3,
 		attributeType={4,1},
 	attributeValue={29,228}
},
[1300] =
{
 		id=1300,
 		aiType=130011001,
 		star=4,
 		attributeType={4,1},
 	attributeValue={38,304}
},
[1301] =
{
 		id=1301,
 		aiType=130011001,
 		star=5,
 		attributeType={4,1},
 	attributeValue={48,379}
},
[1302] =
{
 		id=1302,
 		aiType=130011001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={57,455}
},
[1303] =
{
 		id=1303,
 		aiType=130011002,
 		attributeType={2},
 	attributeValue={0}
},
[1304] =
{
 		id=1304,
 		aiType=130011002,
 		star=1,
 		attributeType={2},
 	attributeValue={8}
},
[1305] =
{
 		id=1305,
 		aiType=130011002,
 		star=2,
 		attributeType={2},
 	attributeValue={16}
},
[1306] =
{
 		id=1306,
 		aiType=130011002,
 		star=3,
 		attributeType={2},
 	attributeValue={24}
},
[1307] =
{
 		id=1307,
 		aiType=130011002,
 		star=4,
 		attributeType={2},
 	attributeValue={33}
},
[1308] =
{
 		id=1308,
 		aiType=130011002,
 		star=5,
 		attributeType={2},
 	attributeValue={41}
},
[1309] =
{
 		id=1309,
 		aiType=130011002,
 		star=6,
 		attributeType={2},
 	attributeValue={49}
},
[1310] =
{
 		id=1310,
 		aiType=130011003,
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1311] =
{
 		id=1311,
 		aiType=130011003,
 		star=1,
 		attributeType={3,2},
 	attributeValue={8,3}
},
[1312] =
{
 		id=1312,
 		aiType=130011003,
 		star=2,
 		attributeType={3,2},
 	attributeValue={15,5}
},
[1313] =
{
 		id=1313,
 		aiType=130011003,
 		star=3,
 		attributeType={3,2},
 	attributeValue={23,8}
},
[1314] =
{
 		id=1314,
 		aiType=130011003,
 		star=4,
 		attributeType={3,2},
 	attributeValue={31,11}
},
[1315] =
{
 		id=1315,
 		aiType=130011003,
 		star=5,
 		attributeType={3,2},
 	attributeValue={38,14}
},
[1316] =
{
 		id=1316,
 		aiType=130011003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={46,16}
},
[1317] =
{
 		id=1317,
 		aiType=130011004,
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1318] =
{
 		id=1318,
 		aiType=130011004,
 		star=1,
 		attributeType={1,2},
 	attributeValue={25,7}
},
[1319] =
{
 		id=1319,
 		aiType=130011004,
 		star=2,
 		attributeType={1,2},
 	attributeValue={51,14}
},
[1320] =
{
 		id=1320,
 		aiType=130011004,
 		star=3,
 		attributeType={1,2},
 	attributeValue={76,20}
},
[1321] =
{
 		id=1321,
 		aiType=130011004,
 		star=4,
 		attributeType={1,2},
 	attributeValue={101,27}
},
[1322] =
{
 		id=1322,
 		aiType=130011004,
 		star=5,
 		attributeType={1,2},
 	attributeValue={126,34}
},
[1323] =
{
 		id=1323,
 		aiType=130011004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={152,41}
},
[1324] =
{
 		id=1324,
 		aiType=130011005,
 		attributeType={2},
 	attributeValue={0}
},
[1325] =
{
 		id=1325,
 		aiType=130011005,
 		star=1,
 		attributeType={2},
 	attributeValue={10}
},
[1326] =
{
 		id=1326,
 		aiType=130011005,
 		star=2,
 		attributeType={2},
 	attributeValue={19}
},
[1327] =
{
 		id=1327,
 		aiType=130011005,
 		star=3,
 		attributeType={2},
 	attributeValue={29}
},
[1328] =
{
 		id=1328,
 		aiType=130011005,
 		star=4,
 		attributeType={2},
 	attributeValue={38}
},
[1329] =
{
 		id=1329,
 		aiType=130011005,
 		star=5,
 		attributeType={2},
 	attributeValue={48}
},
[1330] =
{
 		id=1330,
 		aiType=130011005,
 		star=6,
 		attributeType={2},
 	attributeValue={57}
},
[1331] =
{
 		id=1331,
 		aiType=130012001,
 		attributeType={2},
 	attributeValue={0}
},
[1332] =
{
 		id=1332,
 		aiType=130012001,
 		star=1,
 		attributeType={2},
 	attributeValue={7}
},
[1333] =
{
 		id=1333,
 		aiType=130012001,
 		star=2,
 		attributeType={2},
 	attributeValue={13}
},
[1334] =
{
 		id=1334,
 		aiType=130012001,
 		star=3,
 		attributeType={2},
 	attributeValue={20}
},
[1335] =
{
 		id=1335,
 		aiType=130012001,
 		star=4,
 		attributeType={2},
 	attributeValue={27}
},
[1336] =
{
 		id=1336,
 		aiType=130012001,
 		star=5,
 		attributeType={2},
 	attributeValue={33}
},
[1337] =
{
 		id=1337,
 		aiType=130012001,
 		star=6,
 		attributeType={2},
 	attributeValue={40}
},
[1338] =
{
 		id=1338,
 		aiType=130012002,
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1339] =
{
 		id=1339,
 		aiType=130012002,
 		star=1,
 		attributeType={4,1},
 	attributeValue={4,54}
},
[1340] =
{
 		id=1340,
 		aiType=130012002,
 		star=2,
 		attributeType={4,1},
 	attributeValue={8,107}
},
[1341] =
{
 		id=1341,
 		aiType=130012002,
 		star=3,
 		attributeType={4,1},
 	attributeValue={12,161}
},
[1342] =
{
 		id=1342,
 		aiType=130012002,
 		star=4,
 		attributeType={4,1},
 	attributeValue={15,214}
},
[1343] =
{
 		id=1343,
 		aiType=130012002,
 		star=5,
 		attributeType={4,1},
 	attributeValue={19,268}
},
[1344] =
{
 		id=1344,
 		aiType=130012002,
 		star=6,
 		attributeType={4,1},
 	attributeValue={23,321}
},
[1345] =
{
 		id=1345,
 		aiType=130012003,
 		attributeType={2},
 	attributeValue={0}
},
[1346] =
{
 		id=1346,
 		aiType=130012003,
 		star=1,
 		attributeType={2},
 	attributeValue={8}
},
[1347] =
{
 		id=1347,
 		aiType=130012003,
 		star=2,
 		attributeType={2},
 	attributeValue={15}
},
[1348] =
{
 		id=1348,
 		aiType=130012003,
 		star=3,
 		attributeType={2},
 	attributeValue={23}
},
[1349] =
{
 		id=1349,
 		aiType=130012003,
 		star=4,
 		attributeType={2},
 	attributeValue={30}
},
[1350] =
{
 		id=1350,
 		aiType=130012003,
 		star=5,
 		attributeType={2},
 	attributeValue={38}
},
[1351] =
{
 		id=1351,
 		aiType=130012003,
 		star=6,
 		attributeType={2},
 	attributeValue={46}
},
[1352] =
{
 		id=1352,
 		aiType=130012004,
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1353] =
{
 		id=1353,
 		aiType=130012004,
 		star=1,
 		attributeType={3,2},
 	attributeValue={8,2}
},
[1354] =
{
 		id=1354,
 		aiType=130012004,
 		star=2,
 		attributeType={3,2},
 	attributeValue={15,4}
},
[1355] =
{
 		id=1355,
 		aiType=130012004,
 		star=3,
 		attributeType={3,2},
 	attributeValue={23,6}
},
[1356] =
{
 		id=1356,
 		aiType=130012004,
 		star=4,
 		attributeType={3,2},
 	attributeValue={30,8}
},
[1357] =
{
 		id=1357,
 		aiType=130012004,
 		star=5,
 		attributeType={3,2},
 	attributeValue={38,10}
},
[1358] =
{
 		id=1358,
 		aiType=130012004,
 		star=6,
 		attributeType={3,2},
 	attributeValue={45,11}
},
[1359] =
{
 		id=1359,
 		aiType=130012005,
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1360] =
{
 		id=1360,
 		aiType=130012005,
 		star=1,
 		attributeType={1,2},
 	attributeValue={54,3}
},
[1361] =
{
 		id=1361,
 		aiType=130012005,
 		star=2,
 		attributeType={1,2},
 	attributeValue={107,6}
},
[1362] =
{
 		id=1362,
 		aiType=130012005,
 		star=3,
 		attributeType={1,2},
 	attributeValue={161,9}
},
[1363] =
{
 		id=1363,
 		aiType=130012005,
 		star=4,
 		attributeType={1,2},
 	attributeValue={214,11}
},
[1364] =
{
 		id=1364,
 		aiType=130012005,
 		star=5,
 		attributeType={1,2},
 	attributeValue={268,14}
},
[1365] =
{
 		id=1365,
 		aiType=130012005,
 		star=6,
 		attributeType={1,2},
 	attributeValue={321,17}
},
[1366] =
{
 		id=1366,
 		aiType=140001001,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[1367] =
{
 		id=1367,
 		aiType=140001001,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={68}
},
[1368] =
{
 		id=1368,
 		aiType=140001001,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={137}
},
[1369] =
{
 		id=1369,
 		aiType=140001001,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={205}
},
[1370] =
{
 		id=1370,
 		aiType=140001001,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={274}
},
[1371] =
{
 		id=1371,
 		aiType=140001001,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={342}
},
[1372] =
{
 		id=1372,
 		aiType=140001001,
 		star=6,
 		attributeType={1},
 	attributeValue={410}
},
[1373] =
{
 		id=1373,
 		aiType=140001002,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[1374] =
{
 		id=1374,
 		aiType=140001002,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={10,9}
},
[1375] =
{
 		id=1375,
 		aiType=140001002,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={19,17}
},
[1376] =
{
 		id=1376,
 		aiType=140001002,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={29,26}
},
[1377] =
{
 		id=1377,
 		aiType=140001002,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={39,34}
},
[1378] =
{
 		id=1378,
 		aiType=140001002,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={48,43}
},
[1379] =
{
 		id=1379,
 		aiType=140001002,
 		star=6,
 		attributeType={3,1},
 	attributeValue={58,51}
},
[1380] =
{
 		id=1380,
 		aiType=140001003,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[1381] =
{
 		id=1381,
 		aiType=140001003,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={8,9}
},
[1382] =
{
 		id=1382,
 		aiType=140001003,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={16,17}
},
[1383] =
{
 		id=1383,
 		aiType=140001003,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={23,26}
},
[1384] =
{
 		id=1384,
 		aiType=140001003,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={31,34}
},
[1385] =
{
 		id=1385,
 		aiType=140001003,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={39,43}
},
[1386] =
{
 		id=1386,
 		aiType=140001003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={47,51}
},
[1387] =
{
 		id=1387,
 		aiType=140001004,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1388] =
{
 		id=1388,
 		aiType=140001004,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={10}
},
[1389] =
{
 		id=1389,
 		aiType=140001004,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={21}
},
[1390] =
{
 		id=1390,
 		aiType=140001004,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={31}
},
[1391] =
{
 		id=1391,
 		aiType=140001004,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={41}
},
[1392] =
{
 		id=1392,
 		aiType=140001004,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={52}
},
[1393] =
{
 		id=1393,
 		aiType=140001004,
 		star=6,
 		attributeType={2},
 	attributeValue={62}
},
[1394] =
{
 		id=1394,
 		aiType=140001005,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1395] =
{
 		id=1395,
 		aiType=140001005,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={5,8}
},
[1396] =
{
 		id=1396,
 		aiType=140001005,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={10,16}
},
[1397] =
{
 		id=1397,
 		aiType=140001005,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={15,23}
},
[1398] =
{
 		id=1398,
 		aiType=140001005,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={19,31}
},
[1399] =
{
 		id=1399,
 		aiType=140001005,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={24,39}
},
[1400] =
{
 		id=1400,
 		aiType=140001005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={29,47}
},
[1401] =
{
 		id=1401,
 		aiType=140002001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1402] =
{
 		id=1402,
 		aiType=140002001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={10,74}
},
[1403] =
{
 		id=1403,
 		aiType=140002001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={19,148}
},
[1404] =
{
 		id=1404,
 		aiType=140002001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={29,221}
},
[1405] =
{
 		id=1405,
 		aiType=140002001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={38,295}
},
[1406] =
{
 		id=1406,
 		aiType=140002001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={48,369}
},
[1407] =
{
 		id=1407,
 		aiType=140002001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={57,443}
},
[1408] =
{
 		id=1408,
 		aiType=140002002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1409] =
{
 		id=1409,
 		aiType=140002002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[1410] =
{
 		id=1410,
 		aiType=140002002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={16}
},
[1411] =
{
 		id=1411,
 		aiType=140002002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={24}
},
[1412] =
{
 		id=1412,
 		aiType=140002002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={33}
},
[1413] =
{
 		id=1413,
 		aiType=140002002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={41}
},
[1414] =
{
 		id=1414,
 		aiType=140002002,
 		star=6,
 		attributeType={2},
 	attributeValue={49}
},
[1415] =
{
 		id=1415,
 		aiType=140002003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1416] =
{
 		id=1416,
 		aiType=140002003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={8,3}
},
[1417] =
{
 		id=1417,
 		aiType=140002003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={15,5}
},
[1418] =
{
 		id=1418,
 		aiType=140002003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={23,8}
},
[1419] =
{
 		id=1419,
 		aiType=140002003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={31,11}
},
[1420] =
{
 		id=1420,
 		aiType=140002003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={38,14}
},
[1421] =
{
 		id=1421,
 		aiType=140002003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={46,16}
},
[1422] =
{
 		id=1422,
 		aiType=140002004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1423] =
{
 		id=1423,
 		aiType=140002004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={25,7}
},
[1424] =
{
 		id=1424,
 		aiType=140002004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={49,14}
},
[1425] =
{
 		id=1425,
 		aiType=140002004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={74,20}
},
[1426] =
{
 		id=1426,
 		aiType=140002004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={98,27}
},
[1427] =
{
 		id=1427,
 		aiType=140002004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={123,34}
},
[1428] =
{
 		id=1428,
 		aiType=140002004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={148,41}
},
[1429] =
{
 		id=1429,
 		aiType=140002005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1430] =
{
 		id=1430,
 		aiType=140002005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={10}
},
[1431] =
{
 		id=1431,
 		aiType=140002005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={19}
},
[1432] =
{
 		id=1432,
 		aiType=140002005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={29}
},
[1433] =
{
 		id=1433,
 		aiType=140002005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={38}
},
[1434] =
{
 		id=1434,
 		aiType=140002005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={48}
},
[1435] =
{
 		id=1435,
 		aiType=140002005,
 		star=6,
 		attributeType={2},
 	attributeValue={57}
},
[1436] =
{
 		id=1436,
 		aiType=140003001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1437] =
{
 		id=1437,
 		aiType=140003001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={6,4}
},
[1438] =
{
 		id=1438,
 		aiType=140003001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={12,7}
},
[1439] =
{
 		id=1439,
 		aiType=140003001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={18,11}
},
[1440] =
{
 		id=1440,
 		aiType=140003001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={25,15}
},
[1441] =
{
 		id=1441,
 		aiType=140003001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={31,19}
},
[1442] =
{
 		id=1442,
 		aiType=140003001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={37,22}
},
[1443] =
{
 		id=1443,
 		aiType=140003002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1444] =
{
 		id=1444,
 		aiType=140003002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={13}
},
[1445] =
{
 		id=1445,
 		aiType=140003002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={26}
},
[1446] =
{
 		id=1446,
 		aiType=140003002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={39}
},
[1447] =
{
 		id=1447,
 		aiType=140003002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={52}
},
[1448] =
{
 		id=1448,
 		aiType=140003002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={65}
},
[1449] =
{
 		id=1449,
 		aiType=140003002,
 		star=6,
 		attributeType={2},
 	attributeValue={78}
},
[1450] =
{
 		id=1450,
 		aiType=140003003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[1451] =
{
 		id=1451,
 		aiType=140003003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={9,19}
},
[1452] =
{
 		id=1452,
 		aiType=140003003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={19,37}
},
[1453] =
{
 		id=1453,
 		aiType=140003003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={28,56}
},
[1454] =
{
 		id=1454,
 		aiType=140003003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={37,75}
},
[1455] =
{
 		id=1455,
 		aiType=140003003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={46,93}
},
[1456] =
{
 		id=1456,
 		aiType=140003003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={56,112}
},
[1457] =
{
 		id=1457,
 		aiType=140003004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[1458] =
{
 		id=1458,
 		aiType=140003004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={75,2}
},
[1459] =
{
 		id=1459,
 		aiType=140003004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={149,3}
},
[1460] =
{
 		id=1460,
 		aiType=140003004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={224,5}
},
[1461] =
{
 		id=1461,
 		aiType=140003004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={299,6}
},
[1462] =
{
 		id=1462,
 		aiType=140003004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={373,8}
},
[1463] =
{
 		id=1463,
 		aiType=140003004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={448,9}
},
[1464] =
{
 		id=1464,
 		aiType=140003005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1465] =
{
 		id=1465,
 		aiType=140003005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={4,11}
},
[1466] =
{
 		id=1466,
 		aiType=140003005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={8,22}
},
[1467] =
{
 		id=1467,
 		aiType=140003005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={12,33}
},
[1468] =
{
 		id=1468,
 		aiType=140003005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={15,45}
},
[1469] =
{
 		id=1469,
 		aiType=140003005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={19,56}
},
[1470] =
{
 		id=1470,
 		aiType=140003005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={23,67}
},
[1471] =
{
 		id=1471,
 		aiType=140004001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1472] =
{
 		id=1472,
 		aiType=140004001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={9,73}
},
[1473] =
{
 		id=1473,
 		aiType=140004001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={18,145}
},
[1474] =
{
 		id=1474,
 		aiType=140004001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={27,218}
},
[1475] =
{
 		id=1475,
 		aiType=140004001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={35,291}
},
[1476] =
{
 		id=1476,
 		aiType=140004001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={44,363}
},
[1477] =
{
 		id=1477,
 		aiType=140004001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={53,436}
},
[1478] =
{
 		id=1478,
 		aiType=140004002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1479] =
{
 		id=1479,
 		aiType=140004002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={6}
},
[1480] =
{
 		id=1480,
 		aiType=140004002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={12}
},
[1481] =
{
 		id=1481,
 		aiType=140004002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={18}
},
[1482] =
{
 		id=1482,
 		aiType=140004002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={23}
},
[1483] =
{
 		id=1483,
 		aiType=140004002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={29}
},
[1484] =
{
 		id=1484,
 		aiType=140004002,
 		star=6,
 		attributeType={2},
 	attributeValue={35}
},
[1485] =
{
 		id=1485,
 		aiType=140004003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1486] =
{
 		id=1486,
 		aiType=140004003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={8,2}
},
[1487] =
{
 		id=1487,
 		aiType=140004003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={15,4}
},
[1488] =
{
 		id=1488,
 		aiType=140004003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={23,6}
},
[1489] =
{
 		id=1489,
 		aiType=140004003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={30,8}
},
[1490] =
{
 		id=1490,
 		aiType=140004003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={38,10}
},
[1491] =
{
 		id=1491,
 		aiType=140004003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={45,12}
},
[1492] =
{
 		id=1492,
 		aiType=140004004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1493] =
{
 		id=1493,
 		aiType=140004004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={24,5}
},
[1494] =
{
 		id=1494,
 		aiType=140004004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={48,10}
},
[1495] =
{
 		id=1495,
 		aiType=140004004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={73,15}
},
[1496] =
{
 		id=1496,
 		aiType=140004004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={97,20}
},
[1497] =
{
 		id=1497,
 		aiType=140004004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={121,24}
},
[1498] =
{
 		id=1498,
 		aiType=140004004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={145,29}
},
[1499] =
{
 		id=1499,
 		aiType=140004005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1500] =
{
 		id=1500,
 		aiType=140004005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[1501] =
{
 		id=1501,
 		aiType=140004005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={14}
},
[1502] =
{
 		id=1502,
 		aiType=140004005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={20}
},
[1503] =
{
 		id=1503,
 		aiType=140004005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={27}
},
[1504] =
{
 		id=1504,
 		aiType=140004005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={34}
},
[1505] =
{
 		id=1505,
 		aiType=140004005,
 		star=6,
 		attributeType={2},
 	attributeValue={41}
},
[1506] =
{
 		id=1506,
 		aiType=140005001,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1507] =
{
 		id=1507,
 		aiType=140005001,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[1508] =
{
 		id=1508,
 		aiType=140005001,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={18}
},
[1509] =
{
 		id=1509,
 		aiType=140005001,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={27}
},
[1510] =
{
 		id=1510,
 		aiType=140005001,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={37}
},
[1511] =
{
 		id=1511,
 		aiType=140005001,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={46}
},
[1512] =
{
 		id=1512,
 		aiType=140005001,
 		star=6,
 		attributeType={2},
 	attributeValue={55}
},
[1513] =
{
 		id=1513,
 		aiType=140005002,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1514] =
{
 		id=1514,
 		aiType=140005002,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={7,7}
},
[1515] =
{
 		id=1515,
 		aiType=140005002,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={14,14}
},
[1516] =
{
 		id=1516,
 		aiType=140005002,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={21,21}
},
[1517] =
{
 		id=1517,
 		aiType=140005002,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={27,27}
},
[1518] =
{
 		id=1518,
 		aiType=140005002,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={34,34}
},
[1519] =
{
 		id=1519,
 		aiType=140005002,
 		star=6,
 		attributeType={4,2},
 	attributeValue={41,41}
},
[1520] =
{
 		id=1520,
 		aiType=140005003,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[1521] =
{
 		id=1521,
 		aiType=140005003,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={16,14}
},
[1522] =
{
 		id=1522,
 		aiType=140005003,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={33,28}
},
[1523] =
{
 		id=1523,
 		aiType=140005003,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={49,43}
},
[1524] =
{
 		id=1524,
 		aiType=140005003,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={65,57}
},
[1525] =
{
 		id=1525,
 		aiType=140005003,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={81,71}
},
[1526] =
{
 		id=1526,
 		aiType=140005003,
 		star=6,
 		attributeType={3,1},
 	attributeValue={98,85}
},
[1527] =
{
 		id=1527,
 		aiType=140005004,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[1528] =
{
 		id=1528,
 		aiType=140005004,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={128}
},
[1529] =
{
 		id=1529,
 		aiType=140005004,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={256}
},
[1530] =
{
 		id=1530,
 		aiType=140005004,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={384}
},
[1531] =
{
 		id=1531,
 		aiType=140005004,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={512}
},
[1532] =
{
 		id=1532,
 		aiType=140005004,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={640}
},
[1533] =
{
 		id=1533,
 		aiType=140005004,
 		star=6,
 		attributeType={1},
 	attributeValue={768}
},
[1534] =
{
 		id=1534,
 		aiType=140005005,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[1535] =
{
 		id=1535,
 		aiType=140005005,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={7,4}
},
[1536] =
{
 		id=1536,
 		aiType=140005005,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={14,8}
},
[1537] =
{
 		id=1537,
 		aiType=140005005,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={21,12}
},
[1538] =
{
 		id=1538,
 		aiType=140005005,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={27,16}
},
[1539] =
{
 		id=1539,
 		aiType=140005005,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={34,20}
},
[1540] =
{
 		id=1540,
 		aiType=140005005,
 		star=6,
 		attributeType={2,3},
 	attributeValue={41,24}
},
[1541] =
{
 		id=1541,
 		aiType=140006001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1542] =
{
 		id=1542,
 		aiType=140006001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={5,2}
},
[1543] =
{
 		id=1543,
 		aiType=140006001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={10,4}
},
[1544] =
{
 		id=1544,
 		aiType=140006001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={15,6}
},
[1545] =
{
 		id=1545,
 		aiType=140006001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={20,8}
},
[1546] =
{
 		id=1546,
 		aiType=140006001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={25,10}
},
[1547] =
{
 		id=1547,
 		aiType=140006001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={30,12}
},
[1548] =
{
 		id=1548,
 		aiType=140006002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1549] =
{
 		id=1549,
 		aiType=140006002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[1550] =
{
 		id=1550,
 		aiType=140006002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={14}
},
[1551] =
{
 		id=1551,
 		aiType=140006002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={20}
},
[1552] =
{
 		id=1552,
 		aiType=140006002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={27}
},
[1553] =
{
 		id=1553,
 		aiType=140006002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={34}
},
[1554] =
{
 		id=1554,
 		aiType=140006002,
 		star=6,
 		attributeType={2},
 	attributeValue={41}
},
[1555] =
{
 		id=1555,
 		aiType=140006003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[1556] =
{
 		id=1556,
 		aiType=140006003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={5,17}
},
[1557] =
{
 		id=1557,
 		aiType=140006003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={10,34}
},
[1558] =
{
 		id=1558,
 		aiType=140006003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={15,52}
},
[1559] =
{
 		id=1559,
 		aiType=140006003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={20,69}
},
[1560] =
{
 		id=1560,
 		aiType=140006003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={24,86}
},
[1561] =
{
 		id=1561,
 		aiType=140006003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={29,103}
},
[1562] =
{
 		id=1562,
 		aiType=140006004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[1563] =
{
 		id=1563,
 		aiType=140006004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={69,1}
},
[1564] =
{
 		id=1564,
 		aiType=140006004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={138,2}
},
[1565] =
{
 		id=1565,
 		aiType=140006004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={207,4}
},
[1566] =
{
 		id=1566,
 		aiType=140006004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={276,5}
},
[1567] =
{
 		id=1567,
 		aiType=140006004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={345,6}
},
[1568] =
{
 		id=1568,
 		aiType=140006004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={414,7}
},
[1569] =
{
 		id=1569,
 		aiType=140006005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1570] =
{
 		id=1570,
 		aiType=140006005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={3,6}
},
[1571] =
{
 		id=1571,
 		aiType=140006005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={6,12}
},
[1572] =
{
 		id=1572,
 		aiType=140006005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={10,18}
},
[1573] =
{
 		id=1573,
 		aiType=140006005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={13,23}
},
[1574] =
{
 		id=1574,
 		aiType=140006005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={16,29}
},
[1575] =
{
 		id=1575,
 		aiType=140006005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={19,35}
},
[1576] =
{
 		id=1576,
 		aiType=140007001,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1577] =
{
 		id=1577,
 		aiType=140007001,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={66,4}
},
[1578] =
{
 		id=1578,
 		aiType=140007001,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={132,9}
},
[1579] =
{
 		id=1579,
 		aiType=140007001,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={198,13}
},
[1580] =
{
 		id=1580,
 		aiType=140007001,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={264,18}
},
[1581] =
{
 		id=1581,
 		aiType=140007001,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={330,22}
},
[1582] =
{
 		id=1582,
 		aiType=140007001,
 		star=6,
 		attributeType={1,2},
 	attributeValue={397,27}
},
[1583] =
{
 		id=1583,
 		aiType=140007002,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3},
 	attributeValue={0}
},
[1584] =
{
 		id=1584,
 		aiType=140007002,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3},
 	attributeValue={10}
},
[1585] =
{
 		id=1585,
 		aiType=140007002,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3},
 	attributeValue={20}
},
[1586] =
{
 		id=1586,
 		aiType=140007002,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3},
 	attributeValue={31}
},
[1587] =
{
 		id=1587,
 		aiType=140007002,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3},
 	attributeValue={41}
},
[1588] =
{
 		id=1588,
 		aiType=140007002,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3},
 	attributeValue={51}
},
[1589] =
{
 		id=1589,
 		aiType=140007002,
 		star=6,
 		attributeType={3},
 	attributeValue={61}
},
[1590] =
{
 		id=1590,
 		aiType=140007003,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1591] =
{
 		id=1591,
 		aiType=140007003,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={13,9}
},
[1592] =
{
 		id=1592,
 		aiType=140007003,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={25,18}
},
[1593] =
{
 		id=1593,
 		aiType=140007003,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={38,27}
},
[1594] =
{
 		id=1594,
 		aiType=140007003,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={51,35}
},
[1595] =
{
 		id=1595,
 		aiType=140007003,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={63,44}
},
[1596] =
{
 		id=1596,
 		aiType=140007003,
 		star=6,
 		attributeType={4,2},
 	attributeValue={76,53}
},
[1597] =
{
 		id=1597,
 		aiType=140007004,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[1598] =
{
 		id=1598,
 		aiType=140007004,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={9,3}
},
[1599] =
{
 		id=1599,
 		aiType=140007004,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={18,5}
},
[1600] =
{
 		id=1600,
 		aiType=140007004,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={27,8}
},
[1601] =
{
 		id=1601,
 		aiType=140007004,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={35,10}
},
[1602] =
{
 		id=1602,
 		aiType=140007004,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={44,13}
},
[1603] =
{
 		id=1603,
 		aiType=140007004,
 		star=6,
 		attributeType={2,3},
 	attributeValue={53,15}
},
[1604] =
{
 		id=1604,
 		aiType=140007005,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[1605] =
{
 		id=1605,
 		aiType=140007005,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={66,4}
},
[1606] =
{
 		id=1606,
 		aiType=140007005,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={132,9}
},
[1607] =
{
 		id=1607,
 		aiType=140007005,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={198,13}
},
[1608] =
{
 		id=1608,
 		aiType=140007005,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={264,17}
},
[1609] =
{
 		id=1609,
 		aiType=140007005,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={330,21}
},
[1610] =
{
 		id=1610,
 		aiType=140007005,
 		star=6,
 		attributeType={1,3},
 	attributeValue={397,26}
},
[1611] =
{
 		id=1611,
 		aiType=140008001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1612] =
{
 		id=1612,
 		aiType=140008001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={4,2}
},
[1613] =
{
 		id=1613,
 		aiType=140008001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={9,4}
},
[1614] =
{
 		id=1614,
 		aiType=140008001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={13,6}
},
[1615] =
{
 		id=1615,
 		aiType=140008001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={18,7}
},
[1616] =
{
 		id=1616,
 		aiType=140008001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={22,9}
},
[1617] =
{
 		id=1617,
 		aiType=140008001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={26,11}
},
[1618] =
{
 		id=1618,
 		aiType=140008002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1619] =
{
 		id=1619,
 		aiType=140008002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[1620] =
{
 		id=1620,
 		aiType=140008002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={13}
},
[1621] =
{
 		id=1621,
 		aiType=140008002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={20}
},
[1622] =
{
 		id=1622,
 		aiType=140008002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={26}
},
[1623] =
{
 		id=1623,
 		aiType=140008002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={33}
},
[1624] =
{
 		id=1624,
 		aiType=140008002,
 		star=6,
 		attributeType={2},
 	attributeValue={39}
},
[1625] =
{
 		id=1625,
 		aiType=140008003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[1626] =
{
 		id=1626,
 		aiType=140008003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={5,15}
},
[1627] =
{
 		id=1627,
 		aiType=140008003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={9,30}
},
[1628] =
{
 		id=1628,
 		aiType=140008003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={14,45}
},
[1629] =
{
 		id=1629,
 		aiType=140008003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={19,60}
},
[1630] =
{
 		id=1630,
 		aiType=140008003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={23,75}
},
[1631] =
{
 		id=1631,
 		aiType=140008003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={28,89}
},
[1632] =
{
 		id=1632,
 		aiType=140008004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[1633] =
{
 		id=1633,
 		aiType=140008004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={60,1}
},
[1634] =
{
 		id=1634,
 		aiType=140008004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={119,2}
},
[1635] =
{
 		id=1635,
 		aiType=140008004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={179,3}
},
[1636] =
{
 		id=1636,
 		aiType=140008004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={238,4}
},
[1637] =
{
 		id=1637,
 		aiType=140008004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={298,6}
},
[1638] =
{
 		id=1638,
 		aiType=140008004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={358,7}
},
[1639] =
{
 		id=1639,
 		aiType=140008005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1640] =
{
 		id=1640,
 		aiType=140008005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={3,6}
},
[1641] =
{
 		id=1641,
 		aiType=140008005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={6,11}
},
[1642] =
{
 		id=1642,
 		aiType=140008005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={9,17}
},
[1643] =
{
 		id=1643,
 		aiType=140008005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={11,22}
},
[1644] =
{
 		id=1644,
 		aiType=140008005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={14,28}
},
[1645] =
{
 		id=1645,
 		aiType=140008005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={17,34}
},
[1646] =
{
 		id=1646,
 		aiType=140009001,
 		attributeType={2},
 	attributeValue={0}
},
[1647] =
{
 		id=1647,
 		aiType=140009001,
 		star=1,
 		attributeType={2},
 	attributeValue={7}
},
[1648] =
{
 		id=1648,
 		aiType=140009001,
 		star=2,
 		attributeType={2},
 	attributeValue={14}
},
[1649] =
{
 		id=1649,
 		aiType=140009001,
 		star=3,
 		attributeType={2},
 	attributeValue={21}
},
[1650] =
{
 		id=1650,
 		aiType=140009001,
 		star=4,
 		attributeType={2},
 	attributeValue={28}
},
[1651] =
{
 		id=1651,
 		aiType=140009001,
 		star=5,
 		attributeType={2},
 	attributeValue={35}
},
[1652] =
{
 		id=1652,
 		aiType=140009001,
 		star=6,
 		attributeType={2},
 	attributeValue={42}
},
[1653] =
{
 		id=1653,
 		aiType=140009002,
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1654] =
{
 		id=1654,
 		aiType=140009002,
 		star=1,
 		attributeType={4,1},
 	attributeValue={4,48}
},
[1655] =
{
 		id=1655,
 		aiType=140009002,
 		star=2,
 		attributeType={4,1},
 	attributeValue={7,97}
},
[1656] =
{
 		id=1656,
 		aiType=140009002,
 		star=3,
 		attributeType={4,1},
 	attributeValue={11,145}
},
[1657] =
{
 		id=1657,
 		aiType=140009002,
 		star=4,
 		attributeType={4,1},
 	attributeValue={14,194}
},
[1658] =
{
 		id=1658,
 		aiType=140009002,
 		star=5,
 		attributeType={4,1},
 	attributeValue={18,242}
},
[1659] =
{
 		id=1659,
 		aiType=140009002,
 		star=6,
 		attributeType={4,1},
 	attributeValue={21,291}
},
[1660] =
{
 		id=1660,
 		aiType=140009003,
 		attributeType={2},
 	attributeValue={0}
},
[1661] =
{
 		id=1661,
 		aiType=140009003,
 		star=1,
 		attributeType={2},
 	attributeValue={8}
},
[1662] =
{
 		id=1662,
 		aiType=140009003,
 		star=2,
 		attributeType={2},
 	attributeValue={16}
},
[1663] =
{
 		id=1663,
 		aiType=140009003,
 		star=3,
 		attributeType={2},
 	attributeValue={24}
},
[1664] =
{
 		id=1664,
 		aiType=140009003,
 		star=4,
 		attributeType={2},
 	attributeValue={32}
},
[1665] =
{
 		id=1665,
 		aiType=140009003,
 		star=5,
 		attributeType={2},
 	attributeValue={40}
},
[1666] =
{
 		id=1666,
 		aiType=140009003,
 		star=6,
 		attributeType={2},
 	attributeValue={48}
},
[1667] =
{
 		id=1667,
 		aiType=140009004,
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1668] =
{
 		id=1668,
 		aiType=140009004,
 		star=1,
 		attributeType={3,2},
 	attributeValue={7,2}
},
[1669] =
{
 		id=1669,
 		aiType=140009004,
 		star=2,
 		attributeType={3,2},
 	attributeValue={14,4}
},
[1670] =
{
 		id=1670,
 		aiType=140009004,
 		star=3,
 		attributeType={3,2},
 	attributeValue={22,6}
},
[1671] =
{
 		id=1671,
 		aiType=140009004,
 		star=4,
 		attributeType={3,2},
 	attributeValue={29,8}
},
[1672] =
{
 		id=1672,
 		aiType=140009004,
 		star=5,
 		attributeType={3,2},
 	attributeValue={36,10}
},
[1673] =
{
 		id=1673,
 		aiType=140009004,
 		star=6,
 		attributeType={3,2},
 	attributeValue={43,12}
},
[1674] =
{
 		id=1674,
 		aiType=140009005,
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1675] =
{
 		id=1675,
 		aiType=140009005,
 		star=1,
 		attributeType={1,2},
 	attributeValue={48,3}
},
[1676] =
{
 		id=1676,
 		aiType=140009005,
 		star=2,
 		attributeType={1,2},
 	attributeValue={97,6}
},
[1677] =
{
 		id=1677,
 		aiType=140009005,
 		star=3,
 		attributeType={1,2},
 	attributeValue={145,9}
},
[1678] =
{
 		id=1678,
 		aiType=140009005,
 		star=4,
 		attributeType={1,2},
 	attributeValue={194,12}
},
[1679] =
{
 		id=1679,
 		aiType=140009005,
 		star=5,
 		attributeType={1,2},
 	attributeValue={242,15}
},
[1680] =
{
 		id=1680,
 		aiType=140009005,
 		star=6,
 		attributeType={1,2},
 	attributeValue={291,18}
},
[1681] =
{
 		id=1681,
 		aiType=140010001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1682] =
{
 		id=1682,
 		aiType=140010001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={10}
},
[1683] =
{
 		id=1683,
 		aiType=140010001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={21}
},
[1684] =
{
 		id=1684,
 		aiType=140010001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={31}
},
[1685] =
{
 		id=1685,
 		aiType=140010001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={41}
},
[1686] =
{
 		id=1686,
 		aiType=140010001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={52}
},
[1687] =
{
 		id=1687,
 		aiType=140010001,
 		star=6,
 		attributeType={2},
 	attributeValue={62}
},
[1688] =
{
 		id=1688,
 		aiType=140010002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1689] =
{
 		id=1689,
 		aiType=140010002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={7,8}
},
[1690] =
{
 		id=1690,
 		aiType=140010002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={13,16}
},
[1691] =
{
 		id=1691,
 		aiType=140010002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={20,23}
},
[1692] =
{
 		id=1692,
 		aiType=140010002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={26,31}
},
[1693] =
{
 		id=1693,
 		aiType=140010002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={33,39}
},
[1694] =
{
 		id=1694,
 		aiType=140010002,
 		star=6,
 		attributeType={4,2},
 	attributeValue={39,47}
},
[1695] =
{
 		id=1695,
 		aiType=140010003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[1696] =
{
 		id=1696,
 		aiType=140010003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={10,13}
},
[1697] =
{
 		id=1697,
 		aiType=140010003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={21,26}
},
[1698] =
{
 		id=1698,
 		aiType=140010003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={31,39}
},
[1699] =
{
 		id=1699,
 		aiType=140010003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={42,52}
},
[1700] =
{
 		id=1700,
 		aiType=140010003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={52,65}
},
[1701] =
{
 		id=1701,
 		aiType=140010003,
 		star=6,
 		attributeType={3,1},
 	attributeValue={62,78}
},
[1702] =
{
 		id=1702,
 		aiType=140010004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[1703] =
{
 		id=1703,
 		aiType=140010004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={117}
},
[1704] =
{
 		id=1704,
 		aiType=140010004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={235}
},
[1705] =
{
 		id=1705,
 		aiType=140010004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={352}
},
[1706] =
{
 		id=1706,
 		aiType=140010004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={469}
},
[1707] =
{
 		id=1707,
 		aiType=140010004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={587}
},
[1708] =
{
 		id=1708,
 		aiType=140010004,
 		star=6,
 		attributeType={1},
 	attributeValue={704}
},
[1709] =
{
 		id=1709,
 		aiType=140010005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[1710] =
{
 		id=1710,
 		aiType=140010005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={8,3}
},
[1711] =
{
 		id=1711,
 		aiType=140010005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={16,5}
},
[1712] =
{
 		id=1712,
 		aiType=140010005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={23,8}
},
[1713] =
{
 		id=1713,
 		aiType=140010005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={31,10}
},
[1714] =
{
 		id=1714,
 		aiType=140010005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={39,13}
},
[1715] =
{
 		id=1715,
 		aiType=140010005,
 		star=6,
 		attributeType={2,3},
 	attributeValue={47,16}
},
[1716] =
{
 		id=1716,
 		aiType=140011001,
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1717] =
{
 		id=1717,
 		aiType=140011001,
 		star=1,
 		attributeType={1,2},
 	attributeValue={77,5}
},
[1718] =
{
 		id=1718,
 		aiType=140011001,
 		star=2,
 		attributeType={1,2},
 	attributeValue={153,9}
},
[1719] =
{
 		id=1719,
 		aiType=140011001,
 		star=3,
 		attributeType={1,2},
 	attributeValue={230,14}
},
[1720] =
{
 		id=1720,
 		aiType=140011001,
 		star=4,
 		attributeType={1,2},
 	attributeValue={306,19}
},
[1721] =
{
 		id=1721,
 		aiType=140011001,
 		star=5,
 		attributeType={1,2},
 	attributeValue={383,24}
},
[1722] =
{
 		id=1722,
 		aiType=140011001,
 		star=6,
 		attributeType={1,2},
 	attributeValue={459,28}
},
[1723] =
{
 		id=1723,
 		aiType=140011002,
 		attributeType={3},
 	attributeValue={0}
},
[1724] =
{
 		id=1724,
 		aiType=140011002,
 		star=1,
 		attributeType={3},
 	attributeValue={13}
},
[1725] =
{
 		id=1725,
 		aiType=140011002,
 		star=2,
 		attributeType={3},
 	attributeValue={26}
},
[1726] =
{
 		id=1726,
 		aiType=140011002,
 		star=3,
 		attributeType={3},
 	attributeValue={39}
},
[1727] =
{
 		id=1727,
 		aiType=140011002,
 		star=4,
 		attributeType={3},
 	attributeValue={52}
},
[1728] =
{
 		id=1728,
 		aiType=140011002,
 		star=5,
 		attributeType={3},
 	attributeValue={66}
},
[1729] =
{
 		id=1729,
 		aiType=140011002,
 		star=6,
 		attributeType={3},
 	attributeValue={79}
},
[1730] =
{
 		id=1730,
 		aiType=140011003,
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1731] =
{
 		id=1731,
 		aiType=140011003,
 		star=1,
 		attributeType={4,2},
 	attributeValue={7,9}
},
[1732] =
{
 		id=1732,
 		aiType=140011003,
 		star=2,
 		attributeType={4,2},
 	attributeValue={14,19}
},
[1733] =
{
 		id=1733,
 		aiType=140011003,
 		star=3,
 		attributeType={4,2},
 	attributeValue={22,28}
},
[1734] =
{
 		id=1734,
 		aiType=140011003,
 		star=4,
 		attributeType={4,2},
 	attributeValue={29,38}
},
[1735] =
{
 		id=1735,
 		aiType=140011003,
 		star=5,
 		attributeType={4,2},
 	attributeValue={36,47}
},
[1736] =
{
 		id=1736,
 		aiType=140011003,
 		star=6,
 		attributeType={4,2},
 	attributeValue={43,56}
},
[1737] =
{
 		id=1737,
 		aiType=140011004,
 		attributeType={2,3},
 	attributeValue={0,0}
},
[1738] =
{
 		id=1738,
 		aiType=140011004,
 		star=1,
 		attributeType={2,3},
 	attributeValue={9,3}
},
[1739] =
{
 		id=1739,
 		aiType=140011004,
 		star=2,
 		attributeType={2,3},
 	attributeValue={19,7}
},
[1740] =
{
 		id=1740,
 		aiType=140011004,
 		star=3,
 		attributeType={2,3},
 	attributeValue={28,10}
},
[1741] =
{
 		id=1741,
 		aiType=140011004,
 		star=4,
 		attributeType={2,3},
 	attributeValue={38,13}
},
[1742] =
{
 		id=1742,
 		aiType=140011004,
 		star=5,
 		attributeType={2,3},
 	attributeValue={47,16}
},
[1743] =
{
 		id=1743,
 		aiType=140011004,
 		star=6,
 		attributeType={2,3},
 	attributeValue={56,20}
},
[1744] =
{
 		id=1744,
 		aiType=140011005,
 		attributeType={1,3},
 	attributeValue={0,0}
},
[1745] =
{
 		id=1745,
 		aiType=140011005,
 		star=1,
 		attributeType={1,3},
 	attributeValue={77,5}
},
[1746] =
{
 		id=1746,
 		aiType=140011005,
 		star=2,
 		attributeType={1,3},
 	attributeValue={153,11}
},
[1747] =
{
 		id=1747,
 		aiType=140011005,
 		star=3,
 		attributeType={1,3},
 	attributeValue={230,16}
},
[1748] =
{
 		id=1748,
 		aiType=140011005,
 		star=4,
 		attributeType={1,3},
 	attributeValue={306,22}
},
[1749] =
{
 		id=1749,
 		aiType=140011005,
 		star=5,
 		attributeType={1,3},
 	attributeValue={383,27}
},
[1750] =
{
 		id=1750,
 		aiType=140011005,
 		star=6,
 		attributeType={1,3},
 	attributeValue={459,33}
},
[1751] =
{
 		id=1751,
 		aiType=150001001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1752] =
{
 		id=1752,
 		aiType=150001001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={9,71}
},
[1753] =
{
 		id=1753,
 		aiType=150001001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={18,141}
},
[1754] =
{
 		id=1754,
 		aiType=150001001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={27,212}
},
[1755] =
{
 		id=1755,
 		aiType=150001001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={35,283}
},
[1756] =
{
 		id=1756,
 		aiType=150001001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={44,353}
},
[1757] =
{
 		id=1757,
 		aiType=150001001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={53,424}
},
[1758] =
{
 		id=1758,
 		aiType=150001002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1759] =
{
 		id=1759,
 		aiType=150001002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[1760] =
{
 		id=1760,
 		aiType=150001002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={15}
},
[1761] =
{
 		id=1761,
 		aiType=150001002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={23}
},
[1762] =
{
 		id=1762,
 		aiType=150001002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={31}
},
[1763] =
{
 		id=1763,
 		aiType=150001002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={39}
},
[1764] =
{
 		id=1764,
 		aiType=150001002,
 		star=6,
 		attributeType={2},
 	attributeValue={46}
},
[1765] =
{
 		id=1765,
 		aiType=150001003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1766] =
{
 		id=1766,
 		aiType=150001003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,3}
},
[1767] =
{
 		id=1767,
 		aiType=150001003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={14,5}
},
[1768] =
{
 		id=1768,
 		aiType=150001003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={22,8}
},
[1769] =
{
 		id=1769,
 		aiType=150001003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={29,10}
},
[1770] =
{
 		id=1770,
 		aiType=150001003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={36,13}
},
[1771] =
{
 		id=1771,
 		aiType=150001003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={43,15}
},
[1772] =
{
 		id=1772,
 		aiType=150001004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1773] =
{
 		id=1773,
 		aiType=150001004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={24,6}
},
[1774] =
{
 		id=1774,
 		aiType=150001004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={47,13}
},
[1775] =
{
 		id=1775,
 		aiType=150001004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={71,19}
},
[1776] =
{
 		id=1776,
 		aiType=150001004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={94,26}
},
[1777] =
{
 		id=1777,
 		aiType=150001004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={118,32}
},
[1778] =
{
 		id=1778,
 		aiType=150001004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={141,39}
},
[1779] =
{
 		id=1779,
 		aiType=150001005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1780] =
{
 		id=1780,
 		aiType=150001005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[1781] =
{
 		id=1781,
 		aiType=150001005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={18}
},
[1782] =
{
 		id=1782,
 		aiType=150001005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={27}
},
[1783] =
{
 		id=1783,
 		aiType=150001005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={36}
},
[1784] =
{
 		id=1784,
 		aiType=150001005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={45}
},
[1785] =
{
 		id=1785,
 		aiType=150001005,
 		star=6,
 		attributeType={2},
 	attributeValue={54}
},
[1786] =
{
 		id=1786,
 		aiType=150002001,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1787] =
{
 		id=1787,
 		aiType=150002001,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[1788] =
{
 		id=1788,
 		aiType=150002001,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={15}
},
[1789] =
{
 		id=1789,
 		aiType=150002001,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={22}
},
[1790] =
{
 		id=1790,
 		aiType=150002001,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={30}
},
[1791] =
{
 		id=1791,
 		aiType=150002001,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={37}
},
[1792] =
{
 		id=1792,
 		aiType=150002001,
 		star=6,
 		attributeType={2},
 	attributeValue={45}
},
[1793] =
{
 		id=1793,
 		aiType=150002002,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1794] =
{
 		id=1794,
 		aiType=150002002,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={4,54}
},
[1795] =
{
 		id=1795,
 		aiType=150002002,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={8,107}
},
[1796] =
{
 		id=1796,
 		aiType=150002002,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={12,161}
},
[1797] =
{
 		id=1797,
 		aiType=150002002,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={15,214}
},
[1798] =
{
 		id=1798,
 		aiType=150002002,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={19,268}
},
[1799] =
{
 		id=1799,
 		aiType=150002002,
 		star=6,
 		attributeType={4,1},
 	attributeValue={23,321}
},
[1800] =
{
 		id=1800,
 		aiType=150002003,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1801] =
{
 		id=1801,
 		aiType=150002003,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[1802] =
{
 		id=1802,
 		aiType=150002003,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={17}
},
[1803] =
{
 		id=1803,
 		aiType=150002003,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={26}
},
[1804] =
{
 		id=1804,
 		aiType=150002003,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={34}
},
[1805] =
{
 		id=1805,
 		aiType=150002003,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={43}
},
[1806] =
{
 		id=1806,
 		aiType=150002003,
 		star=6,
 		attributeType={2},
 	attributeValue={51}
},
[1807] =
{
 		id=1807,
 		aiType=150002004,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1808] =
{
 		id=1808,
 		aiType=150002004,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={8,2}
},
[1809] =
{
 		id=1809,
 		aiType=150002004,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={15,4}
},
[1810] =
{
 		id=1810,
 		aiType=150002004,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={23,6}
},
[1811] =
{
 		id=1811,
 		aiType=150002004,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={30,9}
},
[1812] =
{
 		id=1812,
 		aiType=150002004,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={38,11}
},
[1813] =
{
 		id=1813,
 		aiType=150002004,
 		star=6,
 		attributeType={3,2},
 	attributeValue={45,13}
},
[1814] =
{
 		id=1814,
 		aiType=150002005,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1815] =
{
 		id=1815,
 		aiType=150002005,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={54,3}
},
[1816] =
{
 		id=1816,
 		aiType=150002005,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={107,6}
},
[1817] =
{
 		id=1817,
 		aiType=150002005,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={161,10}
},
[1818] =
{
 		id=1818,
 		aiType=150002005,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={214,13}
},
[1819] =
{
 		id=1819,
 		aiType=150002005,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={268,16}
},
[1820] =
{
 		id=1820,
 		aiType=150002005,
 		star=6,
 		attributeType={1,2},
 	attributeValue={321,19}
},
[1821] =
{
 		id=1821,
 		aiType=150003001,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[1822] =
{
 		id=1822,
 		aiType=150003001,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={117}
},
[1823] =
{
 		id=1823,
 		aiType=150003001,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={235}
},
[1824] =
{
 		id=1824,
 		aiType=150003001,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={352}
},
[1825] =
{
 		id=1825,
 		aiType=150003001,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={469}
},
[1826] =
{
 		id=1826,
 		aiType=150003001,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={587}
},
[1827] =
{
 		id=1827,
 		aiType=150003001,
 		star=6,
 		attributeType={1},
 	attributeValue={704}
},
[1828] =
{
 		id=1828,
 		aiType=150003002,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[1829] =
{
 		id=1829,
 		aiType=150003002,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={10,15}
},
[1830] =
{
 		id=1830,
 		aiType=150003002,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={19,29}
},
[1831] =
{
 		id=1831,
 		aiType=150003002,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={29,44}
},
[1832] =
{
 		id=1832,
 		aiType=150003002,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={39,59}
},
[1833] =
{
 		id=1833,
 		aiType=150003002,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={48,73}
},
[1834] =
{
 		id=1834,
 		aiType=150003002,
 		star=6,
 		attributeType={3,1},
 	attributeValue={58,88}
},
[1835] =
{
 		id=1835,
 		aiType=150003003,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[1836] =
{
 		id=1836,
 		aiType=150003003,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={8,15}
},
[1837] =
{
 		id=1837,
 		aiType=150003003,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={16,29}
},
[1838] =
{
 		id=1838,
 		aiType=150003003,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={23,44}
},
[1839] =
{
 		id=1839,
 		aiType=150003003,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={31,59}
},
[1840] =
{
 		id=1840,
 		aiType=150003003,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={39,73}
},
[1841] =
{
 		id=1841,
 		aiType=150003003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={47,88}
},
[1842] =
{
 		id=1842,
 		aiType=150003004,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1843] =
{
 		id=1843,
 		aiType=150003004,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={10}
},
[1844] =
{
 		id=1844,
 		aiType=150003004,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={21}
},
[1845] =
{
 		id=1845,
 		aiType=150003004,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={31}
},
[1846] =
{
 		id=1846,
 		aiType=150003004,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={41}
},
[1847] =
{
 		id=1847,
 		aiType=150003004,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={52}
},
[1848] =
{
 		id=1848,
 		aiType=150003004,
 		star=6,
 		attributeType={2},
 	attributeValue={62}
},
[1849] =
{
 		id=1849,
 		aiType=150003005,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1850] =
{
 		id=1850,
 		aiType=150003005,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={5,8}
},
[1851] =
{
 		id=1851,
 		aiType=150003005,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={10,16}
},
[1852] =
{
 		id=1852,
 		aiType=150003005,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={15,23}
},
[1853] =
{
 		id=1853,
 		aiType=150003005,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={19,31}
},
[1854] =
{
 		id=1854,
 		aiType=150003005,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={24,39}
},
[1855] =
{
 		id=1855,
 		aiType=150003005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={29,47}
},
[1856] =
{
 		id=1856,
 		aiType=150004001,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1857] =
{
 		id=1857,
 		aiType=150004001,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={12}
},
[1858] =
{
 		id=1858,
 		aiType=150004001,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={25}
},
[1859] =
{
 		id=1859,
 		aiType=150004001,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={37}
},
[1860] =
{
 		id=1860,
 		aiType=150004001,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={50}
},
[1861] =
{
 		id=1861,
 		aiType=150004001,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={62}
},
[1862] =
{
 		id=1862,
 		aiType=150004001,
 		star=6,
 		attributeType={2},
 	attributeValue={75}
},
[1863] =
{
 		id=1863,
 		aiType=150004002,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1864] =
{
 		id=1864,
 		aiType=150004002,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={8,9}
},
[1865] =
{
 		id=1865,
 		aiType=150004002,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={15,19}
},
[1866] =
{
 		id=1866,
 		aiType=150004002,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={23,28}
},
[1867] =
{
 		id=1867,
 		aiType=150004002,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={30,37}
},
[1868] =
{
 		id=1868,
 		aiType=150004002,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={38,47}
},
[1869] =
{
 		id=1869,
 		aiType=150004002,
 		star=6,
 		attributeType={4,2},
 	attributeValue={45,56}
},
[1870] =
{
 		id=1870,
 		aiType=150004003,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[1871] =
{
 		id=1871,
 		aiType=150004003,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={12,15}
},
[1872] =
{
 		id=1872,
 		aiType=150004003,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={24,31}
},
[1873] =
{
 		id=1873,
 		aiType=150004003,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={36,46}
},
[1874] =
{
 		id=1874,
 		aiType=150004003,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={48,62}
},
[1875] =
{
 		id=1875,
 		aiType=150004003,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={60,77}
},
[1876] =
{
 		id=1876,
 		aiType=150004003,
 		star=6,
 		attributeType={3,1},
 	attributeValue={72,93}
},
[1877] =
{
 		id=1877,
 		aiType=150004004,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[1878] =
{
 		id=1878,
 		aiType=150004004,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={139}
},
[1879] =
{
 		id=1879,
 		aiType=150004004,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={279}
},
[1880] =
{
 		id=1880,
 		aiType=150004004,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={418}
},
[1881] =
{
 		id=1881,
 		aiType=150004004,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={557}
},
[1882] =
{
 		id=1882,
 		aiType=150004004,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={697}
},
[1883] =
{
 		id=1883,
 		aiType=150004004,
 		star=6,
 		attributeType={1},
 	attributeValue={836}
},
[1884] =
{
 		id=1884,
 		aiType=150004005,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[1885] =
{
 		id=1885,
 		aiType=150004005,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={9,3}
},
[1886] =
{
 		id=1886,
 		aiType=150004005,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={19,6}
},
[1887] =
{
 		id=1887,
 		aiType=150004005,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={28,9}
},
[1888] =
{
 		id=1888,
 		aiType=150004005,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={37,12}
},
[1889] =
{
 		id=1889,
 		aiType=150004005,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={47,15}
},
[1890] =
{
 		id=1890,
 		aiType=150004005,
 		star=6,
 		attributeType={2,3},
 	attributeValue={56,18}
},
[1891] =
{
 		id=1891,
 		aiType=150005001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[1892] =
{
 		id=1892,
 		aiType=150005001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={9,71}
},
[1893] =
{
 		id=1893,
 		aiType=150005001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={18,141}
},
[1894] =
{
 		id=1894,
 		aiType=150005001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={27,212}
},
[1895] =
{
 		id=1895,
 		aiType=150005001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={35,283}
},
[1896] =
{
 		id=1896,
 		aiType=150005001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={44,353}
},
[1897] =
{
 		id=1897,
 		aiType=150005001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={53,424}
},
[1898] =
{
 		id=1898,
 		aiType=150005002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1899] =
{
 		id=1899,
 		aiType=150005002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[1900] =
{
 		id=1900,
 		aiType=150005002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={15}
},
[1901] =
{
 		id=1901,
 		aiType=150005002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={23}
},
[1902] =
{
 		id=1902,
 		aiType=150005002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={31}
},
[1903] =
{
 		id=1903,
 		aiType=150005002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={39}
},
[1904] =
{
 		id=1904,
 		aiType=150005002,
 		star=6,
 		attributeType={2},
 	attributeValue={46}
},
[1905] =
{
 		id=1905,
 		aiType=150005003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1906] =
{
 		id=1906,
 		aiType=150005003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,3}
},
[1907] =
{
 		id=1907,
 		aiType=150005003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={14,5}
},
[1908] =
{
 		id=1908,
 		aiType=150005003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={22,8}
},
[1909] =
{
 		id=1909,
 		aiType=150005003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={29,10}
},
[1910] =
{
 		id=1910,
 		aiType=150005003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={36,13}
},
[1911] =
{
 		id=1911,
 		aiType=150005003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={43,15}
},
[1912] =
{
 		id=1912,
 		aiType=150005004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[1913] =
{
 		id=1913,
 		aiType=150005004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={24,6}
},
[1914] =
{
 		id=1914,
 		aiType=150005004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={47,13}
},
[1915] =
{
 		id=1915,
 		aiType=150005004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={71,19}
},
[1916] =
{
 		id=1916,
 		aiType=150005004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={94,26}
},
[1917] =
{
 		id=1917,
 		aiType=150005004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={118,32}
},
[1918] =
{
 		id=1918,
 		aiType=150005004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={141,39}
},
[1919] =
{
 		id=1919,
 		aiType=150005005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1920] =
{
 		id=1920,
 		aiType=150005005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[1921] =
{
 		id=1921,
 		aiType=150005005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={18}
},
[1922] =
{
 		id=1922,
 		aiType=150005005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={27}
},
[1923] =
{
 		id=1923,
 		aiType=150005005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={36}
},
[1924] =
{
 		id=1924,
 		aiType=150005005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={45}
},
[1925] =
{
 		id=1925,
 		aiType=150005005,
 		star=6,
 		attributeType={2},
 	attributeValue={54}
},
[1926] =
{
 		id=1926,
 		aiType=150006001,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1927] =
{
 		id=1927,
 		aiType=150006001,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[1928] =
{
 		id=1928,
 		aiType=150006001,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={18}
},
[1929] =
{
 		id=1929,
 		aiType=150006001,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={27}
},
[1930] =
{
 		id=1930,
 		aiType=150006001,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={37}
},
[1931] =
{
 		id=1931,
 		aiType=150006001,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={46}
},
[1932] =
{
 		id=1932,
 		aiType=150006001,
 		star=6,
 		attributeType={2},
 	attributeValue={55}
},
[1933] =
{
 		id=1933,
 		aiType=150006002,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1934] =
{
 		id=1934,
 		aiType=150006002,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={6,7}
},
[1935] =
{
 		id=1935,
 		aiType=150006002,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={13,14}
},
[1936] =
{
 		id=1936,
 		aiType=150006002,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={19,21}
},
[1937] =
{
 		id=1937,
 		aiType=150006002,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={25,27}
},
[1938] =
{
 		id=1938,
 		aiType=150006002,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={32,34}
},
[1939] =
{
 		id=1939,
 		aiType=150006002,
 		star=6,
 		attributeType={4,2},
 	attributeValue={38,41}
},
[1940] =
{
 		id=1940,
 		aiType=150006003,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={3,1},
 	attributeValue={0,0}
},
[1941] =
{
 		id=1941,
 		aiType=150006003,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={3,1},
 	attributeValue={15,16}
},
[1942] =
{
 		id=1942,
 		aiType=150006003,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={3,1},
 	attributeValue={30,33}
},
[1943] =
{
 		id=1943,
 		aiType=150006003,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={3,1},
 	attributeValue={45,49}
},
[1944] =
{
 		id=1944,
 		aiType=150006003,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={3,1},
 	attributeValue={60,65}
},
[1945] =
{
 		id=1945,
 		aiType=150006003,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={3,1},
 	attributeValue={75,81}
},
[1946] =
{
 		id=1946,
 		aiType=150006003,
 		star=6,
 		attributeType={3,1},
 	attributeValue={90,98}
},
[1947] =
{
 		id=1947,
 		aiType=150006004,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={1},
 	attributeValue={0}
},
[1948] =
{
 		id=1948,
 		aiType=150006004,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={1},
 	attributeValue={147}
},
[1949] =
{
 		id=1949,
 		aiType=150006004,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={1},
 	attributeValue={293}
},
[1950] =
{
 		id=1950,
 		aiType=150006004,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={1},
 	attributeValue={440}
},
[1951] =
{
 		id=1951,
 		aiType=150006004,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={1},
 	attributeValue={586}
},
[1952] =
{
 		id=1952,
 		aiType=150006004,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={1},
 	attributeValue={733}
},
[1953] =
{
 		id=1953,
 		aiType=150006004,
 		star=6,
 		attributeType={1},
 	attributeValue={879}
},
[1954] =
{
 		id=1954,
 		aiType=150006005,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={2,3},
 	attributeValue={0,0}
},
[1955] =
{
 		id=1955,
 		aiType=150006005,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={2,3},
 	attributeValue={7,4}
},
[1956] =
{
 		id=1956,
 		aiType=150006005,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={2,3},
 	attributeValue={14,8}
},
[1957] =
{
 		id=1957,
 		aiType=150006005,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={2,3},
 	attributeValue={21,11}
},
[1958] =
{
 		id=1958,
 		aiType=150006005,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={2,3},
 	attributeValue={27,15}
},
[1959] =
{
 		id=1959,
 		aiType=150006005,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={2,3},
 	attributeValue={34,19}
},
[1960] =
{
 		id=1960,
 		aiType=150006005,
 		star=6,
 		attributeType={2,3},
 	attributeValue={41,23}
},
[1961] =
{
 		id=1961,
 		aiType=150007001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[1962] =
{
 		id=1962,
 		aiType=150007001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={5,2}
},
[1963] =
{
 		id=1963,
 		aiType=150007001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={9,4}
},
[1964] =
{
 		id=1964,
 		aiType=150007001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={14,6}
},
[1965] =
{
 		id=1965,
 		aiType=150007001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={19,8}
},
[1966] =
{
 		id=1966,
 		aiType=150007001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={23,10}
},
[1967] =
{
 		id=1967,
 		aiType=150007001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={28,12}
},
[1968] =
{
 		id=1968,
 		aiType=150007002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1969] =
{
 		id=1969,
 		aiType=150007002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[1970] =
{
 		id=1970,
 		aiType=150007002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={13}
},
[1971] =
{
 		id=1971,
 		aiType=150007002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={20}
},
[1972] =
{
 		id=1972,
 		aiType=150007002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={27}
},
[1973] =
{
 		id=1973,
 		aiType=150007002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={34}
},
[1974] =
{
 		id=1974,
 		aiType=150007002,
 		star=6,
 		attributeType={2},
 	attributeValue={40}
},
[1975] =
{
 		id=1975,
 		aiType=150007003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[1976] =
{
 		id=1976,
 		aiType=150007003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={5,16}
},
[1977] =
{
 		id=1977,
 		aiType=150007003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={10,33}
},
[1978] =
{
 		id=1978,
 		aiType=150007003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={14,49}
},
[1979] =
{
 		id=1979,
 		aiType=150007003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={19,66}
},
[1980] =
{
 		id=1980,
 		aiType=150007003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={24,82}
},
[1981] =
{
 		id=1981,
 		aiType=150007003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={29,99}
},
[1982] =
{
 		id=1982,
 		aiType=150007004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[1983] =
{
 		id=1983,
 		aiType=150007004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={66,1}
},
[1984] =
{
 		id=1984,
 		aiType=150007004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={132,2}
},
[1985] =
{
 		id=1985,
 		aiType=150007004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={198,4}
},
[1986] =
{
 		id=1986,
 		aiType=150007004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={263,5}
},
[1987] =
{
 		id=1987,
 		aiType=150007004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={329,6}
},
[1988] =
{
 		id=1988,
 		aiType=150007004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={395,7}
},
[1989] =
{
 		id=1989,
 		aiType=150007005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[1990] =
{
 		id=1990,
 		aiType=150007005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={3,6}
},
[1991] =
{
 		id=1991,
 		aiType=150007005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={6,12}
},
[1992] =
{
 		id=1992,
 		aiType=150007005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={9,17}
},
[1993] =
{
 		id=1993,
 		aiType=150007005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={11,23}
},
[1994] =
{
 		id=1994,
 		aiType=150007005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={14,29}
},
[1995] =
{
 		id=1995,
 		aiType=150007005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={17,35}
},
[1996] =
{
 		id=1996,
 		aiType=150008001,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[1997] =
{
 		id=1997,
 		aiType=150008001,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={6}
},
[1998] =
{
 		id=1998,
 		aiType=150008001,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={12}
},
[1999] =
{
 		id=1999,
 		aiType=150008001,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={18}
},
[2000] =
{
 		id=2000,
 		aiType=150008001,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={24}
},
[2001] =
{
 		id=2001,
 		aiType=150008001,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={30}
},
[2002] =
{
 		id=2002,
 		aiType=150008001,
 		star=6,
 		attributeType={2},
 	attributeValue={36}
},
[2003] =
{
 		id=2003,
 		aiType=150008002,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[2004] =
{
 		id=2004,
 		aiType=150008002,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={3,43}
},
[2005] =
{
 		id=2005,
 		aiType=150008002,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={6,86}
},
[2006] =
{
 		id=2006,
 		aiType=150008002,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={10,129}
},
[2007] =
{
 		id=2007,
 		aiType=150008002,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={13,172}
},
[2008] =
{
 		id=2008,
 		aiType=150008002,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={16,215}
},
[2009] =
{
 		id=2009,
 		aiType=150008002,
 		star=6,
 		attributeType={4,1},
 	attributeValue={19,259}
},
[2010] =
{
 		id=2010,
 		aiType=150008003,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[2011] =
{
 		id=2011,
 		aiType=150008003,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={7}
},
[2012] =
{
 		id=2012,
 		aiType=150008003,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={14}
},
[2013] =
{
 		id=2013,
 		aiType=150008003,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={21}
},
[2014] =
{
 		id=2014,
 		aiType=150008003,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={27}
},
[2015] =
{
 		id=2015,
 		aiType=150008003,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={34}
},
[2016] =
{
 		id=2016,
 		aiType=150008003,
 		star=6,
 		attributeType={2},
 	attributeValue={41}
},
[2017] =
{
 		id=2017,
 		aiType=150008004,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[2018] =
{
 		id=2018,
 		aiType=150008004,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={6,2}
},
[2019] =
{
 		id=2019,
 		aiType=150008004,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={12,3}
},
[2020] =
{
 		id=2020,
 		aiType=150008004,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={19,5}
},
[2021] =
{
 		id=2021,
 		aiType=150008004,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={25,7}
},
[2022] =
{
 		id=2022,
 		aiType=150008004,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={31,9}
},
[2023] =
{
 		id=2023,
 		aiType=150008004,
 		star=6,
 		attributeType={3,2},
 	attributeValue={37,10}
},
[2024] =
{
 		id=2024,
 		aiType=150008005,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[2025] =
{
 		id=2025,
 		aiType=150008005,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={43,3}
},
[2026] =
{
 		id=2026,
 		aiType=150008005,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={86,5}
},
[2027] =
{
 		id=2027,
 		aiType=150008005,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={129,8}
},
[2028] =
{
 		id=2028,
 		aiType=150008005,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={172,10}
},
[2029] =
{
 		id=2029,
 		aiType=150008005,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={215,13}
},
[2030] =
{
 		id=2030,
 		aiType=150008005,
 		star=6,
 		attributeType={1,2},
 	attributeValue={259,15}
},
[2031] =
{
 		id=2031,
 		aiType=150009001,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[2032] =
{
 		id=2032,
 		aiType=150009001,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,3}
},
[2033] =
{
 		id=2033,
 		aiType=150009001,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={13,6}
},
[2034] =
{
 		id=2034,
 		aiType=150009001,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={20,9}
},
[2035] =
{
 		id=2035,
 		aiType=150009001,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={26,12}
},
[2036] =
{
 		id=2036,
 		aiType=150009001,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={33,15}
},
[2037] =
{
 		id=2037,
 		aiType=150009001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={39,18}
},
[2038] =
{
 		id=2038,
 		aiType=150009002,
 		costItems={1,521},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[2039] =
{
 		id=2039,
 		aiType=150009002,
 		star=1,
 		costItems={1,522},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={10}
},
[2040] =
{
 		id=2040,
 		aiType=150009002,
 		star=2,
 		costItems={1,523},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={21}
},
[2041] =
{
 		id=2041,
 		aiType=150009002,
 		star=3,
 		costItems={1,524},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={31}
},
[2042] =
{
 		id=2042,
 		aiType=150009002,
 		star=4,
 		costItems={1,525},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={42}
},
[2043] =
{
 		id=2043,
 		aiType=150009002,
 		star=5,
 		costItems={1,526},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={52}
},
[2044] =
{
 		id=2044,
 		aiType=150009002,
 		star=6,
 		attributeType={2},
 	attributeValue={62}
},
[2045] =
{
 		id=2045,
 		aiType=150009003,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={2,1},
 	attributeValue={0,0}
},
[2046] =
{
 		id=2046,
 		aiType=150009003,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={2,1},
 	attributeValue={7,20}
},
[2047] =
{
 		id=2047,
 		aiType=150009003,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={2,1},
 	attributeValue={15,40}
},
[2048] =
{
 		id=2048,
 		aiType=150009003,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={2,1},
 	attributeValue={22,61}
},
[2049] =
{
 		id=2049,
 		aiType=150009003,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={2,1},
 	attributeValue={30,81}
},
[2050] =
{
 		id=2050,
 		aiType=150009003,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={2,1},
 	attributeValue={37,101}
},
[2051] =
{
 		id=2051,
 		aiType=150009003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={45,121}
},
[2052] =
{
 		id=2052,
 		aiType=150009004,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={1,3},
 	attributeValue={0,0}
},
[2053] =
{
 		id=2053,
 		aiType=150009004,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={1,3},
 	attributeValue={81,2}
},
[2054] =
{
 		id=2054,
 		aiType=150009004,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={1,3},
 	attributeValue={162,3}
},
[2055] =
{
 		id=2055,
 		aiType=150009004,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={1,3},
 	attributeValue={243,5}
},
[2056] =
{
 		id=2056,
 		aiType=150009004,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={1,3},
 	attributeValue={324,7}
},
[2057] =
{
 		id=2057,
 		aiType=150009004,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={1,3},
 	attributeValue={405,8}
},
[2058] =
{
 		id=2058,
 		aiType=150009004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={486,10}
},
[2059] =
{
 		id=2059,
 		aiType=150009005,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={4,2},
 	attributeValue={0,0}
},
[2060] =
{
 		id=2060,
 		aiType=150009005,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={4,2},
 	attributeValue={4,9}
},
[2061] =
{
 		id=2061,
 		aiType=150009005,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={4,2},
 	attributeValue={8,18}
},
[2062] =
{
 		id=2062,
 		aiType=150009005,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={4,2},
 	attributeValue={12,27}
},
[2063] =
{
 		id=2063,
 		aiType=150009005,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={4,2},
 	attributeValue={16,36}
},
[2064] =
{
 		id=2064,
 		aiType=150009005,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={4,2},
 	attributeValue={20,45}
},
[2065] =
{
 		id=2065,
 		aiType=150009005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={24,53}
},
[2066] =
{
 		id=2066,
 		aiType=150010001,
 		costItems={1,531},
 		costNum={2000,1},
 		attributeType={4,1},
 	attributeValue={0,0}
},
[2067] =
{
 		id=2067,
 		aiType=150010001,
 		star=1,
 		costItems={1,532},
 		costNum={5000,1},
 		attributeType={4,1},
 	attributeValue={8,69}
},
[2068] =
{
 		id=2068,
 		aiType=150010001,
 		star=2,
 		costItems={1,533},
 		costNum={8000,1},
 		attributeType={4,1},
 	attributeValue={17,139}
},
[2069] =
{
 		id=2069,
 		aiType=150010001,
 		star=3,
 		costItems={1,534},
 		costNum={12000,1},
 		attributeType={4,1},
 	attributeValue={25,208}
},
[2070] =
{
 		id=2070,
 		aiType=150010001,
 		star=4,
 		costItems={1,535},
 		costNum={20000,1},
 		attributeType={4,1},
 	attributeValue={33,278}
},
[2071] =
{
 		id=2071,
 		aiType=150010001,
 		star=5,
 		costItems={1,536},
 		costNum={30000,1},
 		attributeType={4,1},
 	attributeValue={42,347}
},
[2072] =
{
 		id=2072,
 		aiType=150010001,
 		star=6,
 		attributeType={4,1},
 	attributeValue={50,416}
},
[2073] =
{
 		id=2073,
 		aiType=150010002,
 		costItems={1,541},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[2074] =
{
 		id=2074,
 		aiType=150010002,
 		star=1,
 		costItems={1,542},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={8}
},
[2075] =
{
 		id=2075,
 		aiType=150010002,
 		star=2,
 		costItems={1,543},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={16}
},
[2076] =
{
 		id=2076,
 		aiType=150010002,
 		star=3,
 		costItems={1,544},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={24}
},
[2077] =
{
 		id=2077,
 		aiType=150010002,
 		star=4,
 		costItems={1,545},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={32}
},
[2078] =
{
 		id=2078,
 		aiType=150010002,
 		star=5,
 		costItems={1,546},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={40}
},
[2079] =
{
 		id=2079,
 		aiType=150010002,
 		star=6,
 		attributeType={2},
 	attributeValue={48}
},
[2080] =
{
 		id=2080,
 		aiType=150010003,
 		costItems={1,551},
 		costNum={2000,1},
 		attributeType={3,2},
 	attributeValue={0,0}
},
[2081] =
{
 		id=2081,
 		aiType=150010003,
 		star=1,
 		costItems={1,552},
 		costNum={5000,1},
 		attributeType={3,2},
 	attributeValue={7,3}
},
[2082] =
{
 		id=2082,
 		aiType=150010003,
 		star=2,
 		costItems={1,553},
 		costNum={8000,1},
 		attributeType={3,2},
 	attributeValue={14,5}
},
[2083] =
{
 		id=2083,
 		aiType=150010003,
 		star=3,
 		costItems={1,554},
 		costNum={12000,1},
 		attributeType={3,2},
 	attributeValue={22,8}
},
[2084] =
{
 		id=2084,
 		aiType=150010003,
 		star=4,
 		costItems={1,555},
 		costNum={20000,1},
 		attributeType={3,2},
 	attributeValue={29,11}
},
[2085] =
{
 		id=2085,
 		aiType=150010003,
 		star=5,
 		costItems={1,556},
 		costNum={30000,1},
 		attributeType={3,2},
 	attributeValue={36,13}
},
[2086] =
{
 		id=2086,
 		aiType=150010003,
 		star=6,
 		attributeType={3,2},
 	attributeValue={43,16}
},
[2087] =
{
 		id=2087,
 		aiType=150010004,
 		costItems={1,501},
 		costNum={2000,1},
 		attributeType={1,2},
 	attributeValue={0,0}
},
[2088] =
{
 		id=2088,
 		aiType=150010004,
 		star=1,
 		costItems={1,502},
 		costNum={5000,1},
 		attributeType={1,2},
 	attributeValue={23,7}
},
[2089] =
{
 		id=2089,
 		aiType=150010004,
 		star=2,
 		costItems={1,503},
 		costNum={8000,1},
 		attributeType={1,2},
 	attributeValue={46,13}
},
[2090] =
{
 		id=2090,
 		aiType=150010004,
 		star=3,
 		costItems={1,504},
 		costNum={12000,1},
 		attributeType={1,2},
 	attributeValue={69,20}
},
[2091] =
{
 		id=2091,
 		aiType=150010004,
 		star=4,
 		costItems={1,505},
 		costNum={20000,1},
 		attributeType={1,2},
 	attributeValue={93,27}
},
[2092] =
{
 		id=2092,
 		aiType=150010004,
 		star=5,
 		costItems={1,506},
 		costNum={30000,1},
 		attributeType={1,2},
 	attributeValue={116,33}
},
[2093] =
{
 		id=2093,
 		aiType=150010004,
 		star=6,
 		attributeType={1,2},
 	attributeValue={139,40}
},
[2094] =
{
 		id=2094,
 		aiType=150010005,
 		costItems={1,511},
 		costNum={2000,1},
 		attributeType={2},
 	attributeValue={0}
},
[2095] =
{
 		id=2095,
 		aiType=150010005,
 		star=1,
 		costItems={1,512},
 		costNum={5000,1},
 		attributeType={2},
 	attributeValue={9}
},
[2096] =
{
 		id=2096,
 		aiType=150010005,
 		star=2,
 		costItems={1,513},
 		costNum={8000,1},
 		attributeType={2},
 	attributeValue={19}
},
[2097] =
{
 		id=2097,
 		aiType=150010005,
 		star=3,
 		costItems={1,514},
 		costNum={12000,1},
 		attributeType={2},
 	attributeValue={28}
},
[2098] =
{
 		id=2098,
 		aiType=150010005,
 		star=4,
 		costItems={1,515},
 		costNum={20000,1},
 		attributeType={2},
 	attributeValue={37}
},
[2099] =
{
 		id=2099,
 		aiType=150010005,
 		star=5,
 		costItems={1,516},
 		costNum={30000,1},
 		attributeType={2},
 	attributeValue={47}
},
[2100] =
{
 		id=2100,
 		aiType=150010005,
 		star=6,
 		attributeType={2},
 	attributeValue={56}
},
[2101] =
{
 		id=2101,
 		aiType=150011001,
 		attributeType={3,2},
 	attributeValue={0,0}
},
[2102] =
{
 		id=2102,
 		aiType=150011001,
 		star=1,
 		attributeType={3,2},
 	attributeValue={5,2}
},
[2103] =
{
 		id=2103,
 		aiType=150011001,
 		star=2,
 		attributeType={3,2},
 	attributeValue={11,4}
},
[2104] =
{
 		id=2104,
 		aiType=150011001,
 		star=3,
 		attributeType={3,2},
 	attributeValue={16,6}
},
[2105] =
{
 		id=2105,
 		aiType=150011001,
 		star=4,
 		attributeType={3,2},
 	attributeValue={21,8}
},
[2106] =
{
 		id=2106,
 		aiType=150011001,
 		star=5,
 		attributeType={3,2},
 	attributeValue={27,10}
},
[2107] =
{
 		id=2107,
 		aiType=150011001,
 		star=6,
 		attributeType={3,2},
 	attributeValue={32,12}
},
[2108] =
{
 		id=2108,
 		aiType=150011002,
 		attributeType={2},
 	attributeValue={0}
},
[2109] =
{
 		id=2109,
 		aiType=150011002,
 		star=1,
 		attributeType={2},
 	attributeValue={7}
},
[2110] =
{
 		id=2110,
 		aiType=150011002,
 		star=2,
 		attributeType={2},
 	attributeValue={14}
},
[2111] =
{
 		id=2111,
 		aiType=150011002,
 		star=3,
 		attributeType={2},
 	attributeValue={21}
},
[2112] =
{
 		id=2112,
 		aiType=150011002,
 		star=4,
 		attributeType={2},
 	attributeValue={28}
},
[2113] =
{
 		id=2113,
 		aiType=150011002,
 		star=5,
 		attributeType={2},
 	attributeValue={35}
},
[2114] =
{
 		id=2114,
 		aiType=150011002,
 		star=6,
 		attributeType={2},
 	attributeValue={42}
},
[2115] =
{
 		id=2115,
 		aiType=150011003,
 		attributeType={2,1},
 	attributeValue={0,0}
},
[2116] =
{
 		id=2116,
 		aiType=150011003,
 		star=1,
 		attributeType={2,1},
 	attributeValue={5,19}
},
[2117] =
{
 		id=2117,
 		aiType=150011003,
 		star=2,
 		attributeType={2,1},
 	attributeValue={10,38}
},
[2118] =
{
 		id=2118,
 		aiType=150011003,
 		star=3,
 		attributeType={2,1},
 	attributeValue={15,57}
},
[2119] =
{
 		id=2119,
 		aiType=150011003,
 		star=4,
 		attributeType={2,1},
 	attributeValue={20,76}
},
[2120] =
{
 		id=2120,
 		aiType=150011003,
 		star=5,
 		attributeType={2,1},
 	attributeValue={25,95}
},
[2121] =
{
 		id=2121,
 		aiType=150011003,
 		star=6,
 		attributeType={2,1},
 	attributeValue={30,114}
},
[2122] =
{
 		id=2122,
 		aiType=150011004,
 		attributeType={1,3},
 	attributeValue={0,0}
},
[2123] =
{
 		id=2123,
 		aiType=150011004,
 		star=1,
 		attributeType={1,3},
 	attributeValue={76,1}
},
[2124] =
{
 		id=2124,
 		aiType=150011004,
 		star=2,
 		attributeType={1,3},
 	attributeValue={152,3}
},
[2125] =
{
 		id=2125,
 		aiType=150011004,
 		star=3,
 		attributeType={1,3},
 	attributeValue={228,4}
},
[2126] =
{
 		id=2126,
 		aiType=150011004,
 		star=4,
 		attributeType={1,3},
 	attributeValue={305,5}
},
[2127] =
{
 		id=2127,
 		aiType=150011004,
 		star=5,
 		attributeType={1,3},
 	attributeValue={381,7}
},
[2128] =
{
 		id=2128,
 		aiType=150011004,
 		star=6,
 		attributeType={1,3},
 	attributeValue={457,8}
},
[2129] =
{
 		id=2129,
 		aiType=150011005,
 		attributeType={4,2},
 	attributeValue={0,0}
},
[2130] =
{
 		id=2130,
 		aiType=150011005,
 		star=1,
 		attributeType={4,2},
 	attributeValue={3,6}
},
[2131] =
{
 		id=2131,
 		aiType=150011005,
 		star=2,
 		attributeType={4,2},
 	attributeValue={7,12}
},
[2132] =
{
 		id=2132,
 		aiType=150011005,
 		star=3,
 		attributeType={4,2},
 	attributeValue={10,18}
},
[2133] =
{
 		id=2133,
 		aiType=150011005,
 		star=4,
 		attributeType={4,2},
 	attributeValue={13,24}
},
[2134] =
{
 		id=2134,
 		aiType=150011005,
 		star=5,
 		attributeType={4,2},
 	attributeValue={17,30}
},
[2135] =
{
 		id=2135,
 		aiType=150011005,
 		star=6,
 		attributeType={4,2},
 	attributeValue={20,36}
},
[2136] =
{
 		id=2136,
 		aiType=150012001,
 		attributeType={1,2},
 	attributeValue={0,0}
},
[2137] =
{
 		id=2137,
 		aiType=150012001,
 		star=1,
 		attributeType={1,2},
 	attributeValue={68,3}
},
[2138] =
{
 		id=2138,
 		aiType=150012001,
 		star=2,
 		attributeType={1,2},
 	attributeValue={135,7}
},
[2139] =
{
 		id=2139,
 		aiType=150012001,
 		star=3,
 		attributeType={1,2},
 	attributeValue={203,10}
},
[2140] =
{
 		id=2140,
 		aiType=150012001,
 		star=4,
 		attributeType={1,2},
 	attributeValue={270,13}
},
[2141] =
{
 		id=2141,
 		aiType=150012001,
 		star=5,
 		attributeType={1,2},
 	attributeValue={338,17}
},
[2142] =
{
 		id=2142,
 		aiType=150012001,
 		star=6,
 		attributeType={1,2},
 	attributeValue={405,20}
},
[2143] =
{
 		id=2143,
 		aiType=150012002,
 		attributeType={3},
 	attributeValue={0}
},
[2144] =
{
 		id=2144,
 		aiType=150012002,
 		star=1,
 		attributeType={3},
 	attributeValue={11}
},
[2145] =
{
 		id=2145,
 		aiType=150012002,
 		star=2,
 		attributeType={3},
 	attributeValue={22}
},
[2146] =
{
 		id=2146,
 		aiType=150012002,
 		star=3,
 		attributeType={3},
 	attributeValue={33}
},
[2147] =
{
 		id=2147,
 		aiType=150012002,
 		star=4,
 		attributeType={3},
 	attributeValue={44}
},
[2148] =
{
 		id=2148,
 		aiType=150012002,
 		star=5,
 		attributeType={3},
 	attributeValue={55}
},
[2149] =
{
 		id=2149,
 		aiType=150012002,
 		star=6,
 		attributeType={3},
 	attributeValue={65}
},
[2150] =
{
 		id=2150,
 		aiType=150012003,
 		attributeType={4,2},
 	attributeValue={0,0}
},
[2151] =
{
 		id=2151,
 		aiType=150012003,
 		star=1,
 		attributeType={4,2},
 	attributeValue={14,7}
},
[2152] =
{
 		id=2152,
 		aiType=150012003,
 		star=2,
 		attributeType={4,2},
 	attributeValue={27,13}
},
[2153] =
{
 		id=2153,
 		aiType=150012003,
 		star=3,
 		attributeType={4,2},
 	attributeValue={41,20}
},
[2154] =
{
 		id=2154,
 		aiType=150012003,
 		star=4,
 		attributeType={4,2},
 	attributeValue={54,27}
},
[2155] =
{
 		id=2155,
 		aiType=150012003,
 		star=5,
 		attributeType={4,2},
 	attributeValue={68,34}
},
[2156] =
{
 		id=2156,
 		aiType=150012003,
 		star=6,
 		attributeType={4,2},
 	attributeValue={81,40}
},
[2157] =
{
 		id=2157,
 		aiType=150012004,
 		attributeType={2,3},
 	attributeValue={0,0}
},
[2158] =
{
 		id=2158,
 		aiType=150012004,
 		star=1,
 		attributeType={2,3},
 	attributeValue={7,3}
},
[2159] =
{
 		id=2159,
 		aiType=150012004,
 		star=2,
 		attributeType={2,3},
 	attributeValue={13,5}
},
[2160] =
{
 		id=2160,
 		aiType=150012004,
 		star=3,
 		attributeType={2,3},
 	attributeValue={20,8}
},
[2161] =
{
 		id=2161,
 		aiType=150012004,
 		star=4,
 		attributeType={2,3},
 	attributeValue={27,11}
},
[2162] =
{
 		id=2162,
 		aiType=150012004,
 		star=5,
 		attributeType={2,3},
 	attributeValue={34,14}
},
[2163] =
{
 		id=2163,
 		aiType=150012004,
 		star=6,
 		attributeType={2,3},
 	attributeValue={40,16}
},
[2164] =
{
 		id=2164,
 		aiType=150012005,
 		attributeType={1,3},
 	attributeValue={0,0}
},
[2165] =
{
 		id=2165,
 		aiType=150012005,
 		star=1,
 		attributeType={1,3},
 	attributeValue={68,5}
},
[2166] =
{
 		id=2166,
 		aiType=150012005,
 		star=2,
 		attributeType={1,3},
 	attributeValue={135,9}
},
[2167] =
{
 		id=2167,
 		aiType=150012005,
 		star=3,
 		attributeType={1,3},
 	attributeValue={203,14}
},
[2168] =
{
 		id=2168,
 		aiType=150012005,
 		star=4,
 		attributeType={1,3},
 	attributeValue={270,18}
},
[2169] =
{
 		id=2169,
 		aiType=150012005,
 		star=5,
 		attributeType={1,3},
 	attributeValue={338,23}
},
[2170] =
{
 		id=2170,
 		aiType=150012005,
 		star=6,
 		attributeType={1,3},
 	attributeValue={405,27}
}
}

return {title=title, value=value}