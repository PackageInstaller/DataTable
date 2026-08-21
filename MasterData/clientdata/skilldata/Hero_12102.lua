-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12102.lua

local Data = {
	cueFile = "12102",
	[1210209] = {
		bhEvent = "skill.1210209",
		atkEvents = {
			[100] = {
				targetChoose = 4,
				subEventSkill = 1210259,
				subEventId = 1002,
				targetArea = 3,
				eventCondition = "1,1,1210201",
				excludeTarget = 1,
				state = {
					duration = 3,
					stateId = 1210202
				},
				atkCue = {
					cueList = {
						121020001,
						121021001
					}
				}
			},
			[0] = {
				boxId = 1210209,
				eventType = 1,
				state = {}
			}
		}
	},
	[1210229] = {
		bhEvent = "skill.1210229",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210201
				}
			},
			[1002] = {
				subEventId = 1006,
				subEventSkill = 1210229,
				delay = 0.1,
				targetChoose = 23,
				state = {},
				atkCue = {
					cueList = {
						121020004,
						121020005,
						121021003
					}
				}
			},
			[1003] = {
				delay = 0.1,
				boxType = 1,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1210203
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1210203
						}
					},
					[4] = {
						state = {
							duration = -999
						}
					},
					[5] = {
						state = {
							duration = -999
						}
					},
					[6] = {
						state = {
							duration = -999
						}
					}
				}
			},
			[1004] = {
				subEventId = 1005,
				subEventSkill = 1210229,
				delay = 0.1,
				targetChoose = 23,
				state = {},
				atkCue = {
					cueList = {
						121020007,
						121020008,
						121021003
					}
				}
			},
			[1005] = {
				delay = 0.5,
				boxId = 1210231,
				subEventSkill = 1000121,
				boxType = 1,
				targetChoose = 23,
				subEventId = 1080,
				eventType = 1,
				state = {}
			},
			[1006] = {
				delay = 0.5,
				boxId = 1210229,
				subEventSkill = 1000121,
				boxType = 1,
				targetChoose = 23,
				subEventId = 1080,
				eventType = 1,
				state = {}
			},
			[1007] = {
				delay = 0.1,
				targetArea = 3,
				boxType = 1,
				state = {
					duration = -999,
					stateId = 1210203
				}
			}
		}
	},
	[1210230] = {
		bhEvent = "skill.1210230",
		atkEvents = {
			[100] = {
				state = {}
			},
			[5] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 1,
							stateId = 1210203
						}
					},
					[4] = {
						state = {
							duration = 1,
							stateId = 1210203
						}
					},
					[5] = {
						state = {
							duration = 1,
							stateId = 1210203
						}
					},
					[6] = {
						state = {
							duration = 1,
							stateId = 1210203
						}
					}
				}
			},
			[0] = {
				randomTargetNumber = 1,
				recordSkillTargets = 1,
				subEventSkill = 1210230,
				boxId = 1210229,
				targetChoose = 3,
				subEventId = 1001,
				state = {}
			},
			[4] = {
				subEventId = 1080,
				targetChoose = 12,
				subEventSkill = 1000121,
				state = {
					duration = 3,
					stateId = 1210202
				}
			},
			[2] = {
				targetChoose = 7,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210202
					}
				}
			},
			[1001] = {
				eventCondition = "1,2,1210202,1",
				targetArea = 3,
				state = {
					stateOperation = 2,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 0.25,
							stateOperation = 2,
							chooseStateMode = 2,
							chooseStateIds = {
								1210203
							}
						}
					},
					[4] = {
						state = {
							duration = 0.25,
							stateOperation = 2,
							chooseStateMode = 2,
							chooseStateIds = {
								1210203
							}
						}
					},
					[5] = {
						state = {
							duration = 0.25,
							stateOperation = 2,
							chooseStateMode = 2,
							chooseStateIds = {
								1210203
							}
						}
					},
					[6] = {
						state = {
							duration = 0.25,
							stateOperation = 2,
							chooseStateMode = 2,
							chooseStateIds = {
								1210203
							}
						}
					}
				}
			},
			[1002] = {
				boxId = 1210230,
				targetArea = 3,
				eventCondition = "1,1,1210212",
				state = {}
			}
		}
	},
	[1210259] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 105,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 85,
		bhEvent = "skill.1210259",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121020011,
						121020012
					}
				}
			},
			[0] = {
				hitedAnim = "Hit",
				boxId = 1210259,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121020013
					}
				}
			},
			[2] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210203
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						121025001,
						121020015,
						121021005
					}
				}
			},
			{
				targetChoose = 4,
				subEventId = 1002,
				subEventSkill = 1210259,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 3,
					stateId = 1210202
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			},
			[3] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1210204
				}
			},
			[1001] = {
				boxType = 1,
				unitDelay = 0.35,
				boxId = 1210260,
				targetArea = 2,
				subEventSkill = 1210259,
				eventType = 1,
				subEventId = 1004,
				flyCueId = 121020014,
				targetChoose = 23,
				state = {},
				atkCue = {
					cueList = {
						121021006
					}
				},
				hitCue = {
					cueList = {
						121020013
					}
				}
			},
			[4] = {
				targetArea = 3,
				state = {
					stateOperation = 2,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 0.25,
							layerState = 1210203,
							chooseStateMode = 2,
							stateOperation = 2,
							chooseStateIds = {
								1210204
							}
						}
					},
					[4] = {
						state = {
							duration = 0.25,
							layerState = 1210203,
							chooseStateMode = 2,
							stateOperation = 2,
							chooseStateIds = {
								1210204
							}
						}
					},
					[5] = {
						state = {
							duration = 0.25,
							layerState = 1210203,
							chooseStateMode = 2,
							stateOperation = 2,
							chooseStateIds = {
								1210204
							}
						}
					},
					[6] = {
						state = {
							duration = 0.25,
							layerState = 1210203,
							chooseStateMode = 2,
							stateOperation = 2,
							chooseStateIds = {
								1210204
							}
						}
					}
				}
			},
			[101] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210204
					}
				}
			},
			[1002] = {
				targetChoose = 16,
				targetArea = 3,
				state = {
					stateId = 1210202,
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210202
					}
				}
			},
			[1003] = {
				eventCondition = "1,1,8791200",
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 8791201
				}
			},
			[1004] = {
				boxType = 1,
				excludeTarget = 1,
				unitDelay = 0.35,
				boxId = 1210260,
				targetArea = 2,
				eventCondition = "1,1,8791200",
				eventType = 1,
				flyCueId = 121020014,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						121020013
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				121028001,
				121021004
			}
		}
	},
	[1210210] = {
		bhEvent = "skill.1210210",
		atkEvents = {
			[100] = {
				targetChoose = 4,
				subEventSkill = 1210259,
				subEventId = 1002,
				targetArea = 3,
				eventCondition = "1,1,1210201",
				excludeTarget = 1,
				state = {
					duration = 3,
					stateId = 1210202
				},
				atkCue = {
					cueList = {
						121020003,
						121021002
					}
				}
			},
			[0] = {
				boxId = 1210209,
				eventType = 1,
				state = {}
			}
		}
	},
	[1210211] = {
		bhEvent = "skill.1210209",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
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
