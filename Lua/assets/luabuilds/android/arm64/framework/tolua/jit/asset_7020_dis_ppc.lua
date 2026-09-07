local var_0_0 = type
local var_0_1 = string.byte
local var_0_2 = string.format
local var_0_3 = string.match
local var_0_4 = string.gmatch
local var_0_5 = string.gsub
local var_0_6 = table.concat
local bit = require("bit")
local var_0_8 = bit.band
local var_0_9 = bit.bor
local var_0_10 = bit.tohex
local var_0_11 = bit.lshift
local var_0_12 = bit.rshift
local var_0_13 = bit.arshift
local var_0_14 = {
	[0] = false,
	false,
	"tdiARI",
	"twiARI",
	{
		[765] = "efdtstltYRR",
		[759] = "efdctsfR-R",
		[725] = "efsctsiR-R",
		[669] = "evfststltYRR",
		[727] = "efsctsfR-R",
		[1219] = "evsubfssiaawRR",
		[1453] = "evmhogsmianRRR",
		[1039] = "evmhosmfRRR",
		[1281] = "evmhessiaawRRR",
		[1068] = "evmhoumiaRRR",
		[785] = "evlwheRR4",
		[1036] = "evmhoumiRRR",
		[766] = "efdtsteqYRR",
		[754] = "efdcfufR-R",
		[1421] = "evmhosmianwRRR",
		[756] = "efdctuiR-R",
		[1413] = "evmhossianwRRR",
		[542] = "evnandRRR",
		[544] = "evsrwuRRR",
		[724] = "efsctuiR-R",
		[1035] = "evmhesmfRRR",
		[1031] = "evmhossfRRR",
		[560] = "evcmpgtuYRR",
		[514] = "evaddiwRAR~",
		[522] = "evextsbRR",
		[668] = "evfststgtYRR",
		[666] = "evfsctsizR-R",
		[660] = "evfsctuiR-R",
		[633] = "evselRRRW",
		[1222] = "evdivwsRRR",
		[637] = "evselRRRW",
		[521] = "evnegRR",
		[526] = "evcntlswRR",
		[640] = "evfsaddRRR",
		[525] = "evcntlzwRR",
		[639] = "evselRRRW",
		[644] = "evfsabsRR",
		[652] = "evfscmpgtYRR",
		[648] = "evfsmulRRR",
		[1324] = "evmhogumiaaRRR",
		[1037] = "evmhosmiRRR",
		[635] = "evselRRRW",
		[656] = "evfscfuiR-R",
		[658] = "evfscfufR-R",
		[1284] = "evmhousiaawRRR",
		[719] = "efscfdR-R",
		[664] = "evfsctuizR-R",
		[1292] = "evmhoumiaawRRR",
		[1069] = "evmhosmiaRRR",
		[562] = "evcmpltuYRR",
		[537] = "eveqvRRR",
		[554] = "evrlwiRRA",
		[552] = "evrlwRRR",
		[546] = "evsrwiuRRA",
		[713] = "efsdivRRR",
		[716] = "efscmpgtYRR",
		[1101] = "evmwhsmiRRR",
		[721] = "efscfsiR-R",
		[722] = "efscfufR-R",
		[738] = "efdcfuidR-R",
		[752] = "efdcfuiR-R",
		[732] = "efststgtYRR",
		[536] = "evnor|evnotRRR=",
		[535] = "evor|evmrRRR=",
		[1133] = "evmwhsmiaRRR",
		[708] = "efsabsRR",
		[530] = "evandcRRR",
		[704] = "efsaddRRR",
		[529] = "evandRRR",
		[564] = "evcmpeqYRR",
		[1452] = "evmhogumianRRR",
		[712] = "efsmulRRR",
		[527] = "brincRRR",
		[556] = "evmergehiRRR",
		[1345] = "evmwlssiaawRRR",
		[720] = "efscfuiR-R",
		[518] = "evsubiwRAR~",
		[548] = "evslwRRR",
		[1420] = "evmhoumianwRRR",
		[728] = "efsctuizR-R",
		[1412] = "evmhousianwRRR",
		[740] = "efdabsRR",
		[516] = "evsubwRRR~",
		[736] = "efdaddRRR",
		[748] = "efdcmpgtYRR",
		[744] = "efdmulRRR",
		[524] = "evrndwRR",
		[520] = "evabsRR",
		[764] = "efdtstgtYRR",
		[512] = "evaddwRRR",
		[760] = "efdctuizR-R",
		[773] = "evldhRR8",
		[769] = "evlddRR8",
		[781] = "evlhhousplatRR2",
		[1323] = "evmhegsmfaaRRR",
		[777] = "evlhhesplatRR2",
		[789] = "evlwhouRR4",
		[1283] = "evmhessfaawRRR",
		[797] = "evlwhsplatRR4",
		[1291] = "evmhesmfaawRRR",
		[793] = "evlwwsplatRR4",
		[805] = "evstdhRR8",
		[801] = "evstddRR8",
		[1100] = "evmwhumiRRR",
		[821] = "evstwhoRR4",
		[817] = "evstwheRR4",
		[829] = "evstwwoRR4",
		[1132] = "evmwhumiaRRR",
		[825] = "evstwweRR4",
		[1363] = "evmwssfaaRRR",
		[1371] = "evmwsmfaaRRR",
		[1451] = "evmhegsmfanRRR",
		[1419] = "evmhesmfanwRRR",
		[1411] = "evmhessfanwRRR",
		[632] = "evselRRR",
		[1220] = "evmraRR",
		[636] = "evselRRRW",
		[1499] = "evmwsmfanRRR",
		[1491] = "evmwssfanRRR",
		[659] = "evfscfsfR-R",
		[1027] = "evmhessfRRR",
		[663] = "evfsctsfR-R",
		[1067] = "evmhesmfaRRR",
		[1059] = "evmhessfaRRR",
		[1115] = "evmwsmfRRR",
		[1107] = "evmwssfRRR",
		[1147] = "evmwsmfaRRR",
		[1139] = "evmwssfaRRR",
		[563] = "evcmpltsYRR",
		[559] = "evmergelohiRRR",
		[555] = "evsplatfiRS",
		[723] = "efscfsfR-R",
		[547] = "evsrwisRRA",
		[539] = "evorcRRR",
		[739] = "efdcfsidR-R",
		[751] = "efdcfsR-R",
		[747] = "efdctsidzR-R",
		[523] = "evextshRR",
		[755] = "efdcfsfR-R",
		[1227] = "evsubfsmiaawRR",
		[772] = "evldhxRR0R",
		[768] = "evlddxRR0R",
		[780] = "evlhhousplatxRR0R",
		[1321] = "evmhegsmiaaRRR",
		[776] = "evlhhesplatxRR0R",
		[788] = "evlwhouxRR0R",
		[784] = "evlwhexRR0R",
		[796] = "evlwhsplatxRR0R",
		[1289] = "evmhesmiaawRRR",
		[792] = "evlwwsplatxRR0R",
		[804] = "evstdhxRR0R",
		[800] = "evstddxRR0R",
		[820] = "evstwhoxRR0R",
		[816] = "evstwhexRR0R",
		shift = 0,
		[828] = "evstwwoxRR0R",
		[1353] = "evmwlsmiaawRRR",
		[824] = "evstwwexRR0R",
		[1369] = "evmwsmiaaRRR",
		[1449] = "evmhegsmianRRR",
		[1417] = "evmhesmianwRRR",
		[1409] = "evmhessianwRRR",
		mask = 2047,
		[1218] = "evsubfusiaawRR",
		[1481] = "evmwlsmianwRRR",
		[1226] = "evsubfumiaawRR",
		[1473] = "evmwlssianwRRR",
		[1497] = "evmwsmianRRR",
		[646] = "evfsnegRR",
		[654] = "evfscmpeqYRR",
		[1320] = "evmhegumiaaRRR",
		[1033] = "evmhesmiRRR",
		[662] = "evfsctufR-R",
		[1280] = "evmheusiaawRRR",
		[670] = "evfststeqYRR",
		[1288] = "evmheumiaawRRR",
		[1065] = "evmhesmiaRRR",
		[1113] = "evmwsmiRRR",
		[1145] = "evmwsmiaRRR",
		[1344] = "evmwlusiaawRRR",
		[1352] = "evmwlumiaawRRR",
		[710] = "efsnegRR",
		[1368] = "evmwumiaaRRR",
		[1448] = "evmhegumianRRR",
		[718] = "efscmpeqYRR",
		[558] = "evmergehiloRRR",
		[726] = "efsctufR-R",
		[550] = "evslwiRRA",
		[1416] = "evmheumianwRRR",
		[734] = "efststeqYRR",
		[1408] = "evmheusianwRRR",
		[730] = "efsctsizR-R",
		[742] = "efdnegRR",
		[534] = "evxorRRR",
		[750] = "efdcmpeqYRR",
		[746] = "efdctuidzR-R",
		[758] = "efdctufR-R",
		[1217] = "evaddssiaawRR",
		[1480] = "evmwlumianwRRR",
		[1225] = "evaddsmiaawRR",
		[1472] = "evmwlusianwRRR",
		[762] = "efdctsizR-R",
		[1496] = "evmwumianRRR",
		[771] = "evldwRR8",
		[783] = "evlhhossplatRR2",
		[1327] = "evmhogsmfaaRRR",
		[1032] = "evmheumiRRR",
		[791] = "evlwhosRR4",
		[1287] = "evmhossfaawRRR",
		[1295] = "evmhosmfaawRRR",
		[1064] = "evmheumiaRRR",
		[803] = "evstdwRR8",
		[1112] = "evmwumiRRR",
		[1096] = "evmwlumiRRR",
		[1144] = "evmwumiaRRR",
		[1128] = "evmwlumiaRRR",
		[1455] = "evmhogsmfanRRR",
		[1423] = "evmhosmfanwRRR",
		[1415] = "evmhossfanwRRR",
		[1216] = "evaddusiaawRR",
		[634] = "evselRRRW",
		[1224] = "evaddumiaawRR",
		[638] = "evselRRRW",
		[641] = "evfssubRRR",
		[645] = "evfsnabsRR",
		[649] = "evfsdivRRR",
		[653] = "evfscmpltYRR",
		[657] = "evfscfsiR-R",
		[661] = "evfsctsiR-R",
		[1071] = "evmhosmfaRRR",
		[1063] = "evmhossfaRRR",
		[1103] = "evmwhsmfRRR",
		[1095] = "evmwhssfRRR",
		[1135] = "evmwhsmfaRRR",
		[709] = "efsnabsRR",
		[1127] = "evmwhssfaRRR",
		[705] = "efssubRRR",
		[717] = "efscmpltYRR",
		[561] = "evcmpgtsYRR",
		[557] = "evmergeloRRR",
		[553] = "evsplatiRS",
		[733] = "efststltYRR",
		[545] = "evsrwsRRR",
		[741] = "efdnabsRR",
		[737] = "efdsubRRR",
		[749] = "efdcmpltYRR",
		[745] = "efddivRRR",
		[757] = "efdctsiR-R",
		[753] = "efdcfsiR-R",
		[1223] = "evdivwuRRR",
		[770] = "evldwxRR0R",
		[782] = "evlhhossplatxRR0R",
		[1325] = "evmhogsmiaaRRR",
		[790] = "evlwhosxRR0R",
		[1285] = "evmhossiaawRRR",
		[1293] = "evmhosmiaawRRR",
		[802] = "evstdwxRR0R"
	},
	false,
	false,
	"mulliRRI",
	"subficRRI",
	false,
	"cmpl_iYLRU",
	"cmp_iYLRI",
	"addicRRI",
	"addic.RRI",
	"addi|liRR0I",
	"addis|lisRR0I",
	"b_KBJ",
	"sc",
	"bKJ",
	{
		[0] = 1,
		mcrfXX = 289,
		["creqv|crsetCCC%"] = 257,
		crandCCC = 225,
		crnandCCC = "mask",
		[1023] = 150,
		isync = 129,
		crandcCCC = 16,
		b_lrKB = 33,
		["crnor|crnotCCC="] = 528,
		b_ctrKB = 417,
		crorcCCC = 449,
		["cror|crmoveCCC="] = 193,
		["crxor|crclrCCC%"] = "shift"
	},
	"rlwimiRR~AAA.",
	setmetatable({
		shift = 0,
		mask = -1
	}, {
		__index = function(arg_1_0, arg_1_1)
			local var_1_0 = var_0_8(var_0_12(arg_1_1, 11), 31)
			local var_1_1 = var_0_8(var_0_12(arg_1_1, 6), 31)
			local var_1_2 = var_0_8(var_0_12(arg_1_1, 1), 31)

			if var_1_1 == 0 and var_1_2 == 31 - var_1_0 then
				return "slwiRR~A."
			elseif var_1_2 == 31 and var_1_1 == 32 - var_1_0 then
				return "srwiRR~-A."
			else
				return "rlwinmRR~AAA."
			end

			return
		end
	}),
	false,
	"rlwnmRR~RAA.",
	"oriNRR~U",
	"orisRR~U",
	"xoriRR~U",
	"xorisRR~U",
	"andi.RR~U",
	"andis.RR~U",
	{
		[0] = "shift",
		2,
		"mask",
		7,
		{
			[0] = "mask",
			1,
			["rldclRR~RM."] = "rldcrRR~RM.",
			shift = 1
		},
		["rldiclRR~HM."] = "rldicrRR~HM.",
		["rldicRR~HM."] = "rldimiRR~HM."
	},
	setmetatable({
		[0] = "cmpbRR~R",
		922,
		"extshRR~.",
		954,
		"extsbRR~.",
		536,
		"srwRR~R.",
		826,
		"sradiRR~H.",
		778,
		"addoRRR.",
		375,
		"lhauxRRR",
		47,
		"iselgtRRR",
		373,
		"lwauxRRR",
		794,
		"sradRR~R.",
		40,
		"subfRRR.",
		247,
		"stbuxRRR",
		491,
		"divwRRR.",
		246,
		"dcbtst-R0R",
		489,
		"divdRRR.",
		234,
		"addmeRR.",
		"shift",
		1,
		cmp_YLRR = nil,
		[nil] = nil,
		twARR = nil,
		[nil] = nil,
		["subfcRRR."] = "mulhduRRR.",
		["addcRRR."] = "mulhwuRRR.",
		[nil] = nil,
		[nil] = "iselltRRR",
		[nil] = nil,
		[nil] = nil,
		lwarxRR0R = "ldxRR0R",
		[nil] = "lwzxRR0R",
		["slwRR~R."] = nil,
		["cntlzwRR~"] = "sldRR~R.",
		["andRR~R."] = nil,
		[nil] = nil,
		cmpl_YLRR = 232,
		["subfmeRR."] = 824,
		["srawiRR~A."] = 233,
		["mulldRRR."] = 149,
		stdxRR0R = 181,
		stduxRRR = 552,
		["subfoRRR."] = 86,
		["dcbf-R0R"] = 235,
		["mullwRRR."] = 119,
		lbzuxRRR = 341,
		lwaxRR0R = 87,
		lbzxRR0R = 343,
		lhaxRR0R = "mask",
		[1023] = 747,
		["mullwoRRR."] = 84,
		ldarxRR0R = 745,
		["mulldoRRR."] = 136,
		["subfeRRR."] = 854,
		eieio = 215,
		stbxRR0R = 457,
		["divduRRR."] = 616,
		["negoRR."] = 459,
		["divwuRRR."] = 200,
		["subfzeRR."] = 438,
		ecowxRR0R = 75,
		["mulhwRRR."] = 470,
		["dcbi-RR"] = 758,
		["dcba-RR"] = 631,
		lfduxFRR = 154,
		["prtywRR~"] = 58,
		["cntlzdRR~"] = 53,
		lduxRRR = 60,
		["andcRR~R."] = 73,
		["mulhdRRR."] = 124,
		["nor|notRR~R=."] = 104,
		["negRR."] = 284,
		["eqvRR~R."] = 316,
		["xorRR~R."] = 650,
		["addeoRRR."] = 54,
		["dcbst-R0R"] = 412,
		["orcRR~R."] = 79,
		iseleqRRR = 439,
		sthuxRRR = 310,
		eciwxRR0R = 311,
		lhzuxRRR = 660,
		stdbrxRR0R = 476,
		["nandRR~R."] = 55,
		lwzuxRRR = 532,
		ldbrxRR0R = 444,
		["or|mrRR~R=."] = 918,
		sthbrxRR0R = 214,
		["stdcxRR0R."] = 597,
		lswiRR0A = 150,
		["stwcxRR0R."] = 661,
		stswxRR0R = 151,
		stwxRR0R = 662,
		stwbrxRR0R = 790,
		lhbrxRR0R = 533,
		lswxRR0R = 535,
		lfsxFR0R = 695,
		stfsuxFRR = 279,
		lhzxRR0R = 278,
		["dcbt-R0R"] = 648,
		["subfeoRRR."] = 663,
		stfsxFR0R = 599,
		lfdxFR0R = 202,
		["addzeRR."] = 727,
		stfdxFR0R = 759,
		stfduxFR0R = 567,
		lfsuxFRR = 969,
		["divduoRRR."] = 971,
		["divwouRRR."] = 712,
		["subfzeoRR."] = 714,
		["addzeoRR."] = 725,
		stswiRR0A = 407,
		sthxRR0R = 68,
		tdARR = 855,
		lfiwaxFR0R = 983,
		stfiwxFR0R = 986,
		["extswRR~."] = 792,
		["srawRR~R."] = 982,
		["icbi-R0R"] = 183,
		stwuxRRR = 539,
		["srdRR~R."] = 138,
		["addeRRR."] = 534,
		lwbrxRR0R = 1001,
		["divdoRRR."] = 1003,
		["divwoRRR."] = 744,
		["subfmeoRR."] = 746,
		["addmeoRR."] = 266,
		["addRRR."] = 522,
		["addcoRRR."] = 520,
		["subfcoRRR."] = 827,
		["sradiRR~H."] = 122,
		["popcntbRR~"] = 512,
		mcrxrX = 186,
		["prtydRR~"] = 1014,
		["dcbz-R0R"] = 508,
		[144] = {
			[0] = "mask",
			1,
			["mtcrfRZ~"] = "mtocrfRZ~",
			shift = 20
		},
		[19] = {
			[0] = "mask",
			1,
			mfcrR = "mfocrfRZ",
			shift = 20
		},
		[371] = {
			[424] = "mftbuR",
			[392] = "mftbR",
			shift = 11,
			mask = 1023
		},
		[339] = {
			[32] = "mferR",
			[16] = "mfspefscrR",
			[256] = "mflrR",
			mask = 1023,
			[288] = "mfctrR",
			shift = 11
		},
		[467] = {
			[32] = "mtxerR",
			[16] = "mtspefscrR",
			[256] = "mtlrR",
			mask = 1023,
			[288] = "mtctrR",
			shift = 11
		},
		[598] = {
			[0] = 21,
			"mask",
			3,
			sync = "lwsync",
			ptesync = "shift"
		}
	}, {
		__index = function(arg_2_0, arg_2_1)
			if var_0_8(arg_2_1, 31) == 15 then
				return "iselRRRC"
			end

			return
		end
	}),
	"lwzRRD",
	"lwzuRRD",
	"lbzRRD",
	"lbzuRRD",
	"stwRRD",
	"stwuRRD",
	"stbRRD",
	"stbuRRD",
	"lhzRRD",
	"lhzuRRD",
	"lhaRRD",
	"lhauRRD",
	"sthRRD",
	"sthuRRD",
	"lmwRRD",
	"stmwRRD",
	"lfsFRD",
	"lfsuFRD",
	"lfdFRD",
	"lfduFRD",
	"stfsFRD",
	"stfsuFRD",
	"stfdFRD",
	"stfduFRD",
	false,
	false,
	{
		[0] = 0,
		"mask",
		3,
		ldRRE = "lduRRE",
		lwaRRE = "shift"
	},
	{
		{
			[0] = "fsubsFFF.",
			"faddsFFF.",
			"fsqrtsF-F.",
			false,
			"fresF-F.",
			"fmulsFF-F.",
			"frsqrtesF-F.",
			false,
			"fmsubsFFFF~.",
			"fmaddsFFFF~.",
			"fnmsubsFFFF~.",
			"fnmaddsFFFF~.",
			"shift",
			1,
			"mask",
			15,
			[false] = false,
			["fdivsFFF."] = false
		},
		shift = 5,
		mask = 1
	},
	false,
	false,
	{
		[0] = "mask",
		3,
		stdRRE = "stduRRE",
		shift = 0
	},
	{
		[0] = {
			[0] = 456,
			"fripF-F.",
			488,
			"frimF-F.",
			814,
			"fctidF-F.",
			136,
			"fnabsF-F.",
			64,
			"mcrfsXX",
			134,
			"mtfsfiA>>-A>",
			72,
			"fmrF-F.",
			"shift",
			1,
			fcmpuXFF = nil,
			[nil] = nil,
			[nil] = nil,
			[nil] = nil,
			["fcpsgnFFF."] = nil,
			[nil] = nil,
			["frspF-F."] = nil,
			["fctiwF-F."] = "fctiwzF-F.",
			[38] = "mtfsb1A.",
			[264] = "fabsF-F.",
			[711] = "mtfsfZF.",
			[583] = "mffsF.",
			[40] = "fnegF-F.",
			[846] = "fcfidF-F.",
			[815] = "fctidzF-F.",
			[70] = "mtfsb0A.",
			[32] = "fcmpoXFF",
			[392] = "frinF-F.",
			[424] = "frizF-F.",
			mask = 1023
		},
		{
			[0] = "fsubFFF.",
			"faddFFF.",
			"fsqrtF-F.",
			"fselFFFF~.",
			"freF-F.",
			"fmulFF-F.",
			"frsqrteF-F.",
			false,
			"fmsubFFFF~.",
			"fmaddFFFF~.",
			"fnmsubFFFF~.",
			"fnmaddFFFF~.",
			"shift",
			1,
			"mask",
			15,
			[false] = false,
			["fdivFFF."] = false
		},
		shift = 5,
		mask = 1
	}
}
local var_0_15 = {
	[0] = "r0",
	"sp",
	"r2",
	"r3",
	"r4",
	"r5",
	"r6",
	"r7",
	"r8",
	"r9",
	"r10",
	"r11",
	"r12",
	"r13",
	"r14",
	"r15",
	"r16",
	"r17",
	"r18",
	"r19",
	"r20",
	"r21",
	"r22",
	"r23",
	"r24",
	"r25",
	"r26",
	"r27",
	"r28",
	"r29",
	"r30",
	"r31"
}
local var_0_16 = {
	[0] = "lt",
	"gt",
	"eq",
	"so",
	"ge",
	"le",
	"ne",
	"ns"
}

