-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13018.lua

local Data = {
	cueFile = "13018",
	[1301809] = {
		bhEvent = "skill.1301809",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						130180001,
						130181001
					}
				}
			},
			{
				unitDelay = 0.12,
				flyCueId = 130180002,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 0.05,
					stateId = 1301809
				},
				hitCue = {
					cueList = {
						130180003,
						130181002
					}
				}
			},
			[3] = {
				unitDelay = 0.16,
				flyCueId = 130170002,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						randomTargetNumber = 1,
						unitDelay = 0.12,
						flyCueId = 130180002,
						boxType = 1,
						targetChoose = 3,
						state = {
							duration = 0.05,
							stateId = 1301809
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				unitDelay = 0.16,
				flyCueId = 130170002,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						randomTargetNumber = 1,
						unitDelay = 0.12,
						flyCueId = 130180002,
						boxType = 1,
						targetChoose = 3,
						state = {
							duration = 0.05,
							stateId = 1301809
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				boxId = 1301809,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 0.05,
					stateId = 1301805
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						130180020
					}
				}
			}
		}
	},
	[1301810] = {
		bhEvent = "skill.1301810",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130180004,
						130180020,
						130181003
					}
				}
			},
			{
				unitDelay = 0.12,
				flyCueId = 130180005,
				boxType = 1,
				state = {
					duration = 0.05,
					stateId = 1301809
				},
				hitCue = {
					cueList = {
						130180006,
						130181004
					}
				}
			},
			{
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						randomTargetNumber = 1,
						flyCueId = 130180019,
						boxType = 1,
						targetChoose = 3,
						unitDelay = 0.12,
						state = {
							duration = 0.05,
							stateId = 1301809
						},
						hitCue = {
							cueList = {
								130180006,
								130181004
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						randomTargetNumber = 1,
						flyCueId = 130180005,
						boxType = 1,
						targetChoose = 3,
						unitDelay = 0.12,
						state = {
							duration = 0.05,
							stateId = 1301809
						},
						hitCue = {
							cueList = {
								130180006,
								130181004
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1301829] = {
		bhEvent = "skill.1301829",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130180007,
						130180008,
						130181005
					}
				}
			},
			{
				boxId = 1301830,
				targetArea = 3,
				state = {}
			},
			[1001] = {
				boxType = 1,
				unitDelay = 0.16,
				state = {},
				hitCue = {
					cueList = {
						130180011,
						130181006
					}
				}
			},
			[1002] = {
				boxId = 1301829,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 0.05,
					stateId = 1301805
				},
				hitCue = {
					cueList = {
						130181006
					}
				}
			},
			[1003] = {
				targetChoose = 3,
				excludeTarget = 1,
				eventCondition = "1,1,1301820",
				targetArea = 1,
				eventProbId = 1301802,
				state = {
					duration = 0.05,
					stateId = 1301805
				}
			},
			[1004] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1301804
				}
			},
			[1005] = {
				boxId = 1301831,
				targetArea = 3,
				state = {}
			},
			[1006] = {
				eventType = 1,
				boxId = 1301829,
				targetChoose = 23,
				eventProbId = 1301804,
				state = {}
			},
			[1007] = {
				targetChoose = 23,
				state = {
					duration = -999,
					stateId = 82130181
				}
			},
			[1008] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8791481
				}
			},
			[1009] = {
				boxId = 1301831,
				targetArea = 3,
				state = {}
			},
			[1010] = {
				boxId = 1301829,
				targetChoose = 23,
				eventProbId = 1301803,
				state = {}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						130180009
					}
				}
			},
			[1011] = {
				boxId = 1301832,
				targetArea = 3,
				state = {}
			},
			[1012] = {
				boxId = 1301835,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1301859] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 50,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 105,
		bhEvent = "skill.1301859",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						130180012,
						130180013,
						130180008
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						130180017,
						130185001,
						130181008
					}
				}
			},
			[15] = {
				state = {},
				hitCue = {
					cueList = {
						130180018
					}
				}
			},
			{
				subEventId = 1001,
				subEventSkill = 1301859,
				boxId = 1301859,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 0.05,
					stateId = 1301811
				},
				hitCue = {
					cueList = {
						130181010
					}
				}
			},
			[1001] = {
				boxId = 1301860,
				targetArea = 3,
				state = {}
			},
			[11] = {
				delay = 0.3,
				flyCueId = 130180014,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						130180015,
						130183001
					}
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						130180010
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				130188001,
				130181007
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
