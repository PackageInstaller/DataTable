local var_0_0 = type
local var_0_1 = string.sub
local var_0_2 = string.byte
local var_0_3 = string.format
local var_0_4 = string.match
local var_0_5 = string.gmatch
local var_0_6 = string.gsub
local var_0_7 = table.concat
local var_0_8 = require("bit")
local var_0_9 = var_0_8.band
local var_0_10 = var_0_8.bor
local var_0_11 = var_0_8.bxor
local var_0_12 = var_0_8.tohex
local var_0_13 = var_0_8.lshift
local var_0_14 = var_0_8.rshift
local var_0_15 = var_0_8.arshift
local var_0_16 = var_0_8.ror
local var_0_17 = {
	[0] = "shift",
	25,
	"mask",
	15,
	{
		shift = 24,
		mask = 49,
		[16] = {
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
		},
		[48] = {
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
				[1] = {
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
				},
				{
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
				},
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
		},
		[32] = {
			{
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
			},
			{
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
			},
			{
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
			},
			shift = 23,
			mask = 3
		},
		[33] = {
			{
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
			},
			{
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
			},
			{
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
			},
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
	},
	{
		[0] = {
			[0] = {
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
			},
			{
				[0] = {
					[0] = {
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
					},
					{
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
					},
					{
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
					},
					shift = 22,
					mask = 3
				},
				{
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
				},
				shift = 21,
				mask = 1
			},
			shift = 24,
			mask = 1
		},
		{
			false,
			[0] = {
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
			},
			{
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
			},
			false,
			"shift",
			21,
			"mask",
			15,
			[4] = {
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
			},
			[6] = {
				[0] = {
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
				},
				{
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
				},
				shift = 30,
				mask = 1
			},
			{
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
			},
			{
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
			},
			{
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
			},
			{
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
			},
			{
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
			},
			{
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
			},
			{
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
			},
			{
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
			},
			[nil] = false,
			[nil] = false
		},
		shift = 28,
		mask = 1
	},
	{
		shift = 24,
		mask = 49,
		[16] = {
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
		},
		[48] = {
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
				[1] = {
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
				},
				{
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
				},
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
		},
		[32] = {
			{
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
			},
			{
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
			},
			{
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
			},
			shift = 23,
			mask = 3
		},
		[33] = {
			{
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
			},
			{
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
			},
			{
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
			},
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
	},
	{
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
	},
	{
		[0] = "shift",
		23,
		"mask",
		7,
		[0] = {
			[0] = "mask",
			1,
			adrDBx = "adrpDBx",
			shift = 31
		},
		[1] = {
			[0] = "mask",
			1,
			adrDBx = "adrpDBx",
			shift = 31
		},
		[2] = {
			[0] = "shift",
			29,
			"mask",
			3,
			["add|movDNIg"] = "adds|cmnD0NIg",
			subDNIg = "subs|cmpD0NIg"
		},
		{
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
		},
		{
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
		},
		{
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
		},
		{
			[0] = 114881,
			["extr|rorDNM4w"] = 65664,
			["extr|rorDNM4x"] = 65665,
			["extr|rorDNM4x"] = "shift",
			[15] = "mask"
		},
		[nil] = nil,
		[nil] = false
	},
	{
		[0] = "shift",
		23,
		"mask",
		7,
		[0] = {
			[0] = "mask",
			1,
			adrDBx = "adrpDBx",
			shift = 31
		},
		[1] = {
			[0] = "mask",
			1,
			adrDBx = "adrpDBx",
			shift = 31
		},
		[2] = {
			[0] = "shift",
			29,
			"mask",
			3,
			["add|movDNIg"] = "adds|cmnD0NIg",
			subDNIg = "subs|cmpD0NIg"
		},
		{
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
		},
		{
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
		},
		{
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
		},
		{
			[0] = 114881,
			["extr|rorDNM4w"] = 65664,
			["extr|rorDNM4x"] = 65665,
			["extr|rorDNM4x"] = "shift",
			[15] = "mask"
		},
		[nil] = nil,
		[nil] = false
	},
	{
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
	},
	{
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
	},
	{
		shift = 24,
		mask = 49,
		[16] = {
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
		},
		[48] = {
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
				[1] = {
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
				},
				{
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
				},
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
		},
		[32] = {
			{
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
			},
			{
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
			},
			{
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
			},
			shift = 23,
			mask = 3
		},
		[33] = {
			{
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
			},
			{
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
			},
			{
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
			},
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
	},
	{
		[0] = {
			[0] = {
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
			},
			{
				[0] = {
					[0] = {
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
					},
					{
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
					},
					{
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
					},
					shift = 22,
					mask = 3
				},
				{
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
				},
				shift = 21,
				mask = 1
			},
			shift = 24,
			mask = 1
		},
		{
			false,
			[0] = {
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
			},
			{
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
			},
			false,
			"shift",
			21,
			"mask",
			15,
			[4] = {
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
			},
			[6] = {
				[0] = {
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
				},
				{
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
				},
				shift = 30,
				mask = 1
			},
			{
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
			},
			{
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
			},
			{
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
			},
			{
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
			},
			{
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
			},
			{
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
			},
			{
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
			},
			{
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
			},
			[nil] = false,
			[nil] = false
		},
		shift = 28,
		mask = 1
	},
	{
		shift = 24,
		mask = 49,
		[16] = {
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
		},
		[48] = {
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
				[1] = {
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
				},
				{
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
				},
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
		},
		[32] = {
			{
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
			},
			{
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
			},
			{
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
			},
			shift = 23,
			mask = 3
		},
		[33] = {
			{
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
			},
			{
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
			},
			{
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
			},
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
	},
	{
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
	},
	[false] = false,
	[false] = false
}
local var_0_18 = {
	x = {},
	w = {},
	d = {},
	s = {}
}

for iter_0_0 = 0, 30 do
	({
		x = {},
		w = {},
		d = {},
		s = {}
	}).x[iter_0_0] = "x" .. iter_0_0
	;({
		x = {},
		w = {},
		d = {},
		s = {}
	}).w[iter_0_0] = "w" .. iter_0_0
	;({
		x = {},
		w = {},
		d = {},
		s = {}
	}).d[iter_0_0] = "d" .. iter_0_0
	;({
		x = {},
		w = {},
		d = {},
		s = {}
	}).s[iter_0_0] = "s" .. iter_0_0
end

;({
	x = {},
	w = {},
	d = {},
	s = {}
}).x[31] = "sp"
;({
	x = {},
	w = {},
	d = {},
	s = {}
}).w[31] = "wsp"
;({
	x = {},
	w = {},
	d = {},
	s = {}
}).d[31] = "d31"
;({
	x = {},
	w = {},
	d = {},
	s = {}
}).s[31] = "s31"

local var_0_19 = {
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
local var_0_20 = {
	[0] = "lsl",
	"lsr",
	"asr"
}
local var_0_21 = {
	[0] = "uxtb",
	"uxth",
	"uxtw",
	"uxtx",
	"sxtb",
	"sxth",
	"sxtw",
	"sxtx"
}

local function var_0_22(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = ""

	if arg_1_0.rel then
		if arg_1_0.symtab[arg_1_0.rel] then
			var_1_0 = "\t->" .. arg_1_0.symtab[arg_1_0.rel]
		end
	end

	if arg_1_0.hexdump > 0 then
		arg_1_0.out(var_0_3("%08x  %s  %-5s %s%s\n", arg_1_0.addr + arg_1_0.pos, var_0_12(arg_1_0.op), arg_1_1, var_0_7(arg_1_2, ", "), var_1_0))
	else
		arg_1_0.out(var_0_3("%08x  %-5s %s%s\n", arg_1_0.addr + arg_1_0.pos, arg_1_1, var_0_7(arg_1_2, ", "), var_1_0))
	end

	arg_1_0.pos = arg_1_0.pos + 4

	return
end

local function var_0_23(arg_2_0)
	return var_0_22(arg_2_0, ".long", {
		"0x" .. var_0_12(arg_2_0.op)
	})
end

local function var_0_24(arg_3_0, arg_3_1, arg_3_2)
	return var_0_18[var_0_4(arg_3_1, arg_3_0 .. "%w-([xwds])")][arg_3_2]
end

local function var_0_25(arg_4_0)
	if arg_4_0 < 0 then
		return var_0_12(arg_4_0)
	else
		return var_0_3("%x", arg_4_0)
	end

	return
end

local var_0_26 = {
	1431655765,
	286331153,
	16843009,
	65537,
	1
}

local function var_0_27(arg_5_0)
	local var_5_0 = var_0_9(var_0_14(arg_5_0, 10), 63)
	local var_5_1 = var_0_9(var_0_14(arg_5_0, 16), 63)

	if var_0_9(arg_5_0, 0) == 0 then
		local var_5_2 = 5

		if var_5_0 >= 56 then
			var_5_2 = var_5_0 >= 60 and 1 or 2
		elseif var_5_0 >= 48 then
			var_5_2 = 3
		elseif var_5_0 >= 32 then
			var_5_2 = 4
		end

		local var_5_3 = var_0_13(1, var_5_2) - 1
		local var_5_4 = var_0_16(var_0_14(-1, 31 - var_0_9(var_5_0, var_5_3)), (var_0_9(var_5_1, var_5_3)))

		if var_5_2 ~= 5 then
			var_5_4 = var_0_9(var_5_4, var_0_13(1, var_5_3) - 1) + var_0_14(var_5_4, 31 - var_5_3)
		end

		local var_5_5 = var_5_4 * var_0_26[var_5_2]
		local var_5_6 = var_0_25(var_5_4 * var_0_26[var_5_2])

		if var_0_14(arg_5_0, 31) ~= 0 then
			return var_5_6 .. var_0_12(var_5_5)
		else
			return var_5_6
		end
	else
		local var_5_7 = -1
		local var_5_8 = 0

		if var_5_0 < 32 then
			var_5_7 = var_0_14(-1, 31 - var_5_0)
		else
			var_5_8 = var_0_14(-1, 63 - var_5_0)
		end

		if var_5_1 ~= 0 then
			var_5_8 = var_0_16(var_5_8, var_5_1)
			var_5_7 = var_0_16(var_5_7, var_5_1)

			local var_5_9 = var_5_1 == 32 and 0 or var_0_9(var_0_11(var_5_7, var_5_8), var_0_13(-1, 32 - var_5_1))

			var_5_8 = var_0_11(var_5_8, var_5_9)
			var_5_7 = var_0_11(var_5_7, var_5_9)

			if var_5_1 >= 32 then
				var_5_8 = var_5_7
				var_5_7 = var_5_8
			end
		end

		if var_5_8 ~= 0 then
			return var_0_25(var_5_8) .. var_0_12(var_5_7)
		else
			return var_0_25(var_5_7)
		end
	end

	return
end

local function var_0_28(arg_6_0, arg_6_1)
	if arg_6_1 == "b" or arg_6_1 == "bl" then
		do return var_0_15(var_0_13(arg_6_0, 6), 4) end

		goto label_6_0
	end

	::label_6_0::

	if arg_6_1 ~= "adr" then
		if arg_6_1 == "adrp" then
			return var_0_10(var_0_13(var_0_15(var_0_13(arg_6_0, 8), 13), 2), (var_0_9(var_0_14(arg_6_0, 29), 3)))
		elseif arg_6_1 == "tbz" or arg_6_1 == "tbnz" then
			return var_0_13(var_0_15(var_0_13(arg_6_0, 13), 18), 2)
		else
			return var_0_13(var_0_15(var_0_13(arg_6_0, 8), 13), 2)
		end

		return
	end
end

local function var_0_29(arg_7_0)
	return (var_0_9(arg_7_0, 0) == 0 and 1 or -1) * (16 + var_0_9(var_0_14(arg_7_0, 13), 15)) * 2^(var_0_11(var_0_14(var_0_15(var_0_13(arg_7_0, 12), 5), 24), 128) - 3)
end

local function var_0_30(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
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

local function var_0_31(arg_9_0)
	local var_9_0, var_9_1, var_9_2, var_9_3 = var_0_2(arg_9_0.code, arg_9_0.pos + 1, arg_9_0.pos + 4)
	local var_9_4 = var_0_10(var_0_13(var_9_3, 24), var_0_13(var_9_2, 16), var_0_13(var_9_1, 8), var_9_0)
	local var_9_5 = {}
	local var_9_6 = ""
	local var_9_10

	arg_9_0.op = var_9_4
	arg_9_0.rel = nil

	local var_9_11
	local var_9_12 = var_0_17[var_0_9(var_0_14(var_9_4, 25), 15)]

	while var_0_0(var_9_12) ~= "string" do
		if not var_9_12 then
			return var_0_23(arg_9_0)
		end

		var_9_12 = var_9_12[var_0_9(var_0_14(var_9_4, var_9_12.shift), var_9_12.mask)] or var_9_12._
	end

	local var_9_14, var_9_15 = var_0_4(var_9_12, "^([a-z0-9]*)(.*)")
	local var_9_16, var_9_17 = var_0_4(var_9_15, "|([a-z0-9_.|]*)(.*)")

	if var_9_16 then
		var_9_15 = var_9_17
	end

	if var_0_1(var_9_15, 1, 1) == "." then
		local var_9_18, var_9_19 = var_0_4(var_9_15, "^([a-z0-9.]*)(.*)")

		var_9_6 = var_9_6 .. var_9_18
		var_9_15 = var_9_19
	end

	local var_9_20 = var_0_4(var_9_15, "[gf]")

	if var_9_20 then
		var_9_10 = var_9_20 == "g" and (var_0_9(var_9_4, 2147483648) ~= 0 and var_0_18.x or var_0_18.w) or var_0_9(var_9_4, 0) ~= 0 and var_0_18.d or var_0_18.s
	end

	local var_9_21
	local var_9_22

	for iter_9_0 in var_0_5(var_9_15, ".") do
		local var_9_23

		if iter_9_0 == "D" then
			local var_9_24 = var_0_9(var_9_4, 31)

			var_9_23 = var_9_20 and var_9_10[var_9_24] or var_0_24(iter_9_0, var_9_15, var_9_24)
		elseif iter_9_0 == "N" then
			local var_9_25 = var_0_9(var_0_14(var_9_4, 5), 31)

			var_9_23 = var_9_20 and var_9_10[var_9_25] or var_0_24(iter_9_0, var_9_15, var_9_25)
		elseif iter_9_0 == "M" then
			local var_9_26 = var_0_9(var_0_14(var_9_4, 16), 31)

			var_9_23 = var_9_20 and var_9_10[var_9_26] or var_0_24(iter_9_0, var_9_15, var_9_26)
		elseif iter_9_0 == "A" then
			local var_9_27 = var_0_9(var_0_14(var_9_4, 10), 31)

			var_9_23 = var_9_20 and var_9_10[var_9_27] or var_0_24(iter_9_0, var_9_15, var_9_27)
		elseif iter_9_0 == "B" then
			local var_9_28 = arg_9_0.addr + arg_9_0.pos + var_0_28(var_9_4, var_9_14)

			arg_9_0.rel = var_9_28
			var_9_23 = "0x" .. var_0_12(var_9_28)
		elseif iter_9_0 == "T" then
			var_9_23 = var_0_10(var_0_9(var_0_14(var_9_4, 26), 32), var_0_9(var_0_14(var_9_4, 19), 31))
		elseif iter_9_0 == "V" then
			var_9_23 = var_0_9(var_9_4, 15)
		elseif iter_9_0 == "C" then
			var_9_23 = var_0_19[var_0_9(var_0_14(var_9_4, 12), 15)]
		elseif iter_9_0 == "c" then
			local var_9_29 = var_0_9(var_0_14(var_9_4, 5), 31)
			local var_9_30 = var_0_9(var_0_14(var_9_4, 16), 31)
			local var_9_31 = var_0_9(var_0_14(var_9_4, 12), 15)
			local var_9_32 = var_0_11(var_9_31, 1)

			var_9_23 = var_0_19[var_9_31]

			if var_9_16 and var_9_31 ~= 14 and var_9_31 ~= 15 then
				local var_9_33, var_9_34 = var_0_4(var_9_16, "([^|]*)|(.*)")

				if var_9_29 == var_9_30 then
					var_9_5[#var_9_5] = nil
					var_9_23 = var_0_19[var_9_32]

					if var_9_29 ~= 31 then
						var_9_14 = var_9_33 and var_9_33 or var_9_16
					else
						var_9_5[#var_9_5 - 1] = nil
						var_9_14 = var_9_34
					end
				end
			end
		elseif iter_9_0 == "W" then
			var_9_23 = var_0_9(var_0_14(var_9_4, 5), 65535)
		elseif iter_9_0 == "Y" then
			var_9_23 = var_0_9(var_0_14(var_9_4, 5), 65535)

			local var_9_35 = var_0_9(var_0_14(var_9_4, 21), 3)

			if var_9_16 and (var_9_35 == 0 or var_9_23 ~= 0) then
				var_9_14 = var_9_16
			end
		elseif iter_9_0 == "L" then
			local var_9_36 = var_0_18.x[var_0_9(var_0_14(var_9_4, 5), 31)]
			local var_9_37 = var_0_15(var_0_13(var_9_4, 11), 23)

			var_9_23 = var_0_9(var_9_4, 2048) ~= 0 and "[" .. var_9_36 .. ", #" .. var_9_37 .. "]!" or "[" .. var_9_36 .. "], #" .. var_9_37
		elseif iter_9_0 == "U" then
			local var_9_38 = var_0_18.x[var_0_9(var_0_14(var_9_4, 5), 31)]
			local var_9_39 = var_0_13(var_0_15(var_0_13(var_9_4, 10), 20), (var_0_9(var_0_14(var_9_4, 30), 3)))

			var_9_23 = var_9_39 ~= 0 and "[" .. var_9_38 .. ", #" .. var_9_39 .. "]" or "[" .. var_9_38 .. "]"
		elseif iter_9_0 == "K" then
			local var_9_40 = var_0_18.x[var_0_9(var_0_14(var_9_4, 5), 31)]
			local var_9_41 = var_0_15(var_0_13(var_9_4, 11), 23)

			var_9_23 = var_9_41 ~= 0 and "[" .. var_9_40 .. ", #" .. var_9_41 .. "]" or "[" .. var_9_40 .. "]"
		elseif iter_9_0 == "O" then
			local var_9_42 = var_0_18.x[var_0_9(var_0_14(var_9_4, 5), 31)]
			local var_9_43 = var_0_9(var_0_14(var_9_4, 13), 1) == 0 and var_0_18.w[var_0_9(var_0_14(var_9_4, 16), 31)] or var_0_18.x[var_0_9(var_0_14(var_9_4, 16), 31)]

			var_9_23 = "[" .. var_9_42 .. ", " .. var_9_43

			local var_9_44 = var_0_9(var_0_14(var_9_4, 13), 7)
			local var_9_45 = var_0_9(var_0_14(var_9_4, 12), 1)
			local var_9_46 = var_0_9(var_0_14(var_9_4, 30), 3)

			var_9_23 = var_9_44 == 3 and (var_9_45 == 0 and var_9_23 .. "]" or var_9_23 .. ", lsl #" .. var_9_46 .. "]") or (var_9_44 == 2 or var_9_44 == 6 or var_9_44 == 7) and (var_9_45 == 0 and var_9_23 .. ", " .. var_0_21[var_9_44] .. "]" or var_9_23 .. ", " .. var_0_21[var_9_44] .. " #" .. var_9_46 .. "]") or var_9_23 .. "]"
		elseif iter_9_0 == "P" then
			local var_9_47 = var_0_14(var_9_4, 26)
			local var_9_48 = 2

			if var_9_47 >= 42 then
				var_9_48 = 4
			elseif var_9_47 >= 27 then
				var_9_48 = 3
			end

			local var_9_49 = var_0_13(var_0_15(var_0_13(var_9_4, 10), 25), var_9_48)
			local var_9_50 = var_0_18.x[var_0_9(var_0_14(var_9_4, 5), 31)]
			local var_9_51 = var_0_9(var_0_14(var_9_4, 23), 3)

			if var_9_51 == 1 then
				var_9_23 = "[" .. var_9_50 .. "], #" .. var_9_49
			elseif var_9_51 == 2 then
				var_9_23 = var_9_49 == 0 and "[" .. var_9_50 .. "]" or "[" .. var_9_50 .. ", #" .. var_9_49 .. "]"
			elseif var_9_51 == 3 then
				var_9_23 = "[" .. var_9_50 .. ", #" .. var_9_49 .. "]!"
			end
		elseif iter_9_0 == "I" then
			local var_9_52 = var_0_9(var_0_14(var_9_4, 22), 3)
			local var_9_53 = var_0_9(var_0_14(var_9_4, 10), 4095)
			local var_9_54 = var_0_9(var_0_14(var_9_4, 5), 31)
			local var_9_55 = var_0_9(var_9_4, 31)

			if var_9_16 == "mov" and var_9_52 == 0 and var_9_53 == 0 and (var_9_54 == 31 or var_9_55 == 31) then
				var_9_14 = var_9_16
				var_9_23 = nil
			elseif var_9_52 == 0 then
				var_9_23 = var_9_53
			elseif var_9_52 == 1 then
				var_9_23 = var_9_53 .. ", lsl #12"
			end
		elseif iter_9_0 == "i" then
			var_9_23 = "#0x" .. var_0_27(var_9_4)
		elseif iter_9_0 == "1" then
			var_9_22 = var_0_9(var_0_14(var_9_4, 16), 63)
			var_9_23 = var_9_22
		elseif iter_9_0 == "2" then
			var_9_23 = var_0_9(var_0_14(var_9_4, 10), 63)

			if var_9_16 then
				local var_9_56, var_9_57, var_9_58, var_9_59, var_9_60, var_9_61 = var_0_4(var_9_16, "([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)|(.*)")
				local var_9_62 = var_0_9(var_0_14(var_9_4, 26), 32)

				if var_0_30(var_9_62, var_0_9(var_0_14(var_9_4, 30), 1), var_9_23, var_9_22) then
					var_9_14 = var_9_57
					var_9_23 = var_9_23 - var_9_22 + 1
				elseif var_9_22 == 0 and var_9_23 == 7 then
					var_9_5[#var_9_5] = nil

					if var_9_62 ~= 0 then
						var_9_5[#var_9_5 - 1] = var_0_6(var_9_5[#var_9_5 - 1], "x", "w")
					end

					var_9_11 = var_9_5[#var_9_5 - 1]
					var_9_14 = var_9_61
					var_9_23 = nil
				elseif var_9_22 == 0 and var_9_23 == 15 then
					var_9_5[#var_9_5] = nil

					if var_9_62 ~= 0 then
						var_9_5[#var_9_5 - 1] = var_0_6(var_9_5[#var_9_5 - 1], "x", "w")
					end

					var_9_11 = var_9_5[#var_9_5 - 1]
					var_9_14 = var_9_60
					var_9_23 = nil
				elseif var_9_23 == 31 or var_9_23 == 63 then
					if var_9_23 == 31 and var_9_22 == 0 and var_9_14 == "sbfm" then
						var_9_14 = var_9_59
						var_9_5[#var_9_5] = nil

						if var_9_62 ~= 0 then
							var_9_5[#var_9_5 - 1] = var_0_6(var_9_5[#var_9_5 - 1], "x", "w")
						end

						var_9_11 = var_9_5[#var_9_5 - 1]
					else
						var_9_14 = var_9_58
					end

					var_9_23 = nil
				elseif var_0_9(var_9_23, 31) ~= 31 and var_9_22 == var_9_23 + 1 and var_9_14 == "ubfm" then
					var_9_14 = var_9_59
					var_9_11 = "#" .. var_9_62 + 32 - var_9_22
					var_9_5[#var_9_5] = "#" .. var_9_62 + 32 - var_9_22
					var_9_23 = nil
				elseif var_9_23 < var_9_22 then
					var_9_14 = var_9_56
					var_9_11 = "#" .. var_9_62 + 32 - var_9_22
					var_9_5[#var_9_5] = "#" .. var_9_62 + 32 - var_9_22
					var_9_23 = var_9_23 + 1
				end
			end
		elseif iter_9_0 == "3" then
			var_9_23 = var_0_9(var_0_14(var_9_4, 10), 63)

			if var_9_16 then
				local var_9_63, var_9_64 = var_0_4(var_9_16, "([^|]*)|(.*)")

				if var_9_23 < var_9_22 then
					var_9_14 = var_9_63
					var_9_11 = "#" .. var_0_9(var_0_14(var_9_4, 26), 32) + 32 - var_9_22
					var_9_5[#var_9_5] = var_9_11
					var_9_23 = var_9_23 + 1
				elseif var_9_22 <= var_9_23 then
					var_9_14 = var_9_64
					var_9_23 = var_9_23 - var_9_22 + 1
				end
			end
		elseif iter_9_0 == "4" then
			var_9_23 = var_0_9(var_0_14(var_9_4, 10), 63)

			local var_9_65 = var_0_9(var_0_14(var_9_4, 5), 31)
			local var_9_66 = var_0_9(var_0_14(var_9_4, 16), 31)

			if var_9_16 and var_9_65 == var_9_66 then
				var_9_5[#var_9_5] = nil
				var_9_11 = var_9_5[#var_9_5 - 1]
				var_9_14 = var_9_16
			end
		elseif iter_9_0 == "5" then
			var_9_23 = var_0_9(var_0_14(var_9_4, 16), 31)
		elseif iter_9_0 == "S" then
			var_9_23 = var_0_9(var_0_14(var_9_4, 10), 63)

			if var_9_23 == 0 then
				var_9_23 = nil
			else
				var_9_23 = var_0_20[var_0_9(var_0_14(var_9_4, 22), 3)] .. " #" .. var_9_23
			end
		elseif iter_9_0 == "X" then
			local var_9_67 = var_0_9(var_0_14(var_9_4, 13), 7)

			if var_9_67 ~= 3 and var_9_67 ~= 7 then
				var_9_11 = var_0_18.w[var_0_9(var_0_14(var_9_4, 16), 31)]
				var_9_5[#var_9_5] = var_9_11
			end

			var_9_23 = var_0_9(var_0_14(var_9_4, 10), 7)

			if var_9_67 == 2 + var_0_9(var_0_14(var_9_4, 31), 1) and var_0_9(var_0_14(var_9_4, var_9_21 and 5 or 0), 31) == 31 then
				if var_9_23 == 0 then
					var_9_23 = nil
				else
					var_9_23 = "lsl #" .. var_9_23
				end
			else
				var_9_23 = var_9_23 == 0 and var_0_21[var_0_9(var_0_14(var_9_4, 13), 7)] or var_0_21[var_0_9(var_0_14(var_9_4, 13), 7)] .. " #" .. var_9_23
			end
		elseif iter_9_0 == "R" then
			var_9_23 = var_0_9(var_0_14(var_9_4, 21), 3)

			if var_9_23 == 0 then
				var_9_23 = nil
			else
				var_9_23 = "lsl #" .. var_9_23 * 16
			end
		elseif iter_9_0 == "z" then
			if var_9_5[#var_9_5] == "sp" then
				var_9_5[#var_9_5] = "xzr"
			elseif var_9_5[#var_9_5] == "wsp" then
				var_9_5[#var_9_5] = "wzr"
			end
		elseif iter_9_0 == "Z" then
			var_9_23 = 0
		elseif iter_9_0 == "F" then
			var_9_23 = var_0_29(var_9_4)
		elseif iter_9_0 == "g" or iter_9_0 == "f" or iter_9_0 == "x" or iter_9_0 == "w" or iter_9_0 == "d" or iter_9_0 == "s" then
			-- block empty
		elseif iter_9_0 == "0" then
			if var_9_11 == "sp" or var_9_11 == "wsp" then
				local var_9_68 = #var_9_5

				var_9_5[#var_9_5] = nil
				var_9_11 = var_9_5[var_9_68 - 1]

				if var_9_16 then
					local var_9_69, var_9_70 = var_0_4(var_9_16, "([^|]*)|(.*)")

					if not var_9_69 then
						var_9_14 = var_9_16
					else
						if var_9_21 then
							var_9_16 = var_9_69
							var_9_14 = var_9_70

							goto label_9_0

							var_9_16 = var_9_70
						end

						var_9_14 = var_9_69
					end
				end
			end

			::label_9_0::

			var_9_21 = true
		else
			assert(false)
		end

		if var_9_23 then
			var_9_11 = var_9_23

			if var_0_0(var_9_23) == "number" then
				var_9_23 = "#" .. var_9_23
			end

			var_9_5[#var_9_5 + 1] = var_9_23
		end
	end

	return var_0_22(arg_9_0, var_9_14 .. var_9_6, var_9_5)
end

local function var_0_32(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 or 0

	if arg_10_2 then
		local var_10_0 = arg_10_1 + arg_10_2 or #arg_10_0.code

		arg_10_0.pos = arg_10_1
		arg_10_0.rel = nil

		while var_10_0 > arg_10_0.pos do
			var_0_31(arg_10_0)
		end

		return
	end
end

return {
	create = function(arg_11_0, arg_11_1, arg_11_2)
		({
			code = arg_11_0,
			addr = arg_11_1 or 0,
			out = arg_11_2 or io.write,
			symtab = {},
			disass = var_0_32
		}).hexdump = 8

		return {
			code = arg_11_0,
			addr = arg_11_1 or 0,
			out = arg_11_2 or io.write,
			symtab = {},
			disass = var_0_32
		}
	end,
	disass = function(arg_12_0, arg_12_1, arg_12_2)
		var_0(arg_12_0, arg_12_1, arg_12_2):disass()

		return
	end,
	regname = function(arg_13_0)
		if arg_13_0 < 32 then
			return var_0_18.x[arg_13_0]
		end

		return var_0_18.d[arg_13_0 - 32]
	end
}
