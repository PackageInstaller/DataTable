-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14004.lua

local Data = {
	cueFile = "14004",
	[1400409] = {
		bhEvent = "skill.1400409",
		atkEvents = {
			[0] = {
				boxId = 1400409,
				eventType = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140040010,
						140041007
					}
				}
			},
			{
				state = {},
				hitCue = {
					cueList = {
						140040011,
						140041008
					}
				}
			}
		}
	},
	[1400429] = {
		bhEvent = "skill.1400429",
		atkEvents = {
			[0] = {
				targetArea = 2,
				delay = 0.35,
				targetChoose = 12,
				state = {},
				hitCue = {
					cueList = {
						140041004
					}
				},
				levelAtkEvents = {
					[2] = {
						targetChoose = 7,
						state = {
							duration = -999,
							stateId = 1400401
						},
						hitCue = {
							cueList = {
								140040013
							}
						}
					},
					[3] = {
						targetChoose = 7,
						state = {
							duration = -999,
							stateId = 1400401
						},
						hitCue = {
							cueList = {
								140040013
							}
						}
					},
					[4] = {
						targetChoose = 7
					},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140040012,
						140041009
					}
				}
			},
			{
				randomTargetNumber = 3,
				boxId = 1400429,
				recordSkillTargets = 1,
				targetArea = 2,
				eventType = 1,
				targetChoose = 7,
				state = {
					duration = 12,
					stateId = 1000003
				},
				hitCue = {
					cueList = {
						140040014,
						140041010
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						randomTargetNumber = 100,
						hitCue = {
							cueList = {
								140040014,
								140040013
							}
						}
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
								140040005,
								140041004
							}
						}
					}
				}
			},
			[1001] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 1400411
				}
			},
			[1002] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1400430,
				delay = 0.1,
				eventCondition = "1,2,1000003",
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000042
					}
				}
			}
		}
	},
	[1400459] = {
		hideEffect = 1,
		actTime = 100,
		videoActTime = 60,
		prepareCamDruation = 30,
		prepareCamera = 1,
		bhEvent = "skill.1400459",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140040015
					}
				}
			},
			[0] = {
				hitedAnim = "Hit",
				boxId = 1400459,
				targetChoose = 3,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						140043001
					}
				},
				hitCue = {
					cueList = {
						10006003
					}
				}
			},
			{
				targetChoose = 3,
				targetArea = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1400460,
						hitCue = {
							cueList = {
								10000008
							}
						}
					},
					[3] = {
						boxId = 1400460,
						state = {
							duration = 5,
							stateId = 1400402
						},
						hitCue = {
							cueList = {
								10000008
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
				hitCue = {
					cueList = {
						140040016
					}
				}
			},
			{
				state = {},
				levelAtkEvents = {
					[2] = {
						hitCue = {
							cueList = {
								140040017
							}
						}
					},
					[3] = {
						hitCue = {
							cueList = {
								140040017
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140045001,
						140040019,
						140041012
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				targetChoose = 3,
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1400461,
				delay = 0.15,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140040013
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				140048001,
				140041011
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
