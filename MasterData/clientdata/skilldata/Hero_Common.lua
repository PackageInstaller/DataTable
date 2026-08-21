-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_Common.lua

local Data = {
	cueFile = "85001",
	[1000101] = {
		bhEvent = "skill.1000101",
		atkEvents = {
			[0] = {
				state = {}
			},
			[1001] = {
				boxId = 1400560,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1002] = {
				boxId = 1000101,
				state = {},
				hitCue = {
					cueList = {
						10000024
					}
				}
			},
			[1003] = {
				state = {
					duration = -999,
					stateId = 3311702
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311702
					}
				}
			},
			[1005] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 3300711
				}
			},
			[1006] = {
				boxId = 8350660,
				eventType = 1,
				state = {}
			},
			[1007] = {
				eventCondition = "1,2,1401411",
				boxId = 1401420,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1008] = {
				disablePassive = 1,
				boxId = 3311821,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010032
					}
				}
			}
		}
	},
	[1000121] = {
		skillTarget = 1,
		bhEvent = "skill.1000121",
		atkEvents = {
			[1001] = {
				addManaNumber = 25,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				boxId = 1400560,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1003] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300403
				}
			},
			[1004] = {
				targetArea = 3,
				summonMonsters = "10500012",
				state = {}
			},
			[1005] = {
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "10401011",
				state = {}
			},
			[1007] = {
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = 30,
				state = {}
			},
			[1008] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 9900001
				}
			},
			[1009] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			},
			[1010] = {
				addManaNumber = 70,
				targetArea = 3,
				state = {}
			},
			[1011] = {
				targetArea = 3,
				state = {
					duration = 90,
					stateId = 9900007
				}
			},
			[1012] = {
				targetArea = 3,
				state = {
					duration = 999,
					stateId = 9900008
				},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1013] = {
				targetArea = 3,
				boxId = 1200229,
				targetChoose = 15,
				addManaNumber = 15,
				state = {},
				hitCue = {
					cueList = {
						10000035,
						10000008
					}
				}
			},
			[1014] = {
				boxId = 1500329,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1015] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1500659,
				delay = 0.25,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000078
					}
				}
			},
			[1016] = {
				targetArea = 3,
				addManaNumber = 10,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1017] = {
				boxId = 1100001,
				targetArea = 3,
				state = {}
			},
			[1018] = {
				boxId = 1200001,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000044,
						10000047,
						10006004
					}
				}
			},
			[1019] = {
				targetArea = 3,
				state = {
					stateId = 1300002,
					stateCondition = 1,
					duration = 1.2
				}
			},
			[1020] = {
				randomTargetNumber = 1,
				targetArea = 3,
				boxId = 1500001,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						10000045,
						10000047
					}
				}
			},
			[1021] = {
				delay = 0.5,
				boxId = 3310252,
				flyCueId = 10000036,
				boxType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1022] = {
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = 15,
				state = {}
			},
			[1023] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100021
				}
			},
			[1024] = {
				targetArea = 3,
				addManaNumber = 10,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1025] = {
				targetArea = 3,
				addManaNumber = 20,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1026] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100023
				}
			},
			[1027] = {
				targetArea = 3,
				state = {
					duration = 30,
					stateId = 9900012
				},
				hitCue = {
					cueList = {
						850010008
					}
				}
			},
			[1028] = {
				state = {},
				hitCue = {
					cueList = {
						10000037
					}
				}
			},
			[1029] = {
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = -30,
				state = {}
			},
			[1030] = {
				targetChoose = 15,
				targetArea = 3,
				addManaNumber = 20,
				state = {}
			},
			[1031] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1500804
					}
				}
			},
			[1032] = {
				boxId = 1000101,
				disablePassive = 1,
				state = {}
			},
			[1033] = {
				boxId = 1000103,
				disablePassive = 1,
				state = {}
			},
			[1034] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3200102
				},
				hitCue = {
					cueList = {
						10000048
					}
				}
			},
			[1035] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100027
				}
			},
			[1036] = {
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = 20,
				state = {}
			},
			[1037] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						10006004
					}
				}
			},
			[1038] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 5,
					stateId = 1400202
				}
			},
			[1039] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1320105
				}
			},
			[1040] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						9100030
					}
				}
			},
			[1041] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1320101
					}
				}
			},
			[1042] = {
				boxId = 1320129,
				eventType = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1320101
					}
				}
			},
			[1043] = {
				boxId = 1420131,
				targetArea = 2,
				state = {}
			},
			[1044] = {
				boxId = 1200002,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000044,
						10000047,
						10006004
					}
				}
			},
			[1045] = {
				targetArea = 3,
				state = {
					stateId = 1300004,
					stateCondition = 1,
					duration = 1.2
				}
			},
			[1046] = {
				randomTargetNumber = 1,
				targetArea = 3,
				boxId = 1500002,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						10000045,
						10000047
					}
				}
			},
			[1047] = {
				boxId = 1100001,
				targetArea = 3,
				addManaNumber = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1048] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1300031,
						1300033
					}
				}
			},
			[1049] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1300031
				}
			},
			[1050] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1400032
				}
			},
			[1051] = {
				boxId = 1400001,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1052] = {
				randomTargetNumber = 1,
				boxId = 1500003,
				targetChoose = 7,
				targetArea = 3,
				addManaNumber = 3,
				state = {
					duration = -999,
					stateId = 1500031
				},
				hitCue = {
					cueList = {
						10000045,
						10000047
					}
				},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 5
					},
					[3] = {
						addManaNumber = 6
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1053] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1500031
					}
				}
			},
			[1054] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100101
				}
			},
			[1055] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100103
				}
			},
			[1056] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100104
				}
			},
			[1057] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100105
				}
			},
			[1058] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100106
				}
			},
			[1059] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100107
				}
			},
			[1060] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 3300711
				}
			},
			[1061] = {
				boxId = 3311430,
				disablePassive = 1,
				state = {},
				hitCue = {
					cueList = {
						850010032
					}
				}
			},
			[1062] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100109
				}
			},
			[1063] = {
				boxId = 1520129,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1064] = {
				targetChoose = 10,
				targetArea = 3,
				addManaNumber = 10,
				state = {}
			},
			[1065] = {
				boxType = 1,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1520106,
						8350012
					}
				}
			},
			[1066] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						10000070
					}
				}
			},
			[1067] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100112
				}
			},
			[1068] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100114
				}
			},
			[1069] = {
				excludeTarget = 1,
				notRecordLastDamage = 1,
				boxId = 1401160,
				disableHpPassive = 1,
				eventType = 1,
				disablePassive = 1,
				targetChoose = 3,
				state = {
					duration = 2,
					stateOperation = 2,
					chooseStateMode = 2,
					chooseStateIds = {
						1401103
					}
				},
				hitCue = {
					cueList = {
						10000074
					}
				},
				baseCue = {
					cueList = {
						10000073
					}
				}
			},
			[1070] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1220301,
						1220303
					}
				}
			},
			[1071] = {
				state = {
					duration = -999,
					stateId = 1220303
				}
			},
			[1072] = {
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000077
					}
				}
			},
			[1073] = {
				manaNotShow = 1,
				addManaNumber = -40,
				state = {}
			},
			[1074] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1300033
				}
			},
			[1075] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						10000081
					}
				}
			},
			[1076] = {
				manaNotShow = 1,
				addManaNumber = 60,
				state = {}
			},
			[1077] = {
				boxId = 1000013,
				eventType = 1,
				state = {}
			},
			[1078] = {
				excludeTarget = 1,
				notRecordLastDamage = 1,
				boxId = 1420229,
				disableHpPassive = 1,
				eventType = 1,
				disablePassive = 1,
				targetChoose = 3,
				state = {},
				baseCue = {
					cueList = {
						10000084
					}
				}
			},
			[1079] = {
				targetArea = 3,
				state = {
					stateId = 1420204,
					stateCondition = 2,
					duration = 1.2
				}
			},
			[1080] = {
				eventCondition = "1,1,1210211",
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1210213
				}
			},
			[1081] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3210842
				}
			},
			[1082] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100120
				}
			},
			[1083] = {
				addManaNumber = -10,
				state = {}
			},
			[1084] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1101103
					}
				}
			},
			[1085] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1101106
					}
				}
			},
			[1086] = {
				boxId = 1101152,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1101107
					}
				}
			},
			[1087] = {
				boxId = 1420132,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1088] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1500606
				}
			},
			[1089] = {
				boxId = 1500629,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1090] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301504
					}
				}
			},
			[1091] = {
				targetChoose = 23,
				summonMonsters = "1620500,1620500",
				state = {}
			},
			[1092] = {
				targetChoose = 23,
				summonMonsters = "1620600",
				state = {}
			},
			[1093] = {
				subEventId = 1094,
				subEventSkill = 1000121,
				boxId = 1310531,
				targetChoose = 23,
				state = {}
			},
			[1094] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						82131051
					}
				}
			},
			[1095] = {
				boxId = 1401410,
				targetArea = 3,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1401403
				},
				hitCue = {
					cueList = {
						10000054
					}
				}
			},
			[1096] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401402
					}
				}
			},
			[1097] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401402
				}
			},
			[1098] = {
				randomTargetNumber = 1,
				targetArea = 3,
				targetChoose = 3,
				state = {
					duration = -999,
					stateId = 1401401
				}
			},
			[1099] = {
				boxId = 1401410,
				targetChoose = 7,
				state = {}
			},
			[1100] = {
				targetChoose = 9,
				state = {
					duration = 5,
					stateId = 810016
				}
			},
			[1101] = {
				disablePassive = 1,
				boxType = 1,
				delay = 0.2,
				boxId = 1110231,
				disableHpPassive = 1,
				state = {}
			},
			[1102] = {
				targetChoose = 7,
				targetArea = 3,
				eventCondition = "1,2,1401106",
				state = {
					duration = 5,
					stateId = 1401108
				}
			},
			[1103] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1410202
				}
			},
			[1104] = {
				delay = 0.5,
				boxType = 1,
				targetArea = 3,
				addManaNumber = 20,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1410229,
						state = {
							chooseStateType = 2,
							stateOperation = 1,
							chooseRandomNum = 1
						}
					},
					[3] = {
						boxId = 1410229,
						state = {
							chooseStateType = 2,
							stateOperation = 1,
							chooseRandomNum = 1
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1105] = {
				boxId = 1410230,
				disablePassive = 1,
				state = {}
			},
			[1106] = {
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1110208,
						1110211
					}
				}
			},
			[1107] = {
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1110212
				}
			},
			[1108] = {
				targetArea = 3,
				state = {
					duration = 7,
					stateId = 1410203
				}
			},
			[1109] = {
				boxId = 102000529,
				eventType = 1,
				state = {}
			},
			[1110] = {
				boxId = 102000829,
				eventType = 1,
				state = {}
			},
			[1111] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						102000903
					}
				}
			},
			[1112] = {
				addManaNumber = -6,
				targetChoose = 23,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = -9
					},
					[3] = {
						addManaNumber = -12
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1113] = {
				boxId = 2020030,
				targetArea = 3,
				state = {}
			},
			[1114] = {
				boxId = 103000129,
				eventType = 1,
				state = {}
			},
			[1115] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1101218
					}
				}
			},
			[1116] = {
				state = {
					chooseRandomNum = 3311828,
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311828
					}
				}
			},
			[1117] = {
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1401414
				}
			},
			[1118] = {
				delay = 0.2,
				boxId = 1510262,
				stunTime = 0.5,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000104
					}
				}
			},
			[1119] = {
				targetArea = 1,
				state = {
					duration = 0.2,
					stateId = 1510258
				}
			},
			[1120] = {
				eventCondition = "1,2,1401411",
				boxId = 1401420,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1121] = {
				addManaNumber = 5,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 810017
				}
			},
			[1122] = {
				disablePassive = 1,
				boxId = 8350310,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1123] = {
				boxId = 1401633,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1124] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401505
					}
				}
			},
			[1125] = {
				boxId = 1401529,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000102
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1401508
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1401508
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1126] = {
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1401512
				}
			},
			[1127] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1510204
					}
				}
			},
			[1128] = {
				boxId = 1110430,
				targetArea = 3,
				disablePassive = 1,
				state = {}
			},
			[1129] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8350342
					}
				}
			},
			[1130] = {
				subEventId = 1131,
				subEventSkill = 1000121,
				state = {}
			},
			[1131] = {
				filterChuyin = 1,
				subEventId = 1132,
				subEventSkill = 1000121,
				targetChoose = 7,
				excludeTarget = 1,
				state = {}
			},
			[1132] = {
				disablePassive = 1,
				eventCondition = "1,2,1310901",
				boxId = 1310930,
				disableHpPassive = 1,
				eventType = 1,
				state = {}
			},
			[1133] = {
				targetArea = 2,
				state = {
					duration = 3,
					stateId = 1310902
				}
			},
			[1134] = {
				eventCondition = "1,1,1110404",
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1110455
				}
			},
			[1135] = {
				eventCondition = "1,1,1110404",
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1110404
					}
				}
			},
			[1136] = {
				targetArea = 3,
				boxId = 2380020,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1137] = {
				randomTargetNumber = 1,
				targetChoose = 20,
				state = {
					duration = 5,
					stateId = 810018
				}
			},
			[1138] = {
				boxId = 1510330,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1139] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						9100521
					}
				}
			},
			[1140] = {
				targetChoose = 10,
				state = {
					duration = 2,
					stateId = 9100607
				}
			},
			[1141] = {
				targetChoose = 10,
				state = {
					duration = 2,
					stateId = 9100608
				}
			},
			[1142] = {
				targetChoose = 10,
				state = {
					duration = 2,
					stateId = 9100609
				}
			},
			[1143] = {
				targetChoose = 10,
				state = {
					duration = 2,
					stateId = 9100610
				}
			},
			[1144] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100618
				}
			},
			[1145] = {
				targetChoose = 10,
				state = {
					duration = 2,
					stateId = 9100616
				}
			},
			[1146] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 9100617
				}
			},
			[1147] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						9100618
					}
				}
			},
			[1148] = {
				targetChoose = 10,
				state = {
					duration = 2,
					stateId = 9100626
				}
			},
			[1149] = {
				targetChoose = 10,
				state = {
					duration = 2,
					stateId = 9100622
				}
			},
			[1150] = {
				targetChoose = 10,
				state = {
					duration = 2,
					stateId = 9100623
				}
			},
			[1151] = {
				targetChoose = 10,
				state = {
					duration = 2,
					stateId = 9100624
				}
			},
			[1152] = {
				targetChoose = 10,
				state = {
					duration = 2,
					stateId = 9100625
				}
			},
			[1153] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100627
				}
			},
			[1154] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100628
				}
			},
			[1155] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100629
				}
			},
			[1156] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100630
				}
			},
			[1157] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100631
				}
			},
			[1158] = {
				eventCondition = "1,1,9100627,1",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100618
				}
			},
			[1159] = {
				eventCondition = "1,1,9100628,1",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100618
				}
			},
			[1160] = {
				eventCondition = "1,1,9100629,1",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100618
				}
			},
			[1161] = {
				eventCondition = "1,1,9100630,1",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100618
				}
			},
			[1162] = {
				eventCondition = "1,1,9100631,1",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100618
				}
			},
			[1163] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100611
				}
			},
			[1164] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100612
				}
			},
			[1165] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100613
				}
			},
			[1166] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100614
				}
			},
			[1167] = {
				targetChoose = 10,
				state = {
					duration = -999,
					stateId = 2380031
				}
			},
			[1168] = {
				targetChoose = 10,
				state = {
					duration = -999,
					stateId = 2380032
				}
			},
			[1169] = {
				disablePassive = 1,
				boxId = 2380040,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1170] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100618
				}
			},
			[1171] = {
				eventCondition = "1,2,1402001",
				boxId = 1402029,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1172] = {
				disablePassive = 1,
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 103000304
				}
			},
			[1173] = {
				boxId = 1201331,
				targetChoose = 23,
				state = {}
			},
			[1174] = {
				subEventId = 1175,
				subEventSkill = 1000121,
				boxId = 1620829,
				targetArea = 3,
				state = {}
			},
			[1175] = {
				boxType = 1,
				delay = 0.2,
				boxId = 1620829,
				targetArea = 3,
				state = {}
			},
			[1176] = {
				boxId = 810019,
				targetArea = 3,
				targetChoose = 18,
				state = {}
			},
			[1177] = {
				boxId = 1520359,
				targetArea = 1,
				state = {}
			},
			[1178] = {
				disablePassive = 1,
				excludeTarget = 1,
				boxId = 1520360,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1179] = {
				boxId = 1402132,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1180] = {
				boxId = 1402133,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1181] = {
				boxId = 810020,
				targetArea = 3,
				state = {}
			},
			[1182] = {
				disablePassive = 1,
				subEventSkill = 1000121,
				subEventId = 1189,
				targetArea = 3,
				state = {
					chooseStateMode = 1,
					stateOperation = 1
				},
				hitCue = {
					cueList = {
						10000110
					}
				}
			},
			[1183] = {
				subEventId = 1188,
				eventCondition = "1,2,1410401",
				subEventSkill = 1000121,
				targetChoose = 23,
				state = {}
			},
			[1184] = {
				targetChoose = 18,
				subEventId = 1183,
				subEventSkill = 1000121,
				targetArea = 3,
				state = {
					duration = 1.1,
					stateId = 1410413
				}
			},
			[1185] = {
				boxId = 1410429,
				targetArea = 1,
				state = {}
			},
			[1186] = {
				targetChoose = 7,
				subEventType = 1,
				subEventSkill = 1000121,
				subEventId = 1187,
				targetArea = 3,
				eventCondition = "1,2,8791741",
				state = {}
			},
			[1187] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 8791742
				}
			},
			[1188] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1410406
				}
			},
			[1189] = {
				disablePassive = 1,
				boxId = 1620829,
				delay = 0.1,
				boxType = 1,
				targetArea = 3,
				eventType = 1,
				state = {}
			},
			[1190] = {
				addManaNumber = 15,
				targetArea = 1,
				state = {}
			},
			[1191] = {
				addManaNumber = -15,
				targetChoose = 9,
				state = {
					duration = 5,
					stateId = 810021
				}
			},
			[1192] = {
				boxId = 3300205,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1193] = {
				boxId = 810022,
				targetChoose = 23,
				eventType = 1,
				state = {}
			}
		}
	},
	[1000151] = {
		bhEvent = "skill.1000151",
		atkEvents = {
			[1001] = {
				boxId = 1000101,
				eventType = 1,
				state = {}
			},
			[1002] = {
				boxId = 1000103,
				eventType = 1,
				state = {}
			},
			[1003] = {
				boxId = 3300752,
				targetArea = 4,
				disablePassive = 1,
				state = {}
			},
			[1004] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 9900019
				}
			},
			[1005] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 9900022
				}
			},
			[1006] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1520107
					}
				}
			},
			[1007] = {
				state = {},
				atkCue = {
					cueList = {
						10000107
					}
				}
			},
			[1008] = {
				delay = 0.3,
				boxId = 1101361,
				boxType = 1,
				targetChoose = 7,
				eventCondition = "1,2,1101306",
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000109
					}
				}
			},
			[1009] = {
				eventCondition = "1,1,1101304,1",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101303
				}
			},
			[1010] = {
				eventCondition = "1,1,1101316",
				boxId = 1101329,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1011] = {
				eventCondition = "1,1,1101304,1",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101323
				}
			},
			[1012] = {
				eventCondition = "1,1,1101324",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101321
				}
			},
			[1013] = {
				eventCondition = "1,1,1101324,1",
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1101316
					}
				}
			},
			[1014] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1101316
					}
				}
			},
			[1015] = {
				eventCondition = "1,1,1101316",
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = 2,
				state = {}
			},
			[1016] = {
				unitDelay = 0.1,
				boxId = 1402162,
				flyCueId = 140210016,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1017] = {
				unitDelay = 0.1,
				boxId = 1402163,
				flyCueId = 140210016,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1018] = {
				addManaNumber = -15,
				targetChoose = 9,
				state = {
					duration = 5,
					stateId = 810021
				}
			},
			[1019] = {
				eventCondition = "1,1,1000001",
				targetArea = 3,
				state = {
					duration = 1.1,
					stateId = 1410502
				}
			}
		}
	},
	[1000122] = {
		bhEvent = "skill.1000122",
		atkEvents = {
			[1001] = {
				boxId = 8230010,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				boxId = 8230040,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010003
					}
				}
			},
			[1003] = {
				disablePassive = 1,
				boxId = 8230060,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010003
					}
				}
			},
			[1004] = {
				disablePassive = 1,
				targetArea = 2,
				boxId = 8230070,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010010
					}
				}
			},
			[1005] = {
				disablePassive = 1,
				targetArea = 3,
				boxId = 8230080,
				targetChoose = 7,
				randomTargetNumber = 1,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1006] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 10,
					stateId = 8230090
				},
				hitCue = {
					cueList = {
						10000001
					}
				}
			},
			[1007] = {
				disablePassive = 1,
				boxId = 8240010,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1008] = {
				disablePassive = 1,
				boxId = 8240040,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010003
					}
				}
			},
			[1009] = {
				disablePassive = 1,
				boxId = 8240060,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010003
					}
				}
			},
			[1010] = {
				disablePassive = 1,
				targetArea = 2,
				boxId = 8240070,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010010
					}
				}
			},
			[1011] = {
				disablePassive = 1,
				targetArea = 3,
				boxId = 8240080,
				targetChoose = 7,
				randomTargetNumber = 1,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1012] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 10,
					stateId = 8240090
				},
				hitCue = {
					cueList = {
						10000001
					}
				}
			},
			[1013] = {
				disablePassive = 1,
				boxId = 8250010,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1014] = {
				disablePassive = 1,
				boxId = 8250040,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010003
					}
				}
			},
			[1015] = {
				disablePassive = 1,
				boxId = 8250041,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1016] = {
				disablePassive = 1,
				boxId = 8250060,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010003
					}
				}
			},
			[1017] = {
				disablePassive = 1,
				boxId = 8250061,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1018] = {
				disablePassive = 1,
				targetArea = 2,
				boxId = 8250070,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 8250071
				},
				hitCue = {
					cueList = {
						850010010
					}
				}
			},
			[1019] = {
				randomTargetNumber = 1,
				targetArea = 3,
				boxId = 8250080,
				targetChoose = 7,
				excludeTarget = 1,
				state = {
					duration = 5,
					stateId = 8250081
				},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1020] = {
				targetChoose = 7,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 20,
				state = {
					duration = 10,
					stateId = 8250090
				},
				hitCue = {
					cueList = {
						10000001
					}
				}
			},
			[1021] = {
				disablePassive = 1,
				boxId = 8250100,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1022] = {
				disablePassive = 1,
				boxType = 1,
				delay = 0.05,
				boxId = 8230030,
				eventType = 1,
				state = {}
			},
			[1023] = {
				disablePassive = 1,
				targetArea = 3,
				boxId = 8230110,
				targetChoose = 13,
				state = {}
			},
			[1024] = {
				disablePassive = 1,
				boxId = 8230130,
				targetArea = 3,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						8230131,
						8240131,
						8250131
					}
				},
				hitCue = {
					cueList = {
						850010013
					}
				}
			},
			[1025] = {
				disablePassive = 1,
				boxType = 1,
				delay = 0.05,
				boxId = 8240030,
				eventType = 1,
				state = {}
			},
			[1026] = {
				disablePassive = 1,
				targetArea = 3,
				boxId = 8240110,
				targetChoose = 13,
				state = {}
			},
			[1027] = {
				disablePassive = 1,
				boxId = 8240130,
				targetArea = 3,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						8230131,
						8240131,
						8250131
					}
				},
				hitCue = {
					cueList = {
						850010013
					}
				}
			},
			[1028] = {
				disablePassive = 1,
				boxType = 1,
				delay = 0.05,
				boxId = 8250030,
				eventType = 1,
				state = {}
			},
			[1029] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1030] = {
				disablePassive = 1,
				targetArea = 3,
				boxId = 8250110,
				targetChoose = 13,
				state = {}
			},
			[1031] = {
				disablePassive = 1,
				boxId = 8250130,
				targetArea = 3,
				addManaNumber = 20,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						8230131,
						8240131,
						8250131
					}
				},
				hitCue = {
					cueList = {
						850010013
					}
				}
			},
			[1032] = {
				boxId = 8250141,
				targetArea = 3,
				state = {}
			},
			[1033] = {
				addManaNumber = 20,
				targetArea = 3,
				state = {}
			},
			[1034] = {
				delay = 0.1,
				targetArea = 3,
				boxType = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8230131,
						8240131,
						8250131
					}
				}
			},
			[1035] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1000124] = {
		bhEvent = "skill.1000124",
		atkEvents = {
			[1001] = {
				targetArea = 2,
				boxId = 8520030,
				targetChoose = 3,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						850010017
					}
				},
				hitCue = {
					cueList = {
						850010009
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				randomTargetNumber = 1,
				boxId = 8520040,
				targetChoose = 3,
				excludeTarget = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010018
					}
				}
			},
			[1003] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 8540010,
				delay = 0.2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010020
					}
				}
			},
			[1004] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1005] = {
				boxId = 8540040,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1006] = {
				boxId = 8540060,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1007] = {
				boxId = 8540070,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8540070
					}
				},
				hitCue = {
					cueList = {
						850010021
					}
				}
			},
			[1008] = {
				state = {
					duration = 5,
					stateId = 1000001
				},
				hitCue = {
					cueList = {
						10000024
					}
				}
			},
			[1009] = {
				boxId = 8540090,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1010] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			},
			[1011] = {
				boxType = 1,
				delay = 0.1,
				boxId = 8540110,
				excludeTarget = 1,
				eventType = 1,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						850010023
					}
				},
				baseCue = {
					cueList = {
						850010022
					}
				}
			},
			[1012] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 8540141
				},
				hitCue = {
					cueList = {
						10000001
					}
				}
			},
			[1013] = {
				targetChoose = 7,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 30,
				state = {}
			},
			[1014] = {
				targetArea = 3,
				boxId = 8540160,
				targetChoose = 7,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1015] = {
				targetArea = 2,
				boxId = 8540170,
				delay = 0.2,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						850010024
					}
				},
				hitCue = {
					cueList = {
						850010025
					}
				}
			},
			[1016] = {
				addManaNumber = 25,
				targetArea = 3,
				state = {}
			},
			[1017] = {
				targetArea = 2,
				boxId = 8540200,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						850010026
					}
				}
			},
			[1018] = {
				targetChoose = 7,
				targetArea = 2,
				state = {
					duration = 8,
					stateId = 1500101
				}
			},
			[1019] = {
				boxId = 8540220,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1020] = {
				targetChoose = 7,
				targetArea = 2,
				state = {
					duration = -999,
					stateId = 8540231
				}
			},
			[1021] = {
				targetChoose = 7,
				targetArea = 2,
				state = {
					duration = -999,
					stateId = 8540241
				}
			},
			[1022] = {
				boxId = 8540250,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						850010030
					}
				}
			},
			[1023] = {
				boxId = 8500010,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1024] = {
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1025] = {
				controlTime = 2,
				controlAniName = "freeze",
				state = {}
			},
			[1026] = {
				targetArea = 3,
				addManaNumber = 15,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1027] = {
				state = {
					duration = 8,
					stateId = 1000001
				}
			},
			[1028] = {
				state = {
					duration = 8,
					stateId = 1000003
				}
			},
			[1029] = {
				stunTime = 2.5,
				state = {}
			},
			[1030] = {
				delay = 0.5,
				boxId = 8540380,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010009
					}
				}
			},
			[1031] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 8540390,
				delay = 0.2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010018
					}
				}
			},
			[1032] = {
				boxId = 8540400,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1033] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 8590040,
				delay = 0.25,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010018
					}
				}
			},
			[1034] = {
				boxId = 8590050,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1035] = {
				excludeTarget = 1,
				boxId = 8590060,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010023
					}
				},
				baseCue = {
					cueList = {
						850010022
					}
				}
			},
			[1036] = {
				boxId = 8590080,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						850010013
					}
				}
			},
			[1037] = {
				disablePassive = 1,
				boxId = 8590120,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						850010026
					}
				}
			},
			[1038] = {
				boxId = 8590140,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1039] = {
				targetArea = 3,
				addManaNumber = 10,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1040] = {
				boxId = 8590200,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1041] = {
				boxId = 8540250,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						850010030
					}
				}
			},
			[1042] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			},
			[1043] = {
				targetArea = 2,
				boxId = 8590020,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						850010026
					}
				}
			},
			[1044] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 8590130,
				delay = 0.1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010020
					}
				}
			},
			[1045] = {
				addManaNumber = 15,
				targetArea = 3,
				state = {}
			},
			[1046] = {
				targetArea = 2,
				boxId = 8590190,
				delay = 0.2,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						850010024
					}
				},
				hitCue = {
					cueList = {
						850010025
					}
				}
			},
			[1047] = {
				targetArea = 3,
				boxId = 8590230,
				targetChoose = 7,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1048] = {
				targetChoose = 7,
				targetArea = 2,
				state = {
					duration = 10,
					stateId = 1500101
				}
			},
			[1049] = {
				boxId = 8590250,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1050] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1051] = {
				controlTime = 3,
				controlAniName = "freeze",
				state = {}
			},
			[1052] = {
				boxId = 8500070,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			}
		}
	},
	[1000125] = {
		bhEvent = "skill.1000101",
		atkEvents = {
			[1001] = {
				disablePassive = 1,
				boxId = 8611010,
				targetArea = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000050
					}
				}
			},
			[1002] = {
				boxId = 8612040,
				targetArea = 4,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1003] = {
				targetArea = 4,
				boxId = 8613010,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = 2,
					stateId = 8613020
				}
			},
			[1005] = {
				disablePassive = 1,
				targetArea = 4,
				boxId = 8613030,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1006] = {
				disablePassive = 1,
				targetArea = 4,
				stunTime = 3,
				boxId = 8613040,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1007] = {
				targetChoose = 7,
				targetArea = 4,
				addManaNumber = 30,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1008] = {
				targetArea = 4,
				boxId = 8614020,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						10000060
					}
				}
			},
			[1009] = {
				targetChoose = 7,
				targetArea = 4,
				state = {
					duration = 10,
					stateId = 8614030
				}
			},
			[1010] = {
				disablePassive = 1,
				targetArea = 4,
				boxId = 8613020,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = 2,
					stateId = 8613030
				}
			},
			[1011] = {
				targetChoose = 10,
				targetArea = 4,
				addManaNumber = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 6
					},
					[3] = {
						addManaNumber = 9
					},
					[4] = {
						addManaNumber = 12
					},
					[5] = {
						addManaNumber = 15
					},
					[6] = {}
				}
			},
			[1012] = {
				targetChoose = 10,
				targetArea = 5,
				addManaNumber = -3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = -6
					},
					[3] = {
						addManaNumber = -9
					},
					[4] = {
						addManaNumber = -12
					},
					[5] = {
						addManaNumber = -15
					},
					[6] = {}
				}
			},
			[1013] = {
				disablePassive = 1,
				boxId = 8615010,
				targetArea = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000050
					}
				}
			}
		}
	},
	[1000126] = {
		bhEvent = "skill.1000121",
		atkEvents = {
			[1001] = {
				boxId = 8340110,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						850010013
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				boxId = 8350010,
				targetArea = 3,
				addManaNumber = 12,
				state = {},
				hitCue = {
					cueList = {
						850010013
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = 24
					},
					[4] = {
						addManaNumber = 24
					},
					[5] = {
						addManaNumber = 24
					},
					[6] = {
						addManaNumber = 24
					}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8350011,
						8350012
					}
				}
			},
			[1004] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = 20
					},
					[4] = {
						addManaNumber = 20
					},
					[5] = {
						addManaNumber = 20
					},
					[6] = {
						addManaNumber = 20
					}
				}
			},
			[1005] = {
				disablePassive = 1,
				boxId = 8350050,
				targetArea = 3,
				addManaNumber = 8,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = 16
					},
					[4] = {
						addManaNumber = 16
					},
					[5] = {
						addManaNumber = 16
					},
					[6] = {
						addManaNumber = 16
					}
				}
			},
			[1006] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1007] = {
				boxType = 1,
				delay = 0.5,
				boxId = 8350090,
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 8350090
				},
				hitCue = {
					cueList = {
						850010013
					}
				}
			},
			[1008] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 8350100
				}
			},
			[1009] = {
				disablePassive = 1,
				boxId = 8350110,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1010] = {
				boxId = 8350510,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010018
					}
				}
			},
			[1011] = {
				boxId = 8350012,
				targetArea = 3,
				state = {}
			},
			[1012] = {
				boxId = 8350120,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1013] = {
				unitDelay = 0.15,
				targetChoose = 18,
				flyCueId = 10000079,
				boxId = 8350590,
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 8350591
				},
				hitCue = {
					cueList = {
						10000080,
						10000079
					}
				}
			},
			[1014] = {
				boxId = 8350140,
				excludeTarget = 1,
				unitDelay = 0.25,
				boxType = 1,
				eventType = 1,
				disablePassive = 1,
				flyCueId = 10000082,
				targetChoose = 23,
				baseToTarget = 1,
				state = {
					duration = 3,
					stateId = 8350142
				},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1015] = {
				addManaNumber = -12,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = -20
					},
					[3] = {
						addManaNumber = -20
					},
					[4] = {
						addManaNumber = -20
					},
					[5] = {
						addManaNumber = -20
					},
					[6] = {}
				}
			},
			[1016] = {
				subEventId = 1017,
				subEventSkill = 1000126,
				boxId = 8350150,
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						10000057
					}
				}
			},
			[1017] = {
				boxId = 8350150,
				targetChoose = 3,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000057
					}
				}
			},
			[1018] = {
				targetArea = 3,
				eventCondition = "4,2,isArcher,0",
				boxId = 8350160,
				targetChoose = 7,
				state = {
					duration = 8,
					stateId = 8350160
				}
			},
			[1019] = {
				targetChoose = 7,
				targetArea = 3,
				eventCondition = "4,2,isArcher,0",
				state = {
					duration = 8,
					stateId = 8350160
				}
			},
			[1020] = {
				boxId = 8350150,
				targetArea = 3,
				addManaNumber = 20,
				state = {
					duration = -999,
					stateId = 1210203
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {},
					[4] = {
						addManaNumber = 25
					},
					[5] = {
						addManaNumber = 25
					},
					[6] = {
						addManaNumber = 30
					}
				}
			},
			[1021] = {
				boxId = 8350610,
				eventType = 1,
				state = {}
			},
			[1022] = {
				addManaNumber = -11,
				state = {}
			},
			[1023] = {
				addManaNumber = 100,
				targetArea = 3,
				state = {}
			},
			[1024] = {
				targetChoose = 23,
				state = {
					duration = 4,
					stateId = 8350620
				}
			},
			[1025] = {
				boxId = 8350170,
				eventType = 1,
				state = {}
			},
			[1026] = {
				boxId = 8350630,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1027] = {
				boxId = 8350631,
				targetArea = 3,
				state = {}
			},
			[1028] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 8350640
				}
			},
			[1029] = {
				targetChoose = 4,
				state = {
					duration = 10,
					stateId = 8350641
				}
			},
			[1030] = {
				boxId = 8350250,
				targetArea = 3,
				targetChoose = 14,
				state = {}
			},
			[1031] = {
				boxId = 8350650,
				targetChoose = 14,
				eventType = 1,
				state = {}
			},
			[1032] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8350651,
						8350652
					}
				}
			},
			[1033] = {
				boxId = 8350280,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1034] = {
				targetChoose = 10,
				state = {
					duration = -999,
					stateId = 8350322
				}
			},
			[1035] = {
				eventCondition = "1,2,8350320",
				targetChoose = 10,
				state = {
					duration = 0.1,
					stateId = 8350323
				}
			},
			[1036] = {
				disablePassive = 1,
				boxType = 1,
				delay = 0.5,
				boxId = 8350320,
				eventType = 1,
				state = {}
			},
			[1037] = {
				randomTargetNumber = 2,
				targetArea = 3,
				targetChoose = 19,
				state = {
					duration = 5,
					stateId = 8350670
				}
			},
			[1038] = {
				boxId = 8350670,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1039] = {
				boxId = 8350671,
				targetArea = 1,
				state = {}
			},
			[1040] = {
				boxId = 8350330,
				eventType = 1,
				state = {}
			},
			[1041] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8350362,
						8350363
					}
				}
			},
			[1042] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8350363
				}
			},
			[1043] = {
				delay = 0.1,
				targetArea = 3,
				boxType = 1,
				state = {
					duration = 8,
					stateId = 8350361
				}
			},
			[1044] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8350682,
						8350683,
						8350684
					}
				}
			},
			[1045] = {
				boxId = 8350680,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[1046] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 8350684
				}
			},
			[1047] = {
				disablePassive = 1,
				boxId = 8350410,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1048] = {
				boxId = 8350690,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000104
					}
				}
			},
			[1049] = {
				targetChoose = 23,
				state = {
					duration = 1.1,
					stateId = 8350691
				}
			},
			[1050] = {
				eventCondition = "7,0,2,1000003,0,2,1000001,0,2,1000013",
				targetChoose = 23,
				state = {
					duration = 1.1,
					stateId = 8350690
				}
			}
		}
	},
	[1000102] = {
		bhEvent = "skill.1000101",
		atkEvents = {
			[1001] = {
				disablePassive = 1,
				boxId = 8340060,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010003
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				targetArea = 3,
				boxId = 8350030,
				targetChoose = 13,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 8350070,
				delay = 0.1,
				excludeTarget = 1,
				subEventSkill = 1000102,
				eventType = 1,
				disablePassive = 1,
				subEventId = 1004,
				flyCueId = 850010031,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						850010032
					}
				}
			},
			[1004] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 8350070,
				delay = 0.1,
				excludeTarget = 1,
				subEventSkill = 1000102,
				eventType = 1,
				disablePassive = 1,
				subEventId = 1005,
				flyCueId = 850010031,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						850010032
					}
				}
			},
			[1005] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 8350070,
				delay = 0.1,
				excludeTarget = 1,
				subEventSkill = 1000102,
				eventType = 1,
				disablePassive = 1,
				subEventId = 1006,
				flyCueId = 850010031,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						850010032
					}
				}
			},
			[1006] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 8350070,
				delay = 0.1,
				excludeTarget = 1,
				eventType = 1,
				disablePassive = 1,
				flyCueId = 850010031,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						850010032
					}
				}
			}
		}
	},
	[1000152] = {
		bhEvent = "skill.1000151",
		atkEvents = {
			[1001] = {
				boxId = 8340120,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				boxId = 8350020,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1003] = {
				targetArea = 3,
				boxId = 8350520,
				targetChoose = 13,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1004] = {
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = 100,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8350550
					}
				}
			},
			[1006] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8350524
				}
			},
			[1007] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 8350525
				}
			}
		}
	},
	[1000153] = {
		bhEvent = "skill.1000151",
		atkEvents = {
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 5000021
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 5000022
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 5000023
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 5000024
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 5000025
				}
			},
			[1006] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 5000026
				}
			},
			[1007] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 5000027
				}
			},
			[1008] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 5000028
				}
			}
		}
	},
	[1000103] = {
		bhEvent = "skill.1000101",
		atkEvents = {
			[1001] = {
				disablePassive = 1,
				boxId = 8720010,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010003
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				controlTime = 2,
				controlAniName = "freeze",
				state = {
					duration = 4,
					stateId = 8720031
				}
			},
			[1003] = {
				disablePassive = 1,
				randomTargetNumber = 1,
				boxId = 8720120,
				targetChoose = 3,
				excludeTarget = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010020
					}
				}
			},
			[1004] = {
				controlTime = 4,
				controlAniName = "freeze",
				state = {}
			},
			[1005] = {
				addManaNumber = -20,
				state = {}
			},
			[1006] = {
				disablePassive = 1,
				boxId = 8740020,
				targetChoose = 3,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						10000057
					}
				}
			},
			[1007] = {
				targetArea = 3,
				boxId = 8740040,
				targetChoose = 18,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1008] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1009] = {
				disablePassive = 1,
				boxId = 8740060,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010009
					}
				}
			},
			[1010] = {
				disablePassive = 1,
				boxId = 8740140,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1011] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 8704010,
				delay = 0.1,
				excludeTarget = 1,
				subEventSkill = 1000103,
				eventType = 1,
				disablePassive = 1,
				subEventId = 1012,
				flyCueId = 850010031,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						850010032
					}
				}
			},
			[1012] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 8704010,
				delay = 0.1,
				excludeTarget = 1,
				subEventSkill = 1000103,
				eventType = 1,
				disablePassive = 1,
				subEventId = 1013,
				flyCueId = 850010031,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						850010032
					}
				}
			},
			[1013] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 8704010,
				delay = 0.1,
				excludeTarget = 1,
				subEventSkill = 1000103,
				eventType = 1,
				disablePassive = 1,
				subEventId = 1014,
				flyCueId = 850010031,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						850010032
					}
				}
			},
			[1014] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 8704010,
				delay = 0.1,
				excludeTarget = 1,
				eventType = 1,
				disablePassive = 1,
				flyCueId = 850010031,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						850010032
					}
				}
			},
			[1015] = {
				disablePassive = 1,
				controlTime = 1,
				controlAniName = "freeze",
				boxId = 8706030,
				eventType = 1,
				state = {}
			}
		}
	},
	[1000127] = {
		bhEvent = "skill.1000122",
		atkEvents = {
			[1001] = {
				disablePassive = 1,
				excludeTarget = 1,
				boxId = 8720080,
				targetChoose = 3,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						850010022
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				targetArea = 2,
				boxId = 8720090,
				targetChoose = 3,
				excludeTarget = 1,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						850010022
					}
				}
			},
			[1003] = {
				disablePassive = 1,
				boxId = 8720110,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010031,
						850010032
					}
				}
			},
			[1004] = {
				disablePassive = 1,
				boxId = 8720140,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						850010026
					}
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8720151
					}
				}
			},
			[1006] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8720151
				}
			},
			[1007] = {
				targetChoose = 7,
				targetArea = 2,
				state = {
					duration = 6,
					stateId = 1000004
				}
			},
			[1008] = {
				disablePassive = 1,
				boxId = 8720180,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1009] = {
				disablePassive = 1,
				boxId = 8730040,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1010] = {
				targetArea = 3,
				boxId = 8730050,
				targetChoose = 7,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1011] = {
				boxId = 8730060,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1012] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			},
			[1013] = {
				targetChoose = 7,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 30,
				state = {}
			},
			[1014] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1015] = {
				boxId = 8730130,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1016] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1017] = {
				boxId = 8730150,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1018] = {
				addManaNumber = 40,
				targetArea = 3,
				state = {}
			},
			[1019] = {
				disablePassive = 1,
				boxId = 8740110,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1020] = {
				addManaNumber = 25,
				targetArea = 3,
				state = {}
			},
			[1021] = {
				disablePassive = 1,
				boxId = 8740130,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010010
					}
				}
			},
			[1022] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8740151
					}
				}
			},
			[1023] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8740151
				}
			},
			[1024] = {
				disablePassive = 1,
				targetArea = 2,
				boxId = 8730160,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010007
					}
				}
			},
			[1025] = {
				disablePassive = 1,
				targetArea = 2,
				boxId = 8730170,
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 8730171
				},
				hitCue = {
					cueList = {
						10000041
					}
				}
			},
			[1026] = {
				disablePassive = 1,
				targetArea = 2,
				boxId = 8730180,
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 8730181
				},
				hitCue = {
					cueList = {
						10000042
					}
				}
			},
			[1027] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 8740081
				}
			},
			[1028] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8700050
				}
			},
			[1029] = {
				boxId = 8791990,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1030] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8810051
				}
			}
		}
	},
	[1000154] = {
		bhEvent = "skill.1000151",
		atkEvents = {
			[1001] = {
				disablePassive = 1,
				boxId = 8720040,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				boxId = 8720060,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						850010026
					}
				}
			},
			[1003] = {
				disablePassive = 1,
				targetArea = 2,
				boxId = 8720070,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010017
					}
				}
			},
			[1004] = {
				disablePassive = 1,
				boxId = 8720100,
				targetChoose = 8,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010031,
						850010032
					}
				}
			},
			[1005] = {
				disablePassive = 1,
				stunTime = 1.5,
				state = {}
			},
			[1006] = {
				disablePassive = 1,
				notRecordLastDamage = 1,
				boxId = 8730100,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010031,
						850010032
					}
				}
			},
			[1007] = {
				targetChoose = 18,
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 8730121
				}
			},
			[1008] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8740031
					}
				}
			},
			[1009] = {
				disablePassive = 1,
				boxId = 8704020,
				targetChoose = 3,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						10000057
					}
				}
			}
		}
	},
	[1000128] = {
		bhEvent = "skill.1000121",
		atkEvents = {
			[1001] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			},
			[1003] = {
				targetChoose = 7,
				targetArea = 3,
				addManaNumber = 10,
				state = {}
			},
			[1004] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 8702031
				}
			},
			[1005] = {
				targetArea = 3,
				delay = 0.15,
				excludeTarget = 1,
				boxType = 1,
				targetChoose = 7,
				addManaNumber = 20,
				state = {}
			},
			[1006] = {
				disablePassive = 1,
				targetArea = 3,
				boxId = 8703030,
				targetChoose = 14,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1007] = {
				boxId = 8704030,
				disablePassive = 1,
				state = {
					duration = 8,
					stateId = 1000003
				},
				hitCue = {
					cueList = {
						10000042
					}
				}
			},
			[1008] = {
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = 100,
				state = {}
			},
			[1009] = {
				disablePassive = 1,
				boxId = 8705030,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000041
					}
				}
			},
			[1010] = {
				boxId = 8791010,
				unitDelay = 0.25,
				boxType = 1,
				eventType = 1,
				disablePassive = 1,
				flyCueId = 850010033,
				targetChoose = 3,
				baseToTarget = 1,
				state = {}
			},
			[1011] = {
				targetArea = 3,
				addManaNumber = 10,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1012] = {
				boxId = 8791030,
				targetArea = 3,
				addManaNumber = 10,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1013] = {
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = 100,
				state = {}
			},
			[1014] = {
				addManaNumber = 20,
				targetArea = 3,
				state = {}
			},
			[1015] = {
				boxId = 1101024,
				targetArea = 3,
				state = {}
			},
			[1016] = {
				randomTargetNumber = 1,
				targetArea = 3,
				targetChoose = 10,
				state = {
					duration = 5,
					stateId = 8705041
				}
			},
			[1017] = {
				randomTargetNumber = 1,
				excludeTarget = 1,
				boxId = 1201132,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1018] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 12,
					stateId = 8706061
				}
			},
			[1019] = {
				boxId = 1300331,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1020] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8704051
				}
			},
			[1021] = {
				targetChoose = 10,
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1022] = {
				boxId = 1401161,
				eventType = 1,
				state = {}
			},
			[1023] = {
				boxId = 1100224,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1024] = {
				boxId = 1500231,
				targetArea = 3,
				state = {}
			},
			[1025] = {
				targetChoose = 2,
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[1026] = {
				boxId = 1201830,
				disablePassive = 1,
				eventType = 1,
				state = {}
			}
		}
	},
	[1000129] = {
		bhEvent = "skill.1000121",
		atkEvents = {
			[1001] = {
				addManaNumber = 25,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				boxId = 8810040,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1003] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 9100115
				}
			}
		}
	},
	[1000155] = {
		bhEvent = "skill.1000151",
		atkEvents = {
			[1001] = {
				disablePassive = 1,
				boxId = 8813020,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						850010026
					}
				},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1002] = {
				targetChoose = 18,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 8813061
				}
			},
			[1003] = {
				eventCondition = "5,1",
				stunTime = 2,
				state = {}
			}
		}
	},
	[1000104] = {
		bhEvent = "skill.1000101",
		atkEvents = {
			[1001] = {
				disablePassive = 1,
				boxId = 8813010,
				targetChoose = 3,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						10000057
					}
				}
			},
			[1002] = {
				targetArea = 3,
				addManaNumber = 10,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1003] = {
				disablePassive = 1,
				targetArea = 3,
				boxId = 8813050,
				targetChoose = 18,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1004] = {
				controlTime = 4,
				controlAniName = "freeze",
				state = {}
			}
		}
	},
	[1000156] = {
		bhEvent = "skill.1000151",
		atkEvents = {
			[1001] = {
				targetChoose = 7,
				state = {
					duration = 11,
					stateId = 10000011
				}
			},
			[1002] = {
				subEventId = 1003,
				subEventType = 1,
				subEventSkill = 1000156,
				targetChoose = 7,
				state = {
					duration = 11,
					stateId = 10000012
				}
			},
			[1003] = {
				targetChoose = 7,
				targetArea = 1,
				state = {
					duration = 11,
					stateId = 10000013
				}
			},
			[1004] = {
				targetArea = 1,
				summonMonsters = "1610104",
				state = {}
			},
			[1005] = {
				targetArea = 1,
				summonMonsters = "1610105",
				state = {}
			},
			[1006] = {
				targetArea = 1,
				state = {
					duration = 5,
					stateId = 10000025
				}
			},
			[1007] = {
				subEventId = 1008,
				subEventType = 1,
				subEventSkill = 1000156,
				boxId = 10000025,
				targetArea = 1,
				state = {}
			},
			[1008] = {
				randomTargetNumber = 1,
				targetArea = 1,
				rebornMhp = 10000,
				randomRule = 5,
				targetChoose = 24,
				state = {
					chooseStateType = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			[1009] = {
				boxId = 10000027,
				targetArea = 1,
				state = {}
			},
			[1010] = {
				targetArea = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						10000023
					}
				}
			},
			[1011] = {
				boxId = 10000031,
				targetArea = 1,
				state = {}
			},
			[1012] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 100000341
				}
			},
			[1013] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 10000035
				}
			},
			[1014] = {
				targetChoose = 7,
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 10000043
				}
			},
			[1015] = {
				targetChoose = 7,
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 10000044
				}
			},
			[1016] = {
				subEventType = 1,
				subEventSkill = 1000156,
				boxId = 10000043,
				targetChoose = 7,
				subEventId = 1017,
				state = {},
				hitCue = {
					cueList = {
						10000090
					}
				}
			},
			[1017] = {
				targetChoose = 7,
				targetArea = 1,
				state = {
					stateId = 10000043,
					stateOperation = 4,
					delLayer = 3
				}
			},
			[1018] = {
				boxId = 10000051,
				state = {}
			},
			[1019] = {
				boxId = 10000052,
				state = {}
			},
			[1020] = {
				boxId = 100000521,
				disablePassive = 1,
				state = {}
			},
			[1021] = {
				addManaNumber = -5,
				state = {}
			},
			[1022] = {
				boxId = 10000061,
				targetArea = 3,
				state = {}
			},
			[1023] = {
				boxId = 10000062,
				targetArea = 3,
				state = {}
			},
			[1024] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 10000063
				}
			},
			[1025] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 10000073
				}
			},
			[1026] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 10000074
				}
			},
			[1027] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 10000075
				}
			},
			[1028] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 10000076
				}
			},
			[1029] = {
				unitDelay = 0.16,
				boxId = 10000081,
				flyCueId = 10000095,
				boxType = 1,
				targetChoose = 9,
				state = {},
				hitCue = {
					cueList = {
						10000096
					}
				}
			},
			[1030] = {
				unitDelay = 0.16,
				boxId = 10000082,
				flyCueId = 10000095,
				boxType = 1,
				targetChoose = 9,
				state = {},
				hitCue = {
					cueList = {
						10000096
					}
				}
			},
			[1031] = {
				boxType = 1,
				unitDelay = 0.16,
				boxId = 100000821,
				targetChoose = 9,
				state = {},
				hitCue = {
					cueList = {
						10000097
					}
				}
			},
			[1032] = {
				boxId = 10000093,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						10000098
					}
				}
			},
			[1033] = {
				boxId = 100000921,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						10000098
					}
				}
			},
			[1034] = {
				boxId = 10000094,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						10000098
					}
				}
			},
			[1035] = {
				boxId = 10000103,
				targetArea = 1,
				state = {}
			},
			[1036] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 10000111
				}
			},
			[1037] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 10000112
				}
			},
			[1038] = {
				randomTargetNumber = 3,
				targetArea = 1,
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 10000131
				}
			},
			[1039] = {
				randomTargetNumber = 4,
				subEventType = 1,
				subEventSkill = 1000156,
				targetArea = 1,
				targetChoose = 7,
				subEventId = 1040,
				state = {
					duration = -999,
					stateId = 10000132
				}
			},
			[1040] = {
				targetChoose = 7,
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 10000133
				}
			},
			[1041] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 10000141
				}
			},
			[1042] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 10000142
				}
			},
			[1045] = {
				subEventId = 1048,
				subEventSkill = 1000156,
				boxId = 10000152,
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 10000153
				}
			},
			[1046] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 10000095
				}
			},
			[1047] = {
				boxId = 10000095,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000099,
						10000100
					}
				}
			},
			[1048] = {
				targetArea = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						10000152
					}
				}
			},
			[1049] = {
				state = {
					duration = 5,
					stateId = 10000165
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 10000165
						}
					},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1050] = {
				state = {
					duration = 5,
					stateId = 10000164
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 10000164
						}
					},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1051] = {
				boxType = 1,
				delay = 0.1,
				boxId = 10000164,
				state = {}
			},
			[1052] = {
				boxType = 1,
				delay = 0.1,
				boxId = 10000165,
				state = {}
			},
			[1053] = {
				boxId = 10000032,
				targetArea = 1,
				state = {}
			},
			[1054] = {
				state = {
					duration = -999,
					stateId = 10000113
				}
			},
			[1055] = {
				targetArea = 1,
				state = {
					chooseStateType = 2,
					stateOperation = 1,
					chooseStateMode = 1
				}
			},
			[1056] = {
				state = {}
			},
			[1057] = {
				state = {
					duration = 5,
					stateId = 10000164
				}
			}
		}
	},
	[1000157] = {
		bhEvent = "skill.1000101",
		atkEvents = {
			[1001] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 20000001
				}
			},
			[1002] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 20000002
				}
			},
			[1003] = {
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1004] = {
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[1005] = {
				boxId = 20000006,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1006] = {
				addManaNumber = 45,
				targetArea = 3,
				state = {}
			},
			[1007] = {
				boxType = 1,
				boxId = 20000008,
				targetChoose = 3,
				delay = 0.1,
				state = {},
				hitCue = {
					cueList = {
						850010023
					}
				},
				baseCue = {
					cueList = {
						850010022
					}
				}
			},
			[1008] = {
				boxId = 20000010,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						850010023
					}
				},
				baseCue = {
					cueList = {
						850010022
					}
				}
			},
			[1009] = {
				boxId = 20000011,
				targetArea = 1,
				state = {}
			},
			[1010] = {
				boxId = 20000012,
				targetArea = 3,
				state = {}
			},
			[1011] = {
				boxId = 20000013,
				state = {},
				hitCue = {
					cueList = {
						850010009
					}
				}
			},
			[1012] = {
				targetArea = 2,
				boxId = 20000014,
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						850010017
					}
				},
				hitCue = {
					cueList = {
						850010009
					}
				}
			},
			[1013] = {
				state = {
					duration = 12,
					stateId = 1000003
				}
			},
			[1014] = {
				state = {
					duration = 12,
					stateId = 1000001
				}
			},
			[1015] = {
				boxType = 1,
				delay = 0.2,
				boxId = 20000025,
				state = {}
			},
			[1016] = {
				boxId = 20000026,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1017] = {
				boxId = 20000027,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1018] = {
				disablePassive = 1,
				boxId = 20000028,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1019] = {
				boxId = 20000029,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						850010026
					}
				}
			},
			[1020] = {
				delay = 0.2,
				boxType = 1,
				boxId = 20000031,
				state = {},
				hitCue = {
					cueList = {
						850010020
					}
				}
			},
			[1021] = {
				randomTargetNumber = 1,
				boxId = 20000032,
				targetChoose = 3,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						850010018
					}
				}
			},
			[1022] = {
				stunTime = 3.5,
				state = {}
			},
			[1023] = {
				boxId = 20000034,
				targetArea = 3,
				state = {}
			},
			[1024] = {
				targetChoose = 7,
				targetArea = 1,
				addManaNumber = 45,
				state = {}
			},
			[1025] = {
				boxId = 20000037,
				targetArea = 3,
				state = {}
			},
			[1026] = {
				addManaNumber = 15,
				targetArea = 3,
				state = {}
			},
			[1027] = {
				targetArea = 3,
				boxId = 20000041,
				targetChoose = 7,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1028] = {
				targetChoose = 7,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 55,
				state = {}
			},
			[1029] = {
				targetArea = 2,
				boxId = 20000043,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						850010024
					}
				},
				hitCue = {
					cueList = {
						850010025
					}
				}
			},
			[1030] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 200000441
				}
			},
			[1031] = {
				addManaNumber = 15,
				targetArea = 3,
				state = {}
			},
			[1032] = {
				controlTime = 2,
				controlAniName = "freeze",
				state = {}
			},
			[1033] = {
				boxId = 20000053,
				targetChoose = 8,
				state = {},
				hitCue = {
					cueList = {
						850010031,
						850010032
					}
				}
			},
			[1034] = {
				disablePassive = 1,
				targetArea = 2,
				boxId = 20000054,
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						850010017
					}
				}
			},
			[1035] = {
				disablePassive = 1,
				boxId = 20000055,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						850010031,
						850010032
					}
				}
			},
			[1036] = {
				targetChoose = 18,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 200000561
				}
			},
			[1037] = {
				targetArea = 3,
				boxId = 20000057,
				targetChoose = 18,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1038] = {
				boxId = 20000058,
				targetChoose = 4,
				state = {},
				hitCue = {
					cueList = {
						850010009
					}
				}
			},
			[1039] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						200000611
					}
				}
			},
			[1040] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 200000611
				}
			},
			[1041] = {
				state = {
					duration = 5,
					stateId = 200000451
				}
			},
			[1042] = {
				boxId = 20000052,
				targetArea = 3,
				randomTargetNumber = 1,
				state = {}
			},
			[1043] = {
				addManaNumber = -8,
				state = {}
			},
			[1044] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						20000052
					}
				}
			},
			[1045] = {
				targetChoose = 7,
				state = {
					duration = 5,
					stateId = 21000011
				}
			},
			[1046] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 21000012
				}
			},
			[1047] = {
				boxId = 1401440,
				targetArea = 3,
				targetChoose = 7,
				state = {}
			},
			[1048] = {
				boxId = 21000013,
				targetArea = 3,
				state = {}
			},
			[1049] = {
				boxId = 1110235,
				targetArea = 3,
				state = {}
			},
			[1050] = {
				boxId = 20100010,
				targetArea = 3,
				targetChoose = 11,
				state = {}
			},
			[1051] = {
				addManaNumber = 40,
				targetArea = 3,
				state = {}
			},
			[1052] = {
				boxId = 20100020,
				targetArea = 3,
				state = {}
			},
			[1053] = {
				boxId = 20100030,
				targetArea = 3,
				state = {}
			},
			[1054] = {
				boxId = 20600030,
				targetArea = 3,
				state = {}
			},
			[1055] = {
				randomTargetNumber = 1,
				boxId = 1301231,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1056] = {
				boxId = 20300010,
				targetChoose = 11,
				eventType = 1,
				state = {}
			},
			[1057] = {
				boxId = 20300020,
				eventType = 1,
				state = {}
			},
			[1058] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						20300021
					}
				}
			},
			[1059] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 15,
					stateId = 20300030
				}
			},
			[1060] = {
				addManaNumber = 24,
				targetArea = 3,
				state = {}
			},
			[1061] = {
				boxId = 20400010,
				targetArea = 3,
				targetChoose = 11,
				state = {
					duration = 5,
					stateId = 20400011
				}
			},
			[1062] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 20400021
				}
			},
			[1063] = {
				boxId = 20400020,
				targetChoose = 4,
				eventType = 1,
				state = {}
			},
			[1064] = {
				boxId = 20400030,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1065] = {
				targetArea = 3,
				delay = 0.2,
				boxType = 1,
				targetChoose = 9,
				state = {
					duration = 12,
					stateId = 1401301
				}
			},
			[1066] = {
				targetChoose = 18,
				targetArea = 1,
				state = {
					duration = 12.1,
					stateId = 21401331
				}
			},
			[1067] = {
				boxId = 1401360,
				targetArea = 1,
				state = {}
			},
			[1068] = {
				boxId = 20200010,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1069] = {
				boxId = 20200011,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1070] = {
				subEventId = 1071,
				subEventSkill = 1000157,
				boxId = 20200020,
				targetChoose = 4,
				eventType = 1,
				state = {}
			},
			[1071] = {
				boxId = 20200021,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1072] = {
				boxId = 20200030,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1073] = {
				addManaNumber = 8,
				targetArea = 3,
				state = {}
			},
			[1074] = {
				eventCondition = "4,2,inControlled,1",
				boxId = 20600040,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1075] = {
				boxId = 20600050,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1076] = {
				randomTargetNumber = 1,
				targetChoose = 7,
				state = {
					duration = 0.2,
					stateId = 20600061
				},
				hitCue = {
					cueList = {
						10000042
					}
				}
			},
			[1077] = {
				boxId = 20600060,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1078] = {
				boxId = 20300040,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1079] = {
				boxId = 20300050,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1080] = {
				boxId = 20300060,
				targetArea = 3,
				state = {}
			},
			[1081] = {
				boxId = 20500010,
				targetArea = 3,
				targetChoose = 14,
				state = {
					duration = 8,
					stateId = 20500011
				}
			},
			[1082] = {
				boxId = 20500020,
				targetChoose = 7,
				state = {}
			},
			[1083] = {
				boxId = 20500030,
				targetArea = 3,
				state = {}
			},
			[1084] = {
				boxId = 1201840,
				targetArea = 3,
				state = {}
			},
			[1085] = {
				boxId = 1201841,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1086] = {
				state = {
					duration = 2.5,
					stateId = 21201831
				}
			}
		}
	},
	[1000130] = {
		bhEvent = "skill.1000121",
		atkEvents = {
			[1001] = {
				boxId = 870011,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						850010013
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 870021
				}
			},
			[1003] = {
				boxId = 870012,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						10000090
					}
				}
			},
			[1004] = {
				boxId = 870013,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						850010020
					}
				}
			},
			[1005] = {
				boxId = 870014,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1006] = {
				targetArea = 3,
				boxId = 870015,
				targetChoose = 11,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			}
		}
	},
	[1000158] = {
		bhEvent = "skill.1000121",
		atkEvents = {
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						2031111
					}
				}
			},
			[1002] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 2031122
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						2031121,
						2031122
					}
				}
			},
			[1004] = {
				disablePassive = 1,
				boxId = 2031210,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 2031312
				}
			},
			[1006] = {
				eventCondition = "1,1,2031313,1",
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						2031312
					}
				}
			},
			[1007] = {
				targetChoose = 23,
				state = {
					duration = -999,
					stateId = 2031411
				}
			},
			[1008] = {
				targetArea = 3,
				boxId = 2031510,
				targetChoose = 11,
				eventProbId = 2031511,
				state = {},
				hitCue = {
					cueList = {
						10000045,
						10000047
					}
				}
			},
			[1009] = {
				targetChoose = 3,
				targetArea = 2,
				state = {
					duration = -999,
					stateId = 2032111
				}
			},
			[1010] = {
				boxId = 2032120,
				targetArea = 3,
				state = {}
			},
			[1011] = {
				targetChoose = 3,
				targetArea = 2,
				state = {
					duration = 0.1,
					stateId = 2032222
				}
			},
			[1012] = {
				targetArea = 3,
				state = {
					duration = 0.9,
					stateId = 2032221
				}
			},
			[1013] = {
				targetArea = 3,
				state = {
					stateId = 2032311,
					stateCondition = 1,
					duration = 0.9
				}
			},
			[1014] = {
				targetChoose = 11,
				targetArea = 3,
				eventCondition = "1,2,2032320",
				state = {
					duration = -999,
					stateId = 2032321
				}
			},
			[1015] = {
				targetChoose = 23,
				state = {
					duration = -999,
					stateId = 2032412
				}
			},
			[1016] = {
				subEventId = 1017,
				eventCondition = "1,2,2032412",
				subEventSkill = 1000158,
				targetChoose = 23,
				state = {}
			},
			[1017] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 2032411
				}
			},
			[1018] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 2032413
				}
			},
			[1019] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 2032422
				}
			},
			[1020] = {
				boxId = 2032420,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1021] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 2032522
				}
			},
			[1022] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						2032521,
						2032522
					}
				}
			},
			[1023] = {
				randomTargetNumber = 1,
				targetArea = 3,
				targetChoose = 20,
				state = {
					duration = 1,
					stateId = 2031521
				}
			},
			[1024] = {
				targetChoose = 3,
				targetArea = 2,
				state = {
					duration = 1,
					stateId = 2031321
				}
			}
		}
	}
}
local skillDefault = {}
local atkEventsDefault = {
	randomTargetNumber = 0,
	boxType = 0,
	flyCueId = 0,
	eventType = 0,
	delay = 0,
	stateCondition = 0,
	boxId = 0,
	eventProbId = 0
}

for k, skillData in pairs(Data) do
	if k ~= "cueFile" then
		setmetatable(skillData, {
			__index = skillDefault
		})

		for skillKey, skillInfo in pairs(skillData) do
			if skillKey == "atkEvents" then
				for eventsKey, event in pairs(skillInfo) do
					setmetatable(event, {
						__index = atkEventsDefault
					})
				end
			end
		end
	end
end

return Data
