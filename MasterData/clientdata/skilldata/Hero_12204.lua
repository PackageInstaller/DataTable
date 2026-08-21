-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12204.lua

local Data = {
	cueFile = "12204",
	[1220409] = {
		bhEvent = "skill.1220409",
		atkEvents = {
			{
				boxId = 1220409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122040003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122040001,
						122041001
					}
				}
			}
		}
	},
	[1220410] = {
		bhEvent = "skill.1220410",
		atkEvents = {
			{
				boxId = 1220409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122040003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122040002,
						122041002
					}
				}
			}
		}
	},
	[1220459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 75,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 90,
		bhEvent = "skill.1220459",
		atkEvents = {
			{
				hitedAnim = "Hit",
				state = {
					duration = 3.5,
					stateId = 1220401
				}
			},
			[1001] = {
				subEventId = 1003,
				subEventSkill = 1220459,
				boxId = 1220459,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122040012
					}
				}
			},
			[1002] = {
				boxId = 1220460,
				eventType = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122040008
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						122040013,
						122045001,
						122041006
					}
				},
				hitCue = {
					cueList = {
						122040009
					}
				}
			},
			[12] = {
				state = {},
				hitCue = {
					cueList = {
						122040010
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			[1003] = {
				addManaNumber = -10,
				eventCondition = "1,1,1220411",
				state = {}
			},
			[1004] = {
				boxId = 1220461,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122040012
					}
				}
			},
			[1005] = {
				state = {
					duration = 3.5,
					stateId = 1220401
				},
				hitCue = {
					cueList = {
						122040009
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				122048001,
				122041005
			}
		}
	},
	[1220429] = {
		bhEvent = "skill.1220429",
		atkEvents = {
			{
				boxId = 1220431,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122040005
					}
				}
			},
			[1001] = {
				boxId = 1220429,
				targetChoose = 1,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						122041004
					}
				},
				hitCue = {
					cueList = {
						122040007
					}
				}
			},
			[1002] = {
				boxId = 1220430,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			{
				boxId = 1220431,
				eventType = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122040004,
						122041003
					}
				}
			},
			[101] = {
				state = {},
				hitCue = {
					cueList = {
						122040005
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
