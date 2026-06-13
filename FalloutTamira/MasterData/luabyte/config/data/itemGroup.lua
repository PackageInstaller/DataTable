local title = {
	id = 0,
	type = 0,
	items = {},
	cnts = {},
	weight = {},
	chanceLabel = {}
}

local value = {
[1] =
{
 		id=1,
 		type=3,
 		items={1,5},
 		cnts={5000,20},
 	chanceLabel={}
},
[2] =
{
 		id=2,
 		type=3,
 		items={1,501,511,521,531,541,551,502,512,522,532,542,552},
 		cnts={10000,1,1,1,1,1,1,1,1,1,1,1,1},
 	chanceLabel={}
},
[3] =
{
 		id=3,
 		type=3,
 		items={3010},
 		cnts={1},
 	chanceLabel={}
},
[4] =
{
 		id=4,
 		type=1,
 		items={3,1,85,102,104,7,8502,8503,8512,5,5,5},
 		cnts={2000,4000,1,1,1,500,1,1,1,10,30,50},
 		weight={2500,2000,500,1000,500,1000,500,500,900,300,200,100},
 	chanceLabel={}
},
[5] =
{
 		id=5,
 		type=3,
 		items={5},
 		cnts={10},
 	chanceLabel={}
},
[11] =
{
 		id=11,
 		type=3,
 		items={140004,1400042},
 		cnts={1,1},
 	chanceLabel={}
},
[12] =
{
 		id=12,
 		type=3,
 		items={52,86},
 		cnts={1,2},
 	chanceLabel={}
},
[31] =
{
 		id=31,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[32] =
{
 		id=32,
 		type=3,
 		items={3},
 		cnts={1},
 	chanceLabel={}
},
[33] =
{
 		id=33,
 		type=3,
 		items={201,202,203},
 		cnts={1,1,1},
 	chanceLabel={}
},
[34] =
{
 		id=34,
 		type=3,
 		items={701,711,721},
 		cnts={1,1,1},
 	chanceLabel={}
},
[35] =
{
 		id=35,
 		type=3,
 		items={241,242,243,244},
 		cnts={1,1,1,1},
 	chanceLabel={}
},
[36] =
{
 		id=36,
 		type=3,
 		items={63},
 		cnts={1},
 	chanceLabel={}
},
[41] =
{
 		id=41,
 		type=3,
 		items={1},
 		cnts={20000},
 	chanceLabel={}
},
[42] =
{
 		id=42,
 		type=3,
 		items={110005},
 		cnts={1},
 	chanceLabel={}
},
[43] =
{
 		id=43,
 		type=3,
 		items={57},
 		cnts={5},
 	chanceLabel={}
},
[44] =
{
 		id=44,
 		type=3,
 		items={56},
 		cnts={5},
 	chanceLabel={}
},
[45] =
{
 		id=45,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[46] =
{
 		id=46,
 		type=3,
 		items={151},
 		cnts={1},
 	chanceLabel={}
},
[47] =
{
 		id=47,
 		type=3,
 		items={52},
 		cnts={1},
 	chanceLabel={}
},
[51] =
{
 		id=51,
 		type=3,
 		items={5},
 		cnts={10},
 	chanceLabel={}
},
[52] =
{
 		id=52,
 		type=3,
 		items={5},
 		cnts={10},
 	chanceLabel={}
},
[53] =
{
 		id=53,
 		type=3,
 		items={5},
 		cnts={10},
 	chanceLabel={}
},
[54] =
{
 		id=54,
 		type=3,
 		items={5},
 		cnts={10},
 	chanceLabel={}
},
[61] =
{
 		id=61,
 		type=3,
 		items={5,3,1},
 		cnts={20,5000,10000},
 	chanceLabel={}
},
[62] =
{
 		id=62,
 		type=3,
 		items={102,104,1},
 		cnts={1,1,10000},
 	chanceLabel={}
},
[63] =
{
 		id=63,
 		type=3,
 		items={251,7,1},
 		cnts={1,200,10000},
 	chanceLabel={}
},
[71] =
{
 		id=71,
 		type=3,
 		items={5,2015},
 		cnts={40,1},
 	chanceLabel={}
},
[72] =
{
 		id=72,
 		type=3,
 		items={85},
 		cnts={1},
 	chanceLabel={}
},
[73] =
{
 		id=73,
 		type=3,
 		items={5,8503},
 		cnts={40,1},
 	chanceLabel={}
},
[74] =
{
 		id=74,
 		type=3,
 		items={5,8503},
 		cnts={40,1},
 	chanceLabel={}
},
[75] =
{
 		id=75,
 		type=3,
 		items={5,8503},
 		cnts={40,1},
 	chanceLabel={}
},
[76] =
{
 		id=76,
 		type=3,
 		items={5,8503},
 		cnts={40,1},
 	chanceLabel={}
},
[77] =
{
 		id=77,
 		type=3,
 		items={5,8503},
 		cnts={40,1},
 	chanceLabel={}
},
[81] =
{
 		id=81,
 		type=3,
 		items={1405},
 		cnts={1},
 	chanceLabel={}
},
[82] =
{
 		id=82,
 		type=3,
 		items={1414},
 		cnts={1},
 	chanceLabel={}
},
[83] =
{
 		id=83,
 		type=3,
 		items={1405,1413},
 		cnts={1,1},
 	chanceLabel={}
},
[84] =
{
 		id=84,
 		type=2,
 		items={5},
 		cnts={30},
 		weight={10000},
 	chanceLabel={}
},
[91] =
{
 		id=91,
 		type=3,
 		items={5},
 		cnts={300},
 	chanceLabel={}
},
[92] =
{
 		id=92,
 		type=3,
 		items={5},
 		cnts={500},
 	chanceLabel={}
},
[93] =
{
 		id=93,
 		type=3,
 		items={104},
 		cnts={5},
 	chanceLabel={}
},
[94] =
{
 		id=94,
 		type=3,
 		items={57},
 		cnts={5},
 	chanceLabel={}
},
[95] =
{
 		id=95,
 		type=3,
 		items={52},
 		cnts={1},
 	chanceLabel={}
},
[101] =
{
 		id=101,
 		type=1,
 		items={110001},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[102] =
{
 		id=102,
 		type=1,
 		items={110002},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[103] =
{
 		id=103,
 		type=1,
 		items={110008},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[104] =
{
 		id=104,
 		type=1,
 		items={120006},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[105] =
{
 		id=105,
 		type=1,
 		items={130008},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[106] =
{
 		id=106,
 		type=1,
 		items={140008},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[107] =
{
 		id=107,
 		type=1,
 		items={150008},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[108] =
{
 		id=108,
 		type=1,
 		items={140007,150007},
 		cnts={1,1},
 		weight={10000,10000},
 	chanceLabel={}
},
[109] =
{
 		id=109,
 		type=1,
 		items={140007,150007},
 		cnts={1,1},
 		weight={10000,10000},
 	chanceLabel={}
},
[110] =
{
 		id=110,
 		type=1,
 		items={120005},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[111] =
{
 		id=111,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[112] =
{
 		id=112,
 		type=3,
 		items={6,152,86,74,1602},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[113] =
{
 		id=113,
 		type=3,
 		items={6,152,86,74,1602},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[114] =
{
 		id=114,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[115] =
{
 		id=115,
 		type=3,
 		items={152,86,74,1602},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[201] =
{
 		id=201,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[202] =
{
 		id=202,
 		type=3,
 		items={6,152,86,74,1603},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[203] =
{
 		id=203,
 		type=3,
 		items={6,152,86,74,1603},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[204] =
{
 		id=204,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[205] =
{
 		id=205,
 		type=3,
 		items={152,86,74,1603},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[206] =
{
 		id=206,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[207] =
{
 		id=207,
 		type=3,
 		items={6,152,86,74,1604},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[208] =
{
 		id=208,
 		type=3,
 		items={6,152,86,74,1604},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[209] =
{
 		id=209,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[210] =
{
 		id=210,
 		type=3,
 		items={152,86,74,1604},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[211] =
{
 		id=211,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[212] =
{
 		id=212,
 		type=3,
 		items={6,152,86,74,1605},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[213] =
{
 		id=213,
 		type=3,
 		items={6,152,86,74,1605},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[214] =
{
 		id=214,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[215] =
{
 		id=215,
 		type=3,
 		items={152,86,74,1605},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[216] =
{
 		id=216,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[217] =
{
 		id=217,
 		type=3,
 		items={6,152,86,74,1606},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[218] =
{
 		id=218,
 		type=3,
 		items={6,152,86,74,1606},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[219] =
{
 		id=219,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[220] =
{
 		id=220,
 		type=3,
 		items={152,86,74,1606},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[221] =
{
 		id=221,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[222] =
{
 		id=222,
 		type=3,
 		items={6,152,86,74,1607},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[223] =
{
 		id=223,
 		type=3,
 		items={6,152,86,74,1607},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[224] =
{
 		id=224,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[225] =
{
 		id=225,
 		type=3,
 		items={152,86,74,1607},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[226] =
{
 		id=226,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[227] =
{
 		id=227,
 		type=3,
 		items={6,152,86,74,1608},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[228] =
{
 		id=228,
 		type=3,
 		items={6,152,86,74,1608},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[229] =
{
 		id=229,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[230] =
{
 		id=230,
 		type=3,
 		items={152,86,74,1608},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[231] =
{
 		id=231,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[232] =
{
 		id=232,
 		type=3,
 		items={6,152,86,74,1609},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[233] =
{
 		id=233,
 		type=3,
 		items={6,152,86,74,1609},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[234] =
{
 		id=234,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[235] =
{
 		id=235,
 		type=3,
 		items={152,86,74,1609},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[236] =
{
 		id=236,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[237] =
{
 		id=237,
 		type=3,
 		items={6,152,86,74,1610},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[238] =
{
 		id=238,
 		type=3,
 		items={6,152,86,74,1610},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[239] =
{
 		id=239,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[240] =
{
 		id=240,
 		type=3,
 		items={152,86,74,1610},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[241] =
{
 		id=241,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[242] =
{
 		id=242,
 		type=3,
 		items={6,152,86,74,1611},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[243] =
{
 		id=243,
 		type=3,
 		items={6,152,86,74,1611},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[244] =
{
 		id=244,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[245] =
{
 		id=245,
 		type=3,
 		items={152,86,74,1611},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[246] =
{
 		id=246,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[247] =
{
 		id=247,
 		type=3,
 		items={6,152,86,74,1612},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[248] =
{
 		id=248,
 		type=3,
 		items={6,152,86,74,1612},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[249] =
{
 		id=249,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[250] =
{
 		id=250,
 		type=3,
 		items={152,86,74,1612},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[251] =
{
 		id=251,
 		type=3,
 		items={6},
 		cnts={680},
 	chanceLabel={}
},
[252] =
{
 		id=252,
 		type=3,
 		items={6,152,86,74,1613},
 		cnts={1280,1,5,2000,1},
 	chanceLabel={}
},
[253] =
{
 		id=253,
 		type=3,
 		items={6,152,86,74,1613},
 		cnts={600,1,5,2000,1},
 	chanceLabel={}
},
[254] =
{
 		id=254,
 		type=3,
 		items={51,7,86,401,251},
 		cnts={20,5000,8,1,3},
 	chanceLabel={}
},
[255] =
{
 		id=255,
 		type=3,
 		items={152,86,74,1613},
 		cnts={1,5,2000,1},
 	chanceLabel={}
},
[121] =
{
 		id=121,
 		type=3,
 		items={9},
 		cnts={60},
 	chanceLabel={}
},
[122] =
{
 		id=122,
 		type=3,
 		items={9},
 		cnts={60},
 	chanceLabel={}
},
[301] =
{
 		id=301,
 		type=3,
 		items={3001},
 		cnts={1},
 	chanceLabel={}
},
[302] =
{
 		id=302,
 		type=3,
 		items={1304},
 		cnts={1},
 	chanceLabel={}
},
[303] =
{
 		id=303,
 		type=3,
 		items={1305},
 		cnts={1},
 	chanceLabel={}
},
[304] =
{
 		id=304,
 		type=3,
 		items={4602},
 		cnts={1},
 	chanceLabel={}
},
[305] =
{
 		id=305,
 		type=3,
 		items={1302},
 		cnts={1},
 	chanceLabel={}
},
[306] =
{
 		id=306,
 		type=3,
 		items={1303},
 		cnts={1},
 	chanceLabel={}
},
[307] =
{
 		id=307,
 		type=3,
 		items={4602,4603},
 		cnts={1,1},
 	chanceLabel={}
},
[308] =
{
 		id=308,
 		type=3,
 		items={1406},
 		cnts={1},
 	chanceLabel={}
},
[309] =
{
 		id=309,
 		type=3,
 		items={1407},
 		cnts={1},
 	chanceLabel={}
},
[310] =
{
 		id=310,
 		type=3,
 		items={1408},
 		cnts={1},
 	chanceLabel={}
},
[311] =
{
 		id=311,
 		type=3,
 		items={1409},
 		cnts={1},
 	chanceLabel={}
},
[312] =
{
 		id=312,
 		type=3,
 		items={1410},
 		cnts={1},
 	chanceLabel={}
},
[313] =
{
 		id=313,
 		type=3,
 		items={1411},
 		cnts={1},
 	chanceLabel={}
},
[314] =
{
 		id=314,
 		type=3,
 		items={1412},
 		cnts={1},
 	chanceLabel={}
},
[315] =
{
 		id=315,
 		type=3,
 		items={1405},
 		cnts={1},
 	chanceLabel={}
},
[351] =
{
 		id=351,
 		type=3,
 		items={4501},
 		cnts={1},
 	chanceLabel={}
},
[352] =
{
 		id=352,
 		type=3,
 		items={4502},
 		cnts={1},
 	chanceLabel={}
},
[353] =
{
 		id=353,
 		type=3,
 		items={4503},
 		cnts={1},
 	chanceLabel={}
},
[354] =
{
 		id=354,
 		type=3,
 		items={4504},
 		cnts={1},
 	chanceLabel={}
},
[355] =
{
 		id=355,
 		type=3,
 		items={4505},
 		cnts={1},
 	chanceLabel={}
},
[356] =
{
 		id=356,
 		type=3,
 		items={4506},
 		cnts={1},
 	chanceLabel={}
},
[357] =
{
 		id=357,
 		type=3,
 		items={4507},
 		cnts={1},
 	chanceLabel={}
},
[358] =
{
 		id=358,
 		type=3,
 		items={4030},
 		cnts={1},
 	chanceLabel={}
},
[359] =
{
 		id=359,
 		type=3,
 		items={4031},
 		cnts={1},
 	chanceLabel={}
},
[360] =
{
 		id=360,
 		type=3,
 		items={56},
 		cnts={1},
 	chanceLabel={}
},
[361] =
{
 		id=361,
 		type=3,
 		items={56},
 		cnts={1},
 	chanceLabel={}
},
[362] =
{
 		id=362,
 		type=3,
 		items={56},
 		cnts={1},
 	chanceLabel={}
},
[363] =
{
 		id=363,
 		type=3,
 		items={8503},
 		cnts={1},
 	chanceLabel={}
},
[364] =
{
 		id=364,
 		type=3,
 		items={8503},
 		cnts={1},
 	chanceLabel={}
},
[365] =
{
 		id=365,
 		type=3,
 		items={8503},
 		cnts={1},
 	chanceLabel={}
},
[366] =
{
 		id=366,
 		type=3,
 		items={4028},
 		cnts={1},
 	chanceLabel={}
},
[377] =
{
 		id=377,
 		type=3,
 		items={5},
 		cnts={30},
 	chanceLabel={}
},
[378] =
{
 		id=378,
 		type=3,
 		items={5},
 		cnts={30},
 	chanceLabel={}
},
[379] =
{
 		id=379,
 		type=3,
 		items={5},
 		cnts={30},
 	chanceLabel={}
},
[380] =
{
 		id=380,
 		type=3,
 		items={5},
 		cnts={30},
 	chanceLabel={}
},
[401] =
{
 		id=401,
 		type=3,
 		items={1,73},
 		cnts={4000,10},
 	chanceLabel={}
},
[402] =
{
 		id=402,
 		type=3,
 		items={3,73},
 		cnts={2000,15},
 	chanceLabel={}
},
[403] =
{
 		id=403,
 		type=3,
 		items={1,73},
 		cnts={4000,15},
 	chanceLabel={}
},
[404] =
{
 		id=404,
 		type=3,
 		items={3,73},
 		cnts={2000,15},
 	chanceLabel={}
},
[405] =
{
 		id=405,
 		type=3,
 		items={1,73},
 		cnts={4000,15},
 	chanceLabel={}
},
[406] =
{
 		id=406,
 		type=3,
 		items={3,73},
 		cnts={2000,15},
 	chanceLabel={}
},
[407] =
{
 		id=407,
 		type=3,
 		items={1,73},
 		cnts={4000,10},
 	chanceLabel={}
},
[408] =
{
 		id=408,
 		type=3,
 		items={3,73},
 		cnts={2000,15},
 	chanceLabel={}
},
[409] =
{
 		id=409,
 		type=3,
 		items={1,73},
 		cnts={4000,10},
 	chanceLabel={}
},
[410] =
{
 		id=410,
 		type=3,
 		items={3,73},
 		cnts={2500,10},
 	chanceLabel={}
},
[411] =
{
 		id=411,
 		type=3,
 		items={1,73},
 		cnts={5000,15},
 	chanceLabel={}
},
[412] =
{
 		id=412,
 		type=3,
 		items={3,73},
 		cnts={2500,15},
 	chanceLabel={}
},
[413] =
{
 		id=413,
 		type=3,
 		items={1,73},
 		cnts={5000,15},
 	chanceLabel={}
},
[414] =
{
 		id=414,
 		type=3,
 		items={3,73},
 		cnts={2500,15},
 	chanceLabel={}
},
[415] =
{
 		id=415,
 		type=3,
 		items={8521,73},
 		cnts={2,15},
 	chanceLabel={}
},
[416] =
{
 		id=416,
 		type=3,
 		items={3,73},
 		cnts={2500,10},
 	chanceLabel={}
},
[417] =
{
 		id=417,
 		type=3,
 		items={1,73},
 		cnts={5000,15},
 	chanceLabel={}
},
[418] =
{
 		id=418,
 		type=3,
 		items={3,73},
 		cnts={2500,10},
 	chanceLabel={}
},
[419] =
{
 		id=419,
 		type=3,
 		items={1,73},
 		cnts={6000,10},
 	chanceLabel={}
},
[420] =
{
 		id=420,
 		type=3,
 		items={3,73},
 		cnts={3000,15},
 	chanceLabel={}
},
[421] =
{
 		id=421,
 		type=3,
 		items={8522,73},
 		cnts={2,15},
 	chanceLabel={}
},
[422] =
{
 		id=422,
 		type=3,
 		items={3,73},
 		cnts={3000,15},
 	chanceLabel={}
},
[423] =
{
 		id=423,
 		type=3,
 		items={1,73},
 		cnts={6000,15},
 	chanceLabel={}
},
[424] =
{
 		id=424,
 		type=3,
 		items={3,73},
 		cnts={3000,15},
 	chanceLabel={}
},
[425] =
{
 		id=425,
 		type=3,
 		items={1,73},
 		cnts={6000,10},
 	chanceLabel={}
},
[426] =
{
 		id=426,
 		type=3,
 		items={3,73},
 		cnts={3000,15},
 	chanceLabel={}
},
[427] =
{
 		id=427,
 		type=3,
 		items={1,73},
 		cnts={6000,10},
 	chanceLabel={}
},
[428] =
{
 		id=428,
 		type=3,
 		items={3,73},
 		cnts={3500,10},
 	chanceLabel={}
},
[429] =
{
 		id=429,
 		type=3,
 		items={8523,73},
 		cnts={1,15},
 	chanceLabel={}
},
[430] =
{
 		id=430,
 		type=3,
 		items={3,73},
 		cnts={3500,15},
 	chanceLabel={}
},
[431] =
{
 		id=431,
 		type=3,
 		items={1,73},
 		cnts={7000,15},
 	chanceLabel={}
},
[432] =
{
 		id=432,
 		type=3,
 		items={3,73},
 		cnts={3500,15},
 	chanceLabel={}
},
[433] =
{
 		id=433,
 		type=3,
 		items={1,73},
 		cnts={7000,15},
 	chanceLabel={}
},
[434] =
{
 		id=434,
 		type=3,
 		items={3,73},
 		cnts={3500,10},
 	chanceLabel={}
},
[435] =
{
 		id=435,
 		type=3,
 		items={1,73},
 		cnts={7000,15},
 	chanceLabel={}
},
[436] =
{
 		id=436,
 		type=3,
 		items={3,73},
 		cnts={3500,10},
 	chanceLabel={}
},
[437] =
{
 		id=437,
 		type=3,
 		items={1,73},
 		cnts={8000,10},
 	chanceLabel={}
},
[438] =
{
 		id=438,
 		type=3,
 		items={3,73},
 		cnts={4000,15},
 	chanceLabel={}
},
[439] =
{
 		id=439,
 		type=3,
 		items={8523,73},
 		cnts={1,15},
 	chanceLabel={}
},
[440] =
{
 		id=440,
 		type=3,
 		items={3,73},
 		cnts={4000,15},
 	chanceLabel={}
},
[441] =
{
 		id=441,
 		type=3,
 		items={1,73},
 		cnts={8000,15},
 	chanceLabel={}
},
[442] =
{
 		id=442,
 		type=3,
 		items={3,73},
 		cnts={4000,15},
 	chanceLabel={}
},
[443] =
{
 		id=443,
 		type=3,
 		items={1,73},
 		cnts={8000,10},
 	chanceLabel={}
},
[444] =
{
 		id=444,
 		type=3,
 		items={3,73},
 		cnts={4000,15},
 	chanceLabel={}
},
[445] =
{
 		id=445,
 		type=3,
 		items={1,73},
 		cnts={8000,10},
 	chanceLabel={}
},
[446] =
{
 		id=446,
 		type=3,
 		items={3,73},
 		cnts={4500,10},
 	chanceLabel={}
},
[447] =
{
 		id=447,
 		type=3,
 		items={1,73},
 		cnts={9000,15},
 	chanceLabel={}
},
[448] =
{
 		id=448,
 		type=3,
 		items={3,73},
 		cnts={4500,15},
 	chanceLabel={}
},
[449] =
{
 		id=449,
 		type=3,
 		items={1,73},
 		cnts={9000,15},
 	chanceLabel={}
},
[450] =
{
 		id=450,
 		type=3,
 		items={3,73},
 		cnts={4500,15},
 	chanceLabel={}
},
[451] =
{
 		id=451,
 		type=3,
 		items={1,73},
 		cnts={9000,15},
 	chanceLabel={}
},
[452] =
{
 		id=452,
 		type=3,
 		items={3,73},
 		cnts={4500,10},
 	chanceLabel={}
},
[453] =
{
 		id=453,
 		type=3,
 		items={1,73},
 		cnts={9000,15},
 	chanceLabel={}
},
[454] =
{
 		id=454,
 		type=3,
 		items={3,73},
 		cnts={4500,10},
 	chanceLabel={}
},
[455] =
{
 		id=455,
 		type=3,
 		items={8524,73},
 		cnts={1,10},
 	chanceLabel={}
},
[456] =
{
 		id=456,
 		type=3,
 		items={3,73},
 		cnts={5000,15},
 	chanceLabel={}
},
[457] =
{
 		id=457,
 		type=3,
 		items={1,73},
 		cnts={10000,15},
 	chanceLabel={}
},
[458] =
{
 		id=458,
 		type=3,
 		items={3,73},
 		cnts={5000,15},
 	chanceLabel={}
},
[459] =
{
 		id=459,
 		type=3,
 		items={1,73},
 		cnts={10000,15},
 	chanceLabel={}
},
[460] =
{
 		id=460,
 		type=3,
 		items={3,73},
 		cnts={5000,15},
 	chanceLabel={}
},
[461] =
{
 		id=461,
 		type=3,
 		items={1,73},
 		cnts={10000,10},
 	chanceLabel={}
},
[462] =
{
 		id=462,
 		type=3,
 		items={3,73},
 		cnts={5000,15},
 	chanceLabel={}
},
[463] =
{
 		id=463,
 		type=3,
 		items={1,73},
 		cnts={10000,10},
 	chanceLabel={}
},
[464] =
{
 		id=464,
 		type=3,
 		items={110003},
 		cnts={1},
 	chanceLabel={}
},
[465] =
{
 		id=465,
 		type=3,
 		items={110003},
 		cnts={1},
 	chanceLabel={}
},
[466] =
{
 		id=466,
 		type=3,
 		items={110003},
 		cnts={1},
 	chanceLabel={}
},
[467] =
{
 		id=467,
 		type=3,
 		items={110003},
 		cnts={1},
 	chanceLabel={}
},
[468] =
{
 		id=468,
 		type=3,
 		items={110003},
 		cnts={1},
 	chanceLabel={}
},
[469] =
{
 		id=469,
 		type=3,
 		items={110003},
 		cnts={1},
 	chanceLabel={}
},
[470] =
{
 		id=470,
 		type=3,
 		items={151},
 		cnts={1},
 	chanceLabel={}
},
[471] =
{
 		id=471,
 		type=3,
 		items={2023},
 		cnts={1},
 	chanceLabel={}
},
[472] =
{
 		id=472,
 		type=3,
 		items={2007},
 		cnts={1},
 	chanceLabel={}
},
[473] =
{
 		id=473,
 		type=3,
 		items={2021},
 		cnts={1},
 	chanceLabel={}
},
[474] =
{
 		id=474,
 		type=3,
 		items={56},
 		cnts={1},
 	chanceLabel={}
},
[475] =
{
 		id=475,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[476] =
{
 		id=476,
 		type=3,
 		items={1},
 		cnts={1},
 	chanceLabel={}
},
[477] =
{
 		id=477,
 		type=3,
 		items={1},
 		cnts={1},
 	chanceLabel={}
},
[478] =
{
 		id=478,
 		type=3,
 		items={1},
 		cnts={1},
 	chanceLabel={}
},
[479] =
{
 		id=479,
 		type=3,
 		items={1},
 		cnts={1},
 	chanceLabel={}
},
[480] =
{
 		id=480,
 		type=3,
 		items={1},
 		cnts={1},
 	chanceLabel={}
},
[481] =
{
 		id=481,
 		type=3,
 		items={1},
 		cnts={1},
 	chanceLabel={}
},
[482] =
{
 		id=482,
 		type=3,
 		items={1},
 		cnts={1},
 	chanceLabel={}
},
[501] =
{
 		id=501,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[502] =
{
 		id=502,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[503] =
{
 		id=503,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[504] =
{
 		id=504,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[505] =
{
 		id=505,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[506] =
{
 		id=506,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[551] =
{
 		id=551,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[552] =
{
 		id=552,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[553] =
{
 		id=553,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[554] =
{
 		id=554,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[555] =
{
 		id=555,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[556] =
{
 		id=556,
 		type=3,
 		items={58},
 		cnts={1},
 	chanceLabel={}
},
[601] =
{
 		id=601,
 		type=3,
 		items={5,701,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[602] =
{
 		id=602,
 		type=3,
 		items={5,711,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[603] =
{
 		id=603,
 		type=3,
 		items={57,721,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[604] =
{
 		id=604,
 		type=3,
 		items={731,701,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[605] =
{
 		id=605,
 		type=3,
 		items={5,711,1},
 		cnts={80,1,2000},
 	chanceLabel={}
},
[606] =
{
 		id=606,
 		type=3,
 		items={57,721,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[607] =
{
 		id=607,
 		type=3,
 		items={731,701,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[608] =
{
 		id=608,
 		type=3,
 		items={5,711,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[609] =
{
 		id=609,
 		type=3,
 		items={57,721,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[610] =
{
 		id=610,
 		type=3,
 		items={731,701,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[611] =
{
 		id=611,
 		type=3,
 		items={5,711,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[612] =
{
 		id=612,
 		type=3,
 		items={57,721,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[613] =
{
 		id=613,
 		type=3,
 		items={731,701,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[614] =
{
 		id=614,
 		type=3,
 		items={5,711,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[615] =
{
 		id=615,
 		type=3,
 		items={57,721,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[616] =
{
 		id=616,
 		type=3,
 		items={5,701,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[617] =
{
 		id=617,
 		type=3,
 		items={5,711,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[618] =
{
 		id=618,
 		type=3,
 		items={57,721,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[701] =
{
 		id=701,
 		type=3,
 		items={8503,701,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[702] =
{
 		id=702,
 		type=3,
 		items={731,711,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[703] =
{
 		id=703,
 		type=3,
 		items={5,721,1},
 		cnts={100,1,2000},
 	chanceLabel={}
},
[704] =
{
 		id=704,
 		type=3,
 		items={8503,701,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[705] =
{
 		id=705,
 		type=3,
 		items={731,711,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[706] =
{
 		id=706,
 		type=3,
 		items={5,721,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[707] =
{
 		id=707,
 		type=3,
 		items={8503,701,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[708] =
{
 		id=708,
 		type=3,
 		items={731,711,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[709] =
{
 		id=709,
 		type=3,
 		items={5,721,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[710] =
{
 		id=710,
 		type=3,
 		items={8503,701,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[711] =
{
 		id=711,
 		type=3,
 		items={731,711,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[712] =
{
 		id=712,
 		type=3,
 		items={5,721,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[713] =
{
 		id=713,
 		type=3,
 		items={8503,701,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[714] =
{
 		id=714,
 		type=3,
 		items={731,711,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[715] =
{
 		id=715,
 		type=3,
 		items={5,721,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[716] =
{
 		id=716,
 		type=3,
 		items={8503,701,1},
 		cnts={1,1,2000},
 	chanceLabel={}
},
[717] =
{
 		id=717,
 		type=3,
 		items={5,711,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[718] =
{
 		id=718,
 		type=3,
 		items={5,721,1},
 		cnts={40,1,2000},
 	chanceLabel={}
},
[800] =
{
 		id=800,
 		type=3,
 		items={5,86},
 		cnts={80,1},
 	chanceLabel={}
},
[801] =
{
 		id=801,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[802] =
{
 		id=802,
 		type=3,
 		items={3},
 		cnts={3000},
 	chanceLabel={}
},
[803] =
{
 		id=803,
 		type=3,
 		items={201},
 		cnts={1},
 	chanceLabel={}
},
[804] =
{
 		id=804,
 		type=3,
 		items={241},
 		cnts={1},
 	chanceLabel={}
},
[805] =
{
 		id=805,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[806] =
{
 		id=806,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[807] =
{
 		id=807,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[808] =
{
 		id=808,
 		type=3,
 		items={1},
 		cnts={8000},
 	chanceLabel={}
},
[809] =
{
 		id=809,
 		type=3,
 		items={3},
 		cnts={4000},
 	chanceLabel={}
},
[810] =
{
 		id=810,
 		type=3,
 		items={201},
 		cnts={1},
 	chanceLabel={}
},
[811] =
{
 		id=811,
 		type=3,
 		items={241},
 		cnts={1},
 	chanceLabel={}
},
[812] =
{
 		id=812,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[813] =
{
 		id=813,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[814] =
{
 		id=814,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[815] =
{
 		id=815,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[816] =
{
 		id=816,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[817] =
{
 		id=817,
 		type=3,
 		items={201},
 		cnts={2},
 	chanceLabel={}
},
[818] =
{
 		id=818,
 		type=3,
 		items={241},
 		cnts={2},
 	chanceLabel={}
},
[819] =
{
 		id=819,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[820] =
{
 		id=820,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[821] =
{
 		id=821,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[822] =
{
 		id=822,
 		type=3,
 		items={1},
 		cnts={12000},
 	chanceLabel={}
},
[823] =
{
 		id=823,
 		type=3,
 		items={3},
 		cnts={6000},
 	chanceLabel={}
},
[824] =
{
 		id=824,
 		type=3,
 		items={201},
 		cnts={2},
 	chanceLabel={}
},
[825] =
{
 		id=825,
 		type=3,
 		items={241},
 		cnts={2},
 	chanceLabel={}
},
[826] =
{
 		id=826,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[827] =
{
 		id=827,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[828] =
{
 		id=828,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[829] =
{
 		id=829,
 		type=3,
 		items={1},
 		cnts={14000},
 	chanceLabel={}
},
[830] =
{
 		id=830,
 		type=3,
 		items={3},
 		cnts={7000},
 	chanceLabel={}
},
[831] =
{
 		id=831,
 		type=3,
 		items={201},
 		cnts={3},
 	chanceLabel={}
},
[900] =
{
 		id=900,
 		type=3,
 		items={1401,52,5,56,1},
 		cnts={1,1,800,3,10000},
 	chanceLabel={}
},
[901] =
{
 		id=901,
 		type=3,
 		items={8103,58},
 		cnts={1,1},
 	chanceLabel={}
},
[903] =
{
 		id=903,
 		type=3,
 		items={1601},
 		cnts={1},
 	chanceLabel={}
},
[1001] =
{
 		id=1001,
 		type=3,
 		items={86},
 		cnts={2},
 	chanceLabel={}
},
[1002] =
{
 		id=1002,
 		type=3,
 		items={8502},
 		cnts={5},
 	chanceLabel={}
},
[1003] =
{
 		id=1003,
 		type=3,
 		items={251},
 		cnts={5},
 	chanceLabel={}
},
[1004] =
{
 		id=1004,
 		type=3,
 		items={57},
 		cnts={5},
 	chanceLabel={}
},
[1005] =
{
 		id=1005,
 		type=3,
 		items={56},
 		cnts={5},
 	chanceLabel={}
},
[1006] =
{
 		id=1006,
 		type=3,
 		items={8526},
 		cnts={2},
 	chanceLabel={}
},
[1007] =
{
 		id=1007,
 		type=3,
 		items={151},
 		cnts={1},
 	chanceLabel={}
},
[1008] =
{
 		id=1008,
 		type=3,
 		items={51},
 		cnts={5},
 	chanceLabel={}
},
[1009] =
{
 		id=1009,
 		type=3,
 		items={51},
 		cnts={5},
 	chanceLabel={}
},
[1010] =
{
 		id=1010,
 		type=3,
 		items={401},
 		cnts={1},
 	chanceLabel={}
},
[1011] =
{
 		id=1011,
 		type=3,
 		items={8526},
 		cnts={1},
 	chanceLabel={}
},
[1012] =
{
 		id=1012,
 		type=3,
 		items={151},
 		cnts={1},
 	chanceLabel={}
},
[1013] =
{
 		id=1013,
 		type=3,
 		items={57},
 		cnts={2},
 	chanceLabel={}
},
[1014] =
{
 		id=1014,
 		type=3,
 		items={51},
 		cnts={2},
 	chanceLabel={}
},
[1015] =
{
 		id=1015,
 		type=3,
 		items={401},
 		cnts={1},
 	chanceLabel={}
},
[1303] =
{
 		id=1303,
 		type=3,
 		items={1303},
 		cnts={1},
 	chanceLabel={}
},
[1308] =
{
 		id=1308,
 		type=3,
 		items={1308},
 		cnts={1},
 	chanceLabel={}
},
[1309] =
{
 		id=1309,
 		type=3,
 		items={1309},
 		cnts={1},
 	chanceLabel={}
},
[1501] =
{
 		id=1501,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[1502] =
{
 		id=1502,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[1503] =
{
 		id=1503,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[1504] =
{
 		id=1504,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[1505] =
{
 		id=1505,
 		type=3,
 		items={8502},
 		cnts={1},
 	chanceLabel={}
},
[1506] =
{
 		id=1506,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[1507] =
{
 		id=1507,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[1508] =
{
 		id=1508,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[1509] =
{
 		id=1509,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[1510] =
{
 		id=1510,
 		type=3,
 		items={51},
 		cnts={1},
 	chanceLabel={}
},
[1511] =
{
 		id=1511,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[1512] =
{
 		id=1512,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[1513] =
{
 		id=1513,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[1514] =
{
 		id=1514,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[1515] =
{
 		id=1515,
 		type=3,
 		items={8502},
 		cnts={1},
 	chanceLabel={}
},
[1516] =
{
 		id=1516,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[1517] =
{
 		id=1517,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[1518] =
{
 		id=1518,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[1519] =
{
 		id=1519,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[1520] =
{
 		id=1520,
 		type=3,
 		items={51},
 		cnts={1},
 	chanceLabel={}
},
[1521] =
{
 		id=1521,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[1522] =
{
 		id=1522,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[1523] =
{
 		id=1523,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[1524] =
{
 		id=1524,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[1525] =
{
 		id=1525,
 		type=3,
 		items={8502},
 		cnts={1},
 	chanceLabel={}
},
[1526] =
{
 		id=1526,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[1527] =
{
 		id=1527,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[1528] =
{
 		id=1528,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[1529] =
{
 		id=1529,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[1530] =
{
 		id=1530,
 		type=3,
 		items={51},
 		cnts={1},
 	chanceLabel={}
},
[1531] =
{
 		id=1531,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[1532] =
{
 		id=1532,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[1533] =
{
 		id=1533,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[1534] =
{
 		id=1534,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[1535] =
{
 		id=1535,
 		type=3,
 		items={8502},
 		cnts={1},
 	chanceLabel={}
},
[1536] =
{
 		id=1536,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[1537] =
{
 		id=1537,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[1538] =
{
 		id=1538,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[1539] =
{
 		id=1539,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[1540] =
{
 		id=1540,
 		type=3,
 		items={51},
 		cnts={1},
 	chanceLabel={}
},
[1541] =
{
 		id=1541,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[1542] =
{
 		id=1542,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[1543] =
{
 		id=1543,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[1544] =
{
 		id=1544,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[1545] =
{
 		id=1545,
 		type=3,
 		items={8502},
 		cnts={1},
 	chanceLabel={}
},
[1546] =
{
 		id=1546,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[1547] =
{
 		id=1547,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[1548] =
{
 		id=1548,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[1549] =
{
 		id=1549,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[1550] =
{
 		id=1550,
 		type=3,
 		items={401},
 		cnts={1},
 	chanceLabel={}
},
[1601] =
{
 		id=1601,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[1602] =
{
 		id=1602,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[1603] =
{
 		id=1603,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[1604] =
{
 		id=1604,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[1605] =
{
 		id=1605,
 		type=3,
 		items={51,86},
 		cnts={1,1},
 	chanceLabel={}
},
[1606] =
{
 		id=1606,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[1607] =
{
 		id=1607,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[1608] =
{
 		id=1608,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[1609] =
{
 		id=1609,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[1610] =
{
 		id=1610,
 		type=3,
 		items={51,86},
 		cnts={2,1},
 	chanceLabel={}
},
[1611] =
{
 		id=1611,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[1612] =
{
 		id=1612,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[1613] =
{
 		id=1613,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[1614] =
{
 		id=1614,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[1615] =
{
 		id=1615,
 		type=3,
 		items={51,86},
 		cnts={1,1},
 	chanceLabel={}
},
[1616] =
{
 		id=1616,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[1617] =
{
 		id=1617,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[1618] =
{
 		id=1618,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[1619] =
{
 		id=1619,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[1620] =
{
 		id=1620,
 		type=3,
 		items={51,86},
 		cnts={2,1},
 	chanceLabel={}
},
[1621] =
{
 		id=1621,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[1622] =
{
 		id=1622,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[1623] =
{
 		id=1623,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[1624] =
{
 		id=1624,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[1625] =
{
 		id=1625,
 		type=3,
 		items={51,86},
 		cnts={1,1},
 	chanceLabel={}
},
[1626] =
{
 		id=1626,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[1627] =
{
 		id=1627,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[1628] =
{
 		id=1628,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[1629] =
{
 		id=1629,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[1630] =
{
 		id=1630,
 		type=3,
 		items={51,251},
 		cnts={3,3},
 	chanceLabel={}
},
[1631] =
{
 		id=1631,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[1632] =
{
 		id=1632,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[1633] =
{
 		id=1633,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[1634] =
{
 		id=1634,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[1635] =
{
 		id=1635,
 		type=3,
 		items={51,86},
 		cnts={2,1},
 	chanceLabel={}
},
[1636] =
{
 		id=1636,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[1637] =
{
 		id=1637,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[1638] =
{
 		id=1638,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[1639] =
{
 		id=1639,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[1640] =
{
 		id=1640,
 		type=3,
 		items={51,86},
 		cnts={2,1},
 	chanceLabel={}
},
[1641] =
{
 		id=1641,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[1642] =
{
 		id=1642,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[1643] =
{
 		id=1643,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[1644] =
{
 		id=1644,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[1645] =
{
 		id=1645,
 		type=3,
 		items={51,86},
 		cnts={2,1},
 	chanceLabel={}
},
[1646] =
{
 		id=1646,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[1647] =
{
 		id=1647,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[1648] =
{
 		id=1648,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[1649] =
{
 		id=1649,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[1650] =
{
 		id=1650,
 		type=3,
 		items={51,401},
 		cnts={4,1},
 	chanceLabel={}
},
[1701] =
{
 		id=1701,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[1702] =
{
 		id=1702,
 		type=3,
 		items={57},
 		cnts={2},
 	chanceLabel={}
},
[1703] =
{
 		id=1703,
 		type=3,
 		items={57},
 		cnts={2},
 	chanceLabel={}
},
[1704] =
{
 		id=1704,
 		type=3,
 		items={57},
 		cnts={2},
 	chanceLabel={}
},
[1705] =
{
 		id=1705,
 		type=3,
 		items={57},
 		cnts={2},
 	chanceLabel={}
},
[1706] =
{
 		id=1706,
 		type=3,
 		items={57},
 		cnts={3},
 	chanceLabel={}
},
[1707] =
{
 		id=1707,
 		type=3,
 		items={57},
 		cnts={3},
 	chanceLabel={}
},
[2101] =
{
 		id=2101,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[2111] =
{
 		id=2111,
 		type=3,
 		items={5},
 		cnts={10},
 	chanceLabel={}
},
[2121] =
{
 		id=2121,
 		type=3,
 		items={5},
 		cnts={20},
 	chanceLabel={}
},
[2201] =
{
 		id=2201,
 		type=3,
 		items={1},
 		cnts={12000},
 	chanceLabel={}
},
[2202] =
{
 		id=2202,
 		type=3,
 		items={3},
 		cnts={6000},
 	chanceLabel={}
},
[2203] =
{
 		id=2203,
 		type=3,
 		items={201},
 		cnts={3},
 	chanceLabel={}
},
[2204] =
{
 		id=2204,
 		type=3,
 		items={63},
 		cnts={3},
 	chanceLabel={}
},
[2205] =
{
 		id=2205,
 		type=3,
 		items={241},
 		cnts={3},
 	chanceLabel={}
},
[2206] =
{
 		id=2206,
 		type=3,
 		items={1},
 		cnts={14000},
 	chanceLabel={}
},
[2207] =
{
 		id=2207,
 		type=3,
 		items={3},
 		cnts={7000},
 	chanceLabel={}
},
[2208] =
{
 		id=2208,
 		type=3,
 		items={201},
 		cnts={3},
 	chanceLabel={}
},
[2209] =
{
 		id=2209,
 		type=3,
 		items={63},
 		cnts={3},
 	chanceLabel={}
},
[2210] =
{
 		id=2210,
 		type=3,
 		items={241},
 		cnts={3},
 	chanceLabel={}
},
[2211] =
{
 		id=2211,
 		type=3,
 		items={1},
 		cnts={16000},
 	chanceLabel={}
},
[2212] =
{
 		id=2212,
 		type=3,
 		items={3},
 		cnts={8000},
 	chanceLabel={}
},
[2213] =
{
 		id=2213,
 		type=3,
 		items={201},
 		cnts={4},
 	chanceLabel={}
},
[2214] =
{
 		id=2214,
 		type=3,
 		items={63},
 		cnts={4},
 	chanceLabel={}
},
[2215] =
{
 		id=2215,
 		type=3,
 		items={241},
 		cnts={4},
 	chanceLabel={}
},
[2216] =
{
 		id=2216,
 		type=3,
 		items={1},
 		cnts={18000},
 	chanceLabel={}
},
[2217] =
{
 		id=2217,
 		type=3,
 		items={3},
 		cnts={9000},
 	chanceLabel={}
},
[2218] =
{
 		id=2218,
 		type=3,
 		items={201},
 		cnts={5},
 	chanceLabel={}
},
[2219] =
{
 		id=2219,
 		type=3,
 		items={63},
 		cnts={5},
 	chanceLabel={}
},
[2220] =
{
 		id=2220,
 		type=3,
 		items={241},
 		cnts={5},
 	chanceLabel={}
},
[2221] =
{
 		id=2221,
 		type=3,
 		items={1},
 		cnts={20000},
 	chanceLabel={}
},
[2222] =
{
 		id=2222,
 		type=3,
 		items={3},
 		cnts={10000},
 	chanceLabel={}
},
[2223] =
{
 		id=2223,
 		type=3,
 		items={202},
 		cnts={2},
 	chanceLabel={}
},
[2224] =
{
 		id=2224,
 		type=3,
 		items={242},
 		cnts={3},
 	chanceLabel={}
},
[2225] =
{
 		id=2225,
 		type=3,
 		items={62},
 		cnts={2},
 	chanceLabel={}
},
[2226] =
{
 		id=2226,
 		type=3,
 		items={64},
 		cnts={4},
 	chanceLabel={}
},
[2227] =
{
 		id=2227,
 		type=3,
 		items={231},
 		cnts={2},
 	chanceLabel={}
},
[2228] =
{
 		id=2228,
 		type=3,
 		items={1},
 		cnts={22000},
 	chanceLabel={}
},
[2229] =
{
 		id=2229,
 		type=3,
 		items={3},
 		cnts={11000},
 	chanceLabel={}
},
[2230] =
{
 		id=2230,
 		type=3,
 		items={202},
 		cnts={2},
 	chanceLabel={}
},
[2231] =
{
 		id=2231,
 		type=3,
 		items={242},
 		cnts={4},
 	chanceLabel={}
},
[2232] =
{
 		id=2232,
 		type=3,
 		items={62},
 		cnts={2},
 	chanceLabel={}
},
[2233] =
{
 		id=2233,
 		type=3,
 		items={64},
 		cnts={5},
 	chanceLabel={}
},
[2234] =
{
 		id=2234,
 		type=3,
 		items={231},
 		cnts={2},
 	chanceLabel={}
},
[2235] =
{
 		id=2235,
 		type=3,
 		items={1},
 		cnts={24000},
 	chanceLabel={}
},
[2236] =
{
 		id=2236,
 		type=3,
 		items={3},
 		cnts={12000},
 	chanceLabel={}
},
[2237] =
{
 		id=2237,
 		type=3,
 		items={202},
 		cnts={2},
 	chanceLabel={}
},
[2238] =
{
 		id=2238,
 		type=3,
 		items={242},
 		cnts={4},
 	chanceLabel={}
},
[2239] =
{
 		id=2239,
 		type=3,
 		items={62},
 		cnts={3},
 	chanceLabel={}
},
[2240] =
{
 		id=2240,
 		type=3,
 		items={64},
 		cnts={5},
 	chanceLabel={}
},
[2241] =
{
 		id=2241,
 		type=3,
 		items={231},
 		cnts={3},
 	chanceLabel={}
},
[2242] =
{
 		id=2242,
 		type=3,
 		items={1},
 		cnts={26000},
 	chanceLabel={}
},
[2243] =
{
 		id=2243,
 		type=3,
 		items={3},
 		cnts={13000},
 	chanceLabel={}
},
[2244] =
{
 		id=2244,
 		type=3,
 		items={202},
 		cnts={3},
 	chanceLabel={}
},
[2245] =
{
 		id=2245,
 		type=3,
 		items={242},
 		cnts={5},
 	chanceLabel={}
},
[2246] =
{
 		id=2246,
 		type=3,
 		items={62},
 		cnts={3},
 	chanceLabel={}
},
[2247] =
{
 		id=2247,
 		type=3,
 		items={64},
 		cnts={6},
 	chanceLabel={}
},
[2248] =
{
 		id=2248,
 		type=3,
 		items={231},
 		cnts={3},
 	chanceLabel={}
},
[2249] =
{
 		id=2249,
 		type=3,
 		items={1},
 		cnts={30000},
 	chanceLabel={}
},
[2250] =
{
 		id=2250,
 		type=3,
 		items={3},
 		cnts={15000},
 	chanceLabel={}
},
[2251] =
{
 		id=2251,
 		type=3,
 		items={243},
 		cnts={2},
 	chanceLabel={}
},
[2252] =
{
 		id=2252,
 		type=3,
 		items={102},
 		cnts={2},
 	chanceLabel={}
},
[2253] =
{
 		id=2253,
 		type=3,
 		items={5},
 		cnts={40},
 	chanceLabel={}
},
[2254] =
{
 		id=2254,
 		type=3,
 		items={1},
 		cnts={32000},
 	chanceLabel={}
},
[2255] =
{
 		id=2255,
 		type=3,
 		items={3},
 		cnts={16000},
 	chanceLabel={}
},
[2256] =
{
 		id=2256,
 		type=3,
 		items={243},
 		cnts={2},
 	chanceLabel={}
},
[2257] =
{
 		id=2257,
 		type=3,
 		items={102},
 		cnts={2},
 	chanceLabel={}
},
[2258] =
{
 		id=2258,
 		type=3,
 		items={5},
 		cnts={35},
 	chanceLabel={}
},
[2259] =
{
 		id=2259,
 		type=3,
 		items={1},
 		cnts={34000},
 	chanceLabel={}
},
[2260] =
{
 		id=2260,
 		type=3,
 		items={3},
 		cnts={17000},
 	chanceLabel={}
},
[2261] =
{
 		id=2261,
 		type=3,
 		items={243},
 		cnts={3},
 	chanceLabel={}
},
[2262] =
{
 		id=2262,
 		type=3,
 		items={102},
 		cnts={2},
 	chanceLabel={}
},
[2263] =
{
 		id=2263,
 		type=3,
 		items={5},
 		cnts={40},
 	chanceLabel={}
},
[2264] =
{
 		id=2264,
 		type=3,
 		items={1},
 		cnts={36000},
 	chanceLabel={}
},
[2265] =
{
 		id=2265,
 		type=3,
 		items={3},
 		cnts={18000},
 	chanceLabel={}
},
[2266] =
{
 		id=2266,
 		type=3,
 		items={243},
 		cnts={3},
 	chanceLabel={}
},
[2267] =
{
 		id=2267,
 		type=3,
 		items={102},
 		cnts={3},
 	chanceLabel={}
},
[2268] =
{
 		id=2268,
 		type=3,
 		items={5},
 		cnts={40},
 	chanceLabel={}
},
[2269] =
{
 		id=2269,
 		type=3,
 		items={1},
 		cnts={40000},
 	chanceLabel={}
},
[2270] =
{
 		id=2270,
 		type=3,
 		items={7},
 		cnts={500},
 	chanceLabel={}
},
[2271] =
{
 		id=2271,
 		type=3,
 		items={61},
 		cnts={4},
 	chanceLabel={}
},
[2272] =
{
 		id=2272,
 		type=3,
 		items={85},
 		cnts={2},
 	chanceLabel={}
},
[2273] =
{
 		id=2273,
 		type=3,
 		items={8502},
 		cnts={1},
 	chanceLabel={}
},
[2274] =
{
 		id=2274,
 		type=3,
 		items={251},
 		cnts={1},
 	chanceLabel={}
},
[2275] =
{
 		id=2275,
 		type=3,
 		items={1},
 		cnts={44000},
 	chanceLabel={}
},
[2276] =
{
 		id=2276,
 		type=3,
 		items={7},
 		cnts={600},
 	chanceLabel={}
},
[2277] =
{
 		id=2277,
 		type=3,
 		items={61},
 		cnts={4},
 	chanceLabel={}
},
[2278] =
{
 		id=2278,
 		type=3,
 		items={85},
 		cnts={2},
 	chanceLabel={}
},
[2279] =
{
 		id=2279,
 		type=3,
 		items={8502},
 		cnts={2},
 	chanceLabel={}
},
[2280] =
{
 		id=2280,
 		type=3,
 		items={251},
 		cnts={1},
 	chanceLabel={}
},
[2281] =
{
 		id=2281,
 		type=3,
 		items={1},
 		cnts={48000},
 	chanceLabel={}
},
[2282] =
{
 		id=2282,
 		type=3,
 		items={7},
 		cnts={700},
 	chanceLabel={}
},
[2283] =
{
 		id=2283,
 		type=3,
 		items={61},
 		cnts={5},
 	chanceLabel={}
},
[2284] =
{
 		id=2284,
 		type=3,
 		items={85},
 		cnts={2},
 	chanceLabel={}
},
[2285] =
{
 		id=2285,
 		type=3,
 		items={8502},
 		cnts={2},
 	chanceLabel={}
},
[2286] =
{
 		id=2286,
 		type=3,
 		items={251},
 		cnts={1},
 	chanceLabel={}
},
[2287] =
{
 		id=2287,
 		type=3,
 		items={1},
 		cnts={52000},
 	chanceLabel={}
},
[2288] =
{
 		id=2288,
 		type=3,
 		items={7},
 		cnts={800},
 	chanceLabel={}
},
[2289] =
{
 		id=2289,
 		type=3,
 		items={61},
 		cnts={5},
 	chanceLabel={}
},
[2290] =
{
 		id=2290,
 		type=3,
 		items={85},
 		cnts={2},
 	chanceLabel={}
},
[2291] =
{
 		id=2291,
 		type=3,
 		items={8502},
 		cnts={3},
 	chanceLabel={}
},
[2292] =
{
 		id=2292,
 		type=3,
 		items={251},
 		cnts={1},
 	chanceLabel={}
},
[2301] =
{
 		id=2301,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2302] =
{
 		id=2302,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2303] =
{
 		id=2303,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2304] =
{
 		id=2304,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2305] =
{
 		id=2305,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2306] =
{
 		id=2306,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2307] =
{
 		id=2307,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2308] =
{
 		id=2308,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2309] =
{
 		id=2309,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2310] =
{
 		id=2310,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2311] =
{
 		id=2311,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2312] =
{
 		id=2312,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2313] =
{
 		id=2313,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2314] =
{
 		id=2314,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2315] =
{
 		id=2315,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2316] =
{
 		id=2316,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2317] =
{
 		id=2317,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2318] =
{
 		id=2318,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2319] =
{
 		id=2319,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2320] =
{
 		id=2320,
 		type=3,
 		items={1},
 		cnts={3000},
 	chanceLabel={}
},
[2321] =
{
 		id=2321,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2322] =
{
 		id=2322,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2323] =
{
 		id=2323,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2324] =
{
 		id=2324,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2325] =
{
 		id=2325,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2326] =
{
 		id=2326,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2327] =
{
 		id=2327,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2328] =
{
 		id=2328,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2329] =
{
 		id=2329,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2330] =
{
 		id=2330,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2331] =
{
 		id=2331,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2332] =
{
 		id=2332,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2333] =
{
 		id=2333,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2334] =
{
 		id=2334,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2335] =
{
 		id=2335,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2336] =
{
 		id=2336,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2337] =
{
 		id=2337,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2338] =
{
 		id=2338,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2339] =
{
 		id=2339,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2340] =
{
 		id=2340,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2341] =
{
 		id=2341,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2342] =
{
 		id=2342,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2343] =
{
 		id=2343,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2344] =
{
 		id=2344,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2345] =
{
 		id=2345,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2346] =
{
 		id=2346,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2347] =
{
 		id=2347,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2348] =
{
 		id=2348,
 		type=3,
 		items={1},
 		cnts={4000},
 	chanceLabel={}
},
[2349] =
{
 		id=2349,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2350] =
{
 		id=2350,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2351] =
{
 		id=2351,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2352] =
{
 		id=2352,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2353] =
{
 		id=2353,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2354] =
{
 		id=2354,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2355] =
{
 		id=2355,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2356] =
{
 		id=2356,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2357] =
{
 		id=2357,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2358] =
{
 		id=2358,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2359] =
{
 		id=2359,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2360] =
{
 		id=2360,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2361] =
{
 		id=2361,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2362] =
{
 		id=2362,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2363] =
{
 		id=2363,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2364] =
{
 		id=2364,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2365] =
{
 		id=2365,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2366] =
{
 		id=2366,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2367] =
{
 		id=2367,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2368] =
{
 		id=2368,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
},
[2369] =
{
 		id=2369,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2370] =
{
 		id=2370,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2371] =
{
 		id=2371,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2372] =
{
 		id=2372,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2373] =
{
 		id=2373,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2374] =
{
 		id=2374,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2375] =
{
 		id=2375,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2376] =
{
 		id=2376,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2377] =
{
 		id=2377,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2378] =
{
 		id=2378,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2379] =
{
 		id=2379,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2380] =
{
 		id=2380,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2381] =
{
 		id=2381,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2382] =
{
 		id=2382,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2383] =
{
 		id=2383,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2384] =
{
 		id=2384,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2385] =
{
 		id=2385,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2386] =
{
 		id=2386,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2387] =
{
 		id=2387,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2388] =
{
 		id=2388,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2389] =
{
 		id=2389,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2390] =
{
 		id=2390,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2391] =
{
 		id=2391,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2392] =
{
 		id=2392,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2401] =
{
 		id=2401,
 		type=3,
 		items={1},
 		cnts={6000},
 	chanceLabel={}
},
[2402] =
{
 		id=2402,
 		type=3,
 		items={3},
 		cnts={3000},
 	chanceLabel={}
},
[2403] =
{
 		id=2403,
 		type=3,
 		items={201},
 		cnts={2},
 	chanceLabel={}
},
[2404] =
{
 		id=2404,
 		type=3,
 		items={63},
 		cnts={2},
 	chanceLabel={}
},
[2405] =
{
 		id=2405,
 		type=3,
 		items={241},
 		cnts={2},
 	chanceLabel={}
},
[2406] =
{
 		id=2406,
 		type=3,
 		items={1},
 		cnts={7000},
 	chanceLabel={}
},
[2407] =
{
 		id=2407,
 		type=3,
 		items={3},
 		cnts={3500},
 	chanceLabel={}
},
[2408] =
{
 		id=2408,
 		type=3,
 		items={201},
 		cnts={2},
 	chanceLabel={}
},
[2409] =
{
 		id=2409,
 		type=3,
 		items={63},
 		cnts={2},
 	chanceLabel={}
},
[2410] =
{
 		id=2410,
 		type=3,
 		items={241},
 		cnts={2},
 	chanceLabel={}
},
[2411] =
{
 		id=2411,
 		type=3,
 		items={1},
 		cnts={8000},
 	chanceLabel={}
},
[2412] =
{
 		id=2412,
 		type=3,
 		items={3},
 		cnts={4000},
 	chanceLabel={}
},
[2413] =
{
 		id=2413,
 		type=3,
 		items={201},
 		cnts={2},
 	chanceLabel={}
},
[2414] =
{
 		id=2414,
 		type=3,
 		items={63},
 		cnts={2},
 	chanceLabel={}
},
[2415] =
{
 		id=2415,
 		type=3,
 		items={241},
 		cnts={2},
 	chanceLabel={}
},
[2416] =
{
 		id=2416,
 		type=3,
 		items={1},
 		cnts={9000},
 	chanceLabel={}
},
[2417] =
{
 		id=2417,
 		type=3,
 		items={3},
 		cnts={4500},
 	chanceLabel={}
},
[2418] =
{
 		id=2418,
 		type=3,
 		items={201},
 		cnts={3},
 	chanceLabel={}
},
[2419] =
{
 		id=2419,
 		type=3,
 		items={63},
 		cnts={3},
 	chanceLabel={}
},
[2420] =
{
 		id=2420,
 		type=3,
 		items={241},
 		cnts={3},
 	chanceLabel={}
},
[2421] =
{
 		id=2421,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[2422] =
{
 		id=2422,
 		type=3,
 		items={3},
 		cnts={5000},
 	chanceLabel={}
},
[2423] =
{
 		id=2423,
 		type=3,
 		items={202},
 		cnts={1},
 	chanceLabel={}
},
[2424] =
{
 		id=2424,
 		type=3,
 		items={242},
 		cnts={2},
 	chanceLabel={}
},
[2425] =
{
 		id=2425,
 		type=3,
 		items={62},
 		cnts={1},
 	chanceLabel={}
},
[2426] =
{
 		id=2426,
 		type=3,
 		items={64},
 		cnts={2},
 	chanceLabel={}
},
[2427] =
{
 		id=2427,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[2428] =
{
 		id=2428,
 		type=3,
 		items={1},
 		cnts={11000},
 	chanceLabel={}
},
[2429] =
{
 		id=2429,
 		type=3,
 		items={3},
 		cnts={5500},
 	chanceLabel={}
},
[2430] =
{
 		id=2430,
 		type=3,
 		items={202},
 		cnts={1},
 	chanceLabel={}
},
[2431] =
{
 		id=2431,
 		type=3,
 		items={242},
 		cnts={2},
 	chanceLabel={}
},
[2432] =
{
 		id=2432,
 		type=3,
 		items={62},
 		cnts={1},
 	chanceLabel={}
},
[2433] =
{
 		id=2433,
 		type=3,
 		items={64},
 		cnts={3},
 	chanceLabel={}
},
[2434] =
{
 		id=2434,
 		type=3,
 		items={231},
 		cnts={1},
 	chanceLabel={}
},
[2435] =
{
 		id=2435,
 		type=3,
 		items={1},
 		cnts={12000},
 	chanceLabel={}
},
[2436] =
{
 		id=2436,
 		type=3,
 		items={3},
 		cnts={6000},
 	chanceLabel={}
},
[2437] =
{
 		id=2437,
 		type=3,
 		items={202},
 		cnts={1},
 	chanceLabel={}
},
[2438] =
{
 		id=2438,
 		type=3,
 		items={242},
 		cnts={2},
 	chanceLabel={}
},
[2439] =
{
 		id=2439,
 		type=3,
 		items={62},
 		cnts={2},
 	chanceLabel={}
},
[2440] =
{
 		id=2440,
 		type=3,
 		items={64},
 		cnts={3},
 	chanceLabel={}
},
[2441] =
{
 		id=2441,
 		type=3,
 		items={231},
 		cnts={2},
 	chanceLabel={}
},
[2442] =
{
 		id=2442,
 		type=3,
 		items={1},
 		cnts={13000},
 	chanceLabel={}
},
[2443] =
{
 		id=2443,
 		type=3,
 		items={3},
 		cnts={6500},
 	chanceLabel={}
},
[2444] =
{
 		id=2444,
 		type=3,
 		items={202},
 		cnts={2},
 	chanceLabel={}
},
[2445] =
{
 		id=2445,
 		type=3,
 		items={242},
 		cnts={3},
 	chanceLabel={}
},
[2446] =
{
 		id=2446,
 		type=3,
 		items={62},
 		cnts={2},
 	chanceLabel={}
},
[2447] =
{
 		id=2447,
 		type=3,
 		items={64},
 		cnts={3},
 	chanceLabel={}
},
[2448] =
{
 		id=2448,
 		type=3,
 		items={231},
 		cnts={2},
 	chanceLabel={}
},
[2449] =
{
 		id=2449,
 		type=3,
 		items={1},
 		cnts={15000},
 	chanceLabel={}
},
[2450] =
{
 		id=2450,
 		type=3,
 		items={3},
 		cnts={7500},
 	chanceLabel={}
},
[2451] =
{
 		id=2451,
 		type=3,
 		items={243},
 		cnts={1},
 	chanceLabel={}
},
[2452] =
{
 		id=2452,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[2453] =
{
 		id=2453,
 		type=3,
 		items={5},
 		cnts={15},
 	chanceLabel={}
},
[2454] =
{
 		id=2454,
 		type=3,
 		items={1},
 		cnts={16000},
 	chanceLabel={}
},
[2455] =
{
 		id=2455,
 		type=3,
 		items={3},
 		cnts={8000},
 	chanceLabel={}
},
[2456] =
{
 		id=2456,
 		type=3,
 		items={243},
 		cnts={1},
 	chanceLabel={}
},
[2457] =
{
 		id=2457,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[2458] =
{
 		id=2458,
 		type=3,
 		items={5},
 		cnts={18},
 	chanceLabel={}
},
[2459] =
{
 		id=2459,
 		type=3,
 		items={1},
 		cnts={17000},
 	chanceLabel={}
},
[2460] =
{
 		id=2460,
 		type=3,
 		items={3},
 		cnts={8500},
 	chanceLabel={}
},
[2461] =
{
 		id=2461,
 		type=3,
 		items={243},
 		cnts={2},
 	chanceLabel={}
},
[2462] =
{
 		id=2462,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[2463] =
{
 		id=2463,
 		type=3,
 		items={5},
 		cnts={20},
 	chanceLabel={}
},
[2464] =
{
 		id=2464,
 		type=3,
 		items={1},
 		cnts={18000},
 	chanceLabel={}
},
[2465] =
{
 		id=2465,
 		type=3,
 		items={3},
 		cnts={9000},
 	chanceLabel={}
},
[2466] =
{
 		id=2466,
 		type=3,
 		items={243},
 		cnts={2},
 	chanceLabel={}
},
[2467] =
{
 		id=2467,
 		type=3,
 		items={102},
 		cnts={2},
 	chanceLabel={}
},
[2468] =
{
 		id=2468,
 		type=3,
 		items={5},
 		cnts={20},
 	chanceLabel={}
},
[2469] =
{
 		id=2469,
 		type=3,
 		items={1},
 		cnts={20000},
 	chanceLabel={}
},
[2470] =
{
 		id=2470,
 		type=3,
 		items={7},
 		cnts={250},
 	chanceLabel={}
},
[2471] =
{
 		id=2471,
 		type=3,
 		items={61},
 		cnts={2},
 	chanceLabel={}
},
[2472] =
{
 		id=2472,
 		type=3,
 		items={85},
 		cnts={1},
 	chanceLabel={}
},
[2473] =
{
 		id=2473,
 		type=3,
 		items={8502},
 		cnts={1},
 	chanceLabel={}
},
[2474] =
{
 		id=2474,
 		type=3,
 		items={251},
 		cnts={1},
 	chanceLabel={}
},
[2475] =
{
 		id=2475,
 		type=3,
 		items={1},
 		cnts={22000},
 	chanceLabel={}
},
[2476] =
{
 		id=2476,
 		type=3,
 		items={7},
 		cnts={300},
 	chanceLabel={}
},
[2477] =
{
 		id=2477,
 		type=3,
 		items={61},
 		cnts={2},
 	chanceLabel={}
},
[2478] =
{
 		id=2478,
 		type=3,
 		items={85},
 		cnts={1},
 	chanceLabel={}
},
[2479] =
{
 		id=2479,
 		type=3,
 		items={8502},
 		cnts={1},
 	chanceLabel={}
},
[2480] =
{
 		id=2480,
 		type=3,
 		items={251},
 		cnts={1},
 	chanceLabel={}
},
[2481] =
{
 		id=2481,
 		type=3,
 		items={1},
 		cnts={24000},
 	chanceLabel={}
},
[2482] =
{
 		id=2482,
 		type=3,
 		items={7},
 		cnts={350},
 	chanceLabel={}
},
[2483] =
{
 		id=2483,
 		type=3,
 		items={61},
 		cnts={3},
 	chanceLabel={}
},
[2484] =
{
 		id=2484,
 		type=3,
 		items={85},
 		cnts={1},
 	chanceLabel={}
},
[2485] =
{
 		id=2485,
 		type=3,
 		items={8502},
 		cnts={1},
 	chanceLabel={}
},
[2486] =
{
 		id=2486,
 		type=3,
 		items={251},
 		cnts={1},
 	chanceLabel={}
},
[2487] =
{
 		id=2487,
 		type=3,
 		items={1},
 		cnts={26000},
 	chanceLabel={}
},
[2488] =
{
 		id=2488,
 		type=3,
 		items={7},
 		cnts={400},
 	chanceLabel={}
},
[2489] =
{
 		id=2489,
 		type=3,
 		items={61},
 		cnts={3},
 	chanceLabel={}
},
[2490] =
{
 		id=2490,
 		type=3,
 		items={85},
 		cnts={1},
 	chanceLabel={}
},
[2491] =
{
 		id=2491,
 		type=3,
 		items={8502},
 		cnts={2},
 	chanceLabel={}
},
[2492] =
{
 		id=2492,
 		type=3,
 		items={251},
 		cnts={1},
 	chanceLabel={}
},
[2501] =
{
 		id=2501,
 		type=3,
 		items={201},
 		cnts={1},
 	chanceLabel={}
},
[2502] =
{
 		id=2502,
 		type=3,
 		items={241},
 		cnts={1},
 	chanceLabel={}
},
[2503] =
{
 		id=2503,
 		type=3,
 		items={711},
 		cnts={1},
 	chanceLabel={}
},
[2504] =
{
 		id=2504,
 		type=3,
 		items={701},
 		cnts={1},
 	chanceLabel={}
},
[2505] =
{
 		id=2505,
 		type=3,
 		items={721},
 		cnts={1},
 	chanceLabel={}
},
[2506] =
{
 		id=2506,
 		type=3,
 		items={411},
 		cnts={1},
 	chanceLabel={}
},
[2507] =
{
 		id=2507,
 		type=3,
 		items={421},
 		cnts={1},
 	chanceLabel={}
},
[2508] =
{
 		id=2508,
 		type=3,
 		items={431},
 		cnts={1},
 	chanceLabel={}
},
[2509] =
{
 		id=2509,
 		type=3,
 		items={441},
 		cnts={1},
 	chanceLabel={}
},
[2510] =
{
 		id=2510,
 		type=3,
 		items={451},
 		cnts={1},
 	chanceLabel={}
},
[2511] =
{
 		id=2511,
 		type=3,
 		items={461},
 		cnts={1},
 	chanceLabel={}
},
[2512] =
{
 		id=2512,
 		type=3,
 		items={501},
 		cnts={1},
 	chanceLabel={}
},
[2513] =
{
 		id=2513,
 		type=3,
 		items={511},
 		cnts={1},
 	chanceLabel={}
},
[2514] =
{
 		id=2514,
 		type=3,
 		items={521},
 		cnts={1},
 	chanceLabel={}
},
[2515] =
{
 		id=2515,
 		type=3,
 		items={531},
 		cnts={1},
 	chanceLabel={}
},
[2516] =
{
 		id=2516,
 		type=3,
 		items={541},
 		cnts={1},
 	chanceLabel={}
},
[2517] =
{
 		id=2517,
 		type=3,
 		items={551},
 		cnts={1},
 	chanceLabel={}
},
[2518] =
{
 		id=2518,
 		type=3,
 		items={242},
 		cnts={1},
 	chanceLabel={}
},
[2519] =
{
 		id=2519,
 		type=3,
 		items={412},
 		cnts={1},
 	chanceLabel={}
},
[2520] =
{
 		id=2520,
 		type=3,
 		items={422},
 		cnts={1},
 	chanceLabel={}
},
[2521] =
{
 		id=2521,
 		type=3,
 		items={432},
 		cnts={1},
 	chanceLabel={}
},
[2522] =
{
 		id=2522,
 		type=3,
 		items={442},
 		cnts={1},
 	chanceLabel={}
},
[2523] =
{
 		id=2523,
 		type=3,
 		items={452},
 		cnts={1},
 	chanceLabel={}
},
[2524] =
{
 		id=2524,
 		type=3,
 		items={462},
 		cnts={1},
 	chanceLabel={}
},
[2525] =
{
 		id=2525,
 		type=3,
 		items={502},
 		cnts={1},
 	chanceLabel={}
},
[2526] =
{
 		id=2526,
 		type=3,
 		items={512},
 		cnts={1},
 	chanceLabel={}
},
[2527] =
{
 		id=2527,
 		type=3,
 		items={522},
 		cnts={1},
 	chanceLabel={}
},
[2528] =
{
 		id=2528,
 		type=3,
 		items={532},
 		cnts={1},
 	chanceLabel={}
},
[2529] =
{
 		id=2529,
 		type=3,
 		items={542},
 		cnts={1},
 	chanceLabel={}
},
[2530] =
{
 		id=2530,
 		type=3,
 		items={552},
 		cnts={1},
 	chanceLabel={}
},
[2531] =
{
 		id=2531,
 		type=3,
 		items={202},
 		cnts={1},
 	chanceLabel={}
},
[2532] =
{
 		id=2532,
 		type=3,
 		items={712},
 		cnts={1},
 	chanceLabel={}
},
[2533] =
{
 		id=2533,
 		type=3,
 		items={702},
 		cnts={1},
 	chanceLabel={}
},
[2534] =
{
 		id=2534,
 		type=3,
 		items={722},
 		cnts={1},
 	chanceLabel={}
},
[2535] =
{
 		id=2535,
 		type=3,
 		items={243},
 		cnts={1},
 	chanceLabel={}
},
[2536] =
{
 		id=2536,
 		type=3,
 		items={211},
 		cnts={1},
 	chanceLabel={}
},
[2537] =
{
 		id=2537,
 		type=3,
 		items={212},
 		cnts={1},
 	chanceLabel={}
},
[2538] =
{
 		id=2538,
 		type=3,
 		items={503},
 		cnts={1},
 	chanceLabel={}
},
[2539] =
{
 		id=2539,
 		type=3,
 		items={513},
 		cnts={1},
 	chanceLabel={}
},
[2540] =
{
 		id=2540,
 		type=3,
 		items={523},
 		cnts={1},
 	chanceLabel={}
},
[2541] =
{
 		id=2541,
 		type=3,
 		items={533},
 		cnts={1},
 	chanceLabel={}
},
[2542] =
{
 		id=2542,
 		type=3,
 		items={543},
 		cnts={1},
 	chanceLabel={}
},
[2543] =
{
 		id=2543,
 		type=3,
 		items={553},
 		cnts={1},
 	chanceLabel={}
},
[2544] =
{
 		id=2544,
 		type=3,
 		items={504},
 		cnts={1},
 	chanceLabel={}
},
[2545] =
{
 		id=2545,
 		type=3,
 		items={514},
 		cnts={1},
 	chanceLabel={}
},
[2546] =
{
 		id=2546,
 		type=3,
 		items={524},
 		cnts={1},
 	chanceLabel={}
},
[2547] =
{
 		id=2547,
 		type=3,
 		items={534},
 		cnts={1},
 	chanceLabel={}
},
[2548] =
{
 		id=2548,
 		type=3,
 		items={544},
 		cnts={1},
 	chanceLabel={}
},
[2549] =
{
 		id=2549,
 		type=3,
 		items={554},
 		cnts={1},
 	chanceLabel={}
},
[2550] =
{
 		id=2550,
 		type=3,
 		items={505},
 		cnts={1},
 	chanceLabel={}
},
[2551] =
{
 		id=2551,
 		type=3,
 		items={515},
 		cnts={1},
 	chanceLabel={}
},
[2552] =
{
 		id=2552,
 		type=3,
 		items={525},
 		cnts={1},
 	chanceLabel={}
},
[2553] =
{
 		id=2553,
 		type=3,
 		items={535},
 		cnts={1},
 	chanceLabel={}
},
[2554] =
{
 		id=2554,
 		type=3,
 		items={545},
 		cnts={1},
 	chanceLabel={}
},
[2555] =
{
 		id=2555,
 		type=3,
 		items={555},
 		cnts={1},
 	chanceLabel={}
},
[3001] =
{
 		id=3001,
 		type=3,
 		items={1},
 		cnts={9000},
 	chanceLabel={}
},
[3002] =
{
 		id=3002,
 		type=3,
 		items={1},
 		cnts={13600},
 	chanceLabel={}
},
[3003] =
{
 		id=3003,
 		type=3,
 		items={1},
 		cnts={19000},
 	chanceLabel={}
},
[3004] =
{
 		id=3004,
 		type=3,
 		items={1},
 		cnts={25200},
 	chanceLabel={}
},
[3011] =
{
 		id=3011,
 		type=3,
 		items={3},
 		cnts={4500},
 	chanceLabel={}
},
[3012] =
{
 		id=3012,
 		type=3,
 		items={3},
 		cnts={6800},
 	chanceLabel={}
},
[3013] =
{
 		id=3013,
 		type=3,
 		items={3},
 		cnts={9500},
 	chanceLabel={}
},
[3014] =
{
 		id=3014,
 		type=3,
 		items={3},
 		cnts={12600},
 	chanceLabel={}
},
[3021] =
{
 		id=3021,
 		type=1,
 		items={701,701},
 		cnts={1,2},
 		weight={6000,4000},
 	chanceLabel={}
},
[3022] =
{
 		id=3022,
 		type=1,
 		items={711,711},
 		cnts={1,2},
 		weight={6000,4000},
 	chanceLabel={}
},
[3023] =
{
 		id=3023,
 		type=1,
 		items={721,721},
 		cnts={1,2},
 		weight={6000,4000},
 	chanceLabel={}
},
[3024] =
{
 		id=3024,
 		type=1,
 		items={702,702},
 		cnts={1,2},
 		weight={8000,2000},
 	chanceLabel={}
},
[3025] =
{
 		id=3025,
 		type=1,
 		items={712,712},
 		cnts={1,2},
 		weight={8000,2000},
 	chanceLabel={}
},
[3026] =
{
 		id=3026,
 		type=1,
 		items={722,722},
 		cnts={1,2},
 		weight={8000,2000},
 	chanceLabel={}
},
[3027] =
{
 		id=3027,
 		type=1,
 		items={703},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[3028] =
{
 		id=3028,
 		type=1,
 		items={713},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[3029] =
{
 		id=3029,
 		type=1,
 		items={723},
 		cnts={1},
 		weight={10000},
 	chanceLabel={}
},
[3031] =
{
 		id=3031,
 		type=1,
 		items={241,241,241},
 		cnts={1,2,3},
 		weight={5000,3000,2000},
 	chanceLabel={}
},
[3032] =
{
 		id=3032,
 		type=1,
 		items={242,242,242},
 		cnts={1,2,3},
 		weight={5000,4000,1000},
 	chanceLabel={}
},
[3033] =
{
 		id=3033,
 		type=1,
 		items={243,243},
 		cnts={1,2},
 		weight={7500,2500},
 	chanceLabel={}
},
[3034] =
{
 		id=3034,
 		type=1,
 		items={244,244},
 		cnts={1,2},
 		weight={8000,2000},
 	chanceLabel={}
},
[3041] =
{
 		id=3041,
 		type=1,
 		items={201,201},
 		cnts={1,2},
 		weight={5000,5000},
 	chanceLabel={}
},
[3043] =
{
 		id=3043,
 		type=1,
 		items={201,201},
 		cnts={1,2},
 		weight={5000,5000},
 	chanceLabel={}
},
[3044] =
{
 		id=3044,
 		type=4,
 		items={202},
 		cnts={1},
 		weight={4000},
 	chanceLabel={4}
},
[3045] =
{
 		id=3045,
 		type=1,
 		items={202},
 		cnts={1},
 		weight={10000},
 	chanceLabel={2}
},
[3046] =
{
 		id=3046,
 		type=4,
 		items={203},
 		cnts={1},
 		weight={2000},
 	chanceLabel={5}
},
[3047] =
{
 		id=3047,
 		type=4,
 		items={202},
 		cnts={1},
 		weight={10000},
 	chanceLabel={2}
},
[3048] =
{
 		id=3048,
 		type=4,
 		items={203},
 		cnts={1},
 		weight={3650},
 	chanceLabel={4}
},
[3051] =
{
 		id=3051,
 		type=1,
 		items={63,63,63},
 		cnts={2,3,4},
 		weight={2000,6000,2000},
 	chanceLabel={}
},
[3052] =
{
 		id=3052,
 		type=1,
 		items={63,63,63},
 		cnts={4,5,6},
 		weight={2000,6000,2000},
 	chanceLabel={}
},
[3101] =
{
 		id=3101,
 		type=3,
 		items={54,110008},
 		cnts={1,1},
 	chanceLabel={}
},
[3102] =
{
 		id=3102,
 		type=3,
 		items={140008},
 		cnts={1},
 	chanceLabel={}
},
[3103] =
{
 		id=3103,
 		type=3,
 		items={1304},
 		cnts={1},
 	chanceLabel={}
},
[3104] =
{
 		id=3104,
 		type=3,
 		items={53},
 		cnts={1},
 	chanceLabel={}
},
[3105] =
{
 		id=3105,
 		type=3,
 		items={110007},
 		cnts={1},
 	chanceLabel={}
},
[3106] =
{
 		id=3106,
 		type=3,
 		items={110011},
 		cnts={1},
 	chanceLabel={}
},
[3107] =
{
 		id=3107,
 		type=3,
 		items={130002},
 		cnts={1},
 	chanceLabel={}
},
[3108] =
{
 		id=3108,
 		type=3,
 		items={1102,1001},
 		cnts={2,4},
 	chanceLabel={}
},
[3109] =
{
 		id=3109,
 		type=3,
 		items={3},
 		cnts={2000},
 	chanceLabel={}
},
[3110] =
{
 		id=3110,
 		type=3,
 		items={1402},
 		cnts={1},
 	chanceLabel={}
},
[3111] =
{
 		id=3111,
 		type=3,
 		items={1302},
 		cnts={1},
 	chanceLabel={}
},
[3112] =
{
 		id=3112,
 		type=3,
 		items={1305},
 		cnts={1},
 	chanceLabel={}
},
[3501] =
{
 		id=3501,
 		type=3,
 		items={201},
 		cnts={1},
 	chanceLabel={}
},
[3502] =
{
 		id=3502,
 		type=3,
 		items={411,201},
 		cnts={2,2},
 	chanceLabel={}
},
[3503] =
{
 		id=3503,
 		type=3,
 		items={431,1102,104},
 		cnts={2,2,2},
 	chanceLabel={}
},
[3504] =
{
 		id=3504,
 		type=3,
 		items={421,201},
 		cnts={2,2},
 	chanceLabel={}
},
[3505] =
{
 		id=3505,
 		type=3,
 		items={461,201},
 		cnts={2,2},
 	chanceLabel={}
},
[4001] =
{
 		id=4001,
 		type=2,
 		items={1},
 		cnts={2000},
 		weight={10000},
 	chanceLabel={}
},
[4002] =
{
 		id=4002,
 		type=2,
 		items={1},
 		cnts={2000},
 		weight={10000},
 	chanceLabel={}
},
[4003] =
{
 		id=4003,
 		type=2,
 		items={1},
 		cnts={2000},
 		weight={10000},
 	chanceLabel={}
},
[4004] =
{
 		id=4004,
 		type=2,
 		items={3},
 		cnts={1000},
 		weight={10000},
 	chanceLabel={}
},
[4005] =
{
 		id=4005,
 		type=2,
 		items={3},
 		cnts={1000},
 		weight={10000},
 	chanceLabel={}
},
[4006] =
{
 		id=4006,
 		type=2,
 		items={3},
 		cnts={1000},
 		weight={10000},
 	chanceLabel={}
},
[4007] =
{
 		id=4007,
 		type=2,
 		items={1},
 		cnts={2000},
 		weight={10000},
 	chanceLabel={}
},
[4008] =
{
 		id=4008,
 		type=2,
 		items={3},
 		cnts={1000},
 		weight={10000},
 	chanceLabel={}
},
[4009] =
{
 		id=4009,
 		type=2,
 		items={1},
 		cnts={2000},
 		weight={10000},
 	chanceLabel={}
},
[4101] =
{
 		id=4101,
 		type=2,
 		items={1},
 		cnts={2400},
 		weight={10000},
 	chanceLabel={}
},
[4102] =
{
 		id=4102,
 		type=4,
 		items={3},
 		cnts={1200},
 		weight={10000},
 	chanceLabel={}
},
[4103] =
{
 		id=4103,
 		type=4,
 		items={1,411},
 		cnts={2400,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4104] =
{
 		id=4104,
 		type=4,
 		items={3},
 		cnts={1200},
 		weight={10000},
 	chanceLabel={}
},
[4105] =
{
 		id=4105,
 		type=4,
 		items={1,421},
 		cnts={2400,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4106] =
{
 		id=4106,
 		type=4,
 		items={3},
 		cnts={1200},
 		weight={10000},
 	chanceLabel={}
},
[4107] =
{
 		id=4107,
 		type=4,
 		items={1,431},
 		cnts={2400,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4108] =
{
 		id=4108,
 		type=4,
 		items={3},
 		cnts={1200},
 		weight={10000},
 	chanceLabel={}
},
[4109] =
{
 		id=4109,
 		type=4,
 		items={1,441},
 		cnts={2400,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4110] =
{
 		id=4110,
 		type=4,
 		items={3},
 		cnts={1200},
 		weight={10000},
 	chanceLabel={}
},
[4111] =
{
 		id=4111,
 		type=4,
 		items={1,451},
 		cnts={2400,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4112] =
{
 		id=4112,
 		type=4,
 		items={3},
 		cnts={1200},
 		weight={10000},
 	chanceLabel={}
},
[4113] =
{
 		id=4113,
 		type=4,
 		items={1,461},
 		cnts={2400,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4201] =
{
 		id=4201,
 		type=4,
 		items={3,411},
 		cnts={1200,1},
 		weight={10000,10000},
 	chanceLabel={1,2}
},
[4202] =
{
 		id=4202,
 		type=4,
 		items={1,421},
 		cnts={2400,1},
 		weight={10000,10000},
 	chanceLabel={1,2}
},
[4203] =
{
 		id=4203,
 		type=4,
 		items={3,431},
 		cnts={1200,1},
 		weight={10000,10000},
 	chanceLabel={1,2}
},
[4204] =
{
 		id=4204,
 		type=4,
 		items={1,441},
 		cnts={2400,1},
 		weight={10000,10000},
 	chanceLabel={1,2}
},
[4205] =
{
 		id=4205,
 		type=4,
 		items={3,451},
 		cnts={1200,1},
 		weight={10000,10000},
 	chanceLabel={1,2}
},
[4206] =
{
 		id=4206,
 		type=4,
 		items={1,461},
 		cnts={2400,1},
 		weight={10000,10000},
 	chanceLabel={1,2}
},
[4207] =
{
 		id=4207,
 		type=4,
 		items={3},
 		cnts={1200},
 		weight={10000},
 	chanceLabel={}
},
[4208] =
{
 		id=4208,
 		type=4,
 		items={1,412},
 		cnts={2400,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4209] =
{
 		id=4209,
 		type=4,
 		items={3,422},
 		cnts={1200,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4210] =
{
 		id=4210,
 		type=4,
 		items={1,432},
 		cnts={2400,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4211] =
{
 		id=4211,
 		type=4,
 		items={3,442},
 		cnts={1200,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4212] =
{
 		id=4212,
 		type=4,
 		items={1,452},
 		cnts={2400,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4213] =
{
 		id=4213,
 		type=4,
 		items={3,462},
 		cnts={1200,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4301] =
{
 		id=4301,
 		type=4,
 		items={1},
 		cnts={2600},
 		weight={10000},
 	chanceLabel={}
},
[4302] =
{
 		id=4302,
 		type=4,
 		items={3},
 		cnts={1300},
 		weight={10000},
 	chanceLabel={}
},
[4303] =
{
 		id=4303,
 		type=4,
 		items={1,412},
 		cnts={2600,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4304] =
{
 		id=4304,
 		type=4,
 		items={3},
 		cnts={1300},
 		weight={10000},
 	chanceLabel={}
},
[4305] =
{
 		id=4305,
 		type=4,
 		items={1,422},
 		cnts={2600,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4306] =
{
 		id=4306,
 		type=4,
 		items={3},
 		cnts={1300},
 		weight={10000},
 	chanceLabel={}
},
[4307] =
{
 		id=4307,
 		type=4,
 		items={1,432},
 		cnts={2600,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4308] =
{
 		id=4308,
 		type=4,
 		items={3},
 		cnts={1300},
 		weight={10000},
 	chanceLabel={}
},
[4309] =
{
 		id=4309,
 		type=4,
 		items={1,442},
 		cnts={2600,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4310] =
{
 		id=4310,
 		type=4,
 		items={3},
 		cnts={1300},
 		weight={10000},
 	chanceLabel={}
},
[4311] =
{
 		id=4311,
 		type=4,
 		items={1,452},
 		cnts={2600,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4312] =
{
 		id=4312,
 		type=4,
 		items={3},
 		cnts={1300},
 		weight={10000},
 	chanceLabel={}
},
[4313] =
{
 		id=4313,
 		type=4,
 		items={1,462},
 		cnts={2600,1},
 		weight={10000,6000},
 	chanceLabel={1,3}
},
[4401] =
{
 		id=4401,
 		type=4,
 		items={3},
 		cnts={1500},
 		weight={10000},
 	chanceLabel={}
},
[4402] =
{
 		id=4402,
 		type=4,
 		items={1,413},
 		cnts={3000,1},
 		weight={10000,2500},
 	chanceLabel={1,5}
},
[4403] =
{
 		id=4403,
 		type=4,
 		items={3},
 		cnts={1500},
 		weight={10000},
 	chanceLabel={}
},
[4404] =
{
 		id=4404,
 		type=4,
 		items={1,423},
 		cnts={3000,1},
 		weight={10000,2500},
 	chanceLabel={1,5}
},
[4405] =
{
 		id=4405,
 		type=4,
 		items={3},
 		cnts={1500},
 		weight={10000},
 	chanceLabel={}
},
[4406] =
{
 		id=4406,
 		type=4,
 		items={1,433},
 		cnts={3000,1},
 		weight={10000,2500},
 	chanceLabel={1,5}
},
[4407] =
{
 		id=4407,
 		type=4,
 		items={3},
 		cnts={1500},
 		weight={10000},
 	chanceLabel={}
},
[4408] =
{
 		id=4408,
 		type=4,
 		items={1,443},
 		cnts={3000,1},
 		weight={10000,2500},
 	chanceLabel={1,5}
},
[4409] =
{
 		id=4409,
 		type=4,
 		items={3},
 		cnts={1500},
 		weight={10000},
 	chanceLabel={}
},
[4410] =
{
 		id=4410,
 		type=4,
 		items={1,453},
 		cnts={3000,1},
 		weight={10000,2500},
 	chanceLabel={1,5}
},
[4411] =
{
 		id=4411,
 		type=4,
 		items={3},
 		cnts={1500},
 		weight={10000},
 	chanceLabel={}
},
[4412] =
{
 		id=4412,
 		type=4,
 		items={1,463},
 		cnts={3000,1},
 		weight={10000,2500},
 	chanceLabel={1,5}
},
[4413] =
{
 		id=4413,
 		type=4,
 		items={3},
 		cnts={1500},
 		weight={10000},
 	chanceLabel={}
},
[4414] =
{
 		id=4414,
 		type=4,
 		items={1},
 		cnts={3000},
 		weight={10000},
 	chanceLabel={}
},
[4415] =
{
 		id=4415,
 		type=4,
 		items={3},
 		cnts={1500},
 		weight={10000},
 	chanceLabel={}
},
[4501] =
{
 		id=4501,
 		type=4,
 		items={1},
 		cnts={3200},
 		weight={10000},
 	chanceLabel={}
},
[4502] =
{
 		id=4502,
 		type=4,
 		items={3,413},
 		cnts={1600,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4503] =
{
 		id=4503,
 		type=4,
 		items={1},
 		cnts={3200},
 		weight={10000},
 	chanceLabel={}
},
[4504] =
{
 		id=4504,
 		type=4,
 		items={3,423},
 		cnts={1600,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4505] =
{
 		id=4505,
 		type=4,
 		items={1},
 		cnts={3200},
 		weight={10000},
 	chanceLabel={}
},
[4506] =
{
 		id=4506,
 		type=4,
 		items={3,433},
 		cnts={1600,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4507] =
{
 		id=4507,
 		type=4,
 		items={1},
 		cnts={3200},
 		weight={10000},
 	chanceLabel={}
},
[4508] =
{
 		id=4508,
 		type=4,
 		items={3,443},
 		cnts={1600,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4509] =
{
 		id=4509,
 		type=4,
 		items={1},
 		cnts={3200},
 		weight={10000},
 	chanceLabel={}
},
[4510] =
{
 		id=4510,
 		type=4,
 		items={3,453},
 		cnts={1600,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4511] =
{
 		id=4511,
 		type=4,
 		items={1},
 		cnts={3200},
 		weight={10000},
 	chanceLabel={}
},
[4512] =
{
 		id=4512,
 		type=4,
 		items={3,463},
 		cnts={1600,1},
 		weight={10000,4000},
 	chanceLabel={1,4}
},
[4513] =
{
 		id=4513,
 		type=4,
 		items={1},
 		cnts={3200},
 		weight={10000},
 	chanceLabel={}
},
[4514] =
{
 		id=4514,
 		type=4,
 		items={3},
 		cnts={1600},
 		weight={10000},
 	chanceLabel={}
},
[4515] =
{
 		id=4515,
 		type=4,
 		items={1},
 		cnts={3200},
 		weight={10000},
 	chanceLabel={}
},
[5001] =
{
 		id=5001,
 		type=1,
 		items={1001,1002,1003,1004,1005,1006,1007,1008,1009},
 		cnts={1,1,1,1,1,1,1,1,1},
 		weight={1800,900,1200,600,900,900,900,600,600},
 	chanceLabel={}
},
[5002] =
{
 		id=5002,
 		type=1,
 		items={411,421,431,441,451,461,1001,1002,1003,1004,1005,1006,1007,1008,1009},
 		cnts={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
 		weight={260,260,260,260,260,260,1800,900,1200,600,900,900,900,600,600},
 	chanceLabel={}
},
[5003] =
{
 		id=5003,
 		type=1,
 		items={201,241,1001,1002,1003,1004,1005,1006,1007,1008,1009},
 		cnts={1,1,1,1,1,1,1,1,1,1,1},
 		weight={800,800,1800,900,1200,600,900,900,900,600,600},
 	chanceLabel={}
},
[5101] =
{
 		id=5101,
 		type=4,
 		items={8506},
 		cnts={1},
 		weight={4000},
 	chanceLabel={4}
},
[5102] =
{
 		id=5102,
 		type=4,
 		items={8507},
 		cnts={1},
 		weight={3000},
 	chanceLabel={4}
},
[5103] =
{
 		id=5103,
 		type=4,
 		items={8508},
 		cnts={1},
 		weight={2000},
 	chanceLabel={5}
},
[7011] =
{
 		id=7011,
 		type=3,
 		items={64,241},
 		cnts={2,1},
 	chanceLabel={}
},
[7012] =
{
 		id=7012,
 		type=3,
 		items={64,241},
 		cnts={2,1},
 	chanceLabel={}
},
[7013] =
{
 		id=7013,
 		type=3,
 		items={64,242},
 		cnts={2,1},
 	chanceLabel={}
},
[7014] =
{
 		id=7014,
 		type=3,
 		items={64,242},
 		cnts={2,1},
 	chanceLabel={}
},
[7015] =
{
 		id=7015,
 		type=3,
 		items={64,243},
 		cnts={2,1},
 	chanceLabel={}
},
[7016] =
{
 		id=7016,
 		type=3,
 		items={64,243,211},
 		cnts={2,1,1},
 	chanceLabel={}
},
[7021] =
{
 		id=7021,
 		type=3,
 		items={64,241},
 		cnts={2,1},
 	chanceLabel={}
},
[7022] =
{
 		id=7022,
 		type=3,
 		items={64,241},
 		cnts={2,1},
 	chanceLabel={}
},
[7023] =
{
 		id=7023,
 		type=3,
 		items={64,242},
 		cnts={2,1},
 	chanceLabel={}
},
[7024] =
{
 		id=7024,
 		type=3,
 		items={64,242},
 		cnts={2,1},
 	chanceLabel={}
},
[7025] =
{
 		id=7025,
 		type=3,
 		items={64,243},
 		cnts={2,1},
 	chanceLabel={}
},
[7026] =
{
 		id=7026,
 		type=3,
 		items={64,243,211},
 		cnts={2,1,1},
 	chanceLabel={}
},
[7031] =
{
 		id=7031,
 		type=3,
 		items={64,241},
 		cnts={2,1},
 	chanceLabel={}
},
[7032] =
{
 		id=7032,
 		type=3,
 		items={64,241},
 		cnts={2,1},
 	chanceLabel={}
},
[7033] =
{
 		id=7033,
 		type=3,
 		items={64,242},
 		cnts={2,1},
 	chanceLabel={}
},
[7034] =
{
 		id=7034,
 		type=3,
 		items={64,242},
 		cnts={2,1},
 	chanceLabel={}
},
[7035] =
{
 		id=7035,
 		type=3,
 		items={64,243},
 		cnts={2,1},
 	chanceLabel={}
},
[7036] =
{
 		id=7036,
 		type=3,
 		items={64,243,211},
 		cnts={2,1,1},
 	chanceLabel={}
},
[7111] =
{
 		id=7111,
 		type=3,
 		items={64,241},
 		cnts={3,1},
 	chanceLabel={}
},
[7112] =
{
 		id=7112,
 		type=3,
 		items={64,241},
 		cnts={3,1},
 	chanceLabel={}
},
[7113] =
{
 		id=7113,
 		type=3,
 		items={64,242},
 		cnts={3,1},
 	chanceLabel={}
},
[7114] =
{
 		id=7114,
 		type=3,
 		items={64,242},
 		cnts={3,1},
 	chanceLabel={}
},
[7115] =
{
 		id=7115,
 		type=3,
 		items={64,243},
 		cnts={3,1},
 	chanceLabel={}
},
[7116] =
{
 		id=7116,
 		type=3,
 		items={64,243,211},
 		cnts={3,1,1},
 	chanceLabel={}
},
[7121] =
{
 		id=7121,
 		type=3,
 		items={64,241},
 		cnts={3,1},
 	chanceLabel={}
},
[7122] =
{
 		id=7122,
 		type=3,
 		items={64,241},
 		cnts={3,1},
 	chanceLabel={}
},
[7123] =
{
 		id=7123,
 		type=3,
 		items={64,242},
 		cnts={3,1},
 	chanceLabel={}
},
[7124] =
{
 		id=7124,
 		type=3,
 		items={64,242},
 		cnts={3,1},
 	chanceLabel={}
},
[7125] =
{
 		id=7125,
 		type=3,
 		items={64,243},
 		cnts={3,1},
 	chanceLabel={}
},
[7126] =
{
 		id=7126,
 		type=3,
 		items={64,243,211},
 		cnts={3,1,1},
 	chanceLabel={}
},
[7131] =
{
 		id=7131,
 		type=3,
 		items={64,241},
 		cnts={3,1},
 	chanceLabel={}
},
[7132] =
{
 		id=7132,
 		type=3,
 		items={64,241},
 		cnts={3,1},
 	chanceLabel={}
},
[7133] =
{
 		id=7133,
 		type=3,
 		items={64,242},
 		cnts={3,1},
 	chanceLabel={}
},
[7134] =
{
 		id=7134,
 		type=3,
 		items={64,242},
 		cnts={3,1},
 	chanceLabel={}
},
[7135] =
{
 		id=7135,
 		type=3,
 		items={64,243},
 		cnts={3,1},
 	chanceLabel={}
},
[7136] =
{
 		id=7136,
 		type=3,
 		items={64,243,211},
 		cnts={3,1,1},
 	chanceLabel={}
},
[7211] =
{
 		id=7211,
 		type=3,
 		items={64,241},
 		cnts={4,1},
 	chanceLabel={}
},
[7212] =
{
 		id=7212,
 		type=3,
 		items={64,241},
 		cnts={4,1},
 	chanceLabel={}
},
[7213] =
{
 		id=7213,
 		type=3,
 		items={64,242},
 		cnts={4,1},
 	chanceLabel={}
},
[7214] =
{
 		id=7214,
 		type=3,
 		items={64,242},
 		cnts={4,1},
 	chanceLabel={}
},
[7215] =
{
 		id=7215,
 		type=3,
 		items={64,243},
 		cnts={4,1},
 	chanceLabel={}
},
[7216] =
{
 		id=7216,
 		type=3,
 		items={64,243,212},
 		cnts={4,1,1},
 	chanceLabel={}
},
[7221] =
{
 		id=7221,
 		type=3,
 		items={64,241},
 		cnts={4,1},
 	chanceLabel={}
},
[7222] =
{
 		id=7222,
 		type=3,
 		items={64,241},
 		cnts={4,1},
 	chanceLabel={}
},
[7223] =
{
 		id=7223,
 		type=3,
 		items={64,242},
 		cnts={4,1},
 	chanceLabel={}
},
[7224] =
{
 		id=7224,
 		type=3,
 		items={64,242},
 		cnts={4,1},
 	chanceLabel={}
},
[7225] =
{
 		id=7225,
 		type=3,
 		items={64,243},
 		cnts={4,1},
 	chanceLabel={}
},
[7226] =
{
 		id=7226,
 		type=3,
 		items={64,243,212},
 		cnts={4,1,1},
 	chanceLabel={}
},
[7231] =
{
 		id=7231,
 		type=3,
 		items={64,241},
 		cnts={4,1},
 	chanceLabel={}
},
[7232] =
{
 		id=7232,
 		type=3,
 		items={64,241},
 		cnts={4,1},
 	chanceLabel={}
},
[7233] =
{
 		id=7233,
 		type=3,
 		items={64,242},
 		cnts={4,1},
 	chanceLabel={}
},
[7234] =
{
 		id=7234,
 		type=3,
 		items={64,242},
 		cnts={4,1},
 	chanceLabel={}
},
[7235] =
{
 		id=7235,
 		type=3,
 		items={64,243},
 		cnts={4,1},
 	chanceLabel={}
},
[7236] =
{
 		id=7236,
 		type=3,
 		items={64,243,212},
 		cnts={4,1,1},
 	chanceLabel={}
},
[7311] =
{
 		id=7311,
 		type=3,
 		items={64,242},
 		cnts={5,1},
 	chanceLabel={}
},
[7312] =
{
 		id=7312,
 		type=3,
 		items={64,242},
 		cnts={5,1},
 	chanceLabel={}
},
[7313] =
{
 		id=7313,
 		type=3,
 		items={64,243},
 		cnts={5,1},
 	chanceLabel={}
},
[7314] =
{
 		id=7314,
 		type=3,
 		items={64,243},
 		cnts={5,1},
 	chanceLabel={}
},
[7315] =
{
 		id=7315,
 		type=3,
 		items={64,244},
 		cnts={5,1},
 	chanceLabel={}
},
[7316] =
{
 		id=7316,
 		type=3,
 		items={64,244,212},
 		cnts={5,1,1},
 	chanceLabel={}
},
[7321] =
{
 		id=7321,
 		type=3,
 		items={64,242},
 		cnts={5,1},
 	chanceLabel={}
},
[7322] =
{
 		id=7322,
 		type=3,
 		items={64,242},
 		cnts={5,1},
 	chanceLabel={}
},
[7323] =
{
 		id=7323,
 		type=3,
 		items={64,243},
 		cnts={5,1},
 	chanceLabel={}
},
[7324] =
{
 		id=7324,
 		type=3,
 		items={64,243},
 		cnts={5,1},
 	chanceLabel={}
},
[7325] =
{
 		id=7325,
 		type=3,
 		items={64,244},
 		cnts={5,1},
 	chanceLabel={}
},
[7326] =
{
 		id=7326,
 		type=3,
 		items={64,244,212},
 		cnts={5,1,1},
 	chanceLabel={}
},
[7331] =
{
 		id=7331,
 		type=3,
 		items={64,242},
 		cnts={5,1},
 	chanceLabel={}
},
[7332] =
{
 		id=7332,
 		type=3,
 		items={64,242},
 		cnts={5,1},
 	chanceLabel={}
},
[7333] =
{
 		id=7333,
 		type=3,
 		items={64,243},
 		cnts={5,1},
 	chanceLabel={}
},
[7334] =
{
 		id=7334,
 		type=3,
 		items={64,243},
 		cnts={5,1},
 	chanceLabel={}
},
[7335] =
{
 		id=7335,
 		type=3,
 		items={64,244},
 		cnts={5,1},
 	chanceLabel={}
},
[7336] =
{
 		id=7336,
 		type=3,
 		items={64,244,212},
 		cnts={5,1,1},
 	chanceLabel={}
},
[7411] =
{
 		id=7411,
 		type=3,
 		items={64,242},
 		cnts={6,1},
 	chanceLabel={}
},
[7412] =
{
 		id=7412,
 		type=3,
 		items={64,242},
 		cnts={6,1},
 	chanceLabel={}
},
[7413] =
{
 		id=7413,
 		type=3,
 		items={64,243},
 		cnts={6,1},
 	chanceLabel={}
},
[7414] =
{
 		id=7414,
 		type=3,
 		items={64,243},
 		cnts={6,1},
 	chanceLabel={}
},
[7415] =
{
 		id=7415,
 		type=3,
 		items={64,244},
 		cnts={6,1},
 	chanceLabel={}
},
[7416] =
{
 		id=7416,
 		type=3,
 		items={64,244,213},
 		cnts={6,1,1},
 	chanceLabel={}
},
[7421] =
{
 		id=7421,
 		type=3,
 		items={64,242},
 		cnts={6,1},
 	chanceLabel={}
},
[7422] =
{
 		id=7422,
 		type=3,
 		items={64,242},
 		cnts={6,1},
 	chanceLabel={}
},
[7423] =
{
 		id=7423,
 		type=3,
 		items={64,243},
 		cnts={6,1},
 	chanceLabel={}
},
[7424] =
{
 		id=7424,
 		type=3,
 		items={64,243},
 		cnts={6,1},
 	chanceLabel={}
},
[7425] =
{
 		id=7425,
 		type=3,
 		items={64,244},
 		cnts={6,1},
 	chanceLabel={}
},
[7426] =
{
 		id=7426,
 		type=3,
 		items={64,244,213},
 		cnts={6,1,1},
 	chanceLabel={}
},
[7431] =
{
 		id=7431,
 		type=3,
 		items={64,242},
 		cnts={6,1},
 	chanceLabel={}
},
[7432] =
{
 		id=7432,
 		type=3,
 		items={64,242},
 		cnts={6,1},
 	chanceLabel={}
},
[7433] =
{
 		id=7433,
 		type=3,
 		items={64,243},
 		cnts={6,1},
 	chanceLabel={}
},
[7434] =
{
 		id=7434,
 		type=3,
 		items={64,243},
 		cnts={6,1},
 	chanceLabel={}
},
[7435] =
{
 		id=7435,
 		type=3,
 		items={64,244},
 		cnts={6,1},
 	chanceLabel={}
},
[7436] =
{
 		id=7436,
 		type=3,
 		items={64,244,213},
 		cnts={6,1,1},
 	chanceLabel={}
},
[7511] =
{
 		id=7511,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7512] =
{
 		id=7512,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7513] =
{
 		id=7513,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7514] =
{
 		id=7514,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7515] =
{
 		id=7515,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7516] =
{
 		id=7516,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7521] =
{
 		id=7521,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7522] =
{
 		id=7522,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7523] =
{
 		id=7523,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7524] =
{
 		id=7524,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7525] =
{
 		id=7525,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7526] =
{
 		id=7526,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7531] =
{
 		id=7531,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7532] =
{
 		id=7532,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7533] =
{
 		id=7533,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7534] =
{
 		id=7534,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7535] =
{
 		id=7535,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7536] =
{
 		id=7536,
 		type=3,
 		items={64,1,231},
 		cnts={2,10000,1},
 	chanceLabel={}
},
[7611] =
{
 		id=7611,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7612] =
{
 		id=7612,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7613] =
{
 		id=7613,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7614] =
{
 		id=7614,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7615] =
{
 		id=7615,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7616] =
{
 		id=7616,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7621] =
{
 		id=7621,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7622] =
{
 		id=7622,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7623] =
{
 		id=7623,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7624] =
{
 		id=7624,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7625] =
{
 		id=7625,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7626] =
{
 		id=7626,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7631] =
{
 		id=7631,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7632] =
{
 		id=7632,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7633] =
{
 		id=7633,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7634] =
{
 		id=7634,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7635] =
{
 		id=7635,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7636] =
{
 		id=7636,
 		type=3,
 		items={64,1,231},
 		cnts={2,12000,1},
 	chanceLabel={}
},
[7711] =
{
 		id=7711,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7712] =
{
 		id=7712,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7713] =
{
 		id=7713,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7714] =
{
 		id=7714,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7715] =
{
 		id=7715,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7716] =
{
 		id=7716,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7721] =
{
 		id=7721,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7722] =
{
 		id=7722,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7723] =
{
 		id=7723,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7724] =
{
 		id=7724,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7725] =
{
 		id=7725,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7726] =
{
 		id=7726,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7731] =
{
 		id=7731,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7732] =
{
 		id=7732,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7733] =
{
 		id=7733,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7734] =
{
 		id=7734,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7735] =
{
 		id=7735,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7736] =
{
 		id=7736,
 		type=3,
 		items={64,1,231},
 		cnts={3,14000,1},
 	chanceLabel={}
},
[7811] =
{
 		id=7811,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7812] =
{
 		id=7812,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7813] =
{
 		id=7813,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7814] =
{
 		id=7814,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7815] =
{
 		id=7815,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7816] =
{
 		id=7816,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7821] =
{
 		id=7821,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7822] =
{
 		id=7822,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7823] =
{
 		id=7823,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7824] =
{
 		id=7824,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7825] =
{
 		id=7825,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7826] =
{
 		id=7826,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7831] =
{
 		id=7831,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7832] =
{
 		id=7832,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7833] =
{
 		id=7833,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7834] =
{
 		id=7834,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7835] =
{
 		id=7835,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7836] =
{
 		id=7836,
 		type=3,
 		items={64,1,231},
 		cnts={3,16000,1},
 	chanceLabel={}
},
[7911] =
{
 		id=7911,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7912] =
{
 		id=7912,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7913] =
{
 		id=7913,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7914] =
{
 		id=7914,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7915] =
{
 		id=7915,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7916] =
{
 		id=7916,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7921] =
{
 		id=7921,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7922] =
{
 		id=7922,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7923] =
{
 		id=7923,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7924] =
{
 		id=7924,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7925] =
{
 		id=7925,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7926] =
{
 		id=7926,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7931] =
{
 		id=7931,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7932] =
{
 		id=7932,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7933] =
{
 		id=7933,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7934] =
{
 		id=7934,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7935] =
{
 		id=7935,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[7936] =
{
 		id=7936,
 		type=3,
 		items={64,1,231},
 		cnts={4,18000,1},
 	chanceLabel={}
},
[8001] =
{
 		id=8001,
 		type=3,
 		items={1,3,5,6,7,51,52,56,57,61,62,63,64,85,86,87,102,103,104,151,152,161,162,171,172,201,202,203,211,212,213,231,241,242,243,244,251,401,402,411,412,413,421,422,423,431,432,433,441,442,443,451,452,453,461,462,463,501,502,503,504,505,506,511,512,513,514,515,516,521,522,523,524,525,526,531,532,533,534,535,536,541,542,543,544,545,546,551,552,553,554,555,556,701,702,703,704,711,712,713,714,721,722,723,724,731,1001,1002,1003,1004,1005,1006,1007,1008,1009,1102,1103,1104,1105,1106,1107,1108,1109,8101,8102,8502,8503,8506,8507,8508,8511,8512},
 		cnts={10000000,10000000,10000000,10000000,10000000,1000,100,1000,100,20000,20000,20000,20000,100,100,100,100,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100},
 	chanceLabel={}
},
[8002] =
{
 		id=8002,
 		type=3,
 		items={110001,110002,110003,110004,110005,110006,110007,110008,110009,110010,110011,110012,120001,120002,120003,120004,120005,120006,120007,120008,120009,120013,130001,130002,130003,130004,130005,130006,130008,130009,140001,140002,140004,140007,140008,150004,150006,150007,150008,150009},
 		cnts={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
 	chanceLabel={}
},
[8502] =
{
 		id=8502,
 		type=1,
 		items={501,502,503,504,505,506,511,512,513,514,515,516,521,522,523,524,525,526,531,532,533,534,535,536,541,542,543,544,545,546,551,552,553,554,555,556},
 		cnts={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
 		weight={5000,3100,1000,500,300,100,5000,3100,1000,500,300,100,5000,3100,1000,500,300,100,5000,3100,1000,500,300,100,5000,3100,1000,500,300,100,5000,3100,1000,500,300,100},
 	chanceLabel={}
},
[8503] =
{
 		id=8503,
 		type=1,
 		items={2001,2002,2003,2004,2005,2006,2008,2009,2010,2012,2013,2014,2015,2016,2017,2018,2019,2020},
 		cnts={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
 		weight={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
 	chanceLabel={}
},
[8504] =
{
 		id=8504,
 		type=3,
 		items={5,5,5,5,5,5},
 		cnts={188,288,588,888,1288,1888},
 		weight={2000,2500,2500,1000,1000,1000},
 	chanceLabel={}
},
[8505] =
{
 		id=8505,
 		type=3,
 		items={12000202,12000102,11000602,1601},
 		cnts={1,1,1,1},
 	chanceLabel={}
},
[8521] =
{
 		id=8521,
 		type=3,
 		items={1,3,201,8506},
 		cnts={18000,6000,7,3},
 	chanceLabel={}
},
[8522] =
{
 		id=8522,
 		type=3,
 		items={1,3,202},
 		cnts={25000,10000,3},
 	chanceLabel={}
},
[8523] =
{
 		id=8523,
 		type=3,
 		items={1,3,202,8507},
 		cnts={32500,15000,4,3},
 	chanceLabel={}
},
[8524] =
{
 		id=8524,
 		type=3,
 		items={1,3,203},
 		cnts={46000,28000,3},
 	chanceLabel={}
},
[8525] =
{
 		id=8525,
 		type=1,
 		items={2007,2021,2022,2024},
 		cnts={1,1,1,1},
 		weight={1,1,1,1},
 	chanceLabel={}
},
[8526] =
{
 		id=8526,
 		type=1,
 		items={504,505,506,514,515,516,524,525,526,534,535,536,544,545,546,554,555,556},
 		cnts={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
 		weight={400,300,300,400,300,300,400,300,300,400,300,300,400,300,300,400,300,300},
 	chanceLabel={}
},
[8527] =
{
 		id=8527,
 		type=1,
 		items={8502,8506,8507,8508,8511,8511,8511,8512,1,1,1,3,3,3,5,5,61,62,63,63,64,64,102,103,104},
 		cnts={1,1,1,1,1,2,5,1,5000,10000,20000,2500,5000,10000,5,10,1,1,1,2,1,2,1,1,1},
 		weight={250,1000,1000,1000,1000,1000,111,111,200,111,250,200,111,250,200,111,111,111,200,111,200,111,250,1000,1000},
 	chanceLabel={}
},
[10001] =
{
 		id=10001,
 		type=3,
 		items={1,5},
 		cnts={5000,20},
 	chanceLabel={}
},
[10002] =
{
 		id=10002,
 		type=3,
 		items={241,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10003] =
{
 		id=10003,
 		type=3,
 		items={3,5},
 		cnts={2500,20},
 	chanceLabel={}
},
[10004] =
{
 		id=10004,
 		type=3,
 		items={1,5},
 		cnts={6000,20},
 	chanceLabel={}
},
[10005] =
{
 		id=10005,
 		type=3,
 		items={241,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10006] =
{
 		id=10006,
 		type=3,
 		items={3,5},
 		cnts={3000,20},
 	chanceLabel={}
},
[10007] =
{
 		id=10007,
 		type=3,
 		items={1,5},
 		cnts={7000,20},
 	chanceLabel={}
},
[10008] =
{
 		id=10008,
 		type=3,
 		items={241,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10009] =
{
 		id=10009,
 		type=3,
 		items={3,5},
 		cnts={3500,20},
 	chanceLabel={}
},
[10010] =
{
 		id=10010,
 		type=3,
 		items={1,5},
 		cnts={8000,20},
 	chanceLabel={}
},
[10011] =
{
 		id=10011,
 		type=3,
 		items={241,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10012] =
{
 		id=10012,
 		type=3,
 		items={3,5},
 		cnts={4000,20},
 	chanceLabel={}
},
[10013] =
{
 		id=10013,
 		type=3,
 		items={1,5},
 		cnts={9000,20},
 	chanceLabel={}
},
[10014] =
{
 		id=10014,
 		type=3,
 		items={242,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10015] =
{
 		id=10015,
 		type=3,
 		items={3,5},
 		cnts={4500,20},
 	chanceLabel={}
},
[10016] =
{
 		id=10016,
 		type=3,
 		items={1,5},
 		cnts={10000,20},
 	chanceLabel={}
},
[10017] =
{
 		id=10017,
 		type=3,
 		items={242,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10018] =
{
 		id=10018,
 		type=3,
 		items={3,5},
 		cnts={5000,20},
 	chanceLabel={}
},
[10019] =
{
 		id=10019,
 		type=3,
 		items={1,5},
 		cnts={11000,20},
 	chanceLabel={}
},
[10020] =
{
 		id=10020,
 		type=3,
 		items={242,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10021] =
{
 		id=10021,
 		type=3,
 		items={3,5},
 		cnts={5500,20},
 	chanceLabel={}
},
[10022] =
{
 		id=10022,
 		type=3,
 		items={1,5},
 		cnts={12000,20},
 	chanceLabel={}
},
[10023] =
{
 		id=10023,
 		type=3,
 		items={242,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10024] =
{
 		id=10024,
 		type=3,
 		items={3,5},
 		cnts={6000,20},
 	chanceLabel={}
},
[10025] =
{
 		id=10025,
 		type=3,
 		items={1,5},
 		cnts={13000,20},
 	chanceLabel={}
},
[10026] =
{
 		id=10026,
 		type=3,
 		items={242,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10027] =
{
 		id=10027,
 		type=3,
 		items={3,5},
 		cnts={6500,20},
 	chanceLabel={}
},
[10028] =
{
 		id=10028,
 		type=3,
 		items={1,5},
 		cnts={14000,20},
 	chanceLabel={}
},
[10029] =
{
 		id=10029,
 		type=3,
 		items={243,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10030] =
{
 		id=10030,
 		type=3,
 		items={3,5},
 		cnts={7000,20},
 	chanceLabel={}
},
[10031] =
{
 		id=10031,
 		type=3,
 		items={1,5},
 		cnts={15000,20},
 	chanceLabel={}
},
[10032] =
{
 		id=10032,
 		type=3,
 		items={243,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10033] =
{
 		id=10033,
 		type=3,
 		items={3,5},
 		cnts={7500,20},
 	chanceLabel={}
},
[10034] =
{
 		id=10034,
 		type=3,
 		items={1,5},
 		cnts={16000,20},
 	chanceLabel={}
},
[10035] =
{
 		id=10035,
 		type=3,
 		items={243,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10036] =
{
 		id=10036,
 		type=3,
 		items={3,5},
 		cnts={8000,20},
 	chanceLabel={}
},
[10037] =
{
 		id=10037,
 		type=3,
 		items={1,5},
 		cnts={17000,20},
 	chanceLabel={}
},
[10038] =
{
 		id=10038,
 		type=3,
 		items={243,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10039] =
{
 		id=10039,
 		type=3,
 		items={3,5},
 		cnts={8500,20},
 	chanceLabel={}
},
[10040] =
{
 		id=10040,
 		type=3,
 		items={1,5},
 		cnts={18000,20},
 	chanceLabel={}
},
[10041] =
{
 		id=10041,
 		type=3,
 		items={243,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10042] =
{
 		id=10042,
 		type=3,
 		items={3,5},
 		cnts={9000,20},
 	chanceLabel={}
},
[10043] =
{
 		id=10043,
 		type=3,
 		items={1,5},
 		cnts={19000,20},
 	chanceLabel={}
},
[10044] =
{
 		id=10044,
 		type=3,
 		items={244,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10045] =
{
 		id=10045,
 		type=3,
 		items={3,5},
 		cnts={9500,20},
 	chanceLabel={}
},
[10046] =
{
 		id=10046,
 		type=3,
 		items={1,5},
 		cnts={20000,20},
 	chanceLabel={}
},
[10047] =
{
 		id=10047,
 		type=3,
 		items={244,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10048] =
{
 		id=10048,
 		type=3,
 		items={3,5},
 		cnts={10000,20},
 	chanceLabel={}
},
[10049] =
{
 		id=10049,
 		type=3,
 		items={1,5},
 		cnts={20000,20},
 	chanceLabel={}
},
[10050] =
{
 		id=10050,
 		type=3,
 		items={244,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10051] =
{
 		id=10051,
 		type=3,
 		items={3,5},
 		cnts={10000,20},
 	chanceLabel={}
},
[10052] =
{
 		id=10052,
 		type=3,
 		items={1,5},
 		cnts={20000,20},
 	chanceLabel={}
},
[10053] =
{
 		id=10053,
 		type=3,
 		items={244,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10054] =
{
 		id=10054,
 		type=3,
 		items={3,5},
 		cnts={10000,20},
 	chanceLabel={}
},
[10055] =
{
 		id=10055,
 		type=3,
 		items={1,5},
 		cnts={20000,20},
 	chanceLabel={}
},
[10056] =
{
 		id=10056,
 		type=3,
 		items={244,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10057] =
{
 		id=10057,
 		type=3,
 		items={3,5},
 		cnts={10000,20},
 	chanceLabel={}
},
[10058] =
{
 		id=10058,
 		type=3,
 		items={1,5},
 		cnts={20000,20},
 	chanceLabel={}
},
[10059] =
{
 		id=10059,
 		type=3,
 		items={244,5},
 		cnts={1,20},
 	chanceLabel={}
},
[10060] =
{
 		id=10060,
 		type=3,
 		items={3,5},
 		cnts={10000,20},
 	chanceLabel={}
},
[11001] =
{
 		id=11001,
 		type=3,
 		items={1,71},
 		cnts={2000,10},
 	chanceLabel={}
},
[11002] =
{
 		id=11002,
 		type=3,
 		items={1,71},
 		cnts={2000,15},
 	chanceLabel={}
},
[11003] =
{
 		id=11003,
 		type=3,
 		items={1,71},
 		cnts={2000,10},
 	chanceLabel={}
},
[11004] =
{
 		id=11004,
 		type=3,
 		items={1,71},
 		cnts={2000,15},
 	chanceLabel={}
},
[11005] =
{
 		id=11005,
 		type=3,
 		items={1,71},
 		cnts={2000,15},
 	chanceLabel={}
},
[11006] =
{
 		id=11006,
 		type=3,
 		items={1,71},
 		cnts={2000,10},
 	chanceLabel={}
},
[11007] =
{
 		id=11007,
 		type=3,
 		items={1,71},
 		cnts={2000,15},
 	chanceLabel={}
},
[11008] =
{
 		id=11008,
 		type=3,
 		items={1,71},
 		cnts={2000,15},
 	chanceLabel={}
},
[11009] =
{
 		id=11009,
 		type=3,
 		items={1,71},
 		cnts={2000,15},
 	chanceLabel={}
},
[11010] =
{
 		id=11010,
 		type=3,
 		items={1,71},
 		cnts={2000,15},
 	chanceLabel={}
},
[11011] =
{
 		id=11011,
 		type=3,
 		items={1,71},
 		cnts={2000,15},
 	chanceLabel={}
},
[11012] =
{
 		id=11012,
 		type=3,
 		items={1,71},
 		cnts={2000,10},
 	chanceLabel={}
},
[11013] =
{
 		id=11013,
 		type=3,
 		items={1,71},
 		cnts={2000,10},
 	chanceLabel={}
},
[11014] =
{
 		id=11014,
 		type=3,
 		items={1,71},
 		cnts={2000,10},
 	chanceLabel={}
},
[11101] =
{
 		id=11101,
 		type=3,
 		items={1},
 		cnts={10000},
 	chanceLabel={}
},
[11102] =
{
 		id=11102,
 		type=3,
 		items={8511},
 		cnts={2},
 	chanceLabel={}
},
[11103] =
{
 		id=11103,
 		type=3,
 		items={8503},
 		cnts={1},
 	chanceLabel={}
},
[11104] =
{
 		id=11104,
 		type=3,
 		items={5},
 		cnts={30},
 	chanceLabel={}
},
[11105] =
{
 		id=11105,
 		type=3,
 		items={102},
 		cnts={1},
 	chanceLabel={}
},
[11201] =
{
 		id=11201,
 		type=3,
 		items={1,72},
 		cnts={4000,15},
 	chanceLabel={}
},
[11202] =
{
 		id=11202,
 		type=3,
 		items={1,72},
 		cnts={4000,10},
 	chanceLabel={}
},
[11203] =
{
 		id=11203,
 		type=3,
 		items={1,72},
 		cnts={4000,10},
 	chanceLabel={}
},
[11204] =
{
 		id=11204,
 		type=3,
 		items={1,72},
 		cnts={4000,10},
 	chanceLabel={}
},
[11205] =
{
 		id=11205,
 		type=3,
 		items={1,72},
 		cnts={4000,15},
 	chanceLabel={}
},
[11206] =
{
 		id=11206,
 		type=3,
 		items={1,72},
 		cnts={4000,10},
 	chanceLabel={}
},
[11207] =
{
 		id=11207,
 		type=3,
 		items={1,72},
 		cnts={4000,10},
 	chanceLabel={}
},
[11208] =
{
 		id=11208,
 		type=3,
 		items={1,72},
 		cnts={4000,10},
 	chanceLabel={}
},
[11209] =
{
 		id=11209,
 		type=3,
 		items={1,72},
 		cnts={4000,10},
 	chanceLabel={}
},
[11210] =
{
 		id=11210,
 		type=3,
 		items={1,72},
 		cnts={4000,15},
 	chanceLabel={}
},
[11211] =
{
 		id=11211,
 		type=3,
 		items={1,72},
 		cnts={4000,10},
 	chanceLabel={}
},
[11212] =
{
 		id=11212,
 		type=3,
 		items={1,72},
 		cnts={4000,10},
 	chanceLabel={}
},
[11213] =
{
 		id=11213,
 		type=3,
 		items={1,72},
 		cnts={4000,10},
 	chanceLabel={}
},
[11214] =
{
 		id=11214,
 		type=3,
 		items={1,72},
 		cnts={4000,15},
 	chanceLabel={}
},
[11301] =
{
 		id=11301,
 		type=3,
 		items={5},
 		cnts={50},
 	chanceLabel={}
},
[11302] =
{
 		id=11302,
 		type=3,
 		items={56},
 		cnts={1},
 	chanceLabel={}
},
[11303] =
{
 		id=11303,
 		type=3,
 		items={87},
 		cnts={1},
 	chanceLabel={}
},
[11304] =
{
 		id=11304,
 		type=3,
 		items={51},
 		cnts={1},
 	chanceLabel={}
},
[11305] =
{
 		id=11305,
 		type=3,
 		items={104},
 		cnts={1},
 	chanceLabel={}
},
[11401] =
{
 		id=11401,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11402] =
{
 		id=11402,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11403] =
{
 		id=11403,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11404] =
{
 		id=11404,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11405] =
{
 		id=11405,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11406] =
{
 		id=11406,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11407] =
{
 		id=11407,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11408] =
{
 		id=11408,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11409] =
{
 		id=11409,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11410] =
{
 		id=11410,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11411] =
{
 		id=11411,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11412] =
{
 		id=11412,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11413] =
{
 		id=11413,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11414] =
{
 		id=11414,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11415] =
{
 		id=11415,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11416] =
{
 		id=11416,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11417] =
{
 		id=11417,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11418] =
{
 		id=11418,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11419] =
{
 		id=11419,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11420] =
{
 		id=11420,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11421] =
{
 		id=11421,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11422] =
{
 		id=11422,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11423] =
{
 		id=11423,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11424] =
{
 		id=11424,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[11425] =
{
 		id=11425,
 		type=3,
 		items={57},
 		cnts={1},
 	chanceLabel={}
},
[20011] =
{
 		id=20011,
 		type=3,
 		items={87},
 		cnts={1},
 	chanceLabel={}
},
[20012] =
{
 		id=20012,
 		type=3,
 		items={104},
 		cnts={3},
 	chanceLabel={}
},
[20013] =
{
 		id=20013,
 		type=3,
 		items={51},
 		cnts={5},
 	chanceLabel={}
},
[20014] =
{
 		id=20014,
 		type=3,
 		items={5014},
 		cnts={5},
 	chanceLabel={}
},
[20015] =
{
 		id=20015,
 		type=3,
 		items={5015},
 		cnts={1},
 	chanceLabel={}
},
[20016] =
{
 		id=20016,
 		type=3,
 		items={5016},
 		cnts={1},
 	chanceLabel={}
},
[20017] =
{
 		id=20017,
 		type=3,
 		items={5017},
 		cnts={1},
 	chanceLabel={}
},
[20018] =
{
 		id=20018,
 		type=3,
 		items={5},
 		cnts={100},
 	chanceLabel={}
},
[20019] =
{
 		id=20019,
 		type=3,
 		items={5},
 		cnts={200},
 	chanceLabel={}
},
[20020] =
{
 		id=20020,
 		type=3,
 		items={5},
 		cnts={300},
 	chanceLabel={}
},
[20021] =
{
 		id=20021,
 		type=3,
 		items={5},
 		cnts={400},
 	chanceLabel={}
},
[20022] =
{
 		id=20022,
 		type=3,
 		items={5},
 		cnts={500},
 	chanceLabel={}
},
[21101] =
{
 		id=21101,
 		type=3,
 		items={5011},
 		cnts={100},
 	chanceLabel={}
},
[21102] =
{
 		id=21102,
 		type=3,
 		items={5011},
 		cnts={100},
 	chanceLabel={}
},
[21103] =
{
 		id=21103,
 		type=3,
 		items={5011},
 		cnts={100},
 	chanceLabel={}
},
[21104] =
{
 		id=21104,
 		type=3,
 		items={5011},
 		cnts={100},
 	chanceLabel={}
},
[21105] =
{
 		id=21105,
 		type=3,
 		items={5011},
 		cnts={120},
 	chanceLabel={}
},
[21106] =
{
 		id=21106,
 		type=3,
 		items={5011},
 		cnts={120},
 	chanceLabel={}
},
[21107] =
{
 		id=21107,
 		type=3,
 		items={5011},
 		cnts={120},
 	chanceLabel={}
},
[21108] =
{
 		id=21108,
 		type=3,
 		items={5011},
 		cnts={120},
 	chanceLabel={}
},
[21109] =
{
 		id=21109,
 		type=3,
 		items={5011},
 		cnts={150},
 	chanceLabel={}
},
[21110] =
{
 		id=21110,
 		type=3,
 		items={5011},
 		cnts={150},
 	chanceLabel={}
},
[21111] =
{
 		id=21111,
 		type=3,
 		items={5011},
 		cnts={150},
 	chanceLabel={}
},
[21112] =
{
 		id=21112,
 		type=3,
 		items={5011},
 		cnts={150},
 	chanceLabel={}
},
[21201] =
{
 		id=21201,
 		type=3,
 		items={5011},
 		cnts={200},
 	chanceLabel={}
},
[21202] =
{
 		id=21202,
 		type=3,
 		items={5011},
 		cnts={200},
 	chanceLabel={}
},
[21203] =
{
 		id=21203,
 		type=3,
 		items={5011},
 		cnts={200},
 	chanceLabel={}
},
[21204] =
{
 		id=21204,
 		type=3,
 		items={5011},
 		cnts={200},
 	chanceLabel={}
},
[21205] =
{
 		id=21205,
 		type=3,
 		items={5011},
 		cnts={250},
 	chanceLabel={}
},
[21206] =
{
 		id=21206,
 		type=3,
 		items={5011},
 		cnts={250},
 	chanceLabel={}
},
[21207] =
{
 		id=21207,
 		type=3,
 		items={5011},
 		cnts={250},
 	chanceLabel={}
},
[21208] =
{
 		id=21208,
 		type=3,
 		items={5011},
 		cnts={250},
 	chanceLabel={}
},
[21209] =
{
 		id=21209,
 		type=3,
 		items={5011},
 		cnts={300},
 	chanceLabel={}
},
[21210] =
{
 		id=21210,
 		type=3,
 		items={5011},
 		cnts={300},
 	chanceLabel={}
},
[21211] =
{
 		id=21211,
 		type=3,
 		items={5011},
 		cnts={300},
 	chanceLabel={}
},
[21212] =
{
 		id=21212,
 		type=3,
 		items={5011},
 		cnts={300},
 	chanceLabel={}
},
[21301] =
{
 		id=21301,
 		type=3,
 		items={2,5011,412},
 		cnts={16,40,1},
 	chanceLabel={1,1,2}
},
[21302] =
{
 		id=21302,
 		type=3,
 		items={2,5011,422},
 		cnts={16,40,1},
 	chanceLabel={1,1,2}
},
[21303] =
{
 		id=21303,
 		type=3,
 		items={2,5011,432},
 		cnts={16,40,1},
 	chanceLabel={1,1,2}
},
[21304] =
{
 		id=21304,
 		type=3,
 		items={2,5011,442},
 		cnts={16,40,1},
 	chanceLabel={1,1,2}
},
[21305] =
{
 		id=21305,
 		type=3,
 		items={2,5011,452},
 		cnts={16,40,1},
 	chanceLabel={1,1,2}
},
[21306] =
{
 		id=21306,
 		type=3,
 		items={2,5011,462},
 		cnts={16,40,1},
 	chanceLabel={1,1,2}
},
[21307] =
{
 		id=21307,
 		type=4,
 		items={2,5011,413},
 		cnts={24,60,1},
 		weight={10000,10000,8000},
 	chanceLabel={1,1,3}
},
[21308] =
{
 		id=21308,
 		type=4,
 		items={2,5011,423},
 		cnts={24,60,1},
 		weight={10000,10000,8000},
 	chanceLabel={1,1,3}
},
[21309] =
{
 		id=21309,
 		type=4,
 		items={2,5011,433},
 		cnts={24,60,1},
 		weight={10000,10000,8000},
 	chanceLabel={1,1,3}
},
[21310] =
{
 		id=21310,
 		type=4,
 		items={2,5011,443},
 		cnts={24,60,1},
 		weight={10000,10000,8000},
 	chanceLabel={1,1,3}
},
[21311] =
{
 		id=21311,
 		type=4,
 		items={2,5011,453},
 		cnts={24,60,1},
 		weight={10000,10000,8000},
 	chanceLabel={1,1,3}
},
[21312] =
{
 		id=21312,
 		type=4,
 		items={2,5011,463},
 		cnts={24,60,1},
 		weight={10000,10000,8000},
 	chanceLabel={1,1,3}
},
[21401] =
{
 		id=21401,
 		type=3,
 		items={5011},
 		cnts={200},
 	chanceLabel={}
},
[21402] =
{
 		id=21402,
 		type=3,
 		items={2},
 		cnts={16},
 	chanceLabel={}
},
[21403] =
{
 		id=21403,
 		type=3,
 		items={2},
 		cnts={20},
 	chanceLabel={}
},
[21404] =
{
 		id=21404,
 		type=3,
 		items={2},
 		cnts={24},
 	chanceLabel={}
},
[22101] =
{
 		id=22101,
 		type=3,
 		items={241,5018},
 		cnts={4,80},
 	chanceLabel={1,1}
},
[22102] =
{
 		id=22102,
 		type=3,
 		items={201,5018},
 		cnts={4,80},
 	chanceLabel={1,1}
},
[22103] =
{
 		id=22103,
 		type=3,
 		items={242,5018},
 		cnts={4,120},
 	chanceLabel={1,1}
},
[22104] =
{
 		id=22104,
 		type=3,
 		items={202,5018},
 		cnts={2,120},
 	chanceLabel={1,1}
},
[22105] =
{
 		id=22105,
 		type=3,
 		items={243,5018},
 		cnts={3,150},
 	chanceLabel={1,1}
},
[22106] =
{
 		id=22106,
 		type=4,
 		items={203,5018},
 		cnts={1,150},
 		weight={8300,10000},
 	chanceLabel={3,1}
},
[22107] =
{
 		id=22107,
 		type=3,
 		items={244,5018},
 		cnts={2,150},
 	chanceLabel={1,1}
},
[22108] =
{
 		id=22108,
 		type=3,
 		items={1,5018},
 		cnts={30000,150},
 	chanceLabel={2,1}
},
[22200] =
{
 		id=22200,
 		type=3,
 		items={5018},
 		cnts={200},
 	chanceLabel={}
},
[22201] =
{
 		id=22201,
 		type=3,
 		items={5018},
 		cnts={2000},
 	chanceLabel={}
},
[22202] =
{
 		id=22202,
 		type=3,
 		items={8503},
 		cnts={3},
 	chanceLabel={}
},
[22203] =
{
 		id=22203,
 		type=3,
 		items={57},
 		cnts={5},
 	chanceLabel={}
},
[32101] =
{
 		id=32101,
 		type=3,
 		items={8506,1,3},
 		cnts={3,10000,10000},
 	chanceLabel={}
},
[32102] =
{
 		id=32102,
 		type=3,
 		items={8507,1,3},
 		cnts={2,12000,12000},
 	chanceLabel={}
},
[32103] =
{
 		id=32103,
 		type=3,
 		items={8507,1,3},
 		cnts={2,14000,14000},
 	chanceLabel={}
},
[32104] =
{
 		id=32104,
 		type=3,
 		items={8507,1,3},
 		cnts={2,16000,16000},
 	chanceLabel={}
},
[32105] =
{
 		id=32105,
 		type=3,
 		items={8508,1,3},
 		cnts={2,18000,18000},
 	chanceLabel={}
},
[32106] =
{
 		id=32106,
 		type=3,
 		items={8508,1,3},
 		cnts={2,20000,20000},
 	chanceLabel={}
},
[32107] =
{
 		id=32107,
 		type=3,
 		items={8508,1,3},
 		cnts={2,22000,22000},
 	chanceLabel={}
},
[32108] =
{
 		id=32108,
 		type=3,
 		items={8508,1,3},
 		cnts={2,24000,24000},
 	chanceLabel={}
},
[32109] =
{
 		id=32109,
 		type=3,
 		items={8508,1,3},
 		cnts={2,26000,26000},
 	chanceLabel={}
},
[32110] =
{
 		id=32110,
 		type=3,
 		items={8508,1,3},
 		cnts={2,28000,28000},
 	chanceLabel={}
},
[32111] =
{
 		id=32111,
 		type=3,
 		items={8508,1,3},
 		cnts={2,30000,30000},
 	chanceLabel={}
},
[32201] =
{
 		id=32201,
 		type=3,
 		items={5,201,3,1},
 		cnts={60,3,10000,10000},
 	chanceLabel={}
},
[32202] =
{
 		id=32202,
 		type=3,
 		items={5,202,3,1},
 		cnts={80,3,12000,12000},
 	chanceLabel={}
},
[32203] =
{
 		id=32203,
 		type=3,
 		items={5,202,3,1},
 		cnts={100,3,14000,14000},
 	chanceLabel={}
},
[32204] =
{
 		id=32204,
 		type=3,
 		items={5,203,3,1},
 		cnts={120,3,16000,16000},
 	chanceLabel={}
},
[32205] =
{
 		id=32205,
 		type=3,
 		items={5,203,3,1},
 		cnts={120,3,18000,18000},
 	chanceLabel={}
},
[32206] =
{
 		id=32206,
 		type=3,
 		items={5,8502,3,1},
 		cnts={120,2,20000,20000},
 	chanceLabel={}
},
[32207] =
{
 		id=32207,
 		type=3,
 		items={5,8502,3,1},
 		cnts={120,3,22000,22000},
 	chanceLabel={}
},
[32208] =
{
 		id=32208,
 		type=3,
 		items={5,8502,3,1},
 		cnts={120,3,24000,24000},
 	chanceLabel={}
},
[32209] =
{
 		id=32209,
 		type=3,
 		items={5,8502,3,1},
 		cnts={120,3,26000,26000},
 	chanceLabel={}
},
[32210] =
{
 		id=32210,
 		type=3,
 		items={5,8502,3,1},
 		cnts={120,3,28000,28000},
 	chanceLabel={}
},
[32211] =
{
 		id=32211,
 		type=3,
 		items={5,8502,3,1},
 		cnts={120,3,30000,30000},
 	chanceLabel={}
},
[33101] =
{
 		id=33101,
 		type=3,
 		items={57,5},
 		cnts={5,60},
 	chanceLabel={}
},
[33102] =
{
 		id=33102,
 		type=3,
 		items={8101,5,1,3},
 		cnts={1,180,30000,30000},
 	chanceLabel={}
},
[33103] =
{
 		id=33103,
 		type=3,
 		items={86,6,201,241,1,3},
 		cnts={4,120,20,15,60000,30000},
 	chanceLabel={}
},
[33104] =
{
 		id=33104,
 		type=3,
 		items={711,721,701,712,722,702},
 		cnts={25,25,25,6,6,6},
 	chanceLabel={}
},
[33201] =
{
 		id=33201,
 		type=3,
 		items={3,1},
 		cnts={2000,4000},
 	chanceLabel={}
},
[33202] =
{
 		id=33202,
 		type=3,
 		items={57,6,86},
 		cnts={1,40,2},
 	chanceLabel={}
},
[33203] =
{
 		id=33203,
 		type=3,
 		items={51,86,202},
 		cnts={1,2,3},
 	chanceLabel={}
},
[33204] =
{
 		id=33204,
 		type=3,
 		items={8102,86},
 		cnts={1,2},
 	chanceLabel={}
},
[33301] =
{
 		id=33301,
 		type=3,
 		items={52,6,3,1},
 		cnts={1,200,30000,60000},
 	chanceLabel={}
},
[33302] =
{
 		id=33302,
 		type=3,
 		items={86,251,8508,3,1},
 		cnts={2,4,3,20000,40000},
 	chanceLabel={}
},
[33303] =
{
 		id=33303,
 		type=3,
 		items={8526,8502,7},
 		cnts={2,10,2000},
 	chanceLabel={}
},
[33304] =
{
 		id=33304,
 		type=3,
 		items={56,8503},
 		cnts={5,4},
 	chanceLabel={}
},
[33305] =
{
 		id=33305,
 		type=3,
 		items={52,402,401,86},
 		cnts={1,1,1,10},
 	chanceLabel={}
},
[33306] =
{
 		id=33306,
 		type=3,
 		items={6,86},
 		cnts={180,4},
 	chanceLabel={}
},
[33307] =
{
 		id=33307,
 		type=3,
 		items={8526,5},
 		cnts={5,3000},
 	chanceLabel={}
},
[33308] =
{
 		id=33308,
 		type=3,
 		items={8526,5},
 		cnts={2,1300},
 	chanceLabel={}
},
[33401] =
{
 		id=33401,
 		type=3,
 		items={52,203,3,1},
 		cnts={2,3,30000,60000},
 	chanceLabel={}
},
[33402] =
{
 		id=33402,
 		type=3,
 		items={52,251,8502,8508,231,3,1},
 		cnts={4,6,20,10,20,40000,80000},
 	chanceLabel={}
},
[33501] =
{
 		id=33501,
 		type=3,
 		items={52,86,6,211,3,1},
 		cnts={1,12,980,4,100000,160000},
 	chanceLabel={}
},
[33502] =
{
 		id=33502,
 		type=3,
 		items={52,402,401,211,8508,1},
 		cnts={4,1,1,4,8,300000},
 	chanceLabel={}
},
[33503] =
{
 		id=33503,
 		type=3,
 		items={52,86,6,211,3,1},
 		cnts={1,12,980,4,100000,160000},
 	chanceLabel={}
},
[33504] =
{
 		id=33504,
 		type=3,
 		items={52,402,401,211,8508,1},
 		cnts={4,1,1,4,8,300000},
 	chanceLabel={}
},
[33505] =
{
 		id=33505,
 		type=3,
 		items={86,6,212,3,1},
 		cnts={12,4900,3,100000,160000},
 	chanceLabel={}
},
[33506] =
{
 		id=33506,
 		type=3,
 		items={52,402,212,8508,1},
 		cnts={4,1,3,8,300000},
 	chanceLabel={}
},
[34101] =
{
 		id=34101,
 		type=3,
 		items={103},
 		cnts={1},
 	chanceLabel={}
},
[34102] =
{
 		id=34102,
 		type=3,
 		items={6},
 		cnts={980},
 	chanceLabel={}
},
[31701] =
{
 		id=31701,
 		type=3,
 		items={1701},
 		cnts={1},
 	chanceLabel={}
},
[31702] =
{
 		id=31702,
 		type=3,
 		items={1702},
 		cnts={1},
 	chanceLabel={}
},
[31703] =
{
 		id=31703,
 		type=3,
 		items={1703},
 		cnts={1},
 	chanceLabel={}
},
[31704] =
{
 		id=31704,
 		type=3,
 		items={1704},
 		cnts={1},
 	chanceLabel={}
},
[31705] =
{
 		id=31705,
 		type=3,
 		items={1705},
 		cnts={1},
 	chanceLabel={}
},
[31706] =
{
 		id=31706,
 		type=3,
 		items={1706},
 		cnts={1},
 	chanceLabel={}
},
[31707] =
{
 		id=31707,
 		type=3,
 		items={1707},
 		cnts={1},
 	chanceLabel={}
},
[31708] =
{
 		id=31708,
 		type=3,
 		items={1708},
 		cnts={1},
 	chanceLabel={}
},
[31709] =
{
 		id=31709,
 		type=3,
 		items={1709},
 		cnts={1},
 	chanceLabel={}
},
[31710] =
{
 		id=31710,
 		type=3,
 		items={1710},
 		cnts={1},
 	chanceLabel={}
},
[31711] =
{
 		id=31711,
 		type=3,
 		items={1711},
 		cnts={1},
 	chanceLabel={}
},
[31712] =
{
 		id=31712,
 		type=3,
 		items={1712},
 		cnts={1},
 	chanceLabel={}
},
[31713] =
{
 		id=31713,
 		type=3,
 		items={1713},
 		cnts={1},
 	chanceLabel={}
},
[31714] =
{
 		id=31714,
 		type=3,
 		items={1714},
 		cnts={1},
 	chanceLabel={}
},
[31715] =
{
 		id=31715,
 		type=3,
 		items={1715},
 		cnts={1},
 	chanceLabel={}
},
[31716] =
{
 		id=31716,
 		type=3,
 		items={1716},
 		cnts={1},
 	chanceLabel={}
},
[31717] =
{
 		id=31717,
 		type=3,
 		items={1717},
 		cnts={1},
 	chanceLabel={}
},
[31718] =
{
 		id=31718,
 		type=3,
 		items={1718},
 		cnts={1},
 	chanceLabel={}
},
[31719] =
{
 		id=31719,
 		type=3,
 		items={1719},
 		cnts={1},
 	chanceLabel={}
},
[31720] =
{
 		id=31720,
 		type=3,
 		items={1720},
 		cnts={1},
 	chanceLabel={}
},
[31721] =
{
 		id=31721,
 		type=3,
 		items={1721},
 		cnts={1},
 	chanceLabel={}
},
[31722] =
{
 		id=31722,
 		type=3,
 		items={1722},
 		cnts={1},
 	chanceLabel={}
},
[31723] =
{
 		id=31723,
 		type=3,
 		items={1723},
 		cnts={1},
 	chanceLabel={}
},
[31724] =
{
 		id=31724,
 		type=3,
 		items={1724},
 		cnts={1},
 	chanceLabel={}
},
[31725] =
{
 		id=31725,
 		type=3,
 		items={1725},
 		cnts={1},
 	chanceLabel={}
},
[31726] =
{
 		id=31726,
 		type=3,
 		items={1726},
 		cnts={1},
 	chanceLabel={}
},
[31727] =
{
 		id=31727,
 		type=3,
 		items={1727},
 		cnts={1},
 	chanceLabel={}
},
[31728] =
{
 		id=31728,
 		type=3,
 		items={1728},
 		cnts={1},
 	chanceLabel={}
},
[31729] =
{
 		id=31729,
 		type=3,
 		items={1729},
 		cnts={1},
 	chanceLabel={}
},
[31730] =
{
 		id=31730,
 		type=3,
 		items={1730},
 		cnts={1},
 	chanceLabel={}
},
[31731] =
{
 		id=31731,
 		type=3,
 		items={1731},
 		cnts={1},
 	chanceLabel={}
},
[31732] =
{
 		id=31732,
 		type=3,
 		items={1732},
 		cnts={1},
 	chanceLabel={}
},
[31733] =
{
 		id=31733,
 		type=3,
 		items={1733},
 		cnts={1},
 	chanceLabel={}
},
[31734] =
{
 		id=31734,
 		type=3,
 		items={1734},
 		cnts={1},
 	chanceLabel={}
},
[31735] =
{
 		id=31735,
 		type=3,
 		items={1735},
 		cnts={1},
 	chanceLabel={}
},
[31736] =
{
 		id=31736,
 		type=3,
 		items={1736},
 		cnts={1},
 	chanceLabel={}
},
[35101] =
{
 		id=35101,
 		type=3,
 		items={11},
 		cnts={4},
 	chanceLabel={}
},
[35102] =
{
 		id=35102,
 		type=3,
 		items={11},
 		cnts={4},
 	chanceLabel={}
},
[35103] =
{
 		id=35103,
 		type=3,
 		items={11},
 		cnts={8},
 	chanceLabel={}
},
[35104] =
{
 		id=35104,
 		type=3,
 		items={11},
 		cnts={12},
 	chanceLabel={}
},
[35105] =
{
 		id=35105,
 		type=3,
 		items={8527},
 		cnts={1},
 	chanceLabel={}
},
[35106] =
{
 		id=35106,
 		type=3,
 		items={1},
 		cnts={5000},
 	chanceLabel={}
}
}

return {title=title, value=value}