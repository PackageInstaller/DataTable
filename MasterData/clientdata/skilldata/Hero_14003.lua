-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14003.lua

local Data = {
	cueFile = "14003",
	[1400329] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.1400329",
		atkEvents = {
			[0] = {
				targetArea = 2,
				boxId = 1410129,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140030003
					}
				}
			},
			[100] = {
				state = {}
			},
			{
				targetChoose = 4,
				targetArea = 2,
				state = {},
				hitCue = {
					cueList = {
						140030003,
						140031006
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						140030004
					}
				}
			}
		}
	},
	[1400359] = {
		hideTime = 10,
		hideEvent = 3,
		videoActTime = 45,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 100,
		bhEvent = "skill.1400359",
		atkEvents = {
			{
				delay = 0.2,
				targetChoose = 4,
				state = {},
				hitCue = {
					cueList = {
						140030003,
						140031003,
						140031004
					}
				}
			},
			{
				targetChoose = 4,
				state = {}
			},
			[10] = {
				targetChoose = 4,
				state = {}
			},
			[20] = {
				state = {},
				atkCue = {
					cueList = {
						140030004,
						140031002
					}
				}
			},
			{
				boxId = 1410159,
				targetChoose = 4,
				state = {
					duration = 10,
					stateId = 1410101
				},
				hitCue = {
					cueList = {
						140030003
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 15,
							stateId = 1410101
						}
					},
					[4] = {
						state = {
							duration = 15,
							stateId = 1410101
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				state = {}
			},
			[11] = {
				state = {}
			},
			[12] = {
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140030006,
						140035001
					}
				}
			},
			[27] = {
				state = {}
			},
			[90] = {
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				140031007,
				140038002
			}
		}
	},
	[1400301] = {
		bhEvent = "skill.1400301",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 1400309,
				flyCueId = 140030001,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140030002,
						140031005
					}
				}
			}
		}
	},
	[1400321] = {
		bhEvent = "skill.1400321",
		atkEvents = {
			{
				boxId = 1400329,
				targetChoose = 8,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140030005,
						140031006
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1000001
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1000001
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				boxId = 1400330,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140030009
					}
				},
				baseCue = {
					cueList = {
						140030008
					}
				}
			}
		}
	},
	[1400351] = {
		hideTime = 10,
		hideEvent = 3,
		videoActTime = 27,
		hideEffect = 1,
		skillTarget = 5,
		prepareCamera = 1,
		prepareCamDruation = 15,
		actTime = 78,
		bhEvent = "skill.1400351",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						140030007
					}
				}
			},
			[20] = {
				state = {},
				atkCue = {
					cueList = {
						140030004,
						140031002
					}
				}
			},
			[2] = {
				targetChoose = 4,
				state = {},
				atkCue = {
					cueList = {
						140033001
					}
				},
				hitCue = {
					cueList = {
						140030003,
						140031003,
						140031004
					}
				}
			},
			[3] = {
				boxId = 1400359,
				targetChoose = 4,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[100] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1400301
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1400301
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[11] = {
				state = {}
			},
			[12] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1400303
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1400303
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				state = {},
				atkCue = {
					cueList = {
						140036001
					}
				}
			},
			[1002] = {
				state = {},
				atkCue = {
					cueList = {
						140036002
					}
				}
			},
			[1003] = {
				excludeTarget = 1,
				boxId = 1400360,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140030009
					}
				},
				baseCue = {
					cueList = {
						140030008
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140030006,
						140035001
					}
				}
			},
			[27] = {
				hitedAnim = "Hit",
				targetChoose = 4,
				state = {}
			},
			[101] = {
				hitedAnim = "end",
				targetChoose = 4,
				state = {}
			},
			[90] = {
				hitedAnim = "end",
				targetChoose = 4,
				state = {}
			},
			[98] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1400303
				}
			}
		},
		videoActCue = {
			cueList = {
				140038002,
				140031007
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
