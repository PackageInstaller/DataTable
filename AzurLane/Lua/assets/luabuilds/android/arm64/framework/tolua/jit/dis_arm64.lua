type = var_0_10000
string = var_0_10001

local var_0_0 = var_0_10001.sub

string = var_0_10002

local var_0_1 = var_0_10002.byte

string = var_0_10003

local var_0_2 = var_0_10003.format

string = var_0_10004

local var_0_3 = var_0_10004.match

string = var_0_10005

local var_0_4 = var_0_10005.gmatch

string = var_0_10006

local var_0_5 = var_0_10006.gsub

table = var_0_10007

local var_0_6 = var_0_10007.concat

require = var_0_10008

local var_0_7 = var_0_10008("bit").band
local var_0_8 = var_8.bor
local var_0_9 = var_8.bxor
local var_0_10 = var_8.tohex
local var_0_11 = var_8.lshift
local var_0_12 = var_8.rshift
local var_0_13 = var_8.arshift
local var_0_14 = var_8.ror
local var_0_15 = {
	[0] = "mask",
	1,
	adrDBx = "adrpDBx",
	shift = 31
}
local var_0_16 = {
	[0] = "shift",
	29,
	"mask",
	3,
	["add|movDNIg"] = "adds|cmnD0NIg",
	subDNIg = "subs|cmpD0NIg"
}
local var_0_17 = {
	[0] = {
		[0] = "mask",
		1,
		[nil] = false,
		shift = 22,
		[0] = {
			[0] = "shift",
			29,
			"mask",
			3,
			andDNig = "orr|movDN0ig",
			eorDNig = "ands|tstD0Nig"
		}
	},
	{
		[0] = "shift",
		29,
		"mask",
		3,
		andDNig = "orr|movDN0ig",
		eorDNig = "ands|tstD0Nig"
	},
	shift = 31,
	mask = 1
}
local var_0_18 = {
	[0] = {
		[0] = "mask",
		1,
		[nil] = false,
		shift = 22,
		[0] = {
			[0] = "shift",
			29,
			"mask",
			3,
			movnDWRg = false,
			["movz|movDYRg"] = "movkDWRg"
		}
	},
	{
		[0] = "shift",
		29,
		"mask",
		3,
		movnDWRg = false,
		["movz|movDYRg"] = "movkDWRg"
	},
	shift = 31,
	mask = 1
}
local var_0_19 = {
	[0] = {
		shift = 22,
		mask = 1,
		[0] = {
			[0] = 29,
			"mask",
			3,
			["sbfm|sbfiz|sbfx|asr|sxtw|sxth|sxtbDN12w"] = "bfm|bfi|bfxilDN13w",
			["ubfm|ubfiz|ubfx|lsr|lsl|uxth|uxtbDN12w"] = "shift"
		}
	},
	{
		{
			[0] = 29,
			"mask",
			3,
			["sbfm|sbfiz|sbfx|asr|sxtw|sxth|sxtbDN12x"] = "bfm|bfi|bfxilDN13x",
			["ubfm|ubfiz|ubfx|lsr|lsl|uxth|uxtbDN12x"] = "shift"
		},
		shift = 22,
		mask = 1
	},
	shift = 31,
	mask = 1
}
local var_0_20 = {
	[0] = "shift",
	23,
	"mask",
	7,
	[0] = var_0_15,
	[1] = var_0_15,
	[2] = var_0_16,
	var_0_17,
	var_0_18,
	var_0_19,
	{
		[0] = 114881,
		["extr|rorDNM4w"] = 65664,
		["extr|rorDNM4x"] = 65665,
		["extr|rorDNM4x"] = "shift",
		[15] = "mask"
	},
	[nil] = nil,
	[nil] = false
}
local var_0_21 = {
	[0] = {
		[0] = "mask",
		1,
		[nil] = false,
		shift = 15,
		[0] = {
			[0] = {
				[0] = "andDNMSg",
				"bicDNMSg",
				"andDNMg",
				"bicDNMg",
				"shift",
				21,
				"mask",
				7,
				andDNMSg = "bicDNMSg",
				andDNMSg = "bicDNMSg"
			},
			{
				[0] = "orr|movDN0MSg",
				"orn|mvnDN0MSg",
				"orr|movDN0Mg",
				"orn|mvnDN0Mg",
				"shift",
				21,
				"mask",
				7,
				["orr|movDN0MSg"] = "orn|mvnDN0MSg",
				["orr|movDN0MSg"] = "orn|mvnDN0MSg"
			},
			{
				[0] = "eorDNMSg",
				"eonDNMSg",
				"eorDNMg",
				"eonDNMg",
				"shift",
				21,
				"mask",
				7,
				eorDNMSg = "eonDNMSg",
				eorDNMSg = "eonDNMSg"
			},
			{
				[0] = "ands|tstD0NMSg",
				"bicsDNMSg",
				"ands|tstD0NMg",
				"bicsDNMg",
				"shift",
				21,
				"mask",
				7,
				["ands|tstD0NMSg"] = "bicsDNMSg",
				["ands|tstD0NMSg"] = "bicsDNMSg"
			},
			shift = 29,
			mask = 3
		}
	},
	{
		[0] = {
			[0] = "andDNMSg",
			"bicDNMSg",
			"andDNMg",
			"bicDNMg",
			"shift",
			21,
			"mask",
			7,
			andDNMSg = "bicDNMSg",
			andDNMSg = "bicDNMSg"
		},
		{
			[0] = "orr|movDN0MSg",
			"orn|mvnDN0MSg",
			"orr|movDN0Mg",
			"orn|mvnDN0Mg",
			"shift",
			21,
			"mask",
			7,
			["orr|movDN0MSg"] = "orn|mvnDN0MSg",
			["orr|movDN0MSg"] = "orn|mvnDN0MSg"
		},
		{
			[0] = "eorDNMSg",
			"eonDNMSg",
			"eorDNMg",
			"eonDNMg",
			"shift",
			21,
			"mask",
			7,
			eorDNMSg = "eonDNMSg",
			eorDNMSg = "eonDNMSg"
		},
		{
			[0] = "ands|tstD0NMSg",
			"bicsDNMSg",
			"ands|tstD0NMg",
			"bicsDNMg",
			"shift",
			21,
			"mask",
			7,
			["ands|tstD0NMSg"] = "bicsDNMSg",
			["ands|tstD0NMSg"] = "bicsDNMSg"
		},
		shift = 29,
		mask = 3
	},
	shift = 31,
	mask = 1
}
local var_0_22 = {
	[0] = {
		[0] = "mask",
		1,
		[nil] = false,
		shift = 15,
		[0] = {
			[0] = {
				[0] = "shift",
				22,
				"mask",
				3,
				addDNMSg = "addDNMSg",
				addDNMSg = "addDNMg"
			},
			{
				[0] = "shift",
				22,
				"mask",
				3,
				["adds|cmnD0NMSg"] = "adds|cmnD0NMSg",
				["adds|cmnD0NMSg"] = "adds|cmnD0NMg"
			},
			{
				[0] = "shift",
				22,
				"mask",
				3,
				["sub|negDN0MSg"] = "sub|negDN0MSg",
				["sub|negDN0MSg"] = "sub|negDN0Mg"
			},
			{
				[0] = "shift",
				22,
				"mask",
				3,
				["subs|cmp|negsD0N0MzSg"] = "subs|cmp|negsD0N0MzSg",
				["subs|cmp|negsD0N0MzSg"] = "subs|cmp|negsD0N0Mzg"
			},
			shift = 29,
			mask = 3
		}
	},
	{
		[0] = {
			[0] = "shift",
			22,
			"mask",
			3,
			addDNMSg = "addDNMSg",
			addDNMSg = "addDNMg"
		},
		{
			[0] = "shift",
			22,
			"mask",
			3,
			["adds|cmnD0NMSg"] = "adds|cmnD0NMSg",
			["adds|cmnD0NMSg"] = "adds|cmnD0NMg"
		},
		{
			[0] = "shift",
			22,
			"mask",
			3,
			["sub|negDN0MSg"] = "sub|negDN0MSg",
			["sub|negDN0MSg"] = "sub|negDN0Mg"
		},
		{
			[0] = "shift",
			22,
			"mask",
			3,
			["subs|cmp|negsD0N0MzSg"] = "subs|cmp|negsD0N0MzSg",
			["subs|cmp|negsD0N0MzSg"] = "subs|cmp|negsD0N0Mzg"
		},
		shift = 29,
		mask = 3
	},
	shift = 31,
	mask = 1
}
local var_0_23 = {
	[0] = var_0_22,
	var_0_22,
	var_0_22,
	shift = 22,
	mask = 3
}
local var_0_24 = {
	shift = 22,
	mask = 3,
	[0] = {
		[0] = "shift",
		29,
		"mask",
		3,
		addDNMXg = "adds|cmnD0NMXg",
		subDNMXg = "subs|cmpD0NMzXg"
	}
}
local var_0_25 = {
	shift = 10,
	mask = 63,
	[0] = {
		[0] = "shift",
		29,
		"mask",
		3,
		adcDNMg = "adcsDNMg",
		["sbc|ngcDN0Mg"] = "sbcs|ngcsDN0Mg"
	}
}
local var_0_26 = {
	shift = 4,
	mask = 1,
	[0] = {
		shift = 10,
		mask = 3,
		[0] = {
			[0] = "shift",
			29,
			"mask",
			3,
			[nil] = "ccmnNMVCg",
			[false] = "ccmpNMVCg"
		},
		[2] = {
			[0] = "shift",
			29,
			"mask",
			3,
			[nil] = "ccmnN5VCg",
			[false] = "ccmpN5VCg"
		}
	}
}
local var_0_27 = {
	shift = 11,
	mask = 1,
	[0] = {
		[0] = {
			[0] = "shift",
			29,
			"mask",
			3,
			cselDNMzCg = false,
			["csinv|cinv|csetmDNMcg"] = false
		},
		{
			[0] = "shift",
			29,
			"mask",
			3,
			["csinc|cinc|csetDNMcg"] = false,
			["csneg|cnegDNMcg"] = false
		},
		shift = 10,
		mask = 1
	}
}
local var_0_28 = {
	shift = 29,
	mask = 1,
	[0] = {
		[0] = {
			[0] = "clzDNg",
			"clsDNg",
			"shift",
			10,
			"mask",
			2047,
			rbitDNg = "rev16DNg",
			revDNw = false
		},
		{
			[0] = "clzDNg",
			"clsDNg",
			"shift",
			10,
			"mask",
			2047,
			rbitDNg = "rev16DNg",
			rev32DNx = "revDNx"
		},
		shift = 31,
		mask = 1
	}
}
local var_0_29 = {
	shift = 29,
	mask = 1,
	[0] = {
		[0] = false,
		false,
		false,
		false,
		"lslDNMg",
		"lsrDNMg",
		"asrDNMg",
		"rorDNMg",
		"shift",
		10,
		"mask",
		63,
		[nil] = false,
		udivDNMg = "sdivDNMg"
	}
}
local var_0_30 = {
	[0] = "shift",
	29,
	"mask",
	7,
	[0] = {
		shift = 21,
		mask = 7,
		[0] = {
			[0] = "mask",
			1,
			["madd|mulDNMA0g"] = "msub|mnegDNMA0g",
			shift = 15
		}
	},
	{
		[0] = {
			[0] = false,
			"umaddl|umullDxNMwA0x",
			"umulhDNMx",
			"shift",
			21,
			"mask",
			7,
			["madd|mulDNMA0g"] = "smaddl|smullDxNMwA0x",
			smulhDNMx = false
		},
		{
			[0] = false,
			"umsubl|umneglDxNMwA0x",
			"shift",
			21,
			"mask",
			7,
			["msub|mnegDNMA0g"] = "smsubl|smneglDxNMwA0x",
			[false] = false
		},
		shift = 15,
		mask = 1
	},
	[nil] = false,
	[false] = false
}
local var_0_31 = {
	[0] = {
		[0] = var_0_21,
		{
			[0] = var_0_23,
			var_0_24,
			shift = 21,
			mask = 1
		},
		shift = 24,
		mask = 1
	},
	{
		false,
		[0] = var_0_25,
		var_0_26,
		false,
		"shift",
		21,
		"mask",
		15,
		[4] = var_0_27,
		[6] = {
			[0] = var_0_29,
			var_0_28,
			shift = 30,
			mask = 1
		},
		var_0_30,
		var_0_30,
		var_0_30,
		var_0_30,
		var_0_30,
		var_0_30,
		var_0_30,
		var_0_30,
		[nil] = false,
		[nil] = false
	},
	shift = 28,
	mask = 1
}
local var_0_32 = {
	[0] = {
		[0] = 30,
		"mask",
		3,
		ldrDwB = "ldrDxB",
		ldrswDxB = "shift"
	},
	{
		[0] = "mask",
		3,
		ldrDsB = "ldrDdB",
		shift = 30
	},
	shift = 26,
	mask = 1
}
local var_0_33 = {
	[0] = {
		shift = 26,
		mask = 1,
		[0] = {
			[0] = "shift",
			22,
			"mask",
			3,
			strbDwzL = "ldrbDwzL",
			ldrsbDxzL = "ldrsbDwzL"
		}
	},
	{
		shift = 26,
		mask = 1,
		[0] = {
			[0] = "shift",
			22,
			"mask",
			3,
			strhDwzL = "ldrhDwzL",
			ldrshDxzL = "ldrshDwzL"
		}
	},
	{
		[0] = {
			[0] = 22,
			"mask",
			3,
			strDwzL = "ldrDwzL",
			ldrswDxzL = "shift"
		},
		{
			[0] = "mask",
			3,
			strDszL = "ldrDszL",
			shift = 22
		},
		shift = 26,
		mask = 1
	},
	{
		[0] = {
			[0] = "mask",
			3,
			strDxzL = "ldrDxzL",
			shift = 22
		},
		{
			[0] = "mask",
			3,
			strDdzL = "ldrDdzL",
			shift = 22
		},
		shift = 26,
		mask = 1
	},
	shift = 30,
	mask = 3
}
local var_0_34 = {
	[0] = {
		[0] = 10,
		"mask",
		3,
		[0] = {
			shift = 26,
			mask = 1,
			[0] = {
				[0] = {
					[0] = "mask",
					3,
					sturbDwK = "ldurbDwK",
					shift = 22
				},
				{
					[0] = "mask",
					3,
					sturhDwK = "ldurhDwK",
					shift = 22
				},
				{
					[0] = "mask",
					3,
					sturDwK = "ldurDwK",
					shift = 22
				},
				{
					[0] = "mask",
					3,
					sturDxK = "ldurDxK",
					shift = 22
				},
				shift = 30,
				mask = 3
			}
		},
		[1] = var_0_33,
		var_0_33,
		[nil] = nil,
		[false] = "shift"
	},
	{
		shift = 10,
		mask = 3,
		[2] = {
			[0] = {
				[0] = {
					[0] = "shift",
					22,
					"mask",
					3,
					strbDwO = "ldrbDwO",
					ldrsbDxO = "ldrsbDwO"
				},
				{
					[0] = "shift",
					22,
					"mask",
					3,
					strhDwO = "ldrhDwO",
					ldrshDxO = "ldrshDwO"
				},
				{
					[0] = 22,
					"mask",
					3,
					strDwO = "ldrDwO",
					ldrswDxO = "shift"
				},
				{
					[0] = "mask",
					3,
					strDxO = "ldrDxO",
					shift = 22
				},
				shift = 30,
				mask = 3
			},
			{
				shift = 30,
				mask = 3,
				[2] = {
					[0] = "mask",
					3,
					strDsO = "ldrDsO",
					shift = 22
				},
				[3] = {
					[0] = "mask",
					3,
					strDdO = "ldrDdO",
					shift = 22
				}
			},
			shift = 26,
			mask = 1
		}
	},
	shift = 21,
	mask = 1
}
local var_0_35 = {
	[0] = {
		[0] = {
			[0] = "mask",
			1,
			stpDzAzwP = "stpDzAzsP",
			shift = 26
		},
		{
			[0] = "mask",
			1,
			[nil] = "stpDzAzdP",
			shift = 26
		},
		{
			[0] = 1,
			stpDzAzxP = "shift",
			[26] = "mask"
		},
		shift = 30,
		mask = 3
	},
	{
		[0] = {
			[0] = "mask",
			1,
			ldpDzAzwP = "ldpDzAzsP",
			shift = 26
		},
		{
			[0] = "mask",
			1,
			ldpswDAxP = "ldpDzAzdP",
			shift = 26
		},
		{
			[0] = 1,
			ldpDzAzxP = "shift",
			[26] = "mask"
		},
		shift = 30,
		mask = 3
	},
	shift = 22,
	mask = 1
}
local var_0_36 = {
	shift = 24,
	mask = 49,
	[16] = var_0_32,
	[48] = var_0_34,
	[32] = {
		var_0_35,
		var_0_35,
		var_0_35,
		shift = 23,
		mask = 3
	},
	[33] = {
		var_0_35,
		var_0_35,
		var_0_35,
		shift = 23,
		mask = 3
	},
	[49] = {
		[0] = {
			[0] = {
				[0] = "mask",
				3,
				strbDwzU = "ldrbDwzU",
				shift = 22
			},
			{
				[0] = "mask",
				3,
				strhDwzU = "ldrhDwzU",
				shift = 22
			},
			{
				[0] = "mask",
				3,
				strDwzU = "ldrDwzU",
				shift = 22
			},
			{
				[0] = "mask",
				3,
				strDxzU = "ldrDxzU",
				shift = 22
			},
			shift = 30,
			mask = 3
		},
		{
			shift = 30,
			mask = 3,
			[2] = {
				[0] = "mask",
				3,
				strDszU = "ldrDszU",
				shift = 22
			},
			[3] = {
				[0] = "mask",
				3,
				strDdzU = "ldrDdzU",
				shift = 22
			}
		},
		shift = 26,
		mask = 1
	}
}
local var_0_37 = {
	{
		[0] = {
			{
				[0] = {
					[0] = {
						[0] = {
							[0] = {
								shift = 15,
								mask = 1,
								[0] = {
									[0] = {
										[57] = "fcvtzuDwNs",
										[121] = "fcvtzuDwNd",
										[104] = "fcvtpsDwNd",
										[112] = "fcvtmsDwNd",
										[99] = "ucvtfDdNw",
										[97] = "fcvtnuDwNd",
										[100] = "fcvtasDwNd",
										[33] = "fcvtnuDwNs",
										[39] = "fmovDsNw",
										[35] = "ucvtfDsNw",
										[105] = "fcvtpuDwNd",
										[96] = "fcvtnsDwNd",
										[113] = "fcvtmuDwNd",
										[120] = "fcvtzsDwNd",
										[32] = "fcvtnsDwNs",
										[38] = "fmovDwNs",
										[36] = "fcvtasDwNs",
										[40] = "fcvtpsDwNs",
										mask = 255,
										[48] = "fcvtmsDwNs",
										[101] = "fcvtauDwNd",
										[56] = "fcvtzsDwNs",
										[37] = "fcvtauDwNs",
										[98] = "scvtfDdNw",
										[41] = "fcvtpuDwNs",
										[49] = "fcvtmuDwNs",
										shift = 16,
										[34] = "scvtfDsNw"
									},
									{
										[96] = "fcvtnsDxNd",
										[121] = "fcvtzuDxNd",
										[104] = "fcvtpsDxNd",
										[112] = "fcvtmsDxNd",
										[100] = "fcvtasDxNd",
										[97] = "fcvtnuDxNd",
										[56] = "fcvtzsDxNs",
										[33] = "fcvtnuDxNs",
										[105] = "fcvtpuDxNd",
										[102] = "fmovDxNd",
										[99] = "ucvtfDdNx",
										[113] = "fcvtmuDxNd",
										[120] = "fcvtzsDxNd",
										[103] = "fmovDdNx",
										[32] = "fcvtnsDxNs",
										[57] = "fcvtzuDxNs",
										[36] = "fcvtasDxNs",
										[40] = "fcvtpsDxNs",
										mask = 255,
										[48] = "fcvtmsDxNs",
										[101] = "fcvtauDxNd",
										[35] = "ucvtfDsNx",
										[37] = "fcvtauDxNs",
										[98] = "scvtfDdNx",
										[41] = "fcvtpuDxNs",
										[49] = "fcvtmuDxNs",
										shift = 16,
										[34] = "scvtfDsNx"
									},
									shift = 31,
									mask = 1
								}
							},
							{
								shift = 31,
								mask = 1,
								[0] = {
									[0] = {
										[0] = false,
										"fcvtDdNs",
										false,
										false,
										"frintnDNf",
										"frintpDNf",
										"frintmDNf",
										"frintzDNf",
										"frintaDNf",
										false,
										"frintxDNf",
										"frintiDNf",
										"shift",
										15,
										"mask",
										63,
										fmovDNf = "fabsDNf",
										fnegDNf = "fsqrtDNf"
									},
									{
										[0] = "fcvtDsNd",
										false,
										false,
										false,
										"frintnDNf",
										"frintpDNf",
										"frintmDNf",
										"frintzDNf",
										"frintaDNf",
										false,
										"frintxDNf",
										"frintiDNf",
										"shift",
										15,
										"mask",
										63,
										fmovDNf = "fabsDNf",
										fnegDNf = "fsqrtDNf"
									},
									shift = 22,
									mask = 3
								}
							},
							shift = 14,
							mask = 1
						},
						{
							shift = 31,
							mask = 1,
							[0] = {
								shift = 14,
								mask = 3,
								[0] = {
									shift = 23,
									mask = 1,
									[0] = {
										[0] = 0,
										fcmpNMf = 24,
										fcmpeNZf = 8,
										fcmpNZf = 16,
										fcmpeNMf = "mask",
										[31] = "shift"
									}
								}
							}
						},
						shift = 13,
						mask = 1
					},
					{
						shift = 31,
						mask = 1,
						[0] = {
							shift = 5,
							mask = 31,
							[0] = {
								[0] = 1,
								fmovDFf = "shift",
								[23] = "mask"
							}
						}
					},
					shift = 12,
					mask = 1
				},
				{
					shift = 31,
					mask = 1,
					[0] = {
						shift = 23,
						mask = 1,
						[0] = {
							[0] = "mask",
							1,
							fccmpNMVCf = "fccmpeNMVCf",
							shift = 4
						}
					}
				},
				{
					shift = 31,
					mask = 1,
					[0] = {
						shift = 23,
						mask = 1,
						[0] = {
							[0] = "fmaxDNMf",
							"fminDNMf",
							"fmaxnmDNMf",
							"fminnmDNMf",
							"fnmulDNMf",
							"shift",
							12,
							"mask",
							15,
							fmulDNMf = "fdivDNMf",
							faddDNMf = "fsubDNMf"
						}
					}
				},
				{
					shift = 31,
					mask = 1,
					[0] = {
						[0] = 1,
						fcselDNMCf = "shift",
						[23] = "mask"
					}
				},
				shift = 10,
				mask = 3
			},
			shift = 21,
			mask = 1
		},
		{
			shift = 31,
			mask = 1,
			[0] = {
				[0] = {
					[0] = "mask",
					5,
					fmaddDNMAf = "fnmaddDNMAf",
					shift = 21
				},
				{
					[0] = "mask",
					5,
					fmsubDNMAf = "fnmsubDNMAf",
					shift = 21
				},
				shift = 15,
				mask = 1
			}
		},
		shift = 24,
		mask = 1
	},
	shift = 28,
	mask = 7
}
local var_0_38 = {
	[0] = "blB",
	"shift",
	29,
	"mask",
	7,
	[1] = {
		[0] = "shift",
		24,
		"mask",
		3,
		cbzDBg = "cbnzDBg",
		tbzDTBw = "tbnzDTBw"
	},
	[2] = {
		shift = 24,
		mask = 3,
		[0] = {
			shift = 4,
			mask = 1,
			[0] = {
				[0] = "bmiB",
				"bplB",
				"bvsB",
				"bvcB",
				"bhiB",
				"blsB",
				"bgeB",
				"bltB",
				"bgtB",
				"bleB",
				"balB",
				"shift",
				0,
				"mask",
				15,
				beqB = "bneB",
				bhsB = "bloB"
			}
		}
	},
	{
		[0] = "shift",
		24,
		"mask",
		3,
		cbzDBg = "cbnzDBg",
		tbzDTBx = "tbnzDTBx"
	},
	{
		[0] = {
			[2097152] = "brkW",
			shift = 0,
			mask = 14680095
		},
		{
			[204831] = "nop",
			shift = 0,
			mask = 4194303
		},
		{
			[6225920] = "retNx",
			[4128768] = "blrNx",
			mask = 16776223,
			[2031616] = "brNx",
			shift = 0
		},
		shift = 24,
		mask = 3
	},
	bB = nil,
	[nil] = false
}
local var_0_39 = {
	[0] = "shift",
	25,
	"mask",
	15,
	var_0_36,
	var_0_31,
	var_0_36,
	var_0_37,
	var_0_20,
	var_0_20,
	var_0_38,
	var_0_38,
	var_0_36,
	var_0_31,
	var_0_36,
	var_0_37,
	[false] = false,
	[false] = false
}
local var_0_40 = {
	x = {},
	w = {},
	d = {},
	s = {}
}

