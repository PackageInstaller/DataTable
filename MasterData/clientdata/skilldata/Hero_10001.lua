-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_10001.lua

local Data = {
	cueFile = "10001",
	[10001] = {
		bhEvent = "skill.10001",
		atkEvents = {
			[0] = {
				boxId = 1200109,
				state = {},
				hitCue = {
					cueList = {
						100010001
					}
				}
			}
		}
	},
	[10002] = {
		bhEvent = "skill.10002",
		atkEvents = {
			[0] = {
				boxId = 1200109,
				state = {},
				hitCue = {
					cueList = {
						100010002
					}
				}
			}
		}
	},
	[10101] = {
		actTime = 200,
		hideEvent = 1,
		bhEvent = "skill.10101",
		atkEvents = {
			{
				state = {},
				atkCue = {
					cueList = {
						100015003,
						100010005,
						100015004
					}
				}
			},
			[0] = {
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						100010004
					}
				}
			},
			[10] = {
				boxId = 1200159,
				hitedOffset = "Characters/BehitOffset/H001_battle_common_behit_offset_1.anim",
				hitedAnim = "Float",
				state = {},
				hitCue = {
					cueList = {
						100010003
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						100015002
					}
				}
			},
			[100] = {
				hitedAnim = "end",
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						100015001
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
