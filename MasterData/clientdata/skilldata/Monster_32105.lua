-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_32105.lua

local Data = {
	cueFile = "32105",
	[3210501] = {
		bhEvent = "skill.3210501",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321050001,
						321051001
					}
				}
			},
			{
				boxId = 3210501,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[3210502] = {
		bhEvent = "skill.3210502",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321050002,
						321051002
					}
				}
			},
			{
				boxId = 3210501,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[3210503] = {
		bhEvent = "skill.3210503",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321050003,
						321051003
					}
				}
			},
			{
				boxId = 3210503,
				targetChoose = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321050004
					}
				}
			}
		}
	},
	[3210551] = {
		actTime = 45,
		bhEvent = "skill.3210551",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321050006,
						321051004
					}
				}
			},
			[2] = {
				state = {}
			},
			{
				boxId = 3210551,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321050007
					}
				}
			}
		}
	},
	[3210552] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3210552",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321050008,
						321051005
					}
				}
			},
			{
				targetArea = 3,
				state = {
					chooseStateType = 2,
					stateOperation = 1,
					chooseStateMode = 1
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 7,
					stateId = 3210502
				}
			},
			[1001] = {
				boxId = 3210552,
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
	[3210553] = {
		actTime = 40,
		bhEvent = "skill.3210553",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321050010,
						321051006
					}
				}
			},
			{
				boxId = 3210553,
				targetChoose = 1,
				eventType = 1,
				state = {
					chooseStateType = 1,
					stateOperation = 1,
					chooseStateMode = 1
				},
				hitCue = {
					cueList = {
						321050011
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
