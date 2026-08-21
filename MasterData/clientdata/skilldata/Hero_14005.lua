-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14005.lua

local Data = {
	cueFile = "14005",
	[1400509] = {
		bhEvent = "skill.1400509",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1400509,
				flyCueId = 140050012,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140050015,
						140051011
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140050011,
						140051010
					}
				}
			}
		}
	},
	[1400529] = {
		bhEvent = "skill.1400529",
		atkEvents = {
			[0] = {
				flyCueId = 90010002,
				delay = 0.15,
				targetChoose = 7,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1400502
						},
						hitCue = {
							cueList = {
								140050017
							}
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1400502
						},
						hitCue = {
							cueList = {
								140050017
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140050016,
						140051008
					}
				}
			},
			{
				targetArea = 2,
				boxId = 1400529,
				targetChoose = 4,
				eventType = 1,
				state = {
					duration = 12,
					stateId = 1000001
				},
				hitCue = {
					cueList = {
						140050017
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 7
					},
					[4] = {
						state = {}
					},
					[5] = {
						state = {}
					},
					[6] = {
						state = {},
						hitCue = {
							cueList = {
								140050005
							}
						}
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1400511
				}
			},
			[1002] = {
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1400512
				}
			},
			[1003] = {
				subEventId = 1004,
				subEventSkill = 1400529,
				targetArea = 3,
				addManaNumber = 10,
				state = {}
			},
			[1004] = {
				boxId = 1400530,
				targetArea = 3,
				targetChoose = 10,
				state = {}
			},
			[1005] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 1400521
				}
			},
			[1006] = {
				boxId = 1400531,
				state = {}
			}
		}
	},
	[1400559] = {
		shortVideoActTime = 1,
		videoActTime = 50,
		hideEffect = 1,
		hideEvent = 21,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 82,
		bhEvent = "skill.1400559",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140050018,
						140050020
					}
				}
			},
			[0] = {
				unitDelay = 0.05,
				flyCueId = 140050008,
				boxId = 1400559,
				hitedAnim = "Hit",
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1400501
				},
				atkCue = {
					cueList = {
						140053001
					}
				},
				hitCue = {
					cueList = {
						140050021,
						10006003
					}
				}
			},
			[1001] = {
				targetArea = 3,
				boxId = 1400560,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1002] = {
				targetArea = 3,
				addManaNumber = 20,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140055001,
						140051009,
						140050023
					}
				}
			},
			[21] = {
				state = {},
				hitCue = {
					cueList = {
						140050019
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				140058001,
				140051006
			}
		},
		shortVideoActCue = {
			cueList = {
				140051008
			}
		}
	},
	[1400510] = {
		bhEvent = "skill.1400510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140050013,
						140051012
					}
				}
			},
			[0] = {
				unitDelay = 0.08,
				boxId = 1400509,
				flyCueId = 140050014,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140050015,
						140051013
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
