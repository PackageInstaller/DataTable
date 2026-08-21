local var_0_0 = type
local var_0_1 = string.sub
local var_0_2 = string.byte
local var_0_3 = string.format
local var_0_4 = string.match
local var_0_5 = string.gmatch
local var_0_6 = string.gsub
local var_0_7 = string.lower
local var_0_8 = string.rep
local var_0_9 = require("bit").tohex
local var_0_10 = {
	[0] = "addBmr",
	"addVmr",
	"addBrm",
	"addVrm",
	"addBai",
	"addVai",
	"push es",
	"pop es",
	"orBmr",
	"orVmr",
	"orBrm",
	"orVrm",
	"orBai",
	"orVai",
	"push cs",
	"opc2*",
	"adcBmr",
	"adcVmr",
	"adcBrm",
	"adcVrm",
	"adcBai",
	"adcVai",
	"push ss",
	"pop ss",
	"sbbBmr",
	"sbbVmr",
	"sbbBrm",
	"sbbVrm",
	"sbbBai",
	"sbbVai",
	"push ds",
	"pop ds",
	"andBmr",
	"andVmr",
	"andBrm",
	"andVrm",
	"andBai",
	"andVai",
	"es:seg",
	"daa",
	"subBmr",
	"subVmr",
	"subBrm",
	"subVrm",
	"subBai",
	"subVai",
	"cs:seg",
	"das",
	"xorBmr",
	"xorVmr",
	"xorBrm",
	"xorVrm",
	"xorBai",
	"xorVai",
	"ss:seg",
	"aaa",
	"cmpBmr",
	"cmpVmr",
	"cmpBrm",
	"cmpVrm",
	"cmpBai",
	"cmpVai",
	"ds:seg",
	"aas",
	"incVR",
	"incVR",
	"incVR",
	"incVR",
	"incVR",
	"incVR",
	"incVR",
	"incVR",
	"decVR",
	"decVR",
	"decVR",
	"decVR",
	"decVR",
	"decVR",
	"decVR",
	"decVR",
	"pushUR",
	"pushUR",
	"pushUR",
	"pushUR",
	"pushUR",
	"pushUR",
	"pushUR",
	"pushUR",
	"popUR",
	"popUR",
	"popUR",
	"popUR",
	"popUR",
	"popUR",
	"popUR",
	"popUR",
	"sz*pushaw,pusha",
	"sz*popaw,popa",
	"boundVrm",
	"arplWmr",
	"fs:seg",
	"gs:seg",
	"o16:",
	"a16",
	"pushUi",
	"imulVrmi",
	"pushBs",
	"imulVrms",
	"insb",
	"insVS",
	"outsb",
	"outsVS",
	"joBj",
	"jnoBj",
	"jbBj",
	"jnbBj",
	"jzBj",
	"jnzBj",
	"jbeBj",
	"jaBj",
	"jsBj",
	"jnsBj",
	"jpeBj",
	"jpoBj",
	"jlBj",
	"jgeBj",
	"jleBj",
	"jgBj",
	"arith!Bmi",
	"arith!Vmi",
	"arith!Bmi",
	"arith!Vms",
	"testBmr",
	"testVmr",
	"xchgBrm",
	"xchgVrm",
	"movBmr",
	"movVmr",
	"movBrm",
	"movVrm",
	"movVmg",
	"leaVrm",
	"movWgm",
	"popUm",
	"nop*xchgVaR|pause|xchgWaR|repne nop",
	"xchgVaR",
	"xchgVaR",
	"xchgVaR",
	"xchgVaR",
	"xchgVaR",
	"xchgVaR",
	"xchgVaR",
	"sz*cbw,cwde,cdqe",
	"sz*cwd,cdq,cqo",
	"call farViw",
	"wait",
	"sz*pushfw,pushf",
	"sz*popfw,popf",
	"sahf",
	"lahf",
	"movBao",
	"movVao",
	"movBoa",
	"movVoa",
	"movsb",
	"movsVS",
	"cmpsb",
	"cmpsVS",
	"testBai",
	"testVai",
	"stosb",
	"stosVS",
	"lodsb",
	"lodsVS",
	"scasb",
	"scasVS",
	"movBRi",
	"movBRi",
	"movBRi",
	"movBRi",
	"movBRi",
	"movBRi",
	"movBRi",
	"movBRi",
	"movVRI",
	"movVRI",
	"movVRI",
	"movVRI",
	"movVRI",
	"movVRI",
	"movVRI",
	"movVRI",
	"shift!Bmu",
	"shift!Vmu",
	"retBw",
	"ret",
	"vex*3$lesVrm",
	"vex*2$ldsVrm",
	"movBmi",
	"movVmi",
	"enterBwu",
	"leave",
	"retfBw",
	"retf",
	"int3",
	"intBu",
	"into",
	"iretVS",
	"shift!Bm1",
	"shift!Vm1",
	"shift!Bmc",
	"shift!Vmc",
	"aamBu",
	"aadBu",
	"salc",
	"xlatb",
	"fp*0",
	"fp*1",
	"fp*2",
	"fp*3",
	"fp*4",
	"fp*5",
	"fp*6",
	"fp*7",
	"loopneBj",
	"loopeBj",
	"loopBj",
	"sz*jcxzBj,jecxzBj,jrcxzBj",
	"inBau",
	"inVau",
	"outBua",
	"outVua",
	"callVj",
	"jmpVj",
	"jmp farViw",
	"jmpBj",
	"inBad",
	"inVad",
	"outBda",
	"outVda",
	"lock:",
	"int1",
	"repne:rep",
	"rep:",
	"hlt",
	"cmc",
	"testb!Bm",
	"testv!Vm",
	"clc",
	"stc",
	"cli",
	"sti",
	"cld",
	"std",
	"incb!Bm",
	"incd!Vm"
}

