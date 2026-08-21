-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15008.lua

local Data = {
	cueFile = "15008",
	[1500809] = {
		bhEvent = "skill.1500809",
		atkEvents = {
			[0] = {
				unitDelay = 0.16,
				boxId = 1500809,
				flyCueId = 150080003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150080004,
						150081002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150080001,
						150080002,
						150081001
					}
				}
			}
		}
	},
	[1500810] = {
		bhEvent = "skill.1500809",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1500809,
				flyCueId = 90010003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150080001
					}
				}
			},
			[100] = {
				state = {}
			}
		}
	},
	[1500859] = {
		hideTime = 10,
		videoActTime = 50,
		hideEffect = 1,
		skillTarget = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 60,
		bhEvent = "skill.1500859",
		atkEvents = {
			[0] = {
				targetArea = 3,
				targetChoose = 10,
				filterChuyin = 1,
				state = {
					duration = 12,
					stateId = 1500801
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 15,
							stateId = 1500801
						}
					},
					[4] = {
						state = {
							duration = 10,
							stateId = 1500801
						}
					},
					[5] = {
						state = {
							duration = 10,
							stateId = 1500801
						}
					},
					[6] = {
						state = {
							duration = 10,
							stateId = 1500801
						}
					}
				}
			},
			{
				targetArea = 3,
				targetChoose = 10,
				filterChuyin = 1,
				state = {
					duration = 10,
					stateId = 1500802
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 15,
							stateId = 1500802
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				targetChoose = 7,
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						150080007
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500804
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						150085001,
						150080009,
						150081006
					}
				}
			},
			[1002] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 15,
					stateId = 1500892
				}
			},
			[1003] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 15,
					stateId = 1500893
				}
			},
			[1004] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 15,
					stateId = 82150081
				}
			},
			[1005] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 10.1,
					stateId = 1500805
				}
			}
		},
		videoActCue = {
			cueList = {
				150088001,
				150081005
			}
		}
	},
	[1500829] = {
		actTime = 30,
		skillTarget = 1,
		bhEvent = "skill.1500829",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				recordSkillTargets = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				atkCue = {
					cueList = {
						150080005,
						150081003
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 7
					},
					[4] = {
						targetChoose = 4
					},
					[5] = {
						targetChoose = 4
					},
					[6] = {
						targetChoose = 4
					}
				}
			},
			{
				targetChoose = 12,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500803
				},
				hitCue = {
					cueList = {
						150080006,
						150081004
					}
				}
			},
			[1001] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 1500806
				}
			},
			[1002] = {
				targetArea = 3,
				boxId = 1500830,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1003] = {
				boxId = 1500829,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
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
