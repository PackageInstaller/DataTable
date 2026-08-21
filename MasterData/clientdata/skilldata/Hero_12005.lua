-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12005.lua

local Data = {
	cueFile = "12005",
	[1200509] = {
		bhEvent = "skill.1200509",
		atkEvents = {
			{
				boxId = 1200509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1200507
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120050001,
						120051001
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				boxId = 1200512,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000041
					}
				}
			}
		}
	},
	[1200510] = {
		bhEvent = "skill.1200510",
		atkEvents = {
			{
				boxId = 1200509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120050003,
						120051002
					}
				}
			}
		}
	},
	[1200559] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 65,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 70,
		bhEvent = "skill.1200559",
		atkEvents = {
			[0] = {
				hitedAnim = "Hit",
				boxId = 1200559,
				targetChoose = 1,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						120053001
					}
				},
				hitCue = {
					cueList = {
						120050009,
						10006003
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 5,
							stateId = 1200501
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				boxType = 1,
				delay = 1.5,
				boxId = 1200561,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000001
					}
				}
			},
			{
				boxId = 1200560,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1200503
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1200503
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				targetChoose = 1,
				state = {},
				atkCue = {
					cueList = {
						120050008
					}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						120055001,
						120050010,
						120051005
					}
				}
			},
			{
				targetArea = 3,
				state = {}
			},
			[1003] = {
				targetArea = 2,
				state = {},
				atkCue = {
					cueList = {
						120050012
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				targetChoose = 1,
				state = {}
			},
			[27] = {
				targetChoose = 1,
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						10006003
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				120058001,
				120051004
			}
		}
	},
	[1200529] = {
		bhEvent = "skill.1200529",
		atkEvents = {
			[0] = {
				boxId = 1200509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						90010007
					}
				}
			}
		}
	},
	[1200511] = {
		bhEvent = "skill.1200511",
		atkEvents = {
			[0] = {
				boxId = 1200511,
				targetChoose = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120050006
					}
				}
			},
			{
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120050005,
						120051003
					}
				}
			}
		}
	},
	[1200591] = {
		bhEvent = "skill.1200591",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120050008
					}
				}
			},
			[0] = {
				boxId = 1200559,
				targetChoose = 1,
				state = {},
				hitCue = {
					cueList = {
						120050009,
						120051005
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