assert(#var_0_10 == 255)

local var_0_11 = setmetatable({
	[96] = false,
	[7] = false,
	[39] = false,
	[66] = "rex*x",
	[22] = false,
	[97] = false,
	[31] = false,
	[69] = "rex*rb",
	[103] = "a32:",
	[206] = false,
	[130] = false,
	[68] = "rex*r",
	[154] = false,
	[30] = false,
	[197] = "vex*2",
	[71] = "rex*rxb",
	[6] = false,
	[23] = false,
	[70] = "rex*rx",
	[74] = "rex*wx",
	[196] = "vex*3",
	[75] = "rex*wxb",
	[72] = "rex*w",
	[14] = false,
	[73] = "rex*wb",
	[78] = "rex*wrx",
	[79] = "rex*wrxb",
	[47] = false,
	[76] = "rex*wr",
	[55] = false,
	[77] = "rex*wrb",
	[63] = false,
	[214] = false,
	[212] = false,
	[65] = "rex*b",
	[213] = false,
	[98] = false,
	[64] = "rex*",
	[234] = false,
	[99] = "movsxdVrDmt",
	[67] = "rex*xb"
}, {
	__index = var_0_10
})
local var_0_12 = {
	[0] = "sldt!Dmp",
	"sgdt!Ump",
	"larVrm",
	"lslVrm",
	nil,
	"syscall",
	"clts",
	"sysret",
	"invd",
	"wbinvd",
	nil,
	"ud1",
	nil,
	"$prefetch!Bm",
	"femms",
	"3dnowMrmu",
	"movupsXrm|movssXrvm|movupdXrm|movsdXrvm",
	"movupsXmr|movssXmvr|movupdXmr|movsdXmvr",
	"movhlpsXrm$movlpsXrm|movsldupXrm|movlpdXrm|movddupXrm",
	"movlpsXmr||movlpdXmr",
	"unpcklpsXrvm||unpcklpdXrvm",
	"unpckhpsXrvm||unpckhpdXrvm",
	"movlhpsXrm$movhpsXrm|movshdupXrm|movhpdXrm",
	"movhpsXmr||movhpdXmr",
	"$prefetcht!Bm",
	"hintnopVm",
	"hintnopVm",
	"hintnopVm",
	"hintnopVm",
	"hintnopVm",
	"hintnopVm",
	"hintnopVm",
	"movUmx$",
	"movUmy$",
	"movUxm$",
	"movUym$",
	"movUmz$",
	nil,
	"movUzm$",
	nil,
	"movapsXrm||movapdXrm",
	"movapsXmr||movapdXmr",
	"cvtpi2psXrMm|cvtsi2ssXrvVmt|cvtpi2pdXrMm|cvtsi2sdXrvVmt",
	"movntpsXmr|movntssXmr|movntpdXmr|movntsdXmr",
	"cvttps2piMrXm|cvttss2siVrXm|cvttpd2piMrXm|cvttsd2siVrXm",
	"cvtps2piMrXm|cvtss2siVrXm|cvtpd2piMrXm|cvtsd2siVrXm",
	"ucomissXrm||ucomisdXrm",
	"comissXrm||comisdXrm",
	"wrmsr",
	"rdtsc",
	"rdmsr",
	"rdpmc",
	"sysenter",
	"sysexit",
	nil,
	"getsec",
	"opc3*38",
	nil,
	"opc3*3a",
	nil,
	nil,
	nil,
	nil,
	nil,
	"cmovoVrm",
	"cmovnoVrm",
	"cmovbVrm",
	"cmovnbVrm",
	"cmovzVrm",
	"cmovnzVrm",
	"cmovbeVrm",
	"cmovaVrm",
	"cmovsVrm",
	"cmovnsVrm",
	"cmovpeVrm",
	"cmovpoVrm",
	"cmovlVrm",
	"cmovgeVrm",
	"cmovleVrm",
	"cmovgVrm",
	"movmskpsVrXm$||movmskpdVrXm$",
	"sqrtpsXrm|sqrtssXrm|sqrtpdXrm|sqrtsdXrm",
	"rsqrtpsXrm|rsqrtssXrvm",
	"rcppsXrm|rcpssXrvm",
	"andpsXrvm||andpdXrvm",
	"andnpsXrvm||andnpdXrvm",
	"orpsXrvm||orpdXrvm",
	"xorpsXrvm||xorpdXrvm",
	"addpsXrvm|addssXrvm|addpdXrvm|addsdXrvm",
	"mulpsXrvm|mulssXrvm|mulpdXrvm|mulsdXrvm",
	"cvtps2pdXrm|cvtss2sdXrvm|cvtpd2psXrm|cvtsd2ssXrvm",
	"cvtdq2psXrm|cvttps2dqXrm|cvtps2dqXrm",
	"subpsXrvm|subssXrvm|subpdXrvm|subsdXrvm",
	"minpsXrvm|minssXrvm|minpdXrvm|minsdXrvm",
	"divpsXrvm|divssXrvm|divpdXrvm|divsdXrvm",
	"maxpsXrvm|maxssXrvm|maxpdXrvm|maxsdXrvm",
	"punpcklbwPrvm",
	"punpcklwdPrvm",
	"punpckldqPrvm",
	"packsswbPrvm",
	"pcmpgtbPrvm",
	"pcmpgtwPrvm",
	"pcmpgtdPrvm",
	"packuswbPrvm",
	"punpckhbwPrvm",
	"punpckhwdPrvm",
	"punpckhdqPrvm",
	"packssdwPrvm",
	"||punpcklqdqXrvm",
	"||punpckhqdqXrvm",
	"movPrVSm",
	"movqMrm|movdquXrm|movdqaXrm",
	"pshufwMrmu|pshufhwXrmu|pshufdXrmu|pshuflwXrmu",
	"pshiftw!Pvmu",
	"pshiftd!Pvmu",
	"pshiftq!Mvmu||pshiftdq!Xvmu",
	"pcmpeqbPrvm",
	"pcmpeqwPrvm",
	"pcmpeqdPrvm",
	"emms*|",
	"vmreadUmr||extrqXmuu$|insertqXrmuu$",
	"vmwriteUrm||extrqXrm$|insertqXrm$",
	nil,
	nil,
	"||haddpdXrvm|haddpsXrvm",
	"||hsubpdXrvm|hsubpsXrvm",
	"movVSmMr|movqXrm|movVSmXr",
	"movqMmr|movdquXmr|movdqaXmr",
	"joVj",
	"jnoVj",
	"jbVj",
	"jnbVj",
	"jzVj",
	"jnzVj",
	"jbeVj",
	"jaVj",
	"jsVj",
	"jnsVj",
	"jpeVj",
	"jpoVj",
	"jlVj",
	"jgeVj",
	"jleVj",
	"jgVj",
	"setoBm",
	"setnoBm",
	"setbBm",
	"setnbBm",
	"setzBm",
	"setnzBm",
	"setbeBm",
	"setaBm",
	"setsBm",
	"setnsBm",
	"setpeBm",
	"setpoBm",
	"setlBm",
	"setgeBm",
	"setleBm",
	"setgBm",
	"push fs",
	"pop fs",
	"cpuid",
	"btVmr",
	"shldVmru",
	"shldVmrc",
	nil,
	nil,
	"push gs",
	"pop gs",
	"rsm",
	"btsVmr",
	"shrdVmru",
	"shrdVmrc",
	"fxsave!Dmp",
	"imulVrm",
	"cmpxchgBmr",
	"cmpxchgVmr",
	"$lssVrm",
	"btrVmr",
	"$lfsVrm",
	"$lgsVrm",
	"movzxVrBmt",
	"movzxVrWmt",
	"|popcntVrm",
	"ud2Dp",
	"bt!Vmu",
	"btcVmr",
	"bsfVrm",
	"bsrVrm|lzcntVrm|bsrWrm",
	"movsxVrBmt",
	"movsxVrWmt",
	"xaddBmr",
	"xaddVmr",
	"cmppsXrvmu|cmpssXrvmu|cmppdXrvmu|cmpsdXrvmu",
	"$movntiVmr|",
	"pinsrwPrvWmu",
	"pextrwDrPmu",
	"shufpsXrvmu||shufpdXrvmu",
	"$cmpxchg!Qmp",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"||addsubpdXrvm|addsubpsXrvm",
	"psrlwPrvm",
	"psrldPrvm",
	"psrlqPrvm",
	"paddqPrvm",
	"pmullwPrvm",
	"|movq2dqXrMm|movqXmr|movdq2qMrXm$",
	"pmovmskbVrMm||pmovmskbVrXm",
	"psubusbPrvm",
	"psubuswPrvm",
	"pminubPrvm",
	"pandPrvm",
	"paddusbPrvm",
	"padduswPrvm",
	"pmaxubPrvm",
	"pandnPrvm",
	"pavgbPrvm",
	"psrawPrvm",
	"psradPrvm",
	"pavgwPrvm",
	"pmulhuwPrvm",
	"pmulhwPrvm",
	"|cvtdq2pdXrm|cvttpd2dqXrm|cvtpd2dqXrm",
	"$movntqMmr||$movntdqXmr",
	"psubsbPrvm",
	"psubswPrvm",
	"pminswPrvm",
	"porPrvm",
	"paddsbPrvm",
	"paddswPrvm",
	"pmaxswPrvm",
	"pxorPrvm",
	"|||lddquXrm",
	"psllwPrvm",
	"pslldPrvm",
	"psllqPrvm",
	"pmuludqPrvm",
	"pmaddwdPrvm",
	"psadbwPrvm",
	"maskmovqMrm||maskmovdquXrm$",
	"psubbPrvm",
	"psubwPrvm",
	"psubdPrvm",
	"psubqPrvm",
	"paddbPrvm",
	"paddwPrvm",
	"padddPrvm",
	"ud"
}

assert(var_0_12[255] == "ud")

local var_0_13 = {
	["38"] = {
		[0] = "pshufbPrvm",
		"phaddwPrvm",
		"phadddPrvm",
		"phaddswPrvm",
		"pmaddubswPrvm",
		"phsubwPrvm",
		"phsubdPrvm",
		"phsubswPrvm",
		"psignbPrvm",
		"psignwPrvm",
		"psigndPrvm",
		"pmulhrswPrvm",
		"||permilpsXrvm",
		"||permilpdXrvm",
		nil,
		nil,
		"||pblendvbXrma",
		nil,
		nil,
		nil,
		"||blendvpsXrma",
		"||blendvpdXrma",
		"||permpsXrvm",
		"||ptestXrm",
		"||broadcastssXrm",
		"||broadcastsdXrm",
		"||broadcastf128XrlXm",
		nil,
		"pabsbPrm",
		"pabswPrm",
		"pabsdPrm",
		nil,
		"||pmovsxbwXrm",
		"||pmovsxbdXrm",
		"||pmovsxbqXrm",
		"||pmovsxwdXrm",
		"||pmovsxwqXrm",
		"||pmovsxdqXrm",
		nil,
		nil,
		"||pmuldqXrvm",
		"||pcmpeqqXrvm",
		"||$movntdqaXrm",
		"||packusdwXrvm",
		"||maskmovpsXrvm",
		"||maskmovpdXrvm",
		"||maskmovpsXmvr",
		"||maskmovpdXmvr",
		"||pmovzxbwXrm",
		"||pmovzxbdXrm",
		"||pmovzxbqXrm",
		"||pmovzxwdXrm",
		"||pmovzxwqXrm",
		"||pmovzxdqXrm",
		"||permdXrvm",
		"||pcmpgtqXrvm",
		"||pminsbXrvm",
		"||pminsdXrvm",
		"||pminuwXrvm",
		"||pminudXrvm",
		"||pmaxsbXrvm",
		"||pmaxsdXrvm",
		"||pmaxuwXrvm",
		"||pmaxudXrvm",
		"||pmulddXrvm",
		"||phminposuwXrm",
		nil,
		nil,
		nil,
		"||psrlvVSXrvm",
		"||psravdXrvm",
		"||psllvVSXrvm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||pbroadcastdXrlXm",
		"||pbroadcastqXrlXm",
		"||broadcasti128XrlXm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||pbroadcastbXrlXm",
		"||pbroadcastwXrlXm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||pmaskmovXrvVSm",
		nil,
		"||pmaskmovVSmXvr",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||fmaddsub132pHXrvm",
		"||fmsubadd132pHXrvm",
		"||fmadd132pHXrvm",
		"||fmadd132sHXrvm",
		"||fmsub132pHXrvm",
		"||fmsub132sHXrvm",
		"||fnmadd132pHXrvm",
		"||fnmadd132sHXrvm",
		"||fnmsub132pHXrvm",
		"||fnmsub132sHXrvm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||fmaddsub213pHXrvm",
		"||fmsubadd213pHXrvm",
		"||fmadd213pHXrvm",
		"||fmadd213sHXrvm",
		"||fmsub213pHXrvm",
		"||fmsub213sHXrvm",
		"||fnmadd213pHXrvm",
		"||fnmadd213sHXrvm",
		"||fnmsub213pHXrvm",
		"||fnmsub213sHXrvm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||fmaddsub231pHXrvm",
		"||fmsubadd231pHXrvm",
		"||fmadd231pHXrvm",
		"||fmadd231sHXrvm",
		"||fmsub231pHXrvm",
		"||fmsub231sHXrvm",
		"||fnmadd231pHXrvm",
		"||fnmadd231sHXrvm",
		"||fnmsub231pHXrvm",
		"||fnmsub231sHXrvm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||aesencXrvm",
		"||aesenclastXrvm",
		"||aesdecXrvm",
		"||aesdeclastXrvm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"|||crc32TrBmt",
		"|||crc32TrVmt",
		nil,
		nil,
		nil,
		nil,
		nil,
		"| sarxVrmv| shlxVrmv| shrxVrmv"
	},
	["3a"] = {
		[0] = "||permqXrmu",
		"||permpdXrmu",
		"||pblenddXrvmu",
		nil,
		"||permilpsXrmu",
		"||permilpdXrmu",
		"||perm2f128Xrvmu",
		nil,
		"||roundpsXrmu",
		"||roundpdXrmu",
		"||roundssXrvmu",
		"||roundsdXrvmu",
		"||blendpsXrvmu",
		"||blendpdXrvmu",
		"||pblendwXrvmu",
		"palignrPrvmu",
		nil,
		nil,
		nil,
		nil,
		"||pextrbVmXru",
		"||pextrwVmXru",
		"||pextrVmSXru",
		"||extractpsVmXru",
		"||insertf128XrvlXmu",
		"||extractf128XlXmYru",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||pinsrbXrvVmu",
		"||insertpsXrvmu",
		"||pinsrXrvVmuS",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||inserti128Xrvmu",
		"||extracti128XlXmYru",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||dppsXrvmu",
		"||dppdXrvmu",
		"||mpsadbwXrvmu",
		nil,
		"||pclmulqdqXrvmu",
		nil,
		"||perm2i128Xrvmu",
		nil,
		nil,
		nil,
		"||blendvpsXrvmb",
		"||blendvpdXrvmb",
		"||pblendvbXrvmb",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||pcmpestrmXrmu",
		"||pcmpestriXrmu",
		"||pcmpistrmXrmu",
		"||pcmpistriXrmu",
		[223] = "||aeskeygenassistXrmu",
		[240] = "||| rorxVrmu"
	}
}
local var_0_14 = {
	[217] = "vmmcall",
	[194] = "vmlaunch",
	[222] = "skinit",
	[201] = "mwait",
	[223] = "invlpga",
	[196] = "vmxoff",
	[220] = "stgi",
	[248] = "swapgs",
	[221] = "clgi",
	[249] = "rdtscp",
	[218] = "vmload",
	[193] = "vmcall",
	[219] = "vmsave",
	[200] = "monitor",
	[216] = "vmrun",
	[195] = "vmresume"
}
local var_0_15 = {
	[0] = "faddFm",
	"fmulFm",
	"fcomFm",
	"fcompFm",
	"fsubFm",
	"fsubrFm",
	"fdivFm",
	"fdivrFm",
	"fldFm",
	nil,
	"fstFm",
	"fstpFm",
	"fldenvVm",
	"fldcwWm",
	"fnstenvVm",
	"fnstcwWm",
	"fiaddDm",
	"fimulDm",
	"ficomDm",
	"ficompDm",
	"fisubDm",
	"fisubrDm",
	"fidivDm",
	"fidivrDm",
	"fildDm",
	"fisttpDm",
	"fistDm",
	"fistpDm",
	nil,
	"fld twordFmp",
	nil,
	"fstp twordFmp",
	"faddGm",
	"fmulGm",
	"fcomGm",
	"fcompGm",
	"fsubGm",
	"fsubrGm",
	"fdivGm",
	"fdivrGm",
	"fldGm",
	"fisttpQm",
	"fstGm",
	"fstpGm",
	"frstorDmp",
	nil,
	"fnsaveDmp",
	"fnstswWm",
	"fiaddWm",
	"fimulWm",
	"ficomWm",
	"ficompWm",
	"fisubWm",
	"fisubrWm",
	"fidivWm",
	"fidivrWm",
	"fildWm",
	"fisttpWm",
	"fistWm",
	"fistpWm",
	"fbld twordFmp",
	"fildQm",
	"fbstp twordFmp",
	"fistpQm",
	"faddFf",
	"fmulFf",
	"fcomFf",
	"fcompFf",
	"fsubFf",
	"fsubrFf",
	"fdivFf",
	"fdivrFf",
	"fldFf",
	"fxchFf",
	{
		"fnop"
	},
	nil,
	{
		"fchs",
		"fabs",
		nil,
		nil,
		"ftst",
		"fxam"
	},
	{
		"fld1",
		"fldl2t",
		"fldl2e",
		"fldpi",
		"fldlg2",
		"fldln2",
		"fldz"
	},
	{
		"f2xm1",
		"fyl2x",
		"fptan",
		"fpatan",
		"fxtract",
		"fprem1",
		"fdecstp",
		"fincstp"
	},
	{
		"fprem",
		"fyl2xp1",
		"fsqrt",
		"fsincos",
		"frndint",
		"fscale",
		"fsin",
		"fcos"
	},
	"fcmovbFf",
	"fcmoveFf",
	"fcmovbeFf",
	"fcmovuFf",
	nil,
	{
		nil,
		"fucompp"
	},
	nil,
	nil,
	"fcmovnbFf",
	"fcmovneFf",
	"fcmovnbeFf",
	"fcmovnuFf",
	{
		nil,
		nil,
		"fnclex",
		"fninit"
	},
	"fucomiFf",
	"fcomiFf",
	nil,
	"fadd toFf",
	"fmul toFf",
	nil,
	nil,
	"fsub toFf",
	"fsubr toFf",
	"fdivr toFf",
	"fdiv toFf",
	"ffreeFf",
	nil,
	"fstFf",
	"fstpFf",
	"fucomFf",
	"fucompFf",
	nil,
	nil,
	"faddpFf",
	"fmulpFf",
	nil,
	{
		nil,
		"fcompp"
	},
	"fsubrpFf",
	"fsubpFf",
	"fdivrpFf",
	"fdivpFf",
	nil,
	nil,
	nil,
	nil,
	{
		"fnstsw ax"
	},
	"fucomipFf",
	"fcomipFf"
}

assert(var_0_15[126] == "fcomipFf")

local var_0_16 = {
	arith = {
		"add",
		"or",
		"adc",
		"sbb",
		"and",
		"sub",
		"xor",
		"cmp"
	},
	shift = {
		"rol",
		"ror",
		"rcl",
		"rcr",
		"shl",
		"shr",
		"sal",
		"sar"
	},
	testb = {
		"testBmi",
		"testBmi",
		"not",
		"neg",
		"mul",
		"imul",
		"div",
		"idiv"
	},
	testv = {
		"testVmi",
		"testVmi",
		"not",
		"neg",
		"mul",
		"imul",
		"div",
		"idiv"
	},
	incb = {
		"inc",
		"dec"
	},
	incd = {
		"inc",
		"dec",
		"callUmp",
		"$call farDmp",
		"jmpUmp",
		"$jmp farDmp",
		"pushUm"
	},
	sldt = {
		"sldt",
		"str",
		"lldt",
		"ltr",
		"verr",
		"verw"
	},
	sgdt = {
		"vm*$sgdt",
		"vm*$sidt",
		"$lgdt",
		"vm*$lidt",
		"smsw",
		nil,
		"lmsw",
		"vm*$invlpg"
	},
	bt = {
		nil,
		nil,
		nil,
		nil,
		"bt",
		"bts",
		"btr",
		"btc"
	},
	cmpxchg = {
		nil,
		"sz*,cmpxchg8bQmp,cmpxchg16bXmp",
		nil,
		nil,
		nil,
		nil,
		"vmptrld|vmxon|vmclear",
		"vmptrst"
	},
	pshiftw = {
		nil,
		nil,
		"psrlw",
		nil,
		"psraw",
		nil,
		"psllw"
	},
	pshiftd = {
		nil,
		nil,
		"psrld",
		nil,
		"psrad",
		nil,
		"pslld"
	},
	pshiftq = {
		nil,
		nil,
		"psrlq",
		nil,
		nil,
		nil,
		"psllq"
	},
	pshiftdq = {
		nil,
		nil,
		"psrlq",
		"psrldq",
		nil,
		nil,
		"psllq",
		"pslldq"
	},
	fxsave = {
		"$fxsave",
		"$fxrstor",
		"$ldmxcsr",
		"$stmxcsr",
		nil,
		"lfenceDp$",
		"mfenceDp$",
		"sfenceDp$clflush"
	},
	prefetch = {
		"prefetch",
		"prefetchw"
	},
	prefetcht = {
		"prefetchnta",
		"prefetcht0",
		"prefetcht1",
		"prefetcht2"
	}
}
local var_0_17 = {
	B = {
		"al",
		"cl",
		"dl",
		"bl",
		"ah",
		"ch",
		"dh",
		"bh",
		"r8b",
		"r9b",
		"r10b",
		"r11b",
		"r12b",
		"r13b",
		"r14b",
		"r15b"
	},
	B64 = {
		"al",
		"cl",
		"dl",
		"bl",
		"spl",
		"bpl",
		"sil",
		"dil",
		"r8b",
		"r9b",
		"r10b",
		"r11b",
		"r12b",
		"r13b",
		"r14b",
		"r15b"
	},
	W = {
		"ax",
		"cx",
		"dx",
		"bx",
		"sp",
		"bp",
		"si",
		"di",
		"r8w",
		"r9w",
		"r10w",
		"r11w",
		"r12w",
		"r13w",
		"r14w",
		"r15w"
	},
	D = {
		"eax",
		"ecx",
		"edx",
		"ebx",
		"esp",
		"ebp",
		"esi",
		"edi",
		"r8d",
		"r9d",
		"r10d",
		"r11d",
		"r12d",
		"r13d",
		"r14d",
		"r15d"
	},
	Q = {
		"rax",
		"rcx",
		"rdx",
		"rbx",
		"rsp",
		"rbp",
		"rsi",
		"rdi",
		"r8",
		"r9",
		"r10",
		"r11",
		"r12",
		"r13",
		"r14",
		"r15"
	},
	M = {
		"mm0",
		"mm1",
		"mm2",
		"mm3",
		"mm4",
		"mm5",
		"mm6",
		"mm7",
		"mm0",
		"mm1",
		"mm2",
		"mm3",
		"mm4",
		"mm5",
		"mm6",
		"mm7"
	},
	X = {
		"xmm0",
		"xmm1",
		"xmm2",
		"xmm3",
		"xmm4",
		"xmm5",
		"xmm6",
		"xmm7",
		"xmm8",
		"xmm9",
		"xmm10",
		"xmm11",
		"xmm12",
		"xmm13",
		"xmm14",
		"xmm15"
	},
	Y = {
		"ymm0",
		"ymm1",
		"ymm2",
		"ymm3",
		"ymm4",
		"ymm5",
		"ymm6",
		"ymm7",
		"ymm8",
		"ymm9",
		"ymm10",
		"ymm11",
		"ymm12",
		"ymm13",
		"ymm14",
		"ymm15"
	}
}
local var_0_18 = {
	"es",
	"cs",
	"ss",
	"ds",
	"fs",
	"gs",
	"segr6",
	"segr7"
}
local var_0_19 = {
	X = 16,
	Y = 32,
	D = 4,
	W = 2,
	Q = 8,
	M = 8,
	B = 1
}
local var_0_20 = {
	G = "qword",
	X = "xword",
	F = "dword",
	Y = "yword",
	Q = "qword",
	M = "qword",
	D = "dword",
	W = "word",
	B = "byte"
}

local function var_0_21(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0.code
	local var_1_1 = arg_1_0.pos
	local var_1_2 = ""
	local var_1_3 = arg_1_0.hexdump

	if var_1_3 > 0 then
		for iter_1_0 = arg_1_0.start, var_1_1 - 1 do
			var_1_2 = var_1_2 .. var_0_3("%02X", var_0_2(var_1_0, iter_1_0, iter_1_0))
		end

		if var_1_3 < #var_1_2 then
			var_1_2 = var_0_1(var_1_2, 1, var_1_3) .. ". "
		else
			var_1_2 = var_1_2 .. var_0_8(" ", var_1_3 - #var_1_2 + 2)
		end
	end

	if arg_1_2 then
		arg_1_1 = arg_1_1 .. " " .. arg_1_2
	end

	if arg_1_0.o16 then
		arg_1_1 = "o16 " .. arg_1_1
		arg_1_0.o16 = false
	end

	if arg_1_0.a32 then
		arg_1_1 = "a32 " .. arg_1_1
		arg_1_0.a32 = false
	end

	if arg_1_0.rep then
		arg_1_1 = arg_1_0.rep .. " " .. arg_1_1
		arg_1_0.rep = false
	end

	if arg_1_0.rex then
		local var_1_4 = (arg_1_0.rexw and "w" or "") .. (arg_1_0.rexr and "r" or "") .. (arg_1_0.rexx and "x" or "") .. (arg_1_0.rexb and "b" or "") .. (arg_1_0.vexl and "l" or "")

		if arg_1_0.vexv and arg_1_0.vexv ~= 0 then
			var_1_4 = var_1_4 .. "v" .. arg_1_0.vexv
		end

		if var_1_4 ~= "" then
			arg_1_1 = arg_1_0.rex .. "." .. var_1_4 .. " " .. var_0_6(arg_1_1, "^ ", "")
		elseif arg_1_0.rex == "vex" then
			arg_1_1 = var_0_6("v" .. arg_1_1, "^v ", "")
		end

		arg_1_0.rexw = false
		arg_1_0.rexr = false
		arg_1_0.rexx = false
		arg_1_0.rexb = false
		arg_1_0.rex = false
		arg_1_0.vexl = false
		arg_1_0.vexv = false
	end

	if arg_1_0.seg then
		local var_1_5, var_1_6 = var_0_6(arg_1_1, "%[", "[" .. arg_1_0.seg .. ":")

		if var_1_6 == 0 then
			arg_1_1 = arg_1_0.seg .. " " .. arg_1_1
		else
			arg_1_1 = var_1_5
		end

		arg_1_0.seg = false
	end

	if arg_1_0.lock then
		arg_1_1 = "lock " .. arg_1_1
		arg_1_0.lock = false
	end

	local var_1_7 = arg_1_0.imm

	if var_1_7 then
		local var_1_8 = arg_1_0.symtab[var_1_7]

		if var_1_8 then
			arg_1_1 = arg_1_1 .. "\t->" .. var_1_8
		end
	end

	arg_1_0.out(var_0_3("%08x  %s%s\n", arg_1_0.addr + arg_1_0.start, var_1_2, arg_1_1))

	arg_1_0.mrm = false
	arg_1_0.vexv = false
	arg_1_0.start = var_1_1
	arg_1_0.imm = nil
end

local function var_0_22(arg_2_0)
	arg_2_0.o16 = false
	arg_2_0.seg = false
	arg_2_0.lock = false
	arg_2_0.rep = false
	arg_2_0.rexw = false
	arg_2_0.rexr = false
	arg_2_0.rexx = false
	arg_2_0.rexb = false
	arg_2_0.rex = false
	arg_2_0.a32 = false
	arg_2_0.vexl = false
end

local function var_0_23(arg_3_0)
	arg_3_0.pos = arg_3_0.stop + 1

	var_0_22(arg_3_0)

	return var_0_21(arg_3_0, "(incomplete)")
end

local function var_0_24(arg_4_0)
	var_0_22(arg_4_0)

	return var_0_21(arg_4_0, "(unknown)")
end

local function var_0_25(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 + arg_5_2 - 1 > arg_5_0.stop then
		return var_0_23(arg_5_0)
	end

	local var_5_0 = arg_5_0.code

	if arg_5_2 == 1 then
		return (var_0_2(var_5_0, arg_5_1, arg_5_1))
	elseif arg_5_2 == 2 then
		local var_5_1, var_5_2 = var_0_2(var_5_0, arg_5_1, arg_5_1 + 1)

		return var_5_1 + var_5_2 * 256
	else
		local var_5_3, var_5_4, var_5_5, var_5_6 = var_0_2(var_5_0, arg_5_1, arg_5_1 + 3)
		local var_5_7 = var_5_3 + var_5_4 * 256 + var_5_5 * 65536 + var_5_6 * 16777216

		arg_5_0.imm = var_5_7

		return var_5_7
	end
end

local function var_0_26(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1
	local var_6_2
	local var_6_3
	local var_6_4
	local var_6_5
	local var_6_6
	local var_6_7
	local var_6_8
	local var_6_9 = arg_6_0.code
	local var_6_10 = arg_6_0.pos
	local var_6_11 = arg_6_0.stop
	local var_6_12 = arg_6_0.vexl

	for iter_6_0 in var_0_5(arg_6_2, ".") do
		local var_6_13

		if iter_6_0 == "V" or iter_6_0 == "U" then
			if arg_6_0.rexw then
				var_6_2 = "Q"
				arg_6_0.rexw = false
			elseif arg_6_0.o16 then
				var_6_2 = "W"
				arg_6_0.o16 = false
			else
				var_6_2 = iter_6_0 == "U" and arg_6_0.x64 and "Q" or "D"
			end

			var_6_1 = var_0_17[var_6_2]
		elseif iter_6_0 == "T" then
			if arg_6_0.rexw then
				var_6_2 = "Q"
				arg_6_0.rexw = false
			else
				var_6_2 = "D"
			end

			var_6_1 = var_0_17[var_6_2]
		elseif iter_6_0 == "B" then
			var_6_2 = "B"
			var_6_1 = arg_6_0.rex and var_0_17.B64 or var_0_17.B
		elseif var_0_4(iter_6_0, "[WDQMXYFG]") then
			var_6_2 = iter_6_0

			if var_6_2 == "X" and var_6_12 then
				var_6_2 = "Y"
				arg_6_0.vexl = false
			end

			var_6_1 = var_0_17[var_6_2]
		elseif iter_6_0 == "P" then
			var_6_2 = arg_6_0.o16 and "X" or "M"
			arg_6_0.o16 = false

			if var_6_2 == "X" and var_6_12 then
				var_6_2 = "Y"
				arg_6_0.vexl = false
			end

			var_6_1 = var_0_17[var_6_2]
		elseif iter_6_0 == "H" then
			arg_6_1 = arg_6_1 .. (arg_6_0.rexw and "d" or "s")
			arg_6_0.rexw = false
		elseif iter_6_0 == "S" then
			arg_6_1 = arg_6_1 .. var_0_7(var_6_2)
		elseif iter_6_0 == "s" then
			local var_6_14 = var_0_25(arg_6_0, var_6_10, 1)

			if not var_6_14 then
				return
			end

			var_6_13 = var_6_14 <= 127 and var_0_3("+0x%02x", var_6_14) or var_0_3("-0x%02x", 256 - var_6_14)
			var_6_10 = var_6_10 + 1
		elseif iter_6_0 == "u" then
			local var_6_15 = var_0_25(arg_6_0, var_6_10, 1)

			if not var_6_15 then
				return
			end

			var_6_13 = var_0_3("0x%02x", var_6_15)
			var_6_10 = var_6_10 + 1
		elseif iter_6_0 == "b" then
			local var_6_16 = var_0_25(arg_6_0, var_6_10, 1)

			if not var_6_16 then
				return
			end

			var_6_13 = var_6_1[var_6_16 / 16 + 1]
			var_6_10 = var_6_10 + 1
		elseif iter_6_0 == "w" then
			local var_6_17 = var_0_25(arg_6_0, var_6_10, 2)

			if not var_6_17 then
				return
			end

			var_6_13 = var_0_3("0x%x", var_6_17)
			var_6_10 = var_6_10 + 2
		elseif iter_6_0 == "o" then
			if arg_6_0.x64 then
				local var_6_18 = var_0_25(arg_6_0, var_6_10, 4)

				if not var_6_18 then
					return
				end

				local var_6_19 = var_0_25(arg_6_0, var_6_10 + 4, 4)

				if not var_6_19 then
					return
				end

				var_6_13 = var_0_3("[0x%08x%08x]", var_6_19, var_6_18)
				var_6_10 = var_6_10 + 8
			else
				local var_6_20 = var_0_25(arg_6_0, var_6_10, 4)

				if not var_6_20 then
					return
				end

				var_6_13 = var_0_3("[0x%08x]", var_6_20)
				var_6_10 = var_6_10 + 4
			end
		elseif iter_6_0 == "i" or iter_6_0 == "I" then
			local var_6_21 = var_0_19[var_6_2]

			if var_6_21 == 8 and arg_6_0.x64 and iter_6_0 == "I" then
				local var_6_22 = var_0_25(arg_6_0, var_6_10, 4)

				if not var_6_22 then
					return
				end

				local var_6_23 = var_0_25(arg_6_0, var_6_10 + 4, 4)

				if not var_6_23 then
					return
				end

				var_6_13 = var_0_3("0x%08x%08x", var_6_23, var_6_22)
			else
				if var_6_21 == 8 then
					var_6_21 = 4
				end

				local var_6_24 = var_0_25(arg_6_0, var_6_10, var_6_21)

				if not var_6_24 then
					return
				end

				if var_6_2 == "Q" and (var_6_24 < 0 or var_6_24 > 2147483647) then
					var_6_24 = 4294967296 - var_6_24
					var_6_13 = var_0_3(var_6_24 > 65535 and "-0x%08x" or "-0x%x", var_6_24)
				else
					var_6_13 = var_0_3(var_6_24 > 65535 and "0x%08x" or "0x%x", var_6_24)
				end
			end

			var_6_10 = var_6_10 + var_6_21
		elseif iter_6_0 == "j" then
			local var_6_25 = var_0_19[var_6_2]

			if var_6_25 == 8 then
				var_6_25 = 4
			end

			local var_6_26 = var_0_25(arg_6_0, var_6_10, var_6_25)

			if not var_6_26 then
				return
			end

			if var_6_2 == "B" and var_6_26 > 127 then
				var_6_26 = var_6_26 - 256
			elseif var_6_26 > 2147483647 then
				var_6_26 = var_6_26 - 4294967296
			end

			var_6_10 = var_6_10 + var_6_25

			local var_6_27 = var_6_26 + var_6_10 + arg_6_0.addr

			if var_6_27 > 4294967295 and not arg_6_0.x64 then
				var_6_27 = var_6_27 - 4294967296
			end

			arg_6_0.imm = var_6_27

			if var_6_2 == "W" then
				var_6_13 = var_0_3("word 0x%04x", var_6_27 % 65536)
			elseif arg_6_0.x64 then
				local var_6_28 = var_6_27 % 16777216

				var_6_13 = var_0_3("0x%02x%06x", (var_6_27 - var_6_28) / 16777216, var_6_28)
			else
				var_6_13 = "0x" .. var_0_9(var_6_27)
			end
		elseif iter_6_0 == "R" then
			local var_6_29 = var_0_2(var_6_9, var_6_10 - 1, var_6_10 - 1) % 8

			if arg_6_0.rexb then
				var_6_29 = var_6_29 + 8
				arg_6_0.rexb = false
			end

			var_6_13 = var_6_1[var_6_29 + 1]
		elseif iter_6_0 == "a" then
			var_6_13 = var_6_1[1]
		elseif iter_6_0 == "c" then
			var_6_13 = "cl"
		elseif iter_6_0 == "d" then
			var_6_13 = "dx"
		elseif iter_6_0 == "1" then
			var_6_13 = "1"
		else
			if not var_6_3 then
				var_6_3 = arg_6_0.mrm

				if not var_6_3 then
					if var_6_11 < var_6_10 then
						return var_0_23(arg_6_0)
					end

					var_6_3 = var_0_2(var_6_9, var_6_10, var_6_10)
					var_6_10 = var_6_10 + 1
				end

				var_6_5 = var_6_3 % 8
				var_6_3 = (var_6_3 - var_6_5) / 8
				var_6_4 = var_6_3 % 8
				var_6_3 = (var_6_3 - var_6_4) / 8
				var_6_8 = ""

				if var_6_3 < 3 then
					if var_6_5 == 4 then
						if var_6_11 < var_6_10 then
							return var_0_23(arg_6_0)
						end

						var_6_6 = var_0_2(var_6_9, var_6_10, var_6_10)
						var_6_10 = var_6_10 + 1
						var_6_5 = var_6_6 % 8
						var_6_6 = (var_6_6 - var_6_5) / 8
						var_6_7 = var_6_6 % 8
						var_6_6 = (var_6_6 - var_6_7) / 8

						if arg_6_0.rexx then
							var_6_7 = var_6_7 + 8
							arg_6_0.rexx = false
						end

						if var_6_7 == 4 then
							var_6_7 = nil
						end
					end

					if var_6_3 > 0 or var_6_5 == 5 then
						local var_6_30 = var_6_3

						if var_6_30 ~= 1 then
							var_6_30 = 4
						end

						local var_6_31 = var_0_25(arg_6_0, var_6_10, var_6_30)

						if not var_6_31 then
							return
						end

						if var_6_3 == 0 then
							var_6_5 = nil
						end

						if var_6_5 or var_6_7 or not var_6_6 and arg_6_0.x64 and not arg_6_0.a32 then
							if var_6_30 == 1 and var_6_31 > 127 then
								var_6_8 = var_0_3("-0x%x", 256 - var_6_31)
							elseif var_6_31 >= 0 and var_6_31 <= 2147483647 then
								var_6_8 = var_0_3("+0x%x", var_6_31)
							else
								var_6_8 = var_0_3("-0x%x", 4294967296 - var_6_31)
							end
						else
							var_6_8 = var_0_3(arg_6_0.x64 and not arg_6_0.a32 and (not (var_6_31 >= 0) or not (var_6_31 <= 2147483647)) and "0xffffffff%08x" or "0x%08x", var_6_31)
						end

						var_6_10 = var_6_10 + var_6_30
					end
				end

				if var_6_5 and arg_6_0.rexb then
					var_6_5 = var_6_5 + 8
					arg_6_0.rexb = false
				end

				if arg_6_0.rexr then
					var_6_4 = var_6_4 + 8
					arg_6_0.rexr = false
				end
			end

			if iter_6_0 == "m" then
				if var_6_3 == 3 then
					var_6_13 = var_6_1[var_6_5 + 1]
				else
					local var_6_32 = arg_6_0.a32 and var_0_17.D or arg_6_0.aregs
					local var_6_33 = ""
					local var_6_34 = ""

					if var_6_5 then
						var_6_33 = var_6_32[var_6_5 + 1]
					elseif not var_6_6 and arg_6_0.x64 and not arg_6_0.a32 then
						var_6_33 = "rip"
					end

					arg_6_0.a32 = false

					if var_6_7 then
						if var_6_5 then
							var_6_33 = var_6_33 .. "+"
						end

						var_6_34 = var_6_32[var_6_7 + 1]

						if var_6_6 > 0 then
							var_6_34 = var_6_34 .. "*" .. 2^var_6_6
						end
					end

					var_6_13 = var_0_3("[%s%s%s]", var_6_33, var_6_34, var_6_8)
				end

				if var_6_3 < 3 and (not var_0_4(arg_6_2, "[aRrgp]") or var_0_4(arg_6_2, "t")) then
					var_6_13 = var_0_20[var_6_2] .. " " .. var_6_13
				end
			elseif iter_6_0 == "r" then
				var_6_13 = var_6_1[var_6_4 + 1]
			elseif iter_6_0 == "g" then
				var_6_13 = var_0_18[var_6_4 + 1]
			elseif iter_6_0 == "p" then
				-- block empty
			elseif iter_6_0 == "f" then
				var_6_13 = "st" .. var_6_5
			elseif iter_6_0 == "x" then
				if var_6_4 == 0 and arg_6_0.lock and not arg_6_0.x64 then
					var_6_13 = "CR8"
					arg_6_0.lock = false
				else
					var_6_13 = "CR" .. var_6_4
				end
			elseif iter_6_0 == "v" then
				if arg_6_0.vexv then
					var_6_13 = var_6_1[arg_6_0.vexv + 1]
					arg_6_0.vexv = false
				end
			elseif iter_6_0 == "y" then
				var_6_13 = "DR" .. var_6_4
			elseif iter_6_0 == "z" then
				var_6_13 = "TR" .. var_6_4
			elseif iter_6_0 == "l" then
				var_6_12 = false
			elseif iter_6_0 == "t" then
				-- block empty
			else
				error("bad pattern `" .. arg_6_2 .. "'")
			end
		end

		if var_6_13 then
			var_6_0 = var_6_0 and var_6_0 .. ", " .. var_6_13 or var_6_13
		end
	end

	arg_6_0.pos = var_6_10

	return var_0_21(arg_6_0, arg_6_1, var_6_0)
end

local var_0_27

local function var_0_28(arg_7_0)
	local var_7_0 = arg_7_0.mrm

	if not var_7_0 then
		local var_7_1 = arg_7_0.pos

		if var_7_1 > arg_7_0.stop then
			return nil
		end

		var_7_0 = var_0_2(arg_7_0.code, var_7_1, var_7_1)
		arg_7_0.pos = var_7_1 + 1
		arg_7_0.mrm = var_7_0
	end

	return var_7_0
end

local function var_0_29(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 then
		return var_0_24(arg_8_0)
	end

	if var_0_4(arg_8_1, "%|") then
		local var_8_0

		if arg_8_0.rep then
			var_8_0 = arg_8_0.rep == "rep" and "%|([^%|]*)" or "%|[^%|]*%|[^%|]*%|([^%|]*)"
			arg_8_0.rep = false
		elseif arg_8_0.o16 then
			var_8_0 = "%|[^%|]*%|([^%|]*)"
			arg_8_0.o16 = false
		else
			var_8_0 = "^[^%|]*"
		end

		arg_8_1 = var_0_4(arg_8_1, var_8_0)

		if not arg_8_1 then
			return var_0_24(arg_8_0)
		end
	end

	if var_0_4(arg_8_1, "%$") then
		local var_8_1 = var_0_28(arg_8_0)

		if not var_8_1 then
			return var_0_23(arg_8_0)
		end

		arg_8_1 = var_0_4(arg_8_1, var_8_1 >= 192 and "^[^%$]*" or "%$(.*)")

		if arg_8_1 == "" then
			return var_0_24(arg_8_0)
		end
	end

	if arg_8_1 == "" then
		return var_0_24(arg_8_0)
	end

	local var_8_2, var_8_3 = var_0_4(arg_8_1, "^([a-z0-9 ]*)(.*)")

	if var_8_3 == "" and arg_8_2 then
		var_8_3 = arg_8_2
	end

	return var_0_27[var_0_1(var_8_3, 1, 1)](arg_8_0, var_8_2, var_8_3)
end

local function var_0_30(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.pos
	local var_9_1 = arg_9_1[var_0_2(arg_9_0.code, var_9_0, var_9_0)]

	arg_9_0.pos = var_9_0 + 1

	return var_0_29(arg_9_0, var_9_1)
end

var_0_27 = {
	[""] = function(arg_10_0, arg_10_1, arg_10_2)
		return var_0_21(arg_10_0, arg_10_1)
	end,
	B = var_0_26,
	W = var_0_26,
	D = var_0_26,
	Q = var_0_26,
	V = var_0_26,
	U = var_0_26,
	T = var_0_26,
	M = var_0_26,
	X = var_0_26,
	P = var_0_26,
	F = var_0_26,
	G = var_0_26,
	Y = var_0_26,
	H = var_0_26,
	[":"] = function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_0[arg_11_2 == ":" and arg_11_1 or var_0_1(arg_11_2, 2)] = arg_11_1

		if arg_11_0.pos - arg_11_0.start > 5 then
			return var_0_24(arg_11_0)
		end
	end,
	["*"] = function(arg_12_0, arg_12_1, arg_12_2)
		return var_0_27[arg_12_1](arg_12_0, arg_12_1, var_0_1(arg_12_2, 2))
	end,
	["!"] = function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = var_0_28(arg_13_0)

		if not var_13_0 then
			return var_0_23(arg_13_0)
		end

		return var_0_29(arg_13_0, var_0_16[arg_13_1][(var_13_0 - var_13_0 % 8) / 8 % 8 + 1], var_0_1(arg_13_2, 2))
	end,
	sz = function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0.o16 then
			arg_14_0.o16 = false
		else
			arg_14_2 = var_0_4(arg_14_2, ",(.*)")

			if arg_14_0.rexw then
				local var_14_0 = var_0_4(arg_14_2, ",(.*)")

				if var_14_0 then
					arg_14_2 = var_14_0
					arg_14_0.rexw = false
				end
			end
		end

		arg_14_2 = var_0_4(arg_14_2, "^[^,]*")

		return var_0_29(arg_14_0, arg_14_2)
	end,
	opc2 = function(arg_15_0, arg_15_1, arg_15_2)
		return var_0_30(arg_15_0, var_0_12)
	end,
	opc3 = function(arg_16_0, arg_16_1, arg_16_2)
		return var_0_30(arg_16_0, var_0_13[arg_16_2])
	end,
	vm = function(arg_17_0, arg_17_1, arg_17_2)
		return var_0_29(arg_17_0, var_0_14[arg_17_0.mrm])
	end,
	fp = function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = var_0_28(arg_18_0)

		if not var_18_0 then
			return var_0_23(arg_18_0)
		end

		local var_18_1 = var_18_0 % 8
		local var_18_2 = arg_18_2 * 8 + (var_18_0 - var_18_1) / 8 % 8

		if var_18_0 >= 192 then
			var_18_2 = var_18_2 + 64
		end

		local var_18_3 = var_0_15[var_18_2]

		if var_0_0(var_18_3) == "table" then
			var_18_3 = var_18_3[var_18_1 + 1]
		end

		return var_0_29(arg_18_0, var_18_3)
	end,
	rex = function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0.rex then
			return var_0_24(arg_19_0)
		end

		for iter_19_0 in var_0_5(arg_19_2, ".") do
			arg_19_0["rex" .. iter_19_0] = true
		end

		arg_19_0.rex = "rex"
	end,
	vex = function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0.rex then
			return var_0_24(arg_20_0)
		end

		arg_20_0.rex = "vex"

		local var_20_0 = arg_20_0.pos

		if arg_20_0.mrm then
			arg_20_0.mrm = nil
			var_20_0 = var_20_0 - 1
		end

		local var_20_1 = var_0_2(arg_20_0.code, var_20_0, var_20_0)

		if not var_20_1 then
			return var_0_23(arg_20_0)
		end

		local var_20_2 = var_20_0 + 1

		if var_20_1 < 128 then
			arg_20_0.rexr = true
		end

		local var_20_3 = 1

		if arg_20_2 == "3" then
			var_20_3 = var_20_1 % 32
			var_20_1 = (var_20_1 - var_20_3) / 32

			local var_20_4 = var_20_1 % 2

			var_20_1 = (var_20_1 - var_20_4) / 2

			if var_20_4 == 0 then
				arg_20_0.rexb = true
			end

			if var_20_1 % 2 == 0 then
				arg_20_0.rexx = true
			end

			var_20_1 = var_0_2(arg_20_0.code, var_20_2, var_20_2)

			if not var_20_1 then
				return var_0_23(arg_20_0)
			end

			var_20_2 = var_20_2 + 1

			if var_20_1 >= 128 then
				arg_20_0.rexw = true
			end
		end

		arg_20_0.pos = var_20_2

		local var_20_5

		if var_20_3 == 1 then
			var_20_5 = var_0_12
		elseif var_20_3 == 2 then
			var_20_5 = var_0_13["38"]
		elseif var_20_3 == 3 then
			var_20_5 = var_0_13["3a"]
		else
			return var_0_24(arg_20_0)
		end

		local var_20_6 = var_20_1 % 4
		local var_20_7 = (var_20_1 - var_20_6) / 4

		if var_20_6 == 1 then
			arg_20_0.o16 = "o16"
		elseif var_20_6 == 2 then
			arg_20_0.rep = "rep"
		elseif var_20_6 == 3 then
			arg_20_0.rep = "repne"
		end

		local var_20_8 = var_20_7 % 2
		local var_20_9 = (var_20_7 - var_20_8) / 2

		if var_20_8 ~= 0 then
			arg_20_0.vexl = true
		end

		arg_20_0.vexv = (-1 - var_20_9) % 16

		return var_0_30(arg_20_0, var_20_5)
	end,
	nop = function(arg_21_0, arg_21_1, arg_21_2)
		return var_0_29(arg_21_0, arg_21_0.rex and arg_21_2 or "nop")
	end,
	emms = function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0.rex ~= "vex" then
			return var_0_21(arg_22_0, "emms")
		elseif arg_22_0.vexl then
			arg_22_0.vexl = false

			return var_0_21(arg_22_0, "zeroall")
		else
			return var_0_21(arg_22_0, "zeroupper")
		end
	end
}

local function var_0_31(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1 = arg_23_1 or 0

	local var_23_0 = arg_23_2 and arg_23_1 + arg_23_2 or #arg_23_0.code

	arg_23_1 = arg_23_1 + 1
	arg_23_0.start = arg_23_1
	arg_23_0.pos = arg_23_1
	arg_23_0.stop = var_23_0
	arg_23_0.imm = nil
	arg_23_0.mrm = false

	var_0_22(arg_23_0)

	while var_23_0 >= arg_23_0.pos do
		var_0_30(arg_23_0, arg_23_0.map1)
	end

	if arg_23_0.pos ~= arg_23_0.start then
		var_0_23(arg_23_0)
	end
end

local function var_0_32(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = {
		code = arg_24_0,
		addr = (arg_24_1 or 0) - 1,
		out = arg_24_2 or io.write,
		symtab = {},
		disass = var_0_31
	}

	var_24_0.hexdump = 16
	var_24_0.x64 = false
	var_24_0.map1 = var_0_10
	var_24_0.aregs = var_0_17.D

	return var_24_0
end

local function var_0_33(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = var_0_32(arg_25_0, arg_25_1, arg_25_2)

	var_25_0.x64 = true
	var_25_0.map1 = var_0_11
	var_25_0.aregs = var_0_17.Q

	return var_25_0
end

local function var_0_34(arg_26_0, arg_26_1, arg_26_2)
	var_0_32(arg_26_0, arg_26_1, arg_26_2):disass()
end

local function var_0_35(arg_27_0, arg_27_1, arg_27_2)
	var_0_33(arg_27_0, arg_27_1, arg_27_2):disass()
end

local function var_0_36(arg_28_0)
	if arg_28_0 < 8 then
		return var_0_17.D[arg_28_0 + 1]
	end

	return var_0_17.X[arg_28_0 - 7]
end

local function var_0_37(arg_29_0)
	if arg_29_0 < 16 then
		return var_0_17.Q[arg_29_0 + 1]
	end

	return var_0_17.X[arg_29_0 - 15]
end

return {
	create = var_0_32,
	create64 = var_0_33,
	disass = var_0_34,
	disass64 = var_0_35,
	regname = var_0_36,
	regname64 = var_0_37
}