for iter_0_0 = 0, 30 do
	var_0_40.x[iter_0_0] = "x" .. iter_0_0
	var_0_40.w[iter_0_0] = "w" .. iter_0_0
	var_0_40.d[iter_0_0] = "d" .. iter_0_0
	var_0_40.s[iter_0_0] = "s" .. iter_0_0
end

var_0_40.x[31] = "sp"
var_0_40.w[31] = "wsp"
var_0_40.d[31] = "d31"
var_0_40.s[31] = "s31"

local var_0_41 = {
	[0] = "eq",
	"ne",
	"cs",
	"cc",
	"mi",
	"pl",
	"vs",
	"vc",
	"hi",
	"ls",
	"ge",
	"lt",
	"gt",
	"le",
	"al"
}
local var_0_42 = {
	[0] = "lsl",
	"lsr",
	"asr"
}
local var_0_43 = {
	[0] = "uxtb",
	"uxth",
	"uxtw",
	"uxtx",
	"sxtb",
	"sxth",
	"sxtw",
	"sxtx"
}

local function var_0_44(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0.pos
	local var_1_1 = ""

	if arg_1_0.rel and arg_1_0.symtab[arg_1_0.rel] then
		var_1_1 = "\t->" .. var_5
	end

	if arg_1_0.hexdump > 0 then
		arg_1_0.out(var_0_2("%08x  %s  %-5s %s%s\n", arg_1_0.addr + var_1_0, var_0_10(arg_1_0.op), arg_1_1, var_0_6(arg_1_2, ", "), var_1_1))
	else
		arg_1_0.out(var_0_2("%08x  %-5s %s%s\n", arg_1_0.addr + var_1_0, arg_1_1, var_0_6(arg_1_2, ", "), var_1_1))
	end

	arg_1_0.pos = var_1_0 + 4

	return
end

local function var_0_45(arg_2_0)
	return var_0_44(arg_2_0, ".long", {
		"0x" .. var_0_10(arg_2_0.op)
	})
end

local function var_0_46(arg_3_0, arg_3_1, arg_3_2)
	return var_0_40[var_0_3(arg_3_1, arg_3_0 .. "%w-([xwds])")][arg_3_2]
end

local function var_0_47(arg_4_0)
	if arg_4_0 < 0 then
		return var_0_10(arg_4_0)
	else
		return var_0_2("%x", arg_4_0)
	end

	return
end

local var_0_48 = {
	1431655765,
	286331153,
	16843009,
	65537,
	1
}

local function var_0_49(arg_5_0)
	local var_5_0 = var_0_7(var_0_12(arg_5_0, 10), 63)
	local var_5_1 = var_0_7(var_0_12(arg_5_0, 16), 63)

	if var_0_7(arg_5_0, 0) == 0 then
		local var_5_2 = 5

		if var_5_0 >= 56 then
			if var_5_0 >= 60 then
				var_5_2 = 1
			else
				var_5_2 = 2
			end
		elseif var_5_0 >= 48 then
			var_5_2 = 3
		elseif var_5_0 >= 32 then
			var_5_2 = 4
		end

		local var_5_3 = var_0_11(1, var_5_2) - 1
		local var_5_4 = var_0_7(var_5_0, var_5_3)
		local var_5_5 = var_0_7(var_5_1, var_5_3)
		local var_5_6 = var_0_14(var_0_12(-1, 31 - var_5_4), var_5_5)

		if var_5_2 ~= 5 then
			var_5_6 = var_0_7(var_5_6, var_0_11(1, var_5_3) - 1) + var_0_12(var_5_6, 31 - var_5_3)
		end

		local var_5_7 = var_5_6 * var_0_48[var_5_2]
		local var_5_8 = var_0_47(var_5_7)

		if var_0_12(arg_5_0, 31) ~= 0 then
			return var_5_8 .. var_0_10(var_5_7)
		else
			return var_5_8
		end
	else
		local var_5_9 = -1
		local var_5_10 = 0

		if var_5_0 < 32 then
			var_5_9 = var_0_12(-1, 31 - var_5_0)
		else
			var_5_10 = var_0_12(-1, 63 - var_5_0)
		end

		if var_5_1 ~= 0 then
			var_5_9, var_5_10 = var_0_14(var_5_9, var_5_1), var_0_14(var_5_10, var_5_1)

			local var_5_11 = var_5_1 == 32 and 0 or var_0_7(var_0_9(var_5_9, var_5_10), var_0_11(-1, 32 - var_5_1))

			var_5_9, var_5_10 = var_0_9(var_5_9, var_5_11), var_0_9(var_5_10, var_5_11)

			if var_5_1 >= 32 then
				var_5_9, var_5_10 = var_5_10, var_5_9
			end
		end

		if var_5_10 ~= 0 then
			return var_0_47(var_5_10) .. var_0_10(var_5_9)
		else
			return var_0_47(var_5_9)
		end
	end

	return
end

local function var_0_50(arg_6_0, arg_6_1)
	if arg_6_1 == "b" or arg_6_1 == "bl" then
		return var_0_13(var_0_11(arg_6_0, 6), 4)
	elseif arg_6_1 == "adr" or arg_6_1 == "adrp" then
		local var_6_0 = var_0_7(var_0_12(arg_6_0, 29), 3)
		local var_6_1 = var_0_11(var_0_13(var_0_11(arg_6_0, 8), 13), 2)

		return var_0_8(var_6_1, var_6_0)
	elseif arg_6_1 == "tbz" or arg_6_1 == "tbnz" then
		return var_0_11(var_0_13(var_0_11(arg_6_0, 13), 18), 2)
	else
		return var_0_11(var_0_13(var_0_11(arg_6_0, 8), 13), 2)
	end

	return
end

local function var_0_51(arg_7_0)
	local var_7_0 = var_0_7(arg_7_0, 0) == 0 and 1 or -1
	local var_7_1 = var_0_9(var_0_12(var_0_13(var_0_11(arg_7_0, 12), 5), 24), 128) - 3

	return var_7_0 * (16 + var_0_7(var_0_12(arg_7_0, 13), 15)) * 2^var_7_1
end

local function var_0_52(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 < arg_8_3 or arg_8_2 == 31 or arg_8_2 == 63 then
		return false
	end

	if arg_8_3 == 0 then
		if arg_8_0 == 0 and (arg_8_2 == 7 or arg_8_2 == 15) then
			return false
		end

		if arg_8_0 ~= 0 and arg_8_1 == 0 and (arg_8_2 == 7 or arg_8_2 == 15 or arg_8_2 == 31) then
			return false
		end
	end

	return true
end

local function var_0_53(arg_9_0)
	local var_9_0 = arg_9_0.pos
	local var_9_1, var_9_2, var_9_3, var_9_4 = var_0_1(arg_9_0.code, var_9_0 + 1, var_9_0 + 4)
	local var_9_5 = var_0_8(var_0_11(var_9_4, 24), var_0_11(var_9_3, 16), var_0_11(var_9_2, 8), var_9_1)
	local var_9_6 = {}
	local var_9_7 = ""
	local var_9_8
	local var_9_9
	local var_9_10
	local var_9_11

	arg_9_0.op = var_9_5
	arg_9_0.rel = nil

	local var_9_12
	local var_9_13
	local var_9_14 = var_0_39[var_0_7(var_0_12(var_9_5, 25), 15)]

	while var_0_10000(var_9_14) ~= "string" do
		if not var_9_14 then
			return var_0_45(arg_9_0)
		end

		var_9_14 = var_9_14[var_0_7(var_0_12(var_9_5, var_9_14.shift), var_9_14.mask)] or var_9_14._
	end

	local var_9_15, var_9_16 = var_0_3(var_9_14, "^([a-z0-9]*)(.*)")
	local var_9_17, var_9_18 = var_0_3(var_9_16, "|([a-z0-9_.|]*)(.*)")

	if var_9_17 then
		var_9_16 = var_9_18
	end

	if var_0_0(var_9_16, 1, 1) == "." then
		local var_9_19, var_9_20 = var_0_3(var_9_16, "^([a-z0-9.]*)(.*)")

		var_9_7 = var_9_7 .. var_9_19
		var_9_16 = var_9_20
	end

	if var_0_3(var_9_16, "[gf]") then
		if var_16 == "g" then
			var_9_11 = var_0_7(var_9_5, 2147483648) ~= 0 and var_0_40.x or var_0_40.w
		else
			var_9_11 = var_0_7(var_9_5, 0) ~= 0 and var_0_40.d or var_0_40.s
		end
	end

	local var_9_21
	local var_9_22

	for iter_9_0 in var_0_4(var_9_16, ".") do
		local var_9_23

		if iter_9_0 == "D" then
			var_1_10024 = var_0_7(var_9_5, 31)
			var_9_23 = var_16 and var_9_11[var_1_10024] or var_0_46(iter_9_0, var_9_16, var_1_10024)
		elseif iter_9_0 == "N" then
			var_1_10024 = var_0_7(var_0_12(var_9_5, 5), 31)
			var_9_23 = var_16 and var_9_11[var_1_10024] or var_0_46(iter_9_0, var_9_16, var_1_10024)
		elseif iter_9_0 == "M" then
			var_1_10024 = var_0_7(var_0_12(var_9_5, 16), 31)
			var_9_23 = var_16 and var_9_11[var_1_10024] or var_0_46(iter_9_0, var_9_16, var_1_10024)
		elseif iter_9_0 == "A" then
			var_1_10024 = var_0_7(var_0_12(var_9_5, 10), 31)
			var_9_23 = var_16 and var_9_11[var_1_10024] or var_0_46(iter_9_0, var_9_16, var_1_10024)
		elseif iter_9_0 == "B" then
			arg_9_0.rel = arg_9_0.addr + var_9_0 + var_0_50(var_9_5, var_9_15)
			var_9_23 = "0x" .. var_0_10(var_1_10024)
		elseif iter_9_0 == "T" then
			var_9_23 = var_0_8(var_0_7(var_0_12(var_9_5, 26), 32), var_0_7(var_0_12(var_9_5, 19), 31))
		elseif iter_9_0 == "V" then
			var_9_23 = var_0_7(var_9_5, 15)
		elseif iter_9_0 == "C" then
			var_9_23 = var_0_41[var_0_7(var_0_12(var_9_5, 12), 15)]
		elseif iter_9_0 == "c" then
			var_1_10024 = var_0_7(var_0_12(var_9_5, 5), 31)

			local var_9_24 = var_0_7(var_0_12(var_9_5, 16), 31)
			local var_9_25 = var_0_7(var_0_12(var_9_5, 12), 15)
			local var_9_26 = var_0_9(var_9_25, 1)

			var_9_23 = var_0_41[var_9_25]

			if var_9_17 and var_9_25 ~= 14 and var_9_25 ~= 15 then
				local var_9_27, var_9_28 = var_0_3(var_9_17, "([^|]*)|(.*)")

				if var_1_10024 == var_9_24 then
					var_9_6[#var_9_6] = nil
					var_9_23 = var_0_41[var_9_26]

					if var_1_10024 ~= 31 then
						if var_9_27 then
							var_9_15 = var_9_27
						else
							var_9_15 = var_9_17
						end
					else
						var_9_6[var_30 - 1] = nil
						var_9_15 = var_9_28
					end
				end
			end
		elseif iter_9_0 == "W" then
			var_9_23 = var_0_7(var_0_12(var_9_5, 5), 65535)
		elseif iter_9_0 == "Y" then
			var_9_23 = var_0_7(var_0_12(var_9_5, 5), 65535)
			var_1_10024 = var_0_7(var_0_12(var_9_5, 21), 3)

			if var_9_17 and (var_1_10024 == 0 or var_9_23 ~= 0) then
				var_9_15 = var_9_17
			end
		elseif iter_9_0 == "L" then
			var_1_10024 = var_0_40.x[var_0_7(var_0_12(var_9_5, 5), 31)]

			local var_9_29 = var_0_13(var_0_11(var_9_5, 11), 23)

			if var_0_7(var_9_5, 2048) ~= 0 then
				var_9_23 = "[" .. var_1_10024 .. ", #" .. var_9_29 .. "]!"
			else
				var_9_23 = "[" .. var_1_10024 .. "], #" .. var_9_29
			end
		elseif iter_9_0 == "U" then
			var_1_10024 = var_0_40.x[var_0_7(var_0_12(var_9_5, 5), 31)]

			local var_9_30 = var_0_7(var_0_12(var_9_5, 30), 3)

			if var_0_11(var_0_13(var_0_11(var_9_5, 10), 20), var_9_30) ~= 0 then
				var_9_23 = "[" .. var_1_10024 .. ", #" .. var_26 .. "]"
			else
				var_9_23 = "[" .. var_1_10024 .. "]"
			end
		elseif iter_9_0 == "K" then
			var_1_10024 = var_0_40.x[var_0_7(var_0_12(var_9_5, 5), 31)]

			if var_0_13(var_0_11(var_9_5, 11), 23) ~= 0 then
				var_9_23 = "[" .. var_1_10024 .. ", #" .. var_25 .. "]"
			else
				var_9_23 = "[" .. var_1_10024 .. "]"
			end
		elseif iter_9_0 == "O" then
			var_1_10024 = var_0_40.x[var_0_7(var_0_12(var_9_5, 5), 31)]

			local var_9_31

			if var_0_7(var_0_12(var_9_5, 13), 1) == 0 then
				var_9_31 = var_0_40.w[var_0_7(var_0_12(var_9_5, 16), 31)]
			else
				var_9_31 = var_0_40.x[var_0_7(var_0_12(var_9_5, 16), 31)]
			end

			var_9_23 = "[" .. var_1_10024 .. ", " .. var_9_31

			local var_9_32 = var_0_7(var_0_12(var_9_5, 13), 7)
			local var_9_33 = var_0_7(var_0_12(var_9_5, 12), 1)
			local var_9_34 = var_0_7(var_0_12(var_9_5, 30), 3)

			if var_9_32 == 3 then
				if var_9_33 == 0 then
					var_9_23 = var_9_23 .. "]"
				else
					var_9_23 = var_9_23 .. ", lsl #" .. var_9_34 .. "]"
				end
			elseif var_9_32 == 2 or var_9_32 == 6 or var_9_32 == 7 then
				if var_9_33 == 0 then
					var_9_23 = var_9_23 .. ", " .. var_0_43[var_9_32] .. "]"
				else
					var_9_23 = var_9_23 .. ", " .. var_0_43[var_9_32] .. " #" .. var_9_34 .. "]"
				end
			else
				var_9_23 = var_9_23 .. "]"
			end
		elseif iter_9_0 == "P" then
			var_1_10024 = var_0_12(var_9_5, 26)

			local var_9_35 = 2

			if var_1_10024 >= 42 then
				var_9_35 = 4
			elseif var_1_10024 >= 27 then
				var_9_35 = 3
			end

			local var_9_36 = var_0_11(var_0_13(var_0_11(var_9_5, 10), 25), var_9_35)
			local var_9_37 = var_0_40.x[var_0_7(var_0_12(var_9_5, 5), 31)]

			if var_0_7(var_0_12(var_9_5, 23), 3) == 1 then
				var_9_23 = "[" .. var_9_37 .. "], #" .. var_9_36
			elseif var_28 == 2 then
				if var_9_36 == 0 then
					var_9_23 = "[" .. var_9_37 .. "]"
				else
					var_9_23 = "[" .. var_9_37 .. ", #" .. var_9_36 .. "]"
				end
			elseif var_28 == 3 then
				var_9_23 = "[" .. var_9_37 .. ", #" .. var_9_36 .. "]!"
			end
		elseif iter_9_0 == "I" then
			var_1_10024 = var_0_7(var_0_12(var_9_5, 22), 3)

			local var_9_38 = var_0_7(var_0_12(var_9_5, 10), 4095)
			local var_9_39 = var_0_7(var_0_12(var_9_5, 5), 31)
			local var_9_40 = var_0_7(var_9_5, 31)

			if var_9_17 == "mov" and var_1_10024 == 0 and var_9_38 == 0 and (var_9_39 == 31 or var_9_40 == 31) then
				var_9_15 = var_9_17
				var_9_23 = nil
			elseif var_1_10024 == 0 then
				var_9_23 = var_9_38
			elseif var_1_10024 == 1 then
				var_9_23 = var_9_38 .. ", lsl #12"
			end
		elseif iter_9_0 == "i" then
			var_9_23 = "#0x" .. var_0_49(var_9_5)
		elseif iter_9_0 == "1" then
			var_9_23 = var_0_7(var_0_12(var_9_5, 16), 63)
		elseif iter_9_0 == "2" then
			var_9_23 = var_0_7(var_0_12(var_9_5, 10), 63)

			if var_9_17 then
				local var_9_41, var_9_42, var_9_43, var_9_44, var_9_45

				var_1_10024, var_9_41, var_9_42, var_9_43, var_9_44, var_9_45 = var_0_3(var_9_17, "([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)|(.*)")

				local var_9_46 = var_0_7(var_0_12(var_9_5, 26), 32)
				local var_9_47 = var_0_7(var_0_12(var_9_5, 30), 1)

				if var_0_52(var_9_46, var_9_47, var_9_23, var_9_22) then
					var_9_15 = var_9_41
					var_9_23 = var_9_23 - var_9_22 + 1
				elseif var_9_22 == 0 and var_9_23 == 7 then
					var_9_6[#var_9_6] = nil

					if var_9_46 ~= 0 then
						var_9_6[var_32 - 1] = var_0_5(var_9_6[var_32 - 1], "x", "w")
					end

					var_9_12 = var_9_6[var_32 - 1]
					var_9_15 = var_9_45
					var_9_23 = nil
				elseif var_9_22 == 0 and var_9_23 == 15 then
					var_9_6[#var_9_6] = nil

					if var_9_46 ~= 0 then
						var_9_6[var_32 - 1] = var_0_5(var_9_6[var_32 - 1], "x", "w")
					end

					var_9_12 = var_9_6[var_32 - 1]
					var_9_15 = var_9_44
					var_9_23 = nil
				elseif var_9_23 == 31 or var_9_23 == 63 then
					if var_9_23 == 31 and var_9_22 == 0 and var_9_15 == "sbfm" then
						var_9_15 = var_9_43
						var_9_6[#var_9_6] = nil

						if var_9_46 ~= 0 then
							var_9_6[var_32 - 1] = var_0_5(var_9_6[var_32 - 1], "x", "w")
						end

						var_9_12 = var_9_6[var_32 - 1]
					else
						var_9_15 = var_9_42
					end

					var_9_23 = nil
				elseif var_0_7(var_9_23, 31) ~= 31 and var_9_22 == var_9_23 + 1 and var_9_15 == "ubfm" then
					var_9_15 = var_9_43
					var_9_12 = "#" .. var_9_46 + 32 - var_9_22
					var_9_6[#var_9_6] = var_9_12
					var_9_23 = nil
				elseif var_9_23 < var_9_22 then
					var_9_15 = var_1_10024
					var_9_12 = "#" .. var_9_46 + 32 - var_9_22
					var_9_6[#var_9_6] = var_9_12
					var_9_23 = var_9_23 + 1
				end
			end
		elseif iter_9_0 == "3" then
			var_9_23 = var_0_7(var_0_12(var_9_5, 10), 63)

			if var_9_17 then
				local var_9_48

				var_1_10024, var_9_48 = var_0_3(var_9_17, "([^|]*)|(.*)")

				if var_9_23 < var_9_22 then
					var_9_15 = var_1_10024

					local var_9_49 = var_0_7(var_0_12(var_9_5, 26), 32)

					var_9_12 = "#" .. var_9_49 + 32 - var_9_22
					var_9_6[#var_9_6] = var_9_12
					var_9_23 = var_9_23 + 1
				elseif var_9_22 <= var_9_23 then
					var_9_15 = var_9_48
					var_9_23 = var_9_23 - var_9_22 + 1
				end
			end
		elseif iter_9_0 == "4" then
			var_9_23 = var_0_7(var_0_12(var_9_5, 10), 63)
			var_1_10024 = var_0_7(var_0_12(var_9_5, 5), 31)

			local var_9_50 = var_0_7(var_0_12(var_9_5, 16), 31)

			if var_9_17 and var_1_10024 == var_9_50 then
				var_9_6[#var_9_6] = nil
				var_9_12 = var_9_6[var_26 - 1]
				var_9_15 = var_9_17
			end
		elseif iter_9_0 == "5" then
			var_9_23 = var_0_7(var_0_12(var_9_5, 16), 31)
		elseif iter_9_0 == "S" then
			if var_0_7(var_0_12(var_9_5, 10), 63) == 0 then
				var_9_23 = nil
			else
				var_9_23 = var_0_42[var_0_7(var_0_12(var_9_5, 22), 3)] .. " #" .. var_9_23
			end
		elseif iter_9_0 == "X" then
			if var_0_7(var_0_12(var_9_5, 13), 7) ~= 3 and var_1_10024 ~= 7 then
				var_9_12 = var_0_40.w[var_0_7(var_0_12(var_9_5, 16), 31)]
				var_9_6[#var_9_6] = var_9_12
			end

			var_9_23 = var_0_7(var_0_12(var_9_5, 10), 7)

			if var_1_10024 == 2 + var_0_7(var_0_12(var_9_5, 31), 1) and var_0_7(var_0_12(var_9_5, var_9_21 and 5 or 0), 31) == 31 then
				if var_9_23 == 0 then
					var_9_23 = nil
				else
					var_9_23 = "lsl #" .. var_9_23
				end
			elseif var_9_23 == 0 then
				var_9_23 = var_0_43[var_0_7(var_0_12(var_9_5, 13), 7)]
			else
				var_9_23 = var_0_43[var_0_7(var_0_12(var_9_5, 13), 7)] .. " #" .. var_9_23
			end
		elseif iter_9_0 == "R" then
			if var_0_7(var_0_12(var_9_5, 21), 3) == 0 then
				var_9_23 = nil
			else
				var_9_23 = "lsl #" .. var_9_23 * 16
			end
		elseif iter_9_0 == "z" then
			if var_9_6[#var_9_6] == "sp" then
				var_9_6[var_1_10024] = "xzr"
			elseif var_9_6[var_1_10024] == "wsp" then
				var_9_6[var_1_10024] = "wzr"
			end
		elseif iter_9_0 == "Z" then
			var_9_23 = 0
		elseif iter_9_0 == "F" then
			var_9_23 = var_0_51(var_9_5)
		elseif iter_9_0 == "g" or iter_9_0 == "f" or iter_9_0 == "x" or iter_9_0 == "w" or iter_9_0 == "d" or iter_9_0 == "s" then
			-- block empty
		elseif iter_9_0 == "0" then
			if var_9_12 == "sp" or var_9_12 == "wsp" then
				var_9_6[#var_9_6] = nil
				var_9_12 = var_9_6[var_1_10024 - 1]

				if var_9_17 then
					local var_9_51, var_9_52 = var_0_3(var_9_17, "([^|]*)|(.*)")

					if not var_9_51 then
						var_9_15 = var_9_17
					elseif var_9_21 then
						var_9_15, var_9_17 = var_9_52, var_9_51
					else
						var_9_15, var_9_17 = var_9_51, var_9_52
					end
				end
			end

			var_9_21 = true
		else
			assert = var_1_10024

			var_1_10024(false)
		end

		if var_9_23 then
			var_9_12 = var_9_23

			if var_0_10000(var_9_23) == "number" then
				var_9_23 = "#" .. var_9_23
			end

			var_9_6[#var_9_6 + 1] = var_9_23
		end
	end

	return var_0_44(arg_9_0, var_9_15 .. var_9_7, var_9_6)
end

local function var_0_54(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 or 0

	local var_10_0

	if not arg_10_2 or not (arg_10_1 + arg_10_2) then
		var_10_0 = #arg_10_0.code
	end

	arg_10_0.pos = arg_10_1
	arg_10_0.rel = nil

	while var_10_0 > arg_10_0.pos do
		var_0_53(arg_10_0)
	end

	return
end

local function var_0_55(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {
		code = arg_11_0,
		addr = arg_11_1 or 0
	}
	local var_11_1

	if not arg_11_2 then
		::label_11_0::

		io = var_11_1
		var_11_1 = var_11_1.write
	end

	var_11_0.out = var_11_1
	var_11_0.symtab = {}
	var_11_0.disass = var_0_54
	var_11_0.hexdump = 8

	return var_11_0
end

local function var_0_56(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_55(arg_12_0, arg_12_1, arg_12_2)

	var_3.disass(var_12_0)

	return
end

local function var_0_57(arg_13_0)
	if arg_13_0 < 32 then
		return var_0_40.x[arg_13_0]
	end

	return var_0_40.d[arg_13_0 - 32]
end

return {
	create = var_0_55,
	disass = var_0_56,
	regname = var_0_57
}