local function var_0_17(arg_3_0)
	if arg_3_0 <= 3 then
		return var_0_16[var_0_8(arg_3_0, 3)]
	else
		return var_0_2("4*cr%d+%s", var_0_12(arg_3_0, 2), var_0_16[var_0_8(arg_3_0, 3)])
	end

	return
end

local function var_0_18(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ""

	if arg_4_0.rel then
		if arg_4_0.symtab[arg_4_0.rel] then
			var_4_0 = "\t->" .. arg_4_0.symtab[arg_4_0.rel]
		end
	end

	if arg_4_0.hexdump > 0 then
		arg_4_0.out(var_0_2("%08x  %s  %-7s %s%s\n", arg_4_0.addr + arg_4_0.pos, var_0_10(arg_4_0.op), arg_4_1, var_0_6(arg_4_2, ", "), var_4_0))
	else
		arg_4_0.out(var_0_2("%08x  %-7s %s%s\n", arg_4_0.addr + arg_4_0.pos, arg_4_1, var_0_6(arg_4_2, ", "), var_4_0))
	end

	arg_4_0.pos = arg_4_0.pos + 4

	return
end

local function var_0_19(arg_5_0)
	return var_0_18(arg_5_0, ".long", {
		"0x" .. var_0_10(arg_5_0.op)
	})
end

local function var_0_20(arg_6_0)
	local var_6_0, var_6_1, var_6_2, var_6_3 = var_0_1(arg_6_0.code, arg_6_0.pos + 1, arg_6_0.pos + 4)
	local var_6_4 = var_0_9(var_0_11(var_6_0, 24), var_0_11(var_6_1, 16), var_0_11(var_6_2, 8), var_6_3)
	local var_6_5 = {}
	local var_6_6
	local var_6_7 = 21

	arg_6_0.op = var_6_4
	arg_6_0.rel = nil

	local var_6_8 = var_0_14[var_0_12(var_6_0, 2)]

	while var_0_0(var_6_8) ~= "string" do
		if not var_6_8 then
			return var_0_19(arg_6_0)
		end

		var_6_8 = var_6_8[var_0_8(var_0_12(var_6_4, var_6_8.shift), var_6_8.mask)]
	end

	local var_6_9, var_6_10 = var_0_3(var_6_8, "^([a-z0-9_.]*)(.*)")
	local var_6_11, var_6_12 = var_0_3(var_6_10, "|([a-z0-9_.]*)(.*)")

	if var_6_11 then
		var_6_10 = var_6_12
	end

	for iter_6_0 in var_0_4(var_6_10, ".") do
		local var_6_13

		if iter_6_0 == "R" then
			var_6_13 = var_0_15[var_0_8(var_0_12(var_6_4, var_6_7), 31)]
			var_6_7 = var_6_7 - 5
		elseif iter_6_0 == "F" then
			var_6_13 = "f" .. var_0_8(var_0_12(var_6_4, var_6_7), 31)
			var_6_7 = var_6_7 - 5
		elseif iter_6_0 == "A" then
			var_6_13 = var_0_8(var_0_12(var_6_4, var_6_7), 31)
			var_6_7 = var_6_7 - 5
		elseif iter_6_0 == "S" then
			var_6_13 = var_0_13(var_0_11(var_6_4, 27 - var_6_7), 27)
			var_6_7 = var_6_7 - 5
		elseif iter_6_0 == "I" then
			var_6_13 = var_0_13(var_0_11(var_6_4, 16), 16)
		elseif iter_6_0 == "U" then
			var_6_13 = var_0_8(var_6_4, 65535)
		elseif iter_6_0 == "D" or iter_6_0 == "E" then
			local var_6_14 = var_0_13(var_0_11(var_6_4, 16), 16)

			if iter_6_0 == "E" then
				var_6_14 = var_0_8(var_6_14, -4)
			end

			if var_6_6 == "r0" then
				var_6_6 = "0"
			end

			var_6_5[#var_6_5] = var_0_2("%d(%s)", var_6_14, var_6_6)
		elseif iter_6_0 >= "2" and iter_6_0 <= "8" then
			if var_6_6 == "r0" then
				var_6_6 = "0"
			end

			var_6_5[#var_6_5] = var_0_2("%d(%s)", var_0_8(var_0_12(var_6_4, var_6_7), 31) * iter_6_0, var_6_6)
		elseif iter_6_0 == "H" then
			var_6_13 = var_0_8(var_0_12(var_6_4, var_6_7), 31) + var_0_11(var_0_8(var_6_4, 2), 4)
			var_6_7 = var_6_7 - 5
		elseif iter_6_0 == "M" then
			var_6_13 = var_0_8(var_0_12(var_6_4, var_6_7), 31) + var_0_8(var_6_4, 32)
		elseif iter_6_0 == "C" then
			var_6_13 = var_0_17(var_0_8(var_0_12(var_6_4, var_6_7), 31))
			var_6_7 = var_6_7 - 5
		elseif iter_6_0 == "B" then
			local var_6_15 = var_0_12(var_6_4, 21)
			local var_6_16 = var_0_8(var_0_12(var_6_4, 16), 31)
			local var_6_17 = ""

			var_6_7 = var_6_7 - 10

			if var_0_8(var_6_15, 4) == 0 then
				var_6_17 = var_0_8(var_6_15, 2) == 0 and "dnz" or "dz"

				if var_0_8(var_6_15, 16) == 0 then
					var_6_17 = var_6_17 .. (var_0_8(var_6_15, 8) == 0 and "f" or "t")
				end

				if var_0_8(var_6_15, 16) == 0 then
					var_6_13 = var_0_17(var_6_16)
				end

				var_6_9 = var_6_9 .. (var_0_8(var_6_15, 1) == var_0_8(var_0_12(var_6_4, 15), 1) and "-" or "+")
			elseif var_0_8(var_6_15, 16) == 0 then
				var_6_17 = var_0_16[var_0_8(var_6_16, 3) + (var_0_8(var_6_15, 8) == 0 and 4 or 0)]

				if var_6_16 > 3 then
					var_6_13 = "cr" .. var_0_12(var_6_16, 2)
				end

				var_6_9 = var_6_9 .. (var_0_8(var_6_15, 1) == var_0_8(var_0_12(var_6_4, 15), 1) and "-" or "+")
			end

			var_6_9 = var_0_5(var_6_9, "_", var_6_17)
		elseif iter_6_0 == "J" then
			var_6_13 = var_0_13(var_0_11(var_6_4, 27 - var_6_7), 29 - var_6_7) * 4

			if var_0_8(var_6_4, 2) == 0 then
				var_6_13 = arg_6_0.addr + arg_6_0.pos + var_6_13
			end

			arg_6_0.rel = var_6_13
			var_6_13 = "0x" .. var_0_10(var_6_13)
		elseif iter_6_0 == "K" then
			if var_0_8(var_6_4, 1) ~= 0 then
				var_6_9 = var_6_9 .. "l"
			end

			if var_0_8(var_6_4, 2) ~= 0 then
				var_6_9 = var_6_9 .. "a"
			end
		elseif iter_6_0 == "X" or iter_6_0 == "Y" then
			var_6_13 = var_0_8(var_0_12(var_6_4, var_6_7 + 2), 7)
			var_6_13 = (var_6_13 ~= 0 or iter_6_0 ~= "Y" or nil) and "cr" .. var_6_13
			var_6_7 = var_6_7 - 5
		elseif iter_6_0 == "W" then
			var_6_13 = "cr" .. var_0_8(var_6_4, 7)
		elseif iter_6_0 == "Z" then
			var_6_13 = var_0_8(var_0_12(var_6_4, var_6_7 - 4), 255)
			var_6_7 = var_6_7 - 10
		elseif iter_6_0 == ">" then
			var_6_5[#var_6_5] = var_0_12(var_6_5[#var_6_5], 1)
		elseif iter_6_0 == "0" then
			if var_6_6 == "r0" then
				var_6_5[#var_6_5] = nil

				if var_6_11 then
					var_6_9 = var_6_11
				end
			end
		elseif iter_6_0 == "L" then
			var_6_9 = var_0_5(var_6_9, "_", var_0_8(var_6_4, 0) ~= 0 and "d" or "w")
		elseif iter_6_0 == "." then
			if var_0_8(var_6_4, 1) == 1 then
				var_6_9 = var_6_9 .. "."
			end
		elseif iter_6_0 == "N" then
			if var_6_4 == 0 then
				var_6_9 = "nop"

				break
			end
		elseif iter_6_0 == "~" then
			var_6_5[#var_6_5] = var_6_5[#var_6_5 - 1]
			var_6_5[#var_6_5 - 1] = var_6_5[#var_6_5]
		elseif iter_6_0 == "=" then
			if var_6_6 == var_6_5[#var_6_5 - 1] then
				var_6_5[#var_6_5] = nil
				var_6_9 = var_6_11
			end
		elseif iter_6_0 == "%" then
			if var_6_6 == var_6_5[#var_6_5 - 1] and var_6_6 == var_6_5[#var_6_5 - 2] then
				var_6_5[#var_6_5] = nil
				var_6_5[#var_6_5 - 1] = nil
				var_6_9 = var_6_11
			end
		elseif iter_6_0 == "-" then
			var_6_7 = var_6_7 - 5
		else
			assert(false)
		end

		if var_6_13 then
			var_6_5[#var_6_5 + 1] = var_6_13
			var_6_6 = var_6_13
		end
	end

	return var_0_18(arg_6_0, var_6_9, var_6_5)
end

local function var_0_21(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or 0

	local var_7_0

	if arg_7_2 then
		var_7_0 = arg_7_1 + arg_7_2 or #arg_7_0.code
	end

	arg_7_0.pos = arg_7_1 - arg_7_1 % 4
	arg_7_0.rel = nil

	while var_7_0 - var_7_0 % 4 > arg_7_0.pos do
		var_0_20(arg_7_0)
	end

	return
end

local function var_0_22(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		code = arg_8_0,
		addr = arg_8_1 or 0,
		out = arg_8_2 or io.write,
		symtab = {},
		disass = var_0_21
	}

	var_8_0.hexdump = 8

	return var_8_0
end

return {
	create = var_0_22,
	disass = function(arg_9_0, arg_9_1, arg_9_2)
		var_0_22(arg_9_0, arg_9_1, arg_9_2):disass()

		return
	end,
	regname = function(arg_10_0)
		if arg_10_0 < 32 then
			return var_0_15[arg_10_0]
		end

		return "f" .. arg_10_0 - 32
	end
}
